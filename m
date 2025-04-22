Return-Path: <bpf+bounces-56439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E827A97427
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7117FE84
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45F28FFF1;
	Tue, 22 Apr 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Dt4dyTyU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43213C3F6
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344979; cv=none; b=GoTnIvKP5qpnJ25I2akY4hZLEaiO4eVbqr6OJTzsPlcX/c7nLkehT14n8c6Ma6bQ8htnS+2qsP67yHacwa5G1b+IkctY2QMCjpapKwkXoo3TmIYVm+qnF/Je6GD+vJLQY8GlpBNO1dRGzvJAWmJNTtprJjGqi8TBbsKiF3Ub6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344979; c=relaxed/simple;
	bh=WAs+NuCxj8WdRkOx9f7miDklbtxSv9P3D/mG+h9CUJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je8qeQDibYUeAG9dKtT/jphOxDeD6unJXyyESxwF26RBdPLZufVGH/974e/mPgge0TGF5wrkupWFQYEXyBOAcUEkmVQOklek0AAL6bakcU/DyXTWYzKAppYqSoLiIYoe8pWERRiYEeUAzJBiGykx3dRfCdELD/x4gBdNirF7gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Dt4dyTyU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c548db0aa0so90557185a.0
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745344976; x=1745949776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H5nFTLoL+R25NN9eNHi2V0bKLHvKWCD8JAk7cq5TMWU=;
        b=Dt4dyTyU3grXt+iW0PssueYgARSZs9VunpdtEtZ7EAL2l+MCY2wA2r8TDdoNG7UBc0
         lbugAfKfxG693QUevuYoXHsX9IOaBu1MwT31zTfY8z00743HEijnRUQnqd8wc8sWR5wu
         dYsdf8iAjpLSOvDWFUxzoLlcJ+PPSSyHQ/q7AcVznwPW01LTr/AcIdz2cCemUQhFGNgH
         E5dKCAgc0/LQx8Bf6/jVHqbWQr5lXq+t1a5FRTAltXIljoRehCXvt7zbTfEgZOel3Y+8
         j/otjrYKJ0sXHhiEBGRURRvEkdPoEt7i7apKFbhhNhKZ23cstl0/hPmdNE/oXvaGJlxG
         QisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344976; x=1745949776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5nFTLoL+R25NN9eNHi2V0bKLHvKWCD8JAk7cq5TMWU=;
        b=IkeAKf0OkkNK6tU9zYZuuRpKTAsD44Eq/s0gzOZmJR+vcEUWbDuQSrQT9oeL34HwFf
         Dc00fvDvc1kjbb8c0bRABT4duobD5632rY8qJF6ljMjaIkwjK8PWoHfrMwTl2s0yyy2h
         7q2IcaAS4GgH/V3hbsJOzF1cM7SCOJDUZFwRALOVj/otVn3FsK9dMoZ18D0x4XCAq2rI
         2jMT5fgobOCMEoi2vZAvlWvara9wV6Z06ft96WACPlwmjI2s7JRq6berPe24S2tlytAX
         X7EOvJR1KntjL26lrLVPAZSSzXLQUwjZTHH0Hko+PhtfHvxplNWTGXcjMkkrnWDJ81nw
         MMQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlh1rydkSQBmF5lnTgZu5CfvBjo7/0xoh1JDlLHlPEpGWSweIc2J+Sa6rsFocwJrDYsRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrvSLle+3K/sBtVd9sfHiU16b9nxODzrUExsNOaqwVOUWe87X
	5cRcGHpxTNrnJ2qBsPO5pV9Pg/lxeyGC0/ntqOGkGz7tMtT5OTE0GfL7aNEg2eKKuzCeh00fbv7
	mn97lN0eJh+RV0TUHs6Fq/6c97llPAmHdv25urHplXaznBGdWTRw=
X-Gm-Gg: ASbGncswsgo2BiekoCXVhTQmJQL8rPKEShg8Sp3RNDohRwgDyOHAQILhoTAXgzXW+nV
	8mO0CW+jnxyXF/CZS1iQ9w/bQaaLTJhtIwrCpVMHP6es5WCyrXuj0ATmkhwSW07YGwJGa7Ycp36
	Wo/nSJ3sUYB4jBxic9sTfqNPsXQUwgHO5jYhajlzz1TSOKKYslRWMq
X-Google-Smtp-Source: AGHT+IGiFSkdqkBYwCT3EOv3NM38i3PGKYqCIF+uKgdpGcY0COw1JaiVy7jQJvyP/RezYUG6J+1rqMRDBG4cxu7i3xg=
X-Received: by 2002:a05:6214:d03:b0:6e8:ef41:a0eb with SMTP id
 6a1803df08f44-6f4b47829dcmr368786d6.11.1745344976192; Tue, 22 Apr 2025
 11:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419155804.2337261-1-jordan@jrife.io> <20250419155804.2337261-3-jordan@jrife.io>
 <e3b08fdc-8a10-4491-a7a3-c11fed6d15ae@linux.dev>
In-Reply-To: <e3b08fdc-8a10-4491-a7a3-c11fed6d15ae@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 22 Apr 2025 11:02:45 -0700
X-Gm-Features: ATxdqUFvAy3HnFkK25P60rCZaC2IAlN6mvhUpzNz9HSe7luSFFGHBZ_C0qE0PqU
Message-ID: <CABi4-ojzWBaKBFDvu_aO2mRppYz46BZxybRXJ8d7sgzqaGtM_Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I found the "if (lock)" changes and its related changes make the code harder
> to follow. This change is mostly to handle one special case,
> avoid releasing the lock when "resizes" reaches the limit.
>
> Can this one case be specifically handled in the "for(bucket)" loop?
>
> With this special case, it can alloc exactly the "batch_sks" size
> with GFP_ATOMIC. It does not need to put the sk or get the cookie.
> It can directly continue from the "iter->batch[iter->end_sk - 1].sock".
>
> Something like this on top of this set. I reset the "resizes" on each new bucket,
> removed the existing "done" label and avoid getting cookie in the last attempt.
>
> Untested code and likely still buggy. wdyt?

