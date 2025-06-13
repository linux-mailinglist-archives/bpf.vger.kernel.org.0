Return-Path: <bpf+bounces-60552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F43AD7F5F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D2B16FFF9
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956B34545;
	Fri, 13 Jun 2025 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHM2dMmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30972619
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773156; cv=none; b=O7Adf+n/qz6d3b20Q8L9uHF6H6yrWle849AMkasc9DZemKqeoK2OLctSxPQ7Y4FCodpwPmygu62sx9vZpTG3UV1Ou7R6J8IIcXJSpisnIDZ66Afdi7M4TK+UWoc1gTXSG0SwrZ85WWFZCRI312VkuzKZEXU9E6NxdpKW7pK52W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773156; c=relaxed/simple;
	bh=Nd3cKNWGl5bKvi+bImgZ1oKnVlZ8gMBbQgLiCP768P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0NWimkoKwlYlt8m013JJ1XRxU5KjaQnE37I1+IlMcr6R7lbWwCF9OZcWoPgBAJFmSCrqDWxu5wC3g2LlstJTNtj60OiLVprqt3f3pkl5YzWtxdxihpPrM2Kc1Udc0Qr9Qnu7Hbr2TNcwx23HWxs9+z1DZdHzTXjJ0aSS8gCEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHM2dMmz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1410060b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749773154; x=1750377954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpeMeMoFffJniJpfyk1KR5/CdbLGYJFC2JPbovQOICw=;
        b=LHM2dMmzYSDsHaOF7AAhWcJYKQSnDbHDYwWLnr3S3wo3a4ZLkotkbFESsOzDbO6a7f
         9WbjP7Q3hhh1vqRQLSNtQIbdW+DgrIomvrQi81VCLqrJsOU4JjdL5UosLuj3Ii1N5qEO
         Q5+0Q/idZUglO69aox62VeMWRChxU2FaVIi5lo0wqTSa5h2/G/UAyl2qpyXli0+Hds6p
         Ha/1rqnNMAE4r2Bz2D+6tidpxChw03oYSCNt7NrU759CJkmRyJgrKNtrmxQSsLjjT5z+
         MrlDfnWV0oRw2uZWPWRmQfu9Y/zKVYiHMICwjzRt+UJIjWiEM921jgewmqZD/wTQ5bgc
         9L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773154; x=1750377954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpeMeMoFffJniJpfyk1KR5/CdbLGYJFC2JPbovQOICw=;
        b=awOXLxJ7v4Z2dwlI9sQ45zNSxQQeJZIHz4v7dVKBc0tKxxnaDoRXxzuLSaEsdDh5XW
         Kn9sBVUWze8Wzweig4U90ZR7Y6ha6P4Y6qFcuDQ+emeIkQut9HJX4OS2d/Fy0tlZJFT4
         +XirISVno721ZvFC4HPM8Ff1HlZgsYUrGaTHt1c24gXsq8dOk7PhzfogUxE7Bf0HHq/k
         ogfEcw2mPTSrOaXfzlm45CycLM+44DK9dS+Sqzndyb6tHwtBZqla/YC4JzXOfCsxu7F+
         maMlB0lvHHnG0DC0YF4CVsNNs3rfypGjQtkcBMzPQWMphGjJm1gJtR0EF3iTzBOOw6hs
         YLdQ==
X-Gm-Message-State: AOJu0YzAqXK6gVWpnRNcekWZ4kiXOjRJyZTXotr2hZD/0j7+7NRmn+uD
	Xkif4P4ry7VYJSRQXWs3QyRcq3Wj3zE21VhlN1CyFPsuEtQG0S/+3IHz/n7/Kvx0+Cx7/g0v0+A
	6ehIDzAn77k2Zr/V61SNfIGkbHmfdSRo=
X-Gm-Gg: ASbGncvqW3jsAePkU/I8G8qm24F3pCWumf+KMtA/kT/fd744oEXVCQfW1HcRL/dG/cx
	wymxPTsHXPeXehD08aUgPRSUEMXyBQLB6W8pSN9rgD7YTG1tW+R9PSFc10fjFc/I8fp762ts4eM
	Ycj7MghGjRPRsFd/6s5T+WuwclYSsc6op0G9MS7lBxcP6WBq3JJFsge+m2JO0=
X-Google-Smtp-Source: AGHT+IF7NQKoXWQPnv/XvU2+BB2HLCqcrUWNiytkIZT/LckCW8wumDQCfm+AEGOzicvjY+Elcdeb5o5vPW3nzhLD6Jg=
X-Received: by 2002:a05:6a20:7348:b0:21f:8d4f:9e3b with SMTP id
 adf61e73a8af0-21facbaecaemr1259862637.7.1749773154174; Thu, 12 Jun 2025
 17:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612130835.2478649-1-eddyz87@gmail.com> <20250612130835.2478649-2-eddyz87@gmail.com>
In-Reply-To: <20250612130835.2478649-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 17:05:42 -0700
X-Gm-Features: AX0GCFv6nkqY9-Zuk9ExL8CbrCF_zh5f9XqnY-FQSQknmDkiGPtXsJPS10FQaLc
Message-ID: <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory allocations
 in memcg statistics
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This commit adds __GFP_ACCOUNT flag to verifier induced memory
> allocations. The intent is to account for all allocations reachable
> from BPF_PROG_LOAD command, which is needed to track verifier memory
> consumption in veristat. This includes allocations done in verifier.c,
> and some allocations in btf.c, functions in log.c do not allocate.
>
> There is also a utility function bpf_memcg_flags() which selectively
> adds GFP_ACCOUNT flag depending on the `cgroup.memory=3Dnobpf` option.
> As far as I understand [1], the idea is to remove bpf_prog instances
> and maps from memcg accounting as these objects do not strictly belong
> to cgroup, hence it should not apply here.
>
> (btf_parse_fields() is reachable from both program load and map
>  creation, but allocated record is not persistent as is freed as soon
>  as map_check_btf() exits).
>
> [1] https://lore.kernel.org/all/20230210154734.4416-1-laoar.shao@gmail.co=
m/
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/btf.c      | 15 ++++++-----
>  kernel/bpf/verifier.c | 63 ++++++++++++++++++++++---------------------
>  2 files changed, 40 insertions(+), 38 deletions(-)
>

We have a bunch of GFP_USER allocs as well, e.g. for instruction
history and state hashmap. At least the former is very much
interesting, so should we add __GFP_ACCOUNT to those as well?

[...]

