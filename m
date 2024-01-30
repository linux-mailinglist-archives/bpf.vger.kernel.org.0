Return-Path: <bpf+bounces-20764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CBA842CAB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167251F2563D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0E7B3E6;
	Tue, 30 Jan 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/yhEdcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382771B25
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642776; cv=none; b=jEJh2lEVWlETmfWBqxpTJxJ6Tg3p92HX8B1VqXTCFPqpHSlLLmtiENdoQejh7YOFpZZ5T0ytv7DgtyA6dMTd7fK4NR0pPMH7tkVq2Q88kzorSl2SqDtshAAImZnN0nbMO94UHLjJQY9i2Vv17qFYd4vgD2rTmas/YCnNXahOtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642776; c=relaxed/simple;
	bh=7zvbXUGeD04pPpxF3A8Xfs0ecA0xANt4+m6UwszY6/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDeU/WDpPK4uy14Mvdykc2yhSkxc1O/ZWgnqcVlgT5zr5Rl55i/UAwLZenuliweZIyQit0pMUI+1Jm0GgzA7a1HqUyKZkfTIeC+etTkq2MA5TpqUMeHZjxbkXqRGO0WwW+P0+M1Z0j7SQInmKhYlWqHKFZZJdDEFv7ntpCdW4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/yhEdcc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce942efda5so3169060a12.2
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706642774; x=1707247574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCPGL29CRuEUGQCoLntTPTVfG2Mvq1zPhlgdQ+Eh4L8=;
        b=Q/yhEdccXaJzMd0yW7UOMDibXRlfb2rCtffLf9zHG6hmaIBFKSzQTJ9Q7rFlp4Hzkn
         n3DjVunUPlT2gVe3Y8QAtA06SfcN2Z2iEUrqJAfRZuCauYSjiwvgQ00gUT0tiGQeptwn
         mnE4qdlHTyV2MF51VmO+I+/RtDKntdOJau8l/GxZ2LZqFhNunEguuHOwhAmFq4fBAHft
         fuaDUEVkQnF+gMVNR4B747hMjnUPV5TE98S8onpw1qXw0hCSUC8dUEasDw0DAAlv+nW1
         Ylz4lWyfQPM6LmkRJjwGaTKD8M7JUwkLi201nMwp3SlnsXgbDKu+vAbErzX0/F1SuRtA
         wAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642774; x=1707247574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCPGL29CRuEUGQCoLntTPTVfG2Mvq1zPhlgdQ+Eh4L8=;
        b=hayeSeEf2EGeqxZ6UxHRhDPnsCsN2nDIsXlpapPGZYg6BN7jz1/pp4WhvnS34s3omA
         HgsrTCrmpQOVHCxpaRV2PgOyU5Dzm9RbMcKUwSchqmdEXvhb8z/jMGfzmVLNYueraOp+
         k+gQwQH/3tOtGCLjSa8O7JDU2W46QgTSz9StblbW2rYnXRX6JBjbhNdZd4iZgxEAf1Vx
         vGJr9MBu/RG0eOGL7o1XKHdBnfRxDuRIm/Ea8nJgDinEIOVRW4el8+QKgIh0mwEq+as0
         GE/OUtwnDnudRjrcqcB8m+8rvO7HTL17bAmX9c49MD+qyTLDofQh1mIr2LdPtPzGIew4
         tLyA==
X-Gm-Message-State: AOJu0YyBpkJcPChR+VqBdC3YnmHbtJgl0GODYSCVddYD4896vLjMi6SE
	x5qZnX464qjDcYK/5VNxSmSyOdpUVoEc/2OIWx6giwaH9wDwWEpturNU9DM0+Mj2zQp2XBA3yVU
	MJSOhr4SkK9L7Et4F0/WVig1bkos=