Overall I like it, and at a glance, it seems correct. The code before
(with the if (lock) stuff) made it harder to easily verify that the
lock was always released for every code path. This structure makes it
more clear. I'll adopt this for the next version of the series and do
a bit more testing to make sure everything's sound.

>
> #define MAX_REALLOC_ATTEMPTS 2
>
> static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> {
>       struct bpf_udp_iter_state *iter = seq->private;
>       struct udp_iter_state *state = &iter->state;
>       unsigned int find_cookie, end_cookie = 0;
>       struct net *net = seq_file_net(seq);
>       struct udp_table *udptable;
>       unsigned int batch_sks = 0;
>       int resume_bucket;
>       struct sock *sk;
>       int resizes = 0;
>       int err = 0;
>
>       resume_bucket = state->bucket;
>
>       /* The current batch is done, so advance the bucket. */
>       if (iter->st_bucket_done)
>               state->bucket++;
>
>       udptable = udp_get_table_seq(seq, net);
>
> again:
>       /* New batch for the next bucket.
>        * Iterate over the hash table to find a bucket with sockets matching
>        * the iterator attributes, and return the first matching socket from
>        * the bucket. The remaining matched sockets from the bucket are batched
>        * before releasing the bucket lock. This allows BPF programs that are
>        * called in seq_show to acquire the bucket lock if needed.
>        */
>       find_cookie = iter->cur_sk;
>       end_cookie = iter->end_sk;
>       iter->cur_sk = 0;
>       iter->end_sk = 0;
>       iter->st_bucket_done = false;
>       batch_sks = 0;
>
>       for (; state->bucket <= udptable->mask; state->bucket++) {
>               struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>
>               if (hlist_empty(&hslot2->head)) {
>                       resizes = 0;



>                       continue;
>               }
>
>               spin_lock_bh(&hslot2->lock);
>
>               /* Initialize sk to the first socket in hslot2. */
>               sk = hlist_entry_safe(hslot2->head.first, struct sock,
>                                     __sk_common.skc_portaddr_node);
>               /* Resume from the first (in iteration order) unseen socket from
>                * the last batch that still exists in resume_bucket. Most of
>                * the time this will just be where the last iteration left off
>                * in resume_bucket unless that socket disappeared between
>                * reads.
>                *
>                * Skip this if end_cookie isn't set; this is the first
>                * batch, we're on bucket zero, and we want to start from the
>                * beginning.
>                */
>               if (state->bucket == resume_bucket && end_cookie)
>                       sk = bpf_iter_udp_resume(sk,
>                                                &iter->batch[find_cookie],
>                                                end_cookie - find_cookie);
> last_realloc_retry:
>               udp_portaddr_for_each_entry_from(sk) {
>                       if (seq_sk_match(seq, sk)) {
>                               if (iter->end_sk < iter->max_sk) {
>                                       sock_hold(sk);
>                                       iter->batch[iter->end_sk++].sock = sk;
>                               }
>                               batch_sks++;
>                       }
>               }
>
>               if (unlikely(resizes == MAX_REALLOC_ATTEMPTS)  &&
>                   iter->end_sk && iter->end_sk != batch_sks) {

While iter->end_sk == batch_sks should always be true here after goto
last_realloc_retry, I wonder if it's worth adding a sanity check:
WARN_*ing and bailing out if we hit this condition twice? Not sure if
I'm being overly paranoid here.

>                       /* last realloc attempt to batch the whole
>                        * bucket. Keep holding the lock to ensure the
>                        * bucket will not be changed.
>                        */
>                       err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_ATOMIC);
>                       if (err) {
>                               spin_unlock_bh(&hslot2->lock);
>                               return ERR_PTR(err);
>                       }
>                       sk = iter->batch[iter->end_sk - 1].sock;
>                       sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
>                                             struct sock, __sk_common.skc_portaddr_node);
>                       batch_sks = iter->end_sk;
>                       goto last_realloc_retry;
>               }
>
>               spin_unlock_bh(&hslot2->lock);
>
>               if (iter->end_sk)
>                       break;
>
>               /* Got an empty bucket after taking the lock */
>               resizes = 0;
>       }
>
>       /* All done: no batch made. */
>       if (!iter->end_sk)
>               return NULL;
>
>       if (iter->end_sk == batch_sks) {
>               /* Batching is done for the current bucket; return the first
>                * socket to be iterated from the batch.
>                */
>               iter->st_bucket_done = true;
>               return iter->batch[0].sock;
>       }
>
>       err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2, GFP_USER);
>       if (err)
>               return ERR_PTR(err);
>
>       resizes++;
>       goto again;
> }
> static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>                                     unsigned int new_batch_sz, int flags)
> {
>       union bpf_udp_iter_batch_item *new_batch;
>
>       new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
>                                  flags | __GFP_NOWARN);
>       if (!new_batch)
>               return -ENOMEM;
>
>       if (flags != GFP_ATOMIC)
>               bpf_iter_udp_put_batch(iter);
>
>       /* Make sure the new batch has the cookies of the sockets we haven't
>        * visited yet.
>        */
>       memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
>       kvfree(iter->batch);
>       iter->batch = new_batch;
>       iter->max_sk = new_batch_sz;
>
>       return 0;
> }

Jordan

