Return-Path: <bpf+bounces-61372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C4AE64B4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450FD3B9A9B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8892D23A3;
	Tue, 24 Jun 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUjISHYv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08261291C37
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767349; cv=none; b=q+2Um7kykPEDtK5+WN4QW8PSm9CQSARKGkUQVRSIRUgCt047ZKrfqEh6KZdjVdLcKj3NWqjTfJTK+YVe5DVoFi81inpfs5sjuwTSICRZYImXR7mMlHVkVFJs6RpQBwKDmLaIRRu1jRxbMmzYMUsFi7kk4pmk3Sb/QJGkSy6WtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767349; c=relaxed/simple;
	bh=FybE1wefxjXpDsIwGOpnFROtY3Ox6dKgTuorshaBkjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep/I6MGtx3u4ozVVyLuT2dEoMLF6NbePKDxQeUG2KPbKPDaaEThtYI2fpA7puPt9WMIhTUDJDwYPhKljtWiayzGM1IA6/78Q56owCZOgegROHwXFwvCDtmVHsIVp++GWUUGX454KDGZyn+Sz/NzxHRoG3vl5YgEHP3MjyRmHVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUjISHYv; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso65409766b.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750767346; x=1751372146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FybE1wefxjXpDsIwGOpnFROtY3Ox6dKgTuorshaBkjk=;
        b=gUjISHYv2t67sLGR6kKOAnpPRL5H2hTjbOsnwbfkvhEdPXaIbMSIo4vznemReEtITT
         /4WVISqy6PJvib8c6sORZE71QQ/IiTwoqFGuSt1ovrew3zjQjGoKn/BSYXgT2cPxhhZV
         SmFO81YQec2CrGzFPHnaZ9z1b9o8QCoB6/XRtXEm945ETX/t+3EZ2Va1r7xaDkPU04Rm
         AxO0+UgCFa/EJUBnBAwT95GN+lckBdwkL0QKcQLPS7g2t9RK+QZq/RRaDWHnAUkQ8M0F
         jMamrzlY/zRTqbW76qi1uHeMo6Fvyvfgw66CBtuzLrzLwGdVvmsMFHW+68Gn+d0TDFSk
         WEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767346; x=1751372146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FybE1wefxjXpDsIwGOpnFROtY3Ox6dKgTuorshaBkjk=;
        b=KOu346GVqw4/Swzctd33LXwAqOuOj0A6C8391fPmjIaxHuAX+WTMccqGivvT6BdtQI
         DQ5XwpixYYAfcsFWJem+d2pRjNvyDJPi1UTudimEkxRHKJy5sN6dRc3ZCl2jGi+1miNE
         sK3dfOl7vNGRUmRfM/vpqTm2m1/ovgr3h7yBvu7BcLIXzvh8PuUZylG/UZs+uevPbjsi
         RT/fc1cfqUlBWApHam52QcffjQnaz2Q5pDBL3jg6aI0IeeLS/d69y4ws42w1J8z7dt9x
         oXUnnYLVJYhYBhmRe/bb2JcI+5OWTGyuEOT8QEXlmb9pT5ZFZYXniIUsONsjChyAwxXL
         bPqw==
X-Gm-Message-State: AOJu0YwGE0nOTsCqddhMfs5OrVShE9kOI4coqAmN7Dy3d0doHROWz8x6
	3x6YnVuw8paMjKt0l7Z3Wlg2GHtJbv+j8KWIt0VkWE2WUsHelHkjLYrUzlQ9QpDzQTiEm0drDDt
	i8rh1xdIYLE4Zuk/FGT4RRsvtqibavBE=
X-Gm-Gg: ASbGncsv0/Gj227jwvcdSOpFDtLz1gnVs6yyhvkC+j6m4OuEShUUnUBdcetg8WiXni+
	qwH7I9m7GTqcU7kZCsTudICjJUYGLV7wCUtgTv7435LMVdpTRoFwe7nDbvNAh81DHcWXXmpbkAD
	fFhUU2Si3buj1n0OI8cT2crmpUl3vJ3Z5UxXdNUx25RoLd
X-Google-Smtp-Source: AGHT+IHpoEVqOOYj2WlHi8F2ICeepmRDHa8BtNxmIwAPquPFBk53TWbRIao84xFzX/MAu9ioj64TJd3JFhBg2m4UYug=
X-Received: by 2002:a17:907:d88:b0:ae0:a465:1c20 with SMTP id
 a640c23a62f3a-ae0a73c3979mr337199966b.14.1750767346064; Tue, 24 Jun 2025
 05:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-3-memxor@gmail.com>
 <aFqTiLd4HmjPS5eP@krava>
In-Reply-To: <aFqTiLd4HmjPS5eP@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Jun 2025 14:15:09 +0200
X-Gm-Features: Ac12FXy3VF-RH_bbZMFnle1y62G9lAULTAR44p9JGuPLJIAX5G--WIMZXNOsS-U
Message-ID: <CAP01T77EXWDdRYtrJHUR6qLBgLqe4oT0A0N74CGBBRVGYPuKnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/12] bpf: Introduce BPF standard streams
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 14:01, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jun 23, 2025 at 08:12:42PM -0700, Kumar Kartikeya Dwivedi wrote:
> > Add support for a stream API to the kernel and expose related kfuncs to
> > BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. These
> > can be used for printing messages that can be consumed from user space,
> > thus it's similar in spirit to existing trace_pipe interface.
> >
> > The kernel will use the BPF_STDERR stream to notify the program of any
> > errors encountered at runtime. BPF programs themselves may use both
> > streams for writing debug messages. BPF library-like code may use
> > BPF_STDERR to print warnings or errors on misuse at runtime.
>
> just curious, IIUC we can't mix the output of the streams when we dump
> them, right? I wonder it'd be handy to be able to get combined output
> and see messages from bpf programs sorted out with messages from kernel
>

Yeah, this is a good point.
Right now, no, in the sense that sequentiality is definitely broken
across the two streams.
We can force print a timestamp for every message and do the sorting
from bpftool side, or it can just be piped to sort after dumping both
stdout and stderr.
Output will look like trace_pipe with some fixed format before the
actual message.
WDYT? Others are also welcome to chime in.

> thanks,
> jirka
>
>
> > [...]

