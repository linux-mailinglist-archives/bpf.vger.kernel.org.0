Return-Path: <bpf+bounces-31367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764DE8FBB61
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EFB1F2249F
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAD14A4DB;
	Tue,  4 Jun 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd+u6eTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DE12E1CE
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524996; cv=none; b=VlHJa76l4n778NetCrODrfi/DFOARlmr4fOiP0wTr+N9bWQK0uIpm52fa/k7EYp76mgr4lzWSwXkum9hl0jpAMXeDnLQTIntZY1psnhZZ1ZI2l1cX3ZcUGRqSFlV+Vmp0rkfnW1X8BHzrIeiBnxaSUlRN5mxn4B7T6hmi+Pv/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524996; c=relaxed/simple;
	bh=IijgShTUtDT3XubshoHCfh6sYcXhQ3gZmcmPyQ1ipcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipJ0YfdN5VD9ZlehQ7/kYaFaWTpLB8HBiB7Gb6mhpEzF+UupDXkkHYLaBou8o2/JdErBDXoYjZYhWR23zf6s+o47Yk7TOD/kMSdfQAZAFZYMWpPhlnlihJKE3iCG3ENgMuShcA9IM0j2eaCISI+Mp5CWJhDoqKIxmH+MJ0zsssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd+u6eTV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f62217f806so51202775ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717524994; x=1718129794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpg/XGfZO6pvDCJx1zTIUPGsLVyUIzkc+dltYl+wqlw=;
        b=Fd+u6eTVlfHeoXg/7qDmOy2Rh/AWQ9MD07m25LGw361Y7L6QdwSReZ7VtHOHRZfz/E
         oKY4mDi1/HJu9X/d8UYFkKcdUiO42gDtDAVsl1X1NqjUqAWkGxFXWzwrieVrdfB0nUQI
         a6cwfEg+ivzBKHvkKJWaed57tyXSKW19TSdHsHHatrackQYWejT9tsGIs27kbvFftJF5
         3+LELgc12M8qnwRwndfoBLUxFMx0i1+ht6xoy47oKmxWEWnRqi1UHIJjPyayDccZ+bz1
         b33IrLrnVTwYSFzUIyUag//YZYbQeDoZFSwtWu8sf6flCXwbXY/vKWr+Z0xhW1CTuC1j
         HA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524994; x=1718129794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpg/XGfZO6pvDCJx1zTIUPGsLVyUIzkc+dltYl+wqlw=;
        b=okFmshIsoaxkuRM9ZTuR0cikzpAet+0F53yhbi9mVgrd/Y8f8klYxep1ju1pfPVIBr
         rkurX2Y9vM/g4kt+6SPYRri3WhH0ZWwpEtHxgTVbed6upPDr7gVSy4x0UPjFnIP0Le/S
         S/OHqTdfUJr89LD5qn11nJRC1D0O7tt+sFhXE5MLC7aGrBTRRDTy/GYzyqPNLDhNI2dy
         MR8AG+lMu0ieYMbrl3ierB+kkMkblgedQWfKC5khDNqee8wzhTsRO20h6ab8Rhod02ay
         4OlQvskDm88gLP91s6zSi6vAXKQz36jUk5vt46Ft3l9GQZ6Rhv40ulEbW1BfDx3qJIyQ
         GV8g==
X-Gm-Message-State: AOJu0YzQ9D2syb1HqSbdArVLPNsfCiL6P2WJ1Vf55jDAH8M8LPEzMyZE
	T86YVSSZtqLKR0lJgoantc8dNTlMJ3TRfjwm+bQkHjKGvyD+ouCVx5V5fqAGJNOMa4oyvUU6Vr8
	92cQbhvChC4JRaIKyKdNHW/3Jen4=
X-Google-Smtp-Source: AGHT+IH9YJUFd6Un0+WAIOdMsDHqkfPlGOqrwpR0zweDiPGeqqd9MOXYf9zBcr6ZpxJyWC54/a8we3gxr8xwFHi7FI0=
X-Received: by 2002:a17:902:eccf:b0:1f6:77fc:c555 with SMTP id
 d9443c01a7336-1f6a5a698a4mr3556885ad.45.1717524994392; Tue, 04 Jun 2024
 11:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603155308.199254-1-cupertino.miranda@oracle.com> <20240603155308.199254-3-cupertino.miranda@oracle.com>
