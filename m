Return-Path: <bpf+bounces-52454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7CA4300A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310C81899EFD
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD59205502;
	Mon, 24 Feb 2025 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzewT5pn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01D1FFC7F
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435896; cv=none; b=dXsj2J+EnUn3yyui1V8bqs3t6sfVlBvA23TezqKRaFfwCIVi8ABKLh+cxrBTexeU9Ma/gABPR4w1JHUuXVjLwJa5iIOsswpT730xV8y2LMZshLh42K22o4iP8Lh3vlnzl6R51HCZW3tm9jZmVxNwvN0Z14IZSwTni4CKp1tNCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435896; c=relaxed/simple;
	bh=2hOIMx0YHyPBMMszN05lP00pXRkB5dnS8qkzV3CloeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ7en8F0ynY2ocHGsVSSAQ770hDtXUm3pMoBuLZ6FPVR7ZTiimY5NanWgbVkHHlslayzD+EknBQlTkxKJP6UaFGCfq7YEGbjnkqn2H86rsA8JkKMCuyrUZ6525Cv3lMGffkbRqjplJBWKJ1gNZGsI4p9VX8rO8EjOQtyg4lQXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzewT5pn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so75810785ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740435893; x=1741040693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOjfXKHDxcuwJhHm4kiw0BtSS6O6QVSRcZtlOfD9NrM=;
        b=KzewT5pnE/WBB8k4f8vkGUvOUVtiJEFOEU3khAUIWDXHhkyBG01vt+pNQMF14OfIY7
         TPxlCJNZrREXW0AUgvwizR7/sE6BfYEjLlOaLVYVb++UG1Y03MriGuVqjLA+t9pW3oVY
         pbwNwKKQZWJMgdwQGhXbrOeTnlkR1ci/I+RhZtuiPCohk3dfsNeLouMGL6AHiBZWIoPU
         +yyA5a6hxO45IHLXAcjBfr5Jw/Fu9ll8kAYMS1FD2kvGvdfzXQBkpA73kZ7o/a5MRCMN
         KcctsFXOdMNiwrzIbPgdKt8LThRgEHpPKI+GmzwRjyJmmYYZ42y/lvh6OYhpzq7+OPjj
         5cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435893; x=1741040693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOjfXKHDxcuwJhHm4kiw0BtSS6O6QVSRcZtlOfD9NrM=;
        b=RywlcE3FjRS4GVRjQDyT2aP+lNy3j6u9sm8XwQnJlYX+ima0Lo/DL1D647iH8lYzn5
         qc/ORrMJ2um1KsJoiw1yYIyuVhOgxmiVUIHKfG7fMz//fuZPCGn+HVlVBdFQ1ogd8RWY
         kWd9xAhRy1RZy+wBLpPWgdSwQiPIQ0TdBKm6mausB3e7LTHoq8saVka5MX9ZN1ZoAOa6
         aYMmNo23bYDKAN6gj2ntYEFr6WWPF4912lUhe83lEPRj29j0/TF7NWy0YkUMbwMi3rrW
         9H9wlBDtq5jF3pXhzZNXnc+lnaizk8tW82eHpnylL40gMsK+Ok2dtJS60jmVTyi1I0dO
         VXyA==
X-Forwarded-Encrypted: i=1; AJvYcCW6iqI4h0kSrUjrA4JsKbmwwHSDuf5yMkp0IMk7Rlu2XTEgH1tDkxv3AfU50i8D1nSsffs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXFgrq9/ILnQ2zEWn5iAmiTWU1iVrzMZlvdsP0COfSjxL63/M
	Zgem/GPfPTvUPpdGaiYcjKPLCoAhuStkmHOXhqNKX08ZwchYF1YRSy0E1gQ7hlZhiZ4TePFQxAn
	rcB30kw7VLpaqKODoCgZNoOaVL74=
X-Gm-Gg: ASbGncs8a5EXEAPdywfD4Tlqy2zwfvjoZOeghHMW7/Z8NVMX5LS1tHvcBqroF41VhgK
	5JQygIQOELyPY7e8Pv3Qgdsi4qlgmusPl6jUIN1Z4fDZUs+6PfyfpEf9OTQ5s5r91KngGfP//Pi
	k8X17Dx3qvaauvomNT6HIb2bE=
X-Google-Smtp-Source: AGHT+IHPPngTvL/qI7e3PIt6e+2qWCbHNW9Ux73ZDD6J41EAQfAZ5fQGVKUs3dGojknAD17I0RivosRWmeOW9NOyWTU=
X-Received: by 2002:a17:90b:3806:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2fce78b972emr28238268a91.18.1740435891245; Mon, 24 Feb 2025
 14:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219063113.706600-1-pulehui@huaweicloud.com>
 <CAEf4BzYJLKZpuEsbU-A1s7wtpG0YQKUHG3QDaQoDH8B+VY0oSQ@mail.gmail.com> <abf6baeb-ac7a-44da-8c00-a0bb409760df@huawei.com>
In-Reply-To: <abf6baeb-ac7a-44da-8c00-a0bb409760df@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 14:24:39 -0800
X-Gm-Features: AQ5f1JqKWt6Amu6xD-6mTcnmCeMYKMBXwYQq1bFIjhNpn5CmeMTwXIA32oHojgg
Message-ID: <CAEf4BzaZRq+x3C=s3cFw2NH=E=e3xdv844Uk_UWVxxFZAOCzDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild, bpf: Correct pahole version that
 supports distilled base btf feature
To: Pu Lehui <pulehui@huawei.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, Alan Maguire <alan.maguire@oracle.com>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:16=E2=80=AFAM Pu Lehui <pulehui@huawei.com> wrote=
:
>
>
>
> On 2025/2/21 8:30, Andrii Nakryiko wrote:
> > On Tue, Feb 18, 2025 at 10:29=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.=
com> wrote:
> >>
> >> From: Pu Lehui <pulehui@huawei.com>
> >>
> >> pahole commit [0] of supporting distilled base btf feature released on
> >> pahole v1.28 rather than v1.26. So let's correct this.
> >>
> >> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?i=
d=3Dc7b1f6a29ba1 [0]
> >> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >> ---
> >>   scripts/Makefile.btf | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> >> index c3cbeb13de50..fbaaec2187e5 100644
> >> --- a/scripts/Makefile.btf
> >> +++ b/scripts/Makefile.btf
> >> @@ -24,7 +24,7 @@ else
> >>   pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j$(JOBS) --bt=
f_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func=
,consistent_func,decl_tag_kfuncs
> >>
> >>   ifneq ($(KBUILD_EXTMOD),)
> >> -module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_fe=
atures=3Ddistilled_base
> >> +module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fe=
atures=3Ddistilled_base
> >>   endif
> >
> > Alan,
> >
> > Is this correct? Can you please check and ack? Thanks!
>
> Maybe Alan doesn't have time to reply at the moment. We can use the
> following command to check that in pahole.git:
>
> $ git name-rev c7b1f6a29ba1
> c7b1f6a29ba1 tags/v1.28~73


yep, I was a bit lazy to search for specific commit ;)

I like this command, though:

$ git tag --contains c7b1f6a29ba1
v1.28
v1.29

regardless, applied to bpf-next, thanks

>
> >
> >>
> >>   endif
> >> --
> >> 2.34.1
> >>

