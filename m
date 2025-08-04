Return-Path: <bpf+bounces-65012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B8B1AA0C
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195163B8854
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC42264CB;
	Mon,  4 Aug 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF5yiqCd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82AA920;
	Mon,  4 Aug 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339121; cv=none; b=kZ3pm6Ar7ws0oktIopw+6C9Su5XTbTL1gcYMm9xL3IMe2G+Ig6h9LmPZKbnFB0KSVN9NMLREaG2I6V49HsAQX70y9AWOBWnTt8tMbWXLXBC03BAosg9ZH4JQLWyyfujY0nZFl7n/fTdxwmJxxMdDLD/vD49tbwNMt9Mllh+YjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339121; c=relaxed/simple;
	bh=wXQvDqeRFPqa4qyoolm+7SHsR2N2boCqypUXM9XJOAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gfXkO1+oIrJ9fOCNQ4WzPeCoGc8NUXZI6a/GV5gjT6SJb5DOPH6oyw6Njtq7X3MwnYzHHcf/Dkgd2+ssAx41JzmLkLPY05QTx9SaF6rOpXKDdImrPAmOmZUwmVMMoW7rZ8csMkPxruIAzbAAserXs44ZNd10fbWzUcy6yI1MDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF5yiqCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1119C4CEE7;
	Mon,  4 Aug 2025 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339121;
	bh=wXQvDqeRFPqa4qyoolm+7SHsR2N2boCqypUXM9XJOAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RF5yiqCdbFesMwe5gXm5kizfwYWRGWmm5JsxDeI29YAQOdEt+CPCBwwZVtPxzWmkp
	 DvgAyrNEnuJCQRZ0agZtmpTpWxfiDFITUmqTV+If4RoZJ00/DaVZzeRZyU9UvAwQJY
	 0fk8dnVimcA1qa7jFQv0/VPCM/fy1+jkkeRoODmksPHXmaig7+EwF6xqAn5e7BN9EY
	 eNDciDsiaWYaQlvW7n+tZXOsofJdeHSQTSjDao2bBSc6YhtEjUeeoYxt/8rhTr7RZS
	 GPG0E/93q29/p/TE8fOgkSoQPLwJ0aYkJqqo0sk9/ThZQGPBF3nXXbUzAAV+5QWjCa
	 xMvIuwHt9LkxQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 01/10] riscv, bpf: Extract emit_stx() helper
In-Reply-To: <20250719091730.2660197-2-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-2-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:25:18 +0200
Message-ID: <874ium4yxd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> There's a lot of redundant code related to store from register
> operations, let's extract emit_stx() to make code more compact.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

