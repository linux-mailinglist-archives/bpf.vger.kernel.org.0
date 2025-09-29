Return-Path: <bpf+bounces-69940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E05BA881B
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968A3171331
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889DA26A08A;
	Mon, 29 Sep 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UttOKA4p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC81E1DE5
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136568; cv=none; b=s/HoqY82sGpi3nTIiighgUDJ1x9mu1kDtD1FMGS9NtJaWZioqiaZtIQKDf0kmuiJXCQ6K/31GmHQtU8JOCaL88ePvWTTzhI9Pe1Aia2IbHouIbKn8egc8D2izubvG6x59xR5gh9i7/yVFB6Bc937hlb1XNaUxHBB7hzyf4LH4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136568; c=relaxed/simple;
	bh=HbDR50AGAGqCWFE9RBG/GDxS3ix8J3y9vF7AjGkkqsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA09nfVCbhz2Y6WNOWXeJIxNNSQjaXqt0y8clPXSdzM8xgpM2tx7QSAL6zQQcvC4dlz2X0f8mMrS7TtpbWvuhxEKPObntD+1YOlxEOlFOncUhiYe3LXW+I75vTaWkajVEwDvylanEqPok/aEEDXEjarAlo7d33gZjQQFgiuqNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UttOKA4p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so32422605e9.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759136565; x=1759741365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbDR50AGAGqCWFE9RBG/GDxS3ix8J3y9vF7AjGkkqsw=;
        b=UttOKA4pm7qI+GYJAYwp3/4jzuxebTvk42SUxkENl17IixX9jlmso0HGbR1xEJZYVO
         y9h9GBBmGuxvaK9VTsAbOdfERKmqX7Fh5V5uBOTLRssIqkfGdpTENFdDTdxQsCeg7a3p
         T9LxKSmDv7wI9ZF/0yo1YcI17V6bf3bhgxSDAuJeQLUkeH3sBoprl5h7z66TSN2P81UN
         4PHSODbPPaCtIvhzi355x8XtR4pMgNYNvOi/4Aene7Cfl31zCRO65R7zPaH0+f2rgKpU
         mmuwzcAl++QEZVOTIcOCsd9L9Pg+PBkSexS6mr8McksUv6sOcSxLTW8e6WWf4xCthQO4
         3nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136565; x=1759741365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbDR50AGAGqCWFE9RBG/GDxS3ix8J3y9vF7AjGkkqsw=;
        b=sUM85VW4mccRxBZqKT7lUCE8rj6nMhwZniLsE8p0EsZhs6j+666YxKS6ghv5jl1k54
         pGKiTC8IEvJeH7ML94LioiX7Gi2ltxYBYxOrj0fABQjLcyfBgSq7EcMAG13KImUSarVq
         doswRkUmNlCsdtE5cM0R2tTJG5p1Ys+70AkmmqQ56f7SqOg4uyWSYzCJl6Ikhkenfi+/
         yapDKhIDSr9CzX58r7hAoV9DW//pfg8p2xtZC5jY/XUqZq0/Z4Hhj2XbdGVhPfn8Rzky
         ANcuFmKsrXoxlz5GvsJ/opTLiYf1KTa19IH50RbsHahtElyl2o3rBxKql0X0i3nDCYW0
         HVKQ==
X-Gm-Message-State: AOJu0YzNjuije1CLJmc0o07jHzET2cne2j6yzMCfnHhfFMF3wBhm76f6
	ie8zZhB2rgR2M8+9PboGwy0dAeBUkQTIMnVpU8d+ReDth+Jc7rvUNeSk7skm+5yOGO44BQQjqbv
	pDxQPErpGp+qRC5ZUS/Bw08TTnVMUr/4=
X-Gm-Gg: ASbGnctzeAzAi7AfYmuj0/V2zf/C6t/6E32m2SQHbUpOLCqgDvJh+7QIUMeBCeLol0E
	vLrcaETjpcRJcZFX5Y0GwTELtpH5n9j7PVxGV1BhyZre8PaiiEcDSgD5h/+b3M0OShO9Pj/ndsj
	PtZFDXGQjtHXdLEf81J3Z0YtVLF0RAN4QH6HPzFoxHfmQIzvdR11+Dj9ZDCY1PQn8E96/MP9F31
	CmVnA==
X-Google-Smtp-Source: AGHT+IE5VCULlJEEtq/OIAqRQgmiR2iiq1YUFiZcIao4n7vQKXxhLzOn1UOh5lyPB3W4tM4t2LpDcaj4ecfMwDcqYk0=
X-Received: by 2002:a05:600c:1986:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-46e32a057c2mr131581055e9.27.1759136564518; Mon, 29 Sep 2025
 02:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927205304.199760-1-memxor@gmail.com>
In-Reply-To: <20250927205304.199760-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Sep 2025 10:02:33 +0100
X-Gm-Features: AS18NWBVLVQpHRJXRNZmA3aS0Ig3ZTVLl_IKPIsfu6QrMFKrnv30nA13LkopHXQ
Message-ID: <CAADnVQJDEMXmvFJzcug-bpZoYaghKOY+8u1uCo2=3-r60Xg3Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add stress test for rqspinlock
 in NMI
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 9:53=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Introduce a kernel module that will exercise lock acquisition in the NMI
> path, and bias toward creating contention such that NMI waiters end up
> being non-head waiters. Prior to the rqspinlock fix made in the commit
> 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters"), it
> was possible for the queueing path of non-head waiters to get stuck in
> NMI, which this stress test reproduces fairly easily with just 3 CPUs.
>
> Both AA and ABBA flavors are supported, and it will serve as a test case
> for future fixes that address this corner case. More information about
> the problem in question is available in the commit cited above. When the
> fix is reverted, this stress test will lock up the system.
>
> To enable this test automatically through the test_progs infrastructure,
> add a load_module_params API to exercise both AA and ABBA cases when
> running the test.
>
> Note that the test runs for at most 5 seconds, and becomes a noop after
> that, in order to allow the system to make forward progress. In
> addition, CPU 0 is always kept untouched by the created threads and
> NMIs. The test will automatically scale to the number of available
> online CPUs.
>
> Note that at least 3 CPUs are necessary to run this test, hence skip the
> selftest in case the environment has less than 3 CPUs available.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20250926235907.3357831-1-memxor@gmail.com

pw-bot fell asleep. The patch was applied yesterday.

