Return-Path: <bpf+bounces-31581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06A90030D
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54481F2441C
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6C190672;
	Fri,  7 Jun 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="LEVzRcbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD818FC63
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762214; cv=none; b=hte378PpvD9Bf9YBn2GanAMTm/0wcmvuDxO/beTUbv2ZfMIa/ykP1ggnKS46rMLth8E7pm6a7dJgIXf4V9Wq71Uh+DkurH1RG4yg0iTsqhtH7IBL57wffzpEkkkfHxluIG92K1cj/8XvqrmJHDYFavOGzAWwrdqPYgTQ9feiLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762214; c=relaxed/simple;
	bh=lhVzMwo2bwsYikE4S2s6QfMuo9LEZPXHj4cAOh82aGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGlPEVRNcuzj1ZJn9lHqPfod0dAZxsclM5AhzMCUpqzHGKDShkTqgl6I4sQs+v0IQ3LAq+SIIbrHMNtEZFiZSKT9m0jezk5tYXHU69vWV1Fadgnftp3t5xniuMT8CtP96TkVjtunI7HIX/0l7iO1k0cVkZU3P92NYQNlMILJkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=LEVzRcbE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9b74043b1so1059791b6e.1
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1717762212; x=1718367012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBNhYmQ8dkT0XNCOInHG1tDMFk3l+qpne7930s1j4Ck=;
        b=LEVzRcbEJHQfSC8Pf1OhNdLg1nvgi2ME5L/2cY1YUzi3EiZE05iChfdCtUhtZyxxgF
         InM/v2egnl6huT6rR4QPVqfM91Uw1bftaUbb+FcMz/gZNmuBvUKodzd3gavCw+nz6uJM
         UjeFb2lETlQdDz17Rz5U1AqolFY8oO6UxTnJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762212; x=1718367012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBNhYmQ8dkT0XNCOInHG1tDMFk3l+qpne7930s1j4Ck=;
        b=Ss2m2j+bZeHeT/nyVFUXTKp6NikrYoQ130Ceg5eugz9B9xOwdMy/uCRa0iChi6C6hu
         X6y61WsCFLGLScDX3KYFvL2sCBvUtTMLc/e7p/N3fXbYPWnhJpiS8gllRcXRYiorPG7m
         9MpUMmTKkVR5Rovpg/0I2BU91vjzXrB450U+BWk3/tVyic3zSG4v7zytotQ4X0o4x9I+
         JHVAULmcQjg4PYcWQ5Ih6/62nEtNoER5xOm92IyujdiIw6Jaw9VtQ5zubQ/EcTK2mo/I
         8pdigXPuGAB5HyUGZRKLCmNtv3Ddx9eRJWiR1w7O6UjyvgWJn7m6SZbupLPpkH65Nlwp
         KNOg==
X-Forwarded-Encrypted: i=1; AJvYcCUsWPr1EtSaY20xWZ39a1iv6RcUi+rDHHRgU/OEfC//vSihfrBmSa8El8alYMlbI1MkFJuseTVQpEDZ19FCYKm1TXxk
X-Gm-Message-State: AOJu0YzEj0HC54qwLHZEsVjpTpAlRovf+y4Q/+pbg/bCvHXpXndDFuZ8
	r5qT9lW2pOd4cZCRx78IE/Pz6N0Xu2qEIk50MkyL6Xh3uXnChVx0jJKiGeONLJqfLtlVEEOhuk1
	xrozGN50qeRn1nb9o8c8q6nYWvBlowLYEgKw8YQ==
X-Google-Smtp-Source: AGHT+IFB5Swsr9Stevr9CFufiUNtVBAe9HelEy9+H2ZSE5vXvFUIfVouM4wWFiHmYZjz+khNIp6lY1tGGq5fURF4U2A=
X-Received: by 2002:a05:6808:4284:b0:3c8:49e3:c0f1 with SMTP id
 5614622812f47-3d210d2b846mr2330702b6e.5.1717762211561; Fri, 07 Jun 2024
 05:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
 <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
In-Reply-To: <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Fri, 7 Jun 2024 14:09:59 +0200
Message-ID: <CALye=_-oqMO-LRWd7pvMUnOxDCNVg0v=Wgmg8Qggg1Q3yL-jmQ@mail.gmail.com>
Subject: Re: Recursive locking in sockmap
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
> On Thu, Jun 6, 2024 at 6:00=E2=80=AFPM Vincent Whitchurch
> <vincent.whitchurch@datadoghq.com> wrote:
> > With a socket in the sockmap, if there's a parser callback installed
> > and the verdict callback returns SK_PASS, the kernel deadlocks
> > immediately after the verdict callback is run. This started at commit
> > 6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
> > pointer dereference in sk_psock_skb_ingress_enqueue").
> >
> > It can be reproduced by running ./test_sockmap -t ping
> > --txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap is
> > available in this series:
> > https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a2ab14b=
5@datadoghq.com/.
>
> I don't have time right now to look into this issue carefully until
> this weekend. BTW, did you mean the patch [2/5] in the link that can
> solve the problem?

No.  That patch set addresses a different problem which occurs even if
only a verdict callback is used. But patch 4/5 in that patch set adds
the --txmsg_pass_skb option to the test_sockmap test program, and that
option can be used to reproduce this deadlock too.

