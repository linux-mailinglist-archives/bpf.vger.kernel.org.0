Return-Path: <bpf+bounces-73271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 532EEC2971E
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C0E18861A9
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2E1DC198;
	Sun,  2 Nov 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+V7KptX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49AF9EC
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762118458; cv=none; b=cp/dpgoAPa5m0Gx5PYzrbBxJLO3NsIjt4ImZEeB15/c3IeeZ7HwDHTA3K6KjNvac5UM7yRrmLOCHSyJWUmatjpTsgeX9r2tQuo5Hh6KVUQroWD6gzB/w5kBpCenolNY36Au3anmvptizFYiesyHsP8tcGVq3Al8XoSGtdseAP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762118458; c=relaxed/simple;
	bh=1/DsmwgQ8TC+DU1l13dZM16JDscP4bblDDYUdvnus7A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kDiEZOJnHl4JtkGiugYolPWWR6jr9H5O6kgXQIoCv/Z0bjSEMKf4yN4Nl33PG7HDeHDbpUVngpkMiiDRUrl4s8C6VzVB1wP4mpfDal0GLcBbmErQPOn+jXClTdBpv+EjMHTjhe3DUyPBeID3jWn99AXWDZDGUjN9cCiwvFsniD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+V7KptX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8805AC4CEF7;
	Sun,  2 Nov 2025 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762118457;
	bh=1/DsmwgQ8TC+DU1l13dZM16JDscP4bblDDYUdvnus7A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=b+V7KptX6C0B49Vpcq6/v1BrMYKDQrMszjSGtsbNRc9ZOlWx7KAEOd0lNYX1dR0Cc
	 UMydmuOH81OJf4Q41c7qBCyJjCDfsXroBL9YAgqKYYEPkFdBO3i8hsd0mUigw0qdU7
	 3XBhNAnXLtP5ystrRAPL3sVc7kRm8gOGq4cD08rhaxZc3Ao5C8+flL2Zd8DSOWn9vo
	 ND73e+wHN15HbhqxPZ6J1z6h9VKWMbBL5mouPOS+e1tfqUx3o4JhaHKjtwW1b5pEpn
	 tkFpiyjk3K8VHSn6lidEuayiEt+d7EPba9FUEUaVlK5IyR9AtcwK0uY26PHJNykjK9
	 9Nv1rxO32txLA==
Content-Type: multipart/mixed; boundary="===============3400970971500147850=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fff3a198c4d0f8abc33f6d1633585ccb13f1709786bb9f5080641631f69628df@mail.kernel.org>
In-Reply-To: <20251102205722.3266908-7-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-7-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v10 bpf-next 06/11] bpf, x86: add support for indirect jumps
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  2 Nov 2025 21:20:57 +0000 (UTC)

--===============3400970971500147850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 6cb8001495faae09541d55309638b3c1920bae06
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf, x86: add support for indirect jumps

This patch adds support for indirect jumps in BPF through a new
BPF_JMP|BPF_X|BPF_JA instruction. It introduces the PTR_TO_INSN register
type for instruction pointers loaded from INSN_ARRAY maps, along with
verifier support for tracking jump tables and x86 JIT implementation.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[ ... ]

> @@ -21374,6 +21374,28 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
>  	return 0;
>  }
>
> +/*
> + * Clean up dynamically allocated fields of aux data for instructions [start, ...]
> + */
> +static void clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
> +{
> +	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	int end = start + len;
> +	int i;
> +
> +	for (i = start; i < end; i++) {
> +		if (insn_is_gotox(&insns[i])) {
> +			kvfree(aux_data[i].jt);
> +			aux_data[i].jt = NULL;
> +		}
> +
> +		if (bpf_is_ldimm64(&insns[i]))
> +			i++;
> +	}
> +}
> +
>  static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  {
>  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> @@ -21393,6 +21415,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt
>
>  	adjust_insn_arrays_after_remove(env, off, cnt);
>
> +	clear_insn_aux_data(env, off, cnt);
> +
>  	memmove(aux_data + off,	aux_data + off + cnt,
>  		sizeof(*aux_data) * (orig_prog_len - off - cnt));

Can clear_insn_aux_data() correctly identify which aux_data entries need
cleanup when it's called after bpf_remove_insns()? After instructions are
removed, the insns[] array has been modified - insns[off] now contains what
was previously insns[off+cnt]. But aux_data hasn't been shifted yet, so
clear_insn_aux_data() checks the wrong instructions when deciding which
aux_data entries to free.

For example, if instructions [1,2] are removed where insn 2 is a gotox:
- bpf_remove_insns() removes insns[1] and insns[2], shifts later insns down
- insns[1] now contains what was insns[3]
- clear_insn_aux_data() checks insn_is_gotox(&insns[1]) (now insn 3!)
- It might free aux_data[1].jt if insn 3 is a gotox, even though insn 3
  isn't being removed
- It never checks the original insns[2] which was the actual gotox that
  needed cleanup

Should clear_insn_aux_data() be called before bpf_remove_insns() instead?


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf, x86: add support for indirect jumps`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915

--===============3400970971500147850==--

