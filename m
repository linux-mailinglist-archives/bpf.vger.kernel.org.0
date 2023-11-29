Return-Path: <bpf+bounces-16156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F117FDCF0
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951581C20CBD
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207243AC1E;
	Wed, 29 Nov 2023 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMi2dwrQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF395
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a178d491014so93798866b.3
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275027; x=1701879827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu4NmtJJ059g7oSbkEIdXtwSEVLRvSjdpZ5BHx4PLM8=;
        b=QMi2dwrQx3m2DzYrwvptVqAQEhv84RqGBNYeBM3nWl0u+Ty+KYxaQdpI/JgAAl2FF/
         9NJdHD9XT3ZE/gB6oB1CYnXLcFoLNHy7YkShPmFbKF8zdnCFibJYOhd3V63px6v7FfYr
         rfoRVbHHq01isJwC0Q3kOUvkwEwAKnSgU5MT/O1YQreyYVWHlRu/yx1zhyWcPLkCpmSG
         suPTi8r6ZlGaiX8Cp84h9gunfS8vNsMycgilQU3dKkryDaWGppHmsEb03QaKmfs9pA3w
         3emQ/jExVSQ4d6RZ20oMt8UXLq2KP3GYAFk1ePBi2S8DK4W+luAKISBe2KWyDaxwC2QX
         1ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275027; x=1701879827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uu4NmtJJ059g7oSbkEIdXtwSEVLRvSjdpZ5BHx4PLM8=;
        b=pGA2aQVU3A6tFtx9ihnjr6/PgeVL8OMo/Z2Vr1O9C+e5mB5MV5A+XAzxiYiloe41ft
         cFwfVmhjVbucjddQLAOL01utcoj7fworDFLSZOqDns3tkIg8uHwjCysjSKVO4iq73q3V
         cf7Rka6zNtazg7kNx9y7HQFec0eKeLhL6A7WszQii5BFef8CxH8wZBMyBHPFoCc0V7HQ
         bSI6fxwPYkXLD7IgfWtzqMpQ/T3p4t3k17BeboUDsujmSRCs+SBWLGGq0FaEr6I/WccZ
         q3axQhBkshDnPkNlHBf93cqtLy6GpHsGxc452GuK40LPhWjpByOqSYJHclsuDzDZNgrc
         ddbQ==
X-Gm-Message-State: AOJu0YzZdzJwKQIDMMN4FM5+07usP5VPIjAZyyEb4JGc8qR9I9xsN22+
	ljTCX/mwkA+05LZ6qYfqYvXzJVSublI12wT30A4=
X-Google-Smtp-Source: AGHT+IGi0DD36p4v8pMEOLMkrnE3DDU1GH+R++3UN7dcsPUTBqlirwoWUsUW19YPns+LPeUj+Ea7G/G76Lx/E/w/xdk=
X-Received: by 2002:a17:907:a193:b0:a17:da84:a24d with SMTP id
 om19-20020a170907a19300b00a17da84a24dmr720570ejc.22.1701275027406; Wed, 29
 Nov 2023 08:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003620.1049610-1-andrii@kernel.org> <ip4ess62ozhdajzq4idk6w3xy76cgfgkfgq3grwpmq6u4vpead@mfzyvaiofu3d>
In-Reply-To: <ip4ess62ozhdajzq4idk6w3xy76cgfgkfgq3grwpmq6u4vpead@mfzyvaiofu3d>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 08:23:34 -0800
Message-ID: <CAEf4BzZeBO3bo3aqovF5q+3YkOD3UQ+ahyLaaF7dpow2ZuUvPg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/10] BPF verifier retval logic fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:28=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Tue, Nov 28, 2023 at 04:36:10PM -0800, Andrii Nakryiko wrote:
> > This patch set fixes BPF verifier logic around validating and enforcing=
 return
> > values for BPF programs that have specific range of expected return val=
ues.
> > Both sync and async callbacks have similar logic and are fixes as well.
> > A few tests are added that would fail without the fixes in this patch s=
et.
> >
> > Also, while at it, we update retval checking logic to use umin/umax ran=
ge
>
> Looks like this should be change to smin/smax as well
>

yep, thanks, I fixed up few more places where I missed umin/umax ->
smin/smax updates


> > instead of tnum, avoiding future potential issues if expected range can=
not be
> > represented precisely by tnum (e.g., [0, 2] is not representable by tnu=
m and
> > is treated as [0, 3]).
> >
> > There is a little bit of refactoring to unify async callback and progra=
m exit
> > logic to avoid duplication of checks as much as possible.
> >
> > v1->v2:
> >   - drop tnum from retval checks (Eduard);
> >   - use smin/smax instead of umin/umax (Alexei).
>
> ...

