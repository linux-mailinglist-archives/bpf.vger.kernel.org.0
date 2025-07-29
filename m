Return-Path: <bpf+bounces-64579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD7B145FA
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7301AA1FAB
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077DF1F5435;
	Tue, 29 Jul 2025 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZhZsJqc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C317C211;
	Tue, 29 Jul 2025 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753754125; cv=none; b=Ct+vkAKTq4eHRcYHaFcfrNK5nVS2Mz/v1evUDnnM7xaN4flsTDckmPxzv7QwZVOHDTxLyZ9xJHM+mSbmQq52sQGmLIHsWFMjoaKTFmkt/ApfttX74k8y3WaLD2vAGrY/F+H82xsxNgiBBhpejv7knqlGbTSRecckDJJ3ZRHCr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753754125; c=relaxed/simple;
	bh=NJj/9QPeIZ5oNfhVdmPQCsMlGI6rP5xfU8AS0TACYxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsotat8Yv0sK/wEfsU9gUPYpyBqFS7z/+O9S/t/C8zD5D+RKs5mC8vNE2t/gO5oTP6BxPG21dyZIzQfVC0abGC/Fp3F+FiybKAlZuAtdDWRk28xLt9fI8Hi8LsGXWssyQZBdynyNOaf+wnSGkTFYEEc/bUsfzmqjU3GbOSZjoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZhZsJqc; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71a3a341fe9so997407b3.3;
        Mon, 28 Jul 2025 18:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753754123; x=1754358923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugArAxMbUUQ8jK64Z10R37hSqg25QJBjlPZUGjPII7o=;
        b=JZhZsJqcRHnFPbDYmSplXcdJgO3lL/IWdAxsOpd/XB2Pik+Y/+nh3+3/1KGHHkXA2K
         cWymUoIneSkpF4ZTlmr8C4DYFayM3o6PkWCT0R6P7Q0n3Nhuc6Ml5ib7q8ATXuXnkw0B
         B+UQt81SjyyoeZeyXcsj/CI9y3/yDexigpWyr5yqt/HDWskSgzKpqInLEJGB1sBeG8/i
         Pev558PBJvZx4ZNpUdVRWKKTa7y1xya/XZL1FJYDHfO4ead8JeBlWIwYxq8kaFMagXyV
         TcpLeNj6T8l0R0zTrPnUdY6/r1+vrj4Hz4mcf9cSb80znqyGnqYSGqaNzjImL50/GGRH
         P/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753754123; x=1754358923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugArAxMbUUQ8jK64Z10R37hSqg25QJBjlPZUGjPII7o=;
        b=iXGvzsZ+ntvoiZ14YoQmdxdPdo+qHIhcQq6VFS37+0NW/l4+NupJndhPelOZQYCecn
         jNrzs8k4sg633kQbE78Wm6x/MgHy6eNPqZB8tkqD9V9aBpSpYbhAail5mdAu8trWHLZ6
         cZWOcE74f2W1NNx5+nyhNmpGfLu61EJWbPAh/1P43wRcrZm0HX61RYQcg7W6aglAnXFy
         YDTURitOLiECTM8m8G0xKYoGu9TyAgC8JHseq/nfBRJ+JftZJKGpiQVa+q9TkUJ8f/42
         6Yye6f4pNSNRubj/DdLWc4a6kh+zN/CuZ0OzkKi7s8Kqd8Vcu3B0LXG+JSz2iPkf0bD7
         XgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCe36WigU8KFESUt54TzsfSHIZl9udTlgPQpqeuKlHdXI5mFpkUWOiuTYdrark022cGna5vkyD0qpIBRK@vger.kernel.org, AJvYcCUlK/Ihp3z/CyGZoPAro44MPRQ+GsobBEEUOJR/piwgFS7+r5zYRXqDLu2jQBit79y6PB91+H0/y8cR/BgnaYyhEncE@vger.kernel.org, AJvYcCV5r5dpr58Wd24KhHc6vdxMdjIAPIM++NOqL/zpnwE7W8UWUMFTOGyoEdZT43cTsODdGYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOtcbsJxW2cpzzOfd9TuUtLfxmakcL481KO9afpaQpbwx25nR
	XB3xT+wtdtsvhK97n+Sdo963ez5ypLMTryrUrDk/+C4qjD48YZTzgJBl6UijwVxpkHJHEawCIG7
	aWBnnQQtgIw8quqng8xysBzyrKve7kpfP+ijZBdk=
X-Gm-Gg: ASbGnctwynJ2r27tep2jPXY0n8RE08rvln0VEFdLi0Sax00GQdbE3llX0dcoWwhDfmB
	3B7oXBZPctJu7f1G3Vi0/Z+Bt4W1lge6CaoQR0/7CU4kSvVt4lKNvHA0gm40gozicyOUIravgPd
	QEjIsyFhkPwWVOWPBtDbXVdfxN053bAU1+Q0Z9cjmFskZrLzwCE/lzZzLCHsIUDD/V6p56OySHw
	xh/RaM=
X-Google-Smtp-Source: AGHT+IFpY0VJYBru28vqAmfCI9InmkTKlwQqeX74e8KZ+nE7zJJRMRePcIL245G9pczJ/DlcSkEkXfOJ06f93AOQp9A=
X-Received: by 2002:a05:6902:2702:b0:e8d:eefc:61f8 with SMTP id
 3f1490d57ef6-e8df122ef75mr15828000276.28.1753754123009; Mon, 28 Jul 2025
 18:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
 <20250728072637.1035818-2-dongml2@chinatelecom.cn> <20250729104254.560beac056de20d6aebe1d55@kernel.org>
In-Reply-To: <20250729104254.560beac056de20d6aebe1d55@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 29 Jul 2025 09:55:12 +0800
X-Gm-Features: Ac12FXzP2zLoYvvgLYz1p_f1OZoitOwNQD-xFA1RbtuBpc01Bs0c2jQfg2ME0SM
Message-ID: <CADxym3Yx=NQyvHx21M8aU2WfjsbvOHetKQbnXZ_hX7LagdpoQQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] fprobe: use rhltable for fprobe_ip_table
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:42=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi,
>
> I'll check it deeper, but 2 nits I found.
>
> On Mon, 28 Jul 2025 15:22:50 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index ba7ff14f5339..640a0c47fc76 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  #include <linux/sort.h>
> > +#include <linux/rhashtable.h>
>
> nit: Can you sort this alphabetically?

OK!

>
> [...]
> > @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned=
 long ip, unsigned long parent
> >  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_=
ops *gops,
> >                       struct ftrace_regs *fregs)
> >  {
> > -     struct fprobe_hlist_node *node, *first;
> > +     struct fprobe_hlist_node *node;
> >       unsigned long *fgraph_data =3D NULL;
> >       unsigned long func =3D trace->func;
> > +     struct rhlist_head *head, *pos;
>
> nit: Can you sort this as reverse Christmas tree? (like as below)

OK!

>
> >       unsigned long *fgraph_data =3D NULL;
> >       unsigned long func =3D trace->func;
> > +     struct fprobe_hlist_node *node;
> > +     struct rhlist_head *head, *pos;
>
>
> >       unsigned long ret_ip;
> >       int reserved_words;
> >       struct fprobe *fp;
>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

