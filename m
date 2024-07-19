Return-Path: <bpf+bounces-35097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83323937B71
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E21F228D8
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E991465BC;
	Fri, 19 Jul 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iclup+nT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E51B86D9;
	Fri, 19 Jul 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408990; cv=none; b=IQGQuJUVyBHk7W30rszMVjeGvbSUgO+bhNnVyUri/6mdC93iMabf1TEOKF58xTgYKUCjx7QQBimB+E7NWLNxKaTuiBelJvwhslyESU+X0tJx9xNlYpXc++TMkXvujqJR4IhPo3P/RqB/B8m3ad6TDJ99xfKnFtiYOAl7IJAERA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408990; c=relaxed/simple;
	bh=PAMTofhe/PuFsw2RrNvI239JomTA5gF8pfpJTM+xXGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPJuU8Y0ck3tuNJ4sviFAKkP/BPEgzkZlNPRLsOBhDeP+rYCFCLc4zCipG1kS1nO7K1TiYqIkLNQQr6gtJGQPBTHjNkVRb5TOYTRIhigFVH/3D9Ed4dbHcBSK0gUA+ufR8rv7DU+kVqMHfrCIpeVXgwW5kBmOYovozX60laNjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iclup+nT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so15101035e9.3;
        Fri, 19 Jul 2024 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721408987; x=1722013787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw9++V8AzR6okMvjAufW9+ulddDfEe4xLutVaqWie0k=;
        b=iclup+nTWsfvXmXHajv8HwB/XdzRakKKUVWKTl+UXfpSbasmHmRDjUt3uDUz78ix0w
         K6TGts1InTU9FogkhoODfXqApIVwrX5/W4FWnR9hs0BOZSpsSaktC9lN8m4zpbARYArE
         SASOlYmMhHixdq+NhBLZ5kRuLqVpaC6joIMmEUUwBIIof7rCMLLwkTS9NoZLIRTzFJXJ
         7TJ9if7BxRy6P1lZ1ILWG3Udll/opF5DtqfnL0wAhCf1/Aj7NL8CoK0JKxEy7AKJCPde
         dk09OwoCPL6izUPE+z02a7/2ZRIdyT3ySti30HMiBbeI7waxJKDTlSizPS3cPOTwptoz
         L2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408987; x=1722013787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw9++V8AzR6okMvjAufW9+ulddDfEe4xLutVaqWie0k=;
        b=c0WqtyXFWVdEyc/+r76DDn0eP8uKHyKbxEBcGHVJapbSxs93pwQPt/GXlktiUBCIHS
         MiTkB1NK2k95NjHluO6s3mtfWHBUZ7mCozl+KhjJOtCDu1ZqJzaWTIMrnb9uq6bx7rFZ
         SgbWcnT74hj9DEc8uLf4Q4XSrex8TUsX3I6hVjviEF3wv8RvAcOT6j7vYVe+UiEydWQc
         qwV46sZBoCT3tKyZx2x5Ko9d5txr1MJu1jH7wEn4WcRqLpAZAUYkuFlXbzJiSVZ/rmGF
         syJzmXafjXjXsfvgDpvuDScNA/pZRAZJpvufdUlQsbnDapb7zagxGZjw/x4TCIePUDOK
         ramg==
X-Forwarded-Encrypted: i=1; AJvYcCU4prIPaUOkiCqOU0OZ6RCc3diKUk7LyObmlDphrsRXhEBT6NGBn+5gu7AaZniaI9/p6+jdccXhQYKczwOVupMX4+RfwJm3baO25EEPJq9Pz2Qlu0KLPsV6GKs83rFd+5gYKleNm6U5OjQy8vIcTwdZlP+X2sasLxfM
X-Gm-Message-State: AOJu0YzMsY/r9jKQZDocl+K68GcqoCVDbydEM5AQvNr9BLhuJcrJ+pb6
	Sh8yA5EFsr6Ba/QStOhuFwQiglkp385f1SmE/IJUyNyIJ6XQAOJeOOZNm112KH/cuQ6n5jctlLZ
	laCReWfckaz++Jk2NOtS7ZizEzOM=
X-Google-Smtp-Source: AGHT+IEANILOsOCB8+rV4sT3XsrN1RqMBkijNmJpVI4a1HToHAanL+7wOGPkmeBzJkL0LvG4BiQj+0rAbti3zzhMJak=
X-Received: by 2002:a05:600c:45d2:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-427c2d1c43amr59747705e9.30.1721408986658; Fri, 19 Jul 2024
 10:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718143122.2230780-1-asavkov@redhat.com> <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
In-Reply-To: <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 10:09:35 -0700
Message-ID: <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 8:45=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Artem,
>
> On 7/18/24 4:31 PM, Artem Savkov wrote:
> > Without CONFIG_NET_FOU bpf selftests are unable to build because of
> > missing definitions. Add ___local versions of struct bpf_fou_encap and
> > enum bpf_fou_encap_type to fix the issue.
> >
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>
> This breaks BPF CI, ptal:
>
> https://github.com/kernel-patches/bpf/actions/runs/9999691294/job/2764119=
8557
>
>    [...]
>      CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.bp=
f.o
>      CLNG-BPF [test_maps] verifier_bswap.bpf.o
>      CLNG-BPF [test_maps] test_core_reloc_existence.bpf.o
>      CLNG-BPF [test_maps] test_global_func8.bpf.o
>      CLNG-BPF [test_maps] verifier_bitfield_write.bpf.o
>      CLNG-BPF [test_maps] local_storage_bench.bpf.o
>      CLNG-BPF [test_maps] verifier_runtime_jit.bpf.o
>      CLNG-BPF [test_maps] test_pkt_access.bpf.o
>    progs/test_tunnel_kern.c:39:5: error: conflicting types for 'bpf_skb_s=
et_fou_encap'
>       39 | int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
>          |     ^
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:=
107714:12: note: previous declaration is here
>     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, =
struct bpf_fou_encap *encap, int type) __weak __ksym;
>            |            ^
>    progs/test_tunnel_kern.c:41:5: error: conflicting types for 'bpf_skb_g=
et_fou_encap'
>       41 | int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
>          |     ^
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:=
107715:12: note: previous declaration is here
>     107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx, =
struct bpf_fou_encap *encap) __weak __ksym;
>            |            ^
>      CLNG-BPF [test_maps] verifier_typedef.bpf.o
>      CLNG-BPF [test_maps] user_ringbuf_fail.bpf.o
>      CLNG-BPF [test_maps] verifier_map_in_map.bpf.o
>    progs/test_tunnel_kern.c:782:35: error: incompatible pointer types pas=
sing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_=
encap *' [-Werror,-Wincompatible-pointer-types]
>      782 |         ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENC=
AP_GUE___local);
>          |                                          ^~~~~~
>    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:=
107714:83: note: passing argument to parameter 'encap' here
>     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, =
struct bpf_fou_encap *encap, int type) __weak __ksym;

It's a good idea to introduce struct bpf_fou_encap___local
for !FOU builds, but kfunc signature needs to stay and
__local variable needs to be type casted to (struct bpf_fou_encap *)
when calling kfunc.

