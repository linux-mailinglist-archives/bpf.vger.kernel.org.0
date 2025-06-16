Return-Path: <bpf+bounces-60703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECDADAADA
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 10:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B291882DDC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D771F0E26;
	Mon, 16 Jun 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC2TzlCt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8901DB377
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062811; cv=none; b=aTqjaRkU2vJtlLCjqRx2LBwugWgqthpGz4c7TGx4hK5TQKDnPK534MYGYkXpGy3ps2TWCUJ13Q7UhbTeXOBgkz5Y+sUBcfafft9L4luZm1HxnbagmlEQM45mtn2KW+uzi8UxTSa//MTfbgxBjOSxOhhRB5TH9PIVWqmuKI/RQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062811; c=relaxed/simple;
	bh=dxHbGNEk2bAEdeeTVkgCoCVv0At9KU8fDvRKC4BZvPk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgmIjxSYmDujpcndhG7bSiEQ23+eg8o8AcnVkGlpeZmWtp/d6Fn4fQgqs2gkTcE3Ug1IN5E6nTqbWTA6xTbZdWcVcP918UYvypXqLtUGbD0nhMV6d9wcNj+CdBOlWV0HOMnoi86AhGC95hGc9Folw7TwOgn8hbtqOpF2WbrKuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC2TzlCt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad891bb0957so728668266b.3
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750062808; x=1750667608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yMBTHW+18+TxIStku0egqL4jBBZKIM0BH9zq9FlNcc=;
        b=QC2TzlCt3S2kYxm4RKwaP/fvWJJSEb6VnvQf0hw98WDFNu8mecq86cqfJCQsR0umCP
         2TQiVCWG+958XhDMZw0DKo2Ht+mCtL4LIc721usmimiC9T2vz9DK1TLBrSQD22S3vLfi
         2Xap32xEf2MsY4dA12EV0D8a6QDQ0KGJAFr8CMgFo8MB/+uaNrVa4+MqPbssTJ7Kg6eO
         RGB/rbBeztOH+5DF3wSR2kJUyibaM//MLVzZv1xny4CMASMupZwXudkHYKKAjAi84f84
         zf1FCpCLL3wXHvScaoY2vsNHd4i2bzEm5jprw3Nwmfk0ES/xFBwwX7K0i4SunU26nGsF
         x1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750062808; x=1750667608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yMBTHW+18+TxIStku0egqL4jBBZKIM0BH9zq9FlNcc=;
        b=q/r/y9e+ctcaDvNC7PbLi0oGPKvmFoScRmZI60I8/E+giMkpZg0xLGOvzBVICSnYOE
         UzkAdw6AFFCtjxYLK0sat7/L8M800nDT7bCx/k3GpbQ/5YDvTnQ3dtD8T8MmL9sHYHo8
         ROLAhGt5NkS/7DAkeP3VfFgol0fKx5WRJKNrjfWrXsI5AD1M2V8xxYmNeFEmtRvyTzzZ
         dZLvI91pfihUh22dv0jk2TaJl5Zx4iL9+pSfGy6S5ZVw3N3AYys3bC7HnUlWnNMaYdxm
         k/DaV+pgI5vZGNtWxjKtxAimuc2E0LTNs22g5Alsjpcy1SvoUd2j5ZgnJpm1ZRE5GlBP
         AjCA==
X-Gm-Message-State: AOJu0YxP8Jin6oqngtGkj/41lj+iQaW9xuroOzsYGsy5TWWc0qbYkZ22
	sgSJqQG+4UiyCtANU1XijXyAZdXXGjg6UFZS316B/tTeMGZu6x371bHP
