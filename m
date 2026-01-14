Return-Path: <bpf+bounces-78897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA69D1EFE3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 694BA300FEE0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A6329C40;
	Wed, 14 Jan 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXHFx6nR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750839A7E3
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396308; cv=none; b=X1yrlShjnuRKZJ/T9Hc9T5uWwi52kjdTVQ089W9xPXchV2GWpIXp4TAl8ZVzYS1P15n9kobBT1PG1/LTdUVPpUSKX8ldd/PWCxL9E4JHG2CkScmqDe6P/iRAE53cLt2jesw9FheyN+zePrib0Zsh0DTJBJ/b8+kGMRfg89KEuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396308; c=relaxed/simple;
	bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liNtRZH2fdgF4Z59oKCuvGYZVG4igbJ5RArZxGct3Mnsa2B99DwGsyEhrjSS1tELyIFmqirnmoNJ6Qz2ZTYS4ylhP0TBVN3fbJTnv8NjWUZHFntHY3w4lWlHUTAE26hKdYHfzlp5hj6gTChTjq2oLgI8mqBT3PVOsWDD4zQ3JD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXHFx6nR; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12339e2e2c1so229441c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768396303; x=1769001103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
        b=WXHFx6nR9OW4tTgf5X7xeWn6liiukLqrgWKK/xiTunbljcucpob+NM+TD7mgqTQHP4
         5tAxafAARed2fFQYxa3jo6WElVgIsjIBFFv++nbe4yDmrf2/cfGNwFE3h86eAStt/rMo
         gqNlRqTZFuzY7g3GmWxQ0B5tWto1YdhyvevVpLnlMzfd+07w2WZuZ1JFUZoDMlJ6L3BJ
         MkNNA8HdJ1B/MuNgAVEdc6mwgX/VD990qc+ddyAy7CLFV7QUqGghesudeAUJ8YkVdqTW
         QQ8Url4FT5e5YnWJAbAOpg68k5tTXhUb1QfO1JK10m6TXQje5v2skokJWYW8LrTeq9eK
         TuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396303; x=1769001103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
        b=hScgV6IGD5TtMuoeAZ2/QJxeisE1zViXio95gOrHZhv1EzHjFvoA6tbP7RiXKiNfcW
         +Xd8Gr2DOmI0FCws8vDwdFZCrtl/qhaEDmI+153TON72H5UwxIEVLF2M6tgnY36hyNna
         wueh2rK4etm/0h9cWSi1rm0Da1npJJ88pt1d2R1yQ3mOLOK+KGgASyQPRpFURD2O8Lnu
         m002/BHa+rRgn1LXEaHn///GqM5jJftrZPzthuFb0x0ilTgLAqkqafA6czS4Kb/s0XBK
         cRFI7YqgImTd6qJMPSSNDpwaVpur9WsiFjDvJ21KSIAZgrt4RvFQEO7QA8KrL8M9r6sJ
         MNCA==
X-Gm-Message-State: AOJu0YwzkiqUH3upIcrZX7izGB+0E52Q04CjwuBIltpfOsM+869evF2Z
	tj+kRsKeDZdV6JM/CFyix3WWXuY98HkP1Nxmq70Sos4VGdD+EW5/fOTTPFqy8xxEiV4h20j3YKZ
	Yc5oxeOwpmP1UGBUbIeG2y5Rw7DtS/vU=
X-Gm-Gg: AY/fxX42dDOmpQBMiLljolHjR76JlC5hjY0QPxxoh4uznpul2UN+RrjoHPcDC36bQOe
	cTd13a9wk/4I67zR1sdAK5WnLWGlC14Mn1+a9Gu/D82UyHRTMcKJbEnZxAPbmMFpIBWzdc5tP3w
	GGTPKNZxxf2HsVAbWktpgunjAM4XiQqgifBCaN/4gMikTzFf9A3KFvxZbuJomILrLilZsIA4slr
	lrEchE1NfQAsKSYAhVUmY3mp+CDFIYGA5GHXNrswYdOR8iWuQ4o3XRLAmGFcU8wm34NpF/p
X-Received: by 2002:a05:701b:270b:b0:11d:fcc9:f225 with SMTP id
 a92af1059eb24-12336a65e2bmr2402424c88.14.1768396302957; Wed, 14 Jan 2026
 05:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk> <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk> <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
 <87zf6gz83v.fsf@toke.dk>
In-Reply-To: <87zf6gz83v.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 22:11:31 +0900
X-Gm-Features: AZwV_QheH6G9P1GonO5Q9REYqYagJIDa-HYE9AbETr0z5N5bAmfXkid9N1D2HmU
Message-ID: <CAGF5Uf6rsR1swHUs_0eZUAt-cCJVbfTnHMM=OM9JvQCkKUu-rA@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:34=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:


> >
> > Thanks for the pointers. It is really great to see this series. One
> > question: Would adding queue_index to the packet traits KV store be
> > a useful follow-up once the core infrastructure lands?
>
> Possibly? Depends on where things land, I suppose. I'd advise following
> the discussion on the list until it does :)
>
> -Toke
>

Thanks. I will follow the discussion.

