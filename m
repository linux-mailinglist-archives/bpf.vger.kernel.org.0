Return-Path: <bpf+bounces-5472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5675B137
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BE1C2136A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9875918AE7;
	Thu, 20 Jul 2023 14:29:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72998171A9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:29:22 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4226B2
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:29:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992acf67388so134809666b.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689863357; x=1690468157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6b/wsL9Dw6SNVQ19Mv0Rxh/Yiy85mkGpeKiqbV24AI=;
        b=uLfn05sFI18h03BTwACIEKitOUXxSYQjft7DzTAI6U9UtmMiTO2uZxXUssX6v6gjUE
         2SwbDl9XVRfcj2msTA+zF+4h3w8DubENCUEGJAv4v3sHaIwZC49SrDWDWPFX0e54WROu
         6QBOMXGNQrqp+lC3vOctVeIrDa4Aws2LOlVFKNvncqnrlHTMKdWJFswqe8Eehr/0Gb31
         o/K01AsOm6F6oKGWgnZLNbNJuz9MpQ56lPvb0ol6pcFrVTVDCj4Ix+u1bBEafNBItJRR
         F+gQM/6wFT5REoYLNSq7hCAS5020IG5UG3/aHLDCzt4jkYBo7c8f+g3+u7Q/shfTiIZP
         L8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863357; x=1690468157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6b/wsL9Dw6SNVQ19Mv0Rxh/Yiy85mkGpeKiqbV24AI=;
        b=SN0aBCKy6siQXnh0CQKGzXVTYaP0kIUgqr70Nf/NjxHuIfNyew8H+hEvaipks1AHnR
         sKma6zfbVd3WM9hup00TY23TgPihVuN1nIsg0+JPzvf5+lNZVbDDFTfCwt1J+MM+u2e5
         GTFydeiMy7Shd5U8/Z5UM2NNsF/0HFaP6vlw/qU8lm4BameVZzA/xb5Xr/4khvJzAl3t
         AcvcuYFoKastNz7VO0mG68TYTTv40L3NSbg5MgPFP+mMxKBwCWhVXpmY6kgCar8Rlrdo
         QuFF6+gBlEjnDywNU4hzK6cN4ozLSd9bkdNAHEqnnw3rkbAsVmDYTJTI8me4fRLARw+M
         4i5A==
X-Gm-Message-State: ABy/qLbFYEcHlnEclQPeoIQticz9UJI+brFd+RoNStRnkbSJJ00HbcUK
	oLnSaCjTx/Q18W+Umzyvr59XDEBR+rsi2FMwQURUqQ==
X-Google-Smtp-Source: APBJJlG/RYsKYJL0m6COXg4vDOsDmv6ZfnL8UOw4igcVM7W6HI23pxdwFS29nDfHkTYfAJE1lRJf1Q==
X-Received: by 2002:a17:906:2457:b0:98e:4c96:6e1c with SMTP id a23-20020a170906245700b0098e4c966e1cmr4546175ejb.67.1689863356944;
        Thu, 20 Jul 2023 07:29:16 -0700 (PDT)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm780430ejw.225.2023.07.20.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:29:16 -0700 (PDT)
Date: Thu, 20 Jul 2023 14:29:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com
Subject: Re: BPF/Question: PTR_TRUSTED vs PTR_UNTRUSTED
Message-ID: <ZLlEt0J+O7XqnQFb@google.com>
References: <ZIl0+n1Q5yn2r5vL@google.com>
 <20230615174033.GA2915572@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615174033.GA2915572@maniforge>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey David!

Thanks for getting back to me, and super sorry about the delay.

On Thu, Jun 15, 2023 at 12:40:33PM -0500, David Vernet wrote:
> On Wed, Jun 14, 2023 at 08:06:18AM +0000, Matt Bobrowski wrote:
> > Hey David,
> > 
> > I have a quick question in regards to the type tag PTR_TRUSTED, which
> > I believe is causing one of my BPF programs to no longer successfully
> > pass the BPF verifier. Given the following BPF program as an example:
> 
> Hi Matt,
> 
> Thanks for the message. I'll add the bpf list to cc so the community can
> see and discuss.
> 
> > ---
> > SEC("lsm.s/bprm_committed_creds")
> > int BPF_PROG(bprm_committed_creds, struct linux_binprm *bprm)
> > {
> > 	int ret;
> > 	char buf[64] = {0};
> > 
> > 	ret = bpf_d_path(&bprm->file->f_path, buf, sizeof(buf));
> > 	if (ret < 0) {
> > 		bpf_printk("bpf_d_path: ret=%d", ret);
> > 		return 0;
> > 	}
> > 	
> > 	return 0;
> > }
> > ---
> > 
> > In this case, the PTR_TO_BTF_ID pointer (&bprm->file->f_path) I
> > imagine is considered to be trusted and can be passed to the BPF
> > helper bpf_d_path without the BPF verifier complaining.
> > 
> > On the other hand, given the following relatively similar BPF program
> > as an example:
> > 
> > ---
> > SEC("lsm.s/bprm_committed_creds")
> > int BPF_PROG(bprm_committed_creds)
> > {
> > 	int ret;
> > 	char buf[64] = {0};
> > 	struct task_struct *current = bpf_get_current_task_btf();
> > 
> > 	ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> > 	if (ret < 0) {
> > 		bpf_printk("bpf_d_path: ret=%d", ret);
> > 		return 0;
> > 	}
> > 	
> > 	return 0;
> > }
> > ---
> > 
> > In this case, the PTR_TO_BTF_ID pointer (&current->fs->pwd) is
> > considered to be untrusted and cannot be passed to the BPF helper
> > bpf_d_path as the BPF verifier fails to load the BPF program with the
> > following message:
> 
> The reason this is happening is that the struct fs_struct *fs field of
> struct task_struct is not marked as inheriting its parent task's trusted
> status. The following diff would fix the issue:
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa43dc8e85b9..8b8ccde342f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5857,6 +5857,7 @@ BTF_TYPE_SAFE_RCU(struct task_struct) {
>         struct css_set __rcu *cgroups;
>         struct task_struct __rcu *real_parent;
>         struct task_struct *group_leader;
> + struct fs_struct *fs;
>  };

