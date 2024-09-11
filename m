Return-Path: <bpf+bounces-39656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA9975C02
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2ED1C22885
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EFC7E583;
	Wed, 11 Sep 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfaAHShq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD6152532;
	Wed, 11 Sep 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087471; cv=none; b=HGHXQUUrZIVJU1tZPs1Z0FDNruVvM/G374lSPgrOM1L/FClDRUi/NkXpDq8hMvttSOzwQfxMB2o50mEiBrFDkGWZp9dN/6USkTuoImpN+qGfrhKRbcFt1HpKRPg/um96acgZGbpsOH/daRcWEPSpvzmAQKSEBKWYA6ORW8ZvnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087471; c=relaxed/simple;
	bh=Sb1htiv6VrNavcXh5X8AZ+KAkMKWD/uvhcNJbImwjF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgnHVRR8bcC6IDLibzk6KHecpgdWASbsQsLeIcOtUQ1bLq9PxSy/SwxkuZEJd5TH+ANeiaQ1Cb0iXWqeJF+vJgXnPL0l4P6OVDBASGwpBxn5KtvU+hI+4te0LjPlsk9usHrbrxENYfWkZ/cipp3cc1avS5zU3qzMdtB31jTl+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfaAHShq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so163798a91.1;
        Wed, 11 Sep 2024 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726087469; x=1726692269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+gqTYdURsKk/owrE4/HaTfPm9ceyYMB8i+83jcRAbE=;
        b=FfaAHShq4/dRKFUnxNEULrCzo3C+B2Euqhej1dIYK9DI4T1HzxnRIEFX6qsdZayQ1s
         Mm6dbZpt0EuFgZ7udTyTIkVBmt3J37Cs4dawgt25O8mz60M5KNWXqXXM1ObZBAEq/7op
         aWUKeEVFlaTmf/I+nSXxYSWpILOlDYZcuLfMqZkMI524yqkPBD9gCblKVLTgg9XZLJ0w
         MBFe9LWFFQNkE51BbhfHVNonNH5epd+XyhfP8j+h+YobatDBH2CgC5uu6neIuSzodhou
         SSeKccMqw+dCe3emPdkfNgPlDuaHhHx8B8RuZjADjvGgBGb5yU6kG5BGL/6nStbyZTqf
         Kn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087469; x=1726692269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+gqTYdURsKk/owrE4/HaTfPm9ceyYMB8i+83jcRAbE=;
        b=fKnhVgdTv3PrbFtSs59gDZEOqNp+8W7LdlaPYlXJk9gylNAso8qEyJwTLzx+vChvjt
         dTzdKrlZZjYMO2TuhvWRJR7G2ElLWpRoQ6HXvApuUe+YeUe0CYzka6rj9ht7aqvyXyPv
         ZFRn7d6e+JaJKGWtoWzGZT3TdrKslQdUW6ikj9BdhvLqn2iDJ27udje0RoM38T9rcFal
         xAwHZxx0qzZPJu/LnYf1rGLXGb9r8t+8m1HN9cv0hELW/YaMUgwZ3N43g1mHCa0TC/D/
         PfHCO6NyE/m7Ih+T++WlBo20wtpqR/EIhLE11zG1rKxv18s2CW0W3TBsqsfIMJ4jLCmq
         K8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWf5o+RrKLEqiWomuzy2GFHr6vhE+c9PtvTuH42R5yD3sHjtw/BTj+6KZRDJVYr//ZhndVAyE1oZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXGQOKqgX/u2IKtS2HbMN1O92sWpxjst7AWc2xq9J2TYm+V7X
	c+Y5h/UY1VSGx4ExyFdG7Fe0sJ90wbDdzParhqc0Jwua3JiCiQi54Eb97onKqdpTrkEN5WudjFr
	0d8gZLDXRNC7LoNVb5+PDk+PwDBY=
X-Google-Smtp-Source: AGHT+IGe1NZloAxLhu0GnFex0Nzudo2wsxrEb5Wy5puQAkmbN15eajU6O6vlYPMkscGIxa+fpq6nhtYUpr/u2CyL3rQ=
X-Received: by 2002:a17:90b:4c41:b0:2c9:9eb3:8477 with SMTP id
 98e67ed59e1d1-2db9ffcabffmr413397a91.16.1726087468984; Wed, 11 Sep 2024
 13:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145908.34680-1-donald.hunter@gmail.com>
In-Reply-To: <20240911145908.34680-1-donald.hunter@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 13:44:17 -0700
Message-ID: <CAEf4Bzbo=vNwn329eBcX5oqYmQBq1DxcxubFk4D6HQmXHRFD7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] docs/bpf: Add missing BPF program types to docs
To: Donald Hunter <donald.hunter@gmail.com>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:59=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Update the table of program types in the libbpf documentation with the
> recently added program types.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/libbpf/program_types.rst | 29 +++++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/b=
pf/libbpf/program_types.rst
> index 63bb88846e50..fa80a82d5681 100644
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
> @@ -209,5 +225,10 @@ described in more detail in the footnotes.
>                ``a-zA-Z0-9_.*?``.
>  .. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
>  .. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracep=
oint>``.
> +.. [#tc_legacy] The ``tc``, ``classifier`` and ``action`` attach types a=
re deprecated, use
> +                ``tcx/*`` instead.
> +.. [#struct_ops] The ``struct_ops`` attach format is ``struct_ops[.s]/<n=
ame>``, but name appears
> +                 to be ignored. The attachments are defined in a struct =
initializer that is
> +                 tagged with ``SEC(".struct_ops[.link]")``.

libbpf will happily accept just SEC("struct_ops"). So it would be more
correct to say that "struct_ops[.s]/<name>" is accepted, but name is
ignored. But other than that, just SEC("struct_ops") probably makes
most sense.

pw-bot: cr

>  .. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<na=
me>``.
>  .. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
> --
> 2.45.2
>

