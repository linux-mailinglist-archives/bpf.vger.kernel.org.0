Return-Path: <bpf+bounces-72630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38430C16B4E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7C284EA122
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BA313E1C;
	Tue, 28 Oct 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2z1wKXh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490826ED2E
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681698; cv=none; b=tJkDD+HoXLTNMc3dS2WzXepjnCHlTbK6uxwC1wDiZpQ/RW1vURE8ZM3hxHbqqCw18oNBtSdtB7ViVZCGqf7Op1aTu5k29W0Phv6sfhfLLDKeW1jz3okctka8E8T1sSJYTzzLAaUrFZDzEgmK2zu8xmwkvx4a8cWaQ2KHKtx7v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681698; c=relaxed/simple;
	bh=f/7SJ8tHvCFB11CHv16SXLAJOLfTK8SzSvbBD4Oboj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIijijkVxZuC98IhzXE1504PfjTFj92FPJRd63g0TkZshrOzia0debmkJ4c6A4w14eqCZ2Zx+g3SYP+xrqY2IxmUVe86V4FDgVAKQ+5/toOKVP3PI1pLabGAov4kKWC49d7g7N54+iqhNHZvqkpDreblsfXO51OQnNEZ50rSYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2z1wKXh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so6324877a91.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681696; x=1762286496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rLP7I2q7G9yCNKTv3YO1SCZ6EHTfU+BhiKw7IBsDS4=;
        b=Q2z1wKXhec+oAKFKLQrjMITqX6CuKLBmcvhhLLGCAaOaN+7lU20IDTwGp4OrjS35Y/
         u7AjhyszDpMlfGalDVbTthoVtjpt8mZ7xYkWRm9oivHZ1UvKRjOTW0s+so6Z4YVdFYv7
         YmqiyNJYFqYK2JZEZgXgud4VwXPmDbTwnN5NTVFe6KBnKLRB21eFtzcbrbY43MRrgEh7
         7h3cF4TgrXipqdwya4ti5/y9Xhs5fe8bnE74WQBrlsY2W1oBAzUD29e44jyBVx12odFB
         PQRAoTslSxs+k2ENGdFnpG/chFGf7JWS1yP3ZwMBwtp9g8m2y25m6DarIBy6p1+dhlU3
         CwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681696; x=1762286496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rLP7I2q7G9yCNKTv3YO1SCZ6EHTfU+BhiKw7IBsDS4=;
        b=Fcx61io1uHhZtZI400fGrQ6mawOeJhrztT4WbQU8uU8cfC5U4YpF+bUn4AewI5T5p0
         BLF7B9vOcwYe1p669f85nkWHITOKt6BwqsvfDnre8oIjp5DRN6dZdHW6xBaRJOScegcq
         GjdjBO3JPwAbruuKjjkM395E1M2quU+e27ssJ+UQIDkqZuszKgl/L7qo82SDzThbKWgi
         rNFEuMQlxXC7JPqgofI5aeMubvfntyRyiT5zba3whLIOUSgpklV640bXFfeawl79O1an
         vcs7nvblMIS2TCvoZm5V2q/2Kxgt7eiFwlGYXbAb1LRL7ggvTYSrMLH96giZXXWXbJDH
         pPHA==
X-Forwarded-Encrypted: i=1; AJvYcCUfWvvXbVexQAQShFk4mUxm26JvtMsUoIAGMW2ZTKx+xjFv7yofuwWdbq6i7rRZXKstrH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybeBqqZrxIMNu2JugCrmQ3n6W6p9ltQGykIOrchofP/gDse1Q
	tuLSW/ZkJTajJXmXP7y32yxiUlWWv5FL/wJEbhazheRZ3AWYXCUtijIZxAQAA3mLJ6PZA70PuOS
	GTOzRKQvi/V3VryTHSdJwD22s/WE2HuM=
X-Gm-Gg: ASbGncuepCLsqGd6AIUYRugyAvqr2tx5v92DTSDyGTTdV3SlfVeI8pC9Uy5BDBJY2BC
	zLkU6CbmzvKvjNwVnGuk7yqXHHpoBjOvZyrMTH3mSyeKjDDQKCtWk1PYQp5f6N+WH9emiI6JtvQ
	tX2MeltFPpPrrXw+ngQO71hPQsULKollDbU7FqA7VuI4hadGs7j+Lizlxkbbf7RwVb475NHERK3
	tG7NU9gPhcZjLLBklruL8TSAGfNGidcisauSw+kTrYT+FadiXtRAF3wX1pKOHbgb0zZ0tJgZo5n
