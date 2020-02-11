Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85D158ED1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 13:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBKMni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 07:43:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgBKMni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 07:43:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so12241415wrt.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2020 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qScZ2OQGzUYXuR6kAH88f9B9FETX7y4KOyCPzNNd570=;
        b=F6kcxw2aIpOCljO93d1/LT58wt42RsUWIhyechuyPoYaZYHnDGhT/t1x0l3els26iO
         xa2zSEN/RFIqGzLp/Qm73F/kCkab1SWK7xAMM0u1vZuw9ThZeIdHgnK/fkL6pKLDbaqz
         uzbQq9otoYSlNfqquoXNQJgNgx+cy1Jk7s2ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qScZ2OQGzUYXuR6kAH88f9B9FETX7y4KOyCPzNNd570=;
        b=C1PqjRa9vxkIWR53mOVqTI/UMblqXPGDhLnLnNri0vdS+VZfZXF7TbEZewvzgWB544
         wK/TjtU8TY4xLqVeqIYnvOReiquMZl4oPFOeea5ZbxG3h3r01dOzl1tGvJCoPQG0Tq7Z
         BxUpvVjafQPX4ckoVPjSBvR1Tcm2WZosa2PDDocs/9ljE2yfBXCr4f79MEztCPVuM/g/
         VfpOaIrsI6MDZa3UUkyvWmHzw4mh1SkzLI3K2wvuV5uq4Lo0Bjp+T2YVmEfEHYXy9Qxy
         +STEYRfTnBap5X1qNcxgLIr/zOHZWoMP2YWGiHzlOhdXaNPL3IheuoE+8wwMloo0M36C
         MKzQ==
X-Gm-Message-State: APjAAAWujORPzkcqiZfzXI38jxX+MxEJsMBS8Xe74ZCaVQNO97lP19mM
        DIFgV/AsmXIm6c/Rt3zxLKRihPKwwvM=
X-Google-Smtp-Source: APXvYqwuTAbA4laJrO9pymMZOyFSIlGy7FFR+JJ08nww0DqckH8bzRCFXGZWNtaq6pCXQYJWjW0lsg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr8365117wra.78.1581425016848;
        Tue, 11 Feb 2020 04:43:36 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id b13sm5269864wrq.48.2020.02.11.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:43:36 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 11 Feb 2020 13:43:34 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200211124334.GA96694@google.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211031208.e6osrcathampoog7@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10-Feb 19:12, Alexei Starovoitov wrote:
> On Thu, Jan 23, 2020 at 07:24:34AM -0800, KP Singh wrote:
> > +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
> > +	int _ret = 0;						\
> > +	do {							\
> > +		struct security_hook_list *P;			\
> > +		int _idx;					\
> > +								\
> > +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> > +			break;					\
> > +								\
> > +		_idx = bpf_lsm_srcu_read_lock();		\
> > +								\
> > +		hlist_for_each_entry(P,				\
> > +			&bpf_lsm_hook_heads.FUNC, list) {	\
> > +			_ret = P->hook.FUNC(__VA_ARGS__);		\
> > +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> > +				break;				\
> > +		}						\
> > +		bpf_lsm_srcu_read_unlock(_idx);			\
> > +	} while (0);						\
> > +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
> > +})
> 
> This extra CONFIG_SECURITY_BPF_ENFORCE doesn't make sense to me.

We found it easier to debug the programs if enforcement is disabled.
But we can remove this option if you feel strongly about it.

> Why do all the work for bpf-lsm and ignore return code? Such framework already
> exists. For audit only case the user could have kprobed security_*() in
> security/security.c and had access to exactly the same data. There is no need
> in any of these patches if audit the only use case.
> Obviously bpf-lsm has to be capable of making go/no-go decision, so
> my preference is to drop this extra kconfig knob.
> I think the agreement seen in earlier comments in this thread that the prefered
> choice is to always have bpf-based lsm to be equivalent to LSM_ORDER_LAST. In
> such case how about using bpf-trampoline fexit logic instead?

Even if the BPF LSM is LSM_ORDER_LAST this is still different from
adding a trampoline to the exit of the security hooks for a few other
reasons.

> Pros:
> - no changes to security/ directory

* We do need to initialize the BPF LSM as a proper LSM (i.e. in
  security/bpf) because it needs access to security blobs. This is
  only possible statically for now as they should be set after boot
  time to provide guarantees to any helper that uses information in
  security blobs. I have proposed how we could make this dynamic as a
  discussion topic for the BPF conference:

    https://lore.kernel.org/bpf/20200127171516.GA2710@chromium.org

  As you can see from some of the prototype use cases e.g:

    https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c

  that they do rely on security blobs and that they are key in doing
  meaningful security analysis.

* When using the semantic provided by fexit, the BPF LSM program will
  always be executed and will be able to override / clobber the
  decision of LSMs which appear before it in the ordered list. This
  semantic is very different from what we currently have (i.e. the BPF
  LSM hook is only called if all the other LSMs allow the action) and
  seems to be bypassing the LSM framework.

* Not all security_* wrappers simply call the attached hooks and return
  their exit code and not all of them pass the same arguments to the
  hook e.g. security_bprm_check, security_file_open,
  security_task_alloc to just name a few. Illustrating this further
  using security_task_alloc as an example:

	rc = call_int_hook(task_alloc, 0, task, clone_flags);
	if (unlikely(rc))
		security_task_free(task);
	return rc;

Which means we would leak task_structs in this case. While
call_int_hook is sort of equivalent to the fexit trampoline for most
hooks, it's not really the case for some (quite important) LSM hooks.

- KP

> - no changes to call_int_hook() macro
> - patches 4, 5, 6 no longer necessary
> - when security is off all security_*() hooks do single
>   if (hlist_empty(&bpf_lsm_hook_heads.FUNC)) check.
>   With patch 4 there will two such checks. Tiny perf penalty.
>   With fexit approach there will be no extra check.
> - fexit approach is fast even on kernels compiled with retpoline, since
>   its using direct calls
> Cons:
> - bpf trampoline so far is x86 only and arm64 support is wip
> 
> By plugging into fexit I'm proposing to let bpf-lsm prog type modify return
> value. Currently bpf-fexit prog type has read-only access to it. Adding write
> access is a straightforward verifier change. The bpf progs from patch 9 will
> still look exactly the same way:
> SEC("lsm/file_mprotect")
> int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
>             unsigned long reqprot, unsigned long prot) { ... }
> The difference that libbpf will be finding btf_id of security_file_mprotect()
> function and adding fexit trampoline to it instead of going via
> security_list_options and its own lsm_hook_idx uapi. I think reusing existing
> tracing facilities to attach and multiplex multiple programs is cleaner. More
> code reuse. Unified testing of lsm and tracing, etc.
