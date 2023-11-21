Return-Path: <bpf+bounces-15554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCC7F3414
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18B9B21C69
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90255C35;
	Tue, 21 Nov 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os07Juu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A51AC
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:42:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b2ec579efso634285e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700584946; x=1701189746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QImZr3ZL/b+g3plaalz0YTRWVjQWPuATTVKCXWkMALQ=;
        b=Os07Juu66UM3fj5QeVmzowOb3SEJ8YXkYKrO42F0gppSUefABlQy4QDq/ce0b89JHb
         O3FO1ks+Bm6auVkEJLZdaY6+xpde5iu1d+ihhLFTxp1waU7yrTiKsxgsVf92S8UerDks
         lJrbQPGcXGE8V+HM4zTBXP+T9zSzh6zCr/odL1aM49NsN9lSzHA6gpm43HO+k5BxT9RP
         5/dGYDv9wla6mpiDJVjqDgw2BQVb7o2jXvbnzoSvG6LEjHX83AjY/6iNIgDIWA2/6yXQ
         b3Ix6dQVOR3Yj0CB01FgDTWe8leEBojtxNHd2wncp/TE5HwNyWqv4yvZ1uCDHm39MY23
         aMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700584946; x=1701189746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QImZr3ZL/b+g3plaalz0YTRWVjQWPuATTVKCXWkMALQ=;
        b=ncM2pWZlIvb3asi/J6LtrLZYjRVRsIu1IP3MSdqU8MgIZdHCNdcTJbjg2CbvOr5rzJ
         9yVia32jBq0pCw6YNXEBN7ylCYy0Pf0b2wD2QjVyCM/GGqipxZ3lYHTfdytt6zTEU227
         ot+Qe78ryovlJOr/5Z+uazvyPHVFVQ94kZqWBFCz/1kTgkYzA1SuhW5QBTemGVbbvSSM
         GDBzLnq4Ahyq5n8nlyUgDFBAk1cgKH/YLTpeTwpGqTo4qMkD+pIgEwRcuGXXsPlhQF+l
         rJ9gUjuVON8XV+iyNPJpcFPjqtGpkCfuKn6m5rHin2NbyYxedsAFz6HMYPm9xgnpE0v8
         EnBw==
X-Gm-Message-State: AOJu0Yy352Tt6gtD7yQ8cMenVGSXcij13Qfo9XpOIPBU3ArQmx2tW2WP
	+wJD9et9G2u8kVAgRos2z5EqHg0Jy2hWS8yAEEM=
X-Google-Smtp-Source: AGHT+IHzxdDN8KRPfY4kUjLkRi6eueRQshJZ8YPPmYJPEEWw4E5asoePWHRIiV5YlADdIwyyxjolqRJnA7pEvH5Sn6k=
X-Received: by 2002:adf:e54f:0:b0:32f:88d1:218c with SMTP id
 z15-20020adfe54f000000b0032f88d1218cmr7463656wrm.35.1700584945877; Tue, 21
 Nov 2023 08:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116194236.1345035-1-chantr4@gmail.com> <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com> <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
In-Reply-To: <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Nov 2023 08:42:12 -0800
Message-ID: <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
To: Quentin Monnet <quentin@isovalent.com>
Cc: Manu Bretelle <chantr4@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:26=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> >
> > Does it have to leave in the kernel tree?
> > We have bpftool on github, maybe it can be there?
> > Do you want to run bpftool tester as part of BPF CI and that's why
> > you want it to be in the kernel tree?
>
> It doesn't _have_ to be in the kernel tree, although it's a nice place
> where to have it. We have bpftool on GitHub, but the CI that runs there
> is triggered only when syncing the mirror to check that mirroring is not
> broken, so after new patches are applied to bpf-next. If we want this on
> GitHub, we would rather target the BPF CI infra.
>
> A nice point of having it in the repo would be the ability to add tests
> at the same time as we add features in bpftool, of course.

Sounds nice in theory, but in practice that would mean that
every bpftool developer adding a new feature would need to learn rust
to add a corresponding test?
I suspect devs might object to such a requirement.
If tester and bpftool are not sync then they can be in separate repos.

