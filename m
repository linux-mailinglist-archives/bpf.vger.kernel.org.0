Return-Path: <bpf+bounces-17106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2743809AF2
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 05:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104361C20CB6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735695255;
	Fri,  8 Dec 2023 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IggVgGwP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AFD171C;
	Thu,  7 Dec 2023 20:19:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ce28faa92dso12571605ad.2;
        Thu, 07 Dec 2023 20:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702009196; x=1702613996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKFRLwSxv1vJ4nhOqNlCSQcP54rZnxuYa97Rugmsvrg=;
        b=IggVgGwP+HH44pT5JSqVYrBoPYVUbeDVrHV/LRkO7Ogx3fAW7caMCQzmoSCTvdZdeD
         nl5k3G195/0M0j/Qa502ICkKWvr8WQFQY0X0URl/RLn001u8ImENMAT4GEEfHcwDop/T
         mxbgyY6oPNLZ+IwMx/xYlS/oT7/rQ7qkDusmMroVbIw8sMVw5frap1k8nOkEPetO8wGq
         3sal/oTP6ZblBR2fG+SRWO1DfX1cINe4UCDrfjFh24yZYvX86TgdqYIbiP9LwHYC2pFh
         Ecfu+g6I13fx/bZD4hYdBwsVsS3K0tqh+aHXValBYAIoUkozaVVu+BS0VSwfNPM/sCVJ
         e/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702009196; x=1702613996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKFRLwSxv1vJ4nhOqNlCSQcP54rZnxuYa97Rugmsvrg=;
        b=GngnwaQWK+nBRGAuq1MOpCfuVmN6qGnbFEGzLJB8ddXx+LwPMUDZYMUYUxFSgfI+uZ
         dUjYXZikYKfBqNWk42eyPIOeyIdoEZRKY/1WONnhNkKMXlupEDRBBe5hcbpPxr4k/4KA
         b0Qeu8ljfFaipmSk4G8Xf9k5P7y52ZJmbYUD4f9+cwhalddbb6QSCdG7xGs6em+Mm7R/
         /uN6KvnoClW56kVCpqTdItNyAGfGmWrbovKwP3l/KQAOe8xgWi2n005Eio2vvhcALz/a
         Kg4/5nuyIuUGG6R6xOCORihZkvGmfHgHUJ5FzDE0m3B5aenG4Qdas87VpfNgXSmX7uap
         WBwQ==
X-Gm-Message-State: AOJu0YxtB97ulCpM4aAVilGXN7uUdvRAJ8nU+Sxtt+dRYm2yvQcC1QRG
	i/jwJY9UCYYD96WZ3BwqQXM=
X-Google-Smtp-Source: AGHT+IEPStiPwIuC2knFZwYV9zbYDtl5HZW3T/BSaLsxQVHZ8lxrS4BxdwsdCt2RF0mu/w5F0TNfQA==
X-Received: by 2002:a17:902:ee4d:b0:1ca:86b:7ed9 with SMTP id 13-20020a170902ee4d00b001ca086b7ed9mr3139371plo.40.1702009196525;
        Thu, 07 Dec 2023 20:19:56 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:4a12:bf1a:86b1:d99d])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001bf8779e051sm622269plb.289.2023.12.07.20.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:19:55 -0800 (PST)
Date: Thu, 7 Dec 2023 20:19:55 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
	edumazet@google.com, jakub@cloudflare.com, martin.lau@kernel.org,
	netdev@vger.kernel.org, amery.hung@bytedance.com
Subject: Re: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in
 unix_bpf proto add
Message-ID: <ZXKZa4RRmK2M6iHT@pop-os.localdomain>
References: <20231201180139.328529-2-john.fastabend@gmail.com>
 <20231201211453.27432-1-kuniyu@amazon.com>
 <656e4758675b9_1bd6e2086f@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656e4758675b9_1bd6e2086f@john.notmuch>

On Mon, Dec 04, 2023 at 01:40:40PM -0800, John Fastabend wrote:
> Kuniyuki Iwashima wrote:
> > From: John Fastabend <john.fastabend@gmail.com>
> > Date: Fri,  1 Dec 2023 10:01:38 -0800
> > > I added logic to track the sock pair for stream_unix sockets so that we
> > > ensure lifetime of the sock matches the time a sockmap could reference
> > > the sock (see fixes tag). I forgot though that we allow af_unix unconnected
> > > sockets into a sock{map|hash} map.
> > > 
> > > This is problematic because previous fixed expected sk_pair() to exist
> > > and did not NULL check it. Because unconnected sockets have a NULL
> > > sk_pair this resulted in the NULL ptr dereference found by syzkaller.
> > > 
> > > BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> > > Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
> > > Call Trace:
> > >  <TASK>
> > >  ...
> > >  sock_hold include/net/sock.h:777 [inline]
> > >  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> > >  sock_map_init_proto net/core/sock_map.c:190 [inline]
> > >  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
> > >  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
> > >  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
> > >  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
> > > 
> > > We considered just checking for the null ptr and skipping taking a ref
> > > on the NULL peer sock. But, if the socket is then connected() after
> > > being added to the sockmap we can cause the original issue again. So
> > > instead this patch blocks adding af_unix sockets that are not in the
> > > ESTABLISHED state.
> > 
> > I'm not sure if someone has the unconnected stream socket use case
> > though, can't we call additional sock_hold() in connect() by checking
> > sk_prot under sk_callback_lock ?
> 
> Could be done I guess yes. I'm not sure the utility of it though. I
> thought above patch was the simplest solution and didn't require touching
> main af_unix code. I don't actually use the sockmap with af_unix
> sockets anywhere so maybe someone who is using this can comment if
> unconnected is needed?
> 

Our use case is also connected unix stream socket, as demonstrated in
the selftest unix_redir_to_connected().

Thanks.

