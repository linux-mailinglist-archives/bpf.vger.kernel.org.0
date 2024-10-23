Return-Path: <bpf+bounces-42919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E829ACFEE
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131DC1C21439
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB84A1CACDD;
	Wed, 23 Oct 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUF2Vj3Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2C4594D
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700262; cv=none; b=VaJ/ns9Gs2Cu14aVnzEFhXYQ5bsjU8Ue9wnG1EONOM8pIhSpmegkWmEcGQ3xXhbe74kedqqoixE+oSVXRnUPBuKCWIVAdksbVSIsWi3aU04p9w7f9Lcoxw25UKN42fd/IHiEd5D40Cz0/3E/dHIUq05vw26A3R9/2HG+Xeqvhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700262; c=relaxed/simple;
	bh=Nzj+Li/9rEWvDciPSvmvX/faOAjAWhjDn5234R+DuWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWa8vkMgU7FmFT5AY7rT62MAp1/W6ChZPrdhN4Ayes0Gh7DqcFatWzQON0U4ERFZa1b6JJPpL718/Dnv6NH6IopJX/0uTunp8V8ToXrrEn07ytuYXvx6oI+Hq45FE8KXodBtH9dgeKvnobHUS3vzqr/O/8/Cc1iroEpqUqCxf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUF2Vj3Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c6f492d2dso81430335ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729700260; x=1730305060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ebDpwUYSyHZSkOwTPWu6FpA2GYFiI1XvXAlOaeIRllM=;
        b=hUF2Vj3ZvocsQolBKtYQm5npiZZmh3fh7gOD4DJWtbnWM+TO1szBe9GcOqUUb8jwB4
         rA6Uku+giyHzCYElUyzY1c8Y9jPvSQ1/CCT6ynbft7obizOjTWcsGBUJYD3966hNQl9V
         CgtEcLCuXu0p2x1bfSN5s/yR+NqK6h4B3A83CAXSfeaCrIapkAMdVDXa5g+6ooVtf4cd
         unyU9kKbYPcMTyWyXDeNwikS12MKAwSmUMFsJvnYPXfFHczbCcI8MlitsIIPiuKhHxkm
         yM8025sUEf+er1RdiH2lO84LCMLivl5j1HTVQtEy0FqEc4Lhed0B+rZEcBBtoawGn5xz
         Kf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700260; x=1730305060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebDpwUYSyHZSkOwTPWu6FpA2GYFiI1XvXAlOaeIRllM=;
        b=FL8tNkIU2uq5++eyyzjAtTMnznpTIWb4rcBqaGejLLoS/mgpNJ6FzMIHzU02AYZr1f
         luyK7UMDuwZiU+7o97+4a+am8qRGE7NaIkmYxck27JeERJErq6tiaWVI1HMZbKfTKiIY
         6SA4OoHHD4GpxLe8usgUoV8/pRSAS3zm3lm07l5LVJuxfXxO7Q/QaKjCtp+Ij2bwAwC2
         h4K4cefNlVDKiNH2pMi809z93QiaFFAtXSGB9KSjtDIv+FDQ9Nbgbx4UCExaXKQCHcgr
         VxylQuzyuNgjXhKrUBPArJVOvQUh9o3P50v2ZXTUrD0Ho8yz7L7KAHOUGy9H73G8DpU0
         Cfpg==
X-Gm-Message-State: AOJu0YxiiWIlyIvXEiMRJ313g70QAz1Bnxkmh9ff334OokIuLgZ8N3zC
	g5BsI5C+Z2wNoQma4dwQAeGFXtlAj3cb3t472KOVmaO0/3D2Jt12
X-Google-Smtp-Source: AGHT+IFCXsBs9OgwAsBEy0rI6TJ+Wkuvdz0zJyfvo+TJOBzP+Z5MZZAuy1hiwjoyKgoT2UboqNlULw==
X-Received: by 2002:a17:902:e547:b0:20c:a692:cf1e with SMTP id d9443c01a7336-20fa9e9f92dmr45691795ad.43.1729700260071;
        Wed, 23 Oct 2024 09:17:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:30eb:d182:edbc:9581? ([2620:10d:c090:600::1:5e2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f33acsm59420555ad.254.2024.10.23.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:17:39 -0700 (PDT)
Message-ID: <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to
 128 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hou Tao
	 <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>,  Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 23 Oct 2024 09:17:36 -0700
In-Reply-To: <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
References: <20241023022752.172005-1-houtao@huaweicloud.com>
	 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 09:15 -0700, Andrii Nakryiko wrote:

[...]

> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 4513372c5bc8..1bb6c6def04d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -773,8 +773,11 @@ struct bpf_verifier_env {
> >          * since the last time the function state was printed
> >          */
> >         u32 scratched_regs;
> > -       /* Same as scratched_regs but for stack slots */
> > -       u64 scratched_stack_slots;
> > +       /* Same as scratched_regs but for stack slots. The stack size m=
ay
> > +        * temporarily exceed MAX_BPF_STACK (e.g., due to fastcall patt=
ern
> > +        * in check_stack_slot_within_bounds()), so two u64 values are =
used.
> > +        */
> > +       u64 scratched_stack_slots[2];
>=20
> We have other places where we assume that 64 bits is enough to specify
> stack slot index (linked regs, for instance). Do we need to update all
> of those now as well? If yes, maybe then it's better to make sure
> valid programs can never go beyond 512 bytes of stack even for
> bpf_fastcall?..

Specifically function frames.
This is a huge blunder from my side.