X-Google-Smtp-Source: AGHT+IGWMN6r8IErhmTV12tDuy9q1LxgUxs6BuNoz7xLPWDSHTL6YcCo79I99TCPYKoo97UADfm6xB9tVbsX0bGbvC8=
X-Received: by 2002:a05:6a20:2d21:b0:19c:9a25:bdea with SMTP id
 g33-20020a056a202d2100b0019c9a25bdeamr10133805pzl.59.1706642773706; Tue, 30
 Jan 2024 11:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130143220.15258-1-jose.marchesi@oracle.com>
 <CAEf4BzY73K46a=VS-5M45H0abfqt1XCTE9vRnuuGn5rq65ibmg@mail.gmail.com> <87o7d2k7c3.fsf@oracle.com>
In-Reply-To: <87o7d2k7c3.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jan 2024 11:26:01 -0800
Message-ID: <CAEf4BzYH5UA8fAZa7LdbjGfSaLMbN5DxUDOe3hp68e55b+eGhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use -Wno-address-of-packed-member when
 building with GCC
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Faust <david.faust@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:24=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Tue, Jan 30, 2024 at 6:32=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >> GCC implements the -Wno-address-of-packed-member warning, which is
> >> enabled by -Wall, that warns about taking the address of a packed
> >> struct field when it can lead to an "unaligned" address.  Clang
> >> doesn't support this warning.
> >>
> >> This triggers the following errors (-Werror) when building three
> >> particular BPF selftests with GCC:
> >>
> >>   progs/test_cls_redirect.c
> >>   986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
> >>   progs/test_cls_redirect_dynptr.c
> >>   410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
> >>   progs/test_cls_redirect.c
> >>   521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
> >>   progs/test_tc_tunnel.c
> >>    232 |         set_ipv4_csum((void *)&h_outer.ip);
> >>
> >> These warnings do not signal any real problem in the tests as far as I
> >> can see.
> >>
> >> This patch modifies selftests/bpf/Makefile to build these particular
> >> selftests with -Wno-address-of-packed-member when bpf-gcc is used.
> >> Note that we cannot use diagnostics pragmas (which are generally
> >> preferred if I understood properly in a recent BPF office hours)
> >> because Clang doesn't support these warnings.
> >>
> >> Tested in bpf-next master.
> >> No regressions.
> >>
> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> >> Cc: Yonghong Song <yhs@meta.com>
> >> Cc: Eduard Zingerman <eddyz87@gmail.com>
> >> Cc: David Faust <david.faust@oracle.com>
> >> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
> >> index 1a3654bcb5dd..036473060bae 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -73,6 +73,12 @@ progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D =
-Wno-error
> >>  progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
> >>  progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
> >>  progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
> >> +
> >> +# The following selftests take the address of packed struct fields in
> >> +# a way that can lead to unaligned addresses.  GCC warns about this.
> >> +progs/test_cls_redirect.c-CFLAGS :=3D -Wno-address-of-packed-member
> >> +progs/test_cls_redirect_dynpr.c-CFLAGS :=3D -Wno-address-of-packed-me=
mber
> >> +progs/test_tc_tunnel.c-CFLAGS :=3D -Wno-address-of-packed-member
> >
> > Why Makefile additions like these are preferable to just using #pragma
> > in corresponding .c file? I understand there is no #pragma equivalent
> > of -Wno-error, but these diagnostics do have #pragma equivalent,
> > right?
>
> Not with this particular one, because Clang doesn't support
> -W[no-]address-of-packed-member so it would lead to compilation error.
>
> Hence:
>
> >> Note that we cannot use diagnostics pragmas (which are generally
> >> preferred if I understood properly in a recent BPF office hours)
> >> because Clang doesn't support these warnings.
>

But can't we have

#ifdef __gcc__
#pragma ...
#endif


My main point of contention is that having those pragmas
(conditionally) added in respective .c files makes it easier to be
aware of them. While keeping them in Makefile is very opaque and we'll
definitely forget about them, the only way to even notice them would
be to run make V=3D1 and read very-very carefully.


> >
> >>  endif
> >>
> >>  ifneq ($(CLANG_CPUV4),)
> >> --
> >> 2.30.2
> >>
> >>

