Return-Path: <bpf+bounces-68599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC8EB7C7B1
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DA77A5E16
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3E21B9C9;
	Wed, 17 Sep 2025 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT97onru"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E86ADD
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072423; cv=none; b=Vrt1LDKR3VN0OANqQOTMl0X+bHNySTHY4/X92CUkq8kZGKSkdsx5Lp8+sI2IiTatI3xDlW5jk9Q14UbnHY5KHG7HvGHRYVQaFw1S14tUGAB0FkiTvpaMvgaE3vpXCslnAN6NYoXg6s2SQkoiNn/N4QBNQQRuIOUZaJSd5+TpO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072423; c=relaxed/simple;
	bh=OO8zmUyQnSm8zjzOq40r2lX/Y3R9vgmUtjUcgS+NnD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw0BMzF5nevOMr3QXQx36r8xgPoxkTOxAm9j4B/2bx7xH3sOXRQkMEWlFuKc4Uus26CPyAuiFgtzv5jmq+JOkVsWmf9209crtWun66SctmZ6O07nfmOEjAJrSr6G+OV2xMOKMt6uY+buGZGBjpiZIq0tZ5BmJ/f/1+QqTaW8XzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT97onru; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-33158d9dfc6so2892196fac.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758072421; x=1758677221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XqSkYdpZzU0Uzvq+/sMxaFvS0q/3aGndbv/W6XWZmk=;
        b=bT97onruPf+8HpFGgOzP1geduMU1DmjbwiUMKIePXvBFzdDuzs54g8IF5O8sAVEYbf
         KzclOGbvUSWJBmAdk9Ly0lFuw20zXLG6FqAGgjetDRYptzGYA3WE0jkYnzOKTTp4DOsZ
         cKJxOM9eAqCYK9vDEoLUemkHa5vGsDYKHsymBe70Q4J+7bM4gcTBJvH75Wxih0WGCaVI
         qpoJF9hx4UFbo0sal5wLOCu00qZUuKWG9VueTUeD2/kEnDmdnf0t6DjvXDsUMIjyLM8T
         4hKibnsY5iPE3KF9h0/wDCZQVDQjA5pRDf3bmp9QfYIbenEYaIpOeSZvl66o0czoAcyB
         yu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072421; x=1758677221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XqSkYdpZzU0Uzvq+/sMxaFvS0q/3aGndbv/W6XWZmk=;
        b=GhHR7SPXo3B5PnRTfQGN723BpjgOD1MHyV3ppZ4OerSgG0MpNBFp4nU6pVApEuR6KN
         B+p9j4TICloOeyl3zE8JOXw5OPpfHJzIdpQpYMNWGACvc2SHozP+HOl3akC/W6SLbrpQ
         fieh3SmXIKtMXUGLD5Ug4mfZaE6N3LA0jA8NtRBGDgG/PG95+CDvgBnKqa7q77eHbe3z
         c9RqEYrooIer1yp2/1wpnPtjsL8lEMT8HaPLooAgP0yq0c+KkPMZBhNH/RWmBd20PT/y
         Zb7XbJvOM4StfdtrrvRssl7er0yG9Zqkt9LB+TM7oEjVk9iHM5TSGMHyBoXSy6F3YLBU
         7s8g==
X-Forwarded-Encrypted: i=1; AJvYcCV5GTolisuiBjCila0iIUpPmPB/cLem64u9kBATUWbpNU2xQ8OGRP3RhgCy98NRr7z2ZLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGVpjjl1xe27FShUtHH7lRgzWTazpUDU1LL/Txdg+Tut5bg8D
	PCriPP6PkNR2oK8BRJN8bHui4X96I9T8TRiWoc9P/4jnFmh/Bor3iFwdO9jVCT7ugO6WfCRfuGr
	VaPCTmyEENEBvJ3n6NkAW1qnI6Juf8Ws=
X-Gm-Gg: ASbGncveeQ2mJgF0Aca7Om1wSZ6n+nOEW5pQqJJH+5fTZVSukHKSJyVh2MsFZpCz5Gw
	E/AfDtSVe7KtEhrIUJNlj9kDh4Xzwr2k4dBkxANDmw5CIoS4m2sVTAzWychp5gMHTv1M9yl3gPm
	Z6ZPUgNsg1bO+tJJAlyO+tXUagjs0vFgX51BRl9kqej0tisyVpujAnR1uc8CAhd9QJiEyN4764U
	dK8rJI=
