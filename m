Return-Path: <bpf+bounces-16555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B361802791
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A3CB208E7
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD3182AC;
	Sun,  3 Dec 2023 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrBOo6d5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31673CF
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 12:50:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b397793aaso23295545e9.0
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701636603; x=1702241403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zV7MrAKjLn1g8PB/21yd8/9Py+QZfSONWCTUt8XNBcc=;
        b=CrBOo6d5O8+a3Cetmv80Fh7jeQYj43wrHlW98T21bVMSbQBLCY2IxdcHC0h0qF7aLY
         4RauGrn94oq5FGnn8umbCybVh5OE0u5sKPSi6eLdxZC9dKuNo5Fkx0kMAFIAjCCQFfLG
         3qD1Q7rrcc/r8C3iF0WG2KEEz6AeSvZ8ir9UAPXH4jbxzEX+4eriVNanKV0yzyRREGli
         0eCfeKl1G+MyS0h+EOr8eKSCDjL+NYCPSuFpl5gdaYsAuzwa0fQwJH/aDXASFcc9msjt
         N20jg1KWm+x3EcuqaAR7FgmEfLaOMLhngvWlQVwYI39RcZ+AZCGaQmHFsuLUOKeJuoOs
         ZXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701636603; x=1702241403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV7MrAKjLn1g8PB/21yd8/9Py+QZfSONWCTUt8XNBcc=;
        b=gofnmx58GLmTicUwhydfaaxo0CKaAjLF8i2GCs9JQwlHJSDnHRYLTUG6AaO9wMlS9p
         o8hVpO4C7QuzbG048SyA6YhRja2US1VsN5d5X16jfF9TUiIFfJZ6Sw+T1/js/MQek/OF
         fX1VEDNr2D5Cp39MZbGbmAADqjE9oWf+mzFHyqgg+BwFV4pv34n8Zn92iw/KBQjFB4lq
         zmexErjAMAYLEArNgwx5BVXm9fn7RM+1xd27gPAoN8jS8BRiWkNV55jqAnbxZIwAEV9j
         1zRUPs/EiZcTBHpDu3CFWF5jtW1Mub8gkSlvYpDhgpzal/S4KcwKcD8mVPHLuKGYoWGs
         wG5A==
X-Gm-Message-State: AOJu0Yz3CaNLR8WiY4KFtjP2XCJhbfCFlz5wkqTBdSgTNkhxKOd2wBuv
	WAr7CzoCkttCB3m+MYssPQU=
X-Google-Smtp-Source: AGHT+IHiWUoX0fe3BsFhWKAY3wfzJT30xUNj8/+jgLnE6s+sYbq/A35lNe6jkjzMbcEZrO4C8o8ydg==
X-Received: by 2002:a05:600c:4fd2:b0:40b:5e56:7b47 with SMTP id o18-20020a05600c4fd200b0040b5e567b47mr2423501wmq.144.1701636602525;
        Sun, 03 Dec 2023 12:50:02 -0800 (PST)
Received: from krava ([83.240.61.149])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040b36ad5413sm12641457wmq.46.2023.12.03.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 12:50:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 3 Dec 2023 21:50:00 +0100
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
Message-ID: <ZWzp-CEYegT5ZFz2@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <20231128092850.1545199-2-jolsa@kernel.org>
 <59c3a7732d729c36c4134fc47723042e3bdafada.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c3a7732d729c36c4134fc47723042e3bdafada.camel@linux.ibm.com>

On Fri, Dec 01, 2023 at 03:36:26PM +0100, Ilya Leoshkevich wrote:
> On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> > We need to be able to skip ip address check for caller in following
> > changes. Adding checkip argument to allow that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> >  include/linux/bpf.h             |  2 +-
> >  kernel/bpf/arraymap.c           |  8 ++++----
> >  kernel/bpf/core.c               |  2 +-
> >  kernel/bpf/trampoline.c         | 12 ++++++------
> >  8 files changed, 32 insertions(+), 27 deletions(-)
> 
> [...]
> 
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -435,19 +435,21 @@ static int __bpf_arch_text_poke(void *ip, enum
> > bpf_text_poke_type t,
> >  }
> >  
> >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> > -                      void *old_addr, void *new_addr)
> > +                      void *old_addr, void *new_addr, bool checkip)
> >  {
> > -       if (!is_kernel_text((long)ip) &&
> > -           !is_bpf_text_address((long)ip))
> > -               /* BPF poking in modules is not supported */
> > -               return -EINVAL;
> > +       if (checkip) {
> > +               if (!is_kernel_text((long)ip) &&
> > +                   !is_bpf_text_address((long)ip))
> > +                       /* BPF poking in modules is not supported */
> > +                       return -EINVAL;
> >  
> > -       /*
> > -        * See emit_prologue(), for IBT builds the trampoline hook is
> > preceded
> > -        * with an ENDBR instruction.
> > -        */
> > -       if (is_endbr(*(u32 *)ip))
> > -               ip += ENDBR_INSN_SIZE;
> > +               /*
> > +                * See emit_prologue(), for IBT builds the trampoline
> > hook is preceded
> > +                * with an ENDBR instruction.
> > +                */
> > +               if (is_endbr(*(u32 *)ip))
> > +                       ip += ENDBR_INSN_SIZE;
> 
> Do we really want to skip the IP adjustment too?

the idea was that with __bpf_arch_text_poke you are aware of what you
are updating, so there's no need for extra checking

anyway this version got deprecated and I just sent v3 which is bit
different without this change

thanks,
jirka

> 
> > +       }
> >  
> >         return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
> >  }
> 
> [...]

