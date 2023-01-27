Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CB67DD6E
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 07:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjA0G2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 01:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjA0G2f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 01:28:35 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14977291
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 22:28:33 -0800 (PST)
Message-ID: <b7d15874-f6cd-2a5b-0e36-e1ba5ef181e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674800912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbcnBM40ELkdwrM+fzGWPP7CcchIhwEl+NHoEeoLnYM=;
        b=Z1XMtd8v0mRCAi6PTVCrFEr6FDfmkrNcbUK9KdGOujAlDLfoERUuaZOmnQWDpq48mL1I6c
        MG8X4VMtRg2CD7jYdGVkPmoh+UrRa/BlD8cBdZLJPBczUfjFsfdCffV5ygvmopIy8NZJG1
        a51MMB4Qhi19EO2i9NELYHQ5fKBeGUg=
Date:   Thu, 26 Jan 2023 22:28:27 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 11/17] selftests/bpf: Verify xdp_metadata
 xdp->af_xdp path
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
References: <20230119221536.3349901-1-sdf@google.com>
 <20230119221536.3349901-12-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230119221536.3349901-12-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
> - create new netns
> - create veth pair (veTX+veRX)
> - setup AF_XDP socket for both interfaces
> - attach bpf to veRX
> - send packet via veTX
> - verify the packet has expected metadata at veRX

I have seen this in CI for a couple of times. Could you help to take a look?

https://github.com/kernel-patches/bpf/actions/runs/4019879316/jobs/6907358876

   #281     xdp_metadata:FAIL
   Caught signal #11!
   Stack trace:
   ./test_progs-no_alu32(crash_handler+0x38)[0x563debb469b2]
   /lib/x86_64-linux-gnu/libpthread.so.0(+0x13140)[0x7faaf98a2140]
   ./test_progs-no_alu32(bpf_object__destroy_skeleton+0[  122.480620] 
new_name[134]: segfault at 563df12a8970 ip 0000563debb71a23 sp 00007ffffb5ad3d0 
error 4 in test_progs-no_alu32[563deb94b000+254000] likely on CPU 4 (core 0, 
socket 4)
   x1b)[0x563debb71[  122.481715] Code: 8b 45 e8 8b 40 38 39 45 f4 7c b0 90 90 
c9 c3 f3 0f 1e fa 55 48 89 e5 48 83 ec 10 48 89 7d f8 48 83 7d f8 00 74 67 48 8b 
45 f8 <48> 8b 40 40 48 85 c0 74 0c 48 8b 45 f8 48 89 c7 e8 63 ff ff ff 48
   a23]
   ./test_progs-no_alu32(+0x3c192)[0x563deb966192]
   ./test_progs-no_alu32(test_xdp_metadata+0x1a32)[0x563deb969bc8]
   ./test_progs-no_alu32(+0x21ce50)[0x563debb46e50]
   ./test_progs-no_alu32(main+0x54b)[0x563debb4892d]
   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7faaf96ddd0a]
   ./test_progs-no_alu32(_start+0x2e)[0x563deb94cdce]

