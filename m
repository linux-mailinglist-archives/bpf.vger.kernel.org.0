Return-Path: <bpf+bounces-61192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B4AE2059
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70627AF971
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF22E6125;
	Fri, 20 Jun 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLgPZn8Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAD136988;
	Fri, 20 Jun 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438053; cv=none; b=bWYHrp0RioCNmZLYcQcnuTf78xRm05pOFuleUF5O2ZFnH9YidSXRbjaGAeEKRDvocuxTpIZ4a1nVjdZyK0sesLwHeSCMhNN/0hd2WVTKToTIsqfnPqsBcHFevVibzibglwd2zqZ28JEzBgR+hZkqEiNoFrN6D37vEhRjxy81+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438053; c=relaxed/simple;
	bh=KX6tv80e3CvofaxgkpPhdO+UHC4W7+9qaHsigC34mDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3zE0lmVmi3nc2V7QIt9MT0nMgjuTZW5kdTKruMzcpTV3/mHQuJK/aL/YzjD5hM1PTGO8M+nJw5+6phbrw7istSP2K4dGu5y8MF5t/jE3W4gbM54JfS1pukAb/VpVWgrnwnjg86PpYeWE8DUx2aUPmB5PrhHQ0jpr2Jp0EkhNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLgPZn8Y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so1823886a12.2;
        Fri, 20 Jun 2025 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750438051; x=1751042851; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4yi8IQcZyibFlvW9TENnflSaaC5CxQZCE+bmRMWOXA8=;
        b=kLgPZn8Yo/myyHq7tNYadnBDKaJNdSIHPgzmtuVX4Um6F3ZeDUxX5luFo9gGZzIDFG
         +NUiEuJSoSMwuc2Q1EpmWB+UMAei13NShDCmInQmFrWxB+18UMLi20zaaNQGUd2PxcrO
         cTGfBHnIBsiQvvYPELAkKPsClRfr/ERF3md1Jz6MzfkFOh0R2nJYVf3xP6x8YqS+ulBI
         GR2C/+sPq8/LpPlyjCaJ2jzHjaBB/h+7EcED1qXZzdzHqWDFLltp/S4x/2SV40JdnZ35
         vNmR/cKWM4k+ox5LnolZdGlBCUz8/ChRjVCKO8tHU8xkOLgOJLjakO2pWbHwYXKKlES6
         ny+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438051; x=1751042851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yi8IQcZyibFlvW9TENnflSaaC5CxQZCE+bmRMWOXA8=;
        b=G0340HPXbt4/2sqAJ7pgajOzl4AaMdW5Hb/qBhhbDUOTiqkpIJVr1BWUTKCBeiRXAM
         XnDar4Eo//A70XelgOCFheEZlrZgKyWIbnTu9xNf6jxmzwdbppXRGkhiU9myxpte+mI4
         8grkLPsSOANR+FT9xtOKgFhDGqWSu87jkAC+yoMuIox9aAgGPQSVL3XiD/L+sJk2kXLY
         uE1AkAR10Hb/Mogb2/YZnU/1Y7twuKWsZjVoyVhVlrfpO5N2yASkNt/PNMl5Si/R8M5q
         XV9mZg8EjaWqBW4XAv8p+u2AG9Im3GTjRmeQntdSKCDKNhyE5860rR4eWTz/vV5s+SvU
         uhCw==
X-Forwarded-Encrypted: i=1; AJvYcCVVvK45es0Y0geYisJB1H3Oip6PHoysfGXrVt5MWOB6MWXoyO038Q3KLb2J42uVsIuo9hA=@vger.kernel.org, AJvYcCXOnGG7HjSNi9J6IlFHNorYnjOCiNtR3gG+j7OnqOumDrL4dDP/bYSD7w+oYKDX6HfqQUfdscei@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkB6KCZgtXM9DPjwVlQfjMC7u+Sq5poR4D+lolx9v6NVHnrqb
	3lLJ0aqtSDjv6fTv02BzM/IGiMizAZSUPzBuLdb6G55pK52CdPZlzAJ1F1rn
X-Gm-Gg: ASbGnct7QqTR3KoHHXRFb9pA8CPuoZU9D0/9ZaNACEWFTnfDWvhDrTKfLLzPopZtjOK
	hWIKfdj8qIVreIT29lPf08gheQuMjcRa9py5b5pA4TsnQWFHH+gOHgh0xSKGWSAMcxWwobPpZHE
	gpQKUPRxMKHUSNNAqT82HBtBghpK+v0xBbtO4f24If4B9B1S4fzjxz6UGo/MRcoJUNzYgyvkXw2
	LX/BP9ryvMhCIL861JRioyH7oLIAGO1iNHAy6jzjZgFywF6yekjvS+BrSOJtO66vAz2YYo7DGjf
	MCWVLlJkko+OLIw3a92DihdHjs8cpeF9aBXKmwJh8YcjNqxN53jcU2kfQR+V4/0//6tPxS1+vGl
	CgTYWMOkvnsShPotxXzbVvs4=
X-Google-Smtp-Source: AGHT+IGn5SCW4EMrOnvLN7dbvW095nwN7lq2Np84MpBnyljxlaIMTrPM90t+jBo05ZwRMH+E3ZauMA==
X-Received: by 2002:a17:90b:2701:b0:311:e8cc:4253 with SMTP id 98e67ed59e1d1-3159d61a5d0mr5340291a91.2.1750438051116;
        Fri, 20 Jun 2025 09:47:31 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3159df81649sm2244456a91.11.2025.06.20.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:47:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 09:47:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aFWQoXrkIWF2LnRn@mini-arch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>

On 06/21, Jason Xing wrote:
> On Fri, Jun 20, 2025 at 10:25 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/19, Jakub Kicinski wrote:
> > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> > > >     rcu_read_lock();
> > > >  again:
> > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > -           if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > > > +           int max_budget = READ_ONCE(xs->max_tx_budget);
> > > > +
> > > > +           if (xs->tx_budget_spent >= max_budget) {
> > > >                     budget_exhausted = true;
> > > >                     continue;
> > > >             }
> > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > >  {
> > > >     struct xdp_sock *xs = xdp_sk(sk);
> > > > -   u32 max_batch = TX_BATCH_SIZE;
> > > > +   u32 max_budget = READ_ONCE(xs->max_tx_budget);
> > >
> > > Hm, maybe a question to Stan / Willem & other XSK experts but are these
> > > two max values / code paths really related? Question 2 -- is generic
> > > XSK a legit optimization target, legit enough to add uAPI?
> >
> > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> > whether we want to affect zc case given the fact that Jason seemingly
> > cares about copy mode is a good question.
> 
> Allow me to ask the similar question that you asked me before: even though I
> didn't see the necessity to set the max budget for zc mode (just
> because I didn't spot it happening), would it be better if we separate
> both of them because it's an uAPI interface. IIUC, if the setsockopt
> is set, we will not separate it any more in the future?
> 
> We can keep using the hardcoded value (32) in the zc mode like
> before and __only__ touch the copy mode? Later if someone or I found
> the significance of making it tunable, then another parameter of
> setsockopt can be added? Does it make sense?

Related suggestion: maybe we don't need this limit at all for the copy mode?
If the user, with a socket option, can arbitrarily change it, what is the
point of this limit? Keep it on the zc side to make sure one socket doesn't
starve the rest and drop from the copy mode.. Any reason not to do it?

