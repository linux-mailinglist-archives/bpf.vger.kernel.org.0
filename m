Return-Path: <bpf+bounces-15813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4808F7F75AC
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7964D1C21095
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5E2C854;
	Fri, 24 Nov 2023 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CSlCy3vm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DAD71
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 05:53:44 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a02d91ab195so274358166b.3
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700834022; x=1701438822; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bPYBdZ4ItIfXHITMkeTq4Bl+yk6j2zAle2zwSmDGCiE=;
        b=CSlCy3vmpAK9Xa7vG2XkYYMDhnrzFMUw+MmjZ4KxW/Ey+9J6AuuuLtWeZtUlglp0A2
         N3UyMGKB1/oXNRpAgYguNX8r8vntT/u5leSwEcJD+nubCnDa2S7kOh4aL6XPLEctDnFP
         ApbYgL9iqUwI/XWzCJ3i7kwf61KGbg/5aJoT+0MfOW9ocK+M5yKFo6IxRYWxQ6RvSnPR
         oN/1ZN2iVdpT1ObltM80a7L+N+IZO5gEjgYgT4Ichr8e1IcKqigv5kiTkDMBizekrx4+
         60P/ZFTj22nTq4EEEBrNgc6XTxrWEHK6XvSH+Te90E41iqyam9ByGhKxMBMl+8NfNxZ9
         wSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834022; x=1701438822;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPYBdZ4ItIfXHITMkeTq4Bl+yk6j2zAle2zwSmDGCiE=;
        b=g+/NDrIkO6U5I4pnR/wihWA8sQ+7ufsndZef1SktLpEKXcGth5u41CGDnWBiUpL2tG
         fFFFgraijwy4ZEPuBKEWT9WXo9blkb2DKv7GNA0nazM+Oqnsp5FeYve7HfPdBpJ/oG6u
         YRN/aRZp0eGPKKkfUFUa8FCBEbIMWq0hob55mXSh49Dw2kxfBsv1IpcZANrhh8YbqXBy
         N7HclevsvZP7ofrwmfGw4CNMstaVASVy2pKVDoEF7lIT81cuSzicrj2Znj0gts7lGyhf
         gQUePSi3nB7CTGOi7SOgbIKXndMWpcCcBZB/yIqMP/IO1XVR0AYu6W+WOxTeMcG0dm6Q
         LYHQ==
X-Gm-Message-State: AOJu0YzXPekdnYQyplLH2yc/hzX7CSi9Zg9/Z9WCcHpCE01uQWAm02Vq
	Dob0gZc18XB2XKHXbxe3NVnOX/mXTIOfGc6lxlA=
X-Google-Smtp-Source: AGHT+IHT1u7eoX5hY4Xg63LmKH9zDr2fIVDbIuCFbsbxe+I7C5HM3eY56BlqM8wGTordlZj6XssmTQ==
X-Received: by 2002:a17:907:9009:b0:9fe:458e:a814 with SMTP id ay9-20020a170907900900b009fe458ea814mr1915902ejc.21.1700834022459;
        Fri, 24 Nov 2023 05:53:42 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id kg16-20020a17090776f000b00a0371c6cc23sm2092349ejc.95.2023.11.24.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:53:41 -0800 (PST)
References: <20231122192452.335312-1-john.fastabend@gmail.com>
 <20231122192452.335312-2-john.fastabend@gmail.com>
 <ZV+07PlDoxrcAn9c@pop-os.localdomain>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, martin.lau@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: sockmap, af_unix stream sockets need to
 hold ref for pair sock
Date: Fri, 24 Nov 2023 14:43:24 +0100
In-reply-to: <ZV+07PlDoxrcAn9c@pop-os.localdomain>
Message-ID: <87zfz32r6j.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Thu, Nov 23, 2023 at 12:24 PM -08, Cong Wang wrote:
> On Wed, Nov 22, 2023 at 11:24:51AM -0800, John Fastabend wrote:
>> AF_UNIX stream sockets are a paired socket. So sending on one of the pairs
>> will lookup the paired socket as part of the send operation. It is possible
>> however to put just one of the pairs in a BPF map. This currently
>> increments the refcnt on the sock in the sockmap to ensure it is not
>> free'd by the stack before sockmap cleans up its state and stops any
>> skbs being sent/recv'd to that socket.
>> 
>> But we missed a case. If the peer socket is closed it will be
>> free'd by the stack. However, the paired socket can still be
>> referenced from BPF sockmap side because we hold a reference
>> there. Then if we are sending traffic through BPF sockmap to
>> that socket it will try to dereference the free'd pair in its
>> send logic creating a use after free.  And following splat,
>
> Hmm, how could it pass the SOCK_DEAD test in unix_stream_sendmsg()?
>
> 2285                 unix_state_lock(other);
> 2286
> 2287                 if (sock_flag(other, SOCK_DEAD) ||
> 2288                     (other->sk_shutdown & RCV_SHUTDOWN))
> 2289                         goto pipe_err_free;

The quoted UAF happens after unix_state_unlock(other):

  2285                  unix_state_lock(other);
  2286
  2287                  if (sock_flag(other, SOCK_DEAD) ||
  2288                      (other->sk_shutdown & RCV_SHUTDOWN))
  2289                          goto pipe_err_free;
  2290
  2291                  maybe_add_creds(skb, sock, other);
  2292                  scm_stat_add(other, skb);
  2293                  skb_queue_tail(&other->sk_receive_queue, skb);
  2294                  unix_state_unlock(other);
  2295                  other->sk_data_ready(other); <-- UAF

Although, I think I saw it happen at unix_state_lock(other) as well.

We don't hold a ref on other, so we're racing with __sock_release /
unix_release_sock.

