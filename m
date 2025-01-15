Return-Path: <bpf+bounces-48928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA44A124A8
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D36167698
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D72419F7;
	Wed, 15 Jan 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNlTM5wW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196711BEF9E;
	Wed, 15 Jan 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947475; cv=none; b=WWKBI2j09y769u1TlWwb1SqkUwshboXZ8mWZE1JV4XIRG7ofChLVJCuVhNtS+IxkUzW1x0sGRTs2YrciFORDPVtkAE3JV9HlfvF29ItllfjxLKicQomaMUc+J6t0ap/yYFo1OEMmcuT/qRH+MdyhJmIe0bG1hR+1Wi8LvqJnMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947475; c=relaxed/simple;
	bh=xM/06B2nrWtC+XfLoOWeWpaBcEUU7lKPev5GfHDey40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZR86g8AtabcgAL+/K2barBoFRCRliKGKLW2a3lNfI9JUVU6To6YlvpAWrl9V8bAbkaRqSh65j2XdxSR9KNoRIaaczvscpc7n9R246yV4slQaMcE4Ske5tINr0AO/t9uoCGNaJFnsaX1R7IlnXHkLnoIAX+JnCtwSnWmPEnhc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNlTM5wW; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29e5aedbebdso3446751fac.0;
        Wed, 15 Jan 2025 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736947473; x=1737552273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rACLYOKdd3vb9E+PLOLWL9v2+cDEO665+FNM19C60sM=;
        b=DNlTM5wWtG0u82EsYJfwONvy87TrF46rzhbc09mueCMWC1/+OFHC0CmU3LE0lEi4PW
         mOjT/fM7u7J0U8w1/3bBtnw+Z30z81MelPow/L5dcjOifHPMuIR/TbHkQbDWl9ksBekm
         1nmmZj1yygORdEQqseg6VfzbenVLrefo9Fx/utbG7K0Ix8eIrjk7twdgNGCB9hrskMft
         hv69uG4KXQYW123oHKtHi8IZTxHEUXHJOPQ+droiEFSFDPX1sDPrO9K2VKfb3t5O6BfP
         //fw5zC26Mv8fXrawD6lkA2KanyYa57LDDVeX8QEpLit+8nEXTRuE/sSj0Zsx5alEDWd
         HARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736947473; x=1737552273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rACLYOKdd3vb9E+PLOLWL9v2+cDEO665+FNM19C60sM=;
        b=tP+STiRhUAUVhJO4N/EMMZsmYvFOjvdPtd9J9id2g9rQPQWdtz9ZrCr7BIRwQigQjG
         O9LHMijma+OIBtzCBldxYuvO+ab1ABIVFoUPYv9XqT771W8R4OWOiyCfHfoqIeKHsYnu
         XZIpd3G0CPoMt2tWeRtIO2N7eIUwXSaNSyL3S2KuhfdXahgEj5w3pOGnNBG0Yzx4T7cC
         bP7oWvykiT6HpjUzSsUsc4FkaIjuIxqnqn79xz2Jzh2zUcskUr3mXf4jXogDuzKW07xO
         szduxbBklDetQt9nSnJlrjqTyVJ7GWePMx4erLNXBOrDCQOT+jWxulmoxHohmJdDz3Wv
         JQqA==
X-Forwarded-Encrypted: i=1; AJvYcCUKzP/H5rk9zaHjp+epYu1W/xBpX/fqTho47x0wb03aSmWw+XKYq0KMsbd4uA8tmTV0mXBrZnQC40o3@vger.kernel.org, AJvYcCUZfCTp5ZoAxWPIuVnh6niHmr1FHyyHf8gHfnvjucCw0t6Ugyt/7IOqlv6cZf6zfxhUjCvoUIXDke0D/xbPP55Rmh+q@vger.kernel.org, AJvYcCWrOwLzyeIXV7fa0OeburoWFGP+TdXGUHEKMzW4Ti4ATM8Cl/vp7UodGdCQJl+P0AP1ECZxVii9Rz1RseXz@vger.kernel.org, AJvYcCXEFxR+VZIOmqUfSS5R6lqcE0MIR12Gw3zgtjdOvb7hnXYaXTM/r2gKFR0xMMe4bl/irgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwlvqlBaTWAgRCdd3pFoKtw6u3wAO8Nnjnx1STmNqGUqpDyqN
	/BUXK/+ERnk2b98NzAjuo4UVUMr8mieE+5CEZaj/2Q9oq2DKotbJGFJneTetFdLccYfWYYuXmRN
	isgi1i7mkLLY3vrlb+dI2QTCIi5U=
X-Gm-Gg: ASbGncvzniQaXuBYsjkAouXbYuiH7850y7+ZJslvvwoN2MNyUDj2kb3NU2Ug2xThDjj
	btQ/g7JI7yCUtoky+OO8LMmEzYOnUfvO1DDb3JA==
X-Google-Smtp-Source: AGHT+IEN56TIpNLIuOjsCCyCF9AKct+bYJzWLW+51NmA05ChkL0eJQ39irdLxhQcH1Bbm/7U4JCdb/IzjBjOiFCP22A=
X-Received: by 2002:a05:6871:4008:b0:29e:63c3:3392 with SMTP id
 586e51a60fabf-2aa066a0fa0mr15489571fac.15.1736947473124; Wed, 15 Jan 2025
 05:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
In-Reply-To: <Z4eBs0-kJ3iVZjXL@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 15 Jan 2025 05:24:22 -0800
X-Gm-Features: AbW1kvbE5OjHexF7M4SoJdLcFFeEekqCNiQZvsyDbAd2dDnRKzI-AQ2Zu3MZ2y8
Message-ID: <CAHsH6Gs03iJt-ziWt5Bye_DuqCbk3TpMmgPbkYh64XBvpGaDtw@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 15, 2025 at 1:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jan 14, 2025 at 06:25:20PM +0100, Oleg Nesterov wrote:
> > On 01/14, Jiri Olsa wrote:
> > >
> > > ugh.. could we just 'disable' uretprobe trampoline when seccomp gets =
enabled?
> > > overwrite first byte with int3.. and similarly check on seccomp when =
installing
> > > uretprobe and switch to int3
> >
> > Sorry, I don't understand... What exactly we can do? Aside from checkin=
g
> > IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?
>
> I need to check more on seccomp, but I imagine we could do following:
>   - when seccomp filter is installed we could check uprobe trampoline
>     and if it's already installed we change it to int3 trampoline
>   - when uprobe trampoline is getting installed we check if there's
>     seccomp filter installed for task and we use int3 trampoline

Sounds reasonable to me.
I'm wondering how hard it is to figure out the seccomp installation
given that from what I understand it's inherited.

>
> other than that I guess we will have to add sysctl to enable uretprobe
> trampoline..

I'm wondering when one would enable/disable such sysctl.
"Give me speed but potentially crash processes I don't control"
is a curious semantic...

Eyal

>
> jirka

