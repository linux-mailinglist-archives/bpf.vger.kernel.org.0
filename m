Return-Path: <bpf+bounces-66664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516EB384D4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2455E688E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E929CB32;
	Wed, 27 Aug 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlmgBZz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384672116E7
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304556; cv=none; b=L3Hoo706TdJvyvud3a5uaogiKKFUhZ3lrzBm+LQwAFX3m/4+i7ZtnnN5+lUn69u7OuWbV5lRGfuw0XDdyQbKWfxSsVQ2Ibe1PTjd9A3c4UcrfILWO/DX5i/U1GNEb2pcgE2cijX6qMJN9bsUYU2PzAXKAaSOLrd4kgzEtcpDQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304556; c=relaxed/simple;
	bh=GeqWgwT4sAUmsoagfWwhs2u8RfJZCpVqkxjVz3HfX5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKDfB9WACePhJC0qxbMYDJTCZDGZ6pzYcvemH9Lp/ZLl0hnH2JsMtBR3vA6/LHQmjXr//4pmdx/rIEjClyhqbuKfNgY5la6J9HFLNVj1lfHNx29tCg5hpfhfv8VuHSjGZtli2gLKRY+XDOJFacnkYoGanmO/UAXSJ05q1N2jaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlmgBZz2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f6d8fcd0fdso135676485a.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756304554; x=1756909354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5re1CNxOrtxP/Ayif8QgNX+1ItqV8/B/L71l3X/hec=;
        b=dlmgBZz2MEXlhYQMtn3Q7+an5o8GUoGr0PwbBHdaspKqyQbqU5Apn2Ne4Ad+jdbRXA
         qUGp8oQGE7FLb0Qz6lRVa/ax01I2G2OgQk/44b5+hL+FOFNVYgbh1Oe0Wg9Gr0xI8ElR
         bTatOYHACE/DQ8bfT8SSvt0YrZqREH0q5EQpEI93NLTVKTP7LsFNaiu2ZFw7yJGqWdXF
         7FchBSB8fzNeOAHj6R4RPkoGSBd3rqF7XbI/DxJhW+0tKxunEeUJ1Q7mM/3ucX0pwEsD
         4lHpmhzYcQ9WwGRHtcbX1w9hssEWnKByo0HZSXyM0iuRB6CHz62nWu8B//PukuTj1YTB
         my9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304554; x=1756909354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5re1CNxOrtxP/Ayif8QgNX+1ItqV8/B/L71l3X/hec=;
        b=u4fQSTta2Ar20IQM4+szTnnnRfq/cWbzESRACe5Elih819KrtvrZCibAlvYxT4KcdY
         YBbGV+Gcs6JoLxLaz8/lU6hhAmMOnPoRl3ceYAzK2CTpKzV0lExj52AyAipF2nl+6AXg
         Mit9aewdAeucHVoKlBIsYbYpG819RPJvH+KnOc9002IySc3kUgHf/9ecG1QBHTO4I8eH
         ZGZeF4uj6WTVzS11FHM3K8RhSYMpxxEVRCNaBT5BcqgXUtbYI8CCFYpwHMD/O9iJzEDe
         ba/hVLyTi9YI/lDTGp+SCgn9Fe11fGyuxmgNEoR7UZ5SFMQIjeynbSY5+TpXSkXs/rza
         vooA==
X-Forwarded-Encrypted: i=1; AJvYcCXDfVXjGKComu9szuLSoxVERRLq/QzsRNIavWNbbowZ1zu7IvJaPDGt9e5bNoTZW5GfK2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyjEnaJU43SWmPdp2rw3r/XkwU9kped5mq7Zk9Jok84sQAVi1
	o3Nx7DFFbDZD4wpvHR/R5+mGejuTD3FlXZHIfbZbZVbFeSP5O9q6O+x6dRclNBsMtdKuHXFpZT4
	3h+jTSTSrj8WQRLKAOXVfwo6imTRDmCA=
X-Gm-Gg: ASbGncuVGhp/ydCJUZNkhAOd+2UEn7b59Oxph/cOi0gXIS9s3HE/Th+rEZY1fpuFVcN
	0bpSlQM4sij/Ow4PQ/PYvP9B+jzPuJxoYgLntD7P6gVW4fqeV7siQagMixqqFxOfVWChzycBw/x
	zN0qgqn17dUIli9A/BdUa3iLpV0pKZYc9jp5d62iiYdyB4k3RfZ5eSiKs1iI/bJCpF6YXY4e0TE
	/OZyn8=
X-Google-Smtp-Source: AGHT+IEslLJkl0ZeuNaKCzmfBShY64wlqef+fuiIb6XpRJiS3xat/lF1MmMoqGhwoODlIqS4kVLbxpod+nXSv5kvoxE=
X-Received: by 2002:a05:620a:aa19:b0:7f3:9036:13f1 with SMTP id
 af79cd13be357-7f390456b65mr1050631085a.49.1756304554037; Wed, 27 Aug 2025
 07:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
