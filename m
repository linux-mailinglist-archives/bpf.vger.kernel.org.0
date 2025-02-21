Return-Path: <bpf+bounces-52208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1853A3FE97
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCC3BD9D5
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23302512D3;
	Fri, 21 Feb 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Iiay93"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F31D5AA7;
	Fri, 21 Feb 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162001; cv=none; b=hC2pfubv1N0z/gJ8Ghd0MLAVZ6AGRw2UFsnbDTt/euOxrSAzhvjvlfnk8EMbPRMEepQgmfGAIQVcopDSAsi5NRSTQ41MElr876WujSi2RevvbH8Y/lysFOAlkiVamPg/PsTuUcxTzZWJ5RAc0qSGExJw3hhoSrsOxZdBnHHPfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162001; c=relaxed/simple;
	bh=amUGM+2Ee6TG1wQ60OHzHltKBCj71IDHtqOsZNdNgQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEjgHkkaSFOveXqp8B8IeZp2+Fhn3Kmlo/LhHEpqYhlHu+gsd9dbLi72YdgnXALXNqr5WxYVlFvEU1rzFMw/Z6/pF5JToKH69X2oQhvAJU9bStV89yCi0LjFIkqZp089bkjeDxrqYIJa696TOl5Fn1+PcE3T4SaXI4y0DzqfERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Iiay93; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c92c857aso44287295ad.0;
        Fri, 21 Feb 2025 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161999; x=1740766799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOqFqrBqZ94xV6zNUwjJJQSpBxYZgjO/OxGwt4vTBBk=;
        b=H5Iiay93el0tTcpXTpVmxMNNGzXkimJQfn5n32oIicF2y0XpXz5PYqFv9SkKUmxSET
         AvsrAjh8NzYzpXeuROSP/WYCoZMJf/Li/NCPpqSCerIoxIri0eV/3C3GvQT7a8UeHxQK
         3S8EjAI0y7JoQw3nPuks+P5w7Y4PgoyuPCGnN3yWsDGiMPn2RkufEjMFiZWqmMETKzjw
         PIeVRBVc4Z1i/lBOpAI5ZAeWtTcPFXcK36Cq3tieq1cXoyOG+/YuTW9kQ9RFD2WHe6IF
         VFvKfagP76U6LHhU9IOudxShrJUqkpIUgYhSyqzGZy5nvOY8qnrNB7s8g7wpy+sEBDnz
         h9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161999; x=1740766799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOqFqrBqZ94xV6zNUwjJJQSpBxYZgjO/OxGwt4vTBBk=;
        b=RdVloLpLZ4QoPB9t7g8/DI+CjLVBhbqULS1dGvgoAYiQWYt3UOt/78SKeHgVByI9s4
         RUVPxeGMXLgd+FAj/SL7T1nLmo8/a6Ak9CnhslguzjLHUzt6W5uZ9aKxleV2tFize/BZ
         A0tkCbjB9UGtgAON1ZzLZEOmihOsoJh4je7MS2XA3/+Rk6mEDEYlIlhqW9KsmsG39LE4
         ZGXxiia4yRPEuCw3Lzqr4qdrCW7XyZcqDMxvTuVwD7yd2D1tm3R+aCDtIgN5yT21FoIf
         jgX++xbj6lfj08YgqhE4Ws4BPqbomfcvP+3y7IIizBGailDAGOXEu1duesV0DHxqTE/K
         JAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+6bsG9LbpRzEjjWuvWZuha/cquLeXoet1C9nBv5Abi+2/KROhMTyuCy8OFGKvGh4zKDvYoBaLQLTh1GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfsRX5yF+p+O4n6tB5eGwdKmKxjclx1VrhyXHc/B6+T72Qg2s
	s8zk1eLkZebsxo3CerjSqgHMl7/aM1s9DjiRNdv+DEODdr/n5uYI
