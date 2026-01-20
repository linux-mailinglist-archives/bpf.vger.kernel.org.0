Return-Path: <bpf+bounces-79539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DAD3BD5E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02B33300D91C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B32641CA;
	Tue, 20 Jan 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctv6lz9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51D257821
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874357; cv=none; b=qBEefcE2oawWN+AlRdTslYIo3CNDvgiKk8wXwOpbs6bzitVUdHqArL5KFAFdLjNf52sxRaPjkuwMq1QaGFmV1paDlsSM53yHHUfy0yxE3d6R8LPjNYzS0ePB5LGOw5B9taunyamGR/bwJCSvBkjPQUGWx0HFjprrgN157+u7flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874357; c=relaxed/simple;
	bh=/ypGC+WkDvaV86uL7voGQH80EohW3oPSiZBDDyKUGiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZD/m3kVBTtOQ9j2DtcnBUCShT6v3WUUHhOpFIgCgCTU61PptGAPhbJG7WwejFssmfN8oQkjC0drczkTGyyV/+DHY5xjlA+foutci1wAw+X8AANPaHp7jTDAyJiEVBAfgyeW+pmV5Q0RhNzyhpB0L3N9aSlNDYiJkDQ30Ez6yCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctv6lz9Y; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b6bfb0004aso6728240eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874355; x=1769479155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ro4K9Yk3fPlcxbI6QmI+2ZscW+L6ew8kitsc7QheUG0=;
        b=Ctv6lz9Y1uk+0ohDzpzI17Gs+nj+PQKeYlxQ4JFlLaM8fCFWqRCs4bh75AirWefyOy
         V3Ou3uUQhEVA4a77lT9ybB4dAwAiLKFvjbkhNp8S0PiScT0OqlDafziyKUUdZAcOy73Y
         zt4ZrqEjbq/Xa4F2QlxrzPrkL0SxQJdkjRsYDw78x2Y7dXMlPHgowd3/Ca01b7gGQ3sg
         VxMMocrHNm7sT+X+1oL2Y6G8qBtSDUF1rjI4GKDcm2mNqwj8CRFCxnNKx4kK81j+UO9g
         A15itMFlS0dmT3MUJuT/T3Y0dWsZwrH0k4ORh6L6rZlz1Yz551kUvZfae1mSiKNaml4R
         0TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874355; x=1769479155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ro4K9Yk3fPlcxbI6QmI+2ZscW+L6ew8kitsc7QheUG0=;
        b=ZCPHtluYJqGfDCfOgh3VtWWwvrYYTB0rzxxWtf6/JPUEgRsfRCJrdwgdb6nfncuWMp
         N27fBlAZolsnTaHQedmS9YPcqfY8C59nRUAPSLte1MobwyCNPMqR2EAo1+iQ9SLTrEQc
         76Gnto6WWTEdTqjV+NJrp7F8+rTSnFzVrFk1NEIlRG1QIu/xVAESN2cs7W4cbZ0qaSiP
         fJ7X7D6Cyso+r6dHYayUM0zn7bImRCQ+R/F7qRgzi1s6lZxtiD/Q4TwebgzJ57LrW7Y8
         tkAlEuiWyBXnj1cOL2JZ+ThkRygFj7lCSI0eb7MmyeniJi2d4xIFkyvlHyieZPn8ih+i
         7P3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJG42Bpd08qjUIyHUPWyLlJCGn0iOyQOtuXu+xHuZpdYHpsSbGmd3lBOy68xwGKPRylOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXTYsynRwoMpHvChJkmUVvnrknX+5M7hK7OtLNR48MVWD5pL/
	VYUeb9ts+28nE1EAUUZOW/WbQMvaOdQ3j744q4KLXjPlw5Wns2M3mbia
X-Gm-Gg: AZuq6aLH8lOFOHYFmEfMk+K0P0M9iZWakD/0OBunlTWsrsEItKM5dRqkfI0KAEiZldm
	fpBzynDYwJS2d0Dk9CthDwzZuRVP1Oie2M6BHtL8aK9PXaigs1HsoOnEqx3eVUHEe9bwLObcIqi
	1HstXsU0g0YNGqXcm4CKMeZ6hk5TB4IPon5IDca7++naJ3JT9tTwi6EAm71hXExU3Vkz9mRXojn
	LYqqaWYZrhJpeO9oEd20zO10eLksIQInMz/RHJL93lHtjbPuYzb1tcL/gMAJH8MHKXQrPJ98H0f
	BC62DwV2GFTOMLH+Tf0bx1nP396Ji6pZlRYQJdqg/7xf5jE7MBjQ8NKgPUgCcV8xQhH1iccbOm1
	pM1jh4i7xUfmlj95hRsJPebCsRvmyc1iTtc+CzP2QqtTZv67zeYq1uN18GasCvg8GI6dS9jzLBM
	IF0XUyEEk7ABrsdaj3K+HHj1Hy++AXNAwMBt+FdnCW0qZ7XS4/xWIrBfoPE5mUi2EOkQ==
X-Received: by 2002:a05:7300:7c13:b0:2af:7ee:5300 with SMTP id 5a478bee46e88-2b6b3f30eb7mr9885041eec.14.1768874354858;
        Mon, 19 Jan 2026 17:59:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503a30sm16898801eec.13.2026.01.19.17.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:59:14 -0800 (PST)
Message-ID: <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Migrate
 struct_ops_assoc test to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:59:12 -0800
In-Reply-To: <20260116201700.864797-12-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-12-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 2357a0340ffe..225ea30c4e3d 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *ptr)=
 __ksym;
>  struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
>  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
> =20
> -int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ks=
ym;
> -int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *a=
ux__prog) __ksym;
> +#ifndef __KERNEL__
> +extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 i=
d) __weak __ksym;
> +extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args)=
 __weak __ksym;
> +#endif

Nit: wbpf_kfunc_multi_st_ops_test_1 change is not necessary, right?

