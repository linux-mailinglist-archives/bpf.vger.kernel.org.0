Return-Path: <bpf+bounces-70725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC9BCC4F1
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7D4FD37C
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544227932E;
	Fri, 10 Oct 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcjroTTP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50326B77B
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087782; cv=none; b=kALqFN657GklB4e/FXQuyuVl0ws0FrTkcg6kkSJtKkbbWgcfLnO6ohCpNHKSwItdemMbzu4IWQF/0u2dd3wcoaZJPk+g/KhGo8yaleYL4vJGs6ZTRcIKt7rHvlufq0bsHYyrIsBCmOiDm5aqgQvmX8LCtg9ofAgkNq2zfPlOxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087782; c=relaxed/simple;
	bh=tQZBUX3XvCYZXjVGGEOa8qb+ycy4vSGnh5dp8xBMu4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXYwTKO0dtnizhVU8BnujyjTClnQyYragsRaLW3b0Uv57vfrz8fU90P5ivG3AqSOynPdvXFNXFQmBDPvvkWQ9hd8rn5QaM0s3NsXjTcV/rfZK8kEKDJAzP54cD1LzRJGnVinCGjVExpN4ji2QeWAuOIcyxY0c3XH5oOPeAS1CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcjroTTP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4dd7233b407so18760361cf.1
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760087778; x=1760692578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzbSi3MhQ3TlxHHyou9VOzHW9hoBR9Z04kG155RbSzI=;
        b=qcjroTTPnp5fc/eJtGmBZgBkfkUBYeB5L/hvghku77tH+HWDaveGyCKYPlEtQc5Hzo
         jzLcpsPTqvIA24owBjFe8Y1sUnOOPHFo/YBV/0kyLd8aHvGTjKudA4dz9vEl2qsoNaRx
         S4fdro49eqsTrpLWBGsvTmhnGHy6qZfTIAxAZFlV+gm48JHfpRXRfpss7t3GpTu00LZo
         0ErtKuT6Jt2HSKMQLCjooYyL2b86i9nwPrssSo1bCClLQyKkR66Oivd8JFIQV27Tg2ek
         +r84voQG0xa8YKaSDLMWKayojFLwGu+byNYPpd21a9aN5W/j8D1c9pmA1wG31LPmZYCU
         KO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760087778; x=1760692578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzbSi3MhQ3TlxHHyou9VOzHW9hoBR9Z04kG155RbSzI=;
        b=RF//88+teTYWxdli2yJKWXLc786qxVzdRr8j+dKptmDunCAtbNMpQHwdJU0S+2+I/i
         UjG88y2t0Ps+xrQWtK7+6ry37zp7fdzWnPHTkrX3OULwdiq/AUnT3JpK3Wf8bRw8PYsx
         /X3x54OuhCE3vaGVljL9beLgow0z+53tfaLzq5U5+evd+nn/iyPpP+JdXVfrSinTX3JR
         1uuXdEanngZXzFV+tTO3rhBSi0nUORwqs/N0qXpEuRCQ7NqXSO8IOnoOJ6cDyuSJZ8zy
         xYUyeBplZIDna+aaxbcUfeqdBPqG4k5RKXxHOnWnGn2/s974WKAtYKbgsD6v1OFW2CE/
         /cCg==
X-Forwarded-Encrypted: i=1; AJvYcCWx33aqPcTAy/ayIQ7iacirUO/ZdarKsG23POLbdeLjlhDr9WLNw7l3AaGSADhmdJ3U5GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKqp3COsM7D4IGBQEPS5ezl+c12IMPFse9g04CyfDUD2GMW3P
	AxZXvOhR9vc11/weT2vo/YptTJ7Mtjm0j+K5ShZYlC7ZzDL9f994MeBjc4PflyK/sueRs1W04Cw
	jnjCrp4B8c+2E+aQU/B9CNiq83pMMp5owCy6KnWEJ
X-Gm-Gg: ASbGncuA895FeO9hcVq9vGiWuzjHFNGDVQPshaYpTJQNWetBLeMEIa8HQH/fqMqN0/G
	g2m9YOupUMdu0+lL9Hun8gchk9r3lkw6WSOwjGnlvSu+DhpUC8I9Kbip0Y8asMROd5FA5MsjrLI
	myDirrQ+Wqr8FS/Rj6Cmw99VqC231RXe28eZbZLdrogRWxNa7t2UR8lYujDOkVT0j0z9HFGXeKt
	b/+y3Mvi3jYLwaKVBIIdc9XROORBJksCQ==
X-Google-Smtp-Source: AGHT+IErlLpwK/y5ZkyT1NXvQm0VoBCXIQhIIijbb7FXf3NcLAFxOmvBxYfs/FSRnPzRwXaTTMCVqNUkpI4RlupTQT0=
X-Received: by 2002:ac8:5902:0:b0:4be:9bd8:96f0 with SMTP id
 d75a77b69052e-4e6ead74978mr143714981cf.71.1760087777859; Fri, 10 Oct 2025
 02:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
 <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com> <81694a16-07df-44f0-a0a1-601821e8859d@chinatelecom.cn>
In-Reply-To: <81694a16-07df-44f0-a0a1-601821e8859d@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 02:16:06 -0700
X-Gm-Features: AS18NWCPORujAzz3_WeSTAuBKhzVzHemyw1PzLIC2o2khvPutiGDBTseFGRhzhk
Message-ID: <CANn89i+eDC5Pzb3gaszAqD3yjhMSw==O5nnC=R5b_42N5vODcw@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
To: zhengguoyong <zhenggy@chinatelecom.cn>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:17=E2=80=AFAM zhengguoyong <zhenggy@chinatelecom.=
cn> wrote:
>
> Hi Eric,
>
> Thank you for your reply. Indeed, using bh_lock_sock_nested can lead to d=
eadlock risks.
> I apologize for not noticing this earlier.
>
> Can I change bh_lock_sock_nested to lock_sock to resolve this deadlock is=
sue?
> Or do you have any better suggestions on where to update the tp->rcv_nxt =
field in the process?
>

Please look at my original feedback.  lock_sock() is not an option.

