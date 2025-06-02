Return-Path: <bpf+bounces-59465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB4ACBDCA
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 01:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B28B3A34A8
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2138613C8EA;
	Mon,  2 Jun 2025 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgfSgw6S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C3EEA8
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908252; cv=none; b=ta0LgXRNHIDbN1+jd4f/+sIXW6Ges2ZOLhBkRDURD7OUK7fYcx+7jwDtDPLq1idFqjflNun3tejkRY+/npD0Dcd4G2MA+PAwSSUiM1V0UnHCZmf8OnNJKL/RXcno8A+b/h37aPQxOJK+CAjsvVxNP9IgdWPdr7wkhx9aHr6aCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908252; c=relaxed/simple;
	bh=IQsuicHoowk9ciI+zuSeYJDHO4pxnQ8VyNurEo1NpAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFpq3X17lXtvEv/CWxS3E779tAjWS04TZUSJlob4RvRnRHZlVOs+Cewh2kndOuH2bPTuzXhkQc+e8ltieId7JtoiE5ML8toHVasp97tS23FviSKINf4zG1jvtRFbke//viHewSnf8cQnne/M4glHt7OdaAQGxCp5x42OIeeEDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgfSgw6S; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3114c943367so5494438a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748908250; x=1749513050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TaYS56hAP0BXYQGCsfdiH0ewH//Xxnmp99Y84vv+oU=;
        b=mgfSgw6ShqPu3rDJUyGKWHFpZr8BqopruZt3nQo0V6Ri5gVwNukC1Th4NvsNDgF3fu
         A0MuItsW7xcRVbAip+q/a/OZXjGGpGYVWZZS7LzRqyD54Ls4mkWogm+gRkErB7o3DE/h
         Pdd74HGotDPBxyxtEC/LnwOcd1SU6bTf+Dchrh/FoqUTsAGItaY/UayZhUSo9s9fnQDi
         ITshfgS9VPUACDMLADL58lq2AwFWtD+FKytxl9p5KUrxoOGrM/9niruZT9P1FxayQ3t/
         IESKsOHhoQIRgvTGOZ60TE32EMTQb9OMvAOWLC1qwq0vjXSOcl4wyWYc1DdecQXD8OFn
         qvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908250; x=1749513050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TaYS56hAP0BXYQGCsfdiH0ewH//Xxnmp99Y84vv+oU=;
        b=FBAHwREvrtM34PMP2LRbdvtzyBHn5bvREOgCtDzs0mW56x80Y7bxYvJexIPyG+TAMD
         qHYbjBIB+V/8K9/b21viiXGnsUBwfwoIK+2fyCrsB2eo1LlL023wtCZh8YXaJ0l0y6Oj
         ljZrs817suQFIBzkvdQUwf+M2g374yiVDMHqyxBgz/XjnINX7biXDV/AYTsBP8pP5NS1
         Rnp43VQv/jAh73xmcFjMeRj0qKGL4O5dg2hhGgcnvCZuhdUxjiPNAzUz5zedNIEBDY2j
         C/KBCvWrvLkok1URuluI/0x4pz5iR0sExDdz9z2shvbcnOCnkOXByM6GT68tPp2fgmyR
         yP6A==
X-Gm-Message-State: AOJu0YzeESYOB+Wq7p7oxOuhIct86WgsjylPWFLMvnFqEBqJAqiin1x4
	/6F5yoybICZr7pKUY5qTWieHZiuPUsVdJBd0nkSPuqnaCfFO1yRUG/IUN15Sjjx9ztlPLSwJyfi
	RwmdqDm/cKM2UzqG80RXO4yWxPaPXQDo=
X-Gm-Gg: ASbGnctRExpo3kMnTZ4pRy/MsmdSUQlMVTXEErXUO6oPERaDy2VvUqXHJoHGW/NnYMC
	mPdrOrBVfWju3jeFC0bsKZYpyKvdg31nuSNMMFv/HetMM+YvLQnqb02ZsN4eA8RIH80kyIh9yBr
	JXatwxua9LKH1gpmdm/R7p3yFkFr5999LIzuJFGOZOUyoRZVDX
X-Google-Smtp-Source: AGHT+IEUMSfsXaht/6DCLZ6Ou7WB2hVPR7WEewNCtvRnjW4e3kuKpFOnmRIQ8nTpHBYDyO16tfDCHvM7y9L8Y5bJoV4=
X-Received: by 2002:a17:90a:2cc4:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-312ea463f45mr30441a91.21.1748908250467; Mon, 02 Jun 2025
 16:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-4-leon.hwang@linux.dev>
 <CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com> <2d94fcd1-9ddd-49c4-86b6-720b3636ad24@linux.dev>
In-Reply-To: <2d94fcd1-9ddd-49c4-86b6-720b3636ad24@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Jun 2025 16:50:38 -0700
X-Gm-Features: AX0GCFtdbN60MlEt27uiUVL5_C3uexLCCVBFUxNJNC7GlrlGMN_9LhwaCTVKnXA
Message-ID: <CAEf4BzYzikQSvvJTm8j2X71ewBxZjVKLLFqxaVMCgziJMWC8mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf, bpftool: Generate skeleton for
 global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:56=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 28/5/25 06:31, Andrii Nakryiko wrote:
> > Adding libbpf-rs maintainer, Daniel, for awareness, as Rust skeleton
> > will have to add support for this, once this patch set lands upstream.
> >
> >
>
> [...]
>
> >> +
> >> +       if (map_cnt) {
> >> +               bpf_object__for_each_map(map, obj) {
> >> +                       if (bpf_map__is_internal_percpu(map) &&
> >> +                           get_map_ident(map, ident, sizeof(ident)))
> >> +                               printf("\tobj->%s =3D NULL;\n", ident)=
;
> >> +               }
> >> +       }
> >
> > hm... maybe we can avoid this by making libbpf re-mmap() this
> > initialization image to be read-only during bpf_object load? Then the
> > pointer can stay in the skeleton and be available for querying of
> > "initialization values" (if anyone cares), and we won't have any extra
> > post-processing steps in code generated skeleton code?
> >
> > And Rust skeleton will be able to expose this as a non-mutable
> > reference with no extra magic behind it?
> >
> >
> We can re-mmap() it as read-only.
>
> However, in the case of the Rust skeleton, users could still use unsafe
> code to cast immutable variables to mutable ones.

you have to actively want to abuse the API to do this, so I wouldn't
be too concerned about this

>
> That said, it's better to guide users toward treating them as immutable.
>
> Thanks,
> Leon
>

