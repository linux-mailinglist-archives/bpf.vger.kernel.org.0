Return-Path: <bpf+bounces-42549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF29A56FD
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14FE1F21FBF
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7D197A8F;
	Sun, 20 Oct 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mst6jLhq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0A1DFD1;
	Sun, 20 Oct 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461122; cv=none; b=UQiSQQX1NvshpG8MxZk0Mt/CkLhgXjSmrBavIBmHsXfVWA1D8/9e+yq4y43jdI8qEy5mKsbYGoxKzSsmsDEnA5bWwTiCrbqiIq3AT3h9sPNteXtNQDc92dwkY8GXy3xNAIIRG1/1eLwMoXvFZue9VC4VUjiybtM0iIDb2jenbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461122; c=relaxed/simple;
	bh=H4Epv6qeC4bRPwHm76HkKbmSd6YH2E32YywZ/bmqKN0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G8vbqkTlIPoa9yDJgaa9oKxtb//44xTe9rO2wG/8La6dg3recPORgFgVEzP3Pq+H/x6fNK1pxSBz3HMEHyglH3IYQlst4wWJsYCsHLix2XV1ccrshspwrnRwWABrSyLYswIQqYSI1hLJO0WtlZuMjnS1PbvnwrpWByMaGU/MoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mst6jLhq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15495f04dso262071185a.0;
        Sun, 20 Oct 2024 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729461119; x=1730065919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dT9fmaMlUxJBUvQq9OqSg/LZuS+O6J4fJBYqHhKxA0=;
        b=mst6jLhqugAIzyjpm9AcCs4ljd06CBE/7y2uKIV9p6wxmq89a1baLM9JuLOKIoi3fg
         m/oWg02wHQCsKJ0cwU147w72NY3wWIArsHERkpOGTqCSH7BsPjyiCz8eQrtJRM6MSyoK
         zTNGSxN/YC38YE/NEtL8U0/xEz4yiWwtyZnZUNvkSadcLxdEiWYpcSf38DKO1bCxl3Et
         yYDpb4i/KNdmO8frXUkEA83u+eomG2gEEtUHVQbFK7HGGSxHQwa/V9bkiNBwjaP2IT5H
         bzfgwU6y2XRyUVD82/CHLXL1ScxOE7lgrOpS+mkB9AbfWY+LUS1deeQnX2dZYynCMz6l
         TglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729461119; x=1730065919;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7dT9fmaMlUxJBUvQq9OqSg/LZuS+O6J4fJBYqHhKxA0=;
        b=VzFhUXvS95E0FZt4FbSHTCKVO5u9FT7FUhEgOt1mu6fZb4Z8VaINFsnOeytJ1kanGz
         n+5CXljUMiqFr9j62XadggAY47Lwxmw0zV+niKPhROED+K6PESYcrTO65QYjbLomRp6T
         BqCR3nxc1XdWc83BvUBqEpZpgB6O5LUM9A5SXYusRHxx++gqnUWugY7tmlunpQHRXgO6
         p4ZZL0T695Eace5qsGKb+3v/09W2N1/X4AhQGYmT+sUHN0HWCrMldQAkoPHztUxHJUm5
         JQJUrmil7L0mvgLm9vpWYkqrUMupcBaziMVfphJxGm+5d9ljAKhGbnqjpCiH6UevkirW
         GYtA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rOcWvI8HZC9uwy2TIV0tjONMK49J2GnNX9VLdOMsbep73x2TwLn+pUI/wXHTffBKenLzLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujFtwsDW8sG1WZLXSuoy3wwNI8sVI2MOitgPObeOltCIf4v9j
	zzs+CBQYqEoa2pFxPBBE3aiYS/WngiOo7dvy9RsWZZDcBsYscHqq
X-Google-Smtp-Source: AGHT+IGbwOV8kSjVLDhmhM4sj+aUrszygkOPhQFp/ESQ7rLN+vDrzfZswEHY6uQRve6LE4COzL3GCA==
X-Received: by 2002:a05:620a:2990:b0:7b1:4fcc:5483 with SMTP id af79cd13be357-7b157b65c99mr1462452585a.27.1729461119418;
        Sun, 20 Oct 2024 14:51:59 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a88814sm110911885a.132.2024.10.20.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 14:51:58 -0700 (PDT)
Date: Sun, 20 Oct 2024 17:51:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-5-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
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

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Willem suggested that we use a static key to control. The advantage
> is that we will not affect the existing applications at all if we
> don't load BPF program.
> 
> In this patch, except the static key, I also add one logic that is
> used to test if the socket has enabled its tsflags in order to
> support bpf logic to allow both cases to happen at the same time.
> Or else, the skb carring related timestamp flag doesn't know which
> way of printing is desirable.
> 
> One thing important is this patch allows print from both applications
> and bpf program at the same time. Now we have three kinds of print:
> 1) only BPF program prints
> 2) only application program prints
> 3) both can print without side effect
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Getting back to this thread. It is long, instead of responding to
multiple messages, let me combine them in a single response.


* On future extensions:

+1 that the UDP case, and datagrams more broadly, must have a clear
development path, before we can merge TCP.

Similarly, hardware timestamps need not be supported from the start,
but must clearly be supportable.


* On queueing packets to userspace:

> > the current behavior is to just queue to the sk_error_queue as long
> > as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
> > is regardless of the sk_tsflags. "

> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> read the skb from the errqueue but are not able to parse the
> timestamps

Before queuing a packet to userspace on the error queue, the relevant
reporting flag is always tested. sock_recv_timestamp has:

        /*
         * generate control messages if
         * - receive time stamping in software requested
         * - software time stamp available and wanted
         * - hardware time stamps available and wanted
         */
        if (sock_flag(sk, SOCK_RCVTSTAMP) ||
            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
            (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
            (hwtstamps->hwtstamp &&
             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
                __sock_recv_timestamp(msg, sk, skb);

Otherwise applications could get error messages queued, and
epoll/poll/select would unexpectedly behave differently.

> SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
> features including cmsg mode. But it will not be used in bpf mode. 

For simplicity, the two uses of the API are best kept identical. If
there is a technical reason why BPF has to diverge from established
behavior, this needs to be explicitly called out in the commit
message.

Also, if you want to extend the API for BPF in the future, good to
call this out now and ideally extensions will apply to both, to
maintain a uniform API.


* On extra measurement points, at sendmsg or tcp_write_xmit:

The first is interesting. For application timestamping, this was
never needed, as the application can just call clock_gettime before
sendmsg.

In general, additional measurement points are not only useful if the
interval between is not constant. So far, we have seen no need for
any additional points.


* On skb state:

> > For now, is there thing we can explore to share in the skb_shared_info?

skb_shinfo space is at a premium. I don't think we can justify two
extra fields just for this use case.

> My initial thought is just to reuse these fields in skb. It can work
> without interfering one another.

I'm skeptical that two methods can work at the same time. If they are
started at different times, their sk_tskey will be different, for one.

There may be workarounds. Maybe BPF can store its state in some BPF
specific field, indeed. Or perhaps it can store per-sk shadow state
that resolves the conflict. For instance, the offset between sk_tskey
and bpf_tskey.


