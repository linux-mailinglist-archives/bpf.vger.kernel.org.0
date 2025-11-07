Return-Path: <bpf+bounces-73954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3EC4009E
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 528364EAFE3
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B12C21E4;
	Fri,  7 Nov 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BupN8VM9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC95278E63
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520926; cv=none; b=rYOThNBJ3Sl3pEU6ZOdeBGYsTmPdKNI/UgOcBxWBOQd+TD1SE7IHmnRWw0BOGAC4mSxzSq7zWlchvsOR04kMw0sdCP5qiPeFy46UB6Zt2FViNFwF0CC+Racxw/sgNyvTERcFuqd1rob4F2DGYd+/dYaeHhi01K8QHf0VAy9IV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520926; c=relaxed/simple;
	bh=OWiEd8XbPv8RdYmPKuplSxpJVZGnRYjpmY5XLgep+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9wghAN7vEWHtetF9ra7Fk6D5JnNvQUaxzQp2KqF+x5fJ0oQVyxJYjDQR0BVBx7+Hf0sma+VB8QTC8HsVVLnA0o4ls+kCnA3NYTTpI6jKV3Q/ZzI0ipNclez3KrqUs7fvwavnVDIjBSVGBJxkRSNpQBfueIF91NxqD0Eg+eTw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BupN8VM9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso549687a12.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762520923; x=1763125723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=BupN8VM9+coHpMkoRAxsJOTc5Rp4vj4FXlg+/oDipm87kfldmi9RZo4b2Ib1OXVSQb
         E2avwPk3CHm88DmnhQAv6bB2WJFQqU6BDKEdzvMfoLwAuKNpCbsiiN3DCQPUN1NRVCjh
         qa5SMJQh27m+8e1VL9EkmxPaPO3eoqVCvdfqGQAxswXjGAk2wGZTI1El88FuMAw+N1RX
         y7CrHujXk5aTA1cbkBVPZvvHKXeXc5fWp8ezWBQXzi2LEC6MG2molG4R2me7EBjYz+qd
         37ej3/IY4jqzfUZqZCfTDlIM71qH9EDqJPxhXEEobynZdXxUrlnI5xUq8r8T67mmoevH
         os+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520923; x=1763125723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=jlnMtgnZKbpTL3zzCjIOMf2AtpAZVL3Yx4g2xJuqS6HdSWo464t9OWg6mw9mlPgkzt
         UDbcvOki3K1/HB6h/hF/IMJm27Jo6e1zc84l5qjIsIgaKJwroFNS1EhY6uuzP8sCIhIL
         dEDBz0lPdzDWwHXZAc3Ie2TXOVs2wAqkXUBOYXwwMMuZINQ6E6Yxu7pTIUQ2LzPRqnSO
         9FwlBUHpn67kCV6Z/Zd5v4h+/AJdB0WNrG/fn3ITIvJXhqQ4z8i0wvKGSe9wPMeGOCr+
         gLTC43Mc3KjK/Y6qzQhzKU7ArffHCWDcnW7YiL2uXiYoc5U0UcCucf50EJFJQTGf48ZA
         GS2g==
X-Forwarded-Encrypted: i=1; AJvYcCUkqHXedgzWzRo+M5dkeDkxv5KcHcc6pHBaOiK8w/U+Zi5OgjAbNkI7dIa8W+2/H8otq/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eqsX/sDwHj44tTclLZvrZx7XFXH59+cbKpiq9ZG5qib3VdjA
	+V5Foh9knnrGVEC0OuZNtNVTFnD/TQ471vMMSBKvSBk1Xp8xSyLYy6+R+LG6hw04qFS5maGp8zf
	iw1XY