In-Reply-To: <20240603155308.199254-3-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 11:16:22 -0700
Message-ID: <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular expression.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:53=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> This patch changes a few tests to make use of regular expressions such
> that the test validation would allow to properly verify the tests when
> compiled with GCC.
>
> signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
>  tools/testing/selftests/bpf/progs/exceptions_assert.c    | 8 ++++----
>  tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
>  tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
>  tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
>  5 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 66a60bfb5867..64cc9d936a13 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
>   * mem_or_null pointers.
>   */
>  SEC("?raw_tp")
> -__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_")
> +__failure __regex("R[0-9]+ type=3Dscalar expected=3Dpercpu_ptr_")
>  int dynptr_invalidate_slice_or_null(void *ctx)
>  {
>         struct bpf_dynptr ptr;
> @@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
>
>  /* Destruction of dynptr should also any slices obtained from it */
>  SEC("?raw_tp")
> -__failure __msg("R7 invalid mem access 'scalar'")
> +__failure __regex("R[0-9]+ invalid mem access 'scalar'")
>  int dynptr_invalidate_slice_failure(void *ctx)
>  {
>         struct bpf_dynptr ptr1;
> @@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
>
>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
>  SEC("?tc")
> -__failure __msg("R0 cannot write into rdonly_mem")
> +__failure __regex("R[0-9]+ cannot write into rdonly_mem")
>  int skb_invalid_slice_write(struct __sk_buff *skb)
>  {
>         struct bpf_dynptr ptr;
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
> index 5e0a1ca96d4e..deb67d198caf 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
> @@ -59,7 +59,7 @@ check_assert(s64, >=3D, ge_neg, INT_MIN);
>
>  SEC("?tc")
>  __log_level(2) __failure
> -__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,smax=3D=
smax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,s=
max=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")

curious, what R0 value do we end up with with GCC generated code?

>  int check_assert_range_s64(struct __sk_buff *ctx)
>  {
>         struct bpf_sock *sk =3D ctx->sk;
> @@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
>
>  SEC("?tc")
>  __log_level(2) __failure
> -__msg(": R1=3Dctx() R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
> +__regex("R[0-9]=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,smax=3Duma=
x=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
>  int check_assert_range_u64(struct __sk_buff *ctx)
>  {
>         u64 num =3D ctx->len;
> @@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
>
>  SEC("?tc")
>  __log_level(2) __failure
> -__msg(": R0=3D0 R1=3Dctx() R2=3D4096 R10=3Dfp0")
> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3D4096 R10=3Dfp0")
>  int check_assert_single_range_s64(struct __sk_buff *ctx)
>  {
>         struct bpf_sock *sk =3D ctx->sk;
> @@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *c=
tx)
>
>  SEC("?tc")
>  __log_level(2) __failure
> -__msg(": R1=3Dpkt(off=3D64,r=3D64) R2=3Dpkt_end() R6=3Dpkt(r=3D64) R10=
=3Dfp0")
> +__msg("R1=3Dpkt(off=3D64,r=3D64)")
>  int check_assert_generic(struct __sk_buff *ctx)
>  {
>         u8 *data_end =3D (void *)(long)ctx->data_end;
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
> index 3fecf1c6dfe5..8399304eca72 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bp=
f_rb_node *b)
>  }
>
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")
>  long rbtree_api_nolock_add(void *ctx)
>  {
>         struct node_data *n;
> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
>  }
>
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")
>  long rbtree_api_nolock_remove(void *ctx)
>  {
>         struct node_data *n;
> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
>  }
>
>  SEC("?tc")
> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_rb=
_root")
>  long rbtree_api_nolock_first(void *ctx)
>  {
>         bpf_rbtree_first(&groot);
> @@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
>  }
>
>  SEC("?tc")
> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")

this test definitely should have been written in BPF assembly if we
care to check alloc_insn... Otherwise we just care that there is
"Unreleased reference" message, we should match on that without
hard-coding id and alloc_insn?

>  long rbtree_api_remove_no_drop(void *ctx)
>  {
>         struct bpf_rb_node *res;
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 1553b9c16aa7..f8d4b7cfcd68 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bp=
f_rb_node *b)
>  }
>
>  SEC("?tc")
> -__failure __msg("Unreleased reference id=3D4 alloc_insn=3D21")
> +__failure __regex("Unreleased reference id=3D4 alloc_insn=3D[0-9]+")

same, relying on ID and alloc_insns in tests written in C is super fragile.

>  long rbtree_refcounted_node_ref_escapes(void *ctx)
>  {
>         struct node_acquire *n, *m;
> @@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
>  }
>
>  SEC("?tc")
> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)

ditto

>  {
>         struct node_acquire *n, *m;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
> index ee76b51005ab..450b57933c79 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
> @@ -799,7 +799,7 @@ l0_%=3D:      r0 =3D *(u32*)(r0 + %[bpf_xdp_sock_queu=
e_id]);    \
>
>  SEC("sk_skb")
>  __description("bpf_map_lookup_elem(sockmap, &key)")
> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")

same here and below


>  __naked void map_lookup_elem_sockmap_key(void)
>  {
>         asm volatile ("                                 \
> @@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
>
>  SEC("sk_skb")
>  __description("bpf_map_lookup_elem(sockhash, &key)")
> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>  __naked void map_lookup_elem_sockhash_key(void)
>  {
>         asm volatile ("                                 \
> --
> 2.39.2
>

