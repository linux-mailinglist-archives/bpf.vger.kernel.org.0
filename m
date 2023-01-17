Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5843166E790
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 21:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjAQUQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 15:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjAQUNQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 15:13:16 -0500
Received: from out-159.mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D779193E9
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 11:06:10 -0800 (PST)
Message-ID: <0c4e8a7f-9891-338e-1308-599f2c2af447@linux.dev>
Date:   Tue, 17 Jan 2023 11:05:57 -0800
MIME-Version: 1.0
Subject: Re: Struct_ops Questions
Content-Language: en-US
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
References: <CA+PiJmTMrWq-BGAMZgd317q0sT7tN-6=r3sDbZdb8iVzwPKdsw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CA+PiJmTMrWq-BGAMZgd317q0sT7tN-6=r3sDbZdb8iVzwPKdsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/13/23 5:05 PM, Daniel Rosenberg wrote:
> I'm currently working on switching Fuse-BPF over to using struct_ops,
> and have a few questions.
> 
> I noticed that the lifespan of the [name]_struct_op struct passed in
> reg, and the associated maps have a lifespan that can't be influenced
> by the subsystem. Fuse-bpf keeps struct ops on an arbitrary number of
> inodes which will potentially outlive the op structure. My current
> plan is to have fuse treat unreg similar to if the daemon simply
> stopped responding, failing all impacted calls with ENOTCONN. I'm
> currently looking at two approaches.
> 
> 1. Copy the struct received in reg, and have a flag to indicate if the
> structure is live, with unreg just marking it as dead and some RCU
> style sync to ensure we don't lose the function pointers post check.
> 2. Maintain an additional struct that points to the reg provided
> struct. Null out that pointer in unreg, with the same sort of RCU
> sync.
> 
> I'm currently leaning towards 1, but not sure what the best approach
> is here, or if there should be some way for the subsystem to grab a
> kref on the maps/struct_op structures. Given the analogue of the FUSE
> daemon being able to disappear at any given time, I think one of the
> above options should be enough.
> 
> The old fuse-bpf implementation, which had its own program type
> defined, would use the program fd as an identifier, which allowed it
> to increment the ref count as needed. That sort of information isn't
> exposed to the register function, and you can't reach the struct_ops
> structure from a map fd as is. Either of those would allow us to
> directly use the map/struct objects without needing to maintain an
> extra layer of duplicated data. Currently all the register function
> does is add information to be able to check if the map still exists,
> which wouldn't be needed if we could just grab a ref.
> 
> I'm not sure how to handle Fuse being built as a module. Currently,
> bpf_struct_ops uses an include file list to define all available
> struct_ops, along with externs for their bpf_struct_ops structure. If
> we build fuse as a module, that either would not be available, or
> would require us to build extra things into the kernel when we make
> fuse as a module, which sort of seems to defeat the point.
> 
> Do we need a module interface here? At the moment I'm messing around
> with just having the reg/unreg functions implemented within the FUSE
> module, with all of the verification functions built in on the bpf
> side. I've got a rough prototype working, but there's some messiness
> around unloading the module while there are still struct_op programs
> registered. If you unload and reload the module, the struct_op program
> will still show up via bpftools, but would be unusable since it would
> no longer be registered. All of that goes away if we can directly use
> the map fd as an identifier. That wouldn't be useful for anything that
> requires extra setup in their reg function of course.
> 
> It seems like a fair bit of these issues go away if we allow for a way
> to grab the specific struct_op structure from the map fd. Would that
> be a reasonable thing to expose to a module?

I think the first question is related to the refcnt of the struct_ops. Whenever 
a new tcp connection is established, it also needs to bump the refcnt of a (bpf) 
tcp_congestion_ops. The tcp subsystem currently does a bpf_try_module_get() 
which then calls bpf_struct_ops_get() if 'owner == BPF_MODULE_OWNER'. 
bpf_struct_ops_get() will inc the refcnt of the struct_ops.

Regarding unreg, the st_map->st_ops->unreg() will unregister the struct_ops from 
the tcp subsystem. The future tcp connection won't be able to find this (bpf) 
tcp_congestion_ops.

After unreg(), the existing tcp connections could still hold a refcnt to the 
already unregistered (bpf) tcp_congestion_ops. The refcnt will eventually be 
released when all these old connections are closed. This is similar to all other 
kernel tcp-cc modules (eg. when tcp_dctcp.c is built as a module).  Note that 
once unreg, the struct_ops will still be shown in 'bpftools struct_ops dump 
id...' but the status will be in BPF_STRUCT_OPS_STATE_TOBEFREE and it won't be 
usable by new connection.

Does the above behavior work for FUSE also? If not, how is FUSE different?

I think the next set of question is about when FUSE itself is built as a module. 
The first is how to register 'struct bpf_struct_ops bpf_fuse_struct_ops'. You 
are correct that right now it is done during compile time in 
bpf_struct_ops_types.h. To make FUSE itself built as a module and 
bpf_fuse_struct_ops defined in the FUSE module, some work is needed in 
bpf_struct_ops.c to allow registering struct_ops in runtime during module_init. 
For module reference counting, I think the bpf_fuse_struct_ops should be able to 
hold one refcnt of the fuse module. Not sure how bpf_fuse_struct_ops looks like 
and I also don't know how grabbing the map fd will help. It seems you already 
have something working, so it may be easier to discuss base on that.
