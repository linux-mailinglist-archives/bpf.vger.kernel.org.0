Return-Path: <bpf+bounces-51366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26FA3379B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9517A4516
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9BC207640;
	Thu, 13 Feb 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWklfQGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE7204F85;
	Thu, 13 Feb 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426158; cv=none; b=O/8AwdHeM5GztAfzVEGRwCHmFz4y+Pb3O+bB2HoDXqdoy7a7lh5L6/Cq6lYN4WZDk6pufxxJkiFMWNIlPA8CFxqfTzqynY9MTOupLiTzfUxEOQ4nNiLBdweL3W9h1cQguFJhx7If3OHmkmQqjmybVApUjaWaf5h9Ey9mjHxJ6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426158; c=relaxed/simple;
	bh=Wg3PP9aJWpHfVe3nPyR6u8KjM9Y9g9rokv8BwcIlS64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke3N6EvchJbBpCjHOMRYNkN38SgvRHP+giIJAF1DZ6tUxKq3nJSyvAUAzYUy5uUtWT1BftrjEDvrvpp/1XiWQm4sDo5DQsvh8tgUyhh1yoaMF12MGJf2wSKTYEvrcM9TXV/EWszC72vGVqE0HRbzUO/zYTcwqg85ivxmdJTdIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWklfQGN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so531845f8f.0;
        Wed, 12 Feb 2025 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739426155; x=1740030955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbm99omdbeF2OrhsawYuDgrANSK6CWJAaQSKOaxjXj8=;
        b=iWklfQGNAOIl223po2YhyFMJGHv900vZXriz3YHRkIgDKIib6x3ITZ175yhOjgwRy2
         4D6eO9iMXSxno1RP2AgbxldGzBDUvr4g5XoJzu0zPuqzQkt/nOmpDuWe8bShiVDLVVRh
         nO1aSoYdI+IpJg52udZrWuQQjbBxDnKPfz/IW3oSOYytxNv5Uk9+sWrgYUeiraVvWJpW
         Wo0zxyHrmmDqszIddRuSVCd2/NTUcr8JNaf+yXq04vYIVmMsrhG2qrvlD94qR11AwTQ6
         9FiRmj7+gvkGhqOSWtMSQeVX/ZHKnbKhp+DVrSdHI6JCGp9tedV+byK586uentci1IuN
         onAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739426155; x=1740030955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbm99omdbeF2OrhsawYuDgrANSK6CWJAaQSKOaxjXj8=;
        b=RXVaD3mjFWafB/bnViLcWrG1LjJZNtupH/jFV7khlkvRLVK0vjAp0v9+y0DEcZbbUs
         wzb1f6hdOAxGKUdtxON340Guot/VY55iMokIJYdxOYqd+5fxQS7U8rBW/yQWxTN1Vfac
         vtZiuSNk6u/KPypktbfrAEJ+0bQfQ7xOan3Cbf5qDby64H+iUfUayOUdnkZJxAh4mFsu
         GSNxd1kjuPDF4hGXggeEA7dZL73JqoCBMMSW97tG7F4TgQAoDfSGDyScTvUzmDAOifBf
         qmGovbVaRKOwU8yqG/jBph1+e+G3dfXOjjmXVJpGWDj2sdi+Qz7k/kXVb8adskubT8Ir
         xRtA==
X-Forwarded-Encrypted: i=1; AJvYcCW6jG5frh1mHAZHZ6PuXKr637okjjOPz1l6WVmTNhFCYrVqQW2iSjEET160R64v0oGxXC5tZmeXb8GUxpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNAsKax11Xg3mnckH4Q4GHaCboktWrWKPVKDB9ale8OHHhHI/
	XZd4sYfkAyUeY1+/LGKWWt0i7HcWwZLKu0lvWM65mwXKbseGHgeR9IYGzrnfk5NRD0PbTddYuAP
	IbFikph+2ViOHhWaAARuia3oNQXWqsYs6
X-Gm-Gg: ASbGncsoWSn/H2NCv6vncxu3/hMNspQcb+8VtZp1B7jL4pVuhoQtRyhJwLbJ1uPVqNf
	Jr5LLyfw1SziyaJr8Dkpik3Ja0EB+B8rJHSkfJWY/na8TR6daXYzWV2FYr2wPxQdUQNLmp4SznT
	qrUyVJuOyZ+gNm5Sly0xACTIQpT9ks
