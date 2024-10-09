Return-Path: <bpf+bounces-41387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6837996822
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13541C20B38
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1D1917F4;
	Wed,  9 Oct 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbJ2kCri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1C18D650;
	Wed,  9 Oct 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472378; cv=none; b=BMwKw55B3OjZZfmbC2EtqRTFyGKggGrxw8zR5UyrwZF+SKTYeydHdY/sEUB+BcxrBKBv5ZPLxH+RFE0/MCPROJ9sCU5rMUvt+9JvICCCzKoN0y+mySFc50sG/Hi8NYpdjkPRQZuaC46QASC8yrT2OWKKHt6syAN+0p9cDeOT+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472378; c=relaxed/simple;
	bh=jJwdutrgSLXnRbAnB7053y/lF8GO1MLyRfwffFmi1OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOuOaSPmE3pNUvpENrVLsioNxlkHkLc31B3DVKcok3pKAseGuQkPmV4BmrYD8vd/GQYchjThX8Fk+5KcijJzOOpl1gsmxvFaVg7yu2XKoaP82Na1fVsqyglTgrHTtv7QbwpcUCqyecmP6f+HJpB8GBlBLmlizw2HhyQbc3+WgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbJ2kCri; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a34517248dso24614575ab.2;
        Wed, 09 Oct 2024 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728472376; x=1729077176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47PiAqsYoc1dVR7QFQ7X4wuk7gohhN3JyQ1u6OCvd2I=;
        b=VbJ2kCriC3NXskR6O04UbGgRU7OzzNdEtZXlOpv1F7RA0NESXwGC9ziUsZqugC/Tw8
         5NDH2HT2VrEE8fJiVXrJOLcE7KjQrfeos6yn5wKBYoF3IBuT9/eHXaIfVZWEGAVAwnOi
         KjO4WOcV5i60k9CB0PExK1GGvGZJYg/xdH2VpRg6OOJcnwZxvMjt53vN1iv0iGadTN84
         QVa0+h55sLWspkPlzTHFznVdEps4Vfi72p5ON8/1DL3XFsgIsfLC+3afh/BrW2tCNIb6
         5atyRIioP4zxcKQqf1Rwmzw1W5ONnCf6EVUu1SfF+ir76S9nOL2a8F/FgOFIvVVhtHs9
         1I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472376; x=1729077176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47PiAqsYoc1dVR7QFQ7X4wuk7gohhN3JyQ1u6OCvd2I=;
        b=tbXOvYlO2AuIPqUVDvrIwqB7oqdXQzKC2/Bu3/OrNslNS7kvJzVA56bTH99aq8NbCN
         he+/RFrp+h1WhwEPOBP76dCqogUVnjjwKGsOF1F4y+lgh2oWs5uAirUd7vHJSlDpfYh9
         8oH6VZr3uNIcXA3vR0Q0c2hln4IyuHJ/Xyp3bYokFmc0Z1Jlkuj8JBoE289onN7C20a9
         ASTQj3Sd7k89yvAe6J/iSKvb7qf6zb1E2LJHKwHZXbFZhLgmVcpg/XWfzTi9kJQklVUu
         hrGPfpi81sCl7PuQ+bqIESyckwpBm88HS1k9tP2YtPaUfGvQ/9yEr/iefk8LP8tdzH2B
         89zg==
X-Forwarded-Encrypted: i=1; AJvYcCV/80TS5avnsus8ODpEC9KI5TVyvUudH5GYkfs/YY1XbFEJ2J98THmVhzSDEOxYzg9aKe8=@vger.kernel.org, AJvYcCWkYt7S+51DLFLCQj6CQGy7ndGzXHdMx/bPQQxlsi+mAa7nlNrfN9k/reLUTDljup+VeRj85vnW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9H19wPpVe+Xns+7Afd8g20v8AuIwxJjH/96F6N7qw9lSZdN2
	E3xrVWv7zpMyW/C2kKsVOD9zFYVUdvTnO8gJBEi5mVSfNk+IBWf/pc3GiFav1H1F3s2REhQ2Zl8
	GBeIPK51oEkhF/CFMfS7yaQ6Vc1A=
