Return-Path: <bpf+bounces-27944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D800F8B3D44
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BC61C23789
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05A157492;
	Fri, 26 Apr 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9rl+mNp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141911FC4
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150501; cv=none; b=P02ipH2q3fNrPHtc9uT5iT4EAkGf85vsipfRbBv20mANjAXIoa40i3cZrLTb7wFxoAy92IgKicOWpdsRXE9ly5m0lx+ir7lZZOeKOYdKpDSIyMcBx2fobRl/l3OU36RRuMiOlMyjMfK+D6dc9vkTDdzjetI3Xwa58CZBjUa7CIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150501; c=relaxed/simple;
	bh=HA67KwLlmJ3TNKlwpG4Zc7cHCjtbIE8kgXn+qgz0hVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfuObJUKPGkjx87rgWJ+FqMBBD1k1QZGxhJOR6ONe0irwXg4bTC8sgiGjjM//M5MSRrJ5k/haPph07+kAYhJKKNF0rZMhvFUZtmH+os0zNSKxwEFXuiT/DRAPnXMDUlMybn4g88eK1v8FrroiV0tCzYJ8M7j3+WUx3LBlKH42mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9rl+mNp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2016821a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714150499; x=1714755299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc6aETv236Cr3N9eSeBk1skc5Rvs3OyUbg8MWE2s3Zc=;
        b=m9rl+mNpHIjRhDO1uh0BjRRDZQ2v2cbQ+HL5ql1QfXNo+tkOTJVzXjuKN3EduPnOve
         hfCJVorLGreUQ5qWRkzYgckXP4swc90DaLVLQ/DKVRJyiK88bkrdnoDv5RKn7QX2lFA4
         MglMTjODcsRd8QWgcddTZwnB5PhvaTPk+wLChJ3kz81fhwj5Xnm4La16pEbmG+URWcM+
         oH7QoYQF3sARQIRj2lj+o4WxyFkAvJiPvlCICEcoUOpEruLTnM57CxxNJIjrnJhDV0Ni
         wOfHyp2Kg9pLzmMk7haVbEawEtxG6SUn0tYZMQbLF6Rwo3brPWUqewvFbXJLOf2kfVfx
         Ab0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150499; x=1714755299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc6aETv236Cr3N9eSeBk1skc5Rvs3OyUbg8MWE2s3Zc=;
        b=c3S5JZxFgPlCvfOuAvn97KLFsAj6UPfE4osy18nDF2CW7c+WpcnhJm4b0sDWcxuPqN
         KS79Rs0H3HtHzT9yGkWNa4Stq672LEH+lNJqUThDcLcIDRb0+fQLCKyWks8TbuE4SZ2m
         iJWzcil2SKiqcUG9XOOpyPSqmgABC4baRK0pQ3gIrbDvu+eBeCaJET6wENKl0o8agcqt
         n00MpnxEk5zsMocj4f0e1mdyFgyf4jvB0Fe9jLUBOGI03WTPgGvG0St1QZdh2Ew2j4DY
         cRAaBxlGa3tC+9XOpUU10A7av3GNZ3Nbw+G2eoRpJT9s/pNDx4Z/b6Odp3HlUS21U7pb
         5EvA==
X-Gm-Message-State: AOJu0YyTFKgY1weGkVYToo1n3L/GfJ3ZMnj1XeFUwAc9nav6VkwRfhh6
	MKR1gpfSoylpGCiG3ohpoyln+VNIIF7XdzXTX+O0iuq3aVP17B9WOafqULgZ0Dm0tMI86rRh1b3
	wyVRvb2C+EVpQzbj/d39CtVn4lwqCVw==
X-Google-Smtp-Source: AGHT+IEVMdxEJQHSSbEHZ7LSe0WilnAbEqiy7v537F4Aececfu1bkiSDEgh0zgaYXX4b4AQS9LCyzP0e5kq1EH+tuHU=
X-Received: by 2002:a17:90a:cb81:b0:2ae:a332:a5a5 with SMTP id
 a1-20020a17090acb8100b002aea332a5a5mr3562419pju.7.1714150499278; Fri, 26 Apr
 2024 09:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714133551.git.vmalik@redhat.com>
In-Reply-To: <cover.1714133551.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:54:46 -0700
Message-ID: <CAEf4BzZ8ckB0f7g86XCYxsMgLZFRQ_3eYswZzZNokbrC8Z=qHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] libbpf: support "module:function" syntax for
 tracing programs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:17=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> In some situations, it is useful to explicitly specify a kernel module
> to search for a tracing program target (e.g. when a function of the same
> name exists in multiple modules or in vmlinux).
>
> This change enables that by allowing the "module:function" syntax for
> the find_kernel_btf_id function. Thanks to this, the syntax can be used
> both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
> bpf_program__set_attach_target API call.
>

how about function[module] syntax. This follows how modules are
reported in kallsyms and a bunch of other kernel-generated files. I've
been using this syntax in retsnoop for a while, and it feels very
natural. It's also distinctive enough to be recognizable and parseable
without any possible confusions.

Can you please also check if we can/should support this for kprobes as well=
?

> Viktor Malik (2):
>   libbpf: support "module:function" syntax for tracing programs
>   selftests/bpf: add tests for the "module:function" syntax
>
>  tools/lib/bpf/libbpf.c                        | 33 ++++++++++++++-----
>  .../selftests/bpf/prog_tests/module_attach.c  |  6 ++++
>  .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++
>  3 files changed, 53 insertions(+), 9 deletions(-)
>
> --
> 2.44.0
>

