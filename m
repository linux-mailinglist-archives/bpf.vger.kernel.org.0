Return-Path: <bpf+bounces-31524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDB8FF38E
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EA51C264AB
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A61990A2;
	Thu,  6 Jun 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arKCHZqS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA83197A8F
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694364; cv=none; b=q3OzN+BqTqsNRmZE7x7nKi6J+PaDtjS/tAxuCUoeD0Halzt1thTiYnW1oe4X0RQg1uVWacveGlgvBvHYT3HojlcWSdVUL+j1vCr2PPZmSmumET1JNClptrZvJyogiwDA+RAV6MN+k1Peyzx9e7SheeIKweZdc/WuMPf6ikVTuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694364; c=relaxed/simple;
	bh=XbDem8jVT9bOVpvSslPJyul+I6OQFXhR3nIhksmc7qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHB6cRFmYFvUqAjmcS2o/2yz8RIrIY3YpTHF13/5QBoO8l+pplxxSTDjCFozjAICdX82URrDpU03wJg+Wht+s+WRZg4WcjlX93h3ibp0TGFwYxyeJBE6vBRGievWAAez2pek0XY0YZ2VyKHWYAQcKiVstguVvEsaE5Fjj5XcrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arKCHZqS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso1021367a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694362; x=1718299162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt0pjTztcu4n8lTF/hF2b2G0S3c9WiJ59+7WZnT1DAM=;
        b=arKCHZqSE3a7rRDVxFMiyfeeqQK8K+j0GYYs4P1pwkPCNeVS8CQ3T+s90bbUBH+YRC
         PH6UUMbBL3yt9fFRjVPHBCKo+vdUT4Hn/ID+k/Imf1mtiXr8bdACfeIZLpoKbxSenudt
         jy+u5yNY2bsW01m/riHhHEbAgydjMNflWIjrIDAG4ewvOe54gQr+2RARPdFZh4uTLcjs
         08bau5u3HGQ6SE5fB47VRY5+5vb0fjGA1g+ix37s5aB9BWuWjFonfWHWqjGaQhx7vqkB
         dqvPBmHQymTNok2Kvf9sl66u1YAGvVmTLukZcdP1vicF4T+ZF/9OdAU6wOyZ8zU3K7fB
         jnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694362; x=1718299162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt0pjTztcu4n8lTF/hF2b2G0S3c9WiJ59+7WZnT1DAM=;
        b=WDMi6d3AyPeBQgtmPp3gZX5JE1hV1QAAYVLA64bWa7iWdyM5E+Vg3GbCAr5m9lJVrH
         +/F6mWMsydd6qaN1zy65bJwXQUfcnsMeaserZ1ouY8G4nEKqaKyn7s3ekRnNiDHvA5FM
         dzpIxkbkC/0QVh+Xu7OQFp+gSFE9wgpCHO9GsErjD6LMxPff8EdNFuuHXn5ONPxN4TC/
         gIs4ud/3FJzgDpdj8uURzIWg4//7tYtnouAgyar/FKK2a6ImA0sGfPGm4qW2XGOnKS9j
         c98Fvcbfeyy/wPcD39MdUPN/6kuWbAc6tmwo0smZaaWZxBGYTR/NiE4lVwPkcPNM5+fF
         KQ0Q==
X-Gm-Message-State: AOJu0YzYYOF1/Gt48/aRpQ92vxdmKoeW088QV28wzFPpu0wUeKBCLLPT
	u6rUwNbHVQn2O/6pQVUtm16urM1SWoksEpdaCQm5yjELq698XyS+cYqirGe3uUc/fPhhd39jkQI
	wUCM5kplAflfcqRn5PSR5bY3+XZY=
X-Google-Smtp-Source: AGHT+IFhultLvABPoAzW4dKSKwhxKa/4ntgpi/2Iqa9dsOBQgq/dHMlzP3XO3tr1yBDLA7Y0t3f3SLpZySjWkf//GYA=
X-Received: by 2002:a17:90a:5a86:b0:2bf:ea42:d0c3 with SMTP id
 98e67ed59e1d1-2c2bcad6277mr162571a91.16.1717694361758; Thu, 06 Jun 2024
 10:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
 <20240603155308.199254-3-cupertino.miranda@oracle.com> <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
 <87ikymz6ol.fsf@oracle.com>
