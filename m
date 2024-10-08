Return-Path: <bpf+bounces-41271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714089955F4
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360D6289A17
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89320CCE9;
	Tue,  8 Oct 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTVFpDCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF1139587;
	Tue,  8 Oct 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409613; cv=none; b=meSMaAI7RlJ51Zd0N28mNJ2z1qgcemt492m+kDCrrahtG4whAjye8J96bXXPU3vthrrwYfcjvbKgrSpCxE7jUoSowh9G6Ao7sVQNtggySespZEWIYYDKbhBkkdM5s3q1ybzu1qKLgKS/1DeBECpBqGp8SynuAuCP2qdOyrzbwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409613; c=relaxed/simple;
	bh=zap9Y1r3CTsZpH6RVcLM37SN7eOid2giqGc41s1965g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3UmU3Pfr1kFQ8EHcGx3bPPeOSjeQrKXQzU59uhEivqx3pfRaOs816DoVGS+ps+UU0xsZblHZWyyL0hzH2yULENq1itaCuNtcO3TYr0LnOFm5ORCW2SgUxtKf2HnXReN8FGQjvT9ta79eRGjdsJ7GaWUaOfz+znP2RSRGU7JH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTVFpDCW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cc8782869so60669225e9.2;
        Tue, 08 Oct 2024 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728409610; x=1729014410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CVddQOjiXC5Qq86dbbfKMXV0SltWWfZ5nFDUlos9uc=;
        b=FTVFpDCWLO+A1ZnvKWUV+r3A/RmLkH2xTpB4awTSJt6B2n3XChb7QC7XCgqTxxn4Gp
         rLG8I8jUtjLpJ1lUOARs4XyqIec/375gjkUopfWDBgPphXG1dSL27E+ct/3IdtoSAwzs
         Vhz0Xoo/ZVHSq6N76+5SBKDG9Ta9bpc01ZeiLNgegvoxJHJUjexGKXuFlPmKmEB6zgQu
         eF2IU3FgI82DakPIlM1TOOcQE9ggR4J4JhlDo5N+vnFKGFvRCESRNEP0KFxhIcYN2zXt
         I1htpRdq/1ETay0HjoJBFn/bXlTV/tkcXcUDlBKV4KcC0F02RUA68gp2i65moifn7oMi
         6nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409610; x=1729014410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CVddQOjiXC5Qq86dbbfKMXV0SltWWfZ5nFDUlos9uc=;
        b=RogGDmGnH2vMhuiwpIP1YE9mB4uD4iCYV5G/H7Gu59PodKiw1uTq/PjpMT/nMd4gt9
         Z3wAbDhonRcnBytUabzy8JEufiMtj11wAW/YovwCriAg57/XtP7ZMDx5cY5N5tkytso3
         ka7mpKmH1H7zSbe91rvINIB2CR0Vw1QdxaxPI3m+L09E04aVt1YLBJhBDpH0+WyN+p3h
         92fDi4qnCXOZqhLSNqy3IZs1t4d4Wvd7vD+4vq8FXvf4XkSzmqCozkoqDiBs/vUK0GMT
         67UBaL00Ud5Otmq1a/JHEfuqyEKJZYBznAhPPuxjlYVqNo+eCPGid3sis7EymBSBNA02
         V6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqr5jaxbUEJp+Gj2PJd3neEfsVIsi98FWwDHT5AiGbB3pE+l4TvwMPeag8/6QHhUPG9SU=@vger.kernel.org, AJvYcCVD+RN+dLPjloPX/z+NTd0br5bsME6yYCKNJl8d0eo46xD+bkuSTgRIgY2w//dpw8urtzNP1NgI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+B29Kn51My3yH2ozEcy0Z/HHhu4fGYvE0sermyspOj8td76h7
	q3MSYcWAjfqVYQeAZf8YncNJZXrz35/8ASyhOteRY6GnFtIQNg80
X-Google-Smtp-Source: AGHT+IGFweY4PqKarTbtzZS0maqV/JS3VWektN2kmxdO9SZDvQn8kioBh0QlR/O/maCeMtTP+mNOnA==
X-Received: by 2002:a05:600c:1e29:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-42f85a6c5camr138675075e9.1.1728409609940;
        Tue, 08 Oct 2024 10:46:49 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d5fesm133903635e9.24.2024.10.08.10.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:46:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Oct 2024 19:46:46 +0200
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add test for kfunc module order
Message-ID: <ZwVwBiT8XASa7Jy_@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>

On Tue, Oct 08, 2024 at 12:35:19PM +0200, Toke Høiland-Jørgensen wrote:

SNIP

> +static int test_run_prog(const struct bpf_program *prog,
> +			 struct bpf_test_run_opts *opts, int expect_val)
> +{
> +	int err;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), opts);
> +	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
> +		return err;
> +
> +	if (!ASSERT_EQ((int)opts->retval, expect_val, bpf_program__name(prog)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +void test_kfunc_module_order(void)
> +{
> +	struct kfunc_module_order *skel;
> +	char pkt_data[64] = {};
> +	int err = 0;
> +
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, test_opts, .data_in = pkt_data,
> +			    .data_size_in = sizeof(pkt_data));
> +
> +	err = load_module("bpf_test_modorder_x.ko",
> +			  env_verbosity > VERBOSE_NONE);
> +	if (!ASSERT_OK(err, "load bpf_test_modorder_x.ko"))
> +		return;
> +
> +	err = load_module("bpf_test_modorder_y.ko",
> +			  env_verbosity > VERBOSE_NONE);
> +	if (!ASSERT_OK(err, "load bpf_test_modorder_y.ko"))
> +		goto exit_modx;
> +
> +	skel = kfunc_module_order__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "kfunc_module_order__open_and_load()")) {
> +		err = -EINVAL;
> +		goto exit_mods;
> +	}
> +
> +	test_run_prog(skel->progs.call_kfunc_xy, &test_opts, 0);
> +	test_run_prog(skel->progs.call_kfunc_yx, &test_opts, 0);

nit, no need to pass expect_val, it's always 0

jirka

