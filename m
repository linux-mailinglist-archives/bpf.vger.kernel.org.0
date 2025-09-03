Return-Path: <bpf+bounces-67310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FABB42596
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED891BC7A3D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F55242D80;
	Wed,  3 Sep 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1XrV+ad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D761EBFFF;
	Wed,  3 Sep 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913550; cv=none; b=ZqzmfsMrXRW0VSJqMIAKvqyQhm4bVDB2YT025dmLVzv/CruN5qeMYrmJeCxm3uKtvKBAWmjjyVsHYGLDEslQKjiQ2HOmKE9yY9LyEFCj72JPlbi2MB5rghlwSFhStQYdK/yMLdkq7U20RZiGxKXJhjuy91SxBbccTF93F6kAcs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913550; c=relaxed/simple;
	bh=fD0zVaYw3TM4QYiKe9is5FFA+yy4HJ9/VXmbpiMJsaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGR7EbqwnWwtC5xBKOBxGUtdhBWT6FYWH7WrixFpEwqOD2i4cxO0YcL9OkQEsKGJ1EsGGCWq79E7EX6Fp7oe/whL9YcLQyAmVqXioHuJkfOfHK6Z2EXgVmdIq6N9QQagd5KAxemPSXhZfC+FECZbfk/L6GK5pbeDIf6iDWZcNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1XrV+ad; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afec5651966so632252466b.2;
        Wed, 03 Sep 2025 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756913547; x=1757518347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgX6dpZS5QfFmd32ErBKjUZtxBII9pKavjHTTkFejqA=;
        b=i1XrV+adb51sA90PS6DYQLwTaWpluZ1/G3ZK5G/YFZ/oPMJx+za6dqq/TLiVVZ6MnI
         hc4jwFv0We/b5Afyo2F1MTY8UYs2ydeWYstsuOqWYcp2Sn+UbQGr0VR3nYY6HpoAuF2P
         m1/6IoPTqZzIssV8jDQu6EwEX/SlKDTWl9Azh4p9tr8e7gGXjAL/5p/y53iQV2tkGxeV
         2MvxC/3jr7dTbM1bDv5VL2IXEs2RX11EfsdvoPEB39nTTcm9Z1bnK+QxQdA4BU4ZRzhe
         9ccdqmVArZ/kJBtgsd8hDEha0MZ83CBHBBHMsiZE9A95PLX1/aklAwGLNqxzLm3fTryI
         ZIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756913547; x=1757518347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgX6dpZS5QfFmd32ErBKjUZtxBII9pKavjHTTkFejqA=;
        b=DtleLqX0MLwtGjPGhjJm6rNyDT6XO0VdszN/D0wF2gBheGSPDgC9vBnIXSZxNQKqf/
         h8CyCcx6Lj2FyIa4Km1dFtDZEbgbsjXt3bH7+E5rMMpl5eEUmuZikRRQRgzhusyG/s4m
         pSTWMjz3WrkDLJYPTG5HCkiuHGR28r+6JwOBml66O0I15T94Y+Wcrtc+1EBfvOmTWe2i
         JoCW9NjH9BxR7hqvHPZaFxlIC2kC2luw9n19gGsTsg+T/J+Wk4svKS7EmEvgky05TVRg
         WOSy5hkKgH3ymaCCWTFeDI3Ep/WbTAKGOJc5g4fj8MXBs+uEEYI3/3CrdS3WfJx8qXQ2
         66jg==
X-Forwarded-Encrypted: i=1; AJvYcCU4oMPK0qEJ+YOPwFkh+3CXbUrlnRzN65DuXpZcowkrdUAZw2uQ7UaosaDvpx/ImjRfwTE=@vger.kernel.org, AJvYcCWIb8IMcIVQq0OYrIAaDD2n8eXq5QE7M+c9bRfR6rC66AUrMKm6lMyRkoMmj/ueOFxtSeysDkV9vnU4xMGv1vbfS1QV@vger.kernel.org, AJvYcCXSIp+kYvkfJOTFv5A8Slf0M8eObSiEWWgbjRTLV4mtbmYiq+TwZlxMZyTqB5/CE9EqWjBJnzePj836bg82@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hXVozcqoSLhgYav1N2yKmWdX2Pbk0Liulkcg5lWvq6t/6DJM
	JGj+mLRFziLtYwIDCflaWJjE6wHEzprncRLLGmbmjgwSApUwlgFdQu8zy+Vp3ax9SJtm+2xRQWL
	aHQz79Ca/WYdm6LMufR+jh9qa5OpvWz4=
