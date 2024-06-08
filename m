Return-Path: <bpf+bounces-31631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABE901011
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0412B20FE4
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81A176AA9;
	Sat,  8 Jun 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS+liKGk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40481D52E;
	Sat,  8 Jun 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833698; cv=none; b=OaFT6pxAVjEVlor0v437HOS4nxL8YHAojWLQyQG/F1IyakuMlopVdvdWsWsyZjS/B3jtUPPpX89sMH1J4gaTIG2tIhYSO+XlU+4qz41IfRAxin3A9sNQ7APAJqtzdlkfPCHibGda9NKy2HjMQGqpuvtF3I657ar0YsFmFh0HlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833698; c=relaxed/simple;
	bh=g/c4SrbQzg+FfdOpRuQubqswZqRcZAYzy85tSaRem5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2dQ+JXpxDlkjXbC5NKZ2t5aIq2gqfTeE6/ZskptTnqCs4y2Ox7C+JKViVjogWnx0chsRgu/hAsCUXdH6+TRxlJNG4mUsNoJxMtucSs85Is6evtdTHVFsTARiqjSHtHKPWQ2kpU2+EYH0j76DgP2KNE1ZWwTae9Jrf02FHjuB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS+liKGk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f04794973so171830f8f.2;
        Sat, 08 Jun 2024 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717833695; x=1718438495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAWRNp7GKfl35ZF8idBIG8xWUMfDU98RNdFO1Bq1Bew=;
        b=XS+liKGkbc5GLthjlMsBrEkK6SpJuh72O7AdbAAJZeBX/LrjbiuYDjlE8mC9sfmIzT
         aI8js7tYHiNwmalqa9pwRIe9hjANM2D/+RVPNDwcO6YmiA4EHqhV/oMMJcX4SZgb7b0r
         HCw/JxB+B2reDU4B/up2HmIDzu3pgxZJYPKjFe+hl/3HzD1TfZqPPcaiiJbbfQcA0okM
         CczXaCyB5r/ev6FC38q7Ba1uhgSAYK+2xTKSksJQ5c3WsZJ5JOW+xqpiX2FP52W89A5a
         OB3gru+TFgjaSKrh6uvew7JMzbfxFxJLLgz7UqvEWuDlXVyKOxCX6253jEtlKok8obYO
         LKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717833695; x=1718438495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAWRNp7GKfl35ZF8idBIG8xWUMfDU98RNdFO1Bq1Bew=;
        b=mwolvdIKtAclnEXllm1DxWdI5K2tD2567+VoHXOi0GhM4NegzzoUKq9rY6FE8Bfjed
         ZiK6yoU+Uo9HLzjx/p2c6qGir4ohps7Pr+KZ3XdHexvHsYY4LRSxnD9xPcQ2JpWHfUpD
         Lk/A+DJmhTdPjP843sVjmks7QPj49a3c9c7iKntYn46o6ue7CgQIa9sTqaRMoNgue1Rq
         W3D529W5NqTGk8YWeaGOeSMjwycjBjcyPKoLuphNynLwpsMzxhoFXDHnMSGqw1iuH31H
         KJy6ChQzbXFJQxK8KzzxvQriS7v8DtjfdFrzPkccFDtsAc1rmKgija0iJf68wbC6Jjq5
         UbQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHfkiDHsRVNLxz86i00SJ7bmpZeNIaSSRc3uMgRmMF1cUVDP7UlfZP21dRuzj3FgTpeB1kgBS6WbwDzPZnqY3oGqdRQwSZ
X-Gm-Message-State: AOJu0Yx/OnPcmT+PHzW0VmeExFC93inLb7qO2IGOLHJsdUUXrrlqJO9y
	kfoNFzKe8Y8TRU+4Gnd/pesb8J2AHrt5QB3R+wOwm76FLhzF8so8
X-Google-Smtp-Source: AGHT+IEFkAJT5BhsNxGrQC0qHpBzy21JRBZ/1c5X0rWvucd0vtvW9koJU+RzMMrz8eeaTKXctPpM0g==
X-Received: by 2002:a05:6000:1845:b0:35e:f234:695c with SMTP id ffacd0b85a97d-35efee132fdmr3459197f8f.5.1717833695175;
        Sat, 08 Jun 2024 01:01:35 -0700 (PDT)
Received: from [10.0.0.4] ([37.166.160.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d2e73dsm5749638f8f.16.2024.06.08.01.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 01:01:34 -0700 (PDT)
Message-ID: <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com>
Date: Sat, 8 Jun 2024 10:01:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] net: remove the bogus overflow debug check in
 pskb_may_pull()
To: Kuniyuki Iwashima <kuniyu@amazon.com>, xiyou.wangcong@gmail.com
Cc: bpf@vger.kernel.org, cong.wang@bytedance.com, fw@strlen.de,
 netdev@vger.kernel.org, syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
References: <ZmMxzPoDTNu06itR@pop-os.localdomain>
 <20240607213229.97602-1-kuniyu@amazon.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20240607213229.97602-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/7/24 23:32, Kuniyuki Iwashima wrote:
> From: Cong Wang <xiyou.wangcong@gmail.com>
> Date: Fri, 7 Jun 2024 09:14:04 -0700
>> On Fri, Jun 07, 2024 at 01:27:47AM +0200, Florian Westphal wrote:
>>> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>
>>>> Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
>>>> helpers") introduced an overflow debug check for pull/push helpers.
>>>> For __skb_pull() this makes sense because its callers rarely check its
>>>> return value. But for pskb_may_pull() it does not make sense, since its
>>>> return value is properly taken care of. Remove the one in
>>>> pskb_may_pull(), we can continue rely on its return value.
>>> See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
>>> without this check, I would not give up yet.
>> What's the point of that commit?
> 4b911a9690d7 would be better example.  The warning actually found a
> bug in NSH GSO.
>
> Here's splats triggered by syzkaller using NSH over various tunnels.
> https://lore.kernel.org/netdev/20240415222041.18537-2-kuniyu@amazon.com/


Right. We discussed this before. I guess I forgot to send the fix.

Florian could you submit the suggestion I made before ?

diff --git a/net/core/filter.c b/net/core/filter.c
index 
358870408a51e61f3cbc552736806e4dfee1ec39..da7aae6fd8ba557c66699d1cfebd47f18f442aa2 
100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
  static inline int __bpf_try_make_writable(struct sk_buff *skb,
                        unsigned int write_len)
  {
+#if defined(CONFIG_DEBUG_NET)
+    /* Avoid a splat in pskb_may_pull_reason() */
+    if (write_len > INT_MAX)
+        return -EINVAL;
+#endif
      return skb_ensure_writable(skb, write_len);
  }



