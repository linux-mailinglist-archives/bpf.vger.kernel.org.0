Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67D9167C79
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 12:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBULrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 06:47:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51352 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgBULrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 06:47:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so1443243wmi.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cxB7PUXTeUqygVh4eVSAkGxv4BrlTvTyre52qQTb2sk=;
        b=l8D2eEQgmOITjwBuVm5VtuSNkygu1eW905ngMg9QqsVYUb/bc6DX12heuvwETKJWdJ
         4Yznv+nripJTtuk89NxB5EF2XyEy7QrSHtrCsf9A4rDONqhKE+AgfTpv7BRTZsJyQLPl
         QmNdYll/kSn7l93ypox+mWvynTb6er6z+wCG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cxB7PUXTeUqygVh4eVSAkGxv4BrlTvTyre52qQTb2sk=;
        b=j/ATTAWzXs8WfKsWfUlnoSKT+dRU8t9pYWCsy0k4+Ur29k3nhdyWwkD/oUuwottRjI
         kNTUc9XD+S0EQFC+yjJpg/tPr9k6wuO6c2Nf5vX4rxRXsOA3XQ2qHZETv4hx+C8HAhRC
         mVUpTDEdZ1AU+q3rson0aHdQskHIuy2vinFQtcXLkGRRJUp1TnHxu/nBSjdZcQnZUo1i
         yuGA6w0oE3H92VWZXBNDh2mxc/j2uRrF3ym4Oz1HjThB7WI+CeUT9Ut7hkSySgFkxwVM
         URQC3sTKWvDJ7padUyeC/aBMXpJd62dls5lLmwBySLJd7R1OVYBZZ3k23Q8RPRjgrp6E
         8Ihg==
X-Gm-Message-State: APjAAAU+3BJcVOrW/4J5rPRONrXMvIdRFIrCTVntNofhXhuOp3b7+08H
        BkEJXYusyt9NQL20WJaBy5ZE+g==
X-Google-Smtp-Source: APXvYqzi/myhHCRfm6m57QklRA0XyBoOWDLuktGXTj3oiVYDxwisfDnqgz8ZZMcjtH1LSQt61fygoA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr3383352wmj.170.1582285632287;
        Fri, 21 Feb 2020 03:47:12 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id z133sm3564118wmb.7.2020.02.21.03.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 03:47:11 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 21 Feb 2020 12:47:10 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200221114710.GB56944@google.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <20200221022537.wbmhdfkdbfvw2pww@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221022537.wbmhdfkdbfvw2pww@ast-mbp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20-Feb 18:25, Alexei Starovoitov wrote:
> On Thu, Feb 20, 2020 at 06:52:45PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > The BPF LSM programs are implemented as fexit trampolines to avoid the
> > overhead of retpolines. These programs cannot be attached to security_*
> > wrappers as there are quite a few security_* functions that do more than
> > just calling the LSM callbacks.
> > 
> > This was discussed on the lists in:
> > 
> >   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266
> > 
> > Adding a NOP callback after all the static LSM callbacks are called has
> > the following benefits:
> > 
> > - The BPF programs run at the right stage of the security_* wrappers.
> > - They run after all the static LSM hooks allowed the operation,
> >   therefore cannot allow an action that was already denied.
> > 
> > There are some hooks which do not call call_int_hooks or
> > call_void_hooks. It's not possible to call the bpf_lsm_* functions
> > without checking if there is BPF LSM program attached to these hooks.
> > This is added further in a subsequent patch. For now, these hooks are
> > marked as NO_BPF (i.e. attachment of BPF programs is not possible).
> 
> the commit log doesn't match the code.

Fixed. Thanks!

> 
> > +
> > +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > + * function where a BPF program can be attached as an fexit trampoline.
> > + */
> > +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> > +#define LSM_HOOK_int(NAME, ...) noinline int bpf_lsm_##NAME(__VA_ARGS__)  \
> 
> Did you check generated asm?
> I think I saw cases when gcc ignored 'noinline' when function is defined in the
> same file and still performed inlining while keeping the function body.
> To be safe I think __weak is necessary. That will guarantee noinline.

Sure, will change it to __weak.

> 
> And please reduce your cc next time. It's way too long.

Will do.

- KP
