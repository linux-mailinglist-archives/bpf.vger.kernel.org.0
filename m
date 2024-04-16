Return-Path: <bpf+bounces-26985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A638A6F77
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94270283E4B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B2130AE7;
	Tue, 16 Apr 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/DbuuJV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCF131195;
	Tue, 16 Apr 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280576; cv=none; b=qg45Rgquuqm2QVIbZeg1U8zP0rBaD0ncBLYMZ6eJFi32R2/U4GkCqc45ohe0cRPksC1ubMvrYpG2Lf2PEwQz0jd5xdurd6xUp8iRxPsvfR+1Xx81Ya6tFOFQze33qK0guC9XXQre/TRu/TXJtw0BBeKS7jm0tWRB+eszvqNB1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280576; c=relaxed/simple;
	bh=8JSmIW6AisC0YGxh3A+gqhVtexddPmiOclf8d6UXDT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOMmxQBIDnSd2tRELO/oVv18UUEWN31fp7R6sWepRp4zhC+MawXuVJH8k5QrIWKrcyASg4HpabMnKc3pk22SjKEH4NjcYELwlPbBSbLr+H/LUL3pqYdJ1tMMEQk0oOxBhddeKGs8jzWpwDTz4TkCt2En9ev8ObRgNAWRNzeFor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/DbuuJV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34388753650so2093317f8f.3;
        Tue, 16 Apr 2024 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280573; x=1713885373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JSmIW6AisC0YGxh3A+gqhVtexddPmiOclf8d6UXDT8=;
        b=Q/DbuuJVW1xPZFx0ZONTjpKakpFzxfGzRkJfTzaJ4H4rP8jhBin/e/pLJcImw4ExzH
         1jQDdTDuYywJuSrxMFRjd6kM+AiP+grCsoQYrKT4n1LvbTOeGnPUcB6XRAtadHHXdaoM
         CZYyUe8pqLbtChrgDmiYMBRS1TD8mS45sUt0J8Pgb/leq0Tu1EWPAfYNUAhFLfhaaihH
         7FSu/MC/jf1zpfZWbY0JIPmlg1NnaHYTKfBhj6Y2FMOj6/HV+HJ6AvlzmyQWFx6KW0pS
         cPutLy330A32Cj4nzxJ4nglynYHqK/Uo4hJlMxr+8K7z2oHtU4990o0a7rjHFYZM5b2Z
         cGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280573; x=1713885373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JSmIW6AisC0YGxh3A+gqhVtexddPmiOclf8d6UXDT8=;
        b=buGH509nPtCa6MYgCHWYXLqRUouQtDmAo87zSqZQyS0ZRQBbxlJlnWnMc1qDuKngh4
         bDtN5ySnZ9oq81K/crzJggJru+z+YOKGQtuxBYykMI+tgC96VRoi8aSZ5drRJ+HrB6w3
         297MHAsFj2dEOE13EqhukSZ7cS4c9HZj4TvTi7OfWBBqitMm/aevJuXjM2js+/t3vmxA
         8uCjhHx6xFMDtx7rrkXa+CDd+f3DZSpsBx8j6cLZNapj3xAgQWC69FVq7DQ8Y2BZdlie
         N2KiApA4Tu3v2+hheVDTiKUjeGeTrVnX7/OTWBQaoRK4YMxzqohvM/DITIqgIEfauyYq
         zsog==
X-Forwarded-Encrypted: i=1; AJvYcCXFktKhLoQjbKh9uiThrRLkzTunLOQeZvcQ/avVW7HCsIAI/15mqiAga4oPRqAN1URHnEh5tq8oI9qH5XTf5l7T2YOL6rZy+KMXAaKZ1HzVcaTWYDHW9DAqubES7gG60/Ix
X-Gm-Message-State: AOJu0YxUbOZBO8ZLIyZxbeuqDHKOtvrDmFVMc9v5dS/kwqHpwTjh+7U6
	kbfbvXmK1Ag96vacfVj49yqnch4ZIW6zq5Gqwn9FO5ye0y0zeAf/pmRsGx0UyDLwu0nyxMeOsLT
	mcp6TDB4Fc6M/qol9WNPTRlcYZ7UTgvSP
X-Google-Smtp-Source: AGHT+IF8Nl0MMpxdCBz7YOuqSPmL6zOTDD6DeortoGI1yNBvpT1TYwnUZsl3dePdOGnb7RaFfhoArAxG453LTbO1ZSg=
X-Received: by 2002:a05:6000:4c5:b0:346:ba70:f262 with SMTP id
 h5-20020a05600004c500b00346ba70f262mr9409969wri.14.1713280572902; Tue, 16 Apr
 2024 08:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fe696d0615f120bb@google.com> <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
 <CAADnVQ+E=j1Z4MOuk2f-U33oqvUmmrRcvWvsDrmLXvD8FhUmsQ@mail.gmail.com> <CAG_fn=Uxaq1juuq-3cA1qQu6gB7ZB=LpyxBEdKf7DpYfAo3zmg@mail.gmail.com>
In-Reply-To: <CAG_fn=Uxaq1juuq-3cA1qQu6gB7ZB=LpyxBEdKf7DpYfAo3zmg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Apr 2024 08:16:01 -0700
Message-ID: <CAADnVQLUXVV_viC7mmm6VaAyveQKMzibdCMpnUQdf_-3FdjM7Q@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
To: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:52=E2=80=AFAM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Mon, Apr 15, 2024 at 11:06=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi,
> >
> > syzbot folks, please disable such "bug" reporting.
> > The whole point of bpf is to pass such info to userspace.
> > probe_write_user, various ring buffers, bpf_*_printk-s, bpf maps
> > all serve this purpose of "infoleak".
> >
>
> Hi Alexei,
>
> From KMSAN's perspective it is fine to pass information to the
> userspace, unless it is marked as uninitialized.
> It could be that we are missing some initialization in kernel/bpf/core.c =
though.
> Do you know which part of the code is supposed to initialize the stack
> in PROG_NAME?

cap_bpf + cap_perfmon bpf program are allowed to read uninitialized stack.

And recently we added
commit e8742081db7d ("bpf: Mark bpf prog stack with
kmsan_unposion_memory in interpreter mode")
to shut up syzbot.

