Return-Path: <bpf+bounces-42860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7699ABB91
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39493B22C24
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CC55C29;
	Wed, 23 Oct 2024 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVX/U84R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841AA1C28E;
	Wed, 23 Oct 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650713; cv=none; b=PX4Nh03REWWHKEKPp4xa07HYBucZH+8adKOMAO6XPPS2pmXvDPBYBrCY80ZunyqtpGiSawxH6jRQz6asOsZv+M9tzosWGZ1/Q5mZdU+IMgDAIjNNIKM03UCdkxyHhnUi7KcDxdQ0VT1L+rEffNN8vkNTyIO0POyJ/oxvoy1Zdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650713; c=relaxed/simple;
	bh=+uWmf7l/5xKUeRvYWQFvXEiE6OCTPRne6VeNsLyv/wU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tDl1/kg+0Dq3Bdq7kXmgiH3i59NcBgecDiGmh/GhsCuih4B0/KJ56lFVqon7yUgUGNz68yS7Ihtk8AWn8ZQSRB37tw5mSvsk9xc8nyYkjvyWxPhTaapqA5fqE+F/zyUJAzvBTs82jQDCY9KvME90tf1QwP4HasDsbHQ3mwnwedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVX/U84R; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460a415633fso36818781cf.2;
        Tue, 22 Oct 2024 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650710; x=1730255510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+5pkazMR0lQTRePEVE/aggfzwATQGf4HDQ3Fx/SKKI=;
        b=EVX/U84RQ/DfODkt3Hb8FHlluJk7T14l2b2zHCcqCt2iV07x7PoPJpaJNUWUIrQMc9
         J7QezMA5wShvrHbbS7iYR3q5v0gxJv2f/kr5OTDjLejhL3yW6xW2kDNmYt1awUf/GXny
         Smg50APAqbi15m9scuY8w54dUeyit4Vl1LIRjHj7EEeKgkgQFGLivAPVQw4IRnxmqDCm
         u5SNI+cVYxIoxZ1M3hMoAaN5nWEbx2CERVkLNScihLInaudF/ow4/Gq3+LCj7KQofzv9
         PejLHMkcAyv5L9w0q1LSSnxZi9iFAzJ+eNbGNy226PEvTzEC2skDKB/4PWKd08KZxoWh
         auYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650710; x=1730255510;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7+5pkazMR0lQTRePEVE/aggfzwATQGf4HDQ3Fx/SKKI=;
        b=WKuSBvIkZKkpfCbPdbEYBdGFOzwy9EIxgR5O2y+x05/lqs3xqtt5Smnh3idvtsf3pH
         IvfBqJmSnHizPSR/YxRfCykVScKJmLMQK67MbKA1ZC1QEbT42wcaKO0gR0dSxYbyu3U9
         RPA/nKstW7yTvMcSac7tPpL+V7q5umkpJcKn2lijycQuMarnahhBQh/ber5I5sjxmKGu
         TmTY9czJRNEfPn0bUKo4uAPJ8k6784NQK94NCrTjp1UGJ9P63JZ9gS/kjQFPsFGxVqJh
         nsuBdowylAGREPZBmbFEzzPJ+tZP9ziXxaMbhd3tAUU8Oge82p8KRtLLgrnNkF5OLJKm
         cCGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Yh6KEKIFxP4Z5osY624pjXyVEnhrBDgUAXl6+Lb9PM977fbx0BYrSeKfurzlmdpQ634g5rIs@vger.kernel.org, AJvYcCWRVCG9NbYEiTNauRVdFrTrq3vwxm+Iy7NE2fik0wfiYHqFyg5abgnGg4hkKG9+p3HZUCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3T/nxTLAr8w/JPvV3RiqISznRuAVraPhaLWlFkh1n7bQz2qs
	VM9cnFewkYhf5JnqoonJV3cSZeTsbBuRKSMXB5euJXAAFPuh+SiGUn5h0w==
X-Google-Smtp-Source: AGHT+IFh35NWrOofzBUjEaLuvmJz8b+y9ol3/4ghe6+Ajlm+lJnjbVS0QbMJt7ZQvL7d/zm/GqfV5w==
X-Received: by 2002:ac8:57d5:0:b0:45f:6ed:40c0 with SMTP id d75a77b69052e-4611471f4camr12777561cf.40.1729650710220;
        Tue, 22 Oct 2024 19:31:50 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dc5facsm35752001cf.96.2024.10.22.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:31:49 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:31:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6718601526686_15cbc9294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <671840a23227e_1420e529466@willemb.c.googlers.com.notmuch>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
 <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
 <671840a23227e_1420e529466@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
> > On 10/20/24 2:51 PM, Willem de Bruijn wrote:
> > > Jason Xing wrote:
> > >> From: Jason Xing <kernelxing@tencent.com>
> > >>
> > >> Willem suggested that we use a static key to control. The advantage
> > >> is that we will not affect the existing applications at all if we
> > >> don't load BPF program.
> > >>
> > >> In this patch, except the static key, I also add one logic that is
> > >> used to test if the socket has enabled its tsflags in order to
> > >> support bpf logic to allow both cases to happen at the same time.
> > >> Or else, the skb carring related timestamp flag doesn't know which
> > >> way of printing is desirable.
> > >>
> > >> One thing important is this patch allows print from both applications
> > >> and bpf program at the same time. Now we have three kinds of print:
> > >> 1) only BPF program prints
> > >> 2) only application program prints
> > >> 3) both can print without side effect
> > >>
> > >> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > 
> > > Getting back to this thread. It is long, instead of responding to
> > > multiple messages, let me combine them in a single response.
> > > 
> > > 
> > > * On future extensions:
> > > 
> > > +1 that the UDP case, and datagrams more broadly, must have a clear
> > > development path, before we can merge TCP.
> > > 
> > > Similarly, hardware timestamps need not be supported from the start,
> > > but must clearly be supportable.
> > > 
> > > 
> > > * On queueing packets to userspace:
> > > 
> > >>> the current behavior is to just queue to the sk_error_queue as long
> > >>> as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
> > >>> is regardless of the sk_tsflags. "
> > > 
> > >> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> > >> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> > >> read the skb from the errqueue but are not able to parse the
> > >> timestamps
> > > 
> > > Before queuing a packet to userspace on the error queue, the relevant
> > > reporting flag is always tested. sock_recv_timestamp has:
> > > 
> > >          /*
> > >           * generate control messages if
> > >           * - receive time stamping in software requested
> > >           * - software time stamp available and wanted
> > >           * - hardware time stamps available and wanted
> > >           */
> > >          if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > >              (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > >              (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > >              (hwtstamps->hwtstamp &&
> > >               (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > >                  __sock_recv_timestamp(msg, sk, skb);
> > > 
> > > Otherwise applications could get error messages queued, and
> > > epoll/poll/select would unexpectedly behave differently.
> > 
> > I just tried the following diff to remove setsockopt from txtimestamp.c and run 
> > "./txtimestamp -6 -c 1 -C -N -L ::1". It is getting the skb from the error queue 
> > with only cmsg flag.
> 
> That it surprising and against the API intent as I understand it.
> Let me reproduce and take a closer look.

Interesting. I guess my interpretation was wrong.

The reporting flags prevent reporting of the timestamp, but not
queuing of the skb on the error queue. Even if the only purpose is to
report a timestamp.

It goes back until well before all the API extensions. At least v3.6.

It still does suppress the timestamp itself if the relevant reporting
flag, SOF_TIMESTAMPING_SOFTWARE or SOF_TIMESTAMPING_RAW_HARDWARE, is
not set. So BPF should really still match that, I guess.

