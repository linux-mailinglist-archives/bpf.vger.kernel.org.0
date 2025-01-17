Return-Path: <bpf+bounces-49219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B6A15620
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2D17A18E2
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833431A256E;
	Fri, 17 Jan 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rni3BlOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E328188A18
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136792; cv=none; b=jkU0naPQyjIxSqXdPLFmGgcZl7MuPehmkqvUPkyLftdzYyL3tFovcwav5mWTQtKBFGTrrdcI2QB0vnNfBgvyghmT4ahW8J9lTJlg5N45gToChsZUJU0WEJyjE4ZTchMq9RDXBiMFqRu3yo3tWvNCHOrIyvfxwa5jkDLQURXCLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136792; c=relaxed/simple;
	bh=Stx5uqeiPrps70h4syX7K1wAlEFftVyiE8lxhbMIyCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZDu6wDHX82kG1QBhTsgy84I6FWqAWPymekaTbqzkGhnPrVmvp1YwaN2k064q8d/gVErwtQU6/1JcqKlJBfUr63pfR8eBKBkPZcf3Mf/k/TvkPGs2YT38rzk2j5K15tCCTdh4btMPlSKUA/YuHE57VYaFeFmOC6jLZsRgnQGfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rni3BlOn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so3382646a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136790; x=1737741590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aTpWVamGqzqZnoPULiJbWaE/8GUEIgUU7KwyUisGDA=;
        b=Rni3BlOngBzkcrX/Zu2zxNzSoR+zaojz7/LCY/PDaKgI40Vc1XBoJbbB/uwpw+C6KK
         DvcsOJ9NrPAIEQ2EEzrVUkcMyyYLZH8u5dJAfaIKoep3FGIe1ppdwhgF+lYaiIb1M3ly
         AZRt5umblHAPWkv1nfVzXKamUip1YaHBG9iDwmZPOL7OChlTY64q9/8G7v7Zao1pK/WE
         kVxOiKq8qA6SdXOOxW7kKqPdKWoiCU1woHOlHXIz1vHIYXOVQ+F5re1LmSpj0VBfmfKJ
         jEPtOuWmstAmBz/P/968smjF2iXTKPQiJn/A4TuENwvam88YEXstQ/MdORiH9fKCSrUK
         /YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136790; x=1737741590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aTpWVamGqzqZnoPULiJbWaE/8GUEIgUU7KwyUisGDA=;
        b=hcL2h6hnyZNIlw1qMXCKkiu3gn9uzw0/EWbcYEfimSq+2x3iPVM/+hx1SsiqVhvEyr
         kQzP7BKNkhHOFCjKG50u54KXPir8F0m5atcL5h5bK1mTLHtA8iVKCucmVYz+9YLhDYjk
         3rdbYSZs4yNwN/oAzPx1R3nTdCD0fYOAAmWOHb6yfULSlOQrc2hM0DwMMGVj03TONf8A
         VC6AYaV3j2a/zlHPohzCQ/PZ4xjbDiCOPuUR3RuI47oX46YHWbQPdXWT6hcBVZPMHg34
         fYe3rV0rgtojJy4aA0uOtiC6rkasoqIJM6duI3/KV3PE2lzTkvr067G96gdib5IhHGu1
         dbfA==
X-Gm-Message-State: AOJu0YyPWOcrZ2oMPzT0I7KFg7kRVS1ji1NXoe+vX//e6xUF55Jvzuc1
	22K6gl6Cwsg/pHMa0SnD/gOOKWBTy2i8VCFgSc3HLbqXhavBqNNAdx1MgTsD/ouMNEUwzQ12zG+
	x3Fqf5U50ztbehzW4uWuixZ+Xyto=
X-Gm-Gg: ASbGncv/MK97R0PAuFn/ZXw+Cwi8mpx4iG3CsaRCQdowVPhhhcrI3aZ+C5tGSWLcwqm
	Vd3WAGissJEM9eeutllSvxEonAXHabJw8QBhv
X-Google-Smtp-Source: AGHT+IHMeyisO4RKBn99Azy1qFuYVHLQ0P8drn1CkxqELOqcva9mjEJksVRabvOGuPHitEJRQ6Hk8zXSE67nrWeYY1s=
X-Received: by 2002:a17:90a:c883:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f782d35addmr4924138a91.28.1737136789917; Fri, 17 Jan 2025
 09:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115100241.4171581-1-pulehui@huaweicloud.com>
 <20250115100241.4171581-4-pulehui@huaweicloud.com> <CAEf4BzYvbeP16EoKFgfgEQwRw_zfiYVu8rRx8VLTxk=2HuxoNw@mail.gmail.com>
 <15f9c4ac-1d02-4db9-9fd7-634b14cde184@huaweicloud.com>
In-Reply-To: <15f9c4ac-1d02-4db9-9fd7-634b14cde184@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 09:59:37 -0800
X-Gm-Features: AbW1kvaYbCADxvZH0Lux_zw3--wmcnFcbh1zlbIGb9M3CF2uIPjGtOpvzyFAIjc
Message-ID: <CAEf4BzYzn7CWDBFbMZNf+Kf15sF9uP+R_r9J+F6bqvuZASkJcQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add distilled BTF test about
 marking BTF_IS_EMBEDDED
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:15=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
>
>
>
> On 2025/1/17 7:34, Andrii Nakryiko wrote:
> > On Wed, Jan 15, 2025 at 2:00=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.c=
om> wrote:
> >>
> >> From: Pu Lehui <pulehui@huawei.com>
> >>
> >> When redirecting the split BTF to the vmlinux base BTF, we need to mar=
k
> >> the distilled base struct/union members of split BTF structs/unions in
> >> id_map with BTF_IS_EMBEDDED. This indicates that these types must matc=
h
> >> both name and size later. So if a needed composite type, which is the
> >> member of composite type in the split BTF, has a different size in the
> >> base BTF we wish to relocate with, btf__relocate() should error out.
> >>
> >> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >> ---
> >> v2: Add test about marking BTF_IS_EMBEDDED.
> >>
> >>   .../selftests/bpf/prog_tests/btf_distill.c    | 72 +++++++++++++++++=
++
> >>   1 file changed, 72 insertions(+)
> >>
> >
> > Nice test, thanks! Applied the series to bpf-next.
>
> Curious, resilient split BTF is currently supported, shall we deprecate
> MODULE_ALLOW_BTF_MISMATCH?

I'd first give it a bit more time for distilled BTFs to be used widely
in practice to work out all the kinks.

>
> >
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/to=
ols/testing/selftests/bpf/prog_tests/btf_distill.c
> >> index b72b966df77b..fb67ae195a73 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> >> @@ -601,6 +601,76 @@ static void test_distilled_endianness(void)
> >>          btf__free(base);
> >>   }
> >>
> >
> > [...]
>

