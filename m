Return-Path: <bpf+bounces-62316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CAAF7F69
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20526583AD0
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFD257436;
	Thu,  3 Jul 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkTOpYgq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40A2DE716
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565037; cv=none; b=cmMpPV5Nj4u7ei+jR57QfRSIUGixtMKYR+u/8oWEVn5sN1m95dbWlYz5IZ9Q94tMf9hGfE3cOaDbtjcHQ2RPHGJLjEwPhHO4WkGcdlYq2ANf/TQkebhmjvBnDjG8suE83z8n9BfrfDXagGv2Ri5in837VTgG90hum43O00BMZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565037; c=relaxed/simple;
	bh=AvSiMhcPZfPTqnGmzeY7Ptaro29hGXvNc6vXJZOMHiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tzf+PbNyoEGCU9jkJA9Dwo9CIqjLqFt6TFW1XzwSiXXKoyg1cVaRLJuK8B4/tHODJnVT5/OBd3VCLp3QsQ9fczJNYc3CxmRQ3zOv4+yrBaik8pBnOqL6T3nEZBIDBBGAzn7ALWVthSPe8TDOjVYlyqbMm8fDRxwTfZD6ni4Ld/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkTOpYgq; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae361e8ec32so26517566b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751565034; x=1752169834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqe8fgke6z6XYzdbNUksB7foXQxOg4qIwgousOSqe6I=;
        b=LkTOpYgqKOIifqaR0/zVFMlnI2wOhlXx84k9IyK8dxP7687ML/aJ+B8o1o8MgF5uMK
         IEGdi4uRS4HK6IVAt6FAVSdEsy+Qh/57p/Zjr6xm+523HqUg0xGktZ0dBMecedqjWftW
         ltw3xYV+nFFS/f0k30KkpH+hRs1hb9l7d7TcuntLhEB+5oWPeeS1cVOfLbNUlKUKBLBz
         plxjSQgNi1irc8fowbYEbwW6ndMrJXi5aRNA/VQwuBlWkPaHQSlj/DygP6RfYwzoYD5q
         O2992cGyb3gFp+y5C/WmAtpqd349q5E3ZXsWROW5GTwfwUEpEd2u5knBQJtAZlmtmLZ1
         cjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751565034; x=1752169834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqe8fgke6z6XYzdbNUksB7foXQxOg4qIwgousOSqe6I=;
        b=u1QNOgkXl46rEAZBG7H8qA0a3HZptEs39floO/7Op1qETnZ5lq15t76RxswF77f0ql
         /NWjyyASU0HRj+2J23dP+MDR9WbzlMC7Wb8ZGPnqorC72ueGq1ykl1p93Jom/KxelXw0
         h81d2umatoAFm645WRKnrs6j9VOgKUd0bZQn+0QrKeVKDdqW1acFHWszZvyyLSwtNewt
         e9Jv4msG6wTrnJ4yIIyj8QbuRrlxmZ2GFCtk6Wi5dIp68ENGLnVK30mRt3S7Q3Sx0VAa
         qtxgfGkxXX4C8fd+z+XJAn9oaTKhYfQLWaGWN+Tah9KZw+FF/S1kYS02017el8H9sTSJ
         SX2w==
X-Gm-Message-State: AOJu0Yzy2w1wc/IZJ0gNtZhQstySNFa5GwVwCnE+W1axcfDIIkVOZ4yt
	bt2P/VfWFPejOaDbbLC81hGyv8zn6NHKVPcc3MDfrEONtOn8aAYhCL0blmr4rlAkjuBwGeexAzL
	EdpZtmFT5DavGmXgGCoKQeEodTKZA1Ag=
X-Gm-Gg: ASbGncvXNVJLOPT+MUSVP1dGWfUS4OL8yIVKls9+Sm8+eDg8rrDp/UJfOqE5vCTVOPu
	qUrEkAsDzL8WvmU4VAHYcWOSAAbe5f7Zhfx2M9U1jTZQpDPZBrZ0yRf+vCmUAPeWokw1EsWmGoG
	iT+UG8FLuM/Iyt9+8sTUy2Id7+0ny+wQd1s6fkV1FKPDCiPkQZzlGdKdafqYeaBsOUkspq8dfFW
	Ao=
