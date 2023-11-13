Return-Path: <bpf+bounces-14981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C97E98A9
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC68280C1E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484851945F;
	Mon, 13 Nov 2023 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FK7GQuuK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215418629
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 09:15:02 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B510D4
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 01:15:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e62f903e88so402931566b.2
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 01:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699866899; x=1700471699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqAj+/4HsfM/OT/pOYkHTVyOzGslgKaR3cwh79ZR6fY=;
        b=FK7GQuuK8TWlQ4aD8A94WNnTZoVagDZmt4CC2ey6TH4niJeGb/iZECGBLZgGNGP8uJ
         jyqz4DjKiq+bynG+Z407+3tqLBj/dMU/b+fSNKBJURs/WvO9DP/b2ADTW+9K4DItm0Bm
         8mOfuiaQlDHCutTWsXbpTtCswc2d2U3ydzB78BD+m4JmUCZJiVf6dCVWNsJ5QTVivJpK
         vXoky4pNn10uMCBBndyaDfm6GgwNN4jZs8lzbNiLXGQMAbEoXLeekEF5r48dgqWaBGZj
         SOwwGwrbOL5VpBNhMtnIhVtjoqSRoayRfwY41gZRy5sGrvSVtsrVpPAeDnKYEwJs7JQI
         uAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699866899; x=1700471699;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nqAj+/4HsfM/OT/pOYkHTVyOzGslgKaR3cwh79ZR6fY=;
        b=NAq9NchsvwOOjgaro3wbkFik1maujwWyqBryl3LpQISXnkkcp2QoJQBYGxHXIJ4R/m
         yT1aibum4s3uiqTA0CB1dAb5bT0wtPhKZCrPRAab2BIHcYJd9XdprMkxb8Chqr6MVbuh
         8IVENGb4x5cweRvVtB63KcPs6bAauwIgpU0IdtvVVxC9BzILOAa9Me8I+J3Mvuw9NRLw
         cl42xs/lsPmC9B8Z0qWBBzRJgIIbR0Z8fRqPQtohSvJV+HYJD8bh4wcsXIJcsuDu1bqJ
         WXRJsj3qVTfWfibuYJsFtku09D2OFyAaidHWoo21Ieap8FmcNpovKIdugT70XuNt/BSl
         u1fg==
X-Gm-Message-State: AOJu0YwUEX1e+3hB63yoiIwkjvzDypIO6tWGUqbeLlwHLl4wcomep6mW
	On50+gvsEf+OasyGTIgLSFi9Tg==
X-Google-Smtp-Source: AGHT+IF91kjZK5fwVZ7M3Yyq/JWUwfv0MwrVNqHO3XYQbozA8HYRB9ZT/pav1qQGNNomdXGamb7vbg==
X-Received: by 2002:a17:906:e4e:b0:9e3:f97b:239e with SMTP id q14-20020a1709060e4e00b009e3f97b239emr4394231eji.29.1699866898707;
        Mon, 13 Nov 2023 01:14:58 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1e2])
        by smtp.gmail.com with ESMTPSA id lx20-20020a170906af1400b009e5f5efac10sm3655209ejb.208.2023.11.13.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 01:14:58 -0800 (PST)
References: <1699609302-8605-1-git-send-email-yangpc@wangsu.com>
 <CAADnVQL=8-ViD7vPy4tQ1Ek6TzC24aMVFwt4_k0Jc7igz-5Jkw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Pengcheng Yang
 <yangpc@wangsu.com>
Cc: John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, sockmap: Bundle psock->sk_redir and
 redir_ingress into a tagged pointer
Date: Mon, 13 Nov 2023 10:02:49 +0100
In-reply-to: <CAADnVQL=8-ViD7vPy4tQ1Ek6TzC24aMVFwt4_k0Jc7igz-5Jkw@mail.gmail.com>
Message-ID: <87y1f2f20f.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 07:42 AM -08, Alexei Starovoitov wrote:
> On Fri, Nov 10, 2023 at 1:44=E2=80=AFAM Pengcheng Yang <yangpc@wangsu.com=
> wrote:
>>
>> Like skb->_sk_redir, we bundle the sock redirect pointer and
>> the ingress bit to manage them together.
>>
>> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Link: https://lore.kernel.org/bpf/87cz97cnz8.fsf@cloudflare.com
>> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
>> ---
>>  include/linux/skmsg.h | 30 ++++++++++++++++++++++++++++--
>>  net/core/skmsg.c      | 18 ++++++++++--------
>>  net/ipv4/tcp_bpf.c    | 13 +++++++------
>>  net/tls/tls_sw.c      | 11 ++++++-----
>>  4 files changed, 51 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index c1637515a8a4..ae021f511f46 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -78,11 +78,10 @@ struct sk_psock_work_state {
>>
>>  struct sk_psock {
>>         struct sock                     *sk;
>> -       struct sock                     *sk_redir;
>> +       unsigned long                   _sk_redir;
>
> Please don't.
> There is no need to bundle them together.

Seeing how the code turned out, I agree - it didn't work out.
Code is not any simpler. My gut feeling was wrong here.

I gotta ask for, for the future, though -
this is not a "no" to tagged pointers in general, right?

