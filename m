Return-Path: <bpf+bounces-56440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D71A97429
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BC17FEA2
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0313A26D;
	Tue, 22 Apr 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Xwh97PZ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C91DD9D3
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345005; cv=none; b=PqBPMPb4KiFviJsJtmS8LYBov5ZY+piAB0M5lPFgtHjli2ZfrkNKbFvPbmsblOLrAUs4coDeV02VEAw1+QoY4bQ04qdVxhH94uHoIXRgj5Q3XhR+Xy0Li7awmpkvoY9qCE2x7ZLsixlGaBDYhGdlvDjcrrCC8moS3U560X90WiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345005; c=relaxed/simple;
	bh=3+aI91T8njP9jH2i655h+MWTIttIKFogzim/bJ8Fn0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4UKFL5C4q4IMwlLOQMH26b3Gb5zsGEzvTwdrSkHie4KyfPNnON6GT8Xb4Uj59iZhsuvQmNbTf3r47cv6pK01+XNSYlAOseZG0tdcPdkM8MlNVjoiXJ2yILnDEhc+XbngPZz1wVOjwD76bkZV4kdbglSuHMoqNwx7pRO1NUYsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Xwh97PZ0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5445cb72dso53760885a.3
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745345002; x=1745949802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32ZdXmTovN0OSD2r5D1TaWpbCe6i2haD+JASg5H9130=;
        b=Xwh97PZ0Spffq3Zqf/tQnF1bH1u5MrXgXugtGy2epl5cmz7+kvg1MWKcpMMPVqHDyd
         ZVWWMRexU0eWLBhItqx148Uw24WZf+fdEkOSTJRxX/tZxwiGAID1gNM2aU4oThQKUokG
         sXZCiy70ve0WORJ4GTItjAvj1c25L0tWEkCHlrVAXqeEcdksMoVlM0fkklAjK6JpM2B0
         uAHJcQgijnhTzrAC+p9n6DvZL+gI2AXvupDYeZwdjyiLEFR6MbuiuPfKzRDvWQc1aaRq
         ZCC+zbRKnqpNrktJIvNysWttkWTZp7aIWrq1f/AO+XadJElOueBnFxGL81QyyyiN2CSS
         SdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345002; x=1745949802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32ZdXmTovN0OSD2r5D1TaWpbCe6i2haD+JASg5H9130=;
        b=XXSmUrh2UJh4Tn4+J8NALFdMKUhLbKAHvbyMjwzHcPs8w/M1a0G1DLu/KrkntMwNUA
         VUQILH0cIZqoOouN1v9c2J5hPazAdLR73AB9qIszx9UGfYSiDLU9ljIjhIsuG2SDwOvV
         qNxVXWi/9uCqo9rgONQIwTBcNQthngY07HdagRwWCAZfr1D8llD103sraxRh9ycmfuR1
         ZpzMTcNx00pjZ+W6BRDeszY/XXrYryHGvTLybXn8d+gLv02+Gaiv89ufX6K1HB1Ns0fB
         K3NQf1vIGqhGCDL44Me3oUlPKWrvxuoNssxlRLsK7Y2icagXcLy6yCuc5s4Yf+JulWDB
         u53Q==
X-Forwarded-Encrypted: i=1; AJvYcCW08FUgmB/x8t6VDi3mviIuTqIDiqhQ0W4Gv8HOTi+0KkgzCNS7dM3gccARkZ1jsrf6zXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNok7Xe9Ya9aZX1PDGfLVwKd1+Y3ApJzp2JCNhPyx3RpABDltP
	1X5ZZ4LShbrSp60e5P7T20Ar2H/cgNsTHlIjhnzQCGPBbYATj4WaGJ64SiM2J9w2J57MDjH6YH5
	Osxrb1Yn4QueZQ3n9yneXV6DQ9X5cyFhY7V/i3Q==
X-Gm-Gg: ASbGncsnFlv3efRb3zMA78vhjdLA4nm5GebTYD2meraVWJszdXsclfza8LWMhrBIUSh
	XJ4VBcgEAiGc8olKLRK+qF8+ODX0AEogPDWDKtr6+yKf1mAcafkyuV72+kKURYe+SuvCjL4KEFo
	RY+reMZGskyPmcoFJBxyJ8epuZ+Wd13ohB4G6Oy6EYH2Mti56bF8bE
X-Google-Smtp-Source: AGHT+IHn2+ubFPPZO34byhkuVufTiiOQJVnr2PNFIuBegB8EtnRTBKAh4BuNCHk4G309qdx16jaZBXdKHcwpWOin4bY=
X-Received: by 2002:a05:620a:4496:b0:7c0:a898:92fd with SMTP id
 af79cd13be357-7c92805f944mr950134585a.13.1745345002485; Tue, 22 Apr 2025
 11:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419155804.2337261-1-jordan@jrife.io> <20250419155804.2337261-5-jordan@jrife.io>
 <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
In-Reply-To: <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 22 Apr 2025 11:03:11 -0700
X-Gm-Features: ATxdqUG3eH9xhuX1I8fAQAnh5CCetq4Fs34CLFN_M_Qn5KnOUFHSZ4LNCwQ-22g
Message-ID: <CABi4-ogRXQGc7ucKj=jp1AtNprZhn55g+TGhbYnfroMgZ+gVwQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 21, 2025 at 08:47:51PM -0700, Martin KaFai Lau wrote:
> On 4/19/25 8:58 AM, Jordan Rife wrote:
> >   static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
> >   {
> > -   while (iter->cur_sk < iter->end_sk)
> > -           sock_put(iter->batch[iter->cur_sk++].sock);
> > +   union bpf_udp_iter_batch_item *item;
> > +   unsigned int cur_sk = iter->cur_sk;
> > +   __u64 cookie;
> > +
> > +   /* Remember the cookies of the sockets we haven't seen yet, so we can
> > +    * pick up where we left off next time around.
> > +    */
> > +   while (cur_sk < iter->end_sk) {
> > +           item = &iter->batch[cur_sk++];
> > +           cookie = __sock_gen_cookie(item->sock);
>
> This can be called in the start/stop which is preemptible. I suspect this
> should be sock_gen_cookie instead of __sock_gen_cookie. gen_cookie_next() is
> using this_cpu_ptr.

Good point, I will change this.


Jordan

