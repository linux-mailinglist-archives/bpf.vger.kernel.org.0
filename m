Return-Path: <bpf+bounces-73865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC9C3B89C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DF2625D61
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F9335BAC;
	Thu,  6 Nov 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFFiXMPU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31C230D0F;
	Thu,  6 Nov 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436863; cv=none; b=EySNiOjhkbNznPzkl9SdWLIUdMbACCcxl0x7oEwH4WxuaqGWRFlb8vKPHlbIXuMnWoO1kO+jnT0doGWBoVTf/LZPR3vvnDGzEt8TUwH6BZ9fHmnsIWbN0PhR8a6BLQoHNXai4k+aT0f8szeaf3HzKMX0VC9IS0pa31f91uDn1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436863; c=relaxed/simple;
	bh=D5+ojXPQ4gle+DVaRqLeJ8qdlQnA4cmPuT0VmHaWAo8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bv/y3/eh3RBuNu/imevz24bQL0O/3ojUdlfxDFNt6jY/S+eXMs+3+vu9kJqTQQc6rMWjL+44IUZeeG/QPAafpZcAYQO9Ktvx5UqX3AqdSQHO47tYYYFYdQKP+XqPN+I3OC/A7QQ3KOjmRwD6CUIqg7FeHpHMGATsO7T6jHQaPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFFiXMPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BDCC2BCB3;
	Thu,  6 Nov 2025 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436863;
	bh=D5+ojXPQ4gle+DVaRqLeJ8qdlQnA4cmPuT0VmHaWAo8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YFFiXMPUO8OqIxtrLjYXJLK9pO2a/cu1nwlL0BVl6hReslrGLAfG3M++QFDMzrbq7
	 buivQCZzjSnfl//Y+6kFJTZvM2YkZZU/tkPix7onFZURiLEjWJ80TcuKv72tIrGv0n
	 mtV7NuYeZ4NtDAkxF+Q4RplnwvYTXZMI8AuSg9BD77HnjzLSkGmNpiYRXd4i3lS7y2
	 BUKS8tCn5HBNBeegHoNbczBAX/aojg0FlhV07ci5gzoK3ijXJNtKZRZHc68q6cKbUN
	 VClKi6pv5H8Jy0I6PwwPYJkkn9aXMcUE1EsDQ3aRLkGMyO3Y2KsnGc6hgUB+o79EoS
	 VPzWJdoCwXKhQ==
Content-Type: multipart/mixed; boundary="===============7811395342483101209=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
In-Reply-To: <20251106131956.1222864-7-dolinux.peng@gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,dolinux.peng@gmail.com,alan.maguire@oracle.com,song@kernel.org,pengdonglin@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  6 Nov 2025 13:47:42 +0000 (UTC)

--===============7811395342483101209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 66cb739a0..33c327d3c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
>
> +/* Verifies that BTF types are sorted in ascending order according to their
> + * names, with named types appearing before anonymous types. If the ordering
> + * is correct, counts the number of named types and updates the BTF object's
> + * nr_sorted_types field.
> + *
> + * Return: true if types are properly sorted, false otherwise
> + */
> +static bool btf_check_sorted(struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	int i, n, k = 0, nr_sorted_types;
> +
> +	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
> +		goto out;
> +	btf->nr_sorted_types = 0;
                            ^

Can multiple threads race when writing to btf->nr_sorted_types here?
Looking at btf_find_by_name_kind()->btf_check_sorted(), I see that
btf_find_by_name_kind() receives a const pointer but casts away the const
to call btf_check_sorted(). The function bpf_find_btf_id() calls
btf_find_by_name_kind() without holding any locks (line 737), and later
explicitly unlocks before calling it again (lines 756-757).

This means multiple threads can concurrently enter btf_check_sorted() and
write to btf->nr_sorted_types. While the validation logic is idempotent
and all threads would compute the same value, the concurrent writes to the
same memory location without synchronization could trigger KCSAN warnings.

Should this use atomic operations, or should the validation be performed
under a lock during BTF initialization before the BTF becomes visible to
multiple threads?

> +
> +	if (btf->nr_types < 2)
> +		goto out;
> +
> +	nr_sorted_types = 0;
> +	n = btf_nr_types(btf) - 1;
> +	for (i = btf_start_id(btf); i < n; i++) {
> +		k = i + 1;
> +		if (btf_compare_type_names(&i, &k, btf) > 0)
> +			goto out;
> +
> +		t = btf_type_by_id(btf, i);
> +		if (t->name_off)
> +			nr_sorted_types++;
> +	}
> +
> +	t = btf_type_by_id(btf, k);
> +	if (t->name_off)
> +		nr_sorted_types++;
> +	if (nr_sorted_types)
> +		btf->nr_sorted_types = nr_sorted_types;
                             ^

The same race condition applies to this write of nr_sorted_types as well.

> +
> +out:
> +	return btf->nr_sorted_types > 0;
> +}

[ ... ]

> @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
>  			goto out;
>  	}
>
> -	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {
> +	if (btf_check_sorted((struct btf *)btf)) {
                                  ^

The const cast here enables the concurrent writes discussed above. Is
there a reason to mark the btf parameter as const if we're modifying it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19137195500

--===============7811395342483101209==--

