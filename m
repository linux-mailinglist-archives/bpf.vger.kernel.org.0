Return-Path: <bpf+bounces-10480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8837A8B28
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A011B20521
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD408450D5;
	Wed, 20 Sep 2023 18:07:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202EE1A58E;
	Wed, 20 Sep 2023 18:07:12 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D23B9;
	Wed, 20 Sep 2023 11:07:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27659684a4dso9818a91.2;
        Wed, 20 Sep 2023 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233228; x=1695838028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDKh24qGZmK3VNmfI6pHneYOw8sTqAGZ08zaO3vUY08=;
        b=mKWFyrE3fcHWUXqYQJ+756xGV+scAmbvRp8bSSf7TTNqcB0zfxdCU09WDMY33Tm0Hf
         KjZqzxBG2L4nomB1VSFEoHMNqIRbkzMN7gYg3wX2dSNCHbBsvxiwWluDSWc0iH0dqJZG
         q3j15R9oGhWm+3FZskcY3R+o7b46HViTRmyrJC0k7pyGq7UexLqxfgQOL2Qaxe4wYEAg
         LfyJ3xokQP0xI1aSZe9OWYTHoRcvFo7qsnhOI16/KVstu7Z+2TGA6YKnvWAtKxY9KnqX
         lqnseNfwiAseb3G10Oj9VAphBy5vJ373AUnyagHNrDonxSHXM+493SvL0VwaSnyymsIy
         wDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233228; x=1695838028;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CDKh24qGZmK3VNmfI6pHneYOw8sTqAGZ08zaO3vUY08=;
        b=mWHCjTyGaCW1N9ikN8PWkwyCIJA6ZA+z48RAinU3oA2W59Hcv7TC1YBMXSa0CLNMw2
         SNGDseHMCnNE44iNl0tImOATHJ3z9sf5e6TeHa1uhWQ01Hebfw7CxWXrGMjwDMCdxKms
         6Y1sFfs6qxpZgHK+l5y3H0pvR6Jj1HPUEvDWHUzOHCcbwgs3sMuxhH78VZOv+mDUMsEV
         aOpTTvokJFJnKt8ubsxk+j0et5jQprDkKcM/5HVz3/9Hur0eF1bYqgmD7gU7JcC7mbSV
         clcElI1Y0/1KHcbStEf/L93DWyjLtKZrZraEAqrvcLJBN7kAktOYtZhtoj5dKFUke2iy
         YQqQ==
X-Gm-Message-State: AOJu0Yw6UooVwfon4XrWCViScFPKZ7XpJyqpMfQm51XA+RNbk0oZSxih
	J8Qz6Fmw0AWHRqBPvq5+4Ew=
X-Google-Smtp-Source: AGHT+IG/+wNDk+YZF0QHGDzP11GIgMoPE7UBbmKOTDz0g6UAKMB8WNjGCGHDubSoqPSGbz4LwjPY0g==
X-Received: by 2002:a17:90a:ec0f:b0:274:2906:656a with SMTP id l15-20020a17090aec0f00b002742906656amr3273183pjy.5.1695233228412;
        Wed, 20 Sep 2023 11:07:08 -0700 (PDT)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1611861pjo.13.2023.09.20.11.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:07:07 -0700 (PDT)
Date: Wed, 20 Sep 2023 11:07:06 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, 
 Ma Ke <make_ruc2021@163.com>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <650b34ca2b41c_4e8122080@john.notmuch>
In-Reply-To: <dc84f39f-5b13-4a7d-a26c-598227fd9a42@gmail.com>
References: <20230918093620.3479627-1-make_ruc2021@163.com>
 <dc84f39f-5b13-4a7d-a26c-598227fd9a42@gmail.com>
Subject: Re: [PATCH] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kui-Feng Lee wrote:
> 
> 
> On 9/18/23 02:36, Ma Ke wrote:
> > It seems that elements in sockhash are rarely actively
> > deleted by users or ebpf program. Therefore, we do not

We never delete them in our usage. I think soon we will have
support to run BPF programs without a map at all removing these
concerns for many use cases.

> > pay much attention to their deletion. Compared with hash
> > maps, sockhash only provides spin_lock_bh protection.
> > This causes it to appear to have self-locking behavior
> > in the interrupt context, as CVE-2023-0160 points out.

CVE is a bit exagerrated in my opinion. I'm not sure why
anyone would delete an element from interrupt context. But,
OK if someone wrote such a thing we shouldn't lock up.

> > 
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >   net/core/sock_map.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index cb11750b1df5..1302d484e769 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -928,11 +928,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
> >   	struct bpf_shtab_bucket *bucket;
> >   	struct bpf_shtab_elem *elem;
> >   	int ret = -ENOENT;
> > +	unsigned long flags;
> 
> Keep reverse xmas tree ordering?
> 
> >   
> >   	hash = sock_hash_bucket_hash(key, key_size);
> >   	bucket = sock_hash_select_bucket(htab, hash);
> >   
> > -	spin_lock_bh(&bucket->lock);
> > +	spin_lock_irqsave(&bucket->lock, flags);

The hashtab code htab_lock_bucket also does a preempt_disable()
followed by raw_spin_lock_irqsave(). Do we need this as well
to handle the PREEMPT_CONFIG cases.

I'll also take a look, but figured I would post the question given
I wont likely get time to check until tonight/tomorrow.

Also converting to irqsave before ran into syzbot crash wont this do the
same?

> >   	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
> >   	if (elem) {
> >   		hlist_del_rcu(&elem->node);
> > @@ -940,7 +941,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
> >   		sock_hash_free_elem(htab, elem);
> >   		ret = 0;
> >   	}
> > -	spin_unlock_bh(&bucket->lock);
> > +	spin_unlock_irqrestore(&bucket->lock, flags);
> >   	return ret;
> >   }
> >   

