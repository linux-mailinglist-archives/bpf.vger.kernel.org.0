Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B6131B1D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2020 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgAFWNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jan 2020 17:13:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFWNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 17:13:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so27493050pgc.3;
        Mon, 06 Jan 2020 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eyolJd68ERnJpeKV8cAEbEAjcAmeu/bmG+0f7OhQ2SA=;
        b=Yijm0XTU+T/0xsej33JyRLg5dgQC8KC6yShekyLo5/vaHao2/7DcUd/SI8l20lCGjS
         mRL39ZS33Ne/7Xm2Xr0sU8REN9pHR8iHGfOPR8aFm6qsoL9a5bDUvRjAKzh1H8gTlYXD
         vA+ciQ0duA1TVCe/iUPA98eLjzYzfOznyTYKt26YlD2xIA1iR5QxQw7oKy+44L788t+0
         wY8COOYx7B1l+NnVPkBDk6qqAZy8y6rR/ERf5q324H0L4iTy6eyLKivhcRUHS/vhPsoh
         rjV0KqBOp+Skwxq71Lo0SP/nGtKA3TTCzRrtYu6jJ/vVG/IqlW7FjkIb2QuFmRVpzDTu
         EN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eyolJd68ERnJpeKV8cAEbEAjcAmeu/bmG+0f7OhQ2SA=;
        b=p+UKY58PiIUATy9p9bK+zSQllH62xQFusFAyFxW/Wvxo7JP/JwcxHj44his3hjEV9u
         /+HCRz5/XRSjhm6i3mbB307YIy/mSvedWv25Z7NmGl1Vlk9Ha6wA6vB4q1sAB4ypOY0s
         Tr3qb2Q1VyK9X/Vpt4HX+WlUirAOHEuIwxhL4gsSsQH2aNiyFYwLNunlX8mizuHaIY7L
         lYSk10KKLa37sP390jxrB3cJrFXFsF8XoSTVuLmcfog/zPLOgdxSXKOueYr52XYN9IDL
         MveM7tYJyKKq0u0om3IpM3O5YCaFqxHhGvILpPvUO5Ao6IN0Z+wuJ7Php6k2Rn2QYmCS
         InAA==
X-Gm-Message-State: APjAAAUSBqJv/YIWkFFxMRD9KxgMI+yiKD2NItFSeJV8qXFIOIqHb0PH
        xNwxm/1fvz4EYK39X00cN2A=
X-Google-Smtp-Source: APXvYqwYCJHcfeniuDi19iZ4yWsGvSHZV7jg0PZh3evoX6cntwbvydeSWfPAi1Ewbi82beKuDIKX3Q==
X-Received: by 2002:a63:31d1:: with SMTP id x200mr106298627pgx.405.1578348801200;
        Mon, 06 Jan 2020 14:13:21 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:2bf6])
        by smtp.gmail.com with ESMTPSA id w131sm81274287pfc.16.2020.01.06.14.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:13:20 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:13:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Justin Capella <justincapella@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Message-ID: <20200106221317.wpwut2rgw23tdaoo@ast-mbp>
References: <CAMrEMU8Vsn8rfULqf1gfuYL_-ybqzit29CLYReskaZ8XUroZww@mail.gmail.com>
 <768BAF04-BEBF-489A-8737-B645816B262A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <768BAF04-BEBF-489A-8737-B645816B262A@amacapital.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 05, 2020 at 10:33:54AM +0900, Andy Lutomirski wrote:
> 
> >> On Jan 4, 2020, at 8:03 PM, Justin Capella <justincapella@gmail.com> wrote:
> > ﻿
> > I'm rather ignorant about this topic but it would make sense to check prior to making executable from a security standpoint wouldn't it? (In support of the (set_memory_ro + set_memory_x)
> > 
> 
> Maybe, depends if it’s structured in a way that’s actually helpful from a security perspective.
> 
> It doesn’t help that set_memory_x and friends are not optimized at all. These functions are very, very, very slow and adversely affect all CPUs.

That was one of the reason it wasn't done in the first.
Also ftrace trampoline break w^x as well.
Not sure what is the plan for ftrace, but for bpf trampoline I'm going to switch
to text_poke (without _bp) once tip bits get merged during next merge window.
Then bpf trampoline will be allocated as ro+x and text_poke will be used instead of memcpy.
