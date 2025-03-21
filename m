Return-Path: <bpf+bounces-54526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3214A6B4BF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7271898032
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FA1EC011;
	Fri, 21 Mar 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSaNiX2J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256011E991D;
	Fri, 21 Mar 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541322; cv=none; b=DiuH2A6ksyn1zTJwbNlqSWfLiuueQR/WunV6O87wWP2cpzB/KTpG7IxgiZpC306wlj3jfskm+vyF0IbgxS93RNifTBO4TnnNdfojKMsGgb/PqagLeZDYIevdxhevQIdWHitWfIfzyUD5djZ442rPhQBSmOUtTUHavQYLW7vMG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541322; c=relaxed/simple;
	bh=6Hq1R5v42UeX92HRP8x6W4hw97tfd3WgOBXiMFFQPcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPVI0y2ZdpMxzRUWoFwA6D+MdWaGzQmFp/gA0EeTqOI4fppg6xcQIN40WEcd7nPr75QRWdVWaA2Ok6cyAf0Hcne8+HKxru8oYq0AooekdSfp8rAF1LD7kJK3B20x09pof4rpIemiu00TAfbrHX26Ui8lYkWR4Nno1jv8jR8Voko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSaNiX2J; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso16607051fa.1;
        Fri, 21 Mar 2025 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742541319; x=1743146119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj279fORMD9vy3tpRh39rw+SrjrZF1uuE8aC7Joa19s=;
        b=OSaNiX2JlOl/riRl4GC3i6qCIKSX5g2K3SEtHnamKQV2KZ1m71F3dyVc2NrDPy3rO1
         hUVQTpIbEi3Yz/Rhv5ygowuLQW7+V7OZ3F4HjQThnq2TiZ7eNRM7fj2ehgzRU7xV8NVJ
         J0HIQFZusjFQ0J03NIniRgaWq7cNMSubbmpnUY78NFTGWdAEgg4k+nihBsP2PRlwvrGw
         O4vuchuELeHZ891/OobYNvDelw0PDuaBHWHFqzJzQczlDzgbvZpcknWKENttzVsw7CXl
         GbABnwFYEHQYcxejOWVJsGWUQE5aSARTLbx/8ru+jRm9yYUOq4OHIEEGGDfb+o+MODEQ
         CMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541319; x=1743146119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj279fORMD9vy3tpRh39rw+SrjrZF1uuE8aC7Joa19s=;
        b=fCzEkR84CF14F1eWmttYX8z0XX7aypYEJtDIKFDLA7Buh4yIAr2PQF50ueMBGE1v+w
         Sjyp4wl8frUuIVxuWNIoMwSToGIbBPEKt8BgZytaxG2sK77iSimmj+eIGNDazxmJYK0f
         GJKal/zyjTbIPpj3s+EQuFb4FiS6Bim1sY+1ZMd8lcfQImj+dDofKrdds2ktb+2HvI20
         0a05guA4BpLxi4DUjDRXGOspYDfJUGn+8tmaB0y2buGuHhalEdKqW4XwWVn5qhUZ+ze4
         CfgaxLIz/LOX766oycdeUCC3kpip8S9Dcmy+48uBUCci5QAP3QrJoKrBZFTREZaZ/1mn
         Y5iw==
X-Forwarded-Encrypted: i=1; AJvYcCWSGTTNamg+LZ7dYVyPdPXdYrSa/5aojgLwqy+ZYSrIe0FoFOZOctWbLnjyyECCg5IKa1GVLNO68IqGLw==@vger.kernel.org, AJvYcCWkYcUEbgdqStxSCmd5GOttXttRiEDPgLq1Ai72DAQ6OeROOubl7GNl06bUb7UlrBCAoGg4yqkaN3ogADzK@vger.kernel.org, AJvYcCXf7mSpWW3N/y+hmAu5LzVeX/DuegDvBWtSzlhjqez9budr1IsgiQBWG+BlHx8fEagq31c=@vger.kernel.org, AJvYcCXh5k4KIK+dSq6TJnlz5jEemuHXzbGVE6mnNt1aNyZ/fYVNlt472/3qCDJbz8FMMtM1xdmGzTZp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2BK7KLpZc57mupDK7oJjUid8NoqoliP2ljR4NPJPj2eeyDYM
	Mn3W/nxltIKOBgoUh7X+gmg3oWCyzGft+phtAzoj/DPcejsRsiWxpGzaSTEzA/KrF1m7QXKQVTA
	IR0c0Xhre5qbxAarOF3pCgre0Ig8=
X-Gm-Gg: ASbGncur40QR9bxh6NY27JKvOnU225zwpc66NzHdZoFq9E8IHTV6cxpJe2ShQs7N2gO
	DhzxT3aiR/2VBcHyl1dh5XLgYVPFg8owBmXMgoE3lZ2mvqx2f1a14fUl1KeBFxXg6sLJkrg1O5D
	Vfe8qzvOH3r8l09NEu/uPHzTljPg==
X-Google-Smtp-Source: AGHT+IF64cWC9gfTaAH9nbRxd61iq3STl262vSnnGbGAc6a0vV8SEHh3bvNqAboQJ1MxO1wZy49YFNltdpP1jiFlTNQ=
X-Received: by 2002:a2e:8612:0:b0:30b:e440:dbdb with SMTP id
 38308e7fff4ca-30d7e31c966mr6964931fa.37.1742541318821; Fri, 21 Mar 2025
 00:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
 <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
 <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com>
 <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com>
 <CAFULd4aHiEaJkJANNGwv1ae7T0oLd+r9_4+tozgAq0EZhS16Tw@mail.gmail.com>
 <CAADnVQJ56-W--rdeRyRSXVjy5beQpt5scuRuTK9nDUPqdjMQ=w@mail.gmail.com>
 <CAFULd4bv+j8qomULWzcU_SV8zPtvxefFN6NgPu-WQiHaTR8HCg@mail.gmail.com> <CAADnVQ+Aq85fJJGkurLopdAwjyTEnXAb8=u-ni6mjm-swpEYjQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Aq85fJJGkurLopdAwjyTEnXAb8=u-ni6mjm-swpEYjQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Mar 2025 08:15:07 +0100
X-Gm-Features: AQ5f1JqN82mhl8vwRIJQ5oI9zEyzrJGVtHtWZd0bQsy5ilCBRV6I9WjA2cH_UVc
Message-ID: <CAFULd4YCQyYQssE0egTXMTcTX8whT39VTBVYZy6nwxKLiMGZjA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 12:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> > BTW: You can use:
> >
> > --cut here--
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percp=
u.h
> > index 474d648bca9a..e6a7525c9db9 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -105,6 +105,10 @@
> >  # define __my_cpu_type(var)    typeof(var) __percpu_seg_override
> >  # define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force uintptr=
_t)(ptr)
> >  # define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
> > +
> > +# if __has_attribute(address_space) && defined(USE_TYPEOF_UNQUAL)
> > +#  define __percpu_qual        __attribute__((address_space(3)))
>
> I see, so for undefined addr spaces clang x86 just ignores it.
> Weird. But ok.

It ignores undefined addr spaces in the sense that it does nothing
with it. It has no effect on the access to variables in this addr
space. OTOH, the compiler still applies address space checks. I plan
to propose a (RFC?) patch after rc1, once the main part is applied to
the mainline, that enables percpu checks also for clang. It is in
effect just the above couple of lines.

Uros.

