Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E935F36BF
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJCTyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJCTx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 15:53:58 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D539326E2;
        Mon,  3 Oct 2022 12:53:54 -0700 (PDT)
Message-ID: <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664826833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBXDxtk99lc7mMP1AxGZcU45o3GCDxIpvB8/2wdGoWs=;
        b=fB46p3JW96nz0yt7dlNPU4vHB70rL13QA4E6oz6nOUNgR5Zy6AomcJCb/5yWjtJoMkNRXG
        tDuHOAfUA99fieFVxmalDE+CdHRgHxbxT84fcaukiy5DZDRdwq4yEHhvhEPbItZJSustpw
        G+ovO5S3YlK0IgSWaaJGsXQ43z+dri0=
Date:   Mon, 3 Oct 2022 12:53:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
References: <20221001144716.3403120-1-void@manifault.com>
 <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
 <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
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

On 10/3/22 8:56 AM, Kumar Kartikeya Dwivedi wrote:
>>> Also, could you include a test to make sure sleepable programs cannot
>>> call bpf_task_acquire? It seems to assume RCU read lock is held while
>>> that may not be true. If already not possible, maybe a WARN_ON_ONCE
>>> inside the helper to ensure future cases don't creep in.
>>
>> I don't _think_ it's unsafe for a sleepable program to call
>> bpf_task_acquire(). My understanding is that the struct task_struct *
>> parameter to bpf_task_acquire() is not PTR_UNTRUSTED, so it's safe to
>> dereference directly in the kfunc. The implicit assumption here is that
>> the task was either passed to the BPF program (which is calling
>> bpf_task_acquire()) from the main kernel in something like a trace or
>> struct_ops callback, or it was a referenced kptr that was removed from a
>> map with bpf_kptr_xchg(), and is now owned by the BPF program. Given
>> that the ptr type is not PTR_UNTRUSTED, it seemed correct to assume that
>> the task was valid in bpf_task_acquire() regardless of whether we were
>> in an RCU read region or not, but please let me know if I'm wrong about
> 
> I don't think it's correct. You can just walk arbitrary structures and
> obtain a normal PTR_TO_BTF_ID that looks seemingly ok to the verifier
> but has no lifetime guarantees. It's a separate pre-existing problem
> unrelated to your series [0]. PTR_UNTRUSTED is not set for those cases
> currently.
> 
> So the argument to your bpf_task_acquire may already be freed by then.
> This issue would be exacerbated in sleepable BPF programs, where RCU
> read lock is not held, so some cases of pointer walking where it may
> be safe no longer holds.
> 
> I am planning to clean this up, but I'd still prefer if we don't allow
> this helper in sleepable programs, yet. kptr_get is ok to allow.
> Once you have explicit BPF RCU read sections, sleepable programs can
> take it, do loads, and operate on the RCU pointer safely until they
> invalidate it with the outermost bpf_rcu_read_unlock. It's needed for
> local kptrs as well, not just this. I plan to post this very soon, so
> we should be able to fix it up in the current cycle after landing your
> series.
> 
> __rcu tags in the kernel will automatically be understood by the
> verifier and for the majority of the correctly annotated cases this
> will work fine and not break tracing programs.
> 
> [0]: https://lore.kernel.org/bpf/CAADnVQJxe1QT5bvcsrZQCLeZ6kei6WEESP5bDXf_5qcB2Bb6_Q@mail.gmail.com
> 
>> that.  Other kfuncs I saw such as bpf_xdp_ct_lookup() assumed that the
>> parameter passed by the BPF program (which itself was passing on a
>> pointer given to it by the main kernel) is valid as well.
> 
> Yeah, but the CT API doesn't assume validity of random PTR_TO_BTF_ID,
> it requires KF_TRUSTED_ARGS which forces them to have ref_obj_id != 0.

Other than ref_obj_id != 0, could the PTR_TO_BTF_ID obtained through 
btf_ctx_access be marked as trusted (e.g. the ctx[0] in the selftest here)
and bpf_task_acquire() will require KF_TRUSTED_ARGS? would it be safe in general?

