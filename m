Return-Path: <bpf+bounces-76225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B709ECAB198
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 06:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0543086EBA
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946C296BC2;
	Sun,  7 Dec 2025 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VY/qnDeM"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6623BF9B
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765084097; cv=none; b=rn8pXZyvmKhndZ4DGe0CrR6j2E+sY1laLS5bgGU64dx0SQbgayUlONQS9uOm2Bka7hwaXSw9waRLDlKLxyJungssMNYDhIrQT3G8bsp1EJvW5xnDsIuOqIqWi7krk3rBw+Tj5FZb4GwN8zPM7bONNSTM8r2JgJL1kGZl+X1cSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765084097; c=relaxed/simple;
	bh=2C7GSOQoXxcJw12UfPL/U8MuU1cPp4yZ/Gl57GOKRbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsvh/XsU+XKTymz2i9tDcWnO5iim1SDsus0AurhiESs4Ffg12KuarxNJAahiJ6EfWHXsGLN4QKorChFV/VdQ9D9rQhpo6fzvBdPsnba05doB5asIZGUZQMfVhJaeqvP8IsMBlalfFQYeLuCRtFnylDFm+VcRL7fgCbbfJyMf5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VY/qnDeM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765084091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W20ViRj+xUvpr8B5GLMYV/3afB6rwClZITKSt6GkwVc=;
	b=VY/qnDeM8RmCoHew8YC57rjNllvAfGGOm866AE4PRbGWFhCsSnCh/aSVUPkgH7+ytnWAFI
	bTNq/XDTsXIKpnmjNF/bXPg2JdDm/MpzLTFRW0D88zTLadZZbUtjSRLHBzi6s5C0esEhh2
	CRGYtvjMH8+FCOCqSvr+/eZ4oCttsDk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix bpf_seq_read docs for increased buffer size
Date: Sun, 07 Dec 2025 13:07:58 +0800
Message-ID: <5964481.DvuYhMxLoT@7950hx>
In-Reply-To: <20251207005854.2708338-1-tjmercier@google.com>
References: <20251207005854.2708338-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 12/7/25 8:58=E2=80=AFAM, T.J. Mercier wrote:
> Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
> representation of large data structures") increased the fixed buffer
> size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
> didn't get updated at the same time. Update them.
>=20
> Fixes: af65320948b8 ("bpf: Bump iter seq size to support BTF representati=
on of large data structures")

I think we don't need the "Fixes" tag for the document fix?
Therefore, it's better to go to the "bpf-next" tree with the
corresponding tag:
  [PATCH bpf-next]

Thanks!
Menglong Dong

> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/bpf/bpf_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index eec60b57bd3d..4b58d56ecab1 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -86,7 +86,7 @@ static bool bpf_iter_support_resched(struct seq_file *s=
eq)
> =20
>  /* bpf_seq_read, a customized and simpler version for bpf iterator.
>   * The following are differences from seq_read():
> - *  . fixed buffer size (PAGE_SIZE)
> + *  . fixed buffer size (PAGE_SIZE << 3)
>   *  . assuming NULL ->llseek()
>   *  . stop() may call bpf program, handling potential overflow there
>   */
>=20





