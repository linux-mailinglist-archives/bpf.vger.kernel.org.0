Return-Path: <bpf+bounces-33613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDD923C07
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE59281B8B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA415956E;
	Tue,  2 Jul 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVVfsJX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0594CDF9;
	Tue,  2 Jul 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918417; cv=none; b=Z/9CGeGno9AtYeb/R3/vh1DTRDq+BkqrhPM1cd3PrZLFMIod9ncBmdI6OObqZwOb00UbguDZZukcmCj5CeUpYf8JM4KukjRL8/HRad4q4zF9ciMuRW527g+WLa+GemEaRYtHebxWETy3O/gdpmLSb4ac7nPyxrFhRstHDIFCeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918417; c=relaxed/simple;
	bh=IrKOJaTQn8XCe574UcHvkGMMvVf9mEtPmVHmMZisyOo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pipztx/xt90Bsy3E0fkb1miqPaZj0ZD18Q+Iodn4c3w7/szIDRtA0K8aQhZkmBpf5ga27eFnW2dcDYDMA2/4p/GBiYo07QBqgPVt2v8JW0fOoa+HC84mR5xKOUJTGUW8TRxkSSeXOYfDGgTK35A6xNwewzYzVKpYjGHBZh1Plaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVVfsJX0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367601ca463so2310426f8f.0;
        Tue, 02 Jul 2024 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719918415; x=1720523215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feeElcS+cgUqpw8/9Nt4sJkTMDw+8CzRJvyGXG18+xQ=;
        b=HVVfsJX0phM5BSTvQIrcnx9/sc1DiFqLVet8ahRjGZEZ9R+HihV2jSDW8Rr62HBl4o
         JFX8syDKBa9qE2KtVe0qfnXPMTD+w0p2j2aDM5GXTvala5XUN6Fsok8hfHI3nkIi+Pbx
         NevxoYIeGdQmbsZ7TGzbCRhPb2S2Hm8YdoAKxggty89ziaPyi8xbJoyy0EFt2ZZAeLk4
         QcNCqEM2tsWJ0nLSGGn8DGzYN6OXfhaJ8gGP2OSqssF0IOB0le/eoBgd3iZBcCLEy05O
         DPpe8+ZSPx+JdC4gMTgVpVW/Z81XruIBW83tC8VdItI8OVeSBVeb/USs3xIOVG4AkQKe
         /xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918415; x=1720523215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feeElcS+cgUqpw8/9Nt4sJkTMDw+8CzRJvyGXG18+xQ=;
        b=GLmC8UxFo3qmf976EpEXokBZyoYk2JVubntT5noxNU4Q03Ge6lqr7fvaKVCgltQj6C
         1m8aCGprc1l28zJtDRvSbMtum14Sxm+f+1mflLMxklGlZTk8s6cY1r+RDLHPktnoxYC6
         D8lUFORGVrIODNSnijJq0XGq9FBvXVOMWhfBaw1amKakKWXDUkI5OhiapAh47jLMesim
         S6tJRCuIuE5LBQYIRs1u1mEkYGoIlt9NQiJiMcIMiw3kjzYtsSWmBiupNHGYAG9GV50K
         wNIiUJSQ3cLiOFDRKXSoUflEZ9txTJVVPmZkTkWpUlSV0uMFAzE9ftQXO2mD+zg5W4ee
         yung==
X-Forwarded-Encrypted: i=1; AJvYcCX4JODMHTNv45KWReFq1f/4x2x0xIiEx17YY1yubOIMj/p+9Flm8xhsF13QEcV75/ju/xZwKJjAYBKwbfuc2TYZGGc+ev3O
X-Gm-Message-State: AOJu0YwvzMsr1s3kPLW3DdXpfKMvDNco7HvXKo0VM9lo2gpX5cQuamDE
	7jBbtLOhXqFwOU4cBqPJLEqjLq8cfwPFAVAN72bBMHffxzB9WWrm
X-Google-Smtp-Source: AGHT+IEGhAWe9RE3TaYL9RFgz6QtvvSP/o6vjTEXDErXd2V/GouKOTyn5TIC5dteuJvtpMJQg/SopA==
X-Received: by 2002:a5d:630f:0:b0:362:41a4:974d with SMTP id ffacd0b85a97d-3677571b76bmr7046893f8f.46.1719918414409;
        Tue, 02 Jul 2024 04:06:54 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd562sm12980174f8f.15.2024.07.02.04.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:06:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jul 2024 13:06:49 +0200
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Factor out many args
 tests from tracing_struct
Message-ID: <ZoPfSe-CvdEwlxjo@krava>
References: <20240702013730.1082285-1-pulehui@huaweicloud.com>
 <20240702013730.1082285-3-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702013730.1082285-3-pulehui@huaweicloud.com>

On Tue, Jul 02, 2024 at 01:37:29AM +0000, Pu Lehui wrote:

SNIP

> +
> +static void test_struct_many_args(void)
> +{
> +	struct tracing_struct_many_args *skel;
> +	int err;
> +
> +	skel = tracing_struct_many_args__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_struct_many_args__open_and_load"))
> +		return;
> +
> +	err = tracing_struct_many_args__attach(skel);
> +	if (!ASSERT_OK(err, "tracing_struct_many_args__attach"))
> +		goto destroy_skel;
> +
> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
> +
>  	ASSERT_EQ(skel->bss->t7_a, 16, "t7:a");
>  	ASSERT_EQ(skel->bss->t7_b, 17, "t7:b");
>  	ASSERT_EQ(skel->bss->t7_c, 18, "t7:c");
> @@ -74,12 +95,15 @@ static void test_fentry(void)
>  	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
>  	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
>  
> -	tracing_struct__detach(skel);
> +	tracing_struct_many_args__detach(skel);

nit, I know it's in the current code, but tracing_struct_many_args__destroy
will take care of the detach, so no need to call it explicitly

jirka


>  destroy_skel:
> -	tracing_struct__destroy(skel);
> +	tracing_struct_many_args__destroy(skel);
>  }
>  

SNIP

