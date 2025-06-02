Return-Path: <bpf+bounces-59450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732DACBC1F
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C72E3A4A88
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A0221F06;
	Mon,  2 Jun 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iylWw/Jx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7229CE6
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894572; cv=none; b=cfxHX4388iIIA4oEWRgeM3lr0F/4gqRfn7WnZBBhHjQZWlQYeuCaXAftrUSPDB/aK1wjxSBVASzqFmnr5qYS19KYeGke4Z/HQwejl7/whMch3hGq0AB2R6SXUskKlG5P3imltYo4JtOtjZxp7m4pLjCxnOysBvFo2oEcnB4hX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894572; c=relaxed/simple;
	bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4FyscxKkXgq/0bvSGMaKbqhlU5zWBAbedPQtmEqkt5AL6pBwuswy02E9Bgi9f3CLyPnlVx/4skqrkEGLWa5/ivdhbHnRJK3WJYsXF8VM5jwEdzuytx/g9PYLKuJWPrITJ2OtaFSXDFee7wjjfqdVsH5peWD09TtSbkGVSsRxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iylWw/Jx; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c56a3def84so460463985a.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748894570; x=1749499370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
        b=iylWw/JxxWujBMjFUrikA+1ZWIGEE0meR8bh8CWFU8HFvD8n398lEvox18579iQHd7
         mqWsIgHEJbnv+QquBgmvsiMqWjOfNDA0NTDtruHxAy9EUXeZQ+IQpO43sHgYXhWq+BS1
         2qCYtNzB4yZ1DcKxdc98PkAMtsymI8qUsh+uYLArSHIp1FUIrrBdx2/QKZiz6f6uXs6w
         tP6kiDcP+UynlE4wPW6bZqrifxlt26xh1J23szo6yIHQ+3O/RutyQ1T7XlgULOQulhAr
         gDR7jJmhhw8gWy7LcTKyJC+R2cQlocMvfxwiY0Uc1RfeeHsxEvEAt4LGt6Q/R6nSufve
         n4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894570; x=1749499370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O44jyZ1Kd5oy20AmMmw4W6ZFK/TJmZN764rJdr8yx4I=;
        b=MQ63qSgUjvT7AsalmQ+WnWo+hikRNjbGGyMF30Eh0hDHLcUBIRLiZyPgmAzsLO25CL
         ws68Myeh50roDbWix0+/d2Ex5nVyQBYlkDe+SjM+ofB3OOa6mNeENuN686kn52MaYBhh
         x2vUpXSTH0y9wVfzp7TjQaw8Avr1qYnO2+HBMJntHUpTCKJIjnLy+ZNXii/zbSW6Sl5N
         epBYiaYCoUYpzkH83+85jSjZTNgHzbEfsani8cfhKYihcYYt9jet53vaj+JN8vR0LcBx
         pyS2c2oQJlplII4UWKrKSrraC2PRQ/M9wGmzlNu2430xAXz+bzLMtt9vt9JC5ggOXmP6
         6HaA==
X-Forwarded-Encrypted: i=1; AJvYcCXufqeePD4UN/1l2wyAoyHs3797mNOcJy8uabKpMiHBv6JcJnCe+hkYkylrd9+6g1JkSHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjgIsjn2Ul75Um/BojhRnMHwIDoIu1HR67vXtoBCHuytUjc7U
	ADta6Tkl/SsDdrqN6JY/ZlCf2yZqZU/03DTuc0mU1bEuij69Yv/7y8HVijGV8sQ48wfJ/1xkTYD
	AE9KfM2ZvyTvJ6OBuGd6psdB76FIynYeggD3KGaZW
X-Gm-Gg: ASbGncuAc8XuX4oQU7IuXK9ifB5sUKWML/teQe6twglh/M15TboXrpm61r7hb3lsJS/
	rsx9OcK/6OzvxUP25e7kb+7nKuszYxEHHrs7MPva169ao8gwUzAt81VjrzfLrxr8ex/l8S4dCT3
	3fuBEmzapmaIeFHokFbiRKnkAWKHHUXQwGByIhP9NHYZo=
X-Google-Smtp-Source: AGHT+IHgeqPf5EHr1jkfDZ0TWZsQVURsdNh9voMjdnoBkFzaz/mgj3xBAjN2lvxPZngxMNZ2zDqWAhRk0bMIaFAslVQ=
X-Received: by 2002:a05:620a:17a9:b0:7cf:749d:803e with SMTP id
 af79cd13be357-7d0a2034287mr2485082285a.51.1748894570064; Mon, 02 Jun 2025
 13:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com> <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
In-Reply-To: <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 2 Jun 2025 13:02:37 -0700
X-Gm-Features: AX0GCFsfxApMIel-NOMbuG9RAZwUCpPsL1Wg6IssdJPcoBruecM6kKjr4-18sUg
Message-ID: <CAP_z_ChBf6tiBZuLYE8ZGOXLYPpbNtH3F54_yBmF59oWpZ_q5A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Thanks for taking a look at this.

On Sat, May 31, 2025 at 11:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Please split selftests vs main libbpf parts.
> [...]
> Please use normal kernel style comments.
> We're gradually getting away from networking style.
> [...]
> we allow up to 100 char per line.
> Don't split it that short.

I'll clean these up and send out a new patch set.

Blake

