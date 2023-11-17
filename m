Return-Path: <bpf+bounces-15279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1787EFB14
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5913DB20B78
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A34315A;
	Fri, 17 Nov 2023 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZWUp0L3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F4D72
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:55:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso21074645e9.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700258128; x=1700862928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCKe09ZEBq58WGKPntNi2MtxNzEjf44iLgcTxM3JevA=;
        b=SZWUp0L3PtZrfX6q5uox7HaIaUhClhNMXvo0LYohPHZJf/IBNJcttKJzJlauQ/yuF8
         4FLIhvc/ez3HSBjaaC5C0xJZoBK95/fp1BAi//tLfw9e00hg9FR10G6A9bss/Y7deKYf
         +YDHjzP5YxivvLyX41bkdplnm59Nbumr5TEXBhyrF3K6az7b3+VcPJX4aBso0RT+aJQJ
         H9HNlelEP62FGzt+mDYHeOoT+CaHm1FCCT3rl4/mnjpZXnG1XhRmRoMiD0nAyv2qw2j1
         dp7wuYEkAUKQPPH0Q2VhSVqm73O10yjUGne9G38HX6/Btbc3AbB5mGRPZcrWQXMBZg5j
         hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258128; x=1700862928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCKe09ZEBq58WGKPntNi2MtxNzEjf44iLgcTxM3JevA=;
        b=C7eCAFELCYY41vwNWozlqgZKhWvNghsBakh54uZNt17xOGaNSvPWtY/ktzHNNwnToZ
         nRQVhFpzTyUKzmmw0O5tNr/GH//zNlyraoIcqZefY3+nXJTDSr20zHEtwTVN6bb3PKRr
         i92vkIIF1nSHMeNUnw8A6a4TkR722MMEDWBoVCTbY8VJaj5mccJ/6tYqcoqicPVRI/5R
         oprUdMbOEK5jm7PjyAj5hKqvHEJxn+drqBr8trRSF4a/XkUktT6zgha682CcImqvwAGi
         GXwiXYTRUIVfQZXs7eh91QSzOv/IY4VM6YDyZHel8Y2Zp8CTPSfJlblWOIbNByYHmEx+
         +r8g==
X-Gm-Message-State: AOJu0YzZNJXHmz6VgIIciDzlypeMSsK5x+c9DKg3hoZLUkStRnNxI6GE
	xUnZGeU4UP20L+rsEroECV36/edqFHxgEKA9rSY=
X-Google-Smtp-Source: AGHT+IGkPlpWgqvEpXhWfxNZ/581zAqihsUh/LroIVVF0a6hOzktclHPnY9zqcNHtrFP+QwUPUXV3UceXMMb72nptJM=
X-Received: by 2002:a05:600c:3b02:b0:408:389d:c22e with SMTP id
 m2-20020a05600c3b0200b00408389dc22emr257144wms.25.1700258128580; Fri, 17 Nov
 2023 13:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-4-eddyz87@gmail.com>
 <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com>
 <89c592a523d68713a2d3a6c8f3bbe858ff75d069.camel@gmail.com>
 <CAADnVQJ-ujkk0CKD6=J2dXhd2gJGp-nsnCcRAHBB_6+FBB=xOw@mail.gmail.com> <98121f5fd31d67825f4869acd02d1c672f13772c.camel@gmail.com>
In-Reply-To: <98121f5fd31d67825f4869acd02d1c672f13772c.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 13:55:17 -0800
Message-ID: <CAADnVQ+nEje3OAQ3n99s5QVd4LWvM_e4HqN1REDhJkHjGhp+Xg@mail.gmail.com>
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

On Fri, Nov 17, 2023 at 1:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 13:47 -0800, Alexei Starovoitov wrote:
> [...]
> > > This is patch #3, and actual changes are in patch #6, I can change it=
 to:
> > >
> > >   A follow-up patch "bpf: verify callbacks as if they are called
> > >   unknown number of times" changes logic for callbacks handling.
> > >   While previously callbacks were verified as a single function
> > >   call, new scheme takes into account that callbacks could be
> > >   executed unknown number of times.
> > >   ...
> > >
> > > Would that work?
> >
> > ... or just drop it. The commit log typically describes only what's
> > happening in this commit or links to prior commits.
> > Future commit references are unusual.
>
> But there needs to be some justification.
> Since this is not a test, maybe move it after patch #6 and refer to a
> changes from a previous commit?

Better to keep it here to avoid breaking this test.
Use the above wording then.

