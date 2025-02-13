Return-Path: <bpf+bounces-51480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C24A35263
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D8188E60D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762B1C860C;
	Thu, 13 Feb 2025 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCr8PLr5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43E275419;
	Thu, 13 Feb 2025 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491080; cv=none; b=Daoqt6JFozkwXZXdL5cntuUq44hZ6dL9Pn7xy0RO0R47gQfYnHAUYrOW18rlY/Jmr4Rj1X8D32amdOlXKUiVNIGUiKMtQ6KqxPsPAkivPc1Hkc2akyyaCe+wXiHZ4EnNc8da3Ui/4zILe+Ap/KpTi8Jj56/HCbXs85tVohymFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491080; c=relaxed/simple;
	bh=CyJpugw1LsL86O0UFW0V7F890o+MkrUy62qQInp0k9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB0WqgBRplMW5KsdvfeHMlp6Gk88SEQNqdxKHhsvYNjVz/qHCMwiuclY9LIO37+9AISUUrxjL0sZ9yCGvw/yyvvX4xCMnTcrtnsYTlEx52HGZ3QcMHABUZ2wrmXF5HtNakyZJqPkpHM+LNAYR/P685Hjrg1g4ScmmOn2Xq8o3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCr8PLr5; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so8316165ab.1;
        Thu, 13 Feb 2025 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739491077; x=1740095877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ4F6FuyhbgtHMZad3+v5eAA4GhquyF3kxw424UiTto=;
        b=aCr8PLr5ly+ncS2QbhX5Uz6xN7TSfYXg/MvaJwcik5TqTHmWyNPs/gd6BOb5i8grQV
         0wep8Bw6GY3svjUwrhk/0Ug9zg+fHeNDOZcfmmgJCre3EsKo9R0a2epJuqQ8CTsEFV+x
         sunKXIlO9sF4+NNnw2+tVdPnE0GH/Fdo0RtgleaO90e05/fMR8TPpG4NKQo51u4EGcMu
         O+r54kpawt11s/POHIZXytNLXyNFmUevt6b5H4KGSQCeS16Fpo+pBXqXtJ+qJAuJ0Fsn
         Rxscy1e5smYOHbj2StAFMgOHHATZpjDsKEQ4dbZnE+TkdEdPjGLR4mqgEsL6voYvVQv4
         Opbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739491077; x=1740095877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ4F6FuyhbgtHMZad3+v5eAA4GhquyF3kxw424UiTto=;
        b=DgF+X8AmTGYmPEtaHafTNMOKlyZejoYSJ9gM8rECcIyKdwWVKqSjS94G+XIHT8deZs
         E/Yr4b4EYTfOSkcJKOt+XS5nCIBCQtWKnhoJeKQ1TkgBP2/o1GUL2VTL7z74uXylQmE5
         pYz0mJT7GFe1+aT8DlIHzjg+C/7ciZxFyxVyq0+Y/oactQ+ynUDLcDHUSIu5+rRK5o+f
         KwnQ9IWm5TSDR3onR2pmvO6EztyNOUia1sIOu0Rl0ysig1jbUVrFWh3KgfO4j12XyiA7
         uraIZmQienmagmDjUiICmekFFiy6hYoIGi4VawreGNBtA4ZXsxoA28sl+ARQOL9CAnZI
         4o0w==
X-Forwarded-Encrypted: i=1; AJvYcCXn7iD4l6S8NKk/hDE4gDfD0XKjlyhuDfMXNf5+d7OYWq/DG0zZ2YtcSB4497GNEwfpZFSRa2XQ@vger.kernel.org, AJvYcCXpZ/kyHCBYejVx/iuxnVq/HuW5bHmeBShaX2x+rQ9hHIc7ajUuixdJdAZoWHGiJaccOYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLcoOEJ4Ucx9SAhsW0FjQG0+WYbseI6JPSGRVp7nMiq0dIloo
	HYoCcU4Vj4SSU7nzF8gKSTQ0LFU4Z0sbPwIP3Pe0UH7SsXo09c5q3PQWzmP2MKuAnddK5eTfWTy
	6iwc++O5YCqg00qyOaqj9AuMUYDs=
X-Gm-Gg: ASbGncuZXv64Mc8oO4pH+mNUu2o5rkItLu3KBGtMozxrVy0yaiz0z6fY6HA0E/29aRe
	t1gPHZAxlMY7cmGBCA/qdSq+chXUFdtUWwPe1cMJgwNQ4+ojROc/yLY7cRDlD+wyT+YeIlv4=
X-Google-Smtp-Source: AGHT+IHs6ynJrCp6bpJTtUl/zWcPJBlR2RDsZk5mAx53baSU4wXUbrD+npo4H34S7yvmsRshYPIDDbFsjjTgoRotgCQ=
X-Received: by 2002:a92:c547:0:b0:3d1:9bca:cf28 with SMTP id
 e9e14a558f8ab-3d19bcacfe4mr5244415ab.8.1739491077589; Thu, 13 Feb 2025
 15:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
In-Reply-To: <Z66DL7uda3fwNQfH@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 07:57:21 +0800
X-Gm-Features: AWEUYZlvZP8A6izvqVgz1orpaucnVyGGmfIAfGICcyEez1--no4p9Ag-oRPsCf8
Message-ID: <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/13, Jason Xing wrote:
> > Support bpf_setsockopt() to set the maximum value of RTO for
> > BPF program.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst | 3 ++-
> >  include/uapi/linux/bpf.h               | 2 ++
> >  net/core/filter.c                      | 6 ++++++
> >  tools/include/uapi/linux/bpf.h         | 2 ++
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 054561f8dcae..78eb0959438a 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> >
> >  tcp_rto_max_ms - INTEGER
> >       Maximal TCP retransmission timeout (in ms).
> > -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
> > +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have t=
he
> > +     higher precedence for configuring this setting.
>
> The cover letter needs more explanation about the motivation. And
> the precedence as well.

I am targeting the net-next tree because of recent changes[1] made by
Eric. It probably hasn't merged into the bpf-next tree.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3Dae9b3c0e79bc

>
> WRT precedence, can you install setsockopt cgroup program and filter out
> calls to TCP_RTO_MAX_MS?

Yesterday, as suggested by Kuniyuki, I decided to re-use the same
logic of TCP_RTO_MAX_MS for bpf_setsockopt():
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..ffec7b4357f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optna=
me,
        case TCP_USER_TIMEOUT:
        case TCP_NOTSENT_LOWAT:
        case TCP_SAVE_SYN:
+       case TCP_RTO_MAX_MS:
                if (*optlen !=3D sizeof(int))
                        return -EINVAL;
                break;

Are you referring to using the previous way (by introducing a new flag
for BPF) because we need to know the explicit precedence between
setsockopt() and bpf_setsockopt() or other reasons? If so, I think
there are more places than setsockopt() to modify.

And, sorry that I don't follow what you meant by saying "install
setsockopt cgroup program" here. Please provide more hints.

Thanks for the review:)

Thanks,
Jason

