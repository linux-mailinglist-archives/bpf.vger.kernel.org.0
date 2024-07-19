Return-Path: <bpf+bounces-35115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA51937CAF
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440181F2257A
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE91482E4;
	Fri, 19 Jul 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5vvIx0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795FA14600C;
	Fri, 19 Jul 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414688; cv=none; b=Mr6ZyXDu2dbsKxlzV4JGgvdgUesmt5Mb77qBE8x3PY7CJ/wfNkJWOu63wFeA32j5VqhRKu+JeUH3mdKEwQgpq+a1jsnHNN/aE0a++pz3Eg4hA3Q4xYNGxoFTpid6c3j20aNMCIXovC7J43b4Zd3/H4WDthjdtfb13mOy5Dt3vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414688; c=relaxed/simple;
	bh=7wp5/fw5rQWFvxZqvgGU+qhYZpRQhMB/Ij0okkHEhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOKS0ehyWuC3+4ps2eoW5ESVf7Zu8p1wbzHnAx/NlGbmBwinHv/wozFcysFEnTig6qM3Qt3NQFx7LMLIDUK0asFPKojNHLfbPefiY90UyeGbw8k43ue5hbXlXuki6dTI8By2Ro6PIhHM57JBTIz04tCSJV2mXAhIq9+AQrnstuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5vvIx0o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d01e4f7fcso544965b3a.1;
        Fri, 19 Jul 2024 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721414687; x=1722019487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYfSr5eumI646hntPDiuA/JnzYVv0u0szIwQZoo/i2I=;
        b=j5vvIx0oH0L7Fq+KyHZ5Z+S7ErJ/g5R8gfmtq16AeurIoArMMyhJxHjGNJWOeO0kmj
         1GVCLKnvDQeDbtw2Mf2PM5eVNnl5GQIuSxxAJ4wKNSE87pm4NnouSIdg0FLZerEN6yiN
         Xi/Pl2LW0N5nthjcW1e1wcP5paeOubTuK1f+WsDHYUyiwZjVTROwmC09GmUIPhWAEJ6C
         +EewoELAou7Xv6eUOb9BRAx8YZAvJ4c69gfXYSNLIfw18ptBBVqKnBO3AjKLSruX/Y/z
         VubsdJYAqwMRzhYRTpH96eTvybVsmhXExUmmeApMbuVbzBvtGLhpc+PEJ3x1JGlYxgcj
         CUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414687; x=1722019487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYfSr5eumI646hntPDiuA/JnzYVv0u0szIwQZoo/i2I=;
        b=tM0n8hjcKU3pBOdfd186ZZPzOcksTEbbO94bBRt7zSNP+qa7HO0j1yGKSrQxDFEeyE
         bG1KWNeQj2BMFVRowcmVKE5ikWyc7RciSvl/RMhFJHBvh532XL3di/u7ZOR+dqULfIDv
         C8eYtN4tNOvRRE9mjb9NEtMskrxOILiF/ORefdDFetitJ+RwuW/4v+S+EOgwB+sz3S+Q
         ef1Na02jwHU4RaAlokHc4BHltS40sB3klgviaVZ1GKJ1MF/br+T2sQf0KD50MaYeFzOr
         Z2qDXHjrGqNogEtdnNSyiUOSM0eeBgv+RomDIl3xYaX60iiY9r3eo0wj72wvORMkOMM4
         omNw==
X-Forwarded-Encrypted: i=1; AJvYcCWy0/beDcZrYsozlrm4AZ7SfCn/VbXigY53PCmnwdQJfzDFBABQCKFWqlHoqD9zXesUyrtnZF/RGljReyyq60y/0rmZO042Mw/L01aBUen8Mb2CVy2nvC72ppVvxvGhilIRppMI5WVSvRNA3fJHBiRpcABW74h5KeQM
X-Gm-Message-State: AOJu0YyNw+Znbb8IUrphToGgGY2R0zEsxP1xhHukUw+xWcGngS+iBEH2
	QYaFYOOQ5iVdOcdkjxbhEA0RE9dKYQMb0JkrXEmg4w9+ArIo+FzfUoxYz3Z6FqetfnAS3JJg8zm
	B+uLXsI3RP8kR8I5nXEUWA4n54Ts=