In-Reply-To: <87ikymz6ol.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 10:19:08 -0700
Message-ID: <CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular expression.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:50=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Andrii Nakryiko writes:
>
> > On Mon, Jun 3, 2024 at 8:53=E2=80=AFAM Cupertino Miranda
> > <cupertino.miranda@oracle.com> wrote:
> >>
> >> This patch changes a few tests to make use of regular expressions such
> >> that the test validation would allow to properly verify the tests when
> >> compiled with GCC.
> >>
> >> signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> >> Cc: jose.marchesi@oracle.com
> >> Cc: david.faust@oracle.com
> >> Cc: Yonghong Song <yonghong.song@linux.dev>
> >> Cc: Eduard Zingerman <eddyz87@gmail.com>
> >> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >> ---
> >>  tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
> >>  tools/testing/selftests/bpf/progs/exceptions_assert.c    | 8 ++++----
> >>  tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
> >>  tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
> >>  tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
> >>  5 files changed, 15 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/t=
esting/selftests/bpf/progs/dynptr_fail.c
> >> index 66a60bfb5867..64cc9d936a13 100644
> >> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> >> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> >> @@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
> >>   * mem_or_null pointers.
> >>   */
> >>  SEC("?raw_tp")
> >> -__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_")
> >> +__failure __regex("R[0-9]+ type=3Dscalar expected=3Dpercpu_ptr_")
> >>  int dynptr_invalidate_slice_or_null(void *ctx)
> >>  {
> >>         struct bpf_dynptr ptr;
> >> @@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
> >>
> >>  /* Destruction of dynptr should also any slices obtained from it */
> >>  SEC("?raw_tp")
> >> -__failure __msg("R7 invalid mem access 'scalar'")
> >> +__failure __regex("R[0-9]+ invalid mem access 'scalar'")
> >>  int dynptr_invalidate_slice_failure(void *ctx)
> >>  {
> >>         struct bpf_dynptr ptr1;
> >> @@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
> >>
> >>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
> >>  SEC("?tc")
> >> -__failure __msg("R0 cannot write into rdonly_mem")
> >> +__failure __regex("R[0-9]+ cannot write into rdonly_mem")
> >>  int skb_invalid_slice_write(struct __sk_buff *skb)
> >>  {
> >>         struct bpf_dynptr ptr;
> >> diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/t=
ools/testing/selftests/bpf/progs/exceptions_assert.c
> >> index 5e0a1ca96d4e..deb67d198caf 100644
> >> --- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
> >> +++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
> >> @@ -59,7 +59,7 @@ check_assert(s64, >=3D, ge_neg, INT_MIN);
> >>
> >>  SEC("?tc")
> >>  __log_level(2) __failure
> >> -__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,smax=
=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
> >> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff8000000=
2,smax=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
> >
> > curious, what R0 value do we end up with with GCC generated code?
> Oups, this file should have not been committed. Those changes were just
> for experimentation, nothing else. :(
>
> >
> >>  int check_assert_range_s64(struct __sk_buff *ctx)
> >>  {
> >>         struct bpf_sock *sk =3D ctx->sk;
> >> @@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
> >>
> >>  SEC("?tc")
> >>  __log_level(2) __failure
> >> -__msg(": R1=3Dctx() R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,=
smax=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
> >> +__regex("R[0-9]=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,smax=3D=
umax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
> >>  int check_assert_range_u64(struct __sk_buff *ctx)
> >>  {
> >>         u64 num =3D ctx->len;
> >> @@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
> >>
> >>  SEC("?tc")
> >>  __log_level(2) __failure
> >> -__msg(": R0=3D0 R1=3Dctx() R2=3D4096 R10=3Dfp0")
> >> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3D4096 R10=3Dfp0")
> >>  int check_assert_single_range_s64(struct __sk_buff *ctx)
> >>  {
> >>         struct bpf_sock *sk =3D ctx->sk;
> >> @@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff=
 *ctx)
> >>
> >>  SEC("?tc")
> >>  __log_level(2) __failure
> >> -__msg(": R1=3Dpkt(off=3D64,r=3D64) R2=3Dpkt_end() R6=3Dpkt(r=3D64) R1=
0=3Dfp0")
> >> +__msg("R1=3Dpkt(off=3D64,r=3D64)")
> >>  int check_assert_generic(struct __sk_buff *ctx)
> >>  {
> >>         u8 *data_end =3D (void *)(long)ctx->data_end;
> >> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/t=
esting/selftests/bpf/progs/rbtree_fail.c
> >> index 3fecf1c6dfe5..8399304eca72 100644
> >> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> >> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> >> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct=
 bpf_rb_node *b)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_ro=
ot")
> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf=
_rb_root")
> >>  long rbtree_api_nolock_add(void *ctx)
> >>  {
> >>         struct node_data *n;
> >> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_ro=
ot")
> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf=
_rb_root")
> >>  long rbtree_api_nolock_remove(void *ctx)
> >>  {
> >>         struct node_data *n;
> >> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_ro=
ot")
> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf=
_rb_root")
> >>  long rbtree_api_nolock_first(void *ctx)
> >>  {
> >>         bpf_rbtree_first(&groot);
> >> @@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
> >> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
> >
> > this test definitely should have been written in BPF assembly if we
> > care to check alloc_insn... Otherwise we just care that there is
> > "Unreleased reference" message, we should match on that without
> > hard-coding id and alloc_insn?
> I agree. Unfortunately I see a lot of tests that fall in this category.
> I must admit, most of the time I do not know what is the proper approach
> to correct it.
>
> Also found some tests that made expectations on .bss section data
> layout, expeting a particular variable order.
> For example in prog_tests/core_reloc.c, when it maps .bss and assigns it
> to data.

I haven't checked every single one, but I think most (if not all) of
these progs/test_core_reloc_*.c tests (which are what is being tested
in prog_tests/core_reloc.c) are structured with a singular variable in
.bss. And then the variable type is some well-defined struct type. As
Alexei pointed out, compiler is not allowed to just arbitrarily
reorder fields within a struct, unless randomization is enabled with
an extra attribute (which we do not use).

So if you have specific cases where something isn't correct, let's go
over them, but I think prog_tests/core_reloc.c should be fine.

> GCC will allocate variables in a different order then clang and when
> comparing content is not where comparisson is expecting.
>
> Some other test, would expect that struct fields would be in some
> particular order, while GCC decides it would benefit from reordering
> struct fields. For passing those tests I need to disable GCC
> optimization that would make this reordering.
> However reordering of the struct fields is a perfectly valid

Nope, it's not.

As mentioned, struct layout is effectively an ABI, so the compiler
cannot just reorder it. Lots and lots of things would be broken if
this was true for C programs.

> optimization. Maybe disabling for this tests is acceptable, but in any
> case the test itself is prune for any future optimizations that can be
> added to GCC or CLANG.
> This happened in progs/test_core_autosize.c for example.

We probably should rewrite such tests that have to deal with
.bss/.data to BPF skeletons, I think they were written before BPF
skeletons were available.

>
> Anyway, just a couple of examples of tests that were made very tight to
> compiler.
>
> >
> >>  long rbtree_api_remove_no_drop(void *ctx)
> >>  {
> >>         struct bpf_rb_node *res;
> >> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c =
b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> >> index 1553b9c16aa7..f8d4b7cfcd68 100644
> >> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> >> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> >> @@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct=
 bpf_rb_node *b)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("Unreleased reference id=3D4 alloc_insn=3D21")
> >> +__failure __regex("Unreleased reference id=3D4 alloc_insn=3D[0-9]+")
> >
> > same, relying on ID and alloc_insns in tests written in C is super frag=
ile.
> >
> >>  long rbtree_refcounted_node_ref_escapes(void *ctx)
> >>  {
> >>         struct node_acquire *n, *m;
> >> @@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
> >>  }
> >>
> >>  SEC("?tc")
> >> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
> >> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
> >>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
> >
> > ditto
> >
> >>  {
> >>         struct node_acquire *n, *m;
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools=
/testing/selftests/bpf/progs/verifier_sock.c
> >> index ee76b51005ab..450b57933c79 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
> >> @@ -799,7 +799,7 @@ l0_%=3D:      r0 =3D *(u32*)(r0 + %[bpf_xdp_sock_q=
ueue_id]);    \
> >>
> >>  SEC("sk_skb")
> >>  __description("bpf_map_lookup_elem(sockmap, &key)")
> >> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> >> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
> >
> > same here and below
> >
> >
> >>  __naked void map_lookup_elem_sockmap_key(void)
> >>  {
> >>         asm volatile ("                                 \
> >> @@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
> >>
> >>  SEC("sk_skb")
> >>  __description("bpf_map_lookup_elem(sockhash, &key)")
> >> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> >> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
> >>  __naked void map_lookup_elem_sockhash_key(void)
> >>  {
> >>         asm volatile ("                                 \
> >> --
> >> 2.39.2
> >>

