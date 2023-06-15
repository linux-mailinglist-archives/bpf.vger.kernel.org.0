Return-Path: <bpf+bounces-2673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BD731F6A
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 19:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E725128157E
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8C2E0EB;
	Thu, 15 Jun 2023 17:40:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF02E0D8
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 17:40:38 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BE1FDD
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 10:40:36 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so32290371cf.0
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 10:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850836; x=1689442836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZXqzF2NNP37eCmH+yPjva00oUKSjyPwpk1gYa65ptU=;
        b=Cwgb8lAjmRsXRgax4qK1MDE0BO7zgLfUNkfAlsY+X7yKAdyWIPjwT7uh2awYm+RwpK
         VcRy+IEq1iSwKOSMnXtxtvR8iD5sEuranLFM6picuAZ+ul0j+HP2CrVJQJ4r+fYARnHc
         VQZdHQcsMk1EomAHJ2QRSz2OHndJYYBqj59ePN7MIzmTK5EMcRh3EbsCqpcW+hqUN1Rd
         ZPvbYgQBUj3dfBrfZb/+VYDtOcBKqjpbTHKwKZZahd9Bozj55wOgWGSUJd5ziNuxBIDS
         SqFcLEUkbZOhB0qP9hV5bc9H7X//qryjDqcdGLRyddAAKhrRPXSl7EOcVZp6RYYmTspf
         J2zw==
X-Gm-Message-State: AC+VfDwsMnzi5DIhvSHsPZ0ldV5WnkxivLVccHyc55pCLM1uVTkqFE4B
	U7Ji9iijizWOKhQdkLWt+Sg=
X-Google-Smtp-Source: ACHHUZ7VzNSdOG0piOLJeHQWAV++Y98iz/tVlFAJzBXZ+/tVmp55xNaomOmDCCgpBY+yIVORf8njZA==
X-Received: by 2002:a05:622a:1ba7:b0:3f8:20a:1c6a with SMTP id bp39-20020a05622a1ba700b003f8020a1c6amr6621333qtb.40.1686850835692;
        Thu, 15 Jun 2023 10:40:35 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j8-20020ac85c48000000b003f9b6d54b17sm6434593qtj.58.2023.06.15.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:40:34 -0700 (PDT)
Date: Thu, 15 Jun 2023 12:40:33 -0500
From: David Vernet <void@manifault.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
Subject: Re: BPF/Question: PTR_TRUSTED vs PTR_UNTRUSTED
Message-ID: <20230615174033.GA2915572@maniforge>
References: <ZIl0+n1Q5yn2r5vL@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIl0+n1Q5yn2r5vL@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 08:06:18AM +0000, Matt Bobrowski wrote:
> Hey David,
> 
> I have a quick question in regards to the type tag PTR_TRUSTED, which
> I believe is causing one of my BPF programs to no longer successfully
> pass the BPF verifier. Given the following BPF program as an example:

Hi Matt,

Thanks for the message. I'll add the bpf list to cc so the community can
see and discuss.

> ---
> SEC("lsm.s/bprm_committed_creds")
> int BPF_PROG(bprm_committed_creds, struct linux_binprm *bprm)
> {
> 	int ret;
> 	char buf[64] = {0};
> 
> 	ret = bpf_d_path(&bprm->file->f_path, buf, sizeof(buf));
> 	if (ret < 0) {
> 		bpf_printk("bpf_d_path: ret=%d", ret);
> 		return 0;
> 	}
> 	
> 	return 0;
> }
> ---
> 
> In this case, the PTR_TO_BTF_ID pointer (&bprm->file->f_path) I
> imagine is considered to be trusted and can be passed to the BPF
> helper bpf_d_path without the BPF verifier complaining.
> 
> On the other hand, given the following relatively similar BPF program
> as an example:
> 
> ---
> SEC("lsm.s/bprm_committed_creds")
> int BPF_PROG(bprm_committed_creds)
> {
> 	int ret;
> 	char buf[64] = {0};
> 	struct task_struct *current = bpf_get_current_task_btf();
> 
> 	ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> 	if (ret < 0) {
> 		bpf_printk("bpf_d_path: ret=%d", ret);
> 		return 0;
> 	}
> 	
> 	return 0;
> }
> ---
> 
> In this case, the PTR_TO_BTF_ID pointer (&current->fs->pwd) is
> considered to be untrusted and cannot be passed to the BPF helper
> bpf_d_path as the BPF verifier fails to load the BPF program with the
> following message:

The reason this is happening is that the struct fs_struct *fs field of
struct task_struct is not marked as inheriting its parent task's trusted
status. The following diff would fix the issue:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa43dc8e85b9..8b8ccde342f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5857,6 +5857,7 @@ BTF_TYPE_SAFE_RCU(struct task_struct) {
        struct css_set __rcu *cgroups;
        struct task_struct __rcu *real_parent;
        struct task_struct *group_leader;
+ struct fs_struct *fs;
 };

 BTF_TYPE_SAFE_RCU(struct cgroup) {
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index dcdea3127086..aef2d4689826 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -324,3 +324,24 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flag

        return 0;
 }
+
+SEC("lsm.s/bprm_committed_creds")
+__success
+int BPF_PROG(bprm_committed_creds)
+{
+ int ret;
+ char buf[64] = {0};
+ struct task_struct *current = bpf_get_current_task_btf();
+ struct fs_struct *fs;
+
+ bpf_rcu_read_lock();
+ fs = current->fs;
+ ret = bpf_d_path(&fs->pwd, buf, sizeof(buf));
+ bpf_rcu_read_unlock();
+ if (ret < 0) {
+         bpf_printk("bpf_d_path: ret=%d", ret);
+         return 0;
+ }
+
+ return 0;
+}

With this patch, the above test would pass (meaning the program is successfully
verified).

> 
> ---
> ; ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> 15: (b7) r3 = 64                      ; R3_w=64
> 16: (85) call bpf_d_path#147
> R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
> ---
> 
> What's interesting is that based on the following commit
> (3f00c52393445 bpf: Allow trusted pointers to be passed to
> KF_TRUSTED_ARGS kfuncs) message:
> 
> ---
> PTR_TRUSTED pointers are passed directly from the kernel as a
> tracepoint or struct_ops callback argument. Any nested pointer that is
> obtained from walking a PTR_TRUSTED pointer is no longer
> PTR_TRUSTED. From the example above, the struct task_struct *task
> argument is PTR_TRUSTED, but the 'nested' pointer obtained from
> 'task->last_wakee' is not PTR_TRUSTED.
> ---
> 
> I'm reading this as though the first example program should also fail
> BPF verification given that a nested pointer to struct path is
> obtained from walking a PTR_TRUSTED pointer, which presumably is
> struct linux_binprm in this case. What subtle details am I missing
> here? Why is that the first program loads, but the second does not?

The subtle details are in that these are different types. We can't assume that
a child pointer automatically inherits its parent's trusted status for all
types, so we have to hard code it for now until gcc supports using btf type
tags so this can be expressed with annotations like __trusted or __rcu.
Consider that some types may have NULL child pointers in certain scenarios.
Others may be valid as long as you access it in an RCU read region, others may
be valid as long as you access it in an RCU read region and it wasn't NULL.

The struct linux_binprm type's safety is specified in
kernel/bpf/verifier.c:

BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) {
	struct file *file;
};

struct task_struct is specified above:

/* RCU trusted: these fields are trusted in RCU CS and never NULL */
BTF_TYPE_SAFE_RCU(struct task_struct) {
        const cpumask_t *cpus_ptr;
        struct css_set __rcu *cgroups;
        struct task_struct __rcu *real_parent;
        struct task_struct *group_leader;
};

> What workaround needs to be implemented in order to have the second
> example program satisfy the PTR_TRUSTED contract with the BPF helper
> bpf_d_path?

See above, we need to add struct fs_struct * to the list of trusted fields for
struct task_struct, and enclose it in an RCU read region.

Thanks,
David

