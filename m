Return-Path: <bpf+bounces-39756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2827976FDC
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 19:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038E51F25043
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E71BF305;
	Thu, 12 Sep 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz7zPrrT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4478450FA;
	Thu, 12 Sep 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163867; cv=none; b=rW9zgHGwcprdGZvoNkO7ERL4KD+rflrOJxXj4Y0Mou3PmQy0L75rHR1qFhpf/2TAvW2lmRRPz6XCv5hZ4v7/wVozBLNoXitHnSA/Fb3eEGclpv7ziH1BvSoschVq4dB0vnSRfNnkKXviWPRIpCwoPeh3bIL0rcibemp8jAR2T0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163867; c=relaxed/simple;
	bh=gRNIKQe8LPHbkpainpuCj1mpKe3jnYTWPByOYplkE7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGyvGQS8fdehr2cmNzNUr5RL8xVMNvsQzPl7fg0IUgp6JLeOgBAlxr/UqQWlSwkT4d/G14AtLQuJv2DriMmUiyKd9iC3jz5+FaNHqkj1XRUIn/qE2mCTQQpvOA/TBNAe1h84iiKF45T3FPKTiYkrkd5E62F+p6nXbq0qjUa658M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz7zPrrT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so940477a91.0;
        Thu, 12 Sep 2024 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726163865; x=1726768665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAxla2V/jbE96IFDHkffqVnvDP474rGr0BFWJRieBj4=;
        b=Hz7zPrrTwKOMGtiq4H+2l9cTyv72yJQ3c7PWVtw3Xb6pT0rRrAl7hn+toY9ppqSF+l
         8T/TGtaVpyXhrmo9nLrgQQDTSx9l0NVU7h9ZOAAdY3RdEKB4fmh+q5E6wBcbtBlgmY+9
         Ji5ChlSxlb0msVPikyH3nRT69qQkum4BE2DBnTfg9PZfNIqHN9XBtmXT4bTUtG8FEtCs
         tnvLVENUmQyNilGmvPHUofoSYgaN10oqmEHAmXOFyfbr+ilsyGNIUYbuyKl4pBxUhgsX
         M43QPwwQPEh9ZU310lh19biOxOfSt/7yMXQZJ/4rUhH5F8JuTbkJW/KS4uICARcJZF5b
         d/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163865; x=1726768665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAxla2V/jbE96IFDHkffqVnvDP474rGr0BFWJRieBj4=;
        b=BLzDOJ+eIu12TbVod6fGapOpDfp9uMh2dMbid/VNq5uTqkq3w2ROzU4PoQdidcGRbD
         sQhM6MnUD3FQgSjpVTYY4ec652KaiFbeNZnhOxCRTlH7AkXJ0BHECbGOnGTVGymVJT1V
         0a7pmHiRmiwPFV8OkworkWI5zv89WKSB3ScUiZPsxq3nNSanspYKnMgbGdnp53L5pSa8
         dtpyaFQuWfjZx9YxnyeNNFA3z5Hd02KPJvtBhDUBpL/9jAzl5Z4p1QzZazl8Ng5n4Msc
         jwIGJoiN/ilFL0FG4bg6Eh8vjdKCxw7/WDnOhqKSfR3sbNQKcgtnif0/ZzCxufv790q+
         WjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhVdLKIVo9DvSliYVtDSDVl4quvKBiQZHOspdytJiMk1RkUbfm8aanGgcu98ku54iaAW7o/wSRnEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4wF6Dq2tpneFd111u2ODeyqtKKNMrK8lHTG+NjrqAvwl8nAO
	8uilK6pzlezCayjIuRS3QgmCConsUdoDdVu3XL+eTWkgAWsw0Crf01YdRIdziTlMqyp6c2KmtU3
	+v9nBrbe5+x997KmMf7c7HAgu3fw=
X-Google-Smtp-Source: AGHT+IFCxGmCPTnEc/uS/G3IMnElnGyhiHYr0464wQ6QkNgEa8mKcQr/ztZ51OuzeEYuYsaWyVNxrsxDl4guLZ3koYY=
X-Received: by 2002:a17:90a:114f:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2dba0084dabmr4186190a91.37.1726163864936; Thu, 12 Sep 2024
 10:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912095944.6386-1-donald.hunter@gmail.com>
