Return-Path: <bpf+bounces-13745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229F7DD600
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A62B1C20D23
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DC21A0C;
	Tue, 31 Oct 2023 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF2LXlJj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E622301
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:25:02 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B58A3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:25:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9640478a12.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698776699; x=1699381499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrTNaVnSNsjwGVuyTg1opuROSSPKby3EoNSe7d6QxOI=;
        b=NF2LXlJjRb1DUi1NH0MrUdk7JCktEu43H8I6vGhD5vnWef5HcR2t4pSxypumMK53O8
         x0MHwy+wLn+p6UeYhTD1Z46ExOvu7Im82N5e0gl2lrJMNjKxUUtBaaIR3RZBOswl33Is
         kI7j5TjY/d+Hi4PJ12ymNl387HJWZUt7bS4pjjALQgF++kcp3wmOLUoqsI3AT6Pgt7j1
         By7e1HFCt/4TqtAw03boi8xya1gEcn0H9sxo5B8kwEVwCLiO4vBU6841bjGt4Ws4lxPw
         mlXCPUY/+iLpOtxPDq3zPvaCCb1Jd2rtz6UEmBLEHZmp2BVTPQoxKXWtrJIKS0utX+8m
         I8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776699; x=1699381499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrTNaVnSNsjwGVuyTg1opuROSSPKby3EoNSe7d6QxOI=;
        b=MUJKtzr+QMIKTSau1/YFW5BTV9oEh54WTmEch9xavBtO22X/CLANTEGgM9OTkvqVzY
         65ny+I36vswwJu2Gp6J1wFkSX9d0PUv7v9+3LjDgqQGXoz08JTYJsF4mdA7+2+BuEDi9
         mcdjhTiTXD3idqgkJz7uJFGoUqBusbqE15yqP+0YSUOAwlRO+bICFsiZ2UCqDMurEiiH
         dcCSTkJ4q+Y0jMedrBGwk/A/JT5LRTR6FKBXsx28U0PHdVM09v+NvgRRnXLX5NyejJU3
         IQEVHwecq3BTNZQYqbnuOuwapj2rxGPC/ayzCSlOijBhYQLLjJYnvIjz4OD3CQQN2cjM
         d+uQ==
X-Gm-Message-State: AOJu0Yzyl2nZKpHapjmIvitEgC39mDnqs/dj8voKSHxUaRPqHcuGGONz
	d5nkv/TiKvGONrlbfifXcwaiLE56kOf7rwvxY5k=
X-Google-Smtp-Source: AGHT+IG4VAMXj24kljRSeUqNc8WQZyYslN4IlI06X4zgXXsZwe7qwh/zEhMleWm8HASSZ3HQ+AeZSlztaHeVyJS/yg4=
X-Received: by 2002:a17:906:dace:b0:9be:23a0:68b7 with SMTP id
 xi14-20020a170906dace00b009be23a068b7mr121782ejb.73.1698776699011; Tue, 31
 Oct 2023 11:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
In-Reply-To: <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:24:47 -0700
Message-ID: <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc: Yonghong Song <yhs@meta.com>, Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:46=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovalen=
t.com> wrote:
>
> On Thu, Jul 6, 2023 at 5:50=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
> >
> > But I see your point. Maybe we should preserve the original type
> > for BTF_TYPE_ID_TARGET as well. Will check what libbpf/kernel
> > will handle 'const int *' case and get back to this thread later.
> >
> > >
> > > Cheers
> > > Lorenz
>
> Did you get round to fixing this, or did you decide to leave it as is?

Trying to recall, was there anything to do on the libbpf side, or was
it purely a compiler-side change?

