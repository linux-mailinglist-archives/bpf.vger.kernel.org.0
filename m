Return-Path: <bpf+bounces-5478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80A75B238
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7FE281EF1
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07A18B15;
	Thu, 20 Jul 2023 15:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4518AF6
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:16:29 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7D271E
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:16:25 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-403fab47687so7966301cf.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866185; x=1690470985;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ald6Bpt5++hE0PGJ9EFvimlkmAsMm9yn+VQQxYf1Okc=;
        b=Nyj8uP6sNEYo4vaeIWdZYLIxZ7RRPYXKD0VbsI2BX7twUiF8eHR9kFOz1n9+22KlFC
         ujI3tC0UdnJrJVa9lSnTSjR1uxTxbj/LB4A0HUyKEoIqSPo0tjvyCaceKxGudG8D76wf
         K9D/rAz5AXro4KtNF4Sg8hRH4qhYhJ5Jx5rO3gVmNIfsFb6hLKplHLjIECGUIABJYoQX
         WAKndyr/Q8F065q3r83DSnc0X/sSTwgND2P62eINizSF+h0le84F0PNeKHR373DDyciq
         v9oGgWhrY5jgAX99I2WmdpTbIsZ3f9/GzjnOz2nLTKClcR0coZPr00PLgcvAT4TD3xhx
         Kwpw==
X-Gm-Message-State: ABy/qLb3KIvJhhmz8BpwRC/2t7LkZNF0Di7EJtUGPhjSGlLVRWaHt/P0
	IrXa6wVfuvhquuaw7K3Xc88=
X-Google-Smtp-Source: APBJJlHlFnJSjgDix/iYhn0LVfT01tLCNr/QKjhkpJLUXBfshnemeltrl0yqN7nAxlr0LnYVDOM7AQ==
X-Received: by 2002:ac8:5f88:0:b0:405:468d:5693 with SMTP id j8-20020ac85f88000000b00405468d5693mr839727qta.27.1689866184400;
        Thu, 20 Jul 2023 08:16:24 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:fac6])
        by smtp.gmail.com with ESMTPSA id d3-20020ac81183000000b00402364e77dcsm433038qtj.7.2023.07.20.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:16:23 -0700 (PDT)
Date: Thu, 20 Jul 2023 10:16:22 -0500
From: David Vernet <void@manifault.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com
Subject: Re: BPF/Question: PTR_TRUSTED vs PTR_UNTRUSTED
Message-ID: <20230720151622.GA52260@maniforge>
References: <ZIl0+n1Q5yn2r5vL@google.com>
 <20230615174033.GA2915572@maniforge>
 <ZLlEt0J+O7XqnQFb@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLlEt0J+O7XqnQFb@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 02:29:11PM +0000, Matt Bobrowski wrote:
> Hey David!
> 
> Thanks for getting back to me, and super sorry about the delay.
> 
> On Thu, Jun 15, 2023 at 12:40:33PM -0500, David Vernet wrote:
> > On Wed, Jun 14, 2023 at 08:06:18AM +0000, Matt Bobrowski wrote:
> > > Hey David,
> > > 
> > > I have a quick question in regards to the type tag PTR_TRUSTED, which
> > > I believe is causing one of my BPF programs to no longer successfully
> > > pass the BPF verifier. Given the following BPF program as an example:
> > 
> > Hi Matt,
> > 
> > Thanks for the message. I'll add the bpf list to cc so the community can
> > see and discuss.
> > 
> > > ---
> > > SEC("lsm.s/bprm_committed_creds")
> > > int BPF_PROG(bprm_committed_creds, struct linux_binprm *bprm)
> > > {
> > > 	int ret;
> > > 	char buf[64] = {0};
> > > 
> > > 	ret = bpf_d_path(&bprm->file->f_path, buf, sizeof(buf));
> > > 	if (ret < 0) {
> > > 		bpf_printk("bpf_d_path: ret=%d", ret);
> > > 		return 0;
> > > 	}
> > > 	
> > > 	return 0;
> > > }
> > > ---
> > > 
> > > In this case, the PTR_TO_BTF_ID pointer (&bprm->file->f_path) I
> > > imagine is considered to be trusted and can be passed to the BPF
> > > helper bpf_d_path without the BPF verifier complaining.
> > > 
> > > On the other hand, given the following relatively similar BPF program
> > > as an example:
> > > 
> > > ---
> > > SEC("lsm.s/bprm_committed_creds")
> > > int BPF_PROG(bprm_committed_creds)
> > > {
> > > 	int ret;
> > > 	char buf[64] = {0};
> > > 	struct task_struct *current = bpf_get_current_task_btf();
> > > 
> > > 	ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> > > 	if (ret < 0) {
> > > 		bpf_printk("bpf_d_path: ret=%d", ret);
> > > 		return 0;
> > > 	}
> > > 	
> > > 	return 0;
> > > }
> > > ---
> > > 
> > > In this case, the PTR_TO_BTF_ID pointer (&current->fs->pwd) is
> > > considered to be untrusted and cannot be passed to the BPF helper
> > > bpf_d_path as the BPF verifier fails to load the BPF program with the
> > > following message:
> > 
> > The reason this is happening is that the struct fs_struct *fs field of
> > struct task_struct is not marked as inheriting its parent task's trusted
> > status. The following diff would fix the issue:
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fa43dc8e85b9..8b8ccde342f9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5857,6 +5857,7 @@ BTF_TYPE_SAFE_RCU(struct task_struct) {
> >         struct css_set __rcu *cgroups;
> >         struct task_struct __rcu *real_parent;
> >         struct task_struct *group_leader;
> > + struct fs_struct *fs;
> >  };
> 
> Oh, right. So, if we explicitly dereference the struct fs_struct
> member of struct task_struct within a RCU read-side critical section,
> the BPF verifier considers the pointer to struct fs_struct as being
> safe and trusted. Is that right?

