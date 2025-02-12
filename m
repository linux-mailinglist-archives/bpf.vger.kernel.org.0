Return-Path: <bpf+bounces-51222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7BA31F78
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5551644D6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977631FDE29;
	Wed, 12 Feb 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwKEJbz1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99172146A68;
	Wed, 12 Feb 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343048; cv=none; b=GPyzPLNsIJ3qVTRWmfj4ji2QWry2XrIHfRgDyUdIwLXSYWbiySjRCm2mh2lfVOlKc5Ujb25mqvAvLQOiA8h1+JATwVjDWGrIbFupzXTxDi64F3mBk68S1p38FWYnnwtGtizAoXwlFh0OGw5+ehuFRMOd9D6s96bsBuwo7qtsz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343048; c=relaxed/simple;
	bh=R8pIttXenMn7iTlampJ6LXPNSmuNn071Fr3gaT1wJW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H19Drkrg8IUuYu652/aThLxjYWBVMDIkIkzW6z7en72bbgHTOHOEvYkym0EjMUjHEwVbB5YmbS0NjsDHA2Dd5xRrFzVYe2PNufFSVlygeADmNy9vNpF8msRBraGU++SqfmMazqer/qspFRrS5Wc0/JwE5LH9oLRoRu0l0JveELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwKEJbz1; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e589c258663so6899264276.1;
        Tue, 11 Feb 2025 22:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739343045; x=1739947845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8pIttXenMn7iTlampJ6LXPNSmuNn071Fr3gaT1wJW0=;
        b=RwKEJbz1O2Ipxn6xvMM7mtI3/+UV48Eh0vhvnYfgQ3+i/OWtWrdyVAcYjSBBovrDY2
         aUV5B7K69X1wMWIAWcdhblvLJ7mp34ZrdLOJXlfsn+q3qD+xfSLaErTIetjW/zRN4ZaZ
         kaWJ1dCQXsTFgbj/LHaKl3M2FHFlgBoG3roHhrK1+KkGGgZsl9Vek/Gae3bTvzMDdH0d
         Qo+93qHm513Wqdog3iRKF59CjxJ08APZt1JgcDQIepEN9PhZkuwdjeBWU4V9zCbhe4d/
         1NPrHTupYMO2BR+SCzNKafXt5a4eUUFkdLj12IRmz5qxABfvdSG0TuxFuHVI/Mzll+OV
         YBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343045; x=1739947845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8pIttXenMn7iTlampJ6LXPNSmuNn071Fr3gaT1wJW0=;
        b=SfSn2/1VLrk04uIDv++MoCuiyLEmiDD+G1CYMBnB6hzE0JM4Yt6Mmz5BCF3FNm8k9o
         JRLWtgpAsXuWCOdxxbd1Has9FAfUBx5Zzhzf2s/THOVl/C8eGkP2HKhCHm39m86UjblT
         ssP642OOySmBaGx+2q7XCxnrX1ugUgMMWcb4IFYkX9Vq0F5EBMyfk+o1y09HTaKQjCpd
         7G1IC/4sOcH1WEUxe+zm9c/lHYv17inoWvbyPSLiHKm+o8bwxhaJCNqYZETI2BPYjorl
         5lSCmQufNXNZO5AcxNVEfORuJBxjYoMC5KmVCkJxFXcsbyXRDAUvxSbOXNr834AF7ynr
         5mkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5WtI0Vkp8QkkZZjXo3sg1mSp6XMxXPu0Rul/4gepmzWiCgX9Ua0vTQPrD5KWmUDS+pyoh5BlFo+xXCncb/dOQKh4x@vger.kernel.org, AJvYcCUMZPkwV1woUq3I5pE8ruSJCQTcmCGat9M9owIGsC4kAHgQTY7FTV0whRFDNaXQN5Kmabg=@vger.kernel.org, AJvYcCXJn9meZS4LAqywlXePznz7ZAFz4RKgGtCIu7Mtq5eia6uRNkhYPGo0SrVeuPygeEvt2fUyRTViLDMAuex1@vger.kernel.org
