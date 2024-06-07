Return-Path: <bpf+bounces-31618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297569009CF
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ACA1F24BB5
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CCC1974F7;
	Fri,  7 Jun 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5YspWF5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A471199E9A;
	Fri,  7 Jun 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776012; cv=none; b=MNCwifIMku63tOGg58NZ2sAO73UHxWs5uVAHEifleGcslsx/SGPXEBj9mtn8rOHTfyGMiy6Ck/OVRGSmNS5AbPrzQ7ZwJTYta8Oap2tulJcJ0KI0rLRjSOblDwcOritIGoBQslaTRqDemK/BpoPQnzKRX8teUKmgTiI3za1CEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776012; c=relaxed/simple;
	bh=mFLN0jt5PNVU18ZUT6epLAbjLPJKHy4N81RmyjkT9NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOCbaXIOU8/z9a9lbEH1wcSB7tAJIuTvTZXqg9M50I306IrY80fyQGb0CRRCIdPQ4ifXW27/xRunXWKOzaCBRe6tear8H82Tx5EooEy85ORfXEA7zr+hGUghEKANvP0xW76B42ovMw8uM0k6LALrNt7Mdw/IkIjjMrPwq6A82O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5YspWF5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70417a6c328so528429b3a.1;
        Fri, 07 Jun 2024 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776010; x=1718380810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qn9SFQtPMctxEr5JxeaSb+bvqDIXX4/of36UMlSsVxY=;
        b=e5YspWF5oWdPewuhGyYfX0uajabyeBp0OWDPLqfM2YnzunOAF+ADpAllYrwjfkdiEw
         /+g6Yof0rMKaPFbmHTrASOikdlBITdmrgJz82A1A1NlTQ6o7ztY4pos9JRIx5MMibDVG
         dl8yjdqmW/QYopEQAsM/5gMcIoRG7MvKEpMi20zl2OPwxU2ckE+GSPciFWTRaeqY+oxN
         5fLbJPCY6S9nGBmIzC+zB4fO3+dQ8C2Wda9FsTRnzDrd+Ep/frecDpYt0JK+u1Et5Os0
         UkK24/UY94Kp0I4T6xzGy+KMEYItPvoSsEMfoV1NRYjqnf6iNPCiu2J0Zxr8/MW+Q/Dr
         +cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776010; x=1718380810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn9SFQtPMctxEr5JxeaSb+bvqDIXX4/of36UMlSsVxY=;
        b=wi8acgNa67DhfaKVtQeI5rwUBVqCxRJu9s9jPJLGYTnvtR2SAp6EMmi83XpllHqqIp
         ylbTK2sI17NctXR6KoqyKZVhQi3+3fkovkBCcQOcGBY8Q6ozkdjWdxs3o3fW4WRcP4Zf
         mcHAhIX+XaixkqjSVBqn1wHeK5eM0sn9RJbWnLXjfnKnHoaBEkbH8YGkozXb880zlPxL
         56mLXu/KQRaK3Sc6J4ZgGlopebuZnlDnOXuC8pAwUbYwCN+t3zvwSgvBINgJ01uW+mm7
         xGKV9WaFV8rppWfzLWFcUmtlgvxfPdcaQWP1HHWxvSZm7dcsOwNknbrNcdbzC1h0V8qf
         l0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Mg4lbPm2DHJ8275kF9YcLdS+HJ6TmfU7f/dp6enXSnpRZVC26Ag4zXtipJZ08EUS9/OiKA7hHIPFmzXZe7hrnmL1RPcU4O3c1AciU5g0PwSBNoXzfvQPjLqx
X-Gm-Message-State: AOJu0YwTWP37eAHRrpbhnE2SndeEb3CQQrtIzqimURZfyQIrUIqR25Qm
	wP43gY6KxLFiqzDOmAmDWI7OBeX04m3ml+61+zH89hjiQV/WQXu5
X-Google-Smtp-Source: AGHT+IGjN7JPZjC1Vvd+SMSwT1rHd3v8s1lVPVbWPcfTcRX+xdgC8nuY7jcuDlMKS0ORtT05TzhiSA==
X-Received: by 2002:a05:6a20:7fa8:b0:1af:fbab:cf92 with SMTP id adf61e73a8af0-1b2f9de063cmr2741380637.54.1717776008894;
        Fri, 07 Jun 2024 09:00:08 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:ec8a:c212:32db:10a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd371cc7sm2796034b3a.2.2024.06.07.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:00:08 -0700 (PDT)
Date: Fri, 7 Jun 2024 09:00:07 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: Recursive locking in sockmap
Message-ID: <ZmMuh5mkK7w7s/3L@pop-os.localdomain>
References: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
 <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
 <CALye=_-oqMO-LRWd7pvMUnOxDCNVg0v=Wgmg8Qggg1Q3yL-jmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALye=_-oqMO-LRWd7pvMUnOxDCNVg0v=Wgmg8Qggg1Q3yL-jmQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 02:09:59PM +0200, Vincent Whitchurch wrote:
> On Thu, Jun 6, 2024 at 2:47 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > On Thu, Jun 6, 2024 at 6:00 PM Vincent Whitchurch
> > <vincent.whitchurch@datadoghq.com> wrote:
> > > With a socket in the sockmap, if there's a parser callback installed
> > > and the verdict callback returns SK_PASS, the kernel deadlocks
> > > immediately after the verdict callback is run. This started at commit
> > > 6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
> > > pointer dereference in sk_psock_skb_ingress_enqueue").
> > >
> > > It can be reproduced by running ./test_sockmap -t ping
> > > --txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap is
> > > available in this series:
> > > https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com/.
> >
> > I don't have time right now to look into this issue carefully until
> > this weekend. BTW, did you mean the patch [2/5] in the link that can
> > solve the problem?
> 
> No.  That patch set addresses a different problem which occurs even if
> only a verdict callback is used. But patch 4/5 in that patch set adds
> the --txmsg_pass_skb option to the test_sockmap test program, and that
> option can be used to reproduce this deadlock too.

I think we can remove that write_lock_bh(&sk->sk_callback_lock). Can you
test the following patch?

------------>

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..da64ded97f3a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1116,9 +1116,7 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->strp);
-			write_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();

