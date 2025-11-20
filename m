Return-Path: <bpf+bounces-75162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D98C7411A
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB1CA34D106
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF6338596;
	Thu, 20 Nov 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S7aqdZIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B5330339
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643507; cv=none; b=rg9QE1OAea4VQ6rysgTHgjPQOc1/iE2MN97O9Wnq5lmpABu2VNC3mqKzQFbL2liZuDliuez5oH0QgXttjSvLW5d2o9D4qxllG9sag8yXQ7zseb5pZoYVOtPqZl9SJUmYz/T/Zq+6PTTFgwm1g2Kirdj+HOf/MiMM9TZi5uiyjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643507; c=relaxed/simple;
	bh=yrrGT9RTCWN6v25Jy1PljEJyV2gwJA+0BkSczHJvwqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jy9uJz49Pud4WXsNoM4YkUdXwfdMEPL0QdqEe39Enxnxtp8FrfJrGMKAVE+ujMCVcW8XGCnQfRzlTB+Aa83hdYO0rvZq/maodJsMtl8+DOv5+eNGaBPmPEHs4lwR593LyU6mg7oyv5WlQqH7ElkBZUoxn/jsLmBopXFwh3rNuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S7aqdZIp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b727f452fffso333267866b.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1763643505; x=1764248305; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=S7aqdZIpeni1IEmbAnYHWLn6J0Yx8fLyUQLq2Ef1J/WrTksSv4BxKoCb2jI/FILfsc
         wyaUpjWBz/BvwJf4kYQD+NiacTMcuF09mbR03g0xKuuaaEcWUZY0ezk7DscGdzobZBO6
         IejvOvDsDPo+JaQVnqpns0r6JcuL9O4F+ZfF+ihHVAdz8YI6A1CahTv31/CKHY/LU9yC
         Ov/M4kmm+073daycX90GqfpCkJQ+/Rqz6Nk1cqbwvLkKyIQamctisqo/ubcf2I2VwrkS
         B6PboTQVBrKutFNcyknsISoH0nwmw1SMBJHDkNKOFWc7T+QzZ4j5bkqBE+4pRTwWedRc
         Odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643505; x=1764248305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=t6tsEJUjZ6JLFLMIxIS9Ne5Wb3wTm8/1lHeADEUMbiamIsiGb2h9mtv8eulhLtCmBd
         WI1nerTMMi/Cgjf+Xpmc80dVV5RVmJTWvg1aGI8bSIP4jU3UpXIrHVPOpveDaywFLx/R
         EH6CpcEOIW9mHYPFMhoyrkUP8rBv7xYj4uniRHg3qQ+BouyMmuuAFqZ0MRUa+WSFj7o/
         HsqAJpDuKWkNwqngiqFonGY4rRarEfX3nF5MVAfdSHuiCwd3fU38fAU2hwVx8AsMtaht
         tagCwDZ+1SJREMx44snbBFKM7hNxtP5K54H1i/nyf8XxOCfTTaHnsNdOGSdb+TxfTMc1
         s9fg==
X-Gm-Message-State: AOJu0YwOFC2WnWKjF8qf5KGZgt2xKx9O6pPVsx3KdoirWs8x/XdXL0dV
	8SnIAfqIRGt4Bc8FOWrm5zRkLl34c5ebCadglx6DsmwxWoji06Bkns1UdHz8ek1L/TPPgDdT8FB
	+EeK8
X-Gm-Gg: ASbGncuj3MbRgmlS7V5K4T4e23TCUyX5Brgi6VlgC7l8OdLOzpKK0GX19RZjNTPIOT3
	WPNy8YKwnAMbwOAp65CpkGjpKlRXbJ9kl/hlk0LOtrULfVtPy1U3hiEH5GRmE3fLHqTihJo0BKd
	2Wga1NZbDsjkC0jCDJpgmlcKhJivbMLn7DTeX9s1EDcl7dPKYrnyXnh8p3R5T69CaCnIDw0G9nT
	/a+QGV4R5XjWhO1prO12BHbG3KZaBFv0YOxzUgMNk1jp4M3DIIizwjEO1VruyzJoZWxA5rzOxGI
	V7G/kJp6Qn+44s7QOhyi8dnxc4Oml77EsvSmfVo3WZwAKi0e7glf903EIcCxVvqAZiyKpCuaE6n
	rz/byDAPPm7B+USjIjjMy0eBsxHNWb6Kv1z1Onx/v2sAxQoRH2IkaHIs2XphNOoiJmuEZqGpQ67
	aVrMQ=
