Return-Path: <bpf+bounces-41946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D699DC3E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068831C217FB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1A16726E;
	Tue, 15 Oct 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPujGV8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14228EC;
	Tue, 15 Oct 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959166; cv=none; b=nQHD2o3Oh3XRUjBdYa8cHMuhDRyBvYxhjtsGzdq35q2j0lenHThi2QxM+Z102B76Y5H/g2roOuM9VrTFEDp7+/vJbEjgMqr9nY+1KB+Un6407qR7cCBn9leN8J/IHualmHZhJVvgGsKhTVp0JSNdHYCexGQEPgQReyooJ0NsggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959166; c=relaxed/simple;
	bh=wxGednXltcfRZAhjYz86U//pyyQQZpCr2rX8dUngRk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5a6N5lzj8mAaB6ijhMGpAkvpC1nbj/ii+2E1EQin01OaaB7Euu7g47nant2TFjOCy7pUz9ravS/STekR0Kj4cHBmOv3uIOdJhl5EQ9gRW2omj0Zyp4j/rdrilG+xhe4hNfKSCiWB+8JySuGE7/PzgXJpqFlavoCs6OVIUdvH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPujGV8T; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so22360535ab.2;
        Mon, 14 Oct 2024 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728959164; x=1729563964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTmh0GnllYSt4TPF7EOoIC4KXWTX7jiWiympzlmF44M=;
        b=XPujGV8TERruxPYSDqkXghMc834oMq65G6j9dtQLYVVlXI1Bio/rgf1nptlKL9W+Ms
         p8WMDppyVnEmOpmEIacM/ckLYBH8OKHBUqfKutc8sbwY2xWYNyzjrN76R/02TocFZedg
         y42klZyHxb8f3v2up9yePO5ZXCOrQHjGGT7Vc7v3rYzOLgAsgNEGBwsyjKHWcfLZz+tW
         nu1o19PReLDduoVr2kp45frYh3SWqJyyTDmQhY3kvnf2sNfo2qlQMBu718+0sT78/yiT
         Ys9LHrE0u073JDWSCWzObrRqooIvjckkx+kNuN1fvGeC3tsUFNwG9LkkX4TKvlHVan13
         d4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728959164; x=1729563964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTmh0GnllYSt4TPF7EOoIC4KXWTX7jiWiympzlmF44M=;
        b=JlRnLr3iNZhiUkNyHm3LqzkFBxDLscQLHM8RU1sYEOvJpQYjUkBnIb09Cg4ifPE30q
         dpMOsZgkKeP1y5p+eCUAcivnceqa68V6JkevbED/Oav681toKnzfFGLV4pFG6Fz/pOM6
         YqXwn0VxsqqEYWZcOrB8JnV+PkhsGbA9CES7190rNrmZ+DuwIuQHiEuaYJdMRpkh83+U
         QhYYUv2ebhZowbr13It5V7XrUde+ek6FqOeKwA6exm1noNWt0nUpXi1IrZtb/VB0Ex+Q
         7QWh8IUMN+Hx1GhO8x1jlTAO/oho6AoqCHyFN42vc9dQcoKX3desHcU39wRnqFUY/uhy
         KiPw==
X-Forwarded-Encrypted: i=1; AJvYcCUi+rvkHMHniDsgZaTf/hZqctPPKsCufis1+m2zRSBpKl5VseUHVl0QtUpPQdLzNktfToY=@vger.kernel.org, AJvYcCVMaA9GzRTlu5oFmTxXwKSNn6Q9b2ksprhDSzj0nfCFsODG5R0diNTa0GXuOEAStRe38qdT3vCX@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcNGHNrPqpFJC2dc+2U5T2Sud3aPgJEvHn2XC+pLUHiH9wGMp
	HO4pSbPZrzXrBwCc3+Z3TWSXMMhU+l8WeGYTTHGt8VQzLBZXgCFliQVJA5eNM9baEhWAl3R7zZw
	2bOC7bjxpwx4eT5yYjsaRdnBG+ko=
X-Google-Smtp-Source: AGHT+IF8B731NoBrJyYiZXD9lHCFovWNmkhHaJLbQtcNWyga/9JKH6f+TAHF/cRPCnp13AHwx63IvHPwdWyQUXBl9+0=
X-Received: by 2002:a92:cdad:0:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a3bce0b1e1mr93932925ab.22.1728959163936; Mon, 14 Oct 2024
 19:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-10-kerneljasonxing@gmail.com> <670dc78cf28c1_2e17422947f@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc78cf28c1_2e17422947f@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:25:28 +0800
Message-ID: <CAL+tcoDAGLXsqRb4c-hbtE3a38KQHz9jh-p1tKMkWPMKferQ6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 9:38=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > from each sendmsg. We only set the socket once like how we use
> > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> >
> > Note: we will check if non-bpf _and_ bpf sk_tsflags have OPT_ID
> > flag. If either of them has been set before, we will not initialize
> > the key any more,
>
> Where and how is this achieved?

Please see this patch and you will find the following codes.
+       tsflags |=3D (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
+                   sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);

But the difference/problem is that the non-bpf feature only init it
when connect() is done, but the bpf feature could do it at the
beginning of connect(). If running txtimestamp -l 1000, the former
will generate 999 for turkey while the latter 1000.

>
> Also be aware of the subtle distinction between passing OPT_ID_TCP
> along with OPT_ID or not.
>
>

