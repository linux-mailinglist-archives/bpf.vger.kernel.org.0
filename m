Return-Path: <bpf+bounces-64896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C53B184B6
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA36D5A140E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAF270568;
	Fri,  1 Aug 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgvVSAGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F744690;
	Fri,  1 Aug 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061143; cv=none; b=STW5z6bxkEWH9F+xUEjD3uoF7XHDwInreL1gFKxhYq/bUcnmoaSCPiLMftqHvFAIwPYuQX/ZWbHvA4wKGlxTOJuL0/Fn9jj3F1jQtl84s4bR20lb9fN/t+AUDWUHNjbupp9SVpb7Q45ZSzvgLPsw7WX9Ch5Xsh/iS7fTECPqvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061143; c=relaxed/simple;
	bh=up37njGM55h6zlnSPBzTNA2fMrAPj9VC3rLYcGVqHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVJ/5Uph25kLWiCdoOe76v4wUcNO0//u5oohIDq4R9Gfi1kgiIJFPNwl2Xvih7syUC9F9nYM335tr/rimCxDADbEIlZOC/JDLbaT1Amr0jcBbQz8zHyvNlU9oZupA41vO0SrTzECbI50rrg15xyjlrFE8QN4fMV1nIbaZO4hMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgvVSAGQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so3158218a12.2;
        Fri, 01 Aug 2025 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754061140; x=1754665940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX57p1s+aHvjNHq+6BNN3HJIwDEa6YesJfqdZLL2vcA=;
        b=GgvVSAGQprrk2LQQ0dZPM2kaxQHhC50RI4Rw3iaL4iJRJLumIfyOLQFL53zbS7avpd
         NxZLLDRbSM6Ci36zDvcMekOaYjlUMkI1/dcOGaakbiiDXAUaAOwZ6z0a+wUrBy/1RDnS
         6bIk9iA6VzPzdTDC3yXmd3gzAf6Vqyvh7LurNBjJniQsxgKt+UfbA1UYwj2AmmM5UW16
         WTw2/S3SqfCb+xRltT3V0fODmKIZ6hARxWQKpxY3PdGbPvwMaEP8zAEHZ1OuFE7TvTqH
         tr3G/ckbF8S+jOn9ATADOzXD51oL+YI+gPolOrs4xbnd479UCO83GnqrNv0FBlbxj91U
         TN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061140; x=1754665940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX57p1s+aHvjNHq+6BNN3HJIwDEa6YesJfqdZLL2vcA=;
        b=Y1JVNc2jiy7UxllK6ewBtgbjsZ7xaE3yD1x6xuHwuvE+qzf8M1wo6lOAQ9K79E1mrV
         n1YGbMIBRsudOUmybK2spyCC1q46v8zfmBMaiDb8Ihb/p/e5i2oMdah7u2YvkwkIMKH1
         H9L3n5G2iPNC7ZK3Eo4Xoyuwi/zU8oR5wygpjaZmAw+N6cxziXST7Wei4j0s9s9d195O
         /NdwVDB+ahXvtA/7CAHbTDpCE1COL/KpZKpFOy+lfsNVePXxocoEle8vc/UMwq4Gfe3J
         5vTyDtJyCPsTxvpiQlkacYWoUFnnbUk9fjZHVmwtCXlbEG0nl6KDhkmFS8c2FbbaOxAM
         omdg==
X-Forwarded-Encrypted: i=1; AJvYcCUOXGs4VZ5Ee972XRXBkF+SEFUuTCWZw5j23VK20/RzgTIJaM5OAPe9LhOsrwgMyaGSg2jQWFdozyG1tqwFhiT+IGYM@vger.kernel.org, AJvYcCWBIiRcDiVTnaXAWpjKURk6PrP+21Dzpk4l4Y1CNC9POK3tzUO6+sKWOGoIXwE4vLThal8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/esBm5g8L9fP9ND8Kjo8pm0KJTYMVcC74xGiF8PLwuLZAW9tI
	iX5Tk+ruFdn1/yWdOiftsIgcxIQsbxCyy4ItMkXy+ndBeCRM2Uuy52ILgrYiqpMAqX1Q3nECLVo
	EqotpgukmawMt3+UBsiPwhm8FIJwCDa8=
X-Gm-Gg: ASbGncuhpWUPDepG0SxRLDu16SKEuFbioZgIekkjjZDOjxaghJgcCxG1xOMx9jP8z3I
	ntrpe/Atx2U8Nk8dZ+DvjLPuMHxEjG5E026eIABLwpJI5jZFLPGPQnn0bgTRTUXl92PcQnXf+BV
	GHbGEUu5oa7mIw5I90vYzjRVaPnbmaTEprru5UIQHnPY8DI+f9Ue6HZ6/+ODFYW9+kFJ8C/1lbP
	qpMLKobBLDCsfj6GQs8aqNfyOKSD2Mcm8Xm
X-Google-Smtp-Source: AGHT+IHwMXL4bCFWlIeW4xEjTCAGPTpPLNjiGQiRY67a8rrv6vJY77mjY27ayvHs+TQKA0LjCoYDjEF0ExxRcptdrT4=
X-Received: by 2002:a17:907:7b85:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-af94005a96cmr18419766b.27.1754061140097; Fri, 01 Aug 2025
 08:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home>
In-Reply-To: <20250801110705.373c69b4@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 08:12:08 -0700
X-Gm-Features: Ac12FXxAXaVLcHJDVLjSbuFqvBIHP6rgpMD_N7t53ru5wlGGsIp8MTsg3-UuCIA
Message-ID: <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 8:06=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 1 Aug 2025 08:02:24 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 1d2cf898e21e..480657912c96 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3788,7 +3788,7 @@ static int btf_parse_kptr(const struct btf *btf=
, struct btf_field *field,
> > >         /* If a matching btf type is found in kernel or module BTFs, =
kptr_ref
> > >          * is that BTF, otherwise it's program BTF
> > >          */
> > > -       struct btf *kptr_btf;
> > > +       struct btf *kptr_btf __free(btf_put) =3D NULL;
> >
> > Sorry I hate this __free() style.
> > It's not a simplification, but an obfuscation of code and logic.
>
> Well, it's becoming more common. But you are in control of this, so it's
> your decision. I wanted this just to get rid of the gotos in my code.

You can use it in kernel/trace/trace_output.c, of course,
but I really think it's a step back in maintainability.
All this cleanup.h is not a silver bullet. It needs to be used sparingly.