X-Gm-Gg: ASbGncsekpVP7hJgz4co31yQjgg7FnxJ0vRuOu/NmYOD5AJATa3bgqLB/5HMPmsUNAh
	gezoRkus24r7kL7V1YzxUJUKJhiPOweqHvXgRtuqIY/kwbhkb3Dtr/x+pjmO9U2SD9l9E+oq4Yl
	pf/66r0fjIMKHBfX0+WhRNX3ytB5MrTWitVqwkH7ANjYfk7iIuFSjLszjKj7mGLRGiCFzM7vV/O
	f3IbTXC2SQzchNSXyUzc6FARBMMLpcfH2IGz3t4Xics5Ymnywbqzamn8/QFCTp7osJDXl4ysVuU
	dQUwfdZE67qH0qO0Qbj0oTB1UcCrJbjhRtol+mD0ueCtnir1QlNVfGdzXUcg0amMUazsZuj6HjA
	48AHmZlpVyEAlqKDJOplIL5zzYYaAdv1cboDqKdejT1DzwQ62wenluuw437znr6tNGH/XOfpcZg
	ZQ5dvag+CF39CLng==
X-Google-Smtp-Source: AGHT+IEouSTBDMcG/tchDfHpDvHcGOn021q8OTyah/7d7vm3vufHhiqKNCiTpyQWqwWHE044VaVj4Q==
X-Received: by 2002:a05:6402:90a:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6413f061d7fmr2900743a12.24.1762520923128;
        Fri, 07 Nov 2025 05:08:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f71394csm3968988a12.6.2025.11.07.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:08:42 -0800 (PST)
Date: Fri, 7 Nov 2025 14:08:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-modules@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in
 bpf_address_lookup()
Message-ID: <aQ3vWIqG31BgE4YD@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-4-pmladek@suse.com>
 <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>

On Wed 2025-11-05 18:53:23, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 6:24 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Make bpf_address_lookup() compatible with module_address_lookup()
> > and clear the pointer to @modbuildid together with @modname.
> >
> > It is not strictly needed because __sprint_symbol() reads @modbuildid
> > only when @modname is set. But better be on the safe side and make
> > the API more safe.
> >
> > Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/filter.h | 15 +++++++++++----
> >  kernel/kallsyms.c      |  4 ++--
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f5c859b8131a..b7b95840250a 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         int ret = __bpf_address_lookup(addr, size, off, sym);
> >
> > -       if (ret && modname)
> > -               *modname = NULL;
> > +       if (ret) {
> > +               if (modname)
> > +                       *modname = NULL;
> > +               if (modbuildid)
> > +                       *modbuildid = NULL;
> > +       }
> > +
> >         return ret;
> >  }
> >
> > @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         return 0;
> >  }
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 9455e3bb07fc..efb12b077220 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
> >         ret = module_address_lookup(addr, symbolsize, offset,
> >                                     modname, modbuildid, namebuf);
> >         if (!ret)
> > -               ret = bpf_address_lookup(addr, symbolsize,
> > -                                        offset, modname, namebuf);
> > +               ret = bpf_address_lookup(addr, symbolsize, offset,
> > +                                        modname, modbuildid, namebuf);
> 
> The initial bpf_address_lookup() 8 years ago was trying
> to copy paste args and style of kallsyms_lookup().
> It was odd back then. This change is doubling down on the wrong thing.
> It's really odd to pass a pointer into bpf_address_lookup()
> so it zero initializes it.
> bpf ksyms are in the core kernel. They're never in modules.
> Just call __bpf_address_lookup() here and remove the wrapper.

I agree that it is ugly. It would make sense to initialize the
pointers in kallsyms_lookup_buildid and call there
__bpf_address_lookup() variant. Something like:

static int kallsyms_lookup_buildid(unsigned long addr,
			unsigned long *symbolsize,
			unsigned long *offset, char **modname,
			const unsigned char **modbuildid, char *namebuf)
{
	int ret;

	if (modname)
		*modname = NULL;
	if (modbuildid)
		*modbuildid = NULL;
	namebuf[0] = 0;
[...]
	if (!ret)
		ret = __bpf_address_lookup(addr, symbolsize, offset, namebuf);

}

As a result bpf_address_lookup() won't have any caller.
And __bpf_address_lookup() would have two callers.

It would make sense to remove bpf_address_lookup() and
rename __bpf_address_lookup() to bpf_address_lookup().

How does that sound?
Would you prefer to do this in one patch or in two steps, please?

Best Regards,
Petr

