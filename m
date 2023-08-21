Return-Path: <bpf+bounces-8194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC607835D7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEEB280F6E
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12084524F;
	Mon, 21 Aug 2023 22:35:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B423DF
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:35:43 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B980FD
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:35:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso60631691fa.3
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692657340; x=1693262140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gowQBBB1cgvyeu7wX5VURFCdPtktT404wDzuAg5OgJk=;
        b=mTDE06VICQBaIAeH7mgBLwTci19amC3KOnrx2BIiMj9miHFdONizP4VDI2GNG/bGBr
         7fjYnmmnue4UpiNGTp2L02fEd8HxokhFNkx7xzLGY9I8pCe/V9Dk+QqNNf1SqPvUofq0
         WHnHlBNfrM9URSm1EOm7O+ekmvXRxWYMgeGr1mpEYeZe45M8G6mmypr6NJvzhBiQtJza
         /tsxJ9RX1eHOt9BWcBLjU3PjnCFUkqzF+xHXqkqbRypz0zc4tHDlZUHNB3pR4lbCGEzA
         zf3R+Z1pyipTrtNNWm+QeW4xwJInZSB9WkbQQMGiw17HusCgpfYLb/tTRQ9e8HzrhYk2
         njOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657340; x=1693262140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gowQBBB1cgvyeu7wX5VURFCdPtktT404wDzuAg5OgJk=;
        b=Mz4gmykPmwW63fB0YD0Lj7nrh6NFBAdYFn8D7v2ainJyRDIsmTmCVG3eie0UnELbvy
         w/p34kwx3tSp5pAwlb3TeyYxNPdan7Av3V/ujLntCwia94pfaIz/4CvEvX5kTmAiDQQ6
         qEWddnuZIHylMwgMXUQraUMfgcwkek53sL8Oo5qK3JyDc2LpQsHnd94txcxGSD0y7Cia
         r2lXMq5BTpLAaXeei39hx85iUkjmAFOtWSdIsZWRxeAQfYaaJQpbmWyXEIWkdqjQ/jRP
         Jt6vDzmKQdCxixZRZXZAuTtxM4bd2wdElMhoJ/GyGNeUWBOtr9QG74SRSGUoJUsw8F7M
         s3xA==
X-Gm-Message-State: AOJu0YxbJhCvPjHfQmGGCnQzQ283b0BZYZ9ITLC2Jvqcn8/BazsDV9n4
	X5s7JXin1y9sAbvQbWQtsYkc6zof6SXgmOxi/gTFi0eh
X-Google-Smtp-Source: AGHT+IHbabbPTKZdvqOCYULvTSu3sse9APOJpDiqxqM9nDL8XWA+BHA5pF011Pf4DICu965B6MCSYa0XKwGzR+O2Ihc=
X-Received: by 2002:a2e:8716:0:b0:2b9:ef0a:7d4a with SMTP id
 m22-20020a2e8716000000b002b9ef0a7d4amr5149021lji.36.1692657340163; Mon, 21
 Aug 2023 15:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
 <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev> <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
 <CAADnVQL-795Wzhy7E3N5XgVT0OgL0eFMwXxsD1myBGRbUVwaEg@mail.gmail.com> <9ae87beb-af3b-1b45-9027-e8a8e2399159@linux.dev>
In-Reply-To: <9ae87beb-af3b-1b45-9027-e8a8e2399159@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 15:35:28 -0700
Message-ID: <CAADnVQKwFwJWz-Aq7=kbLD0LxngU43j5E5q-ASNjAsdUYpQx4A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 3:13=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/21/23 12:44 PM, Alexei Starovoitov wrote:
> > On Mon, Aug 21, 2023 at 9:03=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>>>
> >>>> The fix on its own looks ok to me, but any reason you'd not like to
> >>>> delegate to map_kptr_match_type?
> >>>> Just to collect kptr related type matching logic in its own place.  =
It
> >>>> doesn't matter too much though.
> >>>
> >>>   From comments from Alexei in
> >>>
> >>> https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-p=
ro-8.dhcp.thefacebook.com/#t
> >>>
> >>> =3D=3D=3D=3D=3D
> >>> The map_kptr_match_type() should have been used for kptrs pointing to
> >>> kernel objects only.
> >>> But you're calling it for MEM_ALLOC object with prog's BTF...
> >>> =3D=3D=3D=3D=3D
> >>>
> >>> So looks like map_kptr_match_type() is for kptrs pointing to
> >>> kernel objects only. So that is why I didn't use it.
> >>>
> >>
> >> That function was added by me. Back then I added this check as we were
> >> discussing possibly supporting such local kptr and more thought would
> >> be needed about the design before just doing type matching. Also it
> >> was using kernel_type_name which was later renamed as btf_type_name,
> >> so as a precaution I added the btf_is_kernel check. Apart from that I
> >> remember no other reason, so I think it should be ok to drop it now
> >> and use it.
> >
> > Agree with Kumar.
> > When I said map_kptr_match_type() is only used with kernel BTF I meant
> > that as code stands it was the intent of that helper.
> > With MEM_ALLOC being kptr_xchg-ed it's better to share the code and
> > map_kptr_match_type() should probably be adopted to work with both kern=
el
> > and prog's BTFs.
>
> Sounds good to me. Will use map_kptr_match_type() in v2.

btw it's a bit risky for bpf tree this late into rc-s. Pls target bpf-next.