In-Reply-To: <20250827094733.426839-1-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 27 Aug 2025 07:22:21 -0700
X-Gm-Features: Ac12FXyTqKDbfmdcT2o4ZfZI0BPOE1IlkIAt6nFApsVRsY5DFVdrrp-xTu27jj8
Message-ID: <CAK3+h2yJL4BFdsuXd3x+tVU4EcTinixbXwckbF1EwzepZWHXmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] LoongArch: Fix BPF trampoline related issues
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, 
	duanchenghao@kylinos.cn, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:19=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The following two selftest cases triggers oops on LoongArch:
>
>     $ ./test_progs -a ns_bpf_qdisc -a tracing_struct

Last time I skipped struct_ops test and now I updated the test
accordingly, no kernel hangs and test result is expected for this
series:

./test_progs \
--deny=3Dmodule_attach \
--deny=3Dsubprogs_extable \
--deny=3Dtimer_lockup \
--json-summary=3D"./bpf_selftests.json"

#213/1   ns_bpf_qdisc/fifo:OK
#213/2   ns_bpf_qdisc/fq:OK
#213/3   ns_bpf_qdisc/attach to mq:OK
#213/4   ns_bpf_qdisc/attach to non root:OK
#213/5   ns_bpf_qdisc/incompl_ops:OK
#213     ns_bpf_qdisc:OK

#408/1   struct_ops_autocreate/cant_load_full_object:OK
#408/2   struct_ops_autocreate/can_load_partial_object:OK
#408/3   struct_ops_autocreate/autoload_and_shadow_vars:OK
#408/4   struct_ops_autocreate/optional_maps:OK
#408     struct_ops_autocreate:OK
#409/1   struct_ops_kptr_return/kptr_return:OK
#409/2   struct_ops_kptr_return/kptr_return_fail__wrong_type:OK
#409/3   struct_ops_kptr_return/kptr_return_fail__invalid_scalar:OK
#409/4   struct_ops_kptr_return/kptr_return_fail__nonzero_offset:OK
#409/5   struct_ops_kptr_return/kptr_return_fail__local_kptr:OK
#409     struct_ops_kptr_return:OK
#410/1   struct_ops_maybe_null/maybe_null:OK
#410/2   struct_ops_maybe_null/maybe_null_fail:OK
#410     struct_ops_maybe_null:OK
#411/1   struct_ops_module/struct_ops_load:OK
#411/2   struct_ops_module/struct_ops_not_zeroed:OK
#411/3   struct_ops_module/struct_ops_incompatible:OK
#411/4   struct_ops_module/struct_ops_null_out_cb:OK
#411/5   struct_ops_module/struct_ops_forgotten_cb:OK
#411/6   struct_ops_module/test_detach_link:OK
#411/7   struct_ops_module/unsupported_ops:OK
#411     struct_ops_module:OK
do_struct_ops_multi_pages:PASS:struct_ops_multi_pages_open_and_load 0 nsec
do_struct_ops_multi_pages:FAIL:attach_multi_pages unexpected error: -7
#412/1   struct_ops_multi_pages/multi_pages:FAIL
#412     struct_ops_multi_pages:FAIL
#413/1   struct_ops_no_cfi/load_bpf_test_no_cfi:OK
#413     struct_ops_no_cfi:OK
#414/1   struct_ops_private_stack/private_stack:SKIP
#414/2   struct_ops_private_stack/private_stack_fail:SKIP
#414/3   struct_ops_private_stack/private_stack_recur:SKIP
#414     struct_ops_private_stack:SKIP
#415/1   struct_ops_refcounted/refcounted:OK
#415/2   struct_ops_refcounted/refcounted_fail__ref_leak:OK
#415/3   struct_ops_refcounted/refcounted_fail__global_subprog:OK
#415/4   struct_ops_refcounted/refcounted_fail__tail_call:OK
#415     struct_ops_refcounted:OK

test_struct_args:PASS:tracing_struct__open_and_load 0 nsec
libbpf: prog 'test_struct_arg_1': failed to attach: -ENOTSUPP
libbpf: prog 'test_struct_arg_1': failed to auto-attach: -ENOTSUPP
test_struct_args:FAIL:tracing_struct__attach unexpected error: -524 (errno =
524)
#468/1   tracing_struct/struct_args:FAIL
test_struct_many_args:PASS:tracing_struct_many_args__open_and_load 0 nsec
libbpf: prog 'test_struct_many_args_1': failed to attach: -ENOTSUPP
libbpf: prog 'test_struct_many_args_1': failed to auto-attach: -ENOTSUPP
test_struct_many_args:FAIL:tracing_struct_many_args__attach unexpected
error: -524 (errno 524)

>
> This small series tries to fix/workaround these issues.
> See individual commit for details.
>
> While at it, remove a duplicated flags check in __arch_prepare_bpf_trampo=
line().
>
> v1 -> v2:
> * collect Acked-by/Tested-by tags
> * update sign_extend() in patch 2 as suggested by Huacai
>
> Hengqi Chen (3):
>   LoongArch: BPF: Remove duplicated flags check
>   LoongArch: BPF: Sign extend struct ops return values properly
>   LoongArch: BPF: No support of struct argument in trampoline programs
>
>  arch/loongarch/net/bpf_jit.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> --
> 2.43.5

