Return-Path: <bpf+bounces-33080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6624916F65
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BCD1C230CF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E271482F8;
	Tue, 25 Jun 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfuJVvqM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EF135A69;
	Tue, 25 Jun 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337075; cv=none; b=VWU1C5O8brIYjdp5LaQ/B/hxhwHm6dFi1GRtWm0zZZqBnLS8hLBa1WdSKj5PiBipuqUi9eCckKBQ3QimyxPiR/f4nvbTzvdeo/wWAUEUOQ0/G28t+IUAf98ab8xqWziP5zTtwaJvlT1A/FqiQZViC3SeTqWgIkV6MDdYJ4HcBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337075; c=relaxed/simple;
	bh=sWbDIxWUhgfMe0rbcmtjdWimWT0i90L+5X3Rw+1EfIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7t/do9nrdGivcwPCZW7mKVapcx7i7EVCdCbylLDBcKf/qhOeZ2lt+bK/IAM6+22LXq7bAGrgA3XlEHoz8aemTrYhDQXtYmbLlKBO3Y+0m7rg/MsZzTH+9pNYv0cxSXpeaWr2r+1j9gCJToPoAq7UHU/puImmkOoQ217fE1mZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfuJVvqM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701b0b0be38so4850121b3a.0;
        Tue, 25 Jun 2024 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719337073; x=1719941873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWbDIxWUhgfMe0rbcmtjdWimWT0i90L+5X3Rw+1EfIo=;
        b=kfuJVvqMNhW7vAwfuHZj2Zbpoa7dIF1ojC9znLZI2lEjxE2rlKInVRPvmDSNtNMdCZ
         6bVkx55Nu9svsEYjLnbatdmXl/k1eU1c897wE+xbJzp10pL7G6chD2fozfl5mql9Q3Nb
         ec+J1jp1mk84qXrWEouW9ybXm+rGPZoahTTeB4RBnyy0OtkJnI+DBLuSo/sMmMN5ty3B
         02+esousq6FwjlS1zFbpqlk7LHO5t6Gq+1mCcysZhooHD6vi9DgBsRfIXpXk5QilROv7
         7XMBso2bClx1OXyCq6B3/r8jPq5kr0WC4lCX/u8CDeq4Ipo9DdAqA/gGifP8ebe2p98f
         b9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337073; x=1719941873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWbDIxWUhgfMe0rbcmtjdWimWT0i90L+5X3Rw+1EfIo=;
        b=ANDsXb6wqu2nU7QpJB45F6eTPpvs2KhiUY7U+LWBVKmfYO448JzjcmZ21tHWIxndD9
         h6p51Sq5eafce6NObZcy0v4vD5AVfZBqSnQi4Wka5v1q1ZPauEiCuzGaYYIhTF+Gn7XN
         Gq/Bm1yRjbuUbzZjdZ0Nmlno+i9BvkGhclQQBDbFH63D2TTuIn/QhMlNXdSFNhLhjhQD
         e+8uYDzHWTpj5yD+o8MyZkl98mkeu8N4W9ig9w2EzywQ2GCttQEMKThLDbAEGcoRzfSY
         2wgbBpgqAfPAaleZxxMbiJ32MQvUau43bGRfFSZm8hTdCFlvQnjequTI+g3u139SgoIf
         VNDA==
X-Forwarded-Encrypted: i=1; AJvYcCW64XNcCMmBW98IBW3AEMbOGza9v7VJXJmaHJakSBNGq68GCAlztUJ7URqyqoUZXSZ4e0/aGf8wK9wkgOzdx7C8yzwhPpXyFb/brGvuT43EqbKsLnEh9mlNOpsVNzA3ADIhfA9QzDM7
X-Gm-Message-State: AOJu0Yz3htO/wmQ0qdSliVzhjwM1oNACpSc8n6UGJDf5Kiq6MbydxILV
	91rwKUnsa9FHAcoSS+nvzfafuSV6ycStx2wscTl0QRauca30mqAq7+z4wbmSuGf/ow17bgdNVd1
	KVCpmRKwRb1zsUVTveJ9LzfEN23CBaiEx
X-Google-Smtp-Source: AGHT+IGGQ+ALCm1+FH9483pK84qeODuVCdr7dHOQVkKpn5icgbQ1v75BK0Th5ru0ixbH6Pl8Q6wZUkYQFZNr8lGJcgw=
X-Received: by 2002:a05:6a20:da9a:b0:1bc:e771:ddc7 with SMTP id
 adf61e73a8af0-1bcf7e8294cmr9746218637.22.1719337073310; Tue, 25 Jun 2024
 10:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-3-andrii@kernel.org>
 <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org> <20240625144952.GA21558@redhat.com>
In-Reply-To: <20240625144952.GA21558@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Jun 2024 10:37:40 -0700
Message-ID: <CAEf4BzZqGNVqAmk_wrGP+MmxQidEr4=FdYiYpodpRd1TAib81A@mail.gmail.com>
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 06/25, Masami Hiramatsu wrote:
> >
> > On Mon, 24 Jun 2024 17:21:34 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Given unapply_uprobe() can call remove_breakpoint() which eventually
> > > calls uprobe_write_opcode(), which can modify a set of memory pages a=
nd
> > > expects mm->mmap_lock held for write, it needs to have writer lock.
> >
> > Oops, it is an actual bug, right?
>
> Why?
>
> So far I don't understand this change. Quite possibly I missed something,
> but in this case the changelog should explain the problem more clearly.
>

I just went off of "Called with mm->mmap_lock held for write." comment
in uprobe_write_opcode(), tbh. If we don't actually need writer
mmap_lock, we should probably update at least that comment. There is a
lot going on in uprobe_write_opcode(), and I don't understand all the
requirements there.


> Oleg.
>

