Return-Path: <bpf+bounces-55831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA1A874EA
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 02:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13437A6076
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16233FD;
	Mon, 14 Apr 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="t6GWOy2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD217E4
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744588939; cv=none; b=QF85WWtKdHhn+5xvOMBvGN6+yxzZhNXDBXA+tUgl8elFNV4BpZe6SViEYO7CGrQ9f902Enl/iNB3dmc1mXN5GVBjcKtDuDFtKPWANdcojV2n/24ZX6OblM6r1/ky6aFYQivg8NifNlD2ghKxRgsa927i9CMfKJ8gmDj8795N2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744588939; c=relaxed/simple;
	bh=4Oqkr+rpv7H6kt3IBhANjW0bZ7rBvBjcskA+y6OqtEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mawDw2RbdpO/CjR/RuFMJ96vq1EKa66fr1wAdDtu1+W7uIWrBmVwqTLX2ewzhwgCpAt6nq5H7thmXHoQ0RvpX2aLyC+Ri1iAlK/rQHUuQkrGOGXD5kNOiawND85rKSaRClGmOmgk5ObNIN1YfQ9DF8FMfW1WI0QCYUcQl+iKKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=t6GWOy2B; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739ab4447c7so250276b3a.0
        for <bpf@vger.kernel.org>; Sun, 13 Apr 2025 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744588937; x=1745193737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pBqpLJXRxqlQHWXQGJzDZjxbJdMmmwZFwpMlsJTNtM=;
        b=t6GWOy2BNlDBXP9E8Ur0wyB5+OfBkAIxUAPe3yBNQe4bDqVt3/+PCO2H4jiQ51CM+3
         vgjMmz67rifd4KIzIrWZpwyDoy0xtukwQJmybPgvis9GXL9ld0rOLixytohyxyzI56FG
         MfiHe4sQyBzDn5wopQUYeLZHFH29jfo1seaEaK0Y9+8OkaoMF6BmWeunRY1KyYLGEkuT
         QGX+KSuv9o3O2ypqxVDfgTGOK6To36YUa+AkUlsnwlVEPPEcS5LSo4Os5tkiTea0lP3u
         YloNisojNyvqeN2w8PjSTDBC97VLDBufAnB7B0bH43lQPrgx2VyteqmZav8JDrMt9vBT
         a0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744588937; x=1745193737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pBqpLJXRxqlQHWXQGJzDZjxbJdMmmwZFwpMlsJTNtM=;
        b=QDvJUgcxTudfJ2RGigJyoqoJZ/3NfKKRTm7agcccWD+ab4WeqRD1XvV7350P86lbyY
         OeoC6m12eUUETOn7GTY+xW5S9Czjdii5JEaB580bKGh1Z3nc3tZ/4G93iKOaMlGaBP7U
         nHFlvlv67OvaAh4Kkl9SwrqGyKYT0yaPoh4XrDhaM3r9eT5l5AraJ5yXyujytjNLclh1
         mbkfBlmC5C3r4JVYyBXzx2dUaFyJmaGX3jc9UvStXTwGMVP3eENS6f8iSJHeQNcIlK55
         k2qrcAbKLAk3kQRzy67VubYbC8TpJC/X+flLbSrX3IVbFYRwzQ+Sp5/PB1Jpo9ba/duD
         mx8A==
X-Forwarded-Encrypted: i=1; AJvYcCU09IFE11Z5UTGA6Cbea033+nxNn9lTaJCocOADtUZsqPCdKYSG/w0VOFQGBMJ5wTGFfXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3dFyIaCOEN8XW1RVBZMmb11+hAu8h/E9JdIjvGGToQUvmOWj
	vfRazhVdrnRRWwFQZGL4E8RYSpkXO0Y/jv2s1CfC05RikPMJd4u2T4S8bKwBFIo=
X-Gm-Gg: ASbGnctke+19wqcB1npC+jJihEPS672X27mZK+VOrnD79O5jhcNkivUGlg688OK5XWn
	GdwF2fZZUvQtEP8fGGtgYmNrx/PMzt/E4C+DLz9IHXiorU6XxAfeCcT47RAozVGlHRv56+5+5Vm
	osfnBBHKyxZ9v9zyTynn0nkeUIGtONkdci3Sd/CJIB/1RilQTizaPMvj0t1YMMN5rDKf5P0TgIj
	O5hmRelTtc+zpp/Y+pyuHdNXWNkywSQsMAZCE341AYvKoMF6cBz78kNN/zXsqxTbr5GoHDh5DG6
	dzWimDAdDXk9/k5zl8MBrZWg
X-Google-Smtp-Source: AGHT+IEwTQ8n/oq4WA0TVwMdQlA7DuR7NSHWr2cz0ehvbqPQNZ2jrjdjgyjx7z4YfsFctHmdzgEMSQ==
X-Received: by 2002:a05:6a00:3a0c:b0:730:9989:d2d4 with SMTP id d2e1a72fcca58-73bd126b0f0mr5430376b3a.3.1744588936403;
        Sun, 13 Apr 2025 17:02:16 -0700 (PDT)
