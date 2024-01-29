Return-Path: <bpf+bounces-20616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED758410B1
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8321C23FD6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6515956A;
	Mon, 29 Jan 2024 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuSJcWsK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EA6166D;
	Mon, 29 Jan 2024 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548923; cv=none; b=YLHkYWe1EHxRzD4L3QHU6btEbuKBsaI2s8HjXohPHp6KwnftVnvUBHOUuOWpEwSkG+jYXZSMUpaJgXWlxQKt7K+cfP7HsNir94V5mg+9Z1RZj8QHNTKpEQB6Q+OPNe47Sf67Oj3bJv36s+icFhZQ/luw09vpSpD9HHIu40fAUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548923; c=relaxed/simple;
	bh=JYBbAYWNibVPSsm2aZM9pxXWuL6jTBf0j8mHiaK44Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTUabhWI/zT+bvR+du/PURsC4h64iGE8aI1gbRkyBokUzn4ki/XGbaTMZWAFw/Z9yLJcHYHtyzRHICw1rjjscDX9kE3JQPMgfXVrgx9NE5Qq5rdsPbGdxlVCS+ehVz64hzS0mCrwXaw10PdHyJpvVzngYSgc40r5mhaIds3w4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuSJcWsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE569C43394;
	Mon, 29 Jan 2024 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548923;
	bh=JYBbAYWNibVPSsm2aZM9pxXWuL6jTBf0j8mHiaK44Ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WuSJcWsKXENTUCDGo/2nsNi6XSHrUZkGChuEAemYPjjWcD24F3le6iVqtY5fwq+UK
	 dHRcUvJZnQPfqFvyR8tEV0GnOh5pPWNl3rmy5mb35Ox3L+Mxp6T5T5hQ7+7gV6gAL1
	 l6HCG62UU0EHCKnyebU+Ti+Bh1ECzWaKwuDdJnixKEqgf7mU+j5enjgXz9SkeXWyav
	 AIpWIf3fuc5wt3yzSwoGrtZHY4xrn35E6Suj5d+7w/LlBI+4oVTqHPLFnm1zFD59EB
	 akVkxhg9PAkJ5oh6k/W4QYOTg/5/VuExl0z8aV7Kj1j6HqKvZKij4FAXSL6cQT4/UO
	 KAcKErCsFpkBg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so36483251fa.0;
        Mon, 29 Jan 2024 09:22:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwNm39VZQxhm9sf74jwCo6cOjBggLocfQeyAEfyVXKeg8wta0IR
	i2UlcfXUsTge+R1MXQeitGYUL9dDDHZZ1AuzLsIoEs+UkIkHVBEFgLKESHiak99oWG9IjB9z9Dg
	AoO5Iq+biVE9gCEHxSaJi1HMndjc=
X-Google-Smtp-Source: AGHT+IG0VAb/ekeITVOF0bS7rfDDvzjNwelO3EtNC/hYjAZLD6sUGghOToyiYKiqSggijHySxsSuWcZVmbTpRn3TFGY=
X-Received: by 2002:a2e:b8d1:0:b0:2cf:457e:61fa with SMTP id
 s17-20020a2eb8d1000000b002cf457e61famr4993469ljp.37.1706548921169; Mon, 29
 Jan 2024 09:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123103241.2282122-1-pulehui@huaweicloud.com> <20240123103241.2282122-2-pulehui@huaweicloud.com>
In-Reply-To: <20240123103241.2282122-2-pulehui@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 09:21:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5fr5-wz1Q_AvuVCwSJ=byE+wVrKcKXrnJQjshn8Hc-sw@mail.gmail.com>
Message-ID: <CAPhsuW5fr5-wz1Q_AvuVCwSJ=byE+wVrKcKXrnJQjshn8Hc-sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Use precise image size for struct_ops trampoline
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> For trampoline using bpf_prog_pack, we need to generate a rw_image
> buffer with size of (image_end - image). For regular trampoline, we use
> the precise image size generated by arch_bpf_trampoline_size to allocate
> rw_image. But for struct_ops trampoline, we allocate rw_image directly
> using close to PAGE_SIZE size. We do not need to allocate for that much,
> as the patch size is usually much smaller than PAGE_SIZE. Let's use
> precise image size for it too.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Song Liu <song@kernel.org>

