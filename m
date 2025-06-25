Return-Path: <bpf+bounces-61572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B9AE8EDE
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBA43B72F5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958982DAFA3;
	Wed, 25 Jun 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGwLYQnG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7E263889
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880401; cv=none; b=PieFm7x+SqtsyCSQL/cH92lqoNGSwO2iN68FpbAODFDNewDIWAK3OaHMN+J518C2nKgulC/d8el+AhDDdW3UTSElpmyGKD4VLmQBzh36fXxdiKa1mzEJ8PcemlqLOCyyH1o/mCWxB47aqb4IIWmBXYCGGZnTFqqjWTZTH4l+Hxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880401; c=relaxed/simple;
	bh=RVDP9wrlmrPidYC/0s5454LvDdVGGSQecA+w2jE2ZRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb/SF23FzkkXlsf1+NkOl7UQrCCLyabY2WyzXuWsaXErrFbFHtWfROio8df/Mue+EkzSJsyu3v7q71LoK4JTJFbfdiKJZGfpE4GIhfKLsOhsTYEjYgzCI+PyN+LeI6duNfIllDLU5b6dTZ3kwFGayoc01Cs1kA1xNB9689KCbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGwLYQnG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fd091f826so286356a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750880398; x=1751485198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h2wIIr43mgwmRt1frjzzszZLKKT+xCvqtCTq5HwKdg=;
        b=eGwLYQnGuAEfZds+7MwjK+BYaIh49JQ8i2tCxQa2GZmNgRMh0cX9k5ENpjxoBsomJh
         00CUFqCKHOlFvqUSuviCnwqVYeSjo1P0+DWBDc04zMbOwAGwW/FINL48ckY50q005Bsp
         8INMN9k+dcwEnXY+o8LFxCo+Y5hE9nWaL+Lchl1v9CcOIH0jVAfKerx5916VFgcdoCc7
         a301puX1ji3tghXkOJqRiQK5sn0Zq+LrFfzKEhISLi9lt1qKr3WtYAQA2PD2x9V+/qQh
         h8tcMjObCk0dvB6bfVzmO3sBVxnKWmOh+73kGXpCerdsD2e52iXXEfM8vlA5239zUq05
         nKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880398; x=1751485198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h2wIIr43mgwmRt1frjzzszZLKKT+xCvqtCTq5HwKdg=;
        b=eUZSlrOLXW9oic/NzsQi1+kcx4zLB2jmUvxiRWrC7kn3iGLe9rjbxul+16zE5tdm99
         dM57Ww0BUy1iNm+EtQA4+/kr1BmNwdKWw8iTXlMjRYs3pjsjVjTTQKvkVyPg+eUd6HW5
         QFJxBJU52VIst1fWciwsNgBLW8ZKm3PnnZNB5yICZXKcNjDdwIT9fSCPV+3GLPlEMOtn
         9jKhpNY7M9CbFP7zZm9br2ZF+7+82A9rtslg5xgytvlhvwCzZJhKTauut8amdGExG+bZ
         VE3QOFdXjCvnEuaOCHx9ghXQK0wCBsuXjwxI199Z14gepQudv7ThqIhcmHli29yeoeXm
         9RLA==
X-Gm-Message-State: AOJu0Yz/LHCWezoqYIzhzi0JEyyAaHstKjWjvHJ0GZBH+GPjC3wNtadH
	TqjphBrLCqJTzxc5CqE7LSw50VcaCywAeiwtoIrXFrOVmj/yRxnPiw6WT9FfmwNV/tmRnnPvNp0
	/ZOSLQsWd7X5pAD4R76Jdl2inxJrjN80=
X-Gm-Gg: ASbGncsfGgV4e2cwqWqid26cRaWQDi4pApYJKk/mR/2nKdXZLFgzO5hWMGOF5pwYx3r
	IhWJ7uYwRitadJRUxCD2H4qe9Dn6QBHL7yKrokJ1HGEYS0it5vHoaikqoc13uJGz33X+Z7LDYFI
	/pYc5tUKeG2HpzNrwtWkucBWKEoETHrnfWfcq9Ud9VrJ+tsahMBU9iRjgKlV0=
X-Google-Smtp-Source: AGHT+IFsHgrPvf6kgyDoQq29b7w9oJXevbIzo5g7nLRpIcol1/Bkh3/Ges5WG4ZOZjxdYcDcVj+RhMeFbW5t/eoDotg=
X-Received: by 2002:a17:90b:55d0:b0:311:482a:f956 with SMTP id
 98e67ed59e1d1-316d69bf0cbmr1022580a91.5.1750880398423; Wed, 25 Jun 2025
 12:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182414.30659-1-eddyz87@gmail.com>
In-Reply-To: <20250625182414.30659-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Jun 2025 12:39:46 -0700
X-Gm-Features: Ac12FXxnif0LcuWFFYN0xirnzJpjwGLQPWE3Cl_riS2A7RQrv553rKvPt2urKks
Message-ID: <CAEf4BzYLkz1_+2s_e4No8jKiVzYvYr0Lyf8ERXSMf2MaZiFTiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: allow void* cast using bpf_rdonly_cast()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Currently, pointers returned by `bpf_rdonly_cast()` have a type of
> "pointer to btf id", and only casts to structure types are allowed.
> Access to memory pointed to by these pointers is done through
> `BPF_PROBE_{MEM,MEMSX}` instructions and does not produce errors on
> invalid memory access.
>
> This patch set extends `bpf_rdonly_cast()` to allow casts to an
> equivalent of 'void *', effectively replacing
> `bpf_probe_read_kernel()` calls in situations where access to
> individual bytes or integers is necessary.
>
> The mechanism was suggested and explored by Andrii Nakryiko in [1].
>
> To help with detecting support for this feature, an
> `enum bpf_features` is added with intended usage as follows:
>
>   if (bpf_core_enum_value_exists(enum bpf_features,
>                                  BPF_FEAT_RDONLY_CAST_TO_VOID))
>     ...
>
> [1] https://github.com/anakryiko/linux/tree/bpf-mem-cast
>
> Changelog:
>
> v2: https://lore.kernel.org/bpf/20250625000520.2700423-1-eddyz87@gmail.co=
m/
> v2 -> v3:
> - dropped direct numbering for __MAX_BPF_FEAT.
>
> v1: https://lore.kernel.org/bpf/20250624191009.902874-1-eddyz87@gmail.com=
/
> v1 -> v2:
> - renamed BPF_FEAT_TOTAL to __MAX_BPF_FEAT and moved patch introducing
>   bpf_features enum to the start of the series (Alexei);
> - dropped patch #3 allowing optout from CAP_SYS_ADMIN drop in
>   prog_tests/verifier.c, use a separate runner in prog_tests/*
>   instead.
>
> Eduard Zingerman (3):
>   bpf: add bpf_features enum
>   bpf: allow void* cast using bpf_rdonly_cast()
>   selftests/bpf: check operations on untrusted ro pointers to mem
>

As I mentioned on patch #3, we are lacking demonstration of another
critical property: ability to dereference the pointer as 1/2/4/8 byte
pointers. Other than that, lgtm.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c                         |  79 ++++++++--
>  .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
>  .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++++
>  3 files changed, 212 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_unt=
rusted.c
>  create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untruste=
d.c
>
> --
> 2.47.1
>

