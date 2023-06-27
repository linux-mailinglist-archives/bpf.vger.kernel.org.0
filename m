Return-Path: <bpf+bounces-3599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC63740422
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D636E28113E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306F539A;
	Tue, 27 Jun 2023 19:53:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC24A27
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 19:53:18 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816FA272D
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40079620a83so67941cf.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=cSzqkm1d1b4AFhkJhViS8sDaJIf+PxUmJXSE1RGhTP6iCCCv38N0BIynlZA09gF4vP
         CpD6cB948INT3shzg+B7IOADAv1mqcb/d284GyeFR7u9Nxq4fDQ/N55DBiaX1FAvlzfk
         Diqjm5prhKaUtRZovQzs1wF6v5Q6+/PTGp2bJ1qMeOcIgAPHCQA7qRmQdIafxnNqmWqw
         MmjY3XWZjlu7Udq8ZL4PTQmd0SnSMlK0whx7TLERo3Mx3XYKbbGU17QRSaLVpQvt3Swx
         Vpc3OrS2B1C1fo8P7o8jU3KS9Lj2Cj+HHmHBerMNwmv6JLhJCO1FQ9ZNhdOIV5ceoHUs
         sJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895595; x=1690487595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLuI5nD00PYdmR0TV738RD1rmcrLwafP6/VBiaRjU1Q=;
        b=lhqIXmGemqt77LYp9Vftr1WEJ047WbDazHJ5Ug0bSAmBLdFOSYwB0xd5LvLlfhtcXy
         knX2aqsD6ndbEZQfzSYFZlTU+OUoyQKCpsNOc2MZPhtcllJtgS1dgnEZXse3KXGK9sSG
         oUd4aH1V3eW6f/yKG/jSaTQMZAN1FX/I6cumefY8ZQhXrH1+Ymw4bJJsmIHWYac4Jj7P
         ZEMTTUIvUjy9FkkMO2vkFN+rI7lZh1mm0zYHbz48lxaLII+QAsFGMho0a7jlX6F4ChYx
         +B+1tk6isobFeNhO1rVU8wiFGcsQ1en/BiSBdn1HPs2Wfc/YMQvReiTy1gyRQA476JpI
         9MkA==
X-Gm-Message-State: AC+VfDwMGJl1yUxS/1dUb95Afd1EZgXl7HzNJ7yPS7EUeNdOHj1ydHS1
	rVFr+Hu0DubTduXtD+d+OzOXvLzJRNl67QiYZXYj3A==
X-Google-Smtp-Source: ACHHUZ4WywyCYGtPMuvdFcpW2dqCRu0tWKd63P8E6CytwoFeUoTgkNgf73pWryoHaPsc+KPEWJlGKZA+hMjAqZ0nE+U=
X-Received: by 2002:a05:622a:285:b0:3f8:175a:4970 with SMTP id
 z5-20020a05622a028500b003f8175a4970mr37184qtw.18.1687895595463; Tue, 27 Jun
 2023 12:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624002708.1907962-1-maskray@google.com> <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
 <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
In-Reply-To: <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Tue, 27 Jun 2023 12:53:04 -0700
Message-ID: <CAFP8O3L_fGJWAcNEhFGBZF4mRi6ObOyupto5o4z80Zaa3x7PDw@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To: Namhyung Kim <namhyung@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 12:29=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> =
wrote:
>
> Hi Fangui and Yonghong,
>
> On Sun, Jun 25, 2023 at 11:25=E2=80=AFAM Yonghong Song <yhs@meta.com> wro=
te:
> >
> >
> >
> > On 6/23/23 5:27 PM, Fangrui Song wrote:
> > > -target has been deprecated since Clang 3.4 in 2013. Use the preferre=
d
> > > --target=3Dbpf form instead. This matches how we use --target=3D in
> > > scripts/Makefile.clang.
> > >
> > > Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de=
0a68135afc7f95def6277
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
>
> After 10 years of deprecation, time to change. :)
>
> Applied to perf-tools-next, thanks!

Thank you!


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

