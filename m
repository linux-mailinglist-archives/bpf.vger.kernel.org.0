Return-Path: <bpf+bounces-59533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB90ACCD40
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F133A4A90
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52B288CA1;
	Tue,  3 Jun 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ1SFDya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2A288C23;
	Tue,  3 Jun 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976226; cv=none; b=OU0oXicmh2tDEgT2GIeTRqgzO1woV++aGf5AmB2n1RFtHxlR+e5mdhW5vMEVnV/tuvV5it7e22rC4k+32/B3HA/JOFffYzt1LERJqFoRM7WicH6LM84Lisk9uIK1P+0e1XN+rIcAU4tpkKKd8/bcSFKtAIq82BmSZ/6B3n90nR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976226; c=relaxed/simple;
	bh=kch8Nb5zEEuVRy69il7fuRGCjksvYPemCS0QdMlvh9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbs2EI6Hbrr/S+0pfRX6/mPzPzi1LJrTifHLHealaEhQDIU1kOqSKLUrq5kudqSUwIXqCy+B4fnHel47EdFplnvlCyORF+USz4D/aiUA6/4fs3snjZhGaGueKCFUr+T5BPta54ieiAJKoSFQm6+7gCi2ynPj8clI958XCe8ZQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ1SFDya; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so130440f8f.1;
        Tue, 03 Jun 2025 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748976223; x=1749581023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kch8Nb5zEEuVRy69il7fuRGCjksvYPemCS0QdMlvh9o=;
        b=RZ1SFDya8Wh30DIZdv/yFFD6VYMHeiXoTSqVVuNLZHvtuMEZHua+zssM/hzclu00Lm
         G5Y756/A53gn29St7a1vH3x5ET8scAT5JV+Q+MBw4zA2tsJMcaC0nfd+3UzL5FrnBT4p
         6y5IFp9hOhBwQyL1e8jJIbf7YbUvbRta1EkAqBLjksPcsSj35fZDXw1g+dOsOomRPb4n
         FJP/D4Wde6li3qVUWLZtx7ZmveBcA0pa5TUWGSVVkz7apkjKjndvEIJXxPJVcel/T6Fh
         QG87q1a2yd5QfE1xtArT6WK3OYC3jMuqth1E2hyC+Nt9BKKDFw5kWR4UG7E7qlZnAQ9R
         3yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976223; x=1749581023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kch8Nb5zEEuVRy69il7fuRGCjksvYPemCS0QdMlvh9o=;
        b=KNlMojUM+PsxzvGYRUOU7fci3RvU4+j8/Fv2C4xWKPtvDPKZ/vafo0O/1schqYnHUG
         HCepfvmxv6iV83L32bsdKSyPomq7XpCz9NSWAtl+nh3oLubQ3A7vzU4rQeg9/Ll99aGy
         2h7AkARJf/IY9q4Ve2URaCgOESwpqs1PqRni99VKLshuZpjWMCnpCiRxtcxNst2jcBKP
         ZuLLp+QahQVgHmviqBZKD6+LP+uEUALMWHAKHNYyCJeWkZB3BAfPLIwC9aNxCEtgQjCL
         izJzhOcRCrO4KdQT/Xac25YyKzcGA9YSG/EbPKFu0k/GcK9xIEcHLRynnEy5qnWJL4s+
         46wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKb2oTkW6RlJWkJYkEXI6dVWI5bV4cebdFVoZi/klk2Ie36sknoHzNn8dAKIoZ/2vaxmM=@vger.kernel.org, AJvYcCV1f5FP+mpRcGma13IkM6u9q2e5WUeOinP3NR03xsaGp6unbs4qWY0QWF4JSn7CG45Pwyaybg9TMAK5Q6YiF5Lb1w==@vger.kernel.org, AJvYcCXft3HM3L8wqFT2OGJhmkNOV9kg4Tl6un3LulczlVu9M1DO3FqncD+nYX9/ZcQGIDitxd0uNWDqZlVmQYbI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aTAOa+7d8Rm70u+aylc1f3n+EwYQsnimpXHgiZippUKDtPBt
	KyKf04Plq9noBALw1Vw6OmugxMbrBAzWXuk9o8FpVw721JS80pDU2VflCv9ASBHrMqJdws7NhOJ
	nvcQc0tsT4AmQT8KuZWiI5MtiOXzpYZ4=
X-Gm-Gg: ASbGnct0rBH8IlewOX+uyMu70uODgO5MTH81VwpeumRhrEKUB09wAlKFWz5PgB6Rv9f
	mvZeF66j4hJSY/yz2dpukHyQ5O1sRURs0JxVvQGb/EwPqHUHHwR8C6wwoLlLqRFgKR7wn/cnps6
	AqPRS22HQB9gtK8Mck1hn1Of/6h9T6HOwlO4RmLWpXWTEEaH+qS+jDHik0v6g=
X-Google-Smtp-Source: AGHT+IHtAF6H5lxG7AUR9eWXQtiTtAAlk2tzZWQDxyPjZxQeyvoi6n/3OdG5W8tknilp89tmpfnxn3B+hx96ybhtJIo=
X-Received: by 2002:a5d:5847:0:b0:3a4:ed9a:7016 with SMTP id
 ffacd0b85a97d-3a5141cfce3mr3213641f8f.26.1748976222612; Tue, 03 Jun 2025
 11:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
 <aDntjJcJsrQWfPkB@google.com> <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
 <CAP_z_Ch8hKvGvot7140ShuCZOxkb+7M7Wpa4AY-D-Arp9P5ffg@mail.gmail.com>
In-Reply-To: <CAP_z_Ch8hKvGvot7140ShuCZOxkb+7M7Wpa4AY-D-Arp9P5ffg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Jun 2025 11:43:29 -0700
X-Gm-Features: AX0GCFsPfQN6jWaDMpO2qBFUYadYsNqbhI_iC3UvHyKkQ97waCljVp6CsG0xuY4
Message-ID: <CAADnVQ+pnP-L7WOxBHGfiT2yF5WBWa_6=UccnYib8ugm+o6G3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Blake Jones <blakejones@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:24=E2=80=AFAM Blake Jones <blakejones@google.com>=
 wrote:
>
> The libbpf patch set is under discussion right now. Once it converges,
> is there a way to include those patches in the perf tree without
> waiting for them to go up to the main tree and then back down? Could I
> resend them here, or include them as the first part of my next patch
> series?

Not really. libbpf is developed in kernel tree, sync to github
and released from github.

