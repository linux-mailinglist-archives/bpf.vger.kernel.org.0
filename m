Return-Path: <bpf+bounces-36171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96E94378B
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093721C2251B
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127016A949;
	Wed, 31 Jul 2024 21:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D01BC40
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460145; cv=none; b=GCmf7IbOhoQE8NW596hp49+9KkssOn7oYVJ0mebdhEx/aHGUozRj2kANdagydLL4yQzS+ls7fztHJkRFUsH072g+X35EXZ4U1Lx7eUxMmLoMyfw1QH/DDYWnBdNCpSg0V9b0AEfAKeMynekpT2cWmojq6P8VbsvBCnE1DWbdnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460145; c=relaxed/simple;
	bh=20TBoa3e3pmf7uDARTzRF8OEvJGeLIQZG6pAL8eGjmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEc5lhTGVvPVY2FwOYuBv/U9j/nDbKFQq/iyHgIhKUVjdwH3YQbT8ScJpeZPVhidaFYabEgxrfY16JxAf1dt8EzOhO7NcyQWtwUo+Dj8MayFP37IIPeOWzAkM21bHeRGSLyBZUuAjURZCcHhg7iy3ZNqYJ7Sw+HMK3OROFvfBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db51133978so104671b6e.3
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 14:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460143; x=1723064943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHI8hdgq0yJU2OamVUB/1NzcngVEUMoqx39qx46oI/M=;
        b=EfNBelREBttHaBIcikF8adIDmqGJC0eabaG+JfjmkLEns1V/EI6JZR3O5PuEOliXyQ
         eH1oDeCYCR+mnYv9UWHkx/PBJYkBGPwXFDlINH7OQOell92dGrzL2sLLdjwggX+bIRJQ
         NxuTDeAQtOhzji520mRrJI+7DHbr+g5BSiNOWzuCBFb0de8vCrrTmi6Un4AjCN0fKTqf
         quHgq1uRdHXU54LQIPkCFjSfrX/MitgxWLFTya8oSSshsD3tG872xwvRPFuUXy/bRW8r
         6XbKFE5rO8lTUWnQaf0zJxZsY/rcQSG6ZgkrraMReQZ+QcFF93gNNjhSL71qtqiZsG3M
         f0LQ==
X-Gm-Message-State: AOJu0YxOYQ14hWb9X1kmC0uk/4OSOhtnc4Ww6oAgY8W2yXupgNX5ht7H
	DSLH8Mv8TXNLzrkiJye9Hhea0ekxj4K6APcPm/pakGVlvvfc8fc=
X-Google-Smtp-Source: AGHT+IFcjWSz3xuDBTSrst5+zALnhRdnKlwXuNA6cqfu/cnCznm+2c1oEuGcK+coPIOfoQFXfQc7zw==
X-Received: by 2002:a05:6808:218f:b0:3da:a6b7:47f3 with SMTP id 5614622812f47-3db511c3014mr333583b6e.1.1722460143550;
        Wed, 31 Jul 2024 14:09:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816af28sm9231039a12.23.2024.07.31.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:09:03 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:09:02 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: Monitor traffic for
 sockmap_listen.
Message-ID: <Zqqn7oPuZJ7dobVU@mini-arch>
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731193140.758210-6-thinker.li@gmail.com>

On 07/31, Kui-Feng Lee wrote:
> Enable traffic monitor for each subtest of sockmap_listen.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 9ce0e0e0b7da..2030472fb8e8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1926,14 +1926,23 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
>  {
>  	const char *family_name, *map_name;
>  	char s[MAX_TEST_NAME];
> +	struct netns_obj *netns;
>  
>  	family_name = family_str(family);
>  	map_name = map_type_str(map);
>  	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
>  	if (!test__start_subtest(s))
>  		return;
> +
> +	netns = netns_new("test", true);
> +	if (!ASSERT_OK_PTR(netns, "netns_new"))
> +		return;

[..]

> +	system("ip link set lo up");

Let's do this in netns_new? We almost always want it in a new ns. The
tests that don't need a loopback can do "lo down".

