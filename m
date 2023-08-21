Return-Path: <bpf+bounces-8179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C8783106
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4779E1C209C0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660911718;
	Mon, 21 Aug 2023 19:44:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437F11707
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:44:16 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE155C2
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:44:15 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso27709801fa.1
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692647054; x=1693251854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7X9ySo5OwLp8DKa7+5HcQtvJJ7TyUa5Kwrdm9pFChw=;
        b=iKMpIExi+a4WJylqTdILmurjCOSQXYYE+C6TfCBOnZtRXVR88X9Sn4ZwddkIWWKNkj
         IE2zoZNUyho9WVDtqRMcwSq1/btQIRaa3JGJdnwAA9UEIwB3g9qIbUPQg1aMRPvtbNCS
         S79e77KRgW2xVsrKSmtr97lfsjnc77pYuK+B2ffes9oQZ1ANhFUszxfrYl1RCfk448Ef
         1/WYkONx1/bA3+VujSXCd4Nb8jG2y0CY1lhN7sZz86kTuPtco6Xs5nLNnx71NLKLOze0
         kOpXE8ZtMwPTJc/xzoCypOKn1DsxoKPNKWBmjJLYu2vFEvjSfULqIJ7n+trzT3Hg+aoC
         uHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647054; x=1693251854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7X9ySo5OwLp8DKa7+5HcQtvJJ7TyUa5Kwrdm9pFChw=;
        b=jKcnod7iClswzORBSInxYZNypoSEhQpItyIDj9sWXTlz5Skj/UwZbsZCCTuY8HZMRt
         mtu1WvT2IlN891llcDbaA0iPcuUBzzFJ7uOJb0jrcH9aOxCfrRM0jlB9izYyaiAT16Fu
         mPxlGnJUcPxFFTVUKqTJ9ocltDoeBg+uOQXduoqDmG0r8xtWaDT1ORKdb4QtzPJ0WBgd
         0foLnI7CkTBXFfiNUxGcs9dLj+XdQTuMVjkAsBmzDa+L7rumEIJ7fUbuTQYhF8B03NW9
         x4ZBNeonGfuz34AbAcGbZA5MV0wJ/dU4/QHPzIaK9dDKlzAqzI5CK/Iq2u4On6flqr6e
         c7Ww==
X-Gm-Message-State: AOJu0YynHByo06e314HEFO3ZpHBy35QYv5HbsQfyyiTvsiNJNeHioMV9
	LaHbEXFlicdII9LXxQSIr0LpPlgxqI3e+GGsOnQ=
X-Google-Smtp-Source: AGHT+IEHgeomnO5wZ6ULpr6VDVVcvSdLMhLzuq9ZUdDFn+qmGVxGeLQTiGPlN+6kLgTpUYWdVc4WEAcLKcoaK69PF+E=
X-Received: by 2002:a2e:7213:0:b0:2bc:cdfa:3d82 with SMTP id
 n19-20020a2e7213000000b002bccdfa3d82mr335086ljc.38.1692647053615; Mon, 21 Aug
 2023 12:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev>
 <CAP01T76hm=FBU3f9EePUsV525g=RFw0KPvSRn5BjHo=QGD_qEQ@mail.gmail.com>
 <4a5a4fbf-fd9d-2723-2a5f-9a9da162bd5b@linux.dev> <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
In-Reply-To: <CAP01T77R=sKccHMc5jrEF2vGyPpAGM25+ompTcT+W8W-mZCk+Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 12:44:02 -0700
Message-ID: <CAADnVQL-795Wzhy7E3N5XgVT0OgL0eFMwXxsD1myBGRbUVwaEg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a bpf_kptr_xchg() issue with local kptr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 9:03=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > >
> > > The fix on its own looks ok to me, but any reason you'd not like to
> > > delegate to map_kptr_match_type?
> > > Just to collect kptr related type matching logic in its own place.  I=
t
> > > doesn't matter too much though.
> >
> >  From comments from Alexei in
> >
> > https://lore.kernel.org/bpf/20230819002907.io3iphmnuk43xblu@macbook-pro=
-8.dhcp.thefacebook.com/#t
> >
> > =3D=3D=3D=3D=3D
> > The map_kptr_match_type() should have been used for kptrs pointing to
> > kernel objects only.
> > But you're calling it for MEM_ALLOC object with prog's BTF...
> > =3D=3D=3D=3D=3D
> >
> > So looks like map_kptr_match_type() is for kptrs pointing to
> > kernel objects only. So that is why I didn't use it.
> >
>
> That function was added by me. Back then I added this check as we were
> discussing possibly supporting such local kptr and more thought would
> be needed about the design before just doing type matching. Also it
> was using kernel_type_name which was later renamed as btf_type_name,
> so as a precaution I added the btf_is_kernel check. Apart from that I
> remember no other reason, so I think it should be ok to drop it now
> and use it.

Agree with Kumar.
When I said map_kptr_match_type() is only used with kernel BTF I meant
that as code stands it was the intent of that helper.
With MEM_ALLOC being kptr_xchg-ed it's better to share the code and
map_kptr_match_type() should probably be adopted to work with both kernel
and prog's BTFs.

And as Kumar noticed __check_ptr_off_reg() part of it is necessary for
MEM_ALLOC too.