X-Google-Smtp-Source: AGHT+IGjUVSyx5TsNpYa8tANw3OI6ULDx89zcPbPzNBwXNISSgSqk9OgNUgjcBQIv/6MbuJVP4AVB3Y9UHychbdg7w0=
X-Received: by 2002:a05:6871:a917:b0:321:2b89:bbaa with SMTP id
 586e51a60fabf-335bce83581mr326053fac.6.1758072421269; Tue, 16 Sep 2025
 18:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828013415.2298-1-hengqi.chen@gmail.com> <mb61pjz2nmyu4.fsf@kernel.org>
 <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com>
 <mb61p4it2a7cu.fsf@kernel.org> <CAADnVQLjCT46WmdOpNUDMA-QxmFQJj185Pi2jdNnzYUcEuhX1g@mail.gmail.com>
In-Reply-To: <CAADnVQLjCT46WmdOpNUDMA-QxmFQJj185Pi2jdNnzYUcEuhX1g@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 17 Sep 2025 09:26:50 +0800
X-Gm-Features: AS18NWCFIEbL2_Ijd4gTgCRiC3U-BAiQujVWQeYAhDMhf7p4gST34Hq6d8CItJE
Message-ID: <CAEyhmHRYVOB0yfobJ3VBkY-D7o86O1vK7Q-0Ne+GShLpJ_p4iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize()
 in bpf_jit_free()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 16, 2025 at 5:51=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Song Liu <song@kernel.org> writes:
> >
> > > Sorry for the late reply.
> > >
> > > On Thu, Aug 28, 2025 at 5:10=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> > > [...]
> > >> Thanks for this patch!
> > >>
> > >> So, this is fixing a bug because bpf_jit_binary_pack_finalize() will=
 do
> > >> kvfree(rw_header); but without it currently, jit_data->header is nev=
er
> > >> freed.
> > >>
> > >> But I think we shouldn't use bpf_jit_binary_pack_finalize() here as =
it
> > >> copies the whole rw_header to ro_header using  bpf_arch_text_copy()
> > >> which is an expensive operation (patch_map/unmap in loop +
> > >> flush_icache_range()) and not needed here because we are going
> > >> to free ro_header anyway.
> > >>
> > >> We only need to copy jit_data->header->size to jit_data->ro_header->=
size
> > >> because this size is later used by bpf_jit_binary_pack_free(), see
> > >> comment above bpf_jit_binary_pack_free().
> > >>
> > >> How I suggest we should fix the code and the comment:
> > >>
> > >> -- >8 --
> > >>
> > >> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_=
comp.c
> > >> index 5083886d6e66b..cb4c50eeada13 100644
> > >> --- a/arch/arm64/net/bpf_jit_comp.c
> > >> +++ b/arch/arm64/net/bpf_jit_comp.c
> > >> @@ -3093,12 +3093,14 @@ void bpf_jit_free(struct bpf_prog *prog)
> > >>
> > >>                 /*
> > >>                  * If we fail the final pass of JIT (from jit_subpro=
gs),
> > >> -                * the program may not be finalized yet. Call finali=
ze here
> > >> -                * before freeing it.
> > >> +                * the program may not be finalized yet. Copy the he=
ader size
> > >> +                * from rw_header to ro_header before freeing the ro=
_header
> > >> +                * with bpf_jit_binary_pack_free().
> > >>                  */
> > >>                 if (jit_data) {
> > >>                         bpf_arch_text_copy(&jit_data->ro_header->siz=
e, &jit_data->header->size,
> > >>                                            sizeof(jit_data->header->=
size));
> > >> +                       kvfree(jit_data->header);
> > >>                         kfree(jit_data);
> > >>                 }
> > >>                 prog->bpf_func -=3D cfi_get_offset();
> > >>
> > >> -- 8< --
> > >>
> > >> Song,
> > >>
> > >> Do you think this optimization is worth it or should we just call
> > >> bpf_jit_binary_pack_finalize() here like this patch is doing?
> > >
> > > This is a good optimization. However, given this is not a hot path,
> > > I don't have a strong preference either way. At the moment, most
> > > other architectures use bpf_jit_binary_pack_finalize(), so it is good
> > > to just use bpf_jit_binary_pack_finalize and keep the logic
> > > consistent.
> >
> > So, in that case we can merge this patch.
> >
> > Acked-by: Puranjay Mohan <puranjay@kernel.org>
>
> It's out of patchwork.
> Hengqi,
> pls repost.

OK, just resend.