Received: from t14 ([2601:643:8b00:2360:f92:4f6:9504:a65a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd233554asm5490923b3a.180.2025.04.13.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 17:02:16 -0700 (PDT)
Date: Sun, 13 Apr 2025 17:02:14 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from
 bpf_iter_udp_batch
Message-ID: <Z_xQhm4aLW9UBykJ@t14>
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-3-jordan@jrife.io>
 <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
 <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
 <daa3f02a-c982-4a7a-afcd-41f5e9b2f79c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa3f02a-c982-4a7a-afcd-41f5e9b2f79c@linux.dev>

> static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> {
>         if (iter->cur_sk < iter->end_sk) {
>                 u64 cookie;
>
>                 cookie = iter->st_bucket_done ?
>                         0 : __sock_gen_cookie(iter->batch[iter->cur_sk].sock);
>                 sock_put(iter->batch[iter->cur_sk].sock);
>                 iter->batch[iter->cur_sk++].cookie = cookie;
>         }
>
>         /* ... */
> }
>
> In bpf_iter_udp_resume(), if it cannot find the first sk from find_cookie to
> end_cookie, then it searches backward from find_cookie to 0. If nothing found,
> then it should start from the beginning of the resume_bucket. Would it work?

It seems like the intent here is to avoid repeating sockets that we've
already visited?

This would work if you need to process a bucket in two batches or less,
but it would still be possible to repeat a socket if you have to process
a bucket in more than two batches: during the transition from batch two
to batch three you don't have any context about what you saw in batch
one, so in the worst case where all the cookies we remembered from batch
two are not found, we restart from the beginning of the list where we
might revisit sockets from batch one. I guess you can say this reduces
the probability of repeats but doesn't eliminate it.

e.g.: socket A gets repeated in batch three after two consecutive calls
      to bpf_iter_udp_batch() hit the resized == true case due to heavy
      churn in the current bucket.

|               Thread 1            Thread 2   Batch State    List State
|  -------------------------------  ---------  ------------   ----------
|                                              [_]            A->B
|  bpf_iter_udp_batch()                        "              "
|    spin_lock_bh(&hslot2->lock)               "              "
|    ...                                       [A]            "
|    spin_unlock_bh(&hslot2->lock)             "              "
|                                   add C,D    "              A->B->C->D
|    bpf_iter_udp_realloc_batch(3)             "              "
|    spin_lock_bh(&hslot2->lock)               [A,_,_]        "
|    ...                                       [A,B,C]        "
|    spin_unlock_bh(&hslot2->lock)             "              "
|    resized == true                           "              "
|    return A                                  "              "
|                                   del B,C    "              A->D
|                                   add E,F,G  "              A->D->E->
t                                                             F->G
i  bpf_iter_udp_batch()                        "              "
m    spin_lock_bh(&hslot2->lock)               "              "
e    ...                                       [D,E,F]        "
|    spin_unlock_bh(&hslot2->lock)             "              "
|                                   add H,I,J  "              A->D->E->
|                                                             F->G->H->
|                                                             I->J
|    bpf_iter_udp_realloc_batch(6)             [D,E,F,_,_,_]  "
|    spin_lock_bh(&hslot2->lock)               "              "
|    ...                                       [D,E,F,G,H,I]  "
|    spin_unlock_bh(&hslot2->lock)             "              "
|    resized == true                           "              "
|    return D                                  "              "
|                                   del D,E,   "              A->J
|                                       F,G,                   
|                                       H,I,                   
|  bpf_iter_udp_batch()                        "              "
|    spin_lock_bh(&hslot2->lock)               "              "
|    ...                                       [A,J,_,_,_,_]  "
|                         !!! A IS REPEATED !!! ^
|    spin_unlock_bh(&hslot2->lock)             "              "
|    return A                                  "              "
v

There's a fundamental limitation where if we have to process a bucket in
more than two batches, we can lose context about what we've visited
before, so there's always some edge case like this. The choice is
basically:

(1) Make a best-effort attempt to avoid repeating sockets, and accept
    that repeats can still happen in rare cases. Maybe the chances are
    close enough to zero to never actually happen, although it's hard to
    say; it may be more probable in some scenarios.

or

(2) Guarantee that repeats can't happen by requiring that a bucket
    completely fits into one (or two?) batches: either error out in the
    resized == true case or prevent it altogether by holding onto the
    lock across reallocs with GFP_ATOMIC to prevent races.

All things being equal, (2) is a nice guarantee to have, but I sense
some hesitance to hold onto hslot2->lock any longer than we already are.
Is there a high performance cost I'm not seeing there? I guess there's a
higher chance of lock contention, and with GFP_ATOMIC allocation is more
likely to fail, but reallocs should be fairly rare? Maybe we could
reduce the chance of reallocs during iteration by "right-sizing" the
batch from the start, e.g. on iterator init, allocate the batch size to
be 3/2 * the maximum list length currently in the UDP table, since you
know you'll eventually need it to be that size anyway. Of course, lists
might grow after that point requiring a realloc somewhere along the way,
but it would avoid any reallocs in cases where the lengths are mostly
stable. I'm fine with (1) if that's the only viable option, but I just
wanted to make sure I'm accurately understanding the constraints here.

Thanks!

-Jordan

