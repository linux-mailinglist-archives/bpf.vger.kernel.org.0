Return-Path: <bpf+bounces-30271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5C8CBD58
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7461C20D6E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE838003B;
	Wed, 22 May 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brEPUscw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E646522;
	Wed, 22 May 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368124; cv=none; b=qZ+Wk+smrqjkkwkv9GK9Eic/YkVG06aX5TJqRncgVQEP5D/jq4CL0mDCimk7tcJLgyoMGIytxmU+XAyk27xHeafF3wqVJ74eG7CGZfXaF6ntIdSGXfl0FC0XR+JOGmXWrDau5OUT2anadxCq/9yBC6ndBYKIFd1mcZzplNJaxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368124; c=relaxed/simple;
	bh=5MbnzzSEIr8suB+6SA9cqi6nf2bLYWxzZ9I6mZm6lQw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrVNF9oYReIapy9Azrqo2unv5kYzaRW7RfIZBPXiRlIPxEccYX0Rk6c3qgpR1quVEAuiPxRAUbQvnGNNUEPAD2k36d76E59L8BUFofz3sKpFPwi0ZPNnICCtYmNg8/oyooRAfBuFrxuuuejc16B3sepgMXYL2Y/luX60jbpibzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brEPUscw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1150588a12.0;
        Wed, 22 May 2024 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368121; x=1716972921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZsKIVJXsn0LOYaTET+hKEKwlMg9X9Tb+9iNScZ+Rm2U=;
        b=brEPUscw78aeSsPckUzHKsGSuBaCRPWcvzg7ziIU6oC+OGXnkALvxaq3TQpHknjdYc
         gE2aTcTuOP0LNXCfMshFETJL1dlwvD4/gHJMGRw8GfxiVC+tj0ctNwNfguTqsXUkOcyC
         l3fW7xX9xFIXGzI2mWC+9MlDuIBWVd28G0ThXopYuj3WcZOk8bhyBN/DvM+AE2uaYuiX
         QLoycEHSQo/QPOyJwLqfmZi0ain7TDhoKvSYFX583Wt1Fn/wu+PHyK+bGGkc6DZOUBfr
         mYfK1+FNyoxBueY3aJnSeg+Tcz6Ldg/ywRlqg/nIFj9B+3UqxLUXSCSUUp/SW6Mznk8a
         Pt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368121; x=1716972921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsKIVJXsn0LOYaTET+hKEKwlMg9X9Tb+9iNScZ+Rm2U=;
        b=oBoba0S883S/vnFuu4gDhL3yPmv5kjQFpAqY8ySEbu/nWbWCSbj+R+u2w0/pfg5YgG
         1ABu2DU+z1atPsS1BDMZ/kLpL0TpUGP5Z/V07X/P5P6LcizXg5a2BXE8nzdK5MBPL6ay
         zWsGNoj1hLn1gTMix3nUMtnnZeKO5BLTIvnkR2jC+52dvFeh4MJbQAVmJ9jWaE6WKJPB
         TZtWGbMJ3Lf35VgJ7DZ+4SeuunanrjbvRqs+OFl1E7UZwxNPA9bL1cA9r+zqTBRiRMAW
         GxssvFYtv6GuQZ22F//IUJ8mz012Q9hKW69aqSOa5ZT+/+LCgiE8a/8X7ODZ/2xcrj1Q
         w6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzxguAMLzhPkb4+Ek6muLBIMjkI2rFBnaERRoa5wWlewXzZUzGA6ytspr+32cRIUs9Qi3KOIj0ogeTP0pJH66ms4NmqaEbg7vKFTtpG3Mc1CQ2S/50i83G7/7stRKGA3atEC8yl7LLlk/YjqfRVlAobdSTu24qm5W/U4jWW2NXKy8PvplIY/TqeFXqn4k9vMb8c99HzJXT9XNlpCC4MoaonBAyTaabgAxVICykfmx2KgZBnAZGzzSNkFh
X-Gm-Message-State: AOJu0YxxZQisqubVm1llOUBOMSNkmwDWGAPV17i4HBlMuNeHEUfyVyBD
	IfcAIz61It8Dgew26fYNnjrQNRy7SXy03quZN1Rqqbyev7BZYBhN
X-Google-Smtp-Source: AGHT+IGglvHN3H2cK8ueaZOg82/YsEcPTFpr4/QkUF0qp/x5ObIxq6iuHLnuXNRCHJ2cMG/cJT/iRw==
X-Received: by 2002:a50:8d5e:0:b0:572:2fdf:b965 with SMTP id 4fb4d7f45d1cf-5752b432b79mr11104430a12.7.1716368120602;
        Wed, 22 May 2024 01:55:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65b5sm18240841a12.6.2024.05.22.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:55:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 May 2024 10:55:17 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Deepak Gupta <debug@rivosinc.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-man <linux-man@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
Message-ID: <Zk2y9XMZfLtys1GB@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
 <CAADnVQ+2Q1992e9mRtWOavHfqKsFUxPp4f6MAAJg90TK_KTpew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+2Q1992e9mRtWOavHfqKsFUxPp4f6MAAJg90TK_KTpew@mail.gmail.com>

On Tue, May 21, 2024 at 01:57:33PM -0700, Alexei Starovoitov wrote:
> On Tue, May 21, 2024 at 1:49 PM Deepak Gupta <debug@rivosinc.com> wrote:
> >
> > On Tue, May 21, 2024 at 12:48:16PM +0200, Jiri Olsa wrote:
> > >hi,
> > >as part of the effort on speeding up the uprobes [0] coming with
> > >return uprobe optimization by using syscall instead of the trap
> > >on the uretprobe trampoline.
> >
> > I understand this provides an optimization on x86. I believe primary reason
> > is syscall is straight-line microcode and short sequence while trap delivery
> > still does all the GDT / IDT and segmentation checks and it makes delivery
> > of the trap slow.
> >
> > So doing syscall improves that. Although it seems x86 is going to get rid of
> > that as part of FRED [1, 2]. And linux kernel support for FRED is already upstream [2].
> > So I am imagining x86 hardware already exists with FRED support.
> >
> > On other architectures, I believe trap delivery for breakpoint instruction
> > is same as syscall instruction.
> >
> > Given that x86 trap delivery is pretty much going following the suit here and
> > intend to make trap delivery cost similar to syscall delivery.
> >
> > Sorry for being buzzkill here but ...
> > Is it worth introducing this syscall which otherwise has no use on other arches
> > and x86 (and x86 kernel) has already taken steps to match trap delivery latency with
> > syscall latency would have similar cost?
> >
> > Did you do any study of this on FRED enabled x86 CPUs?

nope.. interesting, will check, thanks

> 
> afaik CPUs with FRED do not exist on the market and it's
> not clear when they will be available.
> And when they finally will be on the shelves
> the overhead of FRED vs int3 would still have to be measured.
> int3 with FRED might still be higher than syscall with FRED.

+1, also it's not really a complicated change and the wiring of the
new syscall to uretprobe is really simple and we could go back to int3
with just one single patch if we see no longer any benefit to it,
but at the moment it provides speed up

jirka

> 
> >
> > [1] - https://www.intel.com/content/www/us/en/content-details/780121/flexible-return-and-event-delivery-fred-specification.html
> > [2] - https://docs.kernel.org/arch/x86/x86_64/fred.html
> >
> > >
> > >The speed up depends on instruction type that uprobe is installed
> > >and depends on specific HW type, please check patch 1 for details.
> > >

