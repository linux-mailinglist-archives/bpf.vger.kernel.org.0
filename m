Return-Path: <bpf+bounces-48881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0AA115EB
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA53A7435
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF1B665;
	Wed, 15 Jan 2025 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emVGXmg+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89254C6C;
	Wed, 15 Jan 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899763; cv=none; b=XqL/V5e3fCC9Itld8m9aOPOyRDktXmzt8Q2GAwGLaEUgNdjAANneybl0F+X5CE6iph2Cy0hC/opEtT/XFcWw3GCAU6hs6R678pz5SVGkZXt3EDhYaUVnuiqIV3+XlA2261TlQkwx2mo0pNvRef84cJzqZDn0lxKA10YBjxzc6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899763; c=relaxed/simple;
	bh=R4LJpGVyDhVAOavNQe3ojFQUK3N4ggiDzqk2LZGYoBM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=lnrngqPAb3UrkREDGR827h7JaNkZr/K9sj/g7Xf6w99E3DWBHlFJUu/4zKM8RyM2Mw71/XOZJzrq6X0s5yqTyfskPRUXsISOaWnvKrSL7vGwn42DrhC5c4VKsmsxZwNk8uG3D0StVNVL+DwAoFzrPoLZblZsqzrKvAAWLJjMvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emVGXmg+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163bd70069so111521175ad.0;
        Tue, 14 Jan 2025 16:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736899760; x=1737504560; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4LJpGVyDhVAOavNQe3ojFQUK3N4ggiDzqk2LZGYoBM=;
        b=emVGXmg+FM4hHiNtTqcUTtoxYDVUFCqiAyTYmI5sAmC9lYUsDq2yRcemOO6E0swu7D
         Y62l7aj5R6ldfl/wNBAYcjjtyD7MkG9zPQB7TfN+32fS6R+ogHCFR/ToTMKb1dLNJcYw
         Shx73RZ56Wq7nf/3hKxK34phygM553qP44boidPPaRtFYVxok2geBx4U1FwyJ2UyqE2t
         YuKPlR4xtTkkbIQ/Dr7ZfUpB2oAXJVeJ2SGJNYAw45cJcfBKWC7VFmUnWgtI+kObmXGK
         XqoWy7a7xU/hY2wU9VdINvwXTb3INMy8MlQSwSiiwAQTsdAYeA4ptFmvcNGhXyNNrpmu
         Fr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899760; x=1737504560;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4LJpGVyDhVAOavNQe3ojFQUK3N4ggiDzqk2LZGYoBM=;
        b=nYnro4vxdbIPJHDALgqepWpHZlHURN6BXsRiS7llSCEAnvmu8DH8HWHNq/WDhZQt6n
         1vbz0gCbdKY0N6aewHKsrTtSdDLGcLncX55S220uCDVFlVU0rRqonpKc/Plz4gqjWB70
         Tj42Rxwm5EBw38TwT/d8qhm2fvQj64KzPOYMONUtdj5tMjNgRntgvesDDMwuNO20jwFB
         W2feV0knBxluREidUCuiHahcVEIXfbiw1tUYUQO0Q/6sMreRWfxY9NzTKq5ELONL2noT
         LLhCUraHZJRU3Q28YZW+H0wtgtcc5WJHqfXXYOEI0/SWly+nylyDKPvKQmOSZ+IjMnwu
         dQKw==
X-Forwarded-Encrypted: i=1; AJvYcCU1dNI5V2o9leJyi/YDzmIBgI66yIQ+uDc2aV5AxegL+d/L7g5GMWaT0NTv0qmb9LT3zHY=@vger.kernel.org, AJvYcCUzEakUtLAiXkomzpaBCYOaCCiCqT0vs+cp7uleYqhQiGSYALus/Uh1LkAKOFRZHHXvFhkmsiqERp1sRbWUZeo36FCx@vger.kernel.org, AJvYcCVvL7bz3oKpi/1e/xK5zGTA/7PweXyF+QkhQnBXNVSmmab/LFTdiGh8eZL4FSdbbzfDMmB8sBTsqgZv@vger.kernel.org, AJvYcCW23sUGtdVsI7h+FtG6cP+k18BoRXXoTKpxSzwetZ0E6PHhY2jxN26T3oT/zuerwLyvd4fWIDPLS/ACWpyt@vger.kernel.org
X-Gm-Message-State: AOJu0YzUAnNc9dS+yXTiaUNDFmKp0kIXy6tfIPCWuesXALbtFHvjC4Bq
	vfWFEVj03HHUAIc41WYDwz4btFNgn+tAhWWz1M9LIO4Qcd+iUPEC
