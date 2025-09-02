Return-Path: <bpf+bounces-67206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AFCB40B35
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B5D561933
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6413340D8A;
	Tue,  2 Sep 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daUFPnYt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58931353B;
	Tue,  2 Sep 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832076; cv=none; b=QQ373korwxBH44o4Pqw6QkuUUUvpL/vDBAy3pLfW6MwnDXBRlLWA0kekevc46psxn5sYFKrov/hdPY9sIJlTfD9MraDYcdH3TQg2VnTb3uP5+cTie7H2kF8oTDg36cyKUzd5gz5xEmR9Qv4sZNBwXC9tl3X26rK9iTOowCu3ThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832076; c=relaxed/simple;
	bh=CHG2gt25cLFb4Lh1xBkNyzL4RKXfc6SZYoTnmNprWXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fks3vjB2b29ncFxFsCyQv8f72+Rn6/8xfj6titY4XiVSMAhNQYUx9Ke0xnE0XUgFhz3VeC1MnkxMZ4+Z0o9Z7NWYBJYWWcCSMcrM6/vuWNhXgv6f2asz+YtOZaFidltK1KTnIGKU5V6s3zpuxAu88DXyD2TNs4bv1/WLdcgO/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daUFPnYt; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ea8b3a6454so419455ab.1;
        Tue, 02 Sep 2025 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756832074; x=1757436874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd7SYjkGLCDXV8sOUNsW1gZmfkcFB2xKeMtakWXaoI4=;
        b=daUFPnYt+ZsHKIRBE6lFxxiQCKuyisnhPAO1mj6rsZ7D7k0jBoNen8Rr/P5XqILn/6
         JBhRLbBjL4FrTTAeweQrsePeDD6PTlQf5Xx1tTjl1beyYL5vpj1IxEKbonf8nS7vfyYi
         cTQY0Emax45PUxJe8MxQRs5Ufh0P7nU1BytULNcDLtk18hVtzL+7x9456uadKBFVxK6y
         xZeYX64X+jmF8fjES6so2qtVHIRz03v2WgM1mlEU7C9q6tDlvPDv3XHBpDewQt8UD1O9
         4sDDbpno5nCzpNb1rsb94Y4jyxa1m5XKY4/arb/AD67jpctjVNS6M7kI+U/bgRv3tKaV
         cuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832074; x=1757436874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd7SYjkGLCDXV8sOUNsW1gZmfkcFB2xKeMtakWXaoI4=;
        b=t+QoJASxX1AqFrlq8x5M1Zl51P3FgzAuNOCWmPCEyNw1+KqFc+7VUEkImU9ueDxEXE
         oc+R7omCbR/XYFo8g9tUDy46mGoKp5cezbQ8rKs1OnDFth2elaMPJYTzDuPFrVFEQg4H
         O4GLeVa1gLfqsLa1BOStQAL3HOt4DyMXaP5eNmNtBKjSEgL8EyioqZetz5B9DFqQt7pa
         Hmh362a5PyI7hJi4XH2Jw3PufzcI9nN4cngUuvSoLLHJj8U4x+djhKopa+mbLb7OEXPe
         mezWYHWGIOrU/ap4O6VF2V6oYEJfzykYEQVgewLZM14YqZq/dXjGvaBiUnRxv42HJfKF
         WTAA==
X-Forwarded-Encrypted: i=1; AJvYcCV4pBrKSOSEewKdruEQz2bqVSZQ6dF9Q0sVjrI593n3fwAn1Yo0ZxuL9awhFQu6G6URejs=@vger.kernel.org, AJvYcCXDQeL3AVn7/2foWIgIgPzBQhY4lQ5VEsi2tKQzN0d4QK+G8mXyzFts3Rq/3lHbpDG0IgX+wBRp@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrcSkYRAcp7vNidB6hGT9133s3ItYBIpFRZcTuT9pAGzFk5nP
	D94KlPbS6rohhjCgQBhdfcbiDNfqgVZr8J2bmfS+d6wZo3BvJ1w+5kgRIPavO5ZDq62pQKZ1LEc
	TDrYJGrrxOF85dV3fR99lJlgB7eqR1MpqlOekJb6ACg==