X-Gm-Message-State: AOJu0YxauAhSbDNYN3OgLkBDslbStdOvqlZxxRDUnkRTBXrgraC8Eyb6
	aQSyJ1k7q+YIhAOgH9tlLC9IN6IdM5jUORk+82T1o8j1cbmt2El7rKxEhOYiOlLRqkyy7dbd+ml
	i0ofrFc+EnRfWryabqOrTQ2hSQo0=
X-Gm-Gg: ASbGnct8vvXKUHfskAZXKt6V9wR0EffP0ZBi1E77Hj5MevwUGgVsYbIrmG4zJWcoJ+w
	7hOzmSfn0u9kV84HaXYezTaEyn9mzhTFDuQW0JPQxJ9KT48B8FVEGascKX33vLoAC5VjpTkRH
X-Google-Smtp-Source: AGHT+IHqv5DsEiQvLDynsgRjnDoQlnnEq9Aa+3yv9dup4mcV6bVTxrkdRR/kv757DtYZ2qjPy587yVhC9Ido1MMNUn8=
X-Received: by 2002:a05:6902:1618:b0:e5b:3de2:cead with SMTP id
 3f1490d57ef6-e5d9f179f21mr2209894276.34.1739343045146; Tue, 11 Feb 2025
 22:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210104034.146273-1-dongml2@chinatelecom.cn>
 <20250210180528.01118537@gandalf.local.home> <CADxym3YzTc8wyAndNP4OpK8JSLWkpCAMgJox49ioUBXrov1h=w@mail.gmail.com>
 <20250211112413.4c43a9ca@gandalf.local.home>
In-Reply-To: <20250211112413.4c43a9ca@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 12 Feb 2025 14:49:33 +0800
X-Gm-Features: AWEUYZluqXA7qte-RxqrP7PeGuBefghFWc2vtTzom1EOtmrmBcyDAGU25hHmgDA
Message-ID: <CADxym3a2QcujvvmVgWv9OvJXn=SGVeFN2zSPEQAmFkk2SH2iNA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86: add function metadata support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alexei.starovoitov@gmail.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, dongml2@chinatelecom.cn, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 11 Feb 2025 20:03:38 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
>
> >
> > Another beneficiary can be ftrace. For now, all the kernel functions th=
at
> > are enabled by dynamic ftrace will be added to a filter hash. And hash
> > lookup will happen when then traced functions are called, which has an
> > impact on the performance, see
> > __ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function me=
tadata
> > support, we can store the information that if the ftrace ops is enabled=
 on the
> > kernel function to the metadata.
>
> Note, ftrace only uses ftrace_ops_list if there's more than one callback
> attached to the same function. Otherwise it calls directly to a single
> trampoline, and is rather efficient. No meta data needed.

Sorry that the log didn't describe it accurately, the multi callback
case is just what I meant. I'm not sure if it is suitable for such a
case, so let me just remove this part from the commit log, and
let's see it later :/

>
> > > Arm64 and other archs add meta data before the functions too. Can we =
have
> > > an effort to perhaps share these methods?
> >
> > I have not done research on arm64 yet. AFAIK, arm64 insn is 16-bytes al=
igned,
> > so the way we process can be a little different here, as making kernel =
function
> > non 16-bytes aligned can have a huge influence.
>
> Arm64 already uses the meta data before every function. That's where it
> stores a pointer to the ftrace_ops. So in ftrace, when there's a single
> callback attached to a function in arm64, it jumps to a ftrace trampoline=
,
> that will reference the function's meta data to find the ftrace_ops to us=
e
> for that callback.
>
> If more than one callback is attached to the same function, then it acts
> just like x86 and does the loop.

Thank you for your explanation. It seems that it is quite
simple to implement the function meta data in arm64. Let
me dig it deeper on arm64, and I'll implement it together
with x86 in the next version if it is possible.

Thanks!
Menglong Dong

>
> -- Steve