X-Gm-Gg: ASbGncueYB+E2q7xdEO0PyTnyp1+0XEXlc1YWz3+TQJJYpD9ftLGWWeDFh57RdnisTz
	Ue8VRrRvJ8miFOKca8LGjfaR2OcEaKqKU4cRwDOMQwuIXCnl3q6BHy1JqdDl1EKW9qQ1SjEibL/
	XRSrg5E72TYjovvqfZgFfpbq92CyEzsVGYUalJTSHxCQzB/QfEw6k6iO7n0Fin1zk8yTIAwPtVS
	5m+Z+4Dsx0zvTEA4WWfGF2SgppVTSNNqZAixObwU0e3DU2GNoH93DGaYwW/v8a4eqSrKiGij5s6
	nTvCQlo5G1P0fjM=
X-Google-Smtp-Source: AGHT+IEiqgHdxM6gYH9hhBM/uWuoIz75bcOmpXPjNtAo4BnRliFNNN0VJb3sez3eqgdEf4wR0RJc/A==
X-Received: by 2002:a17:902:cccb:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-21a84010cb0mr401177345ad.47.1736899759928;
        Tue, 14 Jan 2025 16:09:19 -0800 (PST)
Received: from smtpclient.apple ([2607:fb90:731b:9526:a54c:f15:5d57:d657])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f064sm71797635ad.34.2025.01.14.16.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 16:09:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Eyal Birger <eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Date: Tue, 14 Jan 2025 16:09:08 -0800
Message-Id: <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
References: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
 Sarai Aleksa <cyphar@cyphar.com>, mhiramat@kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, BPF-dev-list <bpf@vger.kernel.org>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
 tglx@linutronix.de, bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org, rafi@rbk.io,
 Shmulik Ladkani <shmulik.ladkani@gmail.com>
In-Reply-To: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: iPhone Mail (22D5040d)

Hi,

> On Jan 14, 2025, at 15:52, Andrii Nakryiko <andrii.nakryiko@gmail.com> wro=
te:
>=20
> =EF=BB=BFOn Tue, Jan 14, 2025 at 2:11=E2=80=AFPM Oleg Nesterov <oleg@redha=
t.com> wrote:
>>=20
>>> On 01/14, Andrii Nakryiko wrote:
>>>=20
>>> On Tue, Jan 14, 2025 at 12:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
>>>>=20
>>>> But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existing=

>>>> setups must know that sigreturn() should be respected...
>>>=20
>>> someday sys_uretprobe will be old as well ;) FWIW, systemd allowlisted
>>> sys_uretprobe, see [0]
>>=20
>> And I agree! ;)
>>=20
>> I mean, I'd personally prefer to do nothing and wait until userspace figu=
res
>> out that we have another "special" syscall.
>>=20
>> But can we do it? I simply do not know. Can we ignore this (valid) bug re=
port?
>>=20
>=20
> Seems wrong for kernel to try to guess whether some syscall is
> filtered by some policy or not (though maybe I'm misunderstanding the
> details and it's kernel-originated problem?). Seems like a recipe for
> more problems.
>=20
> Nothing is really fundamentally broken. Some piece of software needs
> an upgraded library to not disable the kernel's special syscall (just
> like sys_rt_sigreturn, nothing "new" here, really). Users can't do
> uprobing in such broken setups (but not in general), seems like a good
> incentive for everyone to push for the right thing here: fixed up to
> date software.

It=E2=80=99s not =E2=80=9Cusers=E2=80=9D doing the uprobing in this case.
Its software, that=E2=80=99s working fine in previous kernel versions and up=
on upgrade starts creating crashes in other processes.

IMHO demanding that other software (e.g docker) be upgraded in order to run o=
n a newer kernel is not what Linux formerly guaranteed.

Eyal
>=20
>> Oleg.
>>=20