X-Gm-Gg: ASbGncv+I+q3xCv3/C5/fbMNiKNIw4XCcnLXA7USjBkYTsEPoMw/afTlNq0iTeqNj+W
	VhRNw9IMLYi7ikWMXCp+bhz3ngbpqPvIF+DmQwWBmp1j2CouG9JlwuSqXUe0uSw4ae4xnLktCIq
	GHiyen5/M6WQpXF7d+3OcwEAS+lQBLix7QaceTmR+0+gmy75U3qPMwkG7Mx02skSBAdbsSMBP0F
	2Mo7cTNh56AqRGmYpcADyGtFmMS1PZ8CkTD9eR5KzstltKv1A7sDxS4xIpYvHOGmzuexHCnreA1
	3uf3bLAVm78jCHRHprGeXl0=
X-Google-Smtp-Source: AGHT+IFzQgpB3vlyz56xWEgEIajr1YxAozbUQo+q5VNuc6ftiGpqAuM+tivKkVC9L5mMYSFUEg/9hQ==
X-Received: by 2002:a17:903:188:b0:221:77d:3221 with SMTP id d9443c01a7336-2218c3e304bmr144562735ad.8.1740161999034;
        Fri, 21 Feb 2025 10:19:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491ecsm139761645ad.9.2025.02.21.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:19:58 -0800 (PST)
Message-ID: <d3dacc81d79d67f1c4372adc2517176bed57fadd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add
 libbpf_probe_bpf_kfunc API selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 chen.dylane@gmail.com,  Tao Chen <dylane.chen@didiglobal.com>
Date: Fri, 21 Feb 2025 10:19:53 -0800
In-Reply-To: <20250221163335.262143-5-chen.dylane@linux.dev>
References: <20250221163335.262143-1-chen.dylane@linux.dev>
	 <20250221163335.262143-5-chen.dylane@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-22 at 00:33 +0800, Tao Chen wrote:

[...]

> +static const struct {
> +	const char *name;
> +	int code;
> +} program_types[] =3D {
> +#define _T(n) { #n, BPF_PROG_TYPE_##n }
> +	_T(KPROBE),
> +	_T(XDP),
> +	_T(SYSCALL),
> +	_T(SCHED_CLS),
> +	_T(SCHED_ACT),
> +	_T(SK_SKB),
> +	_T(SOCKET_FILTER),
> +	_T(CGROUP_SKB),
> +	_T(LWT_OUT),
> +	_T(LWT_IN),
> +	_T(LWT_XMIT),
> +	_T(LWT_SEG6LOCAL),
> +	_T(NETFILTER),
> +	_T(CGROUP_SOCK_ADDR),
> +	_T(SCHED_ACT)
> +#undef _T
> +};
> +
> +void test_libbpf_probe_kfuncs_many(void)
> +{

Hi Tao,

Sorry, probably some miscommunication from my side.
I did not mean this test for inclusion, it was meant as a one time
manual inspection of libbpf_probe_bpf_kfunc results.
Just as a sanity check before series is merged.
As an automated test it does not provide much meaningful signal.

> +	int i, kfunc_id, ret, id;
> +	const struct btf_type *t;
> +	struct btf *btf =3D NULL;
> +	const char *kfunc;
> +	const char *tag;
> +
> +	btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);
> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +		return;
> +	for (id =3D 0; id < btf__type_cnt(btf); ++id) {
> +		t =3D btf__type_by_id(btf, id);
> +		if (!t)
> +			continue;
> +		if (!btf_is_decl_tag(t))
> +			continue;
> +		tag =3D btf__name_by_offset(btf, t->name_off);
> +		if (strcmp(tag, "bpf_kfunc") !=3D 0)
> +			continue;
> +		kfunc_id =3D t->type;
> +		t =3D btf__type_by_id(btf, kfunc_id);
> +		if (!btf_is_func(t))
> +			continue;
> +		kfunc =3D btf__name_by_offset(btf, t->name_off);
> +		for (i =3D 0; i < ARRAY_SIZE(program_types); ++i) {
> +			ret =3D libbpf_probe_bpf_kfunc(program_types[i].code,
> +						     kfunc_id, -1, NULL);
> +			if (ret < 0) {
> +				ASSERT_FAIL("kfunc:%s use prog type:%d",
> +				      kfunc, program_types[i].code);
> +				goto cleanup;
> +			}
> +		}
> +	}
> +cleanup:
> +	btf__free(btf);
> +}



