Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDBE2C773B
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgK2Bko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgK2Bkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:40:43 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E098C0613D1;
        Sat, 28 Nov 2020 17:40:03 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so7435498pge.6;
        Sat, 28 Nov 2020 17:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OV7WYEaflJOvgC9Fvl1UU2JUGsbbYuQ370UuXwYxItc=;
        b=Y4k7Jbb7fHBAw0t67D+eHqnUZFbT5hsvuPIbNtQtaayFcscU2H920TBEryoZLG8W56
         JIazFBmJUjgLD7a+FHcpIT7BbOBIIXUnjyL7A662jqFfSamFHOXHlRt1JUKt9ni+7VHR
         xbhcn1e4dxGZd/JOQNqxkFqn6V6OQrXGYB6JHqHTpkIOZNkiLgigALQIOitxQEdZnULj
         2sCiKjEOYDMnZ3PS8iikpBzxa0VbYF76zXGOdrsNv34A03FulLmuQSVIJ4nUxyEboqql
         87HkAmk3B+UscrsE/T7si+NYyUXQAcdb5Qc65niMudfsbskHz6GXTEWTqcq2jW+nDk14
         A6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OV7WYEaflJOvgC9Fvl1UU2JUGsbbYuQ370UuXwYxItc=;
        b=U4FYrNEtr6NJyNNGMcL6TbXJKk4weL7W9BuiRYx6dnd3fevVPHOVStybVcC2TAhoQL
         JcU/3F2du2SxFtybnhVNM7077tsf215GFYvQeAJbhVuKzq2Bb+T7Xvnv2Xn0eDtnwOuW
         yvTO0lpgsTM70Jmud9/zmohg180ktXaGQs3pxBVziNkcNqHnmzGwOe3HnW5goKOZGEVa
         7SHNsvzRHwd1MYtBL0t140YpVMHeWfNcMbUnBMTEdd8n/vQOviX0kLwpgkG57Wv6gOJg
         YtBgOsEbp2H2IemPFMcJT7qwGPkNIozAA8+QJ445NAv//cH1YmfXGItf1gjr2QDFLSrv
         Zegw==
X-Gm-Message-State: AOAM531Zi043OR5a9/HF350py8NUKdVzu/uPMXUHXYsgCbicZ+4XIOKh
        Tm4iUs791SbLdSFd+++PJh0=
X-Google-Smtp-Source: ABdhPJxQ/GkFirMu4p5sPpUl7buWyBE7wW0lCE7RI3hVykNxRenF3+1rfyC5D47SF0J8UuooGgb/5g==
X-Received: by 2002:a17:90a:ca93:: with SMTP id y19mr18103215pjt.71.1606614002978;
        Sat, 28 Nov 2020 17:40:02 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id i10sm11995276pfk.206.2020.11.28.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:40:02 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:40:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
Message-ID: <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 09:53:05PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> > Status of the patches
> > =====================
> > 
> > Thanks for the reviews! Differences from v1->v2 [1]:
> > 
> > * Fixed mistakes in the netronome driver
> > 
> > * Addd sub, add, or, xor operations
> > 
> > * The above led to some refactors to keep things readable. (Maybe I
> >    should have just waited until I'd implemented these before starting
> >    the review...)
> > 
> > * Replaced BPF_[CMP]SET | BPF_FETCH with just BPF_[CMP]XCHG, which
> >    include the BPF_FETCH flag
> > 
> > * Added a bit of documentation. Suggestions welcome for more places
> >    to dump this info...
> > 
> > The prog_test that's added depends on Clang/LLVM features added by
> > Yonghong in https://reviews.llvm.org/D72184
> > 
> > This only includes a JIT implementation for x86_64 - I don't plan to
> > implement JIT support myself for other architectures.
> > 
> > Operations
> > ==========
> > 
> > This patchset adds atomic operations to the eBPF instruction set. The
> > use-case that motivated this work was a trivial and efficient way to
> > generate globally-unique cookies in BPF progs, but I think it's
> > obvious that these features are pretty widely applicable.  The
> > instructions that are added here can be summarised with this list of
> > kernel operations:
> > 
> > * atomic[64]_[fetch_]add
> > * atomic[64]_[fetch_]sub
> > * atomic[64]_[fetch_]and
> > * atomic[64]_[fetch_]or
> 
> * atomic[64]_[fetch_]xor
> 
> > * atomic[64]_xchg
> > * atomic[64]_cmpxchg
> 
> Thanks. Overall looks good to me but I did not check carefully
> on jit part as I am not an expert in x64 assembly...
> 
> This patch also introduced atomic[64]_{sub,and,or,xor}, similar to
> xadd. I am not sure whether it is necessary. For one thing,
> users can just use atomic[64]_fetch_{sub,and,or,xor} to ignore
> return value and they will achieve the same result, right?
> From llvm side, there is no ready-to-use gcc builtin matching
> atomic[64]_{sub,and,or,xor} which does not have return values.
> If we go this route, we will need to invent additional bpf
> specific builtins.

I think bpf specific builtins are overkill.
As you said the users can use atomic_fetch_xor() and ignore
return value. I think llvm backend should be smart enough to use
BPF_ATOMIC | BPF_XOR insn without BPF_FETCH bit in such case.
But if it's too cumbersome to do at the moment we skip this
optimization for now.
