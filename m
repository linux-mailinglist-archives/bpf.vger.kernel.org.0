Return-Path: <bpf+bounces-28729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4618BD6F2
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC771F21FB5
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4515B98F;
	Mon,  6 May 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp8krBaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4915B97A
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031891; cv=none; b=ZaObkSyixbei0g/wm5TARMEHFXDkk5s8obBSZEyMDcS189khxnMO+qV9vSu0GPuoNDGKgacsje9Ww1OAtgs/oCwlnjNW0Kgu4nT/cl7AD3pytkNl+V7n24J7qi3rNxAVxEFZqF7hzCVC1AvkiMq9GBLYHJlVDCAz0pMwvW0VIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031891; c=relaxed/simple;
	bh=ajhYjiqT44WFNV5aPk2uYerAFFBL8B9baSzOwTvDZVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKMr59iNlNot227XARrngh/iBboTUSYFHtAQu3fA3YlFhQFWeYGFFjycATCNLLFHEBTdhlD22/VjnjzxdLlxuLlxUTopZ8J8I8A+2oqpyTTSJWyqBX2LE13YTsblp/v+e9ntEBA4xsT1nhNxpc10PmnKK1GV/fGm4yiAvUuwqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp8krBaW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ca546d40so18381845ad.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715031889; x=1715636689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1mVg72xy8yOt5WLB86lzZkkSfCE6FgrHL5o0j5kMsQ=;
        b=Pp8krBaWYmAyYQviGAhnzt0ut2lrcFYdSTCtw/NV28m0uwIqU2kX8qqOgHu4H3TGsl
         a+sdQrIYEV0hg3wRHhEYRyy3YfAgfqtfk0+8UmOx4w4IPrr4KNDIb80O1AkIRL/daiOD
         3NHoxdtYo+b36EB2rj4HWNgx37WUjxZjDrV2vemDYu7/gCtlyFPQkWoKigB71uHbtttT
         NP4oEspzzcmmVrvVZolQhrakzjgaW7c1nBNH1eiYwVthufExyb3an0kBDh/eoblAWjii
         LvM3sb6sG2ZFk4KCwqskGzveK9QpY9nW7RLq3K2901DPvdmVJAvYCTF5NFcrRXzKhsZg
         rTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031889; x=1715636689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1mVg72xy8yOt5WLB86lzZkkSfCE6FgrHL5o0j5kMsQ=;
        b=gxjnWj0Mu6I6kJfNR/4zLLp9OeHh1l79tNTLv42m9N/mELw6jfspcfxyjTd111tZSy
         UvIaltZisw3g+RD7ZuvJ1V8/w7Lw3yf/mQoxtLopr+zqtYK84Wn6VbtQK1Hz3V8Q0xpd
         tMdf8cPYy3Wa4nwgp6rRfVjRi7CVeaLUc35Al2JOj9dWdG9ePrViVKW9Ot4dw2G7MD1r
         +NRVuTTqkByrYh43LHgaU9SshCrBAo+B1U6KE4blt+wn4dqPlACUkKlqEsPKFPxCNs5+
         z2/MzLxCVHggmPO4RKChQEN2gVJfC28yNngmE/Ye9Vb6M6Q48/S4cgmFf6yMGLNzczzw
         G1gQ==
X-Gm-Message-State: AOJu0YzGrbNMXoKJ3gprrQdTRmFAQEcvMZyl+cEUFIoldRDJwyf0J1IB
	G4UXb/yUQSlfNQfM6FDSKYmSnjRAIL/Rsfk+u7bpoZ8JP1sI/pQ7176TLptByr1pIe8t0VfxXjm
	3pnuPK9h1yJBwILNQTSd/A2GjAI4cS6Mo
