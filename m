Return-Path: <bpf+bounces-59404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6DAC99DB
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175394A258E
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAC23644D;
	Sat, 31 May 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVF3H8vJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4DA1CD1E1
	for <bpf@vger.kernel.org>; Sat, 31 May 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748676393; cv=none; b=fRBWO72DJTU34lKGQN2VhMJDssajXyZJMwXEEwI/k6tqiO40DH4JFUS9s0SWskhEve310kMDWbgWizvcLwnKmAIz8JPdaitjus9GEASV06U2W+QCj6glKdvGOA9P6oLxyMSmADpbHNN1grBMH9171xEFgnsLs2hTwln5bTf8RNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748676393; c=relaxed/simple;
	bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0/BTWoebowpRWwQ0LyCN1t0T8J1XAhu1cwr3DYlj7h3J3WCGwaxTUXJw8faPWTDgS5dIBlMv5TZaeq0JDNg5WHNfoRdyiw7Dgq5rT0PnLZegbX/XaoKrhqrj+IxzLI+xjATLxrjP/sMCNsBBSZY8y/diTLQQY9BVrzVcKhQtI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVF3H8vJ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-530807a8691so574788e0c.0
        for <bpf@vger.kernel.org>; Sat, 31 May 2025 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748676391; x=1749281191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
        b=mVF3H8vJudZMrlnGnshjFuzUdweko06tEBl8b4UJ52uh+KP2QtcTmFavN8kud80HBY
         HcyiRasg1RfAkMA4WOxMSS0e4DOGX0+vkQhaj6pFp9DbAvxnPJgmv/vhmxk8aPm/nF5P
         AJnBVLBGTeO+BFqpungoaRPzm0V92qwO37DRm8a8bdJz+dhBH5lOxK5UoX1NscTIbzj8
         lTZryJpe9teUSDaMeu7JJVdIjCYpTVgEEoZPXA0EYwlyl55Y8RY2hxhNtzxtIxb8jl9+
         EynNYSMaggaydKTZODgwso689k95czVWem3vfTa+PPYvKMzcYyx7YXjS3d7PwbEJVf4v
         2VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748676391; x=1749281191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0LYj/eW+1AU4BHmHS1Hd51x+t+f70loUF5+rqrYZxI=;
        b=apNB672p3WH1NDWROJS6niG3YbwtK2YxG62I1pYPINmual/bk1+iyN2j4vwlQ6H9Q4
         I6rVg3Zh6/JAHBYCLbV3+zV6zZtwiJbhwDeGNYL03axuyp3tDtbTLNRnu+lx1c/Mz4HF
         XQgh0nAdLppaNmgO6iiYjrvSj+F0r5eYrF3Bpeax4tftkHyHuW2bu4y+P2PxbchbNHM3
         eCM5qUqedS/YOoqj69CsDjgsO5UyAyFa4A8FbfgBaxHL+JL6HrYz9wGzRfaGSC6aI+nw
         0N/AC71XMN9UCygjSmXZa3yxpyskjcfWZuFlTkeG8FZ0xiVXRFDRbmREjuIE8i90+9hV
         tLkA==
X-Forwarded-Encrypted: i=1; AJvYcCUw9kwYmb8xfjnoRCg1tNLBBNWXvWv9CxEfIuYgUdwxzi6CVjHNstHxh3+xDqi1uK7YrfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+ZVJpegwIXLLYzoKLJIpt92OT5O7A7upiYW6lnnFQL24z/v8
	fAbrEmGuhzaqT6zAO4W+76GCn5I40YAnvf7ZOqTXYklc1KILztGdvr/7mxkjg8LoL7GSlsNSDx8
	wUtnaSDpbLp3hYHRML0yDMR/ZXsckPLFd5PeZC+aM
X-Gm-Gg: ASbGncscE4oSN5wk11BSjK2ZDvKS6q0nyShEY4nlaPB9myqXdcfQTs/fENgW0vwE6D4
	7GQJudX0kmYCyfBZ0BohcuxZrnir7cbap1jDWnUou1bgt0QVMkqzGsYgl0hkWewdYycEgbPaaV4
	AgaVzyBFuLdzUDC15xmhT380ROeq0vQBllRL/BVYzP/I0=
X-Google-Smtp-Source: AGHT+IG7+8v8kogFT0/mnSqsIheQS6+VT2Gk/Es74puVTsuV9tUkd/CTGzoaKIcaMncezCtLdPZlZwKfCwPXYDgxLD4=
X-Received: by 2002:a05:6122:8285:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-53093688632mr459050e0c.1.1748676390966; Sat, 31 May 2025
 00:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com> <aDntjJcJsrQWfPkB@google.com>
In-Reply-To: <aDntjJcJsrQWfPkB@google.com>
From: Blake Jones <blakejones@google.com>
Date: Sat, 31 May 2025 00:26:20 -0700
X-Gm-Features: AX0GCFvP4PKt3NFBYoQVdhXB4HmMLosfmYPKc30P1NvRJeaacdkCzkp9zNZYmwU
Message-ID: <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Fri, May 30, 2025 at 10:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> I think it's better to go to the bpf tree although it'd take longer to
> get your perf patches.

Thanks for the suggestion. I've sent this patch to the bpf tree, and I'll
resend the rest of this series once that change makes its way to this tree.

Blake

