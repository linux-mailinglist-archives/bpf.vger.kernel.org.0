Return-Path: <bpf+bounces-16864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A1806B0B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 10:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA781C209DF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1288E1C6A0;
	Wed,  6 Dec 2023 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JfWYiQXZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A2FA
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 01:49:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1da1017a09so52261766b.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701856155; x=1702460955; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YqYYX+lt5EEif67Rak16lbjAMvNYu8HrLB23eU/ToBo=;
        b=JfWYiQXZ92tpoJbVCHo0SvWosvx0WAmO7f7km1kq0zQjcQuP6nfZlQLztKJjZqjwL5
         yLc5jjRCktX8PLw56ZTstdFsRR5bnDsJ9BQd7o6Ds8AvhMqSHaoWqJ8AqKm86SIKitCd
         C7YRipj7h6ntR4x2P8bfgsfgaxhMEM0ILi4g0Eyx1AfMxDeGw46sOw/+B/z6sjEQ1ewn
         /1o5sT31Zhwwvx7vPCoZg1Qa/7eqyGHeUybucTR4mKBSE7Ot1u9HkF46RVew5/DmhorW
         doV2bWOhmKUPaVJFx3GCMdXMmFqyVvpOPa9KBgBImJ32treSNn8pMEBBEROO1ZLVNZHA
         f68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856155; x=1702460955;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqYYX+lt5EEif67Rak16lbjAMvNYu8HrLB23eU/ToBo=;
        b=UsYCwAkzivukgM2+ycQoCQjMMhe7pm5i4V2KSmplAn7vkRk3IUlXlYb53RXsl6xYyU
         pdrjcRfYEt6R242XVoFqYkNDO+awBkZnOdoKahGN6L8AMDQtqDu3X4DnJDJkRyxgoq4K
         ZGS8pOASLMVgmS+Tz5VxcX1v56rbtJeBpcTxh4Ywmtu2psOnPmfQjF4YyRyJKuePsWUD
         toqNmWjwXmutAkowGpXByqVvBuLFKJX2j+cTok3ZWlUh4+nW4GHpr9T8vbKQAUrsNH4i
         D9sWB6piQy3YHhg3+XJD9jWnHHf+DGRcOo1d45K2foRb4vDOay4fIdk8SjOyjY1RBb4N
         Xivw==
X-Gm-Message-State: AOJu0YxKGwN74xQLh9ER+tr7zGqt51cRaPnRke0mKu1EciGbPYbAynnD
	9pdq1uZGfOctYfyREYJ2XrLi9VYKZcX0zKW1bFpzBA==
X-Google-Smtp-Source: AGHT+IGZeR8QUNsrYHhXWge70KGc2wwspw1S8hno2oOMEQME2GZL7Ls8H9AMKGFkLdbdniUdMXYORw==
X-Received: by 2002:a17:906:fc03:b0:a19:a19b:7892 with SMTP id ov3-20020a170906fc0300b00a19a19b7892mr376544ejb.85.1701856155371;
        Wed, 06 Dec 2023 01:49:15 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:cb])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906178900b00a1b65249053sm4515395eje.128.2023.12.06.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:49:14 -0800 (PST)
References: <20231201180139.328529-2-john.fastabend@gmail.com>
 <20231201211453.27432-1-kuniyu@amazon.com>
 <656e4758675b9_1bd6e2086f@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, martin.lau@kernel.org,
 netdev@vger.kernel.org, kuniyu@amazon.com
Subject: Re: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in
 unix_bpf proto add
Date: Wed, 06 Dec 2023 10:47:42 +0100
In-reply-to: <656e4758675b9_1bd6e2086f@john.notmuch>
Message-ID: <87msunslt2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 04, 2023 at 01:40 PM -08, John Fastabend wrote:
> Kuniyuki Iwashima wrote:
>> From: John Fastabend <john.fastabend@gmail.com>
>> Date: Fri,  1 Dec 2023 10:01:38 -0800
>> > I added logic to track the sock pair for stream_unix sockets so that we
>> > ensure lifetime of the sock matches the time a sockmap could reference
>> > the sock (see fixes tag). I forgot though that we allow af_unix unconnected
>> > sockets into a sock{map|hash} map.
>> > 
>> > This is problematic because previous fixed expected sk_pair() to exist
>> > and did not NULL check it. Because unconnected sockets have a NULL
>> > sk_pair this resulted in the NULL ptr dereference found by syzkaller.
>> > 
>> > BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430
>> > net/unix/unix_bpf.c:171
>> > Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
>> > Call Trace:
>> >  <TASK>
>> >  ...
>> >  sock_hold include/net/sock.h:777 [inline]
>> >  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
>> >  sock_map_init_proto net/core/sock_map.c:190 [inline]
>> >  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
>> >  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
>> >  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
>> >  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
>> > 
>> > We considered just checking for the null ptr and skipping taking a ref
>> > on the NULL peer sock. But, if the socket is then connected() after
>> > being added to the sockmap we can cause the original issue again. So
>> > instead this patch blocks adding af_unix sockets that are not in the
>> > ESTABLISHED state.
>> 
>> I'm not sure if someone has the unconnected stream socket use case
>> though, can't we call additional sock_hold() in connect() by checking
>> sk_prot under sk_callback_lock ?
>
> Could be done I guess yes. I'm not sure the utility of it though. I
> thought above patch was the simplest solution and didn't require touching
> main af_unix code. I don't actually use the sockmap with af_unix
> sockets anywhere so maybe someone who is using this can comment if
> unconnected is needed?
>
> From rcu and locking side looks like holding sk_callback_lock would
> be sufficient. I was thinking it would require a rcu grace period
> or something but seems not.

I'd revist the option of grabbing an skpair ref in unix_stream_sendmsg.