X-Google-Smtp-Source: AGHT+IFjnY03SgkKFJXGakWMemjBel3yThBRLllppMxp406QiPQp/RZ453CrdHZOotEn8zfKKSaoTn/bZBntoahXkSs=
X-Received: by 2002:a17:90b:4e8e:b0:330:6d5e:f17e with SMTP id
 98e67ed59e1d1-3403a299f98mr256372a91.24.1761681696534; Tue, 28 Oct 2025
 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028155709.1265445-3-alan.maguire@oracle.com> <478a9790d452e3ab4c846f673e7e6ed1b4cb347adfe9628d0fc71256d7f2edcc@mail.kernel.org>
In-Reply-To: <478a9790d452e3ab4c846f673e7e6ed1b4cb347adfe9628d0fc71256d7f2edcc@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 13:01:21 -0700
X-Gm-Features: AWmQ_bmK9U7LLWhm47myGU289ut31EOKaFI-aU12MFqRl0B5zWt2fi3rtvmzXio
Message-ID: <CAEf4BzYYMyjFQMn+UKFBEK2bgFTYP=qEGg2aF_fGZif+GeMJfg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test parsing of
 (multi-)split BTF
To: bot+bpf-ci@kernel.org
Cc: alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, acme@kernel.org, 
	ttreyer@meta.com, yonghong.song@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 8509f4500fb2dfaec7a383a802dffaf84995c434
> Author: Alan Maguire <alan.maguire@oracle.com>
>
> selftests/bpf: Test parsing of (multi-)split BTF
>
> This commit adds test coverage for parsing split BTF data that has been
> written to files. It writes raw BTF data to temporary files, parses them
> back, and compares the parsed results to the original in-memory BTF.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools=
/testing/selftests/bpf/prog_tests/btf_split.c
> > index 3696fb9a0..ee1481c5f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
>
> [ ... ]
>
> > @@ -123,6 +155,35 @@ static void __test_btf_split(bool multi)
> >  "    int uf2;\n"
> >  "};\n\n", "c_dump");
> >
> > +     /* write base, split BTFs to files and ensure parsing succeeds */
> > +     if (btf_raw_write(btf1, base_btf_file) !=3D 0)
> > +             goto cleanup;
> > +     if (btf_raw_write(btf2, split_btf_file) !=3D 0)
> > +             goto cleanup;
> > +     btf4 =3D btf__parse(base_btf_file, NULL);
> > +     if (!ASSERT_OK_PTR(btf4, "parse_base"))
> > +             goto cleanup;
> > +     btf5 =3D btf__parse_split(split_btf_file, btf4);
> > +     if (!ASSERT_OK_PTR(btf5, "parse_split"))
> > +             goto cleanup;
> > +     if (multi) {
> > +             if (btf_raw_write(btf3, multisplit_btf_file) !=3D 0)
> > +                     goto cleanup;
> > +             btf6 =3D btf__parse_split(multisplit_btf_file, btf5);
> > +             if (!ASSERT_OK_PTR(btf5, "parse_multisplit"))
>                                  ^^^^^
>
> Should this check btf6 instead of btf5? The line above assigns to btf6,
> but this assertion checks btf5 which was already validated earlier.
> Following the pattern from the btf4 and btf5 checks above, it looks like
> this should be checking the newly assigned btf6 pointer.
>

AI has a good point, I fixed it up while applying.


Alan, while fixing this up, I noticed that __test_btf_split clean up
path can dereference a bunch of uninitialized btfs (btf4 and btf5).
Also, we can goto cleanup before we create
{base,split,multisplit}_btf_file, so it would be nice if you could
send a follow up fixing all that. Thanks!

> > +                     goto cleanup;
> > +     } else {
> > +             btf6 =3D btf5;
> > +     }
>
> [ ... ]
>
>
> ```
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> In-Reply-To-Subject: `selftests/bpf: Test parsing of (multi-)split BTF`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/188813=
52510

