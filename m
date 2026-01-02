Return-Path: <bpf+bounces-77670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C675CED997
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 02:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6EAE3000EA1
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535AD20E005;
	Fri,  2 Jan 2026 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VlryTCKx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C11C68F
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318492; cv=none; b=CRoWJOjFvTp/z+Kg43uK2H6r6DdXlAP32aaMMrVclyXYydG8EgJiE+tfbmTFsIE8IkG7Ba3JM9+UDOkvhCBAbAF6v+KA3+Vv67GhsQPmW8R/aBiOUoNCpPZ2JSNqBrdT7CwO0wdCgrHB+peySb6yA39fmCuP0XttZaU+1mGnl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318492; c=relaxed/simple;
	bh=d2BBgk7amMm39X2liX/rz94Ad8TtX0pVkIEGgB0qvgU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QuZa0//StiQywatAs80e2D38+ETeIGK3MyHdOCU876MnSmWI3ZMUcHg6sEtMKw7/XRyYukFsjHqw6WFApEbOZbIBWZAWashbY9/flrkyfhbmQYPcreHIzsuiMiIhHctl6ecIiwgo3hA6LTTSQtwb6A5o8ZbcqNJSJhYAZIILhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VlryTCKx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c305b7c472so47643185a.0
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 17:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767318490; x=1767923290; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQJ6P/ZzIw9Xg1wyypSJARGUht+3J7rDH4HLgYdYtPA=;
        b=VlryTCKxeDkcNyBxuijlWfedb5oc78pPWg99FCGAak9jQUTEe4b0IfZR0zDICy8pzH
         4bU7tAmDPjCGpMKO1NkRWYWbdOuiX9fyvbYvj4OSFQIW6gRdicRJXKd6ksIYY8VgZtAn
         kVnQzqrK9WweiF79S0cP6yhvvfHGOky0KyKQPN0idqBD7Fq9fXCzm3GI7QqzPIzrS8hd
         nakoLqh0MFejeF9+RnZuE2lW8lzbPc5ItChj8ykRDF97qq275voutfZa7bXUQCN5BOFL
         PHL8vi8YYGBy+JqQXrWqkF/jufH3I3WNKcJkOI19AqdoCzmzaz8xlvg/qrGi4fX/Fmx3
         TBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767318490; x=1767923290;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQJ6P/ZzIw9Xg1wyypSJARGUht+3J7rDH4HLgYdYtPA=;
        b=Yk3LuDmD622S1vo9F2f96olYgkHmw5wT88ToXOFRlk9HKu3xY2JIngBM13zGflUwqo
         mHIrhBfUww3qI+P/1qkef181SMzYTNJh7A+wbWCZqCgarydik9BcY4YnhTzKl+oU4T+O
         OGIvUt0xmSQtyUZbvIqAqKzffznNHn6lAHRUyExcmal+C/WMT6sA5tWzasTEZZ94fHnX
         IRKf8kf+RNOpBSAcOPKT/12Gau5Ib1OmPME2/71uofpmiwJV7Af7/2BYKdsucO/Q+dOF
         e/P4Mnv+hb8ddvnneMgn0EQJB0Hh5huEFNWE9pRiPXV16D/jqnWeDjBDRw4d5KR9rVbb
         CD7g==
X-Forwarded-Encrypted: i=1; AJvYcCWYHZ+EzeWid39TmS3SvxbyoNGPuY2xjXI4sWxY73jARIXuj6Pnv3GrRFJXlj8X7S67fKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLW2s/RKpYYjiUo7i60fBbf5R19O0qQ3bSBiOK6iPGgmvkV8s
	kkoKVyrzauNLCR4i+bihjVK/mk8QN2YCG9HsrUSoaW54N4m1M2rSCvs2El7h6fRiQVY=
X-Gm-Gg: AY/fxX5+kAwxeoQITO8yrCO7TkXXQHpXNqW7CkHqhcEWA9yv/ieL4ZV2JJmnubRY+/0
	yNWAb7x/MMZUGYU/K1U2CZaCCK5ML63C1bV9vv1KzKd/77QdAxi5RBRTbagwMO3xMgHIlUWlidt
	yZqsPf6W3az/xH1nFPY71+k9BPqENW3nZq6e9fDJDgSPH6iqooFVuKf01JKWOoZJ5M3/P9TX/ND
	N8MoDQGEJ8kktEE4QnQN8/r3oS02Mu8BQnxPgxa6sy533mNjPgA9XsrwJQEZ2lkxEk4wS1fVMhW
	ddj4PZWatqOafYsWIQaeW/O+m+o+AEqqaPlS1AAAWm86V8MCgO47j0uy1uIFylug/xSF0+Q2lNz
	nf1RSTQH3QtFiK8jmLa4mZAVMV8zSJHxU42/DqXIdXhp9G+UEFgFNQM5257/NqKOmnA7+nBQKjH
	GUf8khSQ4M/McnBLP6/HSxlg==
X-Google-Smtp-Source: AGHT+IHK7a+Wn69t52aeVOCScTta4oUekEKkEeNc2eGL82FE6x0Y0G6fiTCc7+aOc08pX1CGYRZEIw==
X-Received: by 2002:a05:620a:4590:b0:89f:7884:4c66 with SMTP id af79cd13be357-8c08fbe0f8bmr5969596385a.25.1767318489986;
        Thu, 01 Jan 2026 17:48:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm3290054785a.45.2026.01.01.17.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 17:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 20:48:08 -0500
Message-Id: <DFDQ494NIE8J.1KSN1EBVBQ22N@etsalapatis.com>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 7/9] selftests: bpf: fix
 cgroup_hierarchical_stats
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-8-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-8-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> The cgroup_hierarchical_stats selftests uses an fentry program attached
> to cgroup_attach_task and then passes the received &dst_cgrp->self to
> the css_rstat_updated() kfunc. The verifier now assumes that all kfuncs
> only takes trusted pointer arguments, and pointers received by fentry
> are not marked trustes by default.
>
> Use a tp_btf program in place for fentry for this test, pointers
> received by tp_btf programs are marked trusted by the verifier.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../testing/selftests/bpf/progs/cgroup_hierarchical_stats.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.=
c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> index ff189a736ad8..8fc38592a87b 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> @@ -62,9 +62,9 @@ static int create_attach_counter(__u64 cg_id, __u64 sta=
te, __u64 pending)
>  				   &init, BPF_NOEXIST);
>  }
> =20
> -SEC("fentry/cgroup_attach_task")
> -int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leade=
r,
> -	     bool threadgroup)
> +SEC("tp_btf/cgroup_attach_task")
> +int BPF_PROG(counter, struct cgroup *dst_cgrp, const char *path,
> +	     struct task_struct *task, bool threadgroup)
>  {
>  	__u64 cg_id =3D cgroup_id(dst_cgrp);
>  	struct percpu_attach_counter *pcpu_counter =3D bpf_map_lookup_elem(


