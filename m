Return-Path: <bpf+bounces-60208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE47AD3F63
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27F33A4506
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F22239E95;
	Tue, 10 Jun 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq4NoVjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB91494CC
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573945; cv=none; b=pZq+cgYODzppiFToKSi56yfUyJbe0R+xbKStWH457r9YjU9WKXp9JF7kzglEPuRgTs36bF4pVeKJ+8lNxAYOil8Scg51Bdu3dqGGTAvrvtiGUbUAPqnFmWJFK6k7ey5Sy2OZoPl8/Qxno6YXsgvozkCbh89aCOuO6VmBokqh158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573945; c=relaxed/simple;
	bh=XsQiHcimeh6Cmf2APHqKLrrlNOcRZ1yK77dtDdyjiag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSjuuhvzdaWSRK+vMzZpQomqFab4OUs5fsIeC5pCli4tfT/UcSbFhT3Arl8PbmozfRdyqnBG85qwkDeoTRjS1W/PWin+Zan0zfzhy88wJlcP0YkNa+Q816bXqoITWy0Ns6l3lgmujdgJ/PrR8gm6zlbOQjPoXEopqw/vuwh8o4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq4NoVjI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso5292219276.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573942; x=1750178742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0IIv5yDyniLUZTK2Pm5zd6QeVxF8nIXASjXHPRi95g=;
        b=Aq4NoVjICqMDL12oYkKTfGB9mwBx1L8MC+YrjUJ/Y1ej1OTUOOgOenye5rgBh5hhie
         oWxMXYbNemjcYcJyfsMZCOuubZy/St3jMAvPgqvR9fXeNKt59+NlDt0v51Rk8OZctE0i
         U/Wcud2OKrqKjFu4zMzyF6BCjK2wHTViJFK7rEgeIGXTHe7CtFJ6JuTAyI7j8wPg3vMb
         iwcUA/jJ8K16fm5lCn92ZlJybmloWiJj7ih41lv1TgFj884Kc6CDVJWmeoXVVPs2xKi9
         84yw+HZGQGQESiFPNu3MYR3e5B3biU/ubxvEM5AIHDBUeYt3u4ib8vsC4VjVIgad7EjU
         hfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573942; x=1750178742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0IIv5yDyniLUZTK2Pm5zd6QeVxF8nIXASjXHPRi95g=;
        b=HagkiRCOVIW2TiWDlqMKUogdsv7RG/Gw7Z04DyL1QuQBCXyhS9xIrEh1C47I5jYED7
         MuH59qIB3XMgAsGK8GKAFvQX2GNyBwlkR7dD7+W5m1GGPEcW6RKO8qpO/2xf1rkaKKDY
         XTjGWFvkGp/bdYM1ZKDIFHYzvPQ1B1F5VudWm0+jN17fjG5BQdDfhqYJagjFednsCd2a
         o+duRjTmburvubGxaaPLqZyeODgW/4Hql18sqe8Mqg4xvTPtBppSyMF0f8kqDzMiEkNq
         VIbp6NL8AouCTvMp0o9zeDqX4bfb5oLwQFGjR+fuaYV8MUr60OrhdXsxHBDXKgLwy/oH
         VHzw==
X-Forwarded-Encrypted: i=1; AJvYcCW95hDI29tVTXni6SUyjlm3zQFcVZc5rAu+K2nvIpYHLtQu2SK9Vp9n0pt5Rg09duUqP6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrizzEHd83M8I9UQOKzN2a5lUb36taFnuJwKU19tcjHQeKi+1u
	XDa36D0+shwjvvKLORkS6oqAYwJ5MJqsxPR1VHWJio9vc8qk1/jVaLMomIZFDB7XJ42/mivMWTf
	IhoMbrvGLe6g7O+1xnsNQJFBJ0mVeUPg=
X-Gm-Gg: ASbGncvBGkD1gCt8CHxBT3MpNpIKVoOZM3I+EuCbgus4kOKbmqRFFipcdlgUaLrt4y0
	6L9a+6kNPs1WOdp9XaaG6TV7AZbqk0Crv3HAlxMmTA/VgB7Fc/Pc6BINMvquPfaXTj72WwkzFd/
	KMKIlnjI8+mctcRgtdACOsod5Lvbt8i8TkUrMIWfFtUns=
