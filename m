Return-Path: <bpf+bounces-73448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFEC31A4F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C311C4EB9F1
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F832E75A;
	Tue,  4 Nov 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBpPOXof"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16631B80A;
	Tue,  4 Nov 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267949; cv=none; b=CrwAmoi4a/7uogJpsYWwiqKqvGBdgbYs1krpb83Lgxb08vFED8MNzFqDZ1AbmemIwmsd1/N4PSuUzWdnf81h+abY56obRg4pgiPbvjcbH2U2VS3EcUBOh3ArCSbDO1uHTrTlCR9UZy7N93clAVpxf0eeN2P7JMyfmeJSKWJt3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267949; c=relaxed/simple;
	bh=t26y0J3cJ8VCH8gj8vcB4W52aJYOOAIO1pxaM5OANm0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TmnHj3MBFLJe/Tj45mDBq3IAZJO9GgT1nQz4MK3aYkH1NsffdkeN8OpctbL2eOhaHNUG/xnVM1So3RclS0yLD+Lg9I5hNf4Hqdq1lcNokB5oNUg2RTniuNuphbErV7jk+YN1VyLlB1IAQS6/iOxT7h9RjkpCVbFjMLxXsN69wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBpPOXof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D66C4CEF7;
	Tue,  4 Nov 2025 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267949;
	bh=t26y0J3cJ8VCH8gj8vcB4W52aJYOOAIO1pxaM5OANm0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PBpPOXoffuDB2Bbvj0KhG//2uJ5Dj4mudIKwtTiQInHaVVXXp36sQYj8N12pC5jAK
	 aCnc1TBcNpVVYuzG0nEASgUNbiiFe5pOLgM3HGArl13njXDaYBuAUJhy5upF/UkuM1
	 FvxYUlkpDPTq9pDS0LA+H/LhFfko7FnqwKDm2WxLfjVnmDd8/N5QCgqUKfobDUBtBu
	 ygCmZ8pLWH8X8CZay/aRvMj9pnNzqb0pHT0ygp3cF1sGEqefcy0uGwsA6Bt2jGPe86
	 wH2GslLC3liIjSHe9S7Ivn8XMoSEW0x6dHG5VLtJ0zE8+A0/7lqtdlBkF0EZnJQtQE
	 cYohs3vcJTUjQ==
Content-Type: multipart/mixed; boundary="===============7773523901444292637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6099162df8322a2198497a8a27e1b0e1e5c017aeb74b20fc1eecde1e67826900@mail.kernel.org>
In-Reply-To: <20251104142714.99878-3-leon.hwang@linux.dev>
References: <20251104142714.99878-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add test to verify freeing the special fields when update [lru_,]percpu_hash maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,memxor@gmail.com,ameryhung@gmail.com,linux-kernel@vger.kernel.org,kernel-patches-bot@fb.com,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 14:52:29 +0000 (UTC)

--===============7773523901444292637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 893a4fdb4..87b0cc018 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c

[ ... ]

> @@ -568,4 +568,64 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
>  	return 0;
>  }
>
> +private(kptr_ref) u64 ref;
> +
> +static int probe_read_refcount(void)
> +{
> +	u32 refcount;
> +
> +	bpf_probe_read_kernel(&refcount, sizeof(refcount), (void *) ref);
> +	return refcount;
> +}
> +
> +static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
> +			    struct node_data __kptr **node)
> +{
> +	struct node_data *n, *m;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return -1;
> +
> +	m = bpf_refcount_acquire(n);
> +	n = bpf_kptr_xchg(node, n);
> +	if (n) {
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(m);
> +		return -2;
> +	}

In __insert_in_list(), after bpf_kptr_xchg() stores the new object in
the map and returns the old value in n, can the error path drop both
n and m? At this point, the new object (pointed to by m) is already
referenced by the map. Dropping m here would free an object that the
map still points to, leaving a dangling pointer.

The test itself never triggers this path since it initializes the map
with zeros first, so the kptr field starts as NULL. However, if this
test were extended or this pattern copied elsewhere, the incorrect
error handling could lead to a use-after-free.

> +
> +	bpf_spin_lock(lock);
> +	bpf_list_push_front(head, &m->l);
> +	ref = (u64)(void *) &m->ref;
> +	bpf_spin_unlock(lock);
> +	return probe_read_refcount();
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19072261328

--===============7773523901444292637==--