With the above patch, yes.

> Why is it that we need to explicitly add it to such lists so that
> they're considered to be trusted and cannot simply perform the
> bpf_rcu_read_lock/unlock() dance from within the BPF program? Also,
> should we not add the field to BTF_TYPE_SAFE_RCU_OR_NULL() instead of
> BTF_TYPE_SAFE_RCU(), as struct fs_struct could perhaps be NULL in some
> circumstances?

I recommend doing some git log / git blame digging. All of this
information was captured in prior discussions. For example, in the patch
[0] which added these structs.

[0]: https://lore.kernel.org/bpf/20230303041446.3630-7-alexei.starovoitov@gmail.com/

> Are you OK with me carrying this recommended patch to the mailing
> list?

Of course

> >  BTF_TYPE_SAFE_RCU(struct cgroup) {
> > diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > index dcdea3127086..aef2d4689826 100644
> > --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> > @@ -324,3 +324,24 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flag
> > 
> >         return 0;
> >  }
> > +
> > +SEC("lsm.s/bprm_committed_creds")
> > +__success
> > +int BPF_PROG(bprm_committed_creds)
> > +{
> > + int ret;
> > + char buf[64] = {0};
> > + struct task_struct *current = bpf_get_current_task_btf();
> > + struct fs_struct *fs;
> > +
> > + bpf_rcu_read_lock();
> > + fs = current->fs;
> > + ret = bpf_d_path(&fs->pwd, buf, sizeof(buf));
> > + bpf_rcu_read_unlock();
> > + if (ret < 0) {
> > +         bpf_printk("bpf_d_path: ret=%d", ret);
> > +         return 0;
> > + }
> > +
> > + return 0;
> > +}
> > 
> > With this patch, the above test would pass (meaning the program is successfully
> > verified).
> > 
> > > 
> > > ---
> > > ; ret = bpf_d_path(&current->fs->pwd, buf, sizeof(buf));
> > > 15: (b7) r3 = 64                      ; R3_w=64
> > > 16: (85) call bpf_d_path#147
> > > R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
> > > ---
> > > 
> > > What's interesting is that based on the following commit
> > > (3f00c52393445 bpf: Allow trusted pointers to be passed to
> > > KF_TRUSTED_ARGS kfuncs) message:
> > > 
> > > ---
> > > PTR_TRUSTED pointers are passed directly from the kernel as a
> > > tracepoint or struct_ops callback argument. Any nested pointer that is
> > > obtained from walking a PTR_TRUSTED pointer is no longer
> > > PTR_TRUSTED. From the example above, the struct task_struct *task
> > > argument is PTR_TRUSTED, but the 'nested' pointer obtained from
> > > 'task->last_wakee' is not PTR_TRUSTED.
> > > ---
> > > 
> > > I'm reading this as though the first example program should also fail
> > > BPF verification given that a nested pointer to struct path is
> > > obtained from walking a PTR_TRUSTED pointer, which presumably is
> > > struct linux_binprm in this case. What subtle details am I missing
> > > here? Why is that the first program loads, but the second does not?
> > 
> > The subtle details are in that these are different types. We can't assume that
> > a child pointer automatically inherits its parent's trusted status for all
> > types, so we have to hard code it for now until gcc supports using btf type
> > tags so this can be expressed with annotations like __trusted or __rcu.
> 
> Oh, interesting. You mention that this is explicitly needed for gcc,
> so I'm now wondering how the semantics differ when using clang? Where
> would such annotations (__trusted, __rcu) be applied?

Please see the patch I linked above :-) The point of Alexei's patch was
to keep the same semantics between gcc and clang until gcc finishes
adding support for btf type tags. I recommend reading [1] to learn more
about BTF, if you're unfamiliar.

[1]: https://docs.kernel.org/bpf/btf.html

Once gcc supports BTF type tags, we can apply __trusted, __rcu, etc
annotations directly where the type is defined to encode the information
in BTF, and then use that information in the verifier to inform pointer
safety guarantees. This is already done in many places throughout the
kernel. See e.g. various fields in the definition of struct task_struct.

> > Consider that some types may have NULL child pointers in certain scenarios.
> > Others may be valid as long as you access it in an RCU read region, others may
> > be valid as long as you access it in an RCU read region and it wasn't NULL.
> 
> This makes sense. Thanks for the explanation.
> 
> > The struct linux_binprm type's safety is specified in
> > kernel/bpf/verifier.c:
> > 
> > BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) {
> > 	struct file *file;
> > };
> > 
> > struct task_struct is specified above:
> > 
> > /* RCU trusted: these fields are trusted in RCU CS and never NULL */
> > BTF_TYPE_SAFE_RCU(struct task_struct) {
> >         const cpumask_t *cpus_ptr;
> >         struct css_set __rcu *cgroups;
> >         struct task_struct __rcu *real_parent;
> >         struct task_struct *group_leader;
> > };
> > 
> > > What workaround needs to be implemented in order to have the second
> > > example program satisfy the PTR_TRUSTED contract with the BPF helper
> > > bpf_d_path?
> > 
> > See above, we need to add struct fs_struct * to the list of trusted fields for
> > struct task_struct, and enclose it in an RCU read region.
> 
> /M

