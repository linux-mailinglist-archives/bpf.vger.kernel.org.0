Return-Path: <bpf+bounces-9965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CF79F421
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FFEFB20793
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF322F17;
	Wed, 13 Sep 2023 21:52:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1ACB667
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 21:52:29 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F31981;
	Wed, 13 Sep 2023 14:52:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so233071f8f.2;
        Wed, 13 Sep 2023 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694641947; x=1695246747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y22xCLlEZQBWLQ/c3kPpCNo4gCkKFSaDNlTQ+FhFUkE=;
        b=rT3Dz8FxaaUV9uQ75S1BaLLjmQ7n9CzXfcfp63500Awfi3I0LiJ0SdC8MKZ93ZvB+4
         4y4vb3khMFTDidPzG2w8au4RljrzPfaOxT9QK397R/Ddkqcw8elEeLBOkGmMB/pQxkfe
         0qFFBI1KHMLxtyIjIHUxB3n7RDV0uV9XDficpbZMIvHhWUGCIe0XPsWHE3Ek/timO4sW
         kFEb9i7SRVNefuTREa+h+NDFigwWXxqMyXIfe9aBY9RC9Z0m9XpnxDW0DCbuzbjKyqU1
         9YJXYFfVw3PeET1OHcQuSxiKx+FdyChdxwKctU7uVu+8X2d2mNh6ICm5ytlI9ABB77fK
         eSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641947; x=1695246747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y22xCLlEZQBWLQ/c3kPpCNo4gCkKFSaDNlTQ+FhFUkE=;
        b=XBhafSL/7iA45TaLIjGePhsV1bCpBerKcjKDWlnugx/gurtGnfhPv3b0Q6j8w8lW3u
         oxtEdT+xaXBJZE+IiT65Izmpp+AsiNn/C0vo9EqW0x908R/fteZy81pVTaeaamjGLkur
         3CWg3I29tNSkLS6X+/1YirQPV+Zzppcg4928bDRGVtlv6ZpUo45UsdtP2a5AOg6bCrB5
         UfzR3BDWUDJKFwuwPw4OY/yxFqAEAXippLzvvGl9zQnybJLzGNE8AYtu7fUdGTv26aC/
         HSaT92199eUVozwFtFJsP2m++wEHt8W3Xxg+MJAXdvA5G6jS6h+aPrVWWLUTD1d2Fx1w
         g5kA==
X-Gm-Message-State: AOJu0YyUiK3VTuf7el2bmBBiDf4xNeg+7Z+fP/mTrl6LPU9JhtkEZQE4
	QGqsi3jR9LPxJwvVe6Tye3dRXTK8JUElndB0vBQ=
X-Google-Smtp-Source: AGHT+IFAQyQmUXz2sHGS3Ql6YprUUCD8o13TqJ9WBgCQiUZg5aTylujKxz3cnSYF2vfq7Vo9anIh8GYVq5187jvMutw=
X-Received: by 2002:a5d:440d:0:b0:317:73d3:441a with SMTP id
 z13-20020a5d440d000000b0031773d3441amr3307728wrq.46.1694641946701; Wed, 13
 Sep 2023 14:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913214554.97356-1-puranjay12@gmail.com>
In-Reply-To: <20230913214554.97356-1-puranjay12@gmail.com>
From: Puranjay Mohan <puranjaymohan@gmail.com>
Date: Wed, 13 Sep 2023 23:52:15 +0200
Message-ID: <CANLeO8KAC=6v4OOG7wv14RfsrMumcpQycr+0f_op1ZPEN=dnQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/1] bpf, arm64: support exceptions
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Sept 2023 at 23:46, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Kumar is working on adding exceptions to BPF and enabling it on x86 [1].
> I am working with him to enable it on ARM64 and will later do it for
> other architectures when the basic exceptions support is upstream.
>

Sorry for the noise.
Please ignore this [resent] email.

Thanks,
Puranjay

