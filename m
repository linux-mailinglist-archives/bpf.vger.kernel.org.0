Return-Path: <bpf+bounces-33368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AF91C3C8
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF201F230D9
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F82F1C9EB9;
	Fri, 28 Jun 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amqSYrmu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAD27713;
	Fri, 28 Jun 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592480; cv=none; b=dZB9W7/cxtP622MwUbe5rlMc2fxKhBZ+fNNXrdP6W3EH4b2W6PWoXDxnymlHCSpC/Ru1wonrcEWLJ+6aAbBJfZ2Pn6o+2mvgNTAvKpVoEz7247lrQyhjvW5vkyTR2xrKkigxD3qfEP+6zV+2KP3hYWq66I52fxsranlron2sMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592480; c=relaxed/simple;
	bh=znCzwlFobyfBO2MbybTMkVatV1nZrL2UNgmpPkyX9tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErqFbrbk3DKn3nQY1oWG/sCPfkMHHRA4X2XbhFDNf9QPJUkGeFf37PJqSBetsAxMVZHGRYVq4d6WYNFK3kZS90npH7yj8UX6JfLe4/Mrpjnv+7Se+kIrGr1wYacICBIYMr5crWGWeDlVo6DVXOY+mEfAqNiiR1bIgp1ELFgE7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amqSYrmu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-656d8b346d2so532346a12.2;
        Fri, 28 Jun 2024 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719592479; x=1720197279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZR3HG0KPtFjFEAuIDOxaF9EEpQn7U1Qh+XfY7fmwtc=;
        b=amqSYrmuXkCQHBcrNNNuwiKn1Ye5Z413Ueoy8COsjG2svV13aHZ3vxId6CRVka7fZH
         5yBc6Xz290T1f4Qx1BNXs9DksS6Gl3obDr35AWgQHg+I04gImVGSFr0SBwZBT6c7IpJJ
         ZksU1MEPbxI5ffB3wdSedlZIDR88hW0jTwwCX9UsWIMvchKlOwDxb3SVMyTyjiTgV1bb
         j8mvPDjaG564M9gcAPK1nSaAIeNhge7+5fI37lFkBAMm5bdTc7MxyB+gf86Q9srPMdcA
         SZLGaHUekJVYLsx0rkYJGN29n7w1i/wXOinVTjQjyWXpazU21ljj+wvj0/fbr2LLfOBx
         l2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592479; x=1720197279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZR3HG0KPtFjFEAuIDOxaF9EEpQn7U1Qh+XfY7fmwtc=;
        b=izZwxZyC/EzFoT/ofdVrSCg61D2HCj/EkuO9zT6G0fCK7Dsqu0nQ/1+/kBZinLA9Hg
         JE+SoqIE8F6V3chkTwin1WeqJtxo2UbGyywzJtLowY/xhFJuMtrztvitmqXCzfdaEMJL
         6oPMitcmSZ9EDIigudtd273frunXXz46tAHm3Q55l3byss+l18RKz8VSDWa3n5Us8aqE
         hEOTTuIY3DJxKKqc7877eBqD2GmfUex+zfKjZYVeIoskNAHJkC9J3ElPG0Y9ig5+iQ7N
         M+X4IlxwIRP3srpdrSkc2yl9oxuwexgyOgmUmCmm3PmQ+DYNd05ZWnX2wryrrs7XczLk
         H/hA==
X-Forwarded-Encrypted: i=1; AJvYcCWzcBrYBMZSy+trE2mYuKLkxWEqMuUDu2zJ+OcHeU+/CraIUSqBvaXP+Qd2X90/298x0DAKbwOkgMSd5O7pXh5UYs4zh1nZowy8Oe4qqPwcAHt8Tzil5QpYh9ohHW22T6WAYK5sGiD/
X-Gm-Message-State: AOJu0YzOHRbT2H9FmQ2FUNrLX5XFvWyAhwkHv5VPWzEQo4FLuktFX6gf
	TTQjEGsklnO+cAWUzrleeMlK9QVsQOhW6/d7CJbt5fgS8BqidFzecgUZnHEKBOafIj8Mo6qHI06
	caMb0XO3nQJswOa3gZiclsMCP4wA=
X-Google-Smtp-Source: AGHT+IGzYlN7WQA6sPNBHf2zVMZZfTWYCrWnfjcbfSalrQqJXB10ApcaSBPLOOzWD7zojjtZKsGzmNHUH+ZPa0/3Q9Q=
X-Received: by 2002:a05:6a20:9692:b0:1b4:1560:f80f with SMTP id
 adf61e73a8af0-1bcf7ffaf67mr15356522637.56.1719592478833; Fri, 28 Jun 2024
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org> <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
 <20240628152846.ddf192c426fc6ce155044da0@kernel.org>
In-Reply-To: <20240628152846.ddf192c426fc6ce155044da0@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 09:34:26 -0700
Message-ID: <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:28=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Thu, 27 Jun 2024 09:47:10 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Jun 27, 2024 at 6:04=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > > -static int __uprobe_register(struct inode *inode, loff_t offset,
> > > > -                          loff_t ref_ctr_offset, struct uprobe_con=
sumer *uc)
> > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > +                       uprobe_consumer_fn get_uprobe_consumer, voi=
d *ctx)
> > >
> > > Is this interface just for avoiding memory allocation? Can't we just
> > > allocate a temporary array of *uprobe_consumer instead?
> >
> > Yes, exactly, to avoid the need for allocating another array that
> > would just contain pointers to uprobe_consumer. Consumers would never
> > just have an array of `struct uprobe_consumer *`, because
> > uprobe_consumer struct is embedded in some other struct, so the array
> > interface isn't the most convenient.
>
> OK, I understand it.
>
> >
> > If you feel strongly, I can do an array, but this necessitates
> > allocating an extra array *and keeping it* for the entire duration of
> > BPF multi-uprobe link (attachment) existence, so it feels like a
> > waste. This is because we don't want to do anything that can fail in
> > the detachment logic (so no temporary array allocation there).
>
> No need to change it, that sounds reasonable.
>

Great, thanks.

> >
> > Anyways, let me know how you feel about keeping this callback.
>
> IMHO, maybe the interface function is better to change to
> `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> side uses a linked list of structure, index access will need to
> follow the list every time.

This would be problematic. Note how we call get_uprobe_consumer(i,
ctx) with i going from 0 to N in multiple independent loops. So if we
are only allowed to ask for the next consumer, then
uprobe_register_batch and uprobe_unregister_batch would need to build
its own internal index and remember ith instance. Which again means
more allocations and possibly failing uprobe_unregister_batch(), which
isn't great.

For now this API works well, I propose to keep it as is. For linked
list case consumers would need to allocate one extra array or pay the
price of O(N) search (which might be ok, depending on how many uprobes
are being attached). But we don't have such consumers right now,
thankfully.

>
> Thank you,
>
>
> >
> > >
> > > Thank you,
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

