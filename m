Return-Path: <bpf+bounces-67774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8EB498B1
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D071BC65A3
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500231C58B;
	Mon,  8 Sep 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEQqij74"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165831CA49
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357292; cv=none; b=BH0mimfFYy/hHiEtYTM3SxjSc2Urgg0JIX8pmp1gKCtCzEBO/gAk+acVYbz+LfXmfguwVTmGwfnYYbEyPbFPCEbLOucobGhcIqNTbu3YTMExTlZd5DdJdyZ6x+eEd2ot97wM4ZQhV5CsTTtUHZBTUvzvV+i+2tuP6xnPAKFT+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357292; c=relaxed/simple;
	bh=Yly41sWEb2egTAtvYnpDTU2argjXR8E+ZxmkAUOJ1b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh5ipNknmHzU8o/0gAOSKmAWnLEWBxhkwv0gp9xNZt+6DUNefluecqDQTlOsyHQBQoQqhV5+sJ526OxVl7CKPe1QtZCdMsYq8qDGVyNAIebfcvxWWYYJgKw4gb01CsEh4RbUybAj27fbBQmdQakhkjiQctxMm7VanEX5IWfSEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEQqij74; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d19699240dso3479153f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357289; x=1757962089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPWFZ0d+4Py+Q5uQ+UKiKbmIWrJW0WaMz5yAABaXFg0=;
        b=iEQqij74jDjwmeYzLrMZS2gxMbN51I7wRzG09kzZtG62huPljWEf4qmmx8doklUOAa
         Fm6EGH6BN50iW2Q0vWO6gXbEXEAkQZxm5X+MTjV90TU7rc8FCakYhjueBOIKJJiMZlr3
         LyB8sy6J4Mk8MNF1WMZcca7lbnlMz4sASGdeAOFjRDc5o953+ty3WRdbsw+hpJRoCOdb
         kNIGUNwniOKbpiPMIukwRBl/7B/kcS5gpLlgfNbR5fWEeZ7tkxOfU6YiorHNpvwLXyCr
         +iwpNemJAkIGZ5H5OP3nfHPR5j0qgI1OOcrqkvOoLf6v9m0Fl0ODTbCGmxuHZ89RN0pC
         13sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357289; x=1757962089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPWFZ0d+4Py+Q5uQ+UKiKbmIWrJW0WaMz5yAABaXFg0=;
        b=IatP8iOzsnRV5ZpB1isZ4gS+WlbWlnwVDjWtWAdBOkyNxPhvSQ8QPKwMhE+mRwp/ab
         mGCwW93jbmbUePWLn8nDtZbE+qUNldcgqhBzUOka76OeHQ5bBmyXnZMDaNQI/Z86ZWE1
         0W+jJJTiOwjupaubD3Kcvtdf0GirMWAv7tV1Esa+dJJ6qUOy5YUhEGcD+weW+hmbvWeA
         /Y3IzaB4/aLtIHrEiSEQBAwBOIvDyvTRChfuQ8nIRx/dwpNONkquy7IHQbdO34cdp+iQ
         T4yUTXS2H2/yELqZZcCreXu0jnRjA/dGUUabyhTQlrv4iA0ZzScI0rnlj32YqLrKRnN6
         lmFg==
X-Forwarded-Encrypted: i=1; AJvYcCVpk4VKw+toIodEfYoKI5Ji28jPKo2S/zn7Jayck01Hm2CHbMxXvnmqKaqr5hT9nqi5xFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqT7pEwqBghkdvThC9M/m+2RZbf76hgfS3J/J4Ett7lEUAMC8I
	7e9NrPKaPwHCXLUja4ZOYR/mBkuEIRTiI5VLkJVUKwTqH75XPJ+TTIEAbilRgL5PRlkz/Ih7oot
	9BitJr18NX8Ul2XxkCiDDK1Y9nWxiMkg=
X-Gm-Gg: ASbGncsB8OVGRiLr/VntGKgCol7JZKMg9zHax3ibJCiKfdECwheB1COq7epP9qVOrpm
	QZg8c1bExsIAv14FkFMZ5zlFkqXdJBUOqGPQV9G2Crlan0DPInAncat4DQzkBC8hj+fEQTghjZa
	0sei5Pn4A59IYRJ8zMkWeIrtdeBoLdtwisJHJEbhzWTJsv7BtE0NT3M0mI2nhG5alcejBOwX9Hb
	/MJc3rXGFNDf7KK6heC2MkNbMDP/qeF2d4I
X-Google-Smtp-Source: AGHT+IESdUg4AidlfEGBzVeoU+W9Tw/ovq8Iw39OBnbDHTQYJrrKjkQ0ufM6V3UHc+T9fgrtubD7mX0NDSGESJXOlOo=
X-Received: by 2002:a05:6000:240b:b0:3df:9ba8:21a3 with SMTP id
 ffacd0b85a97d-3e629b4421bmr6529989f8f.18.1757357288901; Mon, 08 Sep 2025
 11:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908163638.23150-1-puranjay@kernel.org> <20250908163638.23150-6-puranjay@kernel.org>
In-Reply-To: <20250908163638.23150-6-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 11:47:57 -0700
X-Gm-Features: AS18NWBXhz1K0f6uCBVVdb1wszN1zpWPRXZQ05TQ5QtPdSKoyGbFnNnaAUQ_Df8
Message-ID: <CAADnVQK-_UHYNr-ykdOaKF-c3EKck3F2m2sS39TGzyuxMDxHaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add tests for arena fault reporting
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:37=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> +int stream_arena_write_fault(void *ctx)
> +{
> +       struct bpf_arena *ptr =3D (void *)&arena;
> +       u64 user_vm_start;
> +
> +       /* Prevent GCC bounds warning: casting &arena to struct bpf_arena=
 *
> +        * triggers bounds checking since the map definition is smaller t=
han struct
> +        * bpf_arena. barrier_var() makes the pointer opaque to GCC, prev=
enting the
> +        * bounds analysis
> +        */
> +       barrier_var(ptr);
> +       user_vm_start =3D  ptr->user_vm_start;

nit: Too many spaces.

