Return-Path: <bpf+bounces-41275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807F99562A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4191C1F26632
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560820CCDC;
	Tue,  8 Oct 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0ULsd7z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BA20CCDF
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410747; cv=none; b=R1BGUCbNW8LPPdJv3dxl/qULd/1UNNqaMSclcnXSUrSWxpfwJRYZRkbvtSKQOgXWYNR88GbeRyk87DU0MHkJ4UwBt2D/HIUrIOp3OLkkCcG8NFq7W0RDXp5pd7IwBOtc67/wp8W3j4wV5nT94sunmrB9szJhtNhWI6Xp5TNjJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410747; c=relaxed/simple;
	bh=5jnrWiF88k5I9mEvkkTZ/M8EPG4BVGPiOHqtxpZAdK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odhkUP2s1Rt4B06tpiKuyPRjeBsyM29r3lGjXVnDMprAhW/ZC2K508Sra4ozw1Hzr8rzNCzOaNc6jiI2oxs2avsnsMT3SePH/clkLQZcmuUtHEPKftbqWxEoOpyW2ZHa0/YZQcaIy2ws0NUiPh8Y9bxKIzgIHt3/gtvijZgmhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0ULsd7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSBrsBHX+bOF/xalnqFlbySfgWCG2J84KmNwiiijxt0=;
	b=L0ULsd7z3iWGlRM2q3kQzSaxKob5BtWXvxvZDMubwLv/K2L2TaJgDu0rqqYv0jTli4TYXm
	WekEgXsxubH3mrwxLHFf2CeXrUndVsSg4DMyitQ0tvf1DH1JDPDciBXFYbUQXzpHiEaPZs
	t76DHsKfsGBdGtAVFwJsVcvdXEA4C38=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-hGXWGZ0TMk2rPOpXluqPvw-1; Tue, 08 Oct 2024 14:05:44 -0400
X-MC-Unique: hGXWGZ0TMk2rPOpXluqPvw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c911a22768so450681a12.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 11:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410743; x=1729015543;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSBrsBHX+bOF/xalnqFlbySfgWCG2J84KmNwiiijxt0=;
        b=Jjc4F+vo/YUAC2IX3sSUOWzlN/MBkxEm2lMiaG9IJcwFrq1lOZ5xRgSXguQhOceXde
         m74jjQiq+PYJM7ZZWMyda2zP3KMo7GCa15wdpeo+Ok8Imua9TtAAyuEf1q98zuTCaRzV
         Z4L8Kbftyq4rQ4BkADtnXcVkyFuoP98duYypl4O7VTkrNNvAFXi3id3X01jZQ1tDRTbE
         MZRvogLQFndP9lVW9NgBRy3BT5GOOq9CoqY1mGfbtHqwUkem75gH59t/B83zFb6FqfCp
         kDrVmlI+r/uh/TLrq7YeaoUTvIltE1vbc/cdNmPZLtocfdqPRG58ZyiailcZU/kFYqMu
         8Msw==
X-Forwarded-Encrypted: i=1; AJvYcCXuF/zkt/tP79pExxPO05ffask8yTQUOd/pDrCSPeI9Ign4JOJt0CUBRwnAxZWY8g1AzII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6qdSk9haBTK0uYoP7ZpmSrp7E7n+yROj1yCUih/iODQOXwno
	WbU8TBqWNKL6Jbpg/lIT9XlgFE5j7elf+33I+UHZe89lrCcVSMGVT/FpEIeZpI04hKubAA9wMMK
	VZmnzdTTFj6jNP8zznAkTGZiSFv5yM6z09w6a2EB1AhuDZpHBpw==
X-Received: by 2002:a05:6402:3811:b0:5c8:9f44:8145 with SMTP id 4fb4d7f45d1cf-5c8d2e8769dmr14049267a12.26.1728410743007;
        Tue, 08 Oct 2024 11:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImQDma5QXpogq3kDV2BvTyqiPPtxuHsvPzGt2cQSE0/0TUikQD5HviL4wT8kioF60+Te2KA==
X-Received: by 2002:a05:6402:3811:b0:5c8:9f44:8145 with SMTP id 4fb4d7f45d1cf-5c8d2e8769dmr14049226a12.26.1728410742520;
        Tue, 08 Oct 2024 11:05:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bc422sm4542269a12.42.2024.10.08.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 674CB15F3BCD; Tue, 08 Oct 2024 20:05:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Simon Sundberg <simon.sundberg@kau.se>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add test for kfunc module order
In-Reply-To: <ZwVwBiT8XASa7Jy_@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
 <ZwVwBiT8XASa7Jy_@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 20:05:40 +0200
Message-ID: <87h69msc5n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Tue, Oct 08, 2024 at 12:35:19PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>
> SNIP
>
>> +static int test_run_prog(const struct bpf_program *prog,
>> +			 struct bpf_test_run_opts *opts, int expect_val)
>> +{
>> +	int err;
>> +
>> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), opts);
>> +	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
>> +		return err;
>> +
>> +	if (!ASSERT_EQ((int)opts->retval, expect_val, bpf_program__name(prog)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +void test_kfunc_module_order(void)
>> +{
>> +	struct kfunc_module_order *skel;
>> +	char pkt_data[64] =3D {};
>> +	int err =3D 0;
>> +
>> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, test_opts, .data_in =3D pkt_dat=
a,
>> +			    .data_size_in =3D sizeof(pkt_data));
>> +
>> +	err =3D load_module("bpf_test_modorder_x.ko",
>> +			  env_verbosity > VERBOSE_NONE);
>> +	if (!ASSERT_OK(err, "load bpf_test_modorder_x.ko"))
>> +		return;
>> +
>> +	err =3D load_module("bpf_test_modorder_y.ko",
>> +			  env_verbosity > VERBOSE_NONE);
>> +	if (!ASSERT_OK(err, "load bpf_test_modorder_y.ko"))
>> +		goto exit_modx;
>> +
>> +	skel =3D kfunc_module_order__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "kfunc_module_order__open_and_load()")) {
>> +		err =3D -EINVAL;
>> +		goto exit_mods;
>> +	}
>> +
>> +	test_run_prog(skel->progs.call_kfunc_xy, &test_opts, 0);
>> +	test_run_prog(skel->progs.call_kfunc_yx, &test_opts, 0);
>
> nit, no need to pass expect_val, it's always 0

Sure, can get rid of that...

-Toke


