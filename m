Return-Path: <bpf+bounces-15273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBC7EFAF0
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49710B20C55
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967D4F8B1;
	Fri, 17 Nov 2023 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2T8TBHc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F9126
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:33:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so1573005f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700256830; x=1700861630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAlzk/unhBu2nRgJKPnl0TvKLUB8d1xifsdt7Q+uzDM=;
        b=Z2T8TBHcSd0O5ZxMqqMotTveKkwUexnTKeZn2l/kFwA8gC3mYl7M4jhp/e3h29bJxS
         aOkPaunsOk2jyefNhVqw5JU7bOuQGhO4+05ICcn3MYU+ngke8/xwL+XT1zZ389yeyiUo
         zNrcvAnzyu96d3d0LAkXUF/EG8XxaTvLFON7dFndv/tZqh3/d96k2zUi/Wu6TM5Fq3Q1
         +OuARCtMq2rsJ7ij+RDOXJR5uR4EzNeFW8KtMpgR8Mmc4SGwkiYbYpBPCFbjoalrCllY
         QYKunlSuqJulZcVTNuJ3OqqBnzHVginl7EXQws18N4ThLtvGy/3Y3IfRkslpp9XoRi8f
         hs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256830; x=1700861630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAlzk/unhBu2nRgJKPnl0TvKLUB8d1xifsdt7Q+uzDM=;
        b=Xiz313YJx3DXKYYZbt2vwluDGu/bgmvqEuRVCnWoWzWE1oQT4ia99QNca4PyQD8iuI
         8aHslwPpDU0gSaG+FVD94pY6/5VfG5RLPUAnw7Se3mKDLg2Y8OW+5xz71xWUyLECFTld
         URV7mFqX2U5wLfd07StrX/+y24Ax16bxxYIMYarvPNbEVvVlzuFz8feDQb+cxaR3QZyh
         o99nrmeyDnwM2qV1M1FkdKuGEgL3alfDyhD4fqcE8emtl/yL3TAYTHjMFMaPWwqnDDey
         89KeeXWuTcjXkVJ6mJGw52YTEIF+XrbQdn02ACDBPBMyHGTE5his7sKbRK6t31OBFGYH
         D6Mw==
X-Gm-Message-State: AOJu0Yw+UGU3ccDXGxj4c6oCKBxfWMmhHPWjyo0CCiOB6T8YcFkvKbty
	Xxy6girYSXM4LINiM74JlhglydFeWK/6+PK9YR4=
X-Google-Smtp-Source: AGHT+IEZo1WBiqoowk+QfwmdEdBXhw8rcDrJCj7brwRZZjjb/+0ATgRr/4iWZvKwyzbjg6MzIs63mPKebq1QgBo6Ayo=
X-Received: by 2002:a5d:64a9:0:b0:32f:dca6:534d with SMTP id
 m9-20020a5d64a9000000b0032fdca6534dmr195855wrp.47.1700256829610; Fri, 17 Nov
 2023 13:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-12-eddyz87@gmail.com>
 <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com>
 <d6e728aa421b08544b982a0ce60148ef45af7b53.camel@gmail.com>
 <CAEf4BzYHjLdw4xDkoa_r2hBc_RiOtZE78uGcg013GxJ-am0uBw@mail.gmail.com> <6a0e48e8061eb1c2d6b18424fd761affcb2821b3.camel@gmail.com>
In-Reply-To: <6a0e48e8061eb1c2d6b18424fd761affcb2821b3.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 13:33:37 -0800
Message-ID: <CAADnVQJNGZ6SMDYZ8unyDiCB4au=DXX8=N8746s6WvjkTPPTuw@mail.gmail.com>
Subject: Re: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for
 test_loader based tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 15:31 -0500, Andrii Nakryiko wrote:
> [...]
> > > > I think this implementation has an undesired surprising behavior.
> > > > Imagine you have a log like this:
> > > >
> > > > A
> > > > C
> > > > D
> > > > B
> > > >
> > > > And you specify
> > > >
> > > > __msg("A")
> > > > __nomsg("B")
> > > > __msg("C")
> > > > __msg("D")
> > > > __msg("B")
> [...]
> > I think it's useful in general, I believe I had few cases where this
> > would be helpful. So submitting separately makes sense. But I think
> > this patch set doesn't need it if we can validate logic in last patch
> > without relying on this feature.
>
> Ok, will do it separately. While at it can also add two more features:
> - __msg_next, again mimicking FileCheck [0], which would require match to
>   be on a line subsequent to previous match;
> - __msg_re, with support for regular expressions (using [1]).
>
> [0] https://llvm.org/docs/CommandGuide/FileCheck.html
> [1] https://www.gnu.org/software/libc/manual/html_node/Regular-Expression=
s.html

So far this patch set didn't have conflicts with bpf-next and
we need to land it in the bpf tree and backport later,
so pls minimize the changes.
_nomsg, _msg* extensions are certainly useful, but let's add them
later via bpf-next when trees converge.

