Return-Path: <bpf+bounces-55728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8859A85D02
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00EB8C5CD1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1F29CB2F;
	Fri, 11 Apr 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNIxoD7M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A5298CCB;
	Fri, 11 Apr 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373940; cv=none; b=acWVvPpSiCohTTQ+S/ULpCme8DnpBYdop+dS88G/ttnZxFLZFHda23LFgVVANv7QwnKFVYyIF+imFmhqM/5/y/FoR6U0X0wCFlcb/8lB7LvyzBOBnUgY9ErXkKza9Pc/SeTsPRrM5gv6+HzpPXnToRqAA7pM+od7W0XinZqSXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373940; c=relaxed/simple;
	bh=bBCc/5SB2G2nP9XTHy/btF/r2inBfRD+RuJTVqw33g0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBQqGCcTkVigse9AhGObLo2Rt1IY9XxDbA8OPj4e2QO9S9mcMff0iO29Tfk5Jxyh4rnDIFQUBAM3ezkneVzygJBr2EE46CvDAAf8tEBJ48otdMBxgfyjm6QFuQWVH0lyBDEBHoUCVW/lE/FIgKu4QB5Enl73AC8PbIovQ7bCesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNIxoD7M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so19410505e9.3;
        Fri, 11 Apr 2025 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744373937; x=1744978737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pu1oxXZehXWPC7JttBE2484d66SF6Q61uADdagJUHuI=;
        b=NNIxoD7Mxcc6sBPfOkSdy4+WBE2gcHNMDbzRkzOTdqG6RkASHcx8Pg3WZeoL90/3KC
         Ay4VxnJFXzNGrRn5lPLJLWyu2HFK0b7jtA+0o20c1bTX98vDmHTeO4a/llP9sMOAY5jV
         rQiO7jya1M3fu5HT54fJ/WbsEzVseC+TuKCjCfJZsQNASLLH25ebHge6TIGpzYJbbVpE
         gBwNwYhxrQtjIesqBQ0vwR9kG0wlo2zid5P23UX4Y+ITHdKBi8Dp6a9rJhO7fB5FHOK7
         kvlYMjXlefVmq5tkQ2SznU1zpwTgiiXW/6XcROoMGAWdoJgAM6vVpsTo8JoQq1/cW0vz
         yShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744373937; x=1744978737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu1oxXZehXWPC7JttBE2484d66SF6Q61uADdagJUHuI=;
        b=EfjsmlPxLqpCY8vOHn4jainB6TS/cMgMPZS3i9dh52TDUIVU5EkIvu41M9YTJJFPCl
         7nlydP8ekJg6RUOoPEDRb1QRRpvaA2p3c0hi56cptGA9VOA74V5itWhhiDLw+y4gNUmg
         flOflMhxd96rCuQu3Q5vtIY4RnAKTasqkkMTjr3t3cvX0dLERqRf2/Ig9kbzd+0yZAzq
         BLJYPYtQ/1ORTNDXC6rGW68z4Rdx6njBuhQTwmXp86ecB4IFphoRGMwQwAtv6SwmroI1
         Jta2pPNlz/ToONXe4ytkNYvpVh/8iu6XzEnjb7Ahf0oUkSBfMjl22hOwYnwyhWyzrkxE
         rWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxC2KapqFo0/a+vhp5Mjz06uZD/t7CHkesSPahKBCBZQ84hfF5prGGvqYPLVS8pYYO9k=@vger.kernel.org, AJvYcCVuPiTBCFxXVafn+bBQMQymWpxqnfPHQ+up5R3yda8EPfT0bMqyCuYyiEkSKqAs4cMQeduyRlaojV0+Siuk@vger.kernel.org, AJvYcCXDptf37FFgKCzgdWfJOfAN0FhD+W23L3QpB1eYblvbe+yh6KezH4+f+C69mcUzu90WV7KtVgzlp1/X2sdMt1KrwcSz@vger.kernel.org
X-Gm-Message-State: AOJu0YxptS7tNFw7WTMfCBWQnPR/Cii95jDXc5zWLRTV53woIsIe+B4S
	RINxTEjRvv7SVWVCDXLpn0Av7bjUrY/0vZC4fQzT0kw0mvdgupW5
X-Gm-Gg: ASbGncvwiUh6Ldhgt5zmDcBrQieiJaax0WccYLaZfVolY9nEmFSNNfkHxLITcTmtPE/
	LzyYdqP/l8HOzsiywe2n/BvRDhuCaL7rwtjRCe+uMLMxvVfBvVs0OIGxTUaFfclUXX0VwamPzbH
	DLnDrvrOcU9r+BTtJwkSbh+ro2vxADZv6MmFK0xn1KcHfzW+Huetbjz9Z4w21G2iH8oTgQYyd3q
	YB6LBrrNfsQry1rGvxhG0uPLv/wdQ+mRU6L1386DghtXnZ5ksKygxJgSNDYEBvcmZLRB7M/UxOn
	ZMId31nWBj8Qvx5/psa8dFnR91o3BoXh
