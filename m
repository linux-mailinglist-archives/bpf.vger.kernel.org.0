Return-Path: <bpf+bounces-15082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67977EBB02
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 02:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1520D1C20ADC
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FE647;
	Wed, 15 Nov 2023 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOH+ngyF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28739F
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 01:48:23 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B5D5
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 17:48:20 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso3704046d6.1
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700012900; x=1700617700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcbIJmn6FQ6NUQd/5wateuIyXIAZ0RCy4JRfDFLCOn4=;
        b=MOH+ngyFmbF4xoIi2JJVwOOfdieyF9pjaRS+nFBBecPlCgpNcnD9TWbDgarO+3NJ1D
         LNQQFFh0rdqFCUJD/zMxz5vnksfmc4JEDZ+37L+iK2+/RCGi9t7KKTLKNYkIY1lPUWIO
         /Ko+o14sn5UXVOsWYg+9RjlsVir5dGc8TAi09+oU3wN7JVLbDCP+U1pLl5Jb4QcTWZQe
         hcvHf/MASbJvkz6ubGHTINEdBWXp8rw5OASu+9dyzlKP4LrmA/eMEdk2Tvvl5f0v+h2g
         atfuz97Wz3Fbo8pZvLZmveB+5rsXIKtUqPXrvNRUc7iUaf5Lxy+0dHNhBFpZ42DDS9oP
         V0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700012900; x=1700617700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcbIJmn6FQ6NUQd/5wateuIyXIAZ0RCy4JRfDFLCOn4=;
        b=kGjVBay8b57XndHamraVjbuhw2LoMEonzRx7XOZoiotgjVqjzsBNZxFc1G5aJ62H8d
         M7tdBRY6apw2rAZPMmhN3bl/MvUHdLeyNSR3rwMvPAxvZsdx9HG17mSYmTt7vIS8h0u6
         LT61nKnuK98KoSTgL+cquuWRbQQMMo7IOiTjRWy9rEhMZBfrWPrpuKH+YSPcGRVWpoU8
         5TopALdbO2EAY+//+aIcEgkFyvd38xy+hf1SOb+srjpxj7DagyUoVN1W71L/Xqt6l1hh
         TdPTbPLq3c+xsnhkBPaWhSitslBVrv56MEhczi8wNezMRBO4iTTZWEwcqE4rqdn05yMR
         9T8g==
X-Gm-Message-State: AOJu0YwLTbM59kfx44Q4e+iWOCE/RSHSBtAGaN4wwK9K+hha3/JojZQN
	AOmq19/f+uwdVptHQ0nqw+v4i1h2k7lksz2JwEs=
X-Google-Smtp-Source: AGHT+IGXfaCTixdXgdzrzz6e88ChwUkuJUKpDvV0IA+8Y/pZ1/qAl2SKJ6IrBb0WrKbPu/YuAwMxG/2R1ObFcEkxvEg=
X-Received: by 2002:ad4:58d3:0:b0:66d:58ab:10d9 with SMTP id
 dh19-20020ad458d3000000b0066d58ab10d9mr5793435qvb.2.1700012899830; Tue, 14
 Nov 2023 17:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111090034.4248-1-laoar.shao@gmail.com> <20231111090034.4248-7-laoar.shao@gmail.com>
 <CAADnVQKoK6ROsiTpS5AkxaZW_MBUK_aSpUAfG=tQZKnSetqyNg@mail.gmail.com>
In-Reply-To: <CAADnVQKoK6ROsiTpS5AkxaZW_MBUK_aSpUAfG=tQZKnSetqyNg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Nov 2023 09:47:43 +0800
Message-ID: <CALOAHbBmLHiDDjxM3vYRnWExMJMdg6=SZ4R3vTfbDKFLSGOY5g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: Add selftests for cgroup1 hierarchy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 1:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 11, 2023 at 1:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c=
 b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> > new file mode 100644
> > index 0000000..979ff4e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//#endif
>
> Removed while applying.

Thanks for your careful review. I didn't realize it :(

--=20
Regards
Yafang

