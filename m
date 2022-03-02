Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D64CAF45
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiCBUCp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 15:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCBUCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 15:02:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C55C24AA;
        Wed,  2 Mar 2022 12:02:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e2so2505339pls.10;
        Wed, 02 Mar 2022 12:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7BFioUturBwb+BbemATArMiZ45qERJds2R0cuVDbIw=;
        b=MRBXbyzXcOwpS19xaDmOY0I52vehm4ezY4ynZl4pbhxwhZh0mP8VWxXrTGjbZL1mYx
         AzD1Awf8rHGV8KKaeAWHKSrScniPV4FCeFL7z9TeEZA5c/AotfF4ICu0aHiF+K8bVMtW
         YOrAIooaLOg+Fmys1hcFsK1UwAuLaQ7uYCTYRrd8ukcy+oV7UjSd+vqWlvBmtZxdKOLe
         lZUDngSFc/uAHb2biAQpU7lSXcefXXUKiFqFK9kjbkvfDbJqZMjwoKVDp5H0zIMRmlKJ
         6ubVzhe5fchKEWw9kMBQzkJ4VIs8SMTqftTcPmUKNj8HBMb5AZZGMONEZ9HFT2m/f8tr
         TTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7BFioUturBwb+BbemATArMiZ45qERJds2R0cuVDbIw=;
        b=qiaBWShFtnnhwzg457nkG+yqNqL0/Wc5iHnRcGVcrhaTnn0b2RwPBuglKGLwbY9bMx
         QkAr5ujGxy3QBrzXAYynAxYG8l/E74LqCW9KUbF1GhZjcMWTeG9a1WVrIWrVyTaN6rzb
         2DhjyCj9yWBuoT1JlNExCTi2rIJ/R0+VQ4idRmQ002J7nXMaR+JjSf405c0VlhWYgqrg
         jsLagvn8VKFaUI7vTM5DpBUWci+vg1A9z1xmV7RAgsBI2oE6PR5lChBJ3Qkns0qps0Nf
         xvRVYryXvc+jE4ee+te5FpT/XYCmb9xiRpYEuwqcu2ccL2j41Ph4aUH1XEabWrPe+s1w
         LOJQ==
X-Gm-Message-State: AOAM532OCgdr/zzkt1ZQeZBmZUhsWWuRuA1EH1BbLDP5q5d7//CuxLvN
        89MJEDq1p9+1RX+cRSh10rg=
X-Google-Smtp-Source: ABdhPJydHBf4tVaM+x8ndfATX0hlnrLlTExGZTYfxR/hDdo/5T/CTLdLNkZOjbr4oB0QLVMtmNyMaQ==
X-Received: by 2002:a17:902:b087:b0:151:842a:d212 with SMTP id p7-20020a170902b08700b00151842ad212mr9587374plr.92.1646251320766;
        Wed, 02 Mar 2022 12:02:00 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b004f357e3e42fsm6960pfs.36.2022.03.02.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:02:00 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:01:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 7/9] bpf: Lift permission check in __sys_bpf
 when called from kernel.
Message-ID: <20220302200155.sid3imy4iqm7k5qf@ast-mbp.dhcp.thefacebook.com>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-8-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-8-haoluo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 25, 2022 at 03:43:37PM -0800, Hao Luo wrote:
> After we introduced sleepable tracing programs, we now have an
> interesting problem. There are now three execution paths that can
> reach bpf_sys_bpf:
> 
>  1. called from bpf syscall.
>  2. called from kernel context (e.g. kernel modules).
>  3. called from bpf programs.
> 
> Ideally, capability check in bpf_sys_bpf is necessary for the first two
> scenarios. But it may not be necessary for the third case.

Well, it's unnecessary for the first two as well.
When called from the kernel lskel it's a pointless check.
The kernel module can do anything regardless.
When called from bpf syscall program it's not quite correct either.
When CAP_BPF was introduced we've designed it to enforce permissions
at prog load time. The prog_run doesn't check permissions.
So syscall progs don't need this secondary permission check.
Please add "case BPF_PROG_TYPE_SYSCALL:" to is_perfmon_prog_type()
and combine it with this patch.

That would be the best. The alternative below is less appealing.

> An alternative of lifting this permission check would be introducing an
> 'unpriv' version of bpf_sys_bpf, which doesn't check the current task's
> capability. If the owner of the tracing prog wants it to be exclusively
> used by root users, they can use the 'priv' version of bpf_sys_bpf; if
> the owner wants it to be usable for non-root users, they can use the
> 'unpriv' version.

...

> -	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_capable() && !uattr.is_kernel)

This is great idea. If I could think of this I would went with it when prog_syscall
was introduced.
