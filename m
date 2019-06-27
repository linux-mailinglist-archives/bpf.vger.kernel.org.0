Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66A158EA3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 01:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0Xk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 19:40:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41723 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF0Xk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 19:40:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so2116424pls.8
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 16:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ios0tdBrbMiaNhZPetGcknsZ2m4TvlD/r/ST83vdgkU=;
        b=UPjFep1lc64+drMd8k+KJ8eomaMh355tnp6BDo8v7Fp/CVixfHDbbajFEQW5nU0twF
         +FYhYuOlrVc479oYTMJbdFhotuAOliJTgMqBcaE5TqU4gGmBDqpIcbOxBH756OcuuqIO
         8A/XmwsphchNI6qPvBGY+xEfCSPJyHuKlyTONL/snmzIMP2FZSU2ZEtCD/VC2mcZHp+I
         Sl6Hvc9QRgSs+N+jAMND4kc6QYiKk4oW0vzpRBkeeKgO8EKrPjs2Bec453b8x/x7D4NL
         Vi5KmkZpRpawv64hJWEMAkd00yqS1dAjSgJBnN6ZdUJ9oKxKG51R0iPCTYEbLiWnehMU
         EpHQ==
X-Gm-Message-State: APjAAAXwul3AGmpBUZ8zJ/tRklh7tecbKChOuUeWdONPXJ9epQCR3HMm
        /RoeXJGuB6a7UvkDPQTV2mmcA0T1RSafMQ==
X-Google-Smtp-Source: APXvYqwsttsvjEpOCAXUUio75uJQWVe+qFGneHy2HZGg6qjAlVubgnEg3neSdlA/KXt9cZVlYsxquw==
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr7303208plb.75.1561678856059;
        Thu, 27 Jun 2019 16:40:56 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id d1sm199095pgd.50.2019.06.27.16.40.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 16:40:55 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        lmb@cloudflare.com, jannh@google.com, gregkh@linuxfoundation.org,
        linux-abi@vger.kernel.org, kees@chromium.org
References: <20190627201923.2589391-1-songliubraving@fb.com>
 <20190627201923.2589391-2-songliubraving@fb.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <21894f45-70d8-dfca-8c02-044f776c5e05@kernel.org>
Date:   Thu, 27 Jun 2019 16:40:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627201923.2589391-2-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/27/19 1:19 PM, Song Liu wrote:
> This patch introduce unprivileged BPF access. The access control is
> achieved via device /dev/bpf. Users with write access to /dev/bpf are able
> to call sys_bpf().
> 
> Two ioctl command are added to /dev/bpf:
> 
> The two commands enable/disable permission to call sys_bpf() for current
> task. This permission is noted by bpf_permitted in task_struct. This
> permission is inherited during clone(CLONE_THREAD).
> 
> Helper function bpf_capable() is added to check whether the task has got
> permission via /dev/bpf.
> 

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0e079b2298f8..79dc4d641cf3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9134,7 +9134,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
>   		env->insn_aux_data[i].orig_idx = i;
>   	env->prog = *prog;
>   	env->ops = bpf_verifier_ops[env->prog->type];
> -	is_priv = capable(CAP_SYS_ADMIN);
> +	is_priv = bpf_capable(CAP_SYS_ADMIN);

Huh?  This isn't a hardening measure -- the "is_priv" verifier mode 
allows straight-up leaks of private kernel state to user mode.

(For that matter, the pending lockdown stuff should possibly consider 
this a "confidentiality" issue.)


I have a bigger issue with this patch, though: it's a really awkward way 
to pretend to have capabilities.  For bpf, it seems like you could make 
this be a *real* capability without too much pain since there's only one 
syscall there.  Just find a way to pass an fd to /dev/bpf into the 
syscall.  If this means you need a new bpf_with_cap() syscall that takes 
an extra argument, so be it.  The old bpf() syscall can just translate 
to bpf_with_cap(..., -1).

For a while, I've considered a scheme I call "implicit rights".  There 
would be a directory in /dev called /dev/implicit_rights.  This would 
either be part of devtmpfs or a whole new filesystem -- it would *not* 
be any other filesystem.  The contents would be files that can't be read 
or written and exist only in memory.  You create them with a privileged 
syscall.  Certain actions that are sensitive but not at the level of 
CAP_SYS_ADMIN (use of large-attack-surface bpf stuff, creation of user 
namespaces, profiling the kernel, etc) could require an "implicit 
right".  When you do them, if you don't have CAP_SYS_ADMIN, the kernel 
would do a path walk for, say, /dev/implicit_rights/bpf and, if the 
object exists, can be opened, and actually refers to the "bpf" rights 
object, then the action is allowed.  Otherwise it's denied.

This is extensible, and it doesn't require the rather ugly per-task 
state of whether it's enabled.

For things like creation of user namespaces, there's an existing API, 
and the default is that it works without privilege.  Switching it to an 
implicit right has the benefit of not requiring code changes to programs 
that already work as non-root.

But, for BPF in particular, this type of compatibility issue doesn't 
exist now.  You already can't use most eBPF functionality without 
privilege.  New bpf-using programs meant to run without privilege are 
*new*, so they can use a new improved API.  So, rather than adding this 
obnoxious ioctl, just make the API explicit, please.

Also, please cc: linux-abi next time.
