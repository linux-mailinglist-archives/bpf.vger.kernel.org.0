Return-Path: <bpf+bounces-4776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E174F5AD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE462815FC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CD19BCF;
	Tue, 11 Jul 2023 16:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5E18C31
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:39:00 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199D10C4
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:38:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso2552863a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689093537; x=1691685537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW5Lss+VyAVu6r54Ozn+F9PEbk/7TEytGf/+0SGVMOM=;
        b=SR1g3F7O4KC4fG6RPCmHclYmQomk9wqj2LLG3s+Riwo+X7ZQBeF08NZXwEqR6ff8Kd
         Dp5l46qWcnxhPmCphsIEWEpXoGnyJwbH+OHx2QMfmEjE1G2DoUHi1HMGPkCw0c+xz1OG
         5Pu2usnE+C+M1HC7U3D8JdCu34A01CzqT0VBW3jUBV/mrYoVF/hzHM7vd5xshO+9oQP5
         Tw/yzgaFMhFcOmGRQU9EOMAUrpfL35q5PxVvgNrBhElJEu562Q4RqnMoPhcc2r+dSpPB
         MSDcHJgPVeGryoieW//tTV8D93KLzFRE29NvmCjpae784CmdjeYRnnANsBO//2DFKSkk
         G1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093537; x=1691685537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW5Lss+VyAVu6r54Ozn+F9PEbk/7TEytGf/+0SGVMOM=;
        b=Me2SDy6ETwcqHgNMRXfbzMyXxUZahWLasBK5vYCQk1YH8R6gednnGOayzQIrRaO15r
         hR93PP8cQWN7rQfbIik9dBD1m8Q58GbyAIsY7vS/CAOGxS8brZIKqvM5TN/Ed03E9Jkm
         8Hxiz15REZvFOJMA/2sGBnLx87GwpscXeYM3fWcHZtQyqHdSMwc2Fxx5QWC2EAHMU3RF
         Iwuisj/Viidpqpvtr0+wIV35D5DP8TBjw4CUp8D95Aq1/8S5VJqsqza4sNu1TLNUrED9
         HzpDxtUhBdl1ntdE1F3krqHS7aObyhC9yXjNYCH2rh0aeB2zNbwB3zOSXB2YqMOlJL/g
         g4gw==
X-Gm-Message-State: ABy/qLYoc3CzNMDRhYREodPCj9LevFPz1gb4wnZk2y/IEM+vF0xcTP8L
	mDjjnrFzesVT1MzOWhhTyI56Ais8m2inw2JUxIc=
X-Google-Smtp-Source: APBJJlHwzVCpx92w8N2qaaWLYqS48Ci5cZxF8mOQj9VWlHBbINVvE6+I/QvVdJt3NR6TPPAk+FB94j0xzm/nLOkHWqg=
X-Received: by 2002:aa7:c7c4:0:b0:51e:7c:5025 with SMTP id o4-20020aa7c7c4000000b0051e007c5025mr13760998eds.9.1689093537199;
 Tue, 11 Jul 2023 09:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAEf4BzbSdggvGD=xXZxFa8tjUxGWKrsb5hL9EP_viHqQCG+MYA@mail.gmail.com>
 <CAN+4W8iOWyZ9ozZ6xaJyQaMO1J5hNoKOkZ8pN8U9mFBZYa3vwA@mail.gmail.com>
In-Reply-To: <CAN+4W8iOWyZ9ozZ6xaJyQaMO1J5hNoKOkZ8pN8U9mFBZYa3vwA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 09:38:44 -0700
Message-ID: <CAEf4BzbUQE+dEr7ctqH6cgcXWXbsPq1m6FFve9Ozbo1DghK_YQ@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 9:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Thu, Jul 6, 2023 at 10:07=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I think it's better the other way around: make BTF_TYPE_ID_LOCAL strip
> > const/volatile/restrict modifiers. For all other relocations we rely
> > on having named types, so const/volatile makes no sense and will fail
> > relocation. It's hard to come up with the situation where recording
> > const/volatile/restrict in BTF_TYPE_ID_LOCAL would make sense, so I'd
> > say that it should behave just like all the other relos.
>
> Would the relocation then point at the stripped type instead of the
> start of the qualifier chain? I found this by running our unit tests

yep, I think it makes most sense. Important is to not skip typedef,
it's not really a modifier (and libbpf code base makes it very
explicit, unlike in-kernel handling of typedef as a modifier).

> which essentially check that the compiler generated local ID from the
> instruction stream matches what the lib generates. I'd like to be able
> to keep doing this.

