Return-Path: <bpf+bounces-16912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D561807771
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEE9B20D9F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807966EB52;
	Wed,  6 Dec 2023 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jConpzkj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AA122
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:20:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33334480eb4so114608f8f.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701886842; x=1702491642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0SxPGs+YFKMtt3igv6iG2Mh9V6Z6Jj0/EJuYX9jxFI=;
        b=jConpzkjjt/+9gJkAn8LgCT8j7kPjjx75H7mtLRJQTdlxVUTtcRXrcQmt/tlyDkoew
         hKSpklo4t9CG6fzywxBQAhjBQutbK9/86giB8gkT9+RYUfaWTfLoA6C/T1WYKGaWpu+I
         P9EMB3saPKei1RP4A7WLoJ/zR0Ygs1BejsqoQITW3EsvfF8poSRWwm02NndU9dCXJ2f6
         Y2HnLcIrKlrXJv9O6FgaYkodbQJnHNuoLXd/1Ujh0QwSxH7OXVKWByEXDKX9aBvKq3d2
         A3u2r/Zx4BC/Bx6jYq1hs47Qzw9I3rgD3P/lw9Mf8WZhWJXvpJydVS/U3Le49tClzRno
         A8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886842; x=1702491642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0SxPGs+YFKMtt3igv6iG2Mh9V6Z6Jj0/EJuYX9jxFI=;
        b=e7txLJRryb4YVSAMrzEAuunql64hBDwpAWQzKAo/2/kKXMApg88Ix02SIcfhTAM+uh
         ZV2vRaIikZnSV1HbmmPZsHHmbInzEe/z5kHZalqGbwDzB9/Nzx8uj+lmLLDvvSHUduiL
         JKHE2c5pfKy3Q8Ix5swY91LCOzHPBxWugxqirsAw91bjMltYaSAj5rt8dnNMYGaELqFl
         RJZs3illBH4gVUmbf7UWFqoRzNtSTbk6qBkUxLy4yriy8oxSKtKXOzk9ARLyQo1cIQh5
         MIjzxlYD7bpuPEAtfSkO4hZYLWz4PbgDG0lwYKf6+6ABoO8oJceeGMcoTHwRNnQ+kU8F
         4lZw==
X-Gm-Message-State: AOJu0Yyar8YHYekMyjmtMI9Y0A1sAvBqsvDXznFFvDilLEXvvyrDttQY
	1w2DYZkURQgl6KZ0DRlJgAt4M7X+oVqBFwwC0d+EP8yT
X-Google-Smtp-Source: AGHT+IEwuL5iVULrEapYEI2ou+8FRa9lRI4HNxlrAH8UGbvSPepIl9IBESs3FvdMP6gNc0X/8FtNZeTwTlfjGRW98vs=
X-Received: by 2002:a5d:4a42:0:b0:333:40bf:a965 with SMTP id
 v2-20020a5d4a42000000b0033340bfa965mr854968wrs.82.1701886842537; Wed, 06 Dec
 2023 10:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073624.149124-1-jiejiang@chromium.org> <CAEf4BzZvuFcBMvejMoQVCPaRsDQRXmqAvVxJ-o3G=0Ojf0RhtA@mail.gmail.com>
In-Reply-To: <CAEf4BzZvuFcBMvejMoQVCPaRsDQRXmqAvVxJ-o3G=0Ojf0RhtA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Dec 2023 10:20:31 -0800
Message-ID: <CAADnVQJUzS139OK9_CvxN7yAGdhZSeEaOvROANkfaXwQOU84jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Support uid and gid when mounting bpffs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jie Jiang <jiejiang@chromium.org>, bpf <bpf@vger.kernel.org>, vapier@chromium.org, 
	Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 9:21=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 11:36=E2=80=AFPM Jie Jiang <jiejiang@chromium.org>=
 wrote:
> >
> > Parse uid and gid in bpf_parse_param() so that they can be passed in as
> > the `data` parameter when mount() bpffs. This will be useful when we
> > want to control which user/group has the control to the mounted bpffs,
> > otherwise a separate chown() call will be needed.
> >
> > Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> > ---
> > v1 -> v2: Add additional validation in bpf_parse_param() for if the
> >   requested uid/gid is representable in the fs's idmapping.
> >
> >  kernel/bpf/inode.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 50 insertions(+), 2 deletions(-)
> >
>
> LGTM, but I want to point out that this will conflict with the BPF
> token series ([0]), so depending which one goes in first, the other
> will have to be rebased.

The token series are much bigger, so I applied them first.
Please rebase, resend, and keep acks.

> Acked-by: Andrii Nakryiko <andrii@kernel.org>

