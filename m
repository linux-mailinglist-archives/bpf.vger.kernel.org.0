Return-Path: <bpf+bounces-74590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD92C5F88E
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAC35CD97
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9A301460;
	Fri, 14 Nov 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVez5jdh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E235898;
	Fri, 14 Nov 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160697; cv=none; b=F8Yg7axEVNSD0KUI6oTkY5YV41pDgkcLE9gIF2xPCl358+93CWFzaiSoHRxzlRebUd6MArGTZrHL0kKMXIjsgULHZgvF1ihgKhf7PbkPamRa/S0ozxFX9cfj92A1S41iNd7EeRLgUWkxeQ7QCTXa8my5HdMUlCksKIg3jzRc7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160697; c=relaxed/simple;
	bh=2yV8JhWlv0Astt8KudvmzHYW8ACcv0aWPv9YfTnG/SU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rXNQgJm8efJ3VyDYOpX1doluIcfI6xnbuGO/EcyXmoKgbD9a585L7T6Nf+541KgTUnr2woZstWJT5uOHgJUvA9JWW4b1eJiUJVpSRYvvpsECt1bgEtFtXmq0/xM8lEbHfODuCsLTONxRBD4vgI4Bebz6J44qPI9esZlPswHlPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVez5jdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3232EC4CEF1;
	Fri, 14 Nov 2025 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160696;
	bh=2yV8JhWlv0Astt8KudvmzHYW8ACcv0aWPv9YfTnG/SU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PVez5jdhnquBOsRtoJC/1Gdrmaxix9KCUaKCcCTN7P6exoZJ606REXqEtRHC1weIs
	 xrHa3pJ4ikSPb3fVzok0bRjAcWwAhL+Ecr2rzHnJ3mH6yHxg/or5NFDyENkCP6JeJM
	 aQF9nx1gu1nkdGwkRT+GDU8hvMgm6f2FKlFI+l4NQQuFZYbU46Tq+c1eYNPlDEN1m9
	 Q/wvRJJnr2UbpXl3fHaGJBVJrvSSfvKGR7w7WwhfeJ3VMlsa6Tny7kG2m5+XFKqFmg
	 jRZcnGhuS7qXokgNCiYMDdzW1lQQR/MVZSkRqsEOopdzuRIQq6r5EXVduuMehkF2Mo
	 /Iv6N1rxbRzEw==
Content-Type: multipart/mixed; boundary="===============1933662450940188420=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
In-Reply-To: <20251114221741.317631-3-ameryhung@gmail.com>
References: <20251114221741.317631-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Support associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 22:51:36 +0000 (UTC)

--===============1933662450940188420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index a41e6730e..626aa9197 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c

[ ... ]

> @@ -811,6 +822,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
>  			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
>  		*plink++ = &link->link;
> +
> +		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
> +		if (err) {
> +			bpf_prog_put(prog);
> +			goto reset_unlock;
> +		}

Can this double-put the prog reference? In bpf_struct_ops_map_update_elem:

  prog = bpf_prog_get(prog_fd);              // refcnt = 1
  bpf_link_init(..., prog, ...);             // link takes ownership
  *plink++ = &link->link;                    // link stored in st_map
  err = bpf_prog_assoc_struct_ops(prog, ...);
  if (err) {
    bpf_prog_put(prog);                      // refcnt = 0, prog freed
    goto reset_unlock;
  }

Then at reset_unlock:

  bpf_struct_ops_map_put_progs(st_map);      // calls bpf_link_put(link)

The bpf_link_put will eventually call bpf_link_dealloc()->bpf_prog_put(link->prog),
attempting to put the already-freed prog reference. This looks like a use-after-free
if bpf_prog_assoc_struct_ops fails (which can happen when a non-struct_ops program
is already associated and returns -EBUSY).

Should the error path skip the bpf_prog_put and let bpf_struct_ops_map_put_progs
handle the cleanup via the link?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19379369447

--===============1933662450940188420==--

