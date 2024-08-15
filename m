Return-Path: <bpf+bounces-37322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D8953D33
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801C31F21E3C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F781547C6;
	Thu, 15 Aug 2024 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHq1s3rt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4A24211
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759938; cv=none; b=RubzTQUPnjioqKDb7dPEvp238eIVHKUMDpJla9iOmDezc1vIfWSaqNF4wR05Tgvd6e8wYvjyrybPZz40OIVk0ZjjubnvulcQ0EShu9FQE5cqyvFbtWAfSiVoBC8vkoCe4km3I/LJwP1oNpBJOqAuIRB8uI0Fk6ygC60YleDr/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759938; c=relaxed/simple;
	bh=h4asnectJz4/1/X0592kLj1BCcEXEtw5+W/TmLnTpSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLeN50nK9RUcMh6xGZPXz+FW/a5yBbRRsC2QwuJC0IKaHG0rrhvoyTyF0gv+ld4QYGEH/J6BVgFzp8VnzCc4blO6mjjlaItzbuNGtwjWKZumJvbl+kZzAZTWoT2ALqU5PG1cWB5kGrDB4UvB0xJK0SWTGgRiuXIu0ML19Vbq1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHq1s3rt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso1031855a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759936; x=1724364736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gkXAjhcm1OgvcFVQzCy9kNGNCCpTsPBQvBEWoOVSK8=;
        b=VHq1s3rt2zAcufVw9uGqzgirevPp3O/7Upt3DNiTiR8lrcSPclEC8eqARdt044+Yxq
         Cv4PC0qOAEvO+rfIwBIrhET1AdZyZf6H/U9Zd6Kh53CwD/5AjGc3Ofs/S6gohP4hRbjR
         vDJEi5IDfEneXOQRSTQHNEMBa7M8LJUnjsaL8aqg2W7oWXGDl0sfmTXjS7EdmtpSesyJ
         ECzM7yIMTUBQsvYiq+kJ1+aA5k2JjmNsi25FgzYycrI7KCFyDuXJeuU/WzIpqkP7LZJm
         Sga+KeOTxLjzWr6KuqlAM05SZoVw0JbX+AWTfPpqBOSRz15U8k+ijn2u8cHZ5peqf+gq
         7sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759936; x=1724364736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gkXAjhcm1OgvcFVQzCy9kNGNCCpTsPBQvBEWoOVSK8=;
        b=qO4gmhKVAKqsBjuK7Y9FP7v2vJWdrZ2BkNOcsmwGE5T889hVNZK7TbNLPS1vmr7hQI
         JV2qKxH2rlEkJHNmJnNVX8FJwgrRUbnGeezrfiBuaeNVVSpyOfoqFWnieguz1vpoFRFZ
         wIQItVcTO/a3OoIRl9glSnmd9jjAyh5JS5vNMXGjNiatvPVPO9nwqyr9nUP9DCyQknJd
         RJRUoKXX68BIZpFHUIkZX2J6ok7Hmmdn1oykqPwi91WYRDT6j8IIxbb+MkZ2SwORqJ+a
         YoSW9KBx6BPFgn4T+JhWdoLUUdlexVylqo2+cikNRbrMb+U/yxYVAMfXNaKqKuEKpgPI
         7jbg==
X-Gm-Message-State: AOJu0YwsVlumJcFX19WzEyOnPxhlJ6oBg+IvuEosHA3YjhEj9Rf7cDrO
	/GrlnvVNGrQoIU7TdDGg7tphz04kR3dLyGmBInecDRo8EM+2u0Nzny6d5ipMRVxeXASphmCVBoH
	bf8p/9KW+y9rtchTswH0SATiVTVI=
X-Google-Smtp-Source: AGHT+IFXiks4pkEi4VEzedzxUM5mo/OGQ1/bDG/QYGz2+jz7wfXcollhBCKavDceXy6+o7T9COR1SnTI1ZTlUlXr+ss=
X-Received: by 2002:a17:90a:3988:b0:2c2:deda:8561 with SMTP id
 98e67ed59e1d1-2d3e0405446mr1107620a91.41.1723759936374; Thu, 15 Aug 2024
 15:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812234356.2089263-1-eddyz87@gmail.com> <20240812234356.2089263-3-eddyz87@gmail.com>
 <CAEf4BzZDvYEB-qF75vpMbbYLN9rFiTegBsxBXvMxq-UsbANRaQ@mail.gmail.com> <444747beeb37eed1b173bb2fcb9077eaf543e50f.camel@gmail.com>
In-Reply-To: <444747beeb37eed1b173bb2fcb9077eaf543e50f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:12:04 -0700
Message-ID: <CAEf4BzZp-sqfL-r1GfsODO_Hm7QEO+gu-dNMnFN+_+=66RZCeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: mark bpf_cast_to_kern_ctx and
 bpf_rdonly_cast as KF_NOCSR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 14:25 -0700, Andrii Nakryiko wrote:
> > On Mon, Aug 12, 2024 at 4:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
> > > by a single instruction "r0 =3D r1". This clearly follows nocsr contr=
act.
> > > Mark these two functions as KF_NOCSR, in order to use them in
> > > selftests checking KF_NOCSR behaviour for kfuncs.
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c  | 4 ++--
> > >  kernel/bpf/verifier.c | 3 ++-
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > Isn't it now "bpf fastcall" and not "nocsr"? Shouldn't the flag and
> > verifier code reflect this updated terminology?
>
> Here is a pull request for LLVM that lands the feature under
> the new bpf_fastcall name: https://github.com/llvm/llvm-project/pull/1012=
28
> I hope that it would be approved today or tomorrow (more like tomorrow).
>
> Kernel side uses NOCSR in all places.
> I can add a first patch to the series, renaming all NOCSR to bpf_fastcall=
,
> now that it looks like llvm upstream won't object the name.

Yep, I'd do that. Let's keep terminology consistent throughout.

I assume you'll also eventually follow up with bpf_helpers_defs.h
(there is a script that generates it) change to add that bpf_fastcall
attribute for select helpers, right?

>
> [...]
>