X-Google-Smtp-Source: AGHT+IGfvO7fJWbW8HOAUECRPlvfYoFoUZNw85hg2q01JgWrOjbrIUUJHlqMQzDsOfON1ULuMLaygdxtbkZig7/3p0s=
X-Received: by 2002:a17:907:d89:b0:ae0:b7c8:d735 with SMTP id
 a640c23a62f3a-ae3d8cf0f2cmr418725366b.42.1751565033654; Thu, 03 Jul 2025
 10:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-4-memxor@gmail.com>
 <CABFh=a6iKrkcoZL3KUdrK3YMjuFUNM4NMp7k7y51J6h+dM+KRQ@mail.gmail.com>
In-Reply-To: <CABFh=a6iKrkcoZL3KUdrK3YMjuFUNM4NMp7k7y51J6h+dM+KRQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 3 Jul 2025 19:49:57 +0200
X-Gm-Features: Ac12FXxFeS_8rwdW6v4K-uw6amebz430jmGdiT9tvvS4NPNO6RPbWr-aUkkHvB0
Message-ID: <CAP01T74=9ksTsti8DwJACX4=DGBf2y3FYUwsiW02R7Fs-gfeWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Add function to extract program
 source info
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jul 2025 at 17:02, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Prepare a function for use in future patches that can extract the file
> > info, line info, and the source line number for a given BPF program
> > provided it's program counter.
> >
> > Only the basename of the file path is provided, given it can be
> > excessively long in some cases.
> >
> > This will be used in later patches to print source info to the BPF
> > stream.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h |  3 +++
> >  kernel/bpf/core.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
>
> Nits aside:
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 85b1cbe494f5..09f06b1ea62e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3660,4 +3660,7 @@ static inline bool bpf_is_subprog(const struct bp=
f_prog *prog)
> >         return prog->aux->func_idx !=3D 0;
> >  }
> >
> > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, co=
nst char **filep,
> > +                          const char **linep, int *nump);
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index f0def24573ae..5c6e9fbb5508 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -3213,3 +3213,50 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
> >
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> > +
> > +#ifdef CONFIG_BPF_SYSCALL
> > +
> > +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, co=
nst char **filep,
> > +                          const char **linep, int *nump)
> > +{
> > +       int idx =3D -1, insn_start, insn_end, len;
> > +       struct bpf_line_info *linfo;
> > +       void **jited_linfo;
> > +       struct btf *btf;
> > +
> > +       btf =3D prog->aux->btf;
> > +       linfo =3D prog->aux->linfo;
> > +       jited_linfo =3D prog->aux->jited_linfo;
> > +
> > +       if (!btf || !linfo || !prog->aux->jited_linfo)
> > +               return -EINVAL;
>
> Either use jited_linfo in the condition, or remove the shorthands
> above sin ce btf and
> jited_linfo immediately get overwritten anyway.

Good catch.

>
> > +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]-=
>len : prog->len;
> > +
> > +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> > +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
> > +
> > +       insn_start =3D linfo[0].insn_off;
> > +       insn_end =3D insn_start + len;
> > +
> > +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> > +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < i=
nsn_end; i++) {
> > +               if (jited_linfo[i] >=3D (void *)ip)
> > +                       break;
> > +               idx =3D i;
> > +       }
> > +
> > +       if (idx =3D=3D -1)
>
> This doesn't catch the case where we exhaust the loop without ever
> triggering the
> jited_linfo[i] >=3D (void *)ip branch. Is it worth using (jited_linfo[i]
> < (void *)ip as the
> error condition instead, or do we not need to account for it?

I think it will mean the ip belongs to the last idx, so it should be fine.

>
> > +               return -ENOENT;
> > +
> > +       /* Get base component of the file path. */
> > +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> > +       *filep =3D kbasename(*filep);
> > +       /* Obtain the source line, and strip whitespace in prefix. */
> > +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> > +       while (isspace(**linep))
> > +               *linep +=3D 1;
> > +       *nump =3D BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> > +       return 0;
> > +}
> > +
> > +#endif
> > --
> > 2.47.1
> >

