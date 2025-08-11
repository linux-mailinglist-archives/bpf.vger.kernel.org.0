Return-Path: <bpf+bounces-65401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0DB2184C
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EBC1887E2F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECF2DECD3;
	Mon, 11 Aug 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="netmX57D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50F22425B
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950973; cv=none; b=m1OBBCOAj82QE7kK/LqxesP2WUSxrUoQpgehFDrtM9S79A//HuJiY7fVIA12eYpwo6mBAy3i1GYazcGQvJQfQg+Za0tlaCfX/0ws0u8SZAZRWTapZ//JWzVgBHyusEH2v2cSCSDdAZMuAS8ZlE6YL2xZ2YxKcsMgOXlYHF1lWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950973; c=relaxed/simple;
	bh=utU4IFpCWHAbSaaIhlArg9nAH82LpriYxTRLkSz28O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqK6TVC/UpYDfM0sDZbk71Ua0ukYdu1FGbDMKS9xmXpSoGC3SzvdQN6gcGDXeMWyhTKjWR3TDWkiAiiM2NyD0N1SQ5cZzJKe+tSS8bpkaXOwaNK4rSQwClMQZGbTdsgVcQwfUSa8BSjEowK0To9FxAZBZNMPs8vbUfwxIk2aqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=netmX57D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05F2C4CEFA
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754950972;
	bh=utU4IFpCWHAbSaaIhlArg9nAH82LpriYxTRLkSz28O4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=netmX57DC4ayPq1E1eF/MVFeT6hoyBg1KZGJaW8H8OvMWPmPwe09N7LwozHxDyWYk
	 9+/7B4V9lFwXvymOYu0heJAyPffS6zmk1ZtLPp/72TYFOXLoedNXtf0RozkW8yuOvB
	 1eWYUm3RWkoOV1prn7LEtes1kAlo21BWBzoBGyrEKDNB75mDeD1VQmZJnpNsK8ty3Y
	 tqq+8Rgpl2WZ1qt/Kj235NF99Cgbf570INGChqNkcHYzNqpmv74AOHsqjOQpXP4Syh
	 8EEdT55WQls8vrpbjlwjZYJ9T/3TWTp1y2UwZM+9VlYjLttf6FugVOJK8C+UDGAddC
	 E9aHamNQauvEQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso7582800a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlzJrLpa+2Oad6zz5N1XNLYuZKe0rHoPyp+PzMD7jQlygkHpPDTBthidExkPT09503urw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzynp7/TWudocWavkXGXjxJuudbr0YJyZ9P16jK9G5cTu0uGvvE
	lcydiZndC0pFsv0FhLyGjcw7nVHJZvrH4gmL3oWkRGO4GL5u6QMeX4LUXENh3yeaD1BZy4sDb98
	QIWylk1WE5B536lkC9r0qGaESzAJnhSXLT5vvAn6B
X-Google-Smtp-Source: AGHT+IFqDV1orE2TgpxB+ErLN3s9x7HnNpyMPPYsQAZOCtLrgYxMtQBz9aLK6MQOpNaAyDjo81a7hrxcv9MieLGa+DU=
X-Received: by 2002:a05:6402:46:b0:618:4ab5:e85c with SMTP id
 4fb4d7f45d1cf-6184ecac96dmr510284a12.34.1754950971377; Mon, 11 Aug 2025
 15:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-9-kpsingh@kernel.org> <0b060832-4f55-486a-8994-f52d84c39e38@suswa.mountain>
In-Reply-To: <0b060832-4f55-486a-8994-f52d84c39e38@suswa.mountain>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Aug 2025 00:22:40 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6xVfebK5NuLD3edjG_UTpKxjJtHo+yVS5wZRZAiUB3HQ@mail.gmail.com>
X-Gm-Features: Ac12FXzm92awyCYFXv8pLv-6O6W2DVP0WLLZed4-_elzPc1Si0Zm4bJEtY3pK1Q
Message-ID: <CACYkzJ6xVfebK5NuLD3edjG_UTpKxjJtHo+yVS5wZRZAiUB3HQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] bpf: Implement signature verification for BPF programs
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, bboscaccy@linux.microsoft.com, 
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> vim +/sig +2797 kernel/bpf/syscall.c
>
> c83b0ba795b625 KP Singh           2025-07-21  2782  static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
> c83b0ba795b625 KP Singh           2025-07-21  2783                                            union bpf_attr *attr,
> c83b0ba795b625 KP Singh           2025-07-21  2784                                            bool is_kernel)
> c83b0ba795b625 KP Singh           2025-07-21  2785  {
> c83b0ba795b625 KP Singh           2025-07-21  2786      bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
> c83b0ba795b625 KP Singh           2025-07-21  2787      struct bpf_dynptr_kern sig_ptr, insns_ptr;
> c83b0ba795b625 KP Singh           2025-07-21  2788      struct bpf_key *key = NULL;
> c83b0ba795b625 KP Singh           2025-07-21  2789      void *sig;
> c83b0ba795b625 KP Singh           2025-07-21  2790      int err = 0;
> c83b0ba795b625 KP Singh           2025-07-21  2791
> c83b0ba795b625 KP Singh           2025-07-21  2792      key = bpf_lookup_user_key(attr->keyring_id, 0);
> c83b0ba795b625 KP Singh           2025-07-21  2793      if (!key)
> c83b0ba795b625 KP Singh           2025-07-21  2794              return -ENOKEY;
> c83b0ba795b625 KP Singh           2025-07-21  2795
> c83b0ba795b625 KP Singh           2025-07-21  2796      sig = kvmemdup_bpfptr(usig, attr->signature_size);
> c83b0ba795b625 KP Singh           2025-07-21 @2797      if (!sig) {
>
> This should be an if (!IS_ERR(sig)) { check.

Thanks, fixed.

- KP

