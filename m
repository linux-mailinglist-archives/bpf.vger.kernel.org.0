Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D61159780
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgBKR6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 12:58:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37958 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgBKR6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 12:58:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so4565075plj.5;
        Tue, 11 Feb 2020 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rptgnpdljC5x2bhptwLXpbtKJ/HkIadlAqVDXaT95LU=;
        b=eCn2WxhbxODwWTEQoefBVinrom6bS+mgcBkXBuHwVC4mipCdsujuGpAh2CeQ1w/fG+
         NHNsbrWdzQKZbKF4YsDIR4lUOMYbtyBWJ9Ca8AP9Xfkc/3MRpyNiOlp6YIXFFpyRTq5/
         KiLp/jrYJ+45+/nJOEAkt1cCUMciUY8WZIT2vHcuGW/YTb11XUvaObIsJTrZmq0RRsKL
         +fmo420j77BIqDkdks8pYM1l0RhcpyQS5rWoG0KBWZuK3gTaMj2V6elXOIGT4cjD2b2v
         lOXd8jMqcwXBN60bcFFch9l4L6+zIouf/bJSXIOy8BZgs8fNlZSK9DFV+HBgQ6twF+C5
         Okbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rptgnpdljC5x2bhptwLXpbtKJ/HkIadlAqVDXaT95LU=;
        b=QvgFgO5pDHcDUKqEOilaauyxuHgLMMOme+I9BSIE1iaLBfThZxtPM5ai0iJrkRd+AL
         CU5D0uasAPeey6cZNn1RCHqpolLRpprCs8CikQZDVat+1hshfm8Hte6mhIaQeCLPHqT6
         85glL78TtNOJGBCWT6PALtAtSvzfKH2Vtaznydif3X5yFFCbne1b8iuxsYizuMOpzWPQ
         U9MpsdAWwMDRmAm6GZUZ4FEP3zuXt2WBztGzyfU1BQi9SQfl60LFBD++6d2C5qR7zy7J
         rVozxv/Hb4jP7eRuewW8t8LjE1wcy2YU3VQWxFpDkliFErpUxgsrYc+U8Ttj2P+4u92a
         LLJw==
X-Gm-Message-State: APjAAAWCrRIFnUEsb5GhdWBmRGDeJu6R4Vdo03MV/DLXfR6t7ZAB/o+G
        czp+33P8aZt+TOZ7LXxjHtM=
X-Google-Smtp-Source: APXvYqyq0aeXQPknw0aJdqRVkPfZrGR5i6YUVphYlNhjXpItzPVkQdArr7E199v9AJHzFp1eUC+rxA==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr5093197pjb.43.1581443910071;
        Tue, 11 Feb 2020 09:58:30 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:aeb4])
        by smtp.gmail.com with ESMTPSA id e9sm3993074pjt.16.2020.02.11.09.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 09:58:29 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:58:27 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
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
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
Message-ID: <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp>
 <20200211124334.GA96694@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211124334.GA96694@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> 
> > Pros:
> > - no changes to security/ directory
> 
> * We do need to initialize the BPF LSM as a proper LSM (i.e. in
>   security/bpf) because it needs access to security blobs. This is
>   only possible statically for now as they should be set after boot
>   time to provide guarantees to any helper that uses information in
>   security blobs. I have proposed how we could make this dynamic as a
>   discussion topic for the BPF conference:
> 
>     https://lore.kernel.org/bpf/20200127171516.GA2710@chromium.org
> 
>   As you can see from some of the prototype use cases e.g:
> 
>     https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> 
>   that they do rely on security blobs and that they are key in doing
>   meaningful security analysis.

above example doesn't use security blob from bpf prog.
Are you referring to
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/security/bpf/ops.c#L455
Then it's a bpf helper that is using it. And that helper could have been
implemented differently. I think it should be a separate discussion on merits
of such helper, its api, and its implementation.

At the same time I agree that additional scratch space accessible by lsm in
inode->i_security, cred->security and other kernel structs is certainly
necessary, but it's a nack to piggy back on legacy lsm way of doing it. The
implementation of bpf_lsm_blob_sizes.lbs_inode fits one single purpose. It's
fine for builtin LSM where blob sizes and code that uses it lives in one place
in the kernel and being modified at once when need for more space arises. For
bpf progs such approach is a non starter. Progs need to have flexible amount
scratch space. Thankfully this problem is not new. It was solved already.
Please see how bpf_sk_storage is implemented. It's a flexible amount of scratch
spaces available to bpf progs that is available in every socket. It's done on
demand. No space is wasted when progs are not using it. Not all sockets has to
have it either. I strongly believe that the same approach should be used for
scratch space in inode, cred, etc. It can be a union of existing 'void
*security' pointer or a new pointer. net/core/bpf_sk_storage.c implementation
is not socket specific. It can be generalized for inode, cred, task, etc.

> * When using the semantic provided by fexit, the BPF LSM program will
>   always be executed and will be able to override / clobber the
>   decision of LSMs which appear before it in the ordered list. This
>   semantic is very different from what we currently have (i.e. the BPF
>   LSM hook is only called if all the other LSMs allow the action) and
>   seems to be bypassing the LSM framework.

It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
trampoline generator specific to lsm progs.

> * Not all security_* wrappers simply call the attached hooks and return
>   their exit code and not all of them pass the same arguments to the
>   hook e.g. security_bprm_check, security_file_open,
>   security_task_alloc to just name a few. Illustrating this further
>   using security_task_alloc as an example:
> 
> 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> 	if (unlikely(rc))
> 		security_task_free(task);
> 	return rc;
> 
> Which means we would leak task_structs in this case. While
> call_int_hook is sort of equivalent to the fexit trampoline for most
> hooks, it's not really the case for some (quite important) LSM hooks.

let's look at them one by one.
1.
security_bprm_check() calling ima_bprm_check.
I think it's layering violation.
Was it that hard to convince vfs folks to add it in fs/exec.c where
it belongs?

2.
security_file_open() calling fsnotify_perm().
Same layering violation and it's clearly broken.
When CONFIG_SECURITY is not defined:
static inline int security_file_open(struct file *file)
{
        return 0;
}
There is no call to fsnotify_perm().
So fsnotify_open/mkdir/etc() work fine with and without CONFIG_SECURITY,
but fsnotify_perm() events can be lost depending on kconfig.
fsnotify_perm() should be moved in fs/open.c.

3.
security_task_alloc(). hmm.
when CONFIG_SECURITY is enabled and corresponding LSM with
non zero blob_sizes.lbs_task is registered that hook allocates
memory even if task_alloc is empty.
Doing security_task_free() in that hook also looks wrong.
It should have been:
diff --git a/kernel/fork.c b/kernel/fork.c
index ef82feb4bddc..a0d31e781341 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2062,7 +2062,7 @@ static __latent_entropy struct task_struct *copy_process(
        shm_init_task(p);
        retval = security_task_alloc(p, clone_flags);
        if (retval)
-               goto bad_fork_cleanup_audit;
+               goto bad_fork_cleanup_security;
Same issue with security_file_alloc().

I think this layering issues should be fixed, but it's not a blocker for
lsm-bpf to proceed. Using fexit mechanism and bpf_sk_storage generalization is
all that is needed. None of it should touch security/*.
