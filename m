Return-Path: <bpf+bounces-30098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3968CAB8D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C0B20B6D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7E6CDAC;
	Tue, 21 May 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U91SY6bN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7156B7B;
	Tue, 21 May 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286323; cv=none; b=S51CLKOXgX7BXoS/QRodvT47bXW2anzRnz6Hy1uhXlmNj1wgpkc6wUp0X9DXqvPlZiQEGR39bzCNBaeaBCatLzhs9+n5CA+62tbSBG96kdetmxKpliJgpO27gLoGDWWm6UiE0/farxELfpfM6+3jfUdG86eScp76d4ehq/t6w8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286323; c=relaxed/simple;
	bh=yYi5hNsdf/JVmDv8OJQeekda0JmzzC54uH3omBKiUME=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr1EfKIgSw+iUf4sK83I41jGIbP6tlQluG3kJ349LOgHZRpsiSV3dK1Qs/HV+gAvOxx+DQV5R99iCRnpQlqo+25R034GuaAPzC3fgeAK8jXnNie0eohRNBwoNnnFXptTWuc4VxwKuWGQrvJgAW29Etdms1Z0MBldomkipb82l6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U91SY6bN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso9519199a12.2;
        Tue, 21 May 2024 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716286321; x=1716891121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXGQUDdf+LcN9Se8hy3SDw3datb6i3o01wmR3xY+ZaE=;
        b=U91SY6bN7zE1iekQp9AYZTMIJ4GCYUq4NODLW816WeATTYMW6STyvRQCBUrDybwaO4
         Z8nNz/fKmx8qfzI3Zai1U6TFc8bYFifvtoBlXXqiIuaoAe7l38i5yT5IIeaju820XtaT
         WB2bban6pV6OJBWSQ3fgiK5fWl+w5wEsQAw5Kq7QP0pQBXqJhRemLCw1Uhal8W+cb/E3
         VFLs9qTVA87tcqmXbqvx9cx3pBkbhRej05v4UT3YfzXl79Ju6pWi1VlRK3U2CKN7L7tg
         zwJHYfV94QnuUAf6GEVK7eX3hbVOuKPeIbjkdk9G0Jh/mci8Q4AnMlN42WO35otNfsi+
         pPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286321; x=1716891121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXGQUDdf+LcN9Se8hy3SDw3datb6i3o01wmR3xY+ZaE=;
        b=f38PwsZkh91RibmV48z49CASkeHK/GFNSE7A2kJwoUi87Vo9CfUGjvzdHYi2eHyuZG
         DhM6Gqq+xsGIu01i+/hQO6/kX9hjYTToVTLbsHzK9YVE2sVsdMcctqZwtaHOFdOvcVYL
         TIwMo/yi/ehHvQ0Yxh9BBhLZJNhZyfef7UHNB9w5GUl1m/QAE6Li6iUPYkfLr6lJT+NE
         dc0uUTmCEgqfMoPQJEGRqNGlfJn8RtlgotbNrQhxZh0uHgOou6oSEh68zyBG4Q4cqysq
         k98r4YnT5fnGYCIH3X9OcdA2XIeD6DA7xCYB47IkHyVnT/lmJT8bWzsQMYmVdcQT/efY
         /EqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRj/ZoD3txuDRUxSXJnNEl+wHp+b+igQ8JHs5o54uxfkseEyzT4F8iMOaa7q/ZkYJJDNykkoLFaC4R79KowtBXirbBYIThn4a0JChrmOB9/R6FWwRYp4ughTmb0/dydubIKAocfIf5WW0DlXx8l90mQAqYe0lb3Qm9g7xSGnmeaAFhsRtbmoJ7VJQPzcF8QT5AAky7W3JQRjcRzhqJt84tj68vV5OFehq9HFYMwgz1s4KtuaQLjxOoNEZx
X-Gm-Message-State: AOJu0YxK3lxPpB/D7ifyWfWs/+GHfP1AMQfPyak6S2SDpgUPREo09NA5
	xOWFMmlUCp2Ya10AKV8Tr3DGDGsezCwebc/3YQsNDQ8jEqoCbMX5
X-Google-Smtp-Source: AGHT+IHrL4nO4dbSC1XQCh+yY9f5vG1i3rheyn4t0k3IkGU+d9ENf3sGlpgIMwS4VGw4IHpSZTUeHg==
X-Received: by 2002:a17:907:7da3:b0:a58:e3d9:e2d6 with SMTP id a640c23a62f3a-a5a2d672f76mr2679777966b.56.1716286320629;
        Tue, 21 May 2024 03:12:00 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d4bsm1581035266b.78.2024.05.21.03.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:11:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 12:11:57 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <ZkxzbSq3bS2loTJI@krava>
References: <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <20240515113525.GB6821@redhat.com>
 <0fa9634e9ac0d30d513eefe6099f5d8d354d93c1.camel@intel.com>
 <20240515154202.GE6821@redhat.com>
 <Zkp6mT2xag29dLTR@krava>
 <81afa4ccc661a1598b659958164c7a73cf211d21.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81afa4ccc661a1598b659958164c7a73cf211d21.camel@intel.com>

On Tue, May 21, 2024 at 01:31:53AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2024-05-20 at 00:18 +0200, Jiri Olsa wrote:
> > anyway I think we can fix that in another way by using the optimized
> > trampoline,
> > but returning to the user space through iret when shadow stack is detected
> > (as I did in the first version, before you adjusted it to the sysret path).
> > 
> > we need to update the return address on stack only when returning through the
> > trampoline, but we can jump to original return address directly from syscall
> > through iret.. which is slower, but with shadow stack we don't care
> > 
> > basically the only change is adding the shstk_is_enabled check to the
> > following condition in SYSCALL_DEFINE0(uretprobe):
> > 
> >         if (regs->sp != sp || shstk_is_enabled())
> >                 return regs->ax;
> 
> On the surface it sounds reasonable. Thanks.
> 
> And then I guess if tradeoffs are seen differently in the future, and we want to
> enable the fast path for shadow stack we can go with your other solution. So
> this just simply fixes things functionally without much code.

yes, if we want to enable the fast path for shadow stack in future
we'll need to remove that shstk_is_enabled and push extra frame on
shadow stack

jirka