Oh, right. So, if we explicitly dereference the struct fs_struct
member of struct task_struct within a RCU read-side critical section,
the BPF verifier considers the pointer to struct fs_struct as being
safe and trusted. Is that right?

Why is it that we need to explicitly add it to such lists so that
they're considered to be trusted and cannot simply perform the
bpf_rcu_read_lock/unlock() dance from within the BPF program? Also,
should we not add the field to BTF_TYPE_SAFE_RCU_OR_NULL() instead of
BTF_TYPE_SAFE_RCU(), as struct fs_struct could perhaps be NULL in some
circumstances?

Are you OK with me carrying this recommended patch to the mailing
list?

>  BTF_TYPE_SAFE_RCU(struct cgroup) {
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> index dcdea3127086..aef2d4689826 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> @@ -324,3 +324,24 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flag
> 
>         return 0;
>  }
> +
> +SEC("lsm.s/bprm_committed_creds")
> +__success
> +int BPF_PROG(bprm_committed_creds)
> +{
> + int ret;
> + char buf[64] = {0};
> + struct task_struct *current = bpf_get_current_task_btf();
> + struct fs_struct *fs;
> +
> + bpf_rcu_read_lock();
> + fs = current->fs;
> + ret = bpf_d_path(&fs->pwd, buf, sizeof(buf));
> + bpf_rcu_read_unlock();
> + if (ret < 0) {
> +         bpf_printk("bpf_d_path: ret=%d", ret);
> +         return 0;
> + }
> +
> + return 0;
> +}
> 
> With this patch, the above test would pass (meaning the program is successfully
> verified).
> 
> > 
> > ---
> > ; ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> > 15: (b7) r3 = 64                      ; R3_w=64
> > 16: (85) call bpf_d_path#147
> > R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
> > ---
> > 
> > What's interesting is that based on the following commit
> > (3f00c52393445 bpf: Allow trusted pointers to be passed to
> > KF_TRUSTED_ARGS kfuncs) message:
> > 
> > ---
> > PTR_TRUSTED pointers are passed directly from the kernel as a
> > tracepoint or struct_ops callback argument. Any nested pointer that is
> > obtained from walking a PTR_TRUSTED pointer is no longer
> > PTR_TRUSTED. From the example above, the struct task_struct *task
> > argument is PTR_TRUSTED, but the 'nested' pointer obtained from
> > 'task->last_wakee' is not PTR_TRUSTED.
> > ---
> > 
> > I'm reading this as though the first example program should also fail
> > BPF verification given that a nested pointer to struct path is
> > obtained from walking a PTR_TRUSTED pointer, which presumably is
> > struct linux_binprm in this case. What subtle details am I missing
> > here? Why is that the first program loads, but the second does not?
> 
> The subtle details are in that these are different types. We can't assume that
> a child pointer automatically inherits its parent's trusted status for all
> types, so we have to hard code it for now until gcc supports using btf type
> tags so this can be expressed with annotations like __trusted or __rcu.

Oh, interesting. You mention that this is explicitly needed for gcc,
so I'm now wondering how the semantics differ when using clang? Where
would such annotations (__trusted, __rcu) be applied?

> Consider that some types may have NULL child pointers in certain scenarios.
> Others may be valid as long as you access it in an RCU read region, others may
> be valid as long as you access it in an RCU read region and it wasn't NULL.

This makes sense. Thanks for the explanation.

> The struct linux_binprm type's safety is specified in
> kernel/bpf/verifier.c:
> 
> BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) {
> 	struct file *file;
> };
> 
> struct task_struct is specified above:
> 
> /* RCU trusted: these fields are trusted in RCU CS and never NULL */
> BTF_TYPE_SAFE_RCU(struct task_struct) {
>         const cpumask_t *cpus_ptr;
>         struct css_set __rcu *cgroups;
>         struct task_struct __rcu *real_parent;
>         struct task_struct *group_leader;
> };
> 
> > What workaround needs to be implemented in order to have the second
> > example program satisfy the PTR_TRUSTED contract with the BPF helper
> > bpf_d_path?
> 
> See above, we need to add struct fs_struct * to the list of trusted fields for
> struct task_struct, and enclose it in an RCU read region.

/M

