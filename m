Return-Path: <bpf+bounces-20109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF88399C0
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FC828E5D5
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADA82D71;
	Tue, 23 Jan 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0TEFW81"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E34811EE;
	Tue, 23 Jan 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038847; cv=none; b=ipqRdKNivIKpzDoGLP5hklmZBoTu3eXEfGcmkS6tFa4dN9l7wwEVtpZiNBt3NiX5eat3layQ6lo+tXem7L5O9Ni1sUCB/W4I4cQeABUVov/ncXlExVDGkhxJzuPUf5+eUJiPdbJzTXRjD1yVHj0xaBEHO1YVdcRe9J9RNtrXVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038847; c=relaxed/simple;
	bh=FYtZI+5R9kqbjSYb9CK9Mm6YPb0kqh9T3mg3nzspY5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2Ifm9s7a1qjzqr0auNUEifdxsQwR+dlicq+Kh1+GVZJrZxZLX29xfV7JY47pwLqKhF+E0EYcdFXqxDbAbhd4nqCqvO0schjO/JN5FkWytllgLtCsBxRafgV1UUhRn50cBKbzkxkG98Hyw6GrXkw7xBsMAgyPyXSjYktC9OPwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0TEFW81; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-600391ec9b2so8970757b3.1;
        Tue, 23 Jan 2024 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706038845; x=1706643645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAivyP7SbKKLe4N0sRsoFf7bFFfahehZe+y/KoPgB24=;
        b=P0TEFW81lYUoKuJ7PcTfD17OuDM3oS6hR2Wx1WQoiDmuxliOfgOEwPfVoblwMXqCrh
         RzPO1TvR3JYGYJqUkFJSkyEXsr6/qMIYvepnwdsE8bs0kmi9Yfo+3kSElvkOLs75f4Uo
         AaxFv0mSI/tRTNMGYE1n6RQpM6CxNkJ7oQBqFHQOs7xoKRm7MeGfA/cAtA/qqG2UuUD9
         JFjtcE5/Do6E6SpsAUiAx71saCTdp2a/z8qvEaqG6ooXzMpXjOkKKF/CRIsMc4UyABaJ
         khFDShRp4gdsY/uDXo4oEjkX3ZpbV4BSUL1iJGuOhcO04qxXXMnMc4Q/DaQJxfrZ1Avb
         eZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038845; x=1706643645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAivyP7SbKKLe4N0sRsoFf7bFFfahehZe+y/KoPgB24=;
        b=erNBDtWSDgLDYn0sF7V5HnOgfMwgZl4en1uFXFV6HKYzgL290aZZNRN51z9QLrnTi3
         5P9wumqSoqWDJPR7sI97NVnjeU1GrTqC7JLP3Lr1UTDNA9KnpJrCDmHSGQQlp/NREK2E
         OOSquVyMeKRGX+bVbqKNJVXqLn9AJaJ0/0861Z6AZpinFwM18PhJ9GcVZ+Iulh0bIe7/
         YR60qy+26KOJpeh+agqiXj3kq4EOBd3gFZh3gskVLx3BwGbf0rciHFxJEXseIdUqAk+O
         BYmyUPu10KRWMP+LlmvJENyq1GRiCO6B6aqiR36XyjEKAInC+NVMhKGKVQ9Vl1EovI4c
         Pogg==
X-Gm-Message-State: AOJu0YykdTIb0aLwbW0VZEDlgLM9BSzgPZfkCRtrt4lIdTFhBGIB0kfN
	/8hjYOsE0bqvSYecll3tieJ7pKp7T974EsFM0LyLVQWdrWcjsJsQ2Er0ILsnXnWUc+dkl2jc/H2
	GHcBcC/wsuSF65/jFdYPXAxl8abU=
X-Google-Smtp-Source: AGHT+IFSVzcDtpKRx1NESTI2URlQLZhAj4l5YWQzSM41ldKFvTUC8ClxeX7cOF8O8RDXVVzZGreIVRJcqSjnr3ns/Nc=
X-Received: by 2002:a0d:ca82:0:b0:5ee:6ad3:b0b1 with SMTP id
 m124-20020a0dca82000000b005ee6ad3b0b1mr5302626ywd.4.1706038844712; Tue, 23
 Jan 2024 11:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <813b2de18b94389f4df53f21b8a328e1c2fdda13.1705432850.git.amery.hung@bytedance.com>
 <CAEf4BzaDCsVOBgCkZKPpM2RbsiKQMLToRaiYpBYejX=F5DncuA@mail.gmail.com>
In-Reply-To: <CAEf4BzaDCsVOBgCkZKPpM2RbsiKQMLToRaiYpBYejX=F5DncuA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jan 2024 11:40:34 -0800
Message-ID: <CAMB2axNXn80BCNyX5cxjD-+QgfVnYRhK-DesvxewB13=vywceA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_QDISC
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:18=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 17, 2024 at 1:57=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > While eBPF qdisc uses NETLINK for attachment, expected_attach_type is
> > required at load time to verify context access from different programs.
> > This patch adds the section definition for this.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index e067be95da3c..0541f85b4ce6 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8991,6 +8991,10 @@ static const struct bpf_sec_def section_defs[] =
=3D {
> >         SEC_DEF("struct_ops.s+",        STRUCT_OPS, 0, SEC_SLEEPABLE),
> >         SEC_DEF("sk_lookup",            SK_LOOKUP, BPF_SK_LOOKUP, SEC_A=
TTACHABLE),
> >         SEC_DEF("netfilter",            NETFILTER, BPF_NETFILTER, SEC_N=
ONE),
> > +       SEC_DEF("qdisc/enqueue",        QDISC, BPF_QDISC_ENQUEUE, SEC_A=
TTACHABLE_OPT),
> > +       SEC_DEF("qdisc/dequeue",        QDISC, BPF_QDISC_DEQUEUE, SEC_A=
TTACHABLE_OPT),
> > +       SEC_DEF("qdisc/reset",          QDISC, BPF_QDISC_RESET, SEC_ATT=
ACHABLE_OPT),
> > +       SEC_DEF("qdisc/init",           QDISC, BPF_QDISC_INIT, SEC_ATTA=
CHABLE_OPT),
>
> seems like SEC_ATTACHABLE (or just 0) is what you want.
> expected_attach_type shouldn't be optional for any new program type
>

Got it. Will change the flags to SEC_NONE.

> >  };
> >
> >  int libbpf_register_prog_handler(const char *sec,
> > --
> > 2.20.1
> >
> >

