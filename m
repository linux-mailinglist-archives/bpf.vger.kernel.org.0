Return-Path: <bpf+bounces-29330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B838C19A7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6594285392
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFF312D765;
	Thu,  9 May 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j08TbA+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968E12D215
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295548; cv=none; b=TI+lwmel7GPwtwN5p1Fl8+RZUhhQ6l9/0KCFa+48rE9+HNfy5FnHctVSK/0bjkA53jQU0qkx7q3inKVBmRECJPGIMLjSAWj8NNamalY+MNB2U9T7a4nAYFO7kkDTtgPcXeQXAYHO6gZMsWuM/EmqwU8k/LXSWaX3zAvPHZVE5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295548; c=relaxed/simple;
	bh=6jtL8Tq51/6D1tJuPGm0Kl2FshQGs9RlrJmrJmmfe3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSbr13v8X/M+R8ijPOyzN2FOxPntZVsCrSnubjMBs4lolm1Q5bw5rfYHp7FV3KbkU3fYsNxtYPOs2TfWWvuXiQPMbGCtjpHhGDcKbohtiv9iUTw8NiG0YkJeALqVHLvr30nc0UzOXF7JecprlwH+HdoDCaPFIzwCrGQbr9Tx2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j08TbA+4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso7095a12.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715295545; x=1715900345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1vau91hxBMnWZHVkH054+8jTk5Pa/DNJnVVz4HmL40=;
        b=j08TbA+4eLGw+ulUEWaupL0wgEo+IcJIKC1IAT1G1uR8jtJt0JcQbwjZbbrzP4KEQV
         7n8/5WNKUeRGYLv3KXIp9UcqwVkFMFG4PEy+Ce+2sze3V1TFPLoj9RvbNI3sBXqDQEGw
         9CzqWC0zpYfLZ2ty04pD4e+BwaVgrsCi1Ratin88wWMIKZkfMklkCGRj8BWjsDKfHCni
         G7JjZVoHCGKe2Nb4j6V9c06UW0gtVq1fILG7PVYqwzkPOixySzJgNhM/FrPm+r9uZzdF
         GKnIlFcgWg0c9Pc1Mcod5SGWbbDXEFWjlciZiw0e0Rzgb2kAEqds7a95UdWbDh86Jr2l
         PhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295545; x=1715900345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1vau91hxBMnWZHVkH054+8jTk5Pa/DNJnVVz4HmL40=;
        b=NC1+AL0MimTTRh+VDrnRL6qxpFErf9DOechZOzj/sE01VFHhRM68iJAnv6SmV0+OMm
         2j/63QDbR45h68T+GwthUhV0tBs1TaI4mf/VXXk3sdeKPL7d51ES79bhS/PPw3vr43ES
         Tx1vLExcpCYFcjwUfLYuzHoHyKCdyZdiPgdkJA8UQNZDAJfdhO230TtTIsocOUvPs9G5
         PyNW0Bzxtp5r0LBWrQvQGc3iiyaYV2iGoWY1jAg9F538bVwX3Iw+pBnCPVaLsFx231rW
         1e4p2G95qwFueLnkapSVvyTbLXr+HjSdN214uUbpFRQdraHPDpnu2PNAfBqrNagHMDCE
         bl/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYd42oxkB9gaf224eT1Uo4nV0g81atR7rjhOc7Tr6FmpgUe8ob3iTwxR//MSewCp1CZ3mSWmWgE9JKtqdRN9+3MLYU
X-Gm-Message-State: AOJu0YzzPP/KnPHHNlxOuPqpWf/COHu9biwF0HQE8zStP7IhcWMew+aC
	0/VXL089ocNnMw6c7BsOl6sQDASh/czZ8ilZ1WLKVO3wdYINkZ0hCyZzEqYgr3zihxUZkEIhljj
	+396ZUw/xphGaiSvSD48vzdNSWYcMIkiiJfKF
X-Google-Smtp-Source: AGHT+IHuVFTFisfvrt55ub+8UO4+Id1LOVWeasU97gGretbq/QA6WW4CiikvBa7AfpTXmMMad1SbRPJ/2IdczDaT84s=
X-Received: by 2002:a50:8d84:0:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-5735203906fmr30811a12.7.1715295542981; Thu, 09 May 2024
 15:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com> <20240509200022.253089-4-edliaw@google.com>
 <0e196143-c0bf-4d70-9735-7e6d9a69ea8f@nvidia.com>
In-Reply-To: <0e196143-c0bf-4d70-9735-7e6d9a69ea8f@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 15:58:35 -0700
Message-ID: <CAG4es9Xv0Pwst+b0mre2g+QkBGoQS0cWj4xizRt+cHFJ0BTDaQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when
 including lib.mk
To: John Hubbard <jhubbard@nvidia.com>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:25=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/9/24 12:57 PM, Edward Liaw wrote:
> > lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
> > unnecessary to add #define _GNU_SOURCE in the source code.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/Makefile | 4 ++--
> >   tools/testing/selftests/lib.mk   | 5 ++++-
> >   2 files changed, 6 insertions(+), 3 deletions(-)
> >
>
> Hi Edward,
>
> This looks good, with one small refactoring opportunity remaining, though=
:
>
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests=
/Makefile
> > index f0431e6cb67e..9039f3709aff 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
> >     # $(realpath ...) resolves symlinks
> >     abs_objtree :=3D $(realpath $(abs_objtree))
> >     BUILD :=3D $(abs_objtree)/kselftest
> > -  KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
> > +  KHDR_INCLUDES :=3D -isystem ${abs_objtree}/usr/include
> >   else
> >     BUILD :=3D $(CURDIR)
> >     abs_srctree :=3D $(shell cd $(top_srcdir) && pwd)
> > -  KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
> > +  KHDR_INCLUDES :=3D -isystem ${abs_srctree}/usr/include
>
> As mentioned in [1] (but there are a lot of patches to manage here, and
> I think it got overlooked), you could factor out the duplicated
> -D_GNU_SOURCE items into a single place:

Hi John,
Here I'm reverting the change I made to the Makefile in patch 1/68,
since -D_GNU_SOURCE is being added directly to CFLAGS now, I didn't
think it was necessary to add it to KHDR_INCLUDES anymore.  I would
have merged the two patches together, but since the first and second
patches from v2 were already merged, I thought I should leave them in
the series.

Thanks,
Edward

>
> [1]
> https://lore.kernel.org/all/ac8c217e-4109-4ca7-a7dd-fc4fc8b0a4de@nvidia.c=
om/
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >     DEFAULT_INSTALL_HDR_PATH :=3D 1
> >   endif
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index 3023e0e2f58f..e782f4c96aee 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -67,7 +67,7 @@ MAKEFLAGS +=3D --no-print-directory
> >   endif
> >
> >   ifeq ($(KHDR_INCLUDES),)
> > -KHDR_INCLUDES :=3D -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
> > +KHDR_INCLUDES :=3D -isystem $(top_srcdir)/usr/include
> >   endif
> >
> >   # In order to use newer items that haven't yet been added to the user=
's system
> > @@ -188,6 +188,9 @@ endef
> >   clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> >       $(CLEAN)
> >
> > +# Build with _GNU_SOURCE by default
> > +CFLAGS +=3D -D_GNU_SOURCE
> > +
> >   # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
> >   # make USERCFLAGS=3D-Werror USERLDFLAGS=3D-static
> >   CFLAGS +=3D $(USERCFLAGS)
>
>

