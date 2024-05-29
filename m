Return-Path: <bpf+bounces-30875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243E8D4107
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6491C21D38
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6116F0E2;
	Wed, 29 May 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcaAp8G1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AE15B56D
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020190; cv=none; b=VHT8oJHnxCH4NdJh9FGgexGyWF1fWHdvdpq1QutCwpcuEGRu6umuI0BtSBwq/HS0SXX0+PLPBt1/ywO9fyXS6V1UlSKGoYWzmqLZaBuqyBlRLXsvxfb2CGZ7tMLeiWPggjPHeZpnHGjGsojNgb8B4KqP3iPvdgT7cMuX4tonKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020190; c=relaxed/simple;
	bh=0i/qZq7Q7C0oJEc4T0Oxl1fF1up0RyuSzgm75GAdM90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF7jzR5niF5CAv1NSOI1fHtbv7JZ1TCCNGrRHEY5vuR64TbId+b6lcnFbK47GhHpfwzVAXzjxY+zV5rNmIYU9Nf94K+J9MYL8nchkf8TLC0R/zmEpfjjq2Z6zU4jfzyFuZ5pjeyBP6p/pSDlNzYXUAHh9mMk16a44+QLq6zzHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcaAp8G1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62027fcf9b1so1961417b3.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717020188; x=1717624988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r3FrP6pjIEHwgqXvORVjS4ffIa5Tf9VSy8ZZ74J3JY=;
        b=UcaAp8G1HFBwF/b5W1QyMVYsWGWST6kIgeP19DOAxUDVcj+oOWE1vTqSBB/6aqV2nr
         Fvb6afMAbk/0r4sDFBfqaQ4Eq2hKLIUcvI4ddhUG99R58cuggogOE6DGN8M00nK9U+ns
         pp9Tbd4FIuN0MbE1k2kWWJhiYlZfSHKRwwB8ts5qdsq4lbHR/G0ShG+NyJhIKJ00MrmZ
         1KW0PjtPp3zY84Ps64vCsNBckCNEN2fgNiW6KEF0ZikAcdl+Nymuj3T87wilHTVPGA3V
         CZyNRfcnZcE8/4Czh/yNtUCHNpsQuwwgPV+QaI1amPS5cnv2fIiXHtoMOG4dycaUgqDo
         KK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020188; x=1717624988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r3FrP6pjIEHwgqXvORVjS4ffIa5Tf9VSy8ZZ74J3JY=;
        b=IiiGArGeuJKqdNr5T6nq4yLG7pTXh60Qj4uK0tgVwTB7U9OxTCYqHeoJYTCHxw9GGf
         OcqpJDr1AKfoLJs+0hFavEJ4X4+5nWSzjVU9/d+jdJ/K5CEIoCtgAElHMkwWiq71KeOO
         6OMWjWJ/jlskb714Dde1DkgpvUfUO6DgeQO7+79dcT5qvQAG1pBINOz/g41/iAnbgIhw
         NUu214QEamjMTI0awvD8nF1FEdATbhr/JwnoVKkj9RZnyMd+6jS/wP8b8F+u80Khuz2F
         HPLAbOgoyhB1Xbw81OipIgFokF+gWdORT5Vt5lxFXorbkrzc3Jbn44t1SWbWb4Zls56W
         cAFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0QxcAsZ7ubB0kc6L913BAq6wW5aMYSl4MKJovIBSsjVcmmsr4z5xDld/0mcyJ8nI6A4IRL0plX4f6klwYofVLNUuy
X-Gm-Message-State: AOJu0YxtPfAidmuOLQhRuzqzP125PD37CHrpjBm3+5ki3JbB0q6DktqT
	Qw7kcnopVji965Sjqy53JzUIJlLFsq6ZDNcVQ5Q/A6D/tsyP5prw7T3HQdDC//0qvoze0950lTi
	fWXhAZyb4Zv5QGXr6/F3eCshB28I=
X-Google-Smtp-Source: AGHT+IE0NpjJmTmVn5AwizilZZchMA6NdpSpOgClgNtteJj7HwlogrrIdGtrXqzegOataXMgEkRlNX/kaW6fKlepB1o=
X-Received: by 2002:a0d:e296:0:b0:627:a505:9295 with SMTP id
 00721157ae682-62c6ccd9ba0mr798807b3.11.1717020187708; Wed, 29 May 2024
 15:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
 <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
 <CAMB2axPh4T-8yH-S+BryxQ3vp1Cpjrf1Zgv8rbbo2m+zRML+Dw@mail.gmail.com> <CAADnVQLm-OQAsxbocyfBcEiXnuE+pMGW1eM_W+58s4yDHEtOZw@mail.gmail.com>
In-Reply-To: <CAADnVQLm-OQAsxbocyfBcEiXnuE+pMGW1eM_W+58s4yDHEtOZw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 May 2024 15:02:56 -0700
Message-ID: <CAMB2axOfHS=1+_ifOtGDM_tmJR22PF0j2FPKoynOfFC7pcupwg@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, pgovind2@uci.edu, 
	"hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 29, 2024 at 2:46=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, May 29, 2024 at 2:20=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 8:53=E2=80=AFAM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > Hello,
> > > >
> > > > We are developing a tool to perform static analysis on the bpf
> > > > subsystem to detect locking violations. Our tool reported the
> > > > spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() th=
at
> > > > could be called from an NMI. If a bpf program holding the lock is
> > > > interrupted by the same program in NMI, a deadlock can happen. The
> > > > report was generated for kernel version 6.6-rc4, however, we believ=
e
> > > > this should still exist in the latest kernel.
> > >
> > > Fix it similar to
> > > https://lore.kernel.org/all/20230911132815.717240-1-toke@redhat.com/
> > > ?
> >
> > I applied the similar fixing approach to trie->lock, and then I found
> > the two other locks mentioned earlier. My feeling is that there might
> > not be a use case to justify doing trylocks in memcg and rcu. If you
> > think the approach below is okay. I can send a fixing patch.
> >
> > trie_update_elem() {
> > +        if (in_nmi())
> > +                return -EBUSY;
> > }
>
> That's too crude. Trylock is less surprising.
> re: other locks (memcg and rcu).
> I think it's time to switch the whole lpm map to bpf_mem_alloc like we
> did for the hash table.

Thanks for the pointer. That makes sense. I will test and send a fix.

