Return-Path: <bpf+bounces-73479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572EC3282C
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD33BB001
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74D33DEF2;
	Tue,  4 Nov 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+RZJC63"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18F28751A;
	Tue,  4 Nov 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279387; cv=none; b=Tj6wiHUlHc1X65oUdD7+EizlPnBA12K80uBxKwGEXU7cUE0NZaI56RJ7XZGxBmlzgvMYpg6vdlweODBSNhSpcMvpeu46M2WDrH6iq2Xlo1Zqhxp7ndEvpwPgP9AE1M72WPrz5Bt4egZ+GOSUl9WSFZdxANcL5W/pT6X0y2dE75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279387; c=relaxed/simple;
	bh=yTHmdD9YcsuOkkC1lavTwVmaXqQ6H2lnnnWWkhux+9I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m9Dh5osccNXVrAPUWN1bvwvmMPGfQl3GRBAqdckwgM90vWTnjZCkIT+pnV0nK1KH1erjWR4EbjlXXsCB52ehguSTTT1KuHgFnYBbJ5C6m7fYIVGvLBdfenhh1muN5YX7Q5lCGFEcMXMmwNzm8FQPAsy0Gx2jPoMswNYg0ltXDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+RZJC63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ED8C4CEF7;
	Tue,  4 Nov 2025 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279386;
	bh=yTHmdD9YcsuOkkC1lavTwVmaXqQ6H2lnnnWWkhux+9I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=U+RZJC63DC7DT4PMWm2eU0BQjJXH9nTWLM4ep9sVR0yLoD6gy8bhidThL1NJMi41k
	 qRP7b4guDC9Oc5SifEgaHz4s3a5mUkNWIT8XiUY3J3r9EsWaFVdW+8vDMztMUmobjh
	 f62fX0Z4Z2i52CPu3wN3tY+o+zMuFF/4kfPbmXj4e6AWxhu+6VxGMpmSmBbaOT4LbU
	 iGjkflO/78prUL2RlhDzaPyjiI86qHUZj2j/CfC+BDA3I2dQVmqXpJT09D57RtwY/R
	 15VATqaE4yh7zaxCVw3oNR6ILBX/FU1GdgjGYZUri6TfNBIoYLCFRAwjEfOalNmyPg
	 zbcpevUVOuh0Q==
Content-Type: multipart/mixed; boundary="===============0665663762606247832=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6fbae8b38c532ccd1accfa75df7614f56b6a49d6b4a851b525a59b7a07f33d25@mail.kernel.org>
In-Reply-To: <20251104172652.1746988-4-ameryhung@gmail.com>
References: <20251104172652.1746988-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when registering async callback
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 18:03:06 +0000 (UTC)

--===============0665663762606247832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 865b0dae3..557570479 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_prog *prog)
> +{
> +	struct bpf_map *st_ops_assoc = NULL;
> +	int err;
> +
> +	prog = bpf_prog_inc_not_zero(prog);
> +	if (IS_ERR(prog))
> +		return PTR_ERR(prog);
> +
> +	st_ops_assoc = READ_ONCE(prog->aux->st_ops_assoc);
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    st_ops_assoc && st_ops_assoc != BPF_PTR_POISON) {
> +		st_ops_assoc = bpf_map_inc_not_zero(st_ops_assoc);
> +		if (IS_ERR(st_ops_assoc)) {
> +			err = PTR_ERR(st_ops_assoc);
> +			goto put_prog;
> +		}
> +	}

Can this race with bpf_prog_disassoc_struct_ops()? Between reading
st_ops_assoc and incrementing it, another thread could dissociate the
map:

  bpf_async_res_get():
    READ_ONCE(prog->aux->st_ops_assoc)  // reads valid map pointer

  bpf_prog_disassoc_struct_ops():
    guard(mutex)(&prog->aux->st_ops_assoc_mutex)
    WRITE_ONCE(prog->aux->st_ops_assoc, NULL)
    bpf_map_put(st_ops_assoc)  // potentially frees map

  bpf_async_res_get():
    bpf_map_inc_not_zero(st_ops_assoc)  // use-after-free

The map could be freed via RCU and memory reused before
bpf_map_inc_not_zero() executes. Other functions that access
st_ops_assoc (bpf_prog_assoc_struct_ops and bpf_prog_disassoc_struct_ops)
hold prog->aux->st_ops_assoc_mutex. Additionally, bpf_map_inc_not_zero's
documentation states "map_idr_lock should have been held or the map
should have been protected by rcu read lock."

Should bpf_async_res_get() hold the st_ops_assoc_mutex or an RCU read
lock around the st_ops_assoc access?

> +
> +	res->prog = prog;
> +	res->st_ops_assoc = st_ops_assoc;
> +	return 0;
> +put_prog:
> +	bpf_prog_put(prog);
> +	return err;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19077679684

--===============0665663762606247832==--