X-Gm-Gg: ASbGncukBVJcIIxXUV44F+Iszm42x/UGcqoohto9P3yXfvf6+a7ipJc/GZGg3Icc5nA
	hxKwGqDh2moKIFbZ6kMuBdYsakmMlqbbZOCSzRbOrm1RD1UP3nd3PvmQz8VrRBEwdUNTE1qaIcu
	XjNbEdw6r0TjBhIA1sdV48nNuQRMDezft8zfC84Xc7G9M6ULy52UNHTprdoOO0GuFJ/OdOMzz4i
	R9MfvkZ1+ZEqTl68g==
X-Google-Smtp-Source: AGHT+IFHUDYdDmsqSsp+8hlN5MZJfQiguEWD2ztygF0ULyA6ouJsnC9YN1gma/qlzDQzVRI491v98FiBs2vhCKrxwR8=
X-Received: by 2002:a05:6e02:4711:b0:3f6:5b66:b5cd with SMTP id
 e9e14a558f8ab-3f65b66c0b8mr27157345ab.6.1756832073878; Tue, 02 Sep 2025
 09:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
 <CAL+tcoA2MK72wWGXL-RR2Rf+01_tKpSZo7x6VFM+N4DthBK+=w@mail.gmail.com>
 <aLYD2iq+traoJZ7R@boxer> <CAL+tcoAKVRs9nnAHeOA=2kN3Hf_zSS5z64yUSEVmtiS82zz3-Q@mail.gmail.com>
 <aLbNNInuSjkC5qbI@boxer> <CAL+tcoAiY1_OvVAJwWj-YwWY3_9QOWQ_Dwsn5V4vy+wnOQJJog@mail.gmail.com>
 <CAADnVQKOwfFsccUxC1MmtdETkbEw34MaV+YwV=f4vssP=+scVA@mail.gmail.com>
In-Reply-To: <CAADnVQKOwfFsccUxC1MmtdETkbEw34MaV+YwV=f4vssP=+scVA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Sep 2025 00:53:57 +0800
X-Gm-Features: Ac12FXx_CUZdyn221gc2z-fsFixpqKdzobexwvGkkMEomfrJMAFGCzCewEJN73o
Message-ID: <CAL+tcoDn7HCW1+t0bceDPr2D-Q1EcSqh91eG3HJ+CjiLdX4Nag@mail.gmail.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 6:39=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > > > > >
> > > > > > > +               list_for_each_entry_safe(pos, tmp, &XSKCB(skb=
)->addrs_list, addr_node) {
> > > > > >
> > > > > > It seems no need to use xxx_safe() since the whole process (fro=
m
> > > > > > allocating skb to freeing skb) makes sure each skb can be proce=
ssed
> > > > > > atomically?
> > > > >
> > > > > We're deleting nodes from linked list so we need the @tmp for fur=
ther list
> > > > > traversal, I'm not following your statement about atomicity here?
> > > >
> > > > I mean this list is chained around each skb. It's not possible for =
one
> > > > skb to do the allocation operation and free operation at the same
> > > > time, right? That means it's not possible for one list to do the
> > > > delete operation and add operation at the same time. If so, the
> > > > xxx_safe() seems unneeded.
> > >
> > > _safe() variants are meant to allow you to delete nodes while travers=
ing
> > > the list.
> > > You wouldn't be able to traverse the list when in body of the loop no=
des
> > > are deleted as the ->next pointer is poisoned by list_del(). _safe()
> > > variant utilizes additional 'tmp' parameter to allow you doing this
> > > operation.
> >
> > Sure, this is exactly how _safe() works. My take is we don't need to
> > use _safe() to keep safety because it's not possible for one reader
> > traversing the entire addr list while another one is trying to delete
> > node. If it can happen, then _safe() does make sense.
>
> Jason,
> sounds like you're still confused what "_safe" suffix does.
> "_safe" doesn't help with concurrent access at all.

Hi, Alex.

Quoting Maciej to explain the function of _safe(): _safe() variants
are meant to allow you to delete nodes while traversing the list.

I meant the _safe is not needed at all as I explained above. The
af_xdp logic makes sure processes (like reading/adding/deleting) nodes
of this addr list are serialized. So why add _safe here, I wonder?
Just remove the _safe suffix then.

The moment you jump into the conversation, I feel I might get stuck
somehow, but I'm not aware of it... Please correct me if I'm wrong.

Sure, it's a trivial thing because it has no impact on the whole patch.

Thanks,
Jason

