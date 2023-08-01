Return-Path: <bpf+bounces-6582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B776B8FE
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A47281A5C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BB1ADDC;
	Tue,  1 Aug 2023 15:48:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640831ADD6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:48:50 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF6171C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:48:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so89419591fa.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690904927; x=1691509727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hat684yXoonrlSq+GZRQvDw/MHCTzzCkstZ7Vj0rsP4=;
        b=hPCzQDNfxMEfavpJiFIHwVOzpqdQWwPdxp+RLHJmhLNzuUJleKb7FLC94DAxvCKXxm
         Yx8LQLRgb++5wNKmJ1KUGW30RM2ilWLv5QQ6Xogf/uG84YkT3MCktEXCNPwiLkMLhS56
         oOC+UbbDroWOOA1d2Xu8Yy57A5Ap+DefwjgmXct+1lU0btqpdQVut08Jfuu/Q+PF9Ydx
         L1lTVaPAAqr2SQT8GqPZO60JIBIAdKX7kgQIbHMbC5UnsGy9S5PEYsrLhaysqoCyGwRp
         DoPJs/KNOrmeIaDS+/6WVavfyvx8pGSYErc91ARE4kGAOmG8x91DD8hPZvVP/up0ldBW
         Illg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904927; x=1691509727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hat684yXoonrlSq+GZRQvDw/MHCTzzCkstZ7Vj0rsP4=;
        b=Muvu4UqO7IMeBnozsCKV0NrcntLugSsQkt1n3sXIB/McJw0hyb3ij30DtgsLwdO5o4
         bjZWy//zUowi1ZvYfu6jfhU8XIWG94lfYzCua0LTakin92sn6kItyD5uiwENIpRWwyp2
         n/Jgy/scNO7A92X4W+jzGlK9wzwx6zZ4V0a8wxAWj6TXIruXOi9Tck7x7HIwuVqc2/Pf
         KEV5p4c7aDgQ/EbKIGiG1s9RKSfOjtA4galH6lZPHSql3+ufJ8PyETVtmsOHb/RKkYwH
         sp527Gh1CB0ezq9aKgLRbXatsU2SyZrEXvUEqew3kKi/I2mncuD2IiWgYwjuLuMQ4ER3
         d/sQ==
X-Gm-Message-State: ABy/qLYeGPMH74GbfkyU9EwB/EqFIOPvCAp4VfWGJiKEAd0uyY+ZUaAD
	NRI57CZpdpiDG0LXHCIL7YES6EvDNogevy1iXLDqOQeSFMY=
X-Google-Smtp-Source: APBJJlF0BMTFLjP67b3GyKekcl60wfrC+YbRog8LPxH26ki9kk7Vhr8S7KAdaFH/unGMcGovCqEcAAZehdL9/bpgj1c=
X-Received: by 2002:a2e:9e05:0:b0:2b9:e24d:21f6 with SMTP id
 e5-20020a2e9e05000000b002b9e24d21f6mr3014754ljk.20.1690904926676; Tue, 01 Aug
 2023 08:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
 <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com> <1036389e-2dda-4399-922a-e6d0c39934ae@kadam.mountain>
In-Reply-To: <1036389e-2dda-4399-922a-e6d0c39934ae@kadam.mountain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 08:48:34 -0700
Message-ID: <CAADnVQ+=D_PJicmcd7_zFjqk64VeT4Pgc2jFKTQNXjUaSpMyNQ@mail.gmail.com>
Subject: Re: [bug report] bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kui-Feng Lee <kuifeng@meta.com>, Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 11:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Mon, Jul 31, 2023 at 01:47:01PM -0700, Alexei Starovoitov wrote:
> > Probably the following will be enough:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 56ce5008aedd..eb91cae0612a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct
> > bpf_dynptr_kern *ptr, u32 offset
> >         case BPF_DYNPTR_TYPE_XDP:
> >         {
> >                 void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offse=
t
> > + offset, len);
> > -               if (xdp_ptr)
> > +               if (!IS_ERR_OR_NULL(xdp_ptr))
> >                         return xdp_ptr;
>
> Also please, add a comment to bpf_xdp_pointer() which explains what the
> NULL return means.  I couldn't figure it out.
>
> >
> > Also I've noticed:
> > void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
> >                       void *buf, unsigned long len, bool flush);
> > #else /* CONFIG_NET */
> > static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u=
32 len)
> > {
> >         return NULL;
> > }
> >
> > The latter is wrong.
>
> This the only part which I thought I understood.  :P  How is this wrong?

copy-paste mistake.
I meant:
static inline void *bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned
long off, void *buf,
                                     unsigned long len, bool flush)
{
        return NULL;
}
is wrong.

