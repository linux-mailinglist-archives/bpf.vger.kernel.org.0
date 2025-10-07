Return-Path: <bpf+bounces-70538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62067BC2C0D
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03553E1970
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3B24A069;
	Tue,  7 Oct 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+INTlhy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3402225762
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872750; cv=none; b=GEsAjFP4Lxi5QPvRPBxX+dyIMDeT40pRFFjMVSLdsYVpSXf6nhG0UPxUtW05PFin/i5a2J9oDHKIekYLbQj5GMjWHYug10w5KTaW1Sz2ROsabhE79o+w/ag+8chsbSTdhSqP8lm4cbHvbLGwNajeFAH2aNGpZH+yvcrx4LOkEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872750; c=relaxed/simple;
	bh=vR5xxB2qqVNTUxfyJfRCLWMrjsq0WdYpeueixne1hGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LdRXXXFlYCj0hDtiLng7OUKC/JCzIUpkQIx0sexNj156cusaJCxx/JD7hh8iKmzYMRxoiJoZT9gy98hW20De0vfwsEYe4S3dJ8gB9qBxgRL9vlSMLEXRLrwCW5lPHX/MDBfBJBu5xHDsH55bLZzjy8BOFBt/MdDmgXArdYSC0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+INTlhy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4511030a12.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759872748; x=1760477548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjB2M2Rl79WbAPl+g06UXY+zKzn2nA3GA0y+WzmUfOU=;
        b=g+INTlhyR5IMNjmhf7SGtc+9O+JkvoFoKG3efxqo5WAmXQcAChVqj4DdphPql8G6xH
         qBk5Nun0Sn9pzIau/I6P1lXP2R+n9y9ZJhdl4Bt8AtgYm1UTJSQehT1qQ7PhdAQwlCfl
         CLtxXuPPaVSHemMZ2Ckrvs4OUpqbSqwJ0HSAPJkdmkRMxC4JNPVf/Kkhp8OCXDcazk7p
         PCyuqB4ePt1G/oLCojX8RoA9wm7kJV/0jvk27n18UYcCyX1+/OdL4WlplhcENAG+tZ+p
         JofhqYf16tEn4XS23TM776quKCDFJnLsYu1OD5/m81MXbmi2FuzR8GSyxlcaOwxrz4UP
         u2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872748; x=1760477548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjB2M2Rl79WbAPl+g06UXY+zKzn2nA3GA0y+WzmUfOU=;
        b=kbmZrsUJevGXBdbuVd5ydpa0H5qYoEDxXYogYF4z2IhG0zpEpnG3bR9L4D8qrOwu2Y
         lRLL/s4wSDSiixbLczsMPb3uBDQN4uTrakFOpeacyYNkjZG7uUjKST9d/jG42/nCS7PT
         lkEF06h5xE6zFNYmHOnTqyfcvyTWM6YwTd1l+IFj3hxJbbGhIWsGJb5rIhzRka+46a2M
         Knh5m1rE74E1+ORtwI2wSykS8rVCXN7viDkAfgyChZCaEUGQRahPBcXBXp7u5DWfzm+2
         HPnA7qQVGAZswUu7XbFPnZrDNGrijMOsz6bsRnqMa7HKtOrzgZRxbRWZv4rtdPl1BZiM
         XAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAVbcn0pqzJb6idHxGVfMgou7EPf9gnPhkG4YGV/RB5NXrh40tBfjL+DTAj/S9oCznKq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkVBz7w9q+zMYIZS4u2/gdbcOjJKlgnu89142gx15KpyWj5Vq
	39WO6RQ5NpIVaAYOdNTU1cFdiPYq5abwKoz/Ird0uqBgRC912fWRX4xgRiYPNxZ0
X-Gm-Gg: ASbGncvyXWX1avvggEwcV2r8J7YWtKdfbC5Y8nFFt7cywA9RWnJAxKMs6/BnEpYOs60
	DSF+zoWW0J3wstjL2Wwz4hinZTtJEKEzhsntzzdDZt8AF8sV+YFutL6qao6bj4iCZuhuCLlkhMt
	mf7PrEl8gArsYs/0jurMoPaUEmG8m2v5kePtLNy7F5YUCwY2MNNe8BNH44bVwpJ/MadNP2dIHKe
	BshoWZFn9WXdRLnxYgc9H2THknVSZbPfFFexAoUQToVK7jETEvNGIyL1jtag5MrdW01PLG4rXib
	ojGPc1tX8tkzxlocZuJmDNkTTBDTumfYWgvTMrj71yytvOX+Na1Fl+WMlcV1u9MMZTGSNOmYv7h
	QnYaofqyT8fRPS2Tuu+jNP4iU3/5+7Wx63bI9qXNYYwQaaYuRyVzltA0ZVX3H+O/J+N2zLsyf
X-Google-Smtp-Source: AGHT+IELQ610ZqJg/wJ/1rn8nP6xXZlx1YIY6SImvXcQgiLPZSaI7Ch4lUqlLYgPWGrmvaXVkxNSkA==
X-Received: by 2002:a17:902:ef09:b0:275:7ee4:83bc with SMTP id d9443c01a7336-2902721354fmr15438665ad.2.1759872747992;
        Tue, 07 Oct 2025 14:32:27 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d038e4asm177024505ad.0.2025.10.07.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:32:27 -0700 (PDT)
Message-ID: <ebc64ea716708fa6d678d040e5d1ea6634690efc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add bpf_wq tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 07 Oct 2025 14:32:25 -0700
In-Reply-To: <20251007163930.731312-2-mykyta.yatsenko5@gmail.com>
References: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
	 <20251007163930.731312-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 17:39 +0100, Mykyta Yatsenko wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index 99e438fe12ac..e4241119769b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -38,3 +38,47 @@ void serial_test_failures_wq(void)
>  {
>  	RUN_TESTS(wq_failures);
>  }
> +
> +static void test_failure_map_no_btf(void)
> +{
> +	struct wq *skel =3D NULL;
> +	char log[8192];
> +	const struct bpf_insn *insns;
> +	size_t insn_cnt;
> +	int ret, err, map_fd;
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .log_size =3D sizeof(log), .log_b=
uf =3D log,
> +		    .log_level =3D 2);
> +
> +	skel =3D wq__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err =3D bpf_object__prepare(skel->obj);
> +	if (!ASSERT_OK(err, "skel__prepare"))
> +		goto out;
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "map_no_btf", sizeof(__u3=
2), sizeof(__u64), 100,
> +				NULL);
> +	if (!ASSERT_GT(map_fd, -1, "map create"))
> +		goto out;
> +
> +	err =3D bpf_map__reuse_fd(skel->maps.array, map_fd);
> +	if (!ASSERT_OK(err, "map reuse fd"))
> +		goto out;
> +
> +	insns =3D bpf_program__insns(skel->progs.test_map_no_btf);
> +	insn_cnt =3D bpf_program__insn_cnt(skel->progs.test_map_no_btf);
> +	ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, ins=
n_cnt, &opts);
> +
> +	ASSERT_NEQ(ret, 0, "prog load failed");

Nit: if (!ASSERT_LT(ret, 0, ...))
       close(ret);
     ?

> +	ASSERT_HAS_SUBSTR(log, "map 'map_no_btf' has to have BTF in order to us=
e bpf_wq",
> +			  "log complains no map BTF");
> +out:
> +	wq__destroy(skel);
> +}
> +
> +void test_wq_custom(void)
> +{
> +	if (test__start_subtest("test_failure_map_no_btf"))
> +		test_failure_map_no_btf();
> +}

[...]

