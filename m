Return-Path: <bpf+bounces-14439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8157E492C
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C522281332
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68736AF1;
	Tue,  7 Nov 2023 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiejCbTr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D436AEA
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 19:28:13 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A149AF
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 11:28:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d10f94f70bso917848966b.3
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699385291; x=1699990091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TxyTTNcgDHrF8sz9GoQJEhSdxBMaJOFw2YNfr84FX8=;
        b=DiejCbTrEvbbq1YCFqGOndDdvDSuaiZfEAqBWULUoQyIP53ZYFtQcfqKgYap/9GZyV
         GXJBpfHjaMfIc5ER4qfPB6t3MPeeU0bqIXU8fHVML/BjUXAR5/EgONOicWmpHm0hois/
         b3c/wxfVMTrmKRQD0b2JWaDpAqwzix0eaWOcSwH2FvFZk1U3knaLoD3aOpAn1Zk/BKFP
         O8MpNV/ecMBxAtcU3qg4zLBGkkjFQrkKioRveXHHFG1HdvsT+k+Sy9GKBy2JPbHJsQZe
         5o0gJLThb6+tFfT6vEb8Gfa0+nQpXb5c8qhlwY/DDsnp1bhYcOa3wAgQJNeeKWcuGA7z
         yjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385291; x=1699990091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TxyTTNcgDHrF8sz9GoQJEhSdxBMaJOFw2YNfr84FX8=;
        b=ixzCJ1t+jrX0lUEGbx92VsHrKxbzgSJDipaxvCmQWJ9XzbhTydc2KNyF7nTqj263p6
         QivkHlyeBs80YeZeP8yAn5ZT4VXY74c6Z9zfnribXNerw65sE3T9BJEKZAyLB7oitrzo
         RDSj2zDgi5Mubg+70apJTtLYvRrUYS/RyyEo7NmizY40881+TOjxphknhSv2qwaKY0xE
         vMIBN/OIbcaPsT4wGpk2BM7kfjsT8NESfDQQfeSzf6bXAC+tero461CoYjMtEM3hzDq7
         VQhlUmwueDU1M1gMrQVUk8a+z9KxpmOT/pvzK0lIyPqGOrnwX6dilsVWmo+cdYMYCs+H
         IcmQ==
X-Gm-Message-State: AOJu0YxQh+FMDpVW1mxSFK4EQsafLcj7rgsC+F5oSiCBPKrHk7YElRCe
	hb78rin4hPXFrIzeBcqezBzLR1SqbEcibCX4OZfazo2F
X-Google-Smtp-Source: AGHT+IGKRdAIzA4y3Ie6r4FI6i7/gcdShAlMAZwqilOe3WLbJr6Jif0ZP3HMmPZqNqu0g9J1K0yO3gdTIryiCdyvPH0=
X-Received: by 2002:a17:906:4fd4:b0:9e0:5dab:a0ec with SMTP id
 i20-20020a1709064fd400b009e05daba0ecmr6430186ejw.76.1699385290519; Tue, 07
 Nov 2023 11:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107062936.2537338-1-yonghong.song@linux.dev> <9bd0b6b7-6a11-7727-e469-2e0c9cd9cb56@linux.dev>
In-Reply-To: <9bd0b6b7-6a11-7727-e469-2e0c9cd9cb56@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 Nov 2023 11:27:59 -0800
Message-ID: <CAEf4BzbXPW8Fxq2K0_eWB7xGzPMykwh_r+9+jFSNwYwgO9q0VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix potential uninitialized tail
 padding with LIBBPF_OPTS_RESET
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:55=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 11/6/23 10:29=E2=80=AFPM, Yonghong Song wrote:
> > Martin reported that there is a libbpf complaining of non-zero-value ta=
il
> > padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modif=
ied
> > to have a 4-byte tail padding. This only happens to clang compiler.
> > The commend line is: ./test_progs -t tc_netkit_multi_links
> > Martin and I did some investigation and found this indeed the case and
> > the following are the investigation details.
> >
> > Clang 18:
> >    clang version 18.0.0
> >    <I tried clang15/16/17 and they all have similar results>
> >
> > tools/lib/bpf/libbpf_common.h:
> >    #define LIBBPF_OPTS_RESET(NAME, ...)                                =
      \
> >          do {                                                          =
      \
> >                  memset(&NAME, 0, sizeof(NAME));                       =
      \
> >                  NAME =3D (typeof(NAME)) {                             =
        \
> >                          .sz =3D sizeof(NAME),                         =
        \
> >                          __VA_ARGS__                                   =
      \
> >                  };                                                    =
      \
> >          } while (0)
> >
> >    #endif
> >
> > tools/lib/bpf/libbpf.h:
> >    struct bpf_netkit_opts {
> >          /* size of this struct, for forward/backward compatibility */
> >          size_t sz;
> >          __u32 flags;
> >          __u32 relative_fd;
> >          __u32 relative_id;
> >          __u64 expected_revision;
> >          size_t :0;
> >    };
> >    #define bpf_netkit_opts__last_field expected_revision
> > In the above struct bpf_netkit_opts, there is no tail padding.
> >
> > prog_tests/tc_netkit.c:
> >    static void serial_test_tc_netkit_multi_links_target(int mode, int t=
arget)
> >    {
> >          ...
> >          LIBBPF_OPTS(bpf_netkit_opts, optl);
> >          ...
> >          LIBBPF_OPTS_RESET(optl,
> >                  .flags =3D BPF_F_BEFORE,
> >                  .relative_fd =3D bpf_program__fd(skel->progs.tc1),
> >          );
> >          ...
> >    }
> >
> > Let us make the following source change, note that we have a 4-byte
> > tailing padding now.
> >    diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >    index 6cd9c501624f..0dd83910ae9a 100644
> >    --- a/tools/lib/bpf/libbpf.h
> >    +++ b/tools/lib/bpf/libbpf.h
> >    @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_progr=
am *prog, int ifindex,
> >     struct bpf_netkit_opts {
> >          /* size of this struct, for forward/backward compatibility */
> >          size_t sz;
> >    -       __u32 flags;
> >          __u32 relative_fd;
> >          __u32 relative_id;
> >          __u64 expected_revision;
> >    +       __u32 flags;
> >          size_t :0;
> >     };
> >    -#define bpf_netkit_opts__last_field expected_revision
> >    +#define bpf_netkit_opts__last_field flags
>
> The bpf_netkit_ops is in the bpf tree. If avoiding a hole in bpf_netkit_o=
pts
> like above is preferred, probably the fix in this patch and the bpf_netki=
t_ops
> change should be in the same libbpf version?

Yes, they both will be in libbpf v1.3, which hopefully should be
released this week. Let's land the fix soon-ish so that it is synced
and goes into final v1.3.

>
> Ran the test in a loop. It resolved the issue.
>
> Tested-by: Martin KaFai Lau <martin.lau@kernel.org>
>

