Return-Path: <bpf+bounces-48780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5BA1091E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540F97A4DB4
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31313CA97;
	Tue, 14 Jan 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgfX9Rkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E723242D;
	Tue, 14 Jan 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864496; cv=none; b=tuPuaCSbw6FdXYrlEUWbT0fTAW/9CB4cfnbSD5X3wFKrOAWZgZjvGszDDRL7q7qrclEe8NTiBrxCIFCE4waBll/4HnoyTVrly8VTM02PR6oODWWNZmks1p2w0jx2jbZVz281OwhvxvN/JH5qFux5+4/UzIdcIKmGqQ7pQPnqfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864496; c=relaxed/simple;
	bh=00EfIHsrsYBe7aq/PdUq9ftxfxX5dNXZYUhHKxQ+EFo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF3q2XcEWFb/a5wOkB4+G3GxfqjF8eEclzJ+BWdrIB6TmoTe3jnq06oZFNOqL16SymIhrc4geHZVKevxA+ZeXb9mrV0EeiJLfncRwJZ3W+YYCqAWDF06Ack+f9yDEKFBqT+NPggri6qfHDFx63iPPpY3LSKgFLFAwMpE1LpHjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgfX9Rkr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaedd529ba1so781670966b.1;
        Tue, 14 Jan 2025 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864492; x=1737469292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNQNqu414WMrSpKxbP1sinP09y68Mfs7GjPgsxJ4BDM=;
        b=NgfX9Rkr8X+mCZ1N7chHtjRXYI+Ep/yWClnlltxLYgCD24uekgQEYHDury02FR31AU
         HEusjGuKH12yolBwHqFDfF8r22GrBAgugYff2rBBpPwXy3pLaDpnl1ZrURMVA6eSvbC6
         COSlKVtsLiXUXLyGlLLoBn1cugNL1BaFE03iwODkTcAfYD+BelneLkiZFDHw3F7aJQky
         ABAEBOgBz3AhW3GsIAnj9WgdYECa9jeGymo3ITIa8tmsH4RMClhrcdjIblXzrOEkU5km
         tlZjh9VgakOddXJZIH192INmAGsafG4s76Ne9Kdx3FexFFZVe0G7S7aJLeAg+LCcchOP
         AyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864492; x=1737469292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNQNqu414WMrSpKxbP1sinP09y68Mfs7GjPgsxJ4BDM=;
        b=HZi1MBxTX6nMoNWnaJ9uvgNyPvzhowaE7tbSTNWpzkDDRkm7JRoVFSDruwJWcUd9qf
         4LoQCqnY2cgCVHwKQVPwNEB4oF4+cgGSCBmn/zuxkB/iLED4QjSYhdILDTEpfFBDUePz
         UySLkQKkt2yngW6DCLEoLydZP4l6lWO1DkSXE/koI4WzDFkZ+V0VZMdfzmRve/Q6suLS
         buGj1s/FeEjUGv2Q6rRHdhddcLt2+9RUAnygaWnstYoUtpGQ6IL0wCoYfw3d4N5nYDrX
         3o12oNwfjqQ7jQH0Uy5uoe43SPgvueAWkc8knjRIC6hQdRua+pkaq3H5cAQ+pnnVBbYv
         tXIw==
X-Forwarded-Encrypted: i=1; AJvYcCUmHqf76HeD75tgXdMv6jh6rCMM3xbdUeHqdgorOYNuvkTtc2h9y6Gjz8OrYRd5m6jq/cA=@vger.kernel.org, AJvYcCVyc5g7PcQly9ctFIX9LGyVckYrEOhxHgYalD7YAjnRXOwVFddFft7lJfng6BcqcCZZUyRwx2HAi6ZEV3T+T5Kglnig@vger.kernel.org, AJvYcCWzGJpd/JPd9UEfRxunmntrUuVOuLn+Te/GYaU3Hg7o5YojZLQjyQc+PfSqh7xYZj9jZRwvk6iGgDJg@vger.kernel.org, AJvYcCXWsHCkd8wnrCRc5TclsSNMuC/iGxsbbMCLeDgeQSGryQv0RdrHUelwHbySUZMUnUa9L2f5xu31Mg538Zf+@vger.kernel.org
X-Gm-Message-State: AOJu0YxBi/tE5mu238SYHI5Dcey9vGmtKAjKcH4owj91q3tAkIS5+hw2
	KWoJTd0XgEXhq+YIMhUiR8C6TWMAo8hTJmJCpAkpxSpliAHqgPjK
X-Gm-Gg: ASbGncty+cyeKCNdasTvRbAHOi3hwO8PFu3gAsE9n7D8v+HjZgGApe8Ut7eAZVLVYfp
	eCKwpPRoAIJgVuhUzta7/kn23nNR2CLG2vB3W0Euiio4ug0Hmuz+x6iYrDPSccOd1MSMntpnRIH
	2AKjQRyqWWAaoyu52FU16s2AV/QRMf38kLmMsMZQQsUUbcT+hb1/Jd6hNYx8J/n3j/Q4d+8xXkE
	mEbn8HDwJ0acXuWh6HR7KmJ0jVgS7gK7Ydg1Du071I=
X-Google-Smtp-Source: AGHT+IEad78I2WcKOKYqp2vRkb0fzHoBQtd25c/NVw6ysWwSlNKlpD1eQPWtJWGYjecU5/owPChi/Q==
X-Received: by 2002:a05:6402:3596:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d972e0b068mr55715913a12.8.1736864492488;
        Tue, 14 Jan 2025 06:21:32 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a55f9sm6116371a12.81.2025.01.14.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:21:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 15:21:29 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4Zy6W6z3ICp6SdJ@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114190521.0b69a1af64cac41106101154@kernel.org>
 <20250114112106.GC19816@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114112106.GC19816@redhat.com>

On Tue, Jan 14, 2025 at 12:21:07PM +0100, Oleg Nesterov wrote:
> On 01/14, Masami Hiramatsu wrote:
> >
> > On Tue, 14 Jan 2025 10:22:20 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
> > >  	regs->r11 = regs->flags;
> > >  	regs->cx  = regs->ip;
> > >
> > > +	/* zero rbx to signal trampoline that uretprobe syscall was executed */
> > > +	regs->bx  = 0;
> >
> > Can we just return -ENOSYS as like as other syscall instead of
> > using rbx as a side channel?
> > We can carefully check the return address is not -ERRNO when set up
> > and reserve the -ENOSYS for this use case.
> 
> Not sure I understand...
> 
> But please not that the uretprobed function can return any value
> including -ENOSYS, and this is what sys_uretprobe() has to return.

right, uretprobe syscall returns value of the uretprobed function,
so we can't use any reserved value

jirka

