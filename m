Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A968B20A
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 22:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBEVza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 16:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEVza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 16:55:30 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71441817F;
        Sun,  5 Feb 2023 13:55:28 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id mm5so1759240qvb.12;
        Sun, 05 Feb 2023 13:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd8GC4S22QIGy6feHXloJMiVPEVvynjDdix1hqFzPBQ=;
        b=FBPRfps8T2YhacRgXSQbPDYzv20vRSufktKfPZMrGnRkACFBqj5si2gODM69mQtePW
         iETPZbJENpiDqNpgXxoc7x8Lfx1MBe5VhzOXaF6MwarBbVgwJN1Nz6Dq7+i6OedbGvJy
         jvgyVhIXwDqxZPrJesujS8JAekc1/5CRqsCNQpBA4WG52ZqsnJWos4mt1hbgqdvzmJVz
         NkT4K8BrR7m7Xi6KFnY6fqU6Ade+gUmAFGIFX5Q0FnNdWx/bJxsL1FqyeqbdBjty+U4v
         Mr2nlvNDfErMKjmNjBaMHg3yv3siingu03n7TfK/f0Pkb1Bx6ZGMsKkk0klhqtDS5drL
         MPbw==
X-Gm-Message-State: AO0yUKVpKCHsDZh+RnrarZKgqi/POjpeDOywUJKCOuvv5LtY5eUFLZ0f
        gJ5WXcLoxKxEhQ6/y9AMDhRoNAd+v/sR4W+B
X-Google-Smtp-Source: AK7set9i/PApkfhWFCZNLKgGP+t0zfCW5GxPpLn/Ps+2pE/hqkK7fO1lRr69WHxpSZX83VXjWeBYcw==
X-Received: by 2002:a0c:c48f:0:b0:53c:e0cb:67ad with SMTP id u15-20020a0cc48f000000b0053ce0cb67admr20628431qvi.43.1675634127869;
        Sun, 05 Feb 2023 13:55:27 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8625])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b00705cef9b84asm6023118qkh.131.2023.02.05.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:55:27 -0800 (PST)
Date:   Sun, 5 Feb 2023 15:55:29 -0600
From:   David Vernet <void@manifault.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        toke@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        brouer@redhat.com, bagasdotme@gmail.com, linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle /
 stability expectations
Message-ID: <Y+Al0QKpeTK2XGyV@maniforge.lan>
References: <20230203155727.793518-1-void@manifault.com>
 <20230203155727.793518-2-void@manifault.com>
 <Y+AUm8cikB6m978j@pop-os.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+AUm8cikB6m978j@pop-os.localdomain>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 05, 2023 at 12:42:03PM -0800, Cong Wang wrote:
> On Fri, Feb 03, 2023 at 09:57:27AM -0600, David Vernet wrote:
> > BPF kernel <-> kernel API stability has been discussed at length over
> > the last several weeks and months. Now that we've largely aligned over
> > kfuncs being the way forward, and BPF helpers being considered
> > functionally frozen, it's time to document the expectations for kfunc
> > lifecycles and stability so that everyone (BPF users, kfunc developers,
> > and maintainers) are all aligned, and have a crystal-clear understanding
> > of the expectations surrounding kfuncs.
> > 
> > To do that, this patch adds that documentation to the main kfuncs
> > documentation page via a new 'kfunc lifecycle expectations' section. The
> > patch describes how decisions are made in the kernel regarding whether
> > to include, keep, deprecate, or change / remove a kfunc. As described
> > very overtly in the patch itself, but likely worth highlighting here:
> > 
> > "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> > development elsewhere in the kernel".
> > 
> > Rather, the intention and expectation is for kfuncs to be treated like
> > EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> > safe and valuable option for maintainers and kfunc developers to extend
> > the kernel, without tying anyone's hands, or imposing any kind of
> > restrictions on maintainers in the same way that UAPI changes do.
> 
> I think they are still different, kernel modules are still considered as
> a part of kernel development, while eBPF code is not that supposed to be
> kernel development, at least much further. Treating them alike is
> misleading, IMHO.

I'm not following. How is a BPF program not kernel development?

> > 
> > In addition to the 'kfunc lifecycle expectations' section, this patch
> > also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> > authors or maintainers can choose to add to kfuncs if and when they
> > decide to deprecate them. Note that as described in the patch itself, a
> > kfunc need not be deprecated before being changed or removed -- this
> > flag is simply provided as an available deprecation mechanism for those
> > that want to provide a deprecation story / timeline to their users.
> > When necessary, kfuncs may be changed or removed to accommodate changes
> > elsewhere in the kernel without any deprecation at all.
> 
> This fundamentally contradicts with Compile-Once-Run-Everywhere
> https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html

Sorry, but again, I'm not following your point. What exactly about this
"fundamentally contradicts" with CO-RE? Please elaborate if you're going
to claim that something is a fundamental contradiction.

> Could you add some clarification for this too? Especically how we could
> respect CO-RE meanwhile deprecating kfuncs?

I don't know what you mean by "respecting CO-RE". You can compile a BPF
program that calls a kfunc and invoke it on differents, as long as
whatever kernel you're running on provides that kfunc with the same BTF
encoding. This is no different than e.g. accessing a struct element on
two kernel versions.

Also, CO-RE doesn't provide any ironclad guarantees either. If you
access a struct element in a BPF program, and then a kernel version
removes that element from the struct, that BPF program will fail to load
on that kernel.

> BTW, not related to compatibility, but still kfuncs related confusion,
> it also contradicts with Documentation/bpf/bpf_design_QA.rst:
> 
> "
> Q: Can BPF functionality such as new program or map types, new
> helpers, etc be added out of kernel module code?
> 
> A: NO.

Agreed, we should improve the QA to mention that you can load kfuncs
from a module -- thanks for pointing that out!

> "
> 
> The conntrack kfuncs like bpf_skb_ct_alloc() reside in a kernel module.
> 
> Thanks!
