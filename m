Return-Path: <bpf+bounces-55962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD913A8A27E
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CCD189B26F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAB297A4A;
	Tue, 15 Apr 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbmbcp/J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4021B4227;
	Tue, 15 Apr 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729951; cv=none; b=sBnclGWfH0wMOnzdmwOdd3dMP+2CpX1WN0OBXvnMPMN45rzuetI7/LSkJxaa0nRuVPBm3m/brngmCNjGuWaN3pJqaWr1uvlCc3NpWNYMFq2d2E75Xfs9ajTfbSIRtKg1qv8eGMiY6DHu2mpDhLR554doGN0mjhrX1RdWZW8WOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729951; c=relaxed/simple;
	bh=Jz+OpoedL0itOCZXD0lWOBOqpvpcbkJNadNPpgsPCBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/DUR9rjBt/oRM26b9vm7iCcrVzJPk6DyJ6zGEwkhrHHQNOTmZCvAI5yiVfhxOxUveVQyQl/nSADqVanraE1DklIJf//i5OLMkUuRhx0p1vsHstnWiR4Fm30df2ww4+vYmp7gjHS48grL6/9YEeV45cDc+O6TU3K1cJSVN0Jqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbmbcp/J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c2688619bso3737316f8f.1;
        Tue, 15 Apr 2025 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744729947; x=1745334747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jz+OpoedL0itOCZXD0lWOBOqpvpcbkJNadNPpgsPCBg=;
        b=Rbmbcp/JeOkeNqyxPJzHDw0Ola3mA+VeMt0idOQnTJmelQpXjVY0yQ3Q3MvNlqFXLi
         aFpgAhI3KbLnKzZHAEIXXipOiQzkgLZFtPo0FTJFJnQLCIbxlArqx1vcG09IUKjFGeNE
         nItc09d5ovj+5hZ1GbaABz3TE8RW6Kok464vqeYCM9pY8RH2bMTLh5XKaSpm/KU5oSFJ
         4kJ3LtGcT6zZoZP3gBFLX9W9NjH1hAVLoy8ZVhDQTSpvQXk7i8WtAldSA7uKK15zsRBs
         86J3YUi9q61deca5hXOxzOXQyo54j4zV3YZCaBgvJTkUfarr1C3ObZbT+D9aoLSFKSEp
         6FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744729947; x=1745334747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jz+OpoedL0itOCZXD0lWOBOqpvpcbkJNadNPpgsPCBg=;
        b=XPg36DLZ9YHfIOw7habr4E6mKW8pxIgUUsj302rIGEmkaN8oy10SzmC74U3wfM4B5c
         8N0T+FZPkLYTRrmEpZmv4ysQ9Q6lh0KfVcdnK75+vWv5QlVB8wqcBKOueTA3XYUUzmjd
         zLyskpfJPi6/2cK3l1VuoUgcIEpb2XuzT7K4lGONKTGLBc/9IzRYdsmwyMgLhWnqiJZu
         wsQPsIUBixLvOBvKrCxZDQvn+B99orV1NRXRCTb8joQBeqoszknxJoAYr4IWNlLXugGR
         UjU1TMEbtx/rBD+qDvO5D0DK00Q1444t1aPV77nFNlm9kY5WwTTtxw3gDrVtgly03mcx
         FZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW4OCWD1l3LPkXQvHk7Z/ATwdp0KKFK8MG6scjrXhU9GOPpa8ZTPNuS48HiITsnb3h0+BV7WIK@vger.kernel.org, AJvYcCVqTbJsdmqtYW+c0pLluLHpB+vxebyNgf/D65frBwRNqCCTYdSmZGkymkpbz96pLjeTMvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyY4i6hpC4eO5B/sLdYw+hwT3wDahvlggDacszJ+WVQ803EuNn
	skOFOEo1uvYmZckQk2TlUngB6c1E45abB+ZJGx9CIZ+VDmZPbwnHzlsrMryhTgjAfwNG1rMY9LG
	NmAP+Ez2v9Tp6QvOVg8IbyaSrYlU=