X-Google-Smtp-Source: AGHT+IEq3b9JTW4rcXPTg3AiyHoX9fENmk2mdzah9u8WM8nNrinPQbDODoAM1caFsH+Oi46f9FS6wg==
X-Received: by 2002:a05:600c:1d8f:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43f3a9afb04mr24282235e9.30.1744373936243;
        Fri, 11 Apr 2025 05:18:56 -0700 (PDT)
Received: from krava ([2a00:102a:502c:61d:6d28:4f1c:65e0:71e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f08sm82058325e9.12.2025.04.11.05.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:18:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Apr 2025 14:18:53 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5
 instruction
Message-ID: <Z_kIre--yGIc3m6z@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320114200.14377-11-jolsa@kernel.org>
 <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>
 <Z_Ox7ibkULkJ_2Lx@krava>
 <Z_WFZT3rZtjts3u-@krava>
 <CAEf4BzZRe8qEjd1KjwV9y25QhDwkfTd7mnknLNm2pR7ArnAhMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZRe8qEjd1KjwV9y25QhDwkfTd7mnknLNm2pR7ArnAhMQ@mail.gmail.com>

On Wed, Apr 09, 2025 at 11:19:36AM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 8, 2025 at 1:22 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 01:07:26PM +0200, Jiri Olsa wrote:
> > > On Fri, Apr 04, 2025 at 01:33:11PM -0700, Andrii Nakryiko wrote:
> > > > On Thu, Mar 20, 2025 at 4:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Adding support to emulate nop5 as the original uprobe instruction.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > >
> > > > This optimization is independent from the sys_uprobe, right? Maybe
> > > > send it as a stand-alone patch and let's land it sooner?
> > >
> > > ok, will send it separately
> > >
> > > > Also, how hard would it be to do the same for other nopX instructions?
> > >
> > > will check, might be easy
> >
> > we can't do all at the moment, nop1-nop8 are fine, but uprobe won't
> > attach on nop9/10/11 due unsupported prefix.. I guess insn decode
> > would need to be updated first
> >
> > I'll send the nop5 emulation change, because of above and also I don't
> > see practical justification to emulate other nops
> >
> 
> Well, let me counter this approach: if we had nop5 emulation from the
> day one, then we could have just transparently switched USDT libraries
> to use nop5 because they would work well both before and after your
> sys_uprobe changes. But we cannot, and that WILL cause problems and
> headaches to work around that limitation.
> 
> See where I'm going with this? I understand the general "don't build
> feature unless you have a use case", but in this case it's just a
> matter of generality and common sense: we emulate nop1 and nop5, what
> reasons do we have to not emulate all the other nops? Within reason,
> of course. If it's hard to do some nopX, then it would be hard to
> justify without a specific use case. But it doesn't seem so, at least
> for nop1-nop8, so why not?
> 
> tl;dr, let's add all the nops we can emulate now, in one go, instead
> of spoon-feeding this support through the years (with lots of
> unnecessary backwards compatibility headaches associated with that
> approach).

ok, Oleg suggested similar change, I sent v2 with that

thanks,
jirka

> 
> 
> > jirka
> >
> >
> > ---
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 9194695662b2..6616cc9866cc 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -608,6 +608,21 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >                 *sr = utask->autask.saved_scratch_register;
> >         }
> >  }
> > +
> > +static bool emulate_nop_insn(struct arch_uprobe *auprobe)
> > +{
> > +       unsigned int i;
> > +
> > +       /*
> > +        * Uprobe is only allowed to be attached on nop1 through nop8. Further nop
> > +        * instructions have unsupported prefix and uprobe fails to attach on them.
> > +        */
> > +       for (i = 1; i < 9; i++) {
> > +               if (!memcmp(&auprobe->insn, x86_nops[i], i))
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> >  #else /* 32-bit: */
> >  /*
> >   * No RIP-relative addressing on 32-bit
> > @@ -621,6 +636,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> >  {
> >  }
> > +static bool emulate_nop_insn(struct arch_uprobe *auprobe)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_X86_64 */
> >
> >  struct uprobe_xol_ops {
> > @@ -840,6 +859,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >         insn_byte_t p;
> >         int i;
> >
> > +       if (emulate_nop_insn(auprobe))
> > +               goto setup;
> > +
> >         switch (opc1) {
> >         case 0xeb:      /* jmp 8 */
> >         case 0xe9:      /* jmp 32 */

