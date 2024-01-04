Return-Path: <bpf+bounces-19007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A2823B48
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 04:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B9E28825C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830A846D;
	Thu,  4 Jan 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAzHPJAz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69B18647;
	Thu,  4 Jan 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3dee5f534so7420845ad.1;
        Wed, 03 Jan 2024 19:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704340074; x=1704944874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR7S9UreToinw669MkZiNniYRYkImV7KoyVOqWp7Fvg=;
        b=lAzHPJAzm0AQltmJsqPZubeYcbkGykY7EA2eHK3AKU6HBg/huzYiUTHK++xAB+JlsK
         QpAwCpEpbX5E1DnpazO3dC/3x9hlqOv6/1aaxmBvfUXZdIeTeanUK2dBDcE2s4ucdh6r
         gv8QfKrPw3SJI8W3WB2zXm0KjIYiBr1iHy8q7uVL4cJypBLpRJDWNTdG1pscPGHs+Cux
         JCKdLjH+DR5VK4/eIdEz0Hrr9YhIJ5w4tBL5vBY5Bh8RgeJwi4w3fCkeNVoXrcUHJUqB
         lM2Nhy7COKm1Yi97m8R9mRMJmNCzeVpuwO9p8ad7QXBP06bMABx0QL4Q/wDatNo3IrHG
         NHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704340074; x=1704944874;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cR7S9UreToinw669MkZiNniYRYkImV7KoyVOqWp7Fvg=;
        b=Sq0Sx1h/EReOVbrAEVOwAsqTNhIWTqyxCNL6Bw9K/RmtBkrOycGj9m8Kl7M7tWg26f
         CbKvCWfCodIzshsmjM3f0SAmIx9hXk+bnGGnGzUKzTr1GGmGIj+dkDI1q9hdHlt9bTFo
         tMQX5oW289Y+qpiJgC82rMIi3jShvEpi2/Cl2S4CV+J9GR3wMDDpIfFZeN9dIGO1MHnl
         l/23+pMjIB3Mpo1ZxbsCXZMZO01GeTPu8Elk0ZGFL/njFvJmCjibH9X43ldJhcblmLXC
         TiljLzYu7QVxGFFmm2HEehvm9uyQDlltaiqUgI/v49iwTfA43SpDlo2pnqNrc63Dm2IQ
         GYwg==
X-Gm-Message-State: AOJu0YwvOJdT8wnaAtkNNCl63Lx7OydP/NTWw7XpdO2hwZdP5JYQFvte
	oOtWGYMBdGEsPpub5AJA1Fs=
X-Google-Smtp-Source: AGHT+IE0IE2oBTjMy8aWXibgHKFOnrR9SfaJ6etfw0jKbJI+w2hT54Y7XGcwdI57lnbpDzoU2HlHXQ==
X-Received: by 2002:a17:902:6ac3:b0:1cf:e9b5:90ee with SMTP id i3-20020a1709026ac300b001cfe9b590eemr18673plt.24.1704340073423;
        Wed, 03 Jan 2024 19:47:53 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902789400b001d47868c31fsm14756564pll.194.2024.01.03.19.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 19:47:52 -0800 (PST)
Date: Wed, 03 Jan 2024 19:47:51 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: rivendell7@gmail.com, 
 kuniyu@amazon.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <65962a67329cc_2bb2020850@john.notmuch>
In-Reply-To: <841935e8-f075-4fc4-9f1b-3451ad6e1f98@linux.dev>
References: <20231221232327.43678-1-john.fastabend@gmail.com>
 <20231221232327.43678-2-john.fastabend@gmail.com>
 <87zfxoueqe.fsf@cloudflare.com>
 <841935e8-f075-4fc4-9f1b-3451ad6e1f98@linux.dev>
Subject: Re: [PATCH bpf 1/5] bpf: sockmap, fix proto update hook to avoid dup
 calls
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 1/2/24 4:00 AM, Jakub Sitnicki wrote:
> > On Thu, Dec 21, 2023 at 03:23 PM -08, John Fastabend wrote:
> >> When sockets are added to a sockmap or sockhash we allocate and init a
> >> psock. Then update the proto ops with sock_map_init_proto the flow is
> >>
> >>    sock_hash_update_common
> >>      sock_map_link
> >>        psock = sock_map_psock_get_checked() <-returns existing psock
> >>        sock_map_init_proto(sk, psock)       <- updates sk_proto
> >>
> >> If the socket is already in a map this results in the sock_map_init_proto
> >> being called multiple times on the same socket. We do this because when
> >> a socket is added to multiple maps this might result in a new set of BPF
> >> programs being attached to the socket requiring an updated ops struct.
> >>
> >> This creates a rule where it must be safe to call psock_update_sk_prot
> >> multiple times. When we added a fix for UAF through unix sockets in patch
> >> 4dd9a38a753fc we broke this rule by adding a sock_hold in that path
> >> to ensure the sock is not released. The result is if a af_unix stream sock
> >> is placed in multiple maps it results in a memory leak because we call
> >> sock_hold multiple times with only a single sock_put on it.
> >>
> >> Fixes: 4dd9a38a753fc ("bpf: sockmap, fix proto update hook to avoid dup calls")
> 
> The Fixes tag looks wrong ;)
> 
> I changed it to
> 
> Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for 
> pair sock")
> 
> >> Rebported-by: Xingwei Lee <xrivendell7@gmail.com>
> > 
> > Nit: Typo ^
> 
> yep. fixed.
> 
> Also added the missing "test_sockmap_pass_prog__destroy(skel)" to the 
> sockmap_basic.c selftest.

Thanks! Appreciate it Martin.

> 
> Applied. Thanks for the fixes and the review.
> 

