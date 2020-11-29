Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0542C7735
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgK2BhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgK2BhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:37:04 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771AC0613D1;
        Sat, 28 Nov 2020 17:36:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so4544898pll.2;
        Sat, 28 Nov 2020 17:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60Q/WxdzYXfrMFof+jYtWlTA1Q7rDWZ0ufHoBpi8ZDg=;
        b=C7xpg0ykCSA277GMibjvIfc36U2xgyiTkbXG+jihQydcPIxxr6tsDMsCbuGzj9OGqU
         YIGPgH2NfMEGRlWUNUrVvHaB2GCmPgyyikKvERx8mZAgT0HTMJJ/S25LyBzRZDCcs/5K
         h8a5EKIrYramDmcCw1sNJolM8LoO0DzQ9KOAGH7v99cdkdR7Kq17KyAok9yBBCI1mEkq
         pSvNZ9a0xMiUAcVjpS1eBJbnmGvI32z+TatqbS6iXQBSWiNK0HFU4pIzBdi3d+Gm0W8q
         6SZl7zaqqBCYvTGI5wBsnibLNvdllKz5uhW3joKhFPeB5Nci6x2KYoO84Hb9vJRBHWtp
         0Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60Q/WxdzYXfrMFof+jYtWlTA1Q7rDWZ0ufHoBpi8ZDg=;
        b=Ush8AVKqJtoWwY9iey2L+6kRH8FlTrFcs+WoWwL5TUx5OKfcWH6sm1UDW/Z8NTbSgZ
         ToRbLON3VpoZJvULcZ3tHt7RuPGq42sLflg9zICI3eCZiqrj0NMtC8F31UlGekPD1KLo
         Cu0ErcFdirUYnDS6i8iLBAd1vYdmGKmmbvbxlKFKiwGl2yenUnH47gXkgrLVmeVqDUSi
         OTxivJsKc1GUfUH8B9FhhJ3DG+JQBT9QkR0nfPup6ZykBYmIIjToTYcTutXyHueL8reE
         7Qm8LDJ37C+6tp0k810VNBjGRLqTtkz84vg1Ld3pVHXOv5Jw6Kq6jLWgP4MeWb5ge8BG
         jC0w==
X-Gm-Message-State: AOAM533XL92BKxCT7p6sobY3D3ql+8wW+1LworYRzR9sFUHB/LcCbbpK
        ClZGcd+nfR+oYeKktpppJdI=
X-Google-Smtp-Source: ABdhPJxHIh/LWp8HhZp++xQDggXAolqmMXFNh69L8KUUZERMy7v0jlmWcMbOH8nV7q/YNY17BQxMjg==
X-Received: by 2002:a17:902:8c8a:b029:d6:d1e7:e78e with SMTP id t10-20020a1709028c8ab02900d6d1e7e78emr12795086plo.39.1606613778009;
        Sat, 28 Nov 2020 17:36:18 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id b21sm15953801pji.24.2020.11.28.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:36:17 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:36:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Add bitwise atomic instructions
Message-ID: <20201129013615.mf45ihcio2abuvlu@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-12-jackmanb@google.com>
 <d2e093c3-79bc-0a6b-8919-c5a07667926a@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e093c3-79bc-0a6b-8919-c5a07667926a@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 09:39:10PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> > This adds instructions for
> > 
> > atomic[64]_[fetch_]and
> > atomic[64]_[fetch_]or
> > atomic[64]_[fetch_]xor
> > 
> > All these operations are isomorphic enough to implement with the same
> > verifier, interpreter, and x86 JIT code, hence being a single commit.
> > 
> > The main interesting thing here is that x86 doesn't directly support
> > the fetch_ version these operations, so we need to generate a CMPXCHG
> > loop in the JIT. This requires the use of two temporary registers,
> > IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> 
> similar to previous xsub (atomic[64]_sub), should we implement
> xand, xor, xxor in llvm?

yes. please. Unlike atomic_fetch_sub that can be handled by llvm.
atomic_fetch_or/xor/and has to be seen as separate instructions
because JITs will translate them as loop.