X-Google-Smtp-Source: AGHT+IFawGeeYMbjKz90TN1DtLZr67GxcvjTKL036bBzfPWrntnVydBRlcH1fRJZEIe36nuN+kjX6MDuRC/G3AJdku8=
X-Received: by 2002:a5d:6ad0:0:b0:38d:df29:e14f with SMTP id
 ffacd0b85a97d-38f24518191mr1433002f8f.43.1739426154568; Wed, 12 Feb 2025
 21:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com> <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com> <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com> <Z60dO2sV6VIVNE6t@google.com>
In-Reply-To: <Z60dO2sV6VIVNE6t@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Feb 2025 21:55:43 -0800
X-Gm-Features: AWEUYZkMIBfgqn-J1QBcK_dOmAe3QSFRdLl9n0tBkJRYU8-4UpfsqB1hdA59AeM
Message-ID: <CAADnVQ+OyoBPOJk6dcUFozTt0RD-o-hHdR4Dgy+dK2r0uHyC7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:14=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> On Mon, Feb 10, 2025 at 10:51:11PM +0000, Peilin Ye wrote:
> > > >   #define BPF_LOAD_ACQ   0x10
> > > >   #define BPF_STORE_REL  0x20

so that was broken then,
since BPF_SUB 0x10 ?

And original thing was also completely broken for
BPF_ATOMIC_LOAD | BPF_RELAXED =3D=3D 0x10 =3D=3D BPF_SUB ?

so much for "lets define relaxed, acquire,
release, acq_rel for completeness".
:(

> > >
> > > why not 1 and 2 ?
> >
> > I just realized that we can't do 1 and 2 because BPF_ADD | BPF_FETCH
> > also equals 1.
> >
> > > All other bits are reserved and the verifier will make sure they're z=
ero
> >
> > IOW, we can't tell if imm<4-7> is reserved or BPF_ADD (0x00).  What
> > would you suggest?  Maybe:
> >
> >   #define BPF_ATOMIC_LD_ST 0x10
> >
> >   #define BPF_LOAD_ACQ      0x1
> >   #define BPF_STORE_REL     0x2

This is also broken, since
BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ =3D=3D 0x11 =3D=3D BPF_SUB | BPF_FETCH.

BPF_SUB | BPF_FETCH is invalid at the moment,
but such aliasing is bad.

> >
> > ?
>
> Or, how about reusing 0xb in imm<4-7>:
>
>   #define BPF_ATOMIC_LD_ST 0xb0
>
>   #define BPF_LOAD_ACQ      0x1
>   #define BPF_STORE_REL     0x2
>
> 0xb is BPF_MOV in BPFArithOp<>, and we'll never need it for BPF_ATOMIC.
> Instead of moving values between registers, we now "move" values from/to
> the memory - if I can think of it that way.

and BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ would =3D=3D BPF_MOV | BPF_FETCH ?

Not pretty and confusing.

BPF_FETCH modifier means that "do whatever opcode says to do,
like add in memory, but also return the value into insn->src_reg"

Which doesn't fit this BPF_ATOMIC_LD_ST | BPF_LOAD_ACQ semantics
which loads into _dst_reg_.

How about:
#define BPF_LOAD_ACQ 2
#define BPF_STORE_REL 3

and only use them with BPF_MOV like

imm =3D BPF_MOV | BPF_LOAD_ACQ - is actual load acquire
imm =3D BPF_MOV | BPF_STORE_REL - release

Thought 2 stands on its own,
it's also equal to BPF_ADD | BPF_LOAD_ACQ
which is kinda ugly, so I don't like to use 2 alone.

> Or, do we want to start to use the remaining bits of the imm field (i.e.
> imm<8-31>) ?

Maybe.
Sort-of.
Since #define BPF_CMPXCHG     (0xf0 | BPF_FETCH)
another option would be:

#define BPF_LOAD_ACQ 0x100
#define BPF_STORE_REL 0x110

essentially extending op type to:
BPF_ATOMIC_TYPE(imm)    ((imm) & 0x1f0)

All options are not great.
I feel we need to step back.
Is there an architecture that has sign extending load acquire ?

Looks like arm doesn't, and I couldn't find any arch that does.
Then maybe we should reconsider BPF_LDX/STX and use BPF_MODE
to distinguish from normal ldx/stx

#define BPF_ACQ_REL 0xe0

BPF_LDX | BPF_ACQ_REL | BPF_W
BPF_STX | BPF_ACQ_REL | BPF_W

?