X-Google-Smtp-Source: AGHT+IEZj2UwRghgJOQ+x0T2dTUBfsgHlBGY2dRZMzDqUsGHHdxKkr+w8S1ycXwYNk0ZN1F3BkBs9Uetzab1czDHhyI=
X-Received: by 2002:a05:6902:12c6:b0:e81:b0ae:43c0 with SMTP id
 3f1490d57ef6-e81fe6a3ed7mr401309276.27.1749573942522; Tue, 10 Jun 2025
 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-4-ameryhung@gmail.com> <8c4943cb40967d152abe032b4208a7cdd89b539da26783afaa61e37eb6663cbf@mail.kernel.org>
In-Reply-To: <8c4943cb40967d152abe032b4208a7cdd89b539da26783afaa61e37eb6663cbf@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 10 Jun 2025 09:45:31 -0700
X-Gm-Features: AX0GCFvFewdnyka08ySjSCO9SiUHin3bBeOE24bM4c7Rb6B3J_AWj_duXT7i_F8
Message-ID: <CAMB2axPNx3d4MtSri+2iYujUhKsFerbZzD6xvA8RyJwxEprZeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Test accessing struct_ops
 this pointer in timer callback
To: bot+bpf-ci@kernel.org
Cc: kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:42=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [bpf-next,v1,4/4] selftests/bpf: Test accessing struct_ops th=
is pointer in timer callback
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D970053&state=3D*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1554714778=
8
>
> Failed jobs:
> test_progs-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions/=
runs/15547147788/job/43771213307
> test_progs_cpuv4-aarch64-gcc-14: https://github.com/kernel-patches/bpf/ac=
tions/runs/15547147788/job/43771213280
> test_progs_no_alu32-aarch64-gcc-14: https://github.com/kernel-patches/bpf=
/actions/runs/15547147788/job/43771213268
> test_progs-s390x-gcc-14: https://github.com/kernel-patches/bpf/actions/ru=
ns/15547147788/job/43771045529
> test_progs_cpuv4-s390x-gcc-14: https://github.com/kernel-patches/bpf/acti=
ons/runs/15547147788/job/43771045522
> test_progs_no_alu32-s390x-gcc-14: https://github.com/kernel-patches/bpf/a=
ctions/runs/15547147788/job/43771045519
>
> First test_progs failure (test_progs-aarch64-gcc-14):
> #409 struct_ops_this_ptr
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #409/1 struct_ops_this_ptr/test1
> run_subtest:PASS:obj_open_mem 0 nsec
> libbpf: prog 'test1': BPF program load failed: -EACCES
> libbpf: prog 'test1': failed to load: -EACCES
> libbpf: failed to load object 'struct_ops_this_ptr'
> run_subtest:FAIL:unexpected_load_failure unexpected error: -13 (errno 13)
> VERIFIER LOG:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Private stack not supported by jit

The selftests failed to pass CI since bpf_testmod_ops3 is using
private stack. I will change selftests to be based on other struct_ops
in bpf_testmod.c

> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #409/2 struct_ops_this_ptr/syscall_this_ptr
> run_subtest:PASS:obj_open_mem 0 nsec
> libbpf: prog 'test1': BPF program load failed: -EACCES
> libbpf: prog 'test1': -- BEGIN PROG LOAD LOG --
> Private stack not supported by jit
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test1': failed to load: -EACCES
> libbpf: failed to load object 'struct_ops_this_ptr'
> run_subtest:FAIL:unexpected_load_failure unexpected error: -13 (errno 13)
> VERIFIER LOG:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #409/3 struct_ops_this_ptr/struct_ops_this_ptr_in_timer
> libbpf: prog 'test1': BPF program load failed: -EACCES
> libbpf: prog 'test1': -- BEGIN PROG LOAD LOG --
> Private stack not supported by jit
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test1': failed to load: -EACCES
> libbpf: failed to load object 'struct_ops_this_ptr_in_timer'
> libbpf: failed to load BPF skeleton 'struct_ops_this_ptr_in_timer': -EACC=
ES
> test_struct_ops_this_ptr_in_timer_common:FAIL:skel_open_and_load unexpect=
ed error: -13
> #409/4 struct_ops_this_ptr/struct_ops_this_ptr_in_timer_after_detach
> libbpf: prog 'test1': BPF program load failed: -EACCES
> libbpf: prog 'test1': -- BEGIN PROG LOAD LOG --
> Private stack not supported by jit
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test1': failed to load: -EACCES
> libbpf: failed to load object 'struct_ops_this_ptr_in_timer'
> libbpf: failed to load BPF skeleton 'struct_ops_this_ptr_in_timer': -EACC=
ES
> test_struct_ops_this_ptr_in_timer_common:FAIL:skel_open_and_load unexpect=
ed error: -13
>
>
> Please note: this email is coming from an unmonitored mailbox. If you hav=
e
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

