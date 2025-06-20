Return-Path: <bpf+bounces-61184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD129AE1F3F
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA837B2719
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831C2E6136;
	Fri, 20 Jun 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="dlCqraj+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F02E54B4
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434302; cv=none; b=ErA3uLSZqREvKImLoLNPr4jUuw6ZJAQxatLnh4cBOKx8elOOvp7kUX2PL4X2rHIhuYQDsuzIHOEc0HnE+4esu9pIuLIqcPBsakHVZDX/4dBfw8XilArZ7dLETMpLjS/9fbDZlHpH8ZxKxt6WmjykRF/zkJOYMSdGvRxxDZEx03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434302; c=relaxed/simple;
	bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVyYf5PWd2r/HqbbW+SQSnyO+gPmhjHNB77/3ofvsVKVih3Q3xXq0NnEJEzh5UXAba1CMA9/OqFCIGsCwAvOpI14RGMsKyAM/+vSqOd07z9UGYEWinNbcfvqQeiTWggO15auvDRfngysc08CtauS7pdtRwNNVfYPRTeTM1qTbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=dlCqraj+; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d806c1c0eso61511241.3
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1750434299; x=1751039099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
        b=dlCqraj+Jzn7HgLEzDiwZLYPSr+73jzWSVe00jGnzI1bf7x7MgkU+WAhB3OpLPR2Xr
         692buocp3miHbHXsV7ibcDrUypEZQKjGMXhyYJGL7vTyDkDiAukTiNGAYU64gpHSRqG1
         Gfjg2/fLyXWvIC4l7AWhLptrvnrlKYrwpJPc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434299; x=1751039099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
        b=EwBII6jI/m/oEDqzC/0fSPSU2SqDQAFtCrLfzEBaP90za44acUPgt1ZdP3i53JdyDb
         tNYaNfPDk4RBcRvRM5J4PL20pPCulg9bhRfzRtOKQF/2YbNJNIK68W2eMDI6PFw1u+Oi
         XSR+/gVghUTq4jwau3bkXSoikms1zc6bvXknN+i3VMH6a4+qm0RH0gc73N94SsC/Qpnh
         IEyCSy2v7A0IjqSG3xh8XVg0DygkJ8AjtTvjtbfU451Sfmo2sVMLbNr4iwbrt5B33SXo
         fqH7t4OQBpIXsT0tFeoNY7qz5c65lB2ffCMKli3CaDiHSv+oCxYDY2J+Ik5nsYLIAVQc
         v/9w==
X-Forwarded-Encrypted: i=1; AJvYcCX2PijXFCbisMc1pJOM3O7DKGzrZ8j1cPAqhrv9sb/Pt4R4pyDVbVx+8TajLf0M0T5BaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOo0tFP1FwMTNFZkoEoRtZwBgok5aj54V0TUSjaEcEWIdOyaIJ
	zRnW1TkfrOP1N7RB+5DiMbwnEjK3ECF1D0cwTbIkH7Fh8yGdnmYskhVVPMe1SeHkhyquXZi4+8t
	VHr1a1KFjYAIdOPY1klyiNs/VnQgCu8QkM2+PsZMpLg==
X-Gm-Gg: ASbGncvwWlNDmYh8YdVUqIZDlhb/vh8Tij+0aiihOHIQ48kTgoIq61FhvBihThTH31E
	z//PMtCFzFDGXpht4QAIFOWjbs8c38fb/DAA7k4g+NzLE8sFYwfayPZUS/Oolu/8k+LkE1HQGbh
	4oq205/Zqu19zfWGRASVkTOA5GHJG/fdtpgjMPQbBof14qt5jgt2a51huw
X-Google-Smtp-Source: AGHT+IGfetZb5YTOzADWhLIueyC418gbZDS0IQ33L6/V3exTYghPGnj+6eGEUhq/L4fKkQm1rR8S3IzC9dcb07MI32s=
X-Received: by 2002:a05:6102:1611:b0:4df:4ef8:8624 with SMTP id
 ada2fe7eead31-4e9c29d297emr697185137.7.1750434299409; Fri, 20 Jun 2025
 08:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
 <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com> <20250609122146.3e92eaef@kernel.org>
 <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
In-Reply-To: <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Fri, 20 Jun 2025 17:44:48 +0200
X-Gm-Features: Ac12FXys6L7fct_1U66TenHgZHLNfks9sBYqKL_WAEa9WiwjarPPkDph6JQvCek
Message-ID: <CALye=_8_zGg3vnKtk4qrTN2RN7Y4yfEqD1G3Sf=AJSCwBcJkbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:57=E2=80=AFAM Vincent Whitchurch
<vincent.whitchurch@datadoghq.com> wrote:
> On Mon, Jun 9, 2025 at 9:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > Can we not override proto_ops in tcp_bpf for some specific reason?
> > TLS does that, IIUC.
>
> I see that TLS writes to sk->sk_socket->ops to override the proto_ops.
> I added some prints to tcp_bpf_update_proto() but there I see that
> sk->sk_socket is NULL in some code paths, like the one below.

To expand on this: TLS is able to override the sk->sk_socket->ops
since it can only be installed on the socket via setsockopt(2).
tcp_bpf on the other hand allows being installed on passively
established sockets before they have a sk->sk_socket assigned via
accept(2). So, AFAICS, we can't use the same override mechanism as
TLS.