X-Google-Smtp-Source: AGHT+IHwPphV6MLS78QvK/Hb2Ri8UNuAl+EpYWu4qLeBJDJ6OyUjnt8Fx2wiur1czPfIbqPI+85DiaplsdIKj4+yPTg=
X-Received: by 2002:a17:902:e546:b0:1e4:2451:c2b5 with SMTP id
 n6-20020a170902e54600b001e42451c2b5mr13367090plf.13.1715031888990; Mon, 06
 May 2024 14:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506151829.186607-1-cupertino.miranda@oracle.com> <20240506151829.186607-3-cupertino.miranda@oracle.com>
In-Reply-To: <20240506151829.186607-3-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 14:44:36 -0700
Message-ID: <CAEf4BzZZVSdBZc31-705-JtyHLfnacCW9G8Mr4SviBkKo9osMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Change functions definitions
 to support GCC
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	David Faust <david.faust@oracle.com>, Jose Marchesi <jose.marchesi@oracle.com>, 
	Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:19=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> The test_xdp_noinline.c contains 2 functions that use more then 5
> arguments. This patch collapses the 2 last arguments in an array.
> Also in GCC and ipa_sra optimization increases the number of arguments
> used in function encap_v4. This pass disables the optimization for that
> particular file.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>  tools/testing/selftests/bpf/Makefile              |  1 +
>  .../selftests/bpf/progs/test_xdp_noinline.c       | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e506a5948cc2..6fe9b0dd2ea0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -86,6 +86,7 @@ progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS :=
=3D -Wno-error
>  progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS :=3D -Wno-error
>  progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS :=3D -Wno-error
>  progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS :=3D -Wno-error
> +progs/test_xdp_noinline.c-bpf_gcc-CFLAGS :=3D -fno-ipa-sra

Can this be done through `#pragma GCC optimize`? If yes, let's do that inst=
ead?

>  endif
>
>  ifneq ($(CLANG_CPUV4),)
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tool=
s/testing/selftests/bpf/progs/test_xdp_noinline.c
> index 5c7e4758a0ca..a38199f900ec 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> @@ -588,12 +588,13 @@ static void connection_table_lookup(struct real_def=
inition **real,
>  __attribute__ ((noinline))
>  static int process_l3_headers_v6(struct packet_description *pckt,
>                                  __u8 *protocol, __u64 off,
> -                                __u16 *pkt_bytes, void *data,
> -                                void *data_end)
> +                                __u16 *pkt_bytes, void *extra_args[2])
>  {
>         struct ipv6hdr *ip6h;
>         __u64 iph_len;
>         int action;
> +       void *data =3D extra_args[0];
> +       void *data_end =3D extra_args[1];
>
>         ip6h =3D data + off;
>         if (ip6h + 1 > data_end)
> @@ -619,11 +620,12 @@ static int process_l3_headers_v6(struct packet_desc=
ription *pckt,
>  __attribute__ ((noinline))
>  static int process_l3_headers_v4(struct packet_description *pckt,
>                                  __u8 *protocol, __u64 off,
> -                                __u16 *pkt_bytes, void *data,
> -                                void *data_end)
> +                                __u16 *pkt_bytes, void *extra_args[2])
>  {
>         struct iphdr *iph;
>         int action;
> +       void *data =3D extra_args[0];
> +       void *data_end =3D extra_args[1];
>
>         iph =3D data + off;
>         if (iph + 1 > data_end)
> @@ -666,13 +668,14 @@ static int process_packet(void *data, __u64 off, vo=
id *data_end,
>         __u8 protocol;
>         __u32 vip_num;
>         int action;
> +       void *extra_args[2] =3D { data, data_end };
>
>         if (is_ipv6)
>                 action =3D process_l3_headers_v6(&pckt, &protocol, off,
> -                                              &pkt_bytes, data, data_end=
);
> +                                              &pkt_bytes, extra_args);
>         else
>                 action =3D process_l3_headers_v4(&pckt, &protocol, off,
> -                                              &pkt_bytes, data, data_end=
);
> +                                              &pkt_bytes, extra_args);
>         if (action >=3D 0)
>                 return action;
>         protocol =3D pckt.flow.proto;
> --
> 2.39.2
>