In-Reply-To: <20240912095944.6386-1-donald.hunter@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 10:57:32 -0700
Message-ID: <CAEf4BzYv-q5tCfKXSFDuq-dpjVLZ9S59ow3Mk4-Ug7pJtJuD6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add missing BPF program types to docs
To: Donald Hunter <donald.hunter@gmail.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:59=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Update the table of program types in the libbpf documentation with the
> recently added program types.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/libbpf/program_types.rst | 30 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/b=
pf/libbpf/program_types.rst
> index 63bb88846e50..09bb834aa827 100644
> --- a/Documentation/bpf/libbpf/program_types.rst
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -121,6 +121,8 @@ described in more detail in the footnotes.
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_LWT_XMIT``                |                           =
             | ``lwt_xmit``                     |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_NETFILTER``               |                           =
             | ``netfilter``                    |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_PERF_EVENT``              |                           =
             | ``perf_event``                   |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE`` |                           =
             | ``raw_tp.w+`` [#rawtp]_          |           |
> @@ -131,11 +133,23 @@ described in more detail in the footnotes.
>  +                                           +                           =
             +----------------------------------+-----------+
>  |                                           |                           =
             | ``raw_tracepoint+``              |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> -| ``BPF_PROG_TYPE_SCHED_ACT``               |                           =
             | ``action``                       |           |
> +| ``BPF_PROG_TYPE_SCHED_ACT``               |                           =
             | ``action`` [#tc_legacy]_         |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> -| ``BPF_PROG_TYPE_SCHED_CLS``               |                           =
             | ``classifier``                   |           |
> +| ``BPF_PROG_TYPE_SCHED_CLS``               |                           =
             | ``classifier`` [#tc_legacy]_     |           |
>  +                                           +                           =
             +----------------------------------+-----------+
> -|                                           |                           =
             | ``tc``                           |           |
> +|                                           |                           =
             | ``tc`` [#tc_legacy]_             |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_NETKIT_PRIMARY``    =
             | ``netkit/primary``               |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_NETKIT_PEER``       =
             | ``netkit/peer``                  |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TCX_INGRESS``       =
             | ``tc/ingress``                   |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TCX_EGRESS``        =
             | ``tc/egress``                    |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TCX_INGRESS``       =
             | ``tcx/ingress``                  |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TCX_EGRESS``        =
             | ``tcx/egress``                   |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_SK_LOOKUP``               | ``BPF_SK_LOOKUP``         =
             | ``sk_lookup``                    |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> @@ -155,7 +169,9 @@ described in more detail in the footnotes.
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_SOCK_OPS``                | ``BPF_CGROUP_SOCK_OPS``   =
             | ``sockops``                      |           |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> -| ``BPF_PROG_TYPE_STRUCT_OPS``              |                           =
             | ``struct_ops+``                  |           |
> +| ``BPF_PROG_TYPE_STRUCT_OPS``              |                           =
             | ``struct_ops+`` [#struct_ops]_   |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``struct_ops.s+`` [#struct_ops]_ | Yes       |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_SYSCALL``                 |                           =
             | ``syscall``                      | Yes       |
>  +-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> @@ -209,5 +225,11 @@ described in more detail in the footnotes.
>                ``a-zA-Z0-9_.*?``.
>  .. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
>  .. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracep=
oint>``.
> +.. [#tc_legacy] The ``tc``, ``classifier`` and ``action`` attach types a=
re deprecated, use
> +                ``tcx/*`` instead.
> +.. [#struct_ops] The ``struct_ops`` attach format is ``struct_ops[.s]/<n=
ame>``, but ``name`` is

I slightly modified this to:

The ``struct_ops`` attach format supports ``struct_ops[.s]/<name>``
convention, but ...

Pushed to bpf-next, thanks.

> +                 ignored and it is recommended to just use ``SEC("struct=
_ops[.s]")``. The
> +                 attachments are defined in a struct initializer that is=
 tagged with
> +                 ``SEC(".struct_ops[.link]")``.
>  .. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<na=
me>``.
>  .. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
> --
> 2.45.2
>