X-Gm-Gg: ASbGncvtvxktxHTsgvu7/9q+6G21PCQai8gz5BHjmGeXka3pX0ND1UAeUaRaYDtH/Jd
	LznJ0pHsnT1cDsqksmqI0TKER7Q0QeaHWAMxfqlQ+Zw+TSFW5TUd9tfW+5IEa0r3wtsWNkb1nbe
	k79j83O31VXgTTsDtcl3Pyg0WWkBs1q6+fVCgbeoBUchdCR14cL4/45Z1Qqi7UECC6e2Xh4H98J
	QLZxd/AKzkn4Itev76uJfXMeYgXH9cSPQ==
X-Google-Smtp-Source: AGHT+IEt0Yis1igDmpDx0CLQTXkm8aHokNuMof+Pl3n0bzmLGpmg9EcoltOpyNV+iZGd/bgZATvGhR0SRpu3UD2W4ZM=
X-Received: by 2002:a17:907:1c18:b0:b04:25e6:2ddc with SMTP id
 a640c23a62f3a-b0425e63190mr1217006466b.8.1756913546482; Wed, 03 Sep 2025
 08:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-5-jolsa@kernel.org>
 <CAADnVQ+MntzHdwSe_Oqe7CU=E3yjko=7+9GTnapsPWwe4oqpsw@mail.gmail.com> <aLfhwmf7lkIYQvBt@krava>
In-Reply-To: <aLfhwmf7lkIYQvBt@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 08:32:14 -0700
X-Gm-Features: Ac12FXxASY2P0h5YMyjz9HhgwgYggMMDww7dZzIhA6BIbSwyPzLvK2tOLrG5coI
Message-ID: <CAADnVQLLcH1weL24BJv=K5cSijNzjgWq5LM2=GCyM6bid2m0ag@mail.gmail.com>
Subject: Re: [PATCH perf/core 04/11] bpf: Add support to attach uprobe_multi
 unique uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:35=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Sep 02, 2025 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> > On Tue, Sep 2, 2025 at 7:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > Adding support to attach unique uprobe through uprobe multi link
> > > interface.
> > >
> > > Adding new BPF_F_UPROBE_MULTI_UNIQUE flag that denotes the unique
> > > uprobe creation.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/uapi/linux/bpf.h       | 3 ++-
> > >  kernel/trace/bpf_trace.c       | 4 +++-
> > >  tools/include/uapi/linux/bpf.h | 3 ++-
> > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 233de8677382..3de9eb469fe2 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1300,7 +1300,8 @@ enum {
> > >   * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> > >   */
> > >  enum {
> > > -       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0)
> > > +       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0),
> > > +       BPF_F_UPROBE_MULTI_UNIQUE =3D (1U << 1),
> >
> > I second Masami's point. "exclusive" name fits better.
> > And once you use that name the "multi_exclusive"
> > part will not make sense.
> > How can an exclusive user of the uprobe be "multi" at the same time?
> > Like attaching to multiple uprobes and modifying regsiters
> > in all of them? Is it practical ?
>
> we can still attach single uprobe with uprobe_multi,
> but for more uprobes it's probably not practical
>
> > It till attach single uprobe with eels to me BPF_F_UPROBE_EXCLUSIVE sho=
uld be targeting
> > one specific uprobe.
>
> do you mean to force single uprobe with this flag?
>
> I understood 'BPF_F_UPROBE_MULTI_' flag prefix more as indication what li=
nk
> it belongs to, but I'm ok with BPF_F_UPROBE_EXCLUSIVE

What is the use case for attaching the same bpf prog to multiple
uprobes and modifying their registers?