X-Google-Smtp-Source: AGHT+IHStgLwmAPDB44UyOfvI6437sWYw7wRuQrtEDN1HhgslEJsoQB/I2A4zYoWXiRfqE7oL+j7u3VFYz91Q12fxbw=
X-Received: by 2002:a05:6a00:3a0f:b0:706:a87f:98ae with SMTP id
 d2e1a72fcca58-70ce4f1c984mr10279689b3a.24.1721414686779; Fri, 19 Jul 2024
 11:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718143122.2230780-1-asavkov@redhat.com> <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
 <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
In-Reply-To: <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:44:34 -0700
Message-ID: <CAEf4BzbgeCo09sfrQVgBHJJ-=uZEEm287xXkjoLMrUkcLN6VMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Artem Savkov <asavkov@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 10:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 8:45=E2=80=AFAM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >
> > Hi Artem,
> >
> > On 7/18/24 4:31 PM, Artem Savkov wrote:
> > > Without CONFIG_NET_FOU bpf selftests are unable to build because of
> > > missing definitions. Add ___local versions of struct bpf_fou_encap an=
d
> > > enum bpf_fou_encap_type to fix the issue.
> > >
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >
> > This breaks BPF CI, ptal:
> >
> > https://github.com/kernel-patches/bpf/actions/runs/9999691294/job/27641=
198557
> >
> >    [...]
> >      CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.=
bpf.o
> >      CLNG-BPF [test_maps] verifier_bswap.bpf.o
> >      CLNG-BPF [test_maps] test_core_reloc_existence.bpf.o
> >      CLNG-BPF [test_maps] test_global_func8.bpf.o
> >      CLNG-BPF [test_maps] verifier_bitfield_write.bpf.o
> >      CLNG-BPF [test_maps] local_storage_bench.bpf.o
> >      CLNG-BPF [test_maps] verifier_runtime_jit.bpf.o
> >      CLNG-BPF [test_maps] test_pkt_access.bpf.o
> >    progs/test_tunnel_kern.c:39:5: error: conflicting types for 'bpf_skb=
_set_fou_encap'
> >       39 | int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> >          |     ^
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.=
h:107714:12: note: previous declaration is here
> >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx=
, struct bpf_fou_encap *encap, int type) __weak __ksym;
> >            |            ^
> >    progs/test_tunnel_kern.c:41:5: error: conflicting types for 'bpf_skb=
_get_fou_encap'
> >       41 | int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> >          |     ^
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.=
h:107715:12: note: previous declaration is here
> >     107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx=
, struct bpf_fou_encap *encap) __weak __ksym;
> >            |            ^
> >      CLNG-BPF [test_maps] verifier_typedef.bpf.o
> >      CLNG-BPF [test_maps] user_ringbuf_fail.bpf.o
> >      CLNG-BPF [test_maps] verifier_map_in_map.bpf.o
> >    progs/test_tunnel_kern.c:782:35: error: incompatible pointer types p=
assing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fo=
u_encap *' [-Werror,-Wincompatible-pointer-types]
> >      782 |         ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_E=
NCAP_GUE___local);
> >          |                                          ^~~~~~
> >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.=
h:107714:83: note: passing argument to parameter 'encap' here
> >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx=
, struct bpf_fou_encap *encap, int type) __weak __ksym;
>
> It's a good idea to introduce struct bpf_fou_encap___local
> for !FOU builds, but kfunc signature needs to stay and
> __local variable needs to be type casted to (struct bpf_fou_encap *)
> when calling kfunc.

Given we specify

CONFIG_NET_FOU=3Dy (not =3Dm)

in selftests/bpf/config, do we really need to work around this? I bet
we have a bunch of other missing types if we don't set all the
settings as required by selftests/bpf/config.

