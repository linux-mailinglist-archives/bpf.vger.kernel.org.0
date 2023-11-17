Return-Path: <bpf+bounces-15277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B7B7EFB04
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF9728132B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071B3C495;
	Fri, 17 Nov 2023 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy95FpWG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA3BC
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:47:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4094301d505so19069605e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700257643; x=1700862443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/108I88UknM3sj2NWYYwb3+2cSHUJ9ozEyTF8G/4ds=;
        b=Uy95FpWG2Pkcl3PuApRtgpndWDL1sj12XlGGxYNZ4MTbgUq+/lvRNUOmQXNhs325Q3
         OO1zNj+loAAQknSSvHE736yXDuMAECWnzB62o9jvBlIkpsiwlfijYMnnTAy4jsxFIBc4
         +IpU2Qcuec84s++bS81ny5OXTl45NMZFxMw32W9YzUjpwGQlajZ9/sOJO7ekvjX3X7q3
         Ix/TjIbLfRSe/O4FOU+gd2hXoI3rcWdL6xyw5uop8rBkqs50qppNgcJmcSbmY7AqBAPD
         zixbTiTeeHZV/VsfhnKvcRlham5rVZMOFq3qXVyjNHRe/rqyEAM4rVStFJlvppr3Q7B5
         obpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257643; x=1700862443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/108I88UknM3sj2NWYYwb3+2cSHUJ9ozEyTF8G/4ds=;
        b=PL0unF/Rd8TwWNA9ex130kojN/MSNtk/UIFS6nSS3fBK866Jz6QCB7eTIBA2f4Ss5z
         cYXBz5w3KYuCsg05IHSKsEZ2/y3HFwvBX2y9p/fXRSTHMEOefn001BtmlSydusAXxMXN
         ZofrTYLQFzcNnW805HiUHCwzwoMlLtWgGGImUdHm4P63biVD5zOseZfAMdvPzKu3ZNYR
         vchcvpCWWn0rAXzAazuaVqyX1MD8ZC6xm1A3KWQXmNAWTgHLI4BIh/Tj3KJRZlXECQqF
         is2hnUqWQVypG3561/1TSyu5UDr6/boOTot1784XYz8Kgk7nhewjR9uUHodxYAtKI0qU
         QYSQ==
X-Gm-Message-State: AOJu0Yxaerkydth9NHy53b+MCTS44hA1A8dHD5Fmc52jI5vILEco/Qfu
	ryvLj9TC3xF1xJGn5hFOpeJ38glT4GjqFWcyGBQ=
X-Google-Smtp-Source: AGHT+IHXlkdR8FQFrtt17WccYOZI8d4K9r+dcLa57rsvSUgti4OFAdH3GLMzNzFAe7apdz+YNU9R87z0IIO2aW/vVig=
X-Received: by 2002:a5d:6c61:0:b0:32f:e027:b1c4 with SMTP id
 r1-20020a5d6c61000000b0032fe027b1c4mr256421wrz.5.1700257642832; Fri, 17 Nov
 2023 13:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-4-eddyz87@gmail.com>
 <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com> <89c592a523d68713a2d3a6c8f3bbe858ff75d069.camel@gmail.com>
In-Reply-To: <89c592a523d68713a2d3a6c8f3bbe858ff75d069.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 13:47:11 -0800
Message-ID: <CAADnVQJ-ujkk0CKD6=J2dXhd2gJGp-nsnCcRAHBB_6+FBB=xOw@mail.gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 13:38 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 15, 2023 at 6:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > The patch a few patches from this one changes logic for callbacks
> > > handling.
> >
> > That's a wordsmith level 10. I'm far below this level.
> > Could you please rephrase it? 'The next patch changes ...' or something=
?
>
> This is patch #3, and actual changes are in patch #6, I can change it to:
>
>   A follow-up patch "bpf: verify callbacks as if they are called
>   unknown number of times" changes logic for callbacks handling.
>   While previously callbacks were verified as a single function
>   call, new scheme takes into account that callbacks could be
>   executed unknown number of times.
>   ...
>
> Would that work?

... or just drop it. The commit log typically describes only what's
happening in this commit or links to prior commits.
Future commit references are unusual.