X-Gm-Gg: ASbGncuhW30auDlNZPEXtvcpwJ9c2fuEadGD7t5gqQ5j/nT8GxJl47E2GQ/Z/qUiSST
	FWy/UpsBsl9u8Khbi4El45Y/ErrqLCL4EtGhd1OmVufCgjVYrOPfyjLQuoxgJffM0s0zM4uiq99
	ywehkcCXWheYjEGFFKCdUlH84fDpqALgEdwwbe/QulvH33Mwo=
X-Google-Smtp-Source: AGHT+IHBdwhQta9Wqzwv5G09IMBIXzJA5+EyvzhF/tStlWQlsw7x0zGMu0qIiPz9ldCm/cmk0ZvGmywcIc0rsgcZg6g=
X-Received: by 2002:a5d:64c7:0:b0:39c:30f7:ac88 with SMTP id
 ffacd0b85a97d-39ea520390cmr12797223f8f.20.1744729947402; Tue, 15 Apr 2025
 08:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de> <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
 <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
 <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be> <20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
 <3cee5141-c525-4e83-830e-bf21828aed51@uliege.be> <20250415073818.06ea327c@kernel.org>
In-Reply-To: <20250415073818.06ea327c@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 08:12:16 -0700
X-Gm-Features: ATxdqUGDKZOjEc7GOqFhWDnVlfM-yNjWBVU_H_5VKqf-ulnB47Ihd5M7mV3Z-8I
Message-ID: <CAADnVQ+of2aBgmOFGNfixtqgp-spYdvZwHyw_=77S5T_+LXCBw@mail.gmail.com>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Jakub Kicinski <kuba@kernel.org>
Cc: Justin Iurman <justin.iurman@uliege.be>, Andrea Mayer <andrea.mayer@uniroma2.it>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 15 Apr 2025 11:10:01 +0200 Justin Iurman wrote:
> > > However, there is my opinion an issue that can occur: between the che=
ck on
> > > in_softirq() and the call to local_bh_disable(), the task may be sche=
duled on
> > > another CPU. As a result, the check on in_softirq() becomes ineffecti=
ve because
> > > we may end up disabling BH on a CPU that is not the one we just check=
ed (with
> > > if (in_softirq()) { ... }).
>
> The context is not affected by migration. The context is fully defined
> by the execution stack.
>
> > Hmm, I think it's correct... good catch. I went for this solution to (i=
)
> > avoid useless nested BHs disable calls; and (ii) avoid ending up with a
> > spaghetti graph of possible paths with or without BHs disabled (i.e.,
> > with single entry points, namely lwtunnel_xmit() and lwtunnel_output())=
,
> > which otherwise makes it hard to maintain the code IMO.
> >
> > So, if we want to follow what Alexei suggests (see his last response),
> > we'd need to disable BHs in both ip_local_out() and ip6_local_out().
> > These are the common functions which are closest in depth, and so for
> > both lwtunnel_xmit() and lwtunnel_output(). But... at the "cost" of
> > disabling BHs even when it may not be required. Indeed, ip_local_out()
> > and ip6_local_out() both call dst_output(), which one is usually not
> > lwtunnel_output() (and there may not even be a lwtunnel_xmit() to call
> > either).
> >
> > The other solution is to always call local_bh_disable() in both
> > lwtunnel_xmit() and lwtunnel_output(), at the cost of disabling BHs whe=
n
> > they were already. Which was basically -v1 and received a NACK from Ale=
xei.
>
> I thought he nacked preempt_disable()

+1.

imo unconditional local_bh_disable() in tx path is fine.
I didn't like the addition of local_bh_disable() in every lwt related
function without doing home work whether it's needed there or not.
Like input path shouldn't need local_bh_disable

