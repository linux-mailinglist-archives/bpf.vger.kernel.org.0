Return-Path: <bpf+bounces-67137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B93B3F25A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD1B189CF6F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDD2253EC;
	Tue,  2 Sep 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR1f331j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206533991
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780372; cv=none; b=SGHnWpx2xVwwTdOj1RgXEVIoSXhsqnTnE2/YfIXZKYTXVGkhYOePbQMJ9h4llBJbNoxPlwzhTV9k/ilx/o7z3fQXzqtIBJja0r2wG4pYY0s7maehoQxbfVsFSDeL8WkMqf3Tif/AADaCF+gmcUkXsH60P/Qawc7mi94x+pcOt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780372; c=relaxed/simple;
	bh=Yq8uTi64Mduu42jjQm0HY+DYjGxKk8q/YO4TY+g6hhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P45xLvIS8xyCeGQ0p4o4jjplEt3mphnzSEvfFP+PKLVMFo4Jm3C0ZWXUMqkhdnlPdKKhY31mqIYWPq4YSbWz2dLcz86G15TTmKs7T0V/NK7j+zml2XIxsZw+O3eV7visaMZPnZUsZn/1rfnj6lFOfz8Fj2EXpwVhwrjLIugw3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR1f331j; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so9754151a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756780369; x=1757385169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkL/ISXOKnOpKl146OaXX9PfJdswLnWs37BhaSumANk=;
        b=eR1f331jly/odYXY+Qzz5v1in/on0z/K6+4Qmj7wZeJS29/hr5g6/tRb8h/luhtmVd
         ptwSX6drGDWxsKSyGfSKYuFrp5aiDRk6ztWyAfwN9L1BkXrPo9dINvziXzeqc+nCkF1G
         dW0M0sRRU66ywqs78PNqBDknDKl2YXXk1g77e/GSza+dlno4Evm7yYJy+QGfEjtyetew
         /zMI4kYI8pdIErdjAHrquN/o7ihXLPvqOr5EOq6OHTsgUlNX2bmlhjaKEa6wFxuBogR/
         Zkj3B8xA4pZU+qiE8TELzjSv6+NQTdHmiXjw8jYkK+PZW/O0jHLUpDFcrrolT4iO6sdI
         D/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780369; x=1757385169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkL/ISXOKnOpKl146OaXX9PfJdswLnWs37BhaSumANk=;
        b=dAVogTA2+WlD/HcCXc9t3KbPztEc4OvAHA0X5G0H8nnGG6C1SP3M66Bsqkpq9EQ78v
         Ir28uWYvAXztAH+F4r0QhY8c5z/5qhvFeACO+nKR5Qmal1b5SHNasEshr1H1lZmcJihV
         9rVfifYEFmwTl4R09D5J5CWfOWP0CXL+dXE1gfx5t9Ha98hH0UJT9kgupGQvo9dKxkcf
         zKrCqs2xYP/0BCo9AwYxKEx9nGtRF6yMqqhsE8X+JUg9nP0ztXyhh63LgSKGrVDww5OD
         vcUH1wqRVZxdb8GLv9J0K5Z4X+56+HJ1EhGDGqAy+Wk3YtiCLX5mIdVJr2VslMfBOGDJ
         MxBg==
X-Forwarded-Encrypted: i=1; AJvYcCXEX+0zmaLIjsXAsEknZlvnZC3Ke2a15de20nUdgBG+VhuhMunjnah9vHKPsUYvS6rrdJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88EvKQnErfGS0I+S7AZDaEaCSt923w6MfBJRFGlwrg6xijGAg
	Q7eskPvxhu/zDX17dTiMdbl3AsqdAmvGD0nUwCUlm+/Jr+o1qsP3n0RbN2ys0dSPgwjGvwFlFkj
	M3JQShFsm+9YMEFCSt0xMFvUEJVrvkvD9+Ybz
X-Gm-Gg: ASbGncuGPWCofrgX96VbenRpufu/dn0AoGKPZDlOHSbP5E1uajNgVSvWvPs+KMdRd/H
	FRXe+CvMZs0yNMQlWQWvdYuFDw7OcOeBmo6cCUSmmgexX2CeFkltiJxrT702CuOHsCnvUr3EfSz
	2H2N2IJX1V6Bf0XiE2PzvbeYods0PvIWMM/Fy07GV3sVSvVSfUGureIDIXdSzMF4VrhvL+0CA9W
	XeWYGB9HUMQseNRBljE5G+m0cjjUA==
X-Google-Smtp-Source: AGHT+IFT8mFrI6K6sKIlX6vuKDxkXDJ2v2EDZW3sTTvyo3zBE7svMsECKElAcwBPYvucakSH5ZxeGY+oqAGiCoJj5Gg=
X-Received: by 2002:a05:6402:2547:b0:61d:249a:43fe with SMTP id
 4fb4d7f45d1cf-61d26d9c38cmr10060929a12.24.1756780368828; Mon, 01 Sep 2025
 19:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901193730.43543-1-puranjay@kernel.org> <20250901193730.43543-3-puranjay@kernel.org>
 <CAADnVQLgcZyUgB2Uq7z8Vc0f=nTWLw8hNPZ2xzVCbWUJxuheQw@mail.gmail.com>
In-Reply-To: <CAADnVQLgcZyUgB2Uq7z8Vc0f=nTWLw8hNPZ2xzVCbWUJxuheQw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 2 Sep 2025 04:32:12 +0200
X-Gm-Features: Ac12FXxBEG-iXMn_f11YUoZsKC1VewQ3UHFaaCbHlQR7wQm4uADSbMHxwCykFWk
Message-ID: <CAP01T752t4vv3CmHmPVbqnhvemJz=szYQ9UXSMWbKgHSU24BMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] bpf: core: introduce main_prog_aux for
 stream access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sept 2025 at 04:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 1, 2025 at 12:37=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > BPF streams are only valid for the main programs, to make it easier to
> > access streams from subprogs, introduce main_prog_aux in struct
> > bpf_prog_aux.
> >
> > prog->aux->main_prog_aux =3D prog->aux, for main programs and
> > prog->aux->main_prog_aux =3D main_prog->aux, for subprograms.
> >
> > This makes it easy to access streams like:
> > stream =3D bpf_stream_get(stream_id, prog->main_prog_aux);
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  include/linux/bpf.h   | 1 +
> >  kernel/bpf/core.c     | 3 +--
> >  kernel/bpf/stream.c   | 6 +++---
> >  kernel/bpf/verifier.c | 1 +
> >  4 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 8f6e87f0f3a89..d133171c4d2a9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1633,6 +1633,7 @@ struct bpf_prog_aux {
> >         /* function name for valid attach_btf_id */
> >         const char *attach_func_name;
> >         struct bpf_prog **func;
> > +       struct bpf_prog_aux *main_prog_aux;
> >         void *jit_data; /* JIT specific data. arch dependent */
> >         struct bpf_jit_poke_descriptor *poke_tab;
> >         struct bpf_kfunc_desc_tab *kfunc_tab;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ef01cc644a965..dbbf8e4b6e4c2 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -120,6 +120,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned i=
nt size, gfp_t gfp_extra_flag
> >
> >         fp->pages =3D size / PAGE_SIZE;
> >         fp->aux =3D aux;
> > +       fp->aux->main_prog_aux =3D aux;
>
> Though I agree that it's not strictly necessary, this approach
> is so much easier to reason about.
>
> Kumar, wdyt?

Yeah, nbd, this looks fine as well.

