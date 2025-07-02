Return-Path: <bpf+bounces-62169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240FAF6000
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BD44409E8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0A30114E;
	Wed,  2 Jul 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADB7XUmX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A6253351
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477351; cv=none; b=TCkhqQyRqR4z/suqSMwAPNaqBtKqBEcBCH+PT73oDb1LccahUSq0cZAVX43HOcOaqBt3za7NaSkAL8FJyt87+q86rE5NbCGXGibTI0vWfDnH8/dxY1cuTPZHTQqvVtFaIOX5blVMRyVuMC6afQRg4gSvYSQrCYWEphdTWZAitTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477351; c=relaxed/simple;
	bh=1F1UkZml9Ow+WwL7msmjBl/ZugBx5sT20lzdU+oMfzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIxPyRdALDOzeNYS/3mYcjD5PgeZl0vYx0HdzSmF09nNDAgV93AMj3nnqGZNR0lP34JXQLzAAbgCWUcj3XRGuF4LaH44veXYRLub57hsmnMeZ3ONbNpwPQQYmXdNKYH9NWHZYhNo9n6cBEyPFg8lKuOLNJmD99BjkYTzjyu9fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADB7XUmX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so5057152b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477350; x=1752082150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F1UkZml9Ow+WwL7msmjBl/ZugBx5sT20lzdU+oMfzw=;
        b=ADB7XUmXHAxeu/l+PaPSCo6EIOp+oDoD4DC9DUKmOoB8inQYb8H5li04py8MRkqu9J
         lqtzq+smGwQNNGJM79r8oQB1wVqrCKbAViU2js0QoEmu0aHDso6JkyMGMbLExM51S85R
         CI4oxjRI/UxUiTcShRckmXEtcotSmUHzQbXZTYJHcB0qynV558ZaQjwfJoHnR/ywM9Jd
         4c3626hFmD3Lvrsms/zInbRlCn4nLto1T3ApNBhb5u+D6GfCI0edXyBZUokPg9AZ3M7E
         Vx89/+mwbWee7XuihozcdDymz9Kg9VvQy983hWGinxSjXgi6TAdQ+CsPG0q6OWE4TqpU
         V9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477350; x=1752082150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F1UkZml9Ow+WwL7msmjBl/ZugBx5sT20lzdU+oMfzw=;
        b=tzQJWOC23cI/KT3TRc7Hj9lkdXKFNtmHzgbd+h42U2vdwpMTA6kkYszXPVlYAT8oOv
         +ND5bvI0qDY2+fFABCMVE4l25AZkDMtdKARjviaqfARc9L6HXH3f4f+/3tTwFrNldneC
         8UW3NgD9+SQmNus9hn2FTQ9XzzSXl7zVuPuilid8MPo/7sN+CaYdC1QRLTZjha6HabTU
         y5RuzFs2VmKVCWBJtH7nAP3eKOlpo0rcYSV9HfttTGpyV+/uQZdzjaUgJz1oBRUnfV/H
         DilKoOvswahuIMXr/eHW8ylSfcyxQXnVjCmFYwU1K1TSqbEgzHum+phkfp9hHYztewng
         TW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQXwwTeifsohUPRW+x+8mkKVFpelpxNBqsj62qNF3I8WZ4xt40P7F9xaVXo1Q2/h+sixg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCk/lHXV4uL3+MAeQnpiBzLS22mb7rFXNczsA77CYExc4Cc7h
	9RvJHEVp+30kbDsLgpaPBjFjV1Q/AZ84xWHSmu/LssgcmSwlYnf4MmFDoit5x/J2mg8jSW/dzz7
	aRTGK1PUu9kJzW+6GLxYiGc6lkAXsE6E=
X-Gm-Gg: ASbGncv1Koe/Znx8i+4IYN5fwvt12PMmTW/Z0YWiRLfAcnyZ/IvwLjj9IeQ15zJ+g/T
	hRe765vZbtsHsEZaI8rNnXb71WEtEWK0VIuOsDTLUSnWj8Hm4bAatYL4EyGnFrvGH103tiXj211
	yRbnpxHVGuaJv5kPTcO8FbrXyNnHP/wN1QeG9CwxFxHsEZE0YmOoV3KGYUFGw=
X-Google-Smtp-Source: AGHT+IEwCO1piEp8TvzttVBwNGS5VehUeZb4SfDTSaYCElX6bCQ4Be7kV0Satw16ugkryMKionmP63GmT82C0ZgVVMs=
X-Received: by 2002:a05:6a00:10d3:b0:748:f1ba:9afe with SMTP id
 d2e1a72fcca58-74c997fd328mr564025b3a.4.1751477349578; Wed, 02 Jul 2025
 10:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630133524.364236-1-vmalik@redhat.com> <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com> <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
 <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com> <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
 <45fa8528ac315388469aa448d9c5081783924b18.camel@gmail.com>
In-Reply-To: <45fa8528ac315388469aa448d9c5081783924b18.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Jul 2025 10:28:57 -0700
X-Gm-Features: Ac12FXyqYxTT4RhAb-2Q02h5fIhO34hK2XhWse2lrst0K8tC2QNyy_zcSxK-vJk
Message-ID: <CAEf4Bzah-MAPsk7RgSNXH01Tw4QrO6E1A2Rz7VhZf2A7PS5SNg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-07-01 at 14:07 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > we should be getting rid of all those __ksym __weak kfunc
> > redefinitions because they now should come from vmlinux.h, not add
> > more of that, IMO.
>
> Tbh, I'm not sure this matters much. Kfunc signatures don't change
> often (don't remember it ever happen), so having prototypes here and
> there in selftests shouldn't be a maintenance burden.

Ok, if I'm the only one who thinks we shouldn't duplicate kfunc
definitions because we have an established approach that works, so be
it, not such a big deal.

I'm curious to see if the next step would be someone asking to do
something about enum or struct that is defined only with some kernel
configuration that selftest relies on. Are we going to add extra
#defines just to be able to do #ifndef-#define-#endif guarding in
selftest source code just to accommodate someone wanting to build BPF
selftests, but not wanting to follow prescribed build setup? Or start
adding feature detection in Makefile and exclude some tests from being
built? Will that start to be a maintenance burden?

I guess I just don't understand the direction here.