X-Google-Smtp-Source: AGHT+IGx1D4Lf3+ONX9DYRjufCOc1Fw/EfSu7B0mNDhtvWXtJYLURbexh3sFGvbZtkfpHNbDzHlRQg==
X-Received: by 2002:a17:907:9487:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b765720a6e1mr306820066b.17.1763643504589;
        Thu, 20 Nov 2025 04:58:24 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm201000466b.42.2025.11.20.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:58:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  "John Fastabend" <john.fastabend@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Simon Horman" <horms@kernel.org>,  "Neal Cardwell"
 <ncardwell@google.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "David
 Ahern" <dsahern@kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Daniel Borkmann" <daniel@iogearbox.net>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Martin KaFai Lau" <martin.lau@linux.dev>,  "Eduard
 Zingerman" <eddyz87@gmail.com>,  "Song Liu" <song@kernel.org>,  "Yonghong
 Song" <yonghong.song@linux.dev>,  "KP Singh" <kpsingh@kernel.org>,
  "Stanislav Fomichev" <sdf@fomichev.me>,  "Hao Luo" <haoluo@google.com>,
  "Jiri Olsa" <jolsa@kernel.org>,  "Shuah Khan" <shuah@kernel.org>,
  "Michal Luczaj" <mhal@rbox.co>,  "Stefano Garzarella"
 <sgarzare@redhat.com>,  "Cong Wang" <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev> (Jiayuan
	Chen's message of "Thu, 20 Nov 2025 02:49:43 +0000")
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
	<20251117110736.293040-2-jiayuan.chen@linux.dev>
	<87zf8h6bpd.fsf@cloudflare.com>
	<5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev>
Date: Thu, 20 Nov 2025 13:58:23 +0100
Message-ID: <87tsyo6ets.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 20, 2025 at 02:49 AM GMT, Jiayuan Chen wrote:
> November 20, 2025 at 03:53, "Jakub Sitnicki" <jakub@cloudflare.com mailto:jakub@cloudflare.com?to=%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.com%3E > wrote:
>
> [...]
>> >  +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data needs to be
>> >  + * redirected to the ingress queue of a specified socket. Since BPF_F_INGRESS is
>> >  + * defined in UAPI so that we can't extend this enum for our internal flags. We
>> >  + * define some internal flags here while inheriting BPF_F_INGRESS.
>> >  + */
>> >  +enum {
>> >  + SK_MSG_F_INGRESS = BPF_F_INGRESS, /* (1ULL << 0) */
>> >  + /* internal flag */
>> >  + SK_MSG_F_INGRESS_SELF = (1ULL << 1)
>> >  +};
>> >  +
>> > 
>> I'm wondering if we need additional state to track this.
>> Can we track sk_msg's construted from skb's that were not redirected by
>> setting `sk_msg.sk = sk` to indicate that the source socket is us in
>> sk_psock_skb_ingress_self()?
>
> Functionally, that would work. However, in that case, we would have to hold
> a reference to sk until the sk_msg is read, which would delay the release of
> sk. One concern is that if there is a bug in the read-side application, sk
> might never be released.

We don't need to grab a reference to sk if we're talking about setting
it only in sk_psock_skb_ingress_self(). psock already holds a ref for
psock->sk, and we purge psock->ingress_msg queue when destroying the
psock before releasing the sock ref in sk_psock_destroy().

While there's nothing wrong with an internal flaag, I'm trying to see if
we make things somewhat consistent so as a result sk_msg state is easier
to reason about.

My thinking here is that we already set sk_msg.sk to source socket in
sk_psock_msg_verdict() on sendmsg() path, so we know that this is the
purpose of that field. We could mimic this on recvmsg() path.

