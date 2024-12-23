Return-Path: <bpf+bounces-47560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B399FB5F2
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403F71885F3A
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA281D61B9;
	Mon, 23 Dec 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Agyrt4dk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8751AE01E
	for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987448; cv=none; b=DJxhpXTDohkutERQk55nL48bhnFzrsvwq/NLup4fZhDJpRH8pT2GkPKeUK/rLjBbZ8OOs9mfzcTpDwWXfKxdkngspUH8bmlSrzIvxhGRAHI65WbgVJ6+mxy/ccICBGXxTFWRLutgJ/wrGOeCiCDvg9dRl5GiF0QgqRXWBYqN09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987448; c=relaxed/simple;
	bh=2DztFD4apdvC8stTVS+VecbKHNgB6uuuS7owdy7LcTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmBnHtSVJcqQCNxiqu+YHfraXUxRrvYjdmxlhLql3VccFMV2h4bftxDGvfJVi3niAzvEqKyFCiOUtrHuc/f89Pk4Djc/gzpzvp9S8NhrWkMegThZr9YTxiNAeibVvT03tY7ynQBhwt/wySiTDiAYzhnFjbex3vNFWG4+D/CIsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Agyrt4dk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so530361366b.0
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734987444; x=1735592244; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OGEqWYFSgt4bPFSAnPtuSoRF9ILoLLRxjytbsVMptA=;
        b=Agyrt4dkASc9uE9zuXsnHGdfWMeV23HIDe+0M3VmKOR4sag79PnER8okfeq54Poa9m
         V77ht8Da0mzbFrztKziQxBxa8ChUWSZfYbBxF/HKIsCHEnJITm1N3euy0nxjCO2eHhH/
         NjXgZRYXiQErem6LeJ8kCKPvhp0ihQr+0AiOTJCsH6whiT4RMUmHZLz9hi6Bcgb7DwB/
         aeRB5Mxztbgom8cfDGGxvzJFYxFhdX6Z3j1ziVyN30u8I/2Q7zpi75un2s2j+qJmfdaY
         88NNl2o08w+Z30hWRJPXh9rK9SNyFftVlqZpGanygqpSjyEbAIEsPoX170evyPcujLkO
         rdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734987444; x=1735592244;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OGEqWYFSgt4bPFSAnPtuSoRF9ILoLLRxjytbsVMptA=;
        b=XzQwPmlBEgwRNBM2EsxH4gFu9GKrOTlkXrh9mv++bO3+vk0E2ksGkj6bQInWL9iE1f
         sBtUIAQ5cRKSHR7QrfI6EqpHFkJDp2s7JOcUpu+QzSet+J2q/NBwOqB+Bi/qF2sCVMm8
         qEInoa8iU+sgmD0ZDNJm6k9eJ2iXsr9xTzmnJPU7x5ZFelOGvv69njaM1PFLREKkD50f
         TH8Mq8ylFPpr8Rz7bOIRjIj1Sx0JU6skt3h3fVDmkB7Qcc3B57yv3zf38DFDFf+Cv4gl
         FqMUSSL84NbLOkWmza8ouAz4YFHHcb+c/2nGScckOsvxINTy7A+1S4tSdr3ouFdurF9N
         ThTQ==
X-Gm-Message-State: AOJu0YyzCLMkiXxQjIKS258ciZUJbb0hC3+ffUO0WaKXotKEuNamOn02
	7ehKoBbkDF9+J5NcZmdGzW/lxBRc1adPB6Zon5z0RFO77X6zVBNfo1ABAZdXH8M=
X-Gm-Gg: ASbGncvC6kj3jDtS9sM8+hlF3cL6OENUMyIrAW46Vwpew3czO5vgAWTtc0LubJmQIN4
	42fMOQlg4rWwo+et2LrLb7jJtjUIGd5ajtTgPEEQzXAeTZjIVlTWHXW4nyWImEeemgHG82Z27en
	6BZC2Xchy7gEclRhn0/AfjZbpANLNwq0nh4I8Jl/84/89ulLhSnXDUIVBh8IazzWiBRgE8DFvWe
	BHUUVTFxD50qXCEm2tsfa3oK2hEAL1hJEGJe/ePj2o/7nAdfg==
X-Google-Smtp-Source: AGHT+IElHOy1IFO9H4rPqHyMyH8kWxBbQzZbW/MtUiptFTg1JwzlcXcWubdOmY3q8sfa31+CT4IWBQ==
X-Received: by 2002:a17:907:d9f:b0:aac:619:7ed8 with SMTP id a640c23a62f3a-aac28748b30mr1413613766b.7.1734987444422;
        Mon, 23 Dec 2024 12:57:24 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:507b:2387::38a:19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895075sm562478166b.51.2024.12.23.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 12:57:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,  martin.lau@linux.dev,  ast@kernel.org,
  edumazet@google.com,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  song@kernel.org,  andrii@kernel.org,  mhal@rbox.co,
  yonghong.song@linux.dev,  daniel@iogearbox.net,
  xiyou.wangcong@gmail.com,  horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
In-Reply-To: <ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
	(Jiayuan Chen's message of "Thu, 19 Dec 2024 17:30:53 +0800")
References: <20241218053408.437295-1-mrpre@163.com>
	<20241218053408.437295-2-mrpre@163.com>
	<87jzbxvw9y.fsf@cloudflare.com>
	<ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
Date: Mon, 23 Dec 2024 21:57:22 +0100
Message-ID: <87h66ujex9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 19, 2024 at 05:30 PM +08, Jiayuan Chen wrote:
> Currently, not all modules using strparser have issues with
> copied_seq miscalculation. The issue exists mainly with
> bpf::sockmap + strparser because bpf::sockmap implements a
> proprietary read interface for user-land: tcp_bpf_recvmsg_parser().
>
> Both this and strp_recv->tcp_read_sock update copied_seq, leading
> to errors.
>
> This is why I rewrote the tcp_read_sock() interface specifically for
> bpf::sockmap.

All right. Looks like reusing read_skb is not going to pan out.

But I think we should not give up just yet. It's easy to add new code.

We can try to break up and parametrize tcp_read_sock - if other
maintainers are not against it. Does something like this work for you?

  https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2/

Other minor feedback I have:

- The newly added code is optional and should depend on
  CONFIG_BPF_STREAM_PARSER being enabled. Please check that it builds
  with CONFIG_BPF_STREAM_PARSER=n as well.

- Let's not add complexity until it's really needed, and today we don't
  need seprate tcp_bpf_proto_ops for IPv4 and IPv6.

- There are style issues with the added test. Please run checkpatch.pl.