X-Google-Smtp-Source: AGHT+IFawdsUIdWxCP8EC71mXttf/iQY7n3QF3+cFPQkmMHQEtIdoiQ9Cz+kXwZl6wTNH5KuWN/54beNrGYLnVEcLro=
X-Received: by 2002:a05:6e02:12c1:b0:3a3:97b6:74fe with SMTP id
 e9e14a558f8ab-3a397cecc36mr17440505ab.11.1728472376341; Wed, 09 Oct 2024
 04:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch> <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com> <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev>
In-Reply-To: <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 19:12:19 +0800
Message-ID: <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:28=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 09/10/2024 02:05, Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 7:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>
> >> On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
> >> <willemdebruijn.kernel@gmail.com> wrote:
> >>>
> >>> Jason Xing wrote:
> >>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>
> >>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by usi=
ng
> >>>> tracepoint to print information (say, tstamp) so that we can
> >>>> transparently equip applications with this feature and require no
> >>>> modification in user side.
> >>>>
> >>>> Later, we discussed at netconf and agreed that we can use bpf for be=
tter
> >>>> extension, which is mainly suggested by John Fastabend and Willem de
> >>>> Bruijn. Many thanks here! So I post this series to see if we have a
> >>>> better solution to extend.
> >>>>
> >>>> This approach relies on existing SO_TIMESTAMPING feature, for tx pat=
h,
> >>>> users only needs to pass certain flags through bpf program to make s=
ure
> >>>> the last skb from each sendmsg() has timestamp related controlled fl=
ag.
> >>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsfla=
gs
> >>>> and wait for the moment when recvmsg() is called.
> >>>
> >>> As you mention, overall I am very supportive of having a way to add
> >>> timestamping by adminstrators, without having to rebuild applications=
.
> >>> BPF hooks seem to be the right place for this.
> >>>
> >>> There is existing kprobe/kretprobe/kfunc support. Supporting
> >>> SO_TIMESTAMPING directly may be useful due to its targeted feature
> >>> set, and correlation between measurements for the same data in the
> >>> stream.
> >>>
> >>>> After this series, we could step by step implement more advanced
> >>>> functions/flags already in SO_TIMESTAMPING feature for bpf extension=
.
> >>>
> >>> My main implementation concern is where this API overlaps with the
> >>> existing user API, and how they might conflict. A few questions in th=
e
> >>> patches.
> >>
> >> Agreed. That's also what I'm concerned about. So I decided to ask for
> >> related experts' help.
> >>
> >> How to deal with it without interfering with the existing apps in the
> >> right way is the key problem.
> >
> > What I try to implement is let the bpf program have the highest
> > precedence. It's similar to RTO min, see the commit as an example:
> >
> > commit f086edef71be7174a16c1ed67ac65a085cda28b1
> > Author: Kevin Yang <yyd@google.com>
> > Date:   Mon Jun 3 21:30:54 2024 +0000
> >
> >      tcp: add sysctl_tcp_rto_min_us
> >
> >      Adding a sysctl knob to allow user to specify a default
> >      rto_min at socket init time, other than using the hard
> >      coded 200ms default rto_min.
> >
> >      Note that the rto_min route option has the highest precedence
> >      for configuring this setting, followed by the TCP_BPF_RTO_MIN
> >      socket option, followed by the tcp_rto_min_us sysctl.
> >
> > It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
> > The first priority can override others. It doesn't have a good
> > chance/point to restore the icsk_rto_min field if users want to
> > shutdown the bpf program because it is set in
> > bpf_sol_tcp_setsockopt().
>
> rto_min example is slightly different. With tcp_rto_min the doesn't
> expect any data to come back to user space while for timestamping the
> app may be confused directly by providing more data, or by not providing
> expected data. I believe some hint about requestor of the data is needed
> here. It will also help to solve the problem of populating sk_err_queue
> mentioned by Martin.

Sorry, I don't fully get it. In this patch series, this bpf extension
feature will not rely on sk_err_queue any more to report tx timestamps
to userspace. Bpf program can do that printing.

Do you mean that it could be wrong if one skb carries the tsflags that
are previously set due to the bpf program and then suddenly users
detach the program? It indeed will put a new/cloned skb into the error
queue. Interesting corner case. It seems I have to re-implement a
totally independent tsflags for bpf extension feature. Do you have a
better idea on this?

Thanks,
Jason