X-Gm-Gg: ASbGncvwa3jh+vhzL/KrBl2CRfgeiSqlcE8m98HODTtnfTYLe28VleGNULZ2iLVvsMF
	eS2wCZj36/oFuQ4ZaHo2t/b/auqFjHOjfN08eit5pXiQzrk/KiEzDwN6BC6ZBslFgIsHBfTRFUZ
	l/KIac5o2BH+Us6Fuyy469RcO/gUIbAELj58c4pagYyMMYsmPWq/Cg5c2Cj+4tePUMiLuc7nh1g
	/3jRVfBDPXahGx+38P8cfTOeoCDR8ZyZdlxDzJHKBSJwNYJhmPxCIw6Vfsfdtj1FGRNmiFJN1g5
	xznaj1cW+dPWnFT/WCqtGJx7lP0roC2XeSyXe6w3pnQso0Wd
X-Google-Smtp-Source: AGHT+IFbyQQTyvz4ogv5XD1HxmWZMpZNlsn/s7sahA3yK0fBjqkfhr4BoHRPH7LDbrlC7Nouj2nO9g==
X-Received: by 2002:a17:906:6a09:b0:ad2:1a63:3ba4 with SMTP id a640c23a62f3a-adfad41d957mr648146266b.37.1750062807657;
        Mon, 16 Jun 2025 01:33:27 -0700 (PDT)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec89292d9sm610215066b.116.2025.06.16.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 01:33:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Jun 2025 10:33:25 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
Message-ID: <aE_W1ZoK6BZ6_EGA@krava>
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
 <20250615185351.2757391-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615185351.2757391-1-yonghong.song@linux.dev>

On Sun, Jun 15, 2025 at 11:53:51AM -0700, Yonghong Song wrote:

SNIP

> 
> There are total 301 locations for usdt_300. For gcc11 built binary, there are
> 300 spec's. But for clang20 built binary, there are 3 spec's. The libbpf default
> BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__attach_usdt() will
> fail, but the function will succeed for clang20.
> 
> Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (through overwriting
> BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other test failures.
> We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.c since we
> have below in the Makefile:
>   test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
> and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both progs must
> be the same.
> 
> The refactoring does not change existing test result. But the future change will
> allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, which will have
> the same attachment failure as in gcc11.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..dc29ef94312a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
>  	 */
>  	trigger_300_usdts();

should above line (plus the comment) ...

>  
> -	/* we'll reuse usdt_100 BPF program for usdt_300 test */
>  	bpf_link__destroy(skel->links.usdt_100);
> -	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
> -							"test", "usdt_300", NULL);
> -	err = -errno;
> -	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> -		goto cleanup;
> -	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>  
> -	/* let's check that there are no "dangling" BPF programs attached due
> -	 * to partial success of the above test:usdt_300 attachment
> -	 */

... and the code below (up to usdt_301_sum assert)
go to the new subtest_multispec_fail_usdt test as well?

jirka

>  	bss->usdt_100_called = 0;
>  	bss->usdt_100_sum = 0;
>  
> @@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
>  	test_usdt__destroy(skel);
>  }
>  
> +static void subtest_multispec_fail_usdt(void)
> +{
> +	LIBBPF_OPTS(bpf_usdt_opts, opts);
> +	struct test_usdt *skel;
> +	int err;
> +
> +	skel = test_usdt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->bss->my_pid = getpid();
> +
> +	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
> +							"test", "usdt_300", NULL);
> +	err = -errno;
> +	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> +		goto cleanup;
> +	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> +
> +cleanup:
> +	test_usdt__destroy(skel);
> +}
> +
>  static FILE *urand_spawn(int *pid)
>  {
>  	FILE *f;
> @@ -422,6 +435,8 @@ void test_usdt(void)
>  		subtest_basic_usdt();
>  	if (test__start_subtest("multispec"))
>  		subtest_multispec_usdt();
> +	if (test__start_subtest("multispec_fail"))
> +		subtest_multispec_fail_usdt();
>  	if (test__start_subtest("urand_auto_attach"))
>  		subtest_urandom_usdt(true /* auto_attach */);
>  	if (test__start_subtest("urand_pid_attach"))
> -- 
> 2.47.1
> 
> 

