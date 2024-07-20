Return-Path: <bpf+bounces-35176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D893826A
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2099E1F22146
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D41487E7;
	Sat, 20 Jul 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhzDMUt5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D51C27;
	Sat, 20 Jul 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721499626; cv=none; b=p7FhRXKdzfTID1EzsdCzLoQ35MVAVBgpVaOZ1ta1B4lyISifo2pxv25MstoXf+/vqomuMjg2ZMCiRsOu2FdAk8qGdYPKAanWKj9XB+MaXVbWTNCNLWGFj4QhHOWKQwjDtwxkOk2V/xe9Thlgq/Uoltrbv4io2SeIijJUx+DxUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721499626; c=relaxed/simple;
	bh=C6k8kxg14LOGII/8SaL8z25q+ctUqRjRR10qr5P4uxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHNcqCV57rfS7L5eo34gl1g1twStCGJ3FrdZ0SJItKTtlxdjRgvsnz3/Ev75F1PEsyOEMsqewZd+B6a5hwLBYTItRpVF6RyfcSVO5wcITbkgrDxt6ZpQWEywZFfS3hpFGX1MZG/rwMqzVGOcfyvk3h3SdtSB16R9Vcu7J8J7NLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhzDMUt5; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c0dbd2866so1335769fac.0;
        Sat, 20 Jul 2024 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721499623; x=1722104423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2tHKqDGRbnDCXwN65qCrcnaa0fnnNabF939w9mIc6M=;
        b=mhzDMUt5WOXaNXneeyIavGeR6aiSMNRMwZg6pI+Isc9sDBwwHvngDRTsqrpv2QrNMX
         1SSI6OoBfOTubcTtSBiDp2cPphJoXK7vH0wsCRyI2OFpA5zKKCl7hrd3AbNTseff48W0
         MmbiGzMTzUQcoR0kTv/D+wqUyWApkWh5xQNkdvWXP1M53xjXyHfSANe+3G+nZSzmAdNK
         BE6m52uMDG0oJIBq0SMuwQr0CO02Yh59a/e5R5KlwDE/ann5/Xk3duxajfpv01MfVqCR
         YsZPH/NB4EmtuSIvRDBbedyQaHYON/ppsVjQY/2dKN1I7vmEplekFqqWjM5qo08rtB2V
         a7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721499623; x=1722104423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2tHKqDGRbnDCXwN65qCrcnaa0fnnNabF939w9mIc6M=;
        b=Rzi23x98scJ8SYr/AhqhGykfRWFTcmUIw/l+tir/DlYvl2/ExiHJNiIvcJCnx1+IgH
         1k6SvRfGDyIBXtAgp3NVe/vVPXPtKbN6YHwshgz5OZ2IAOa3fBZ+kwGgdz1JMBIQX1o5
         P36PIwFaCN4CbetXOkBPCv1NGu2fDaaal8/Qee5Nf0qQJSoodl/3E1An7TmYY/0If++L
         DStw+giMeb9eqMI9Y3Jimo6Y5vmb9tkdl5bg4fC6SPz1YoMxwMl5Q/Qc5Ykpe4b9kUU8
         MxHJhp9Olnk64iTq5BG4o0OPU8Z1XjN9EeM9DlRgFRLg9a6iOHIaSZ8bbfMarmds1fk2
         1Hqw==
X-Forwarded-Encrypted: i=1; AJvYcCWVCW/k5itieOz9AJNPKUQ4bPwdifRaTZBweJlsYijG/1S0TezwFtReFe+JMIwK6vcqxIqU3tnnHgPFt9VpIgpLTxaFRwWTQrYUyTgn8LlIYswX27yVw+jw9LgK
X-Gm-Message-State: AOJu0YyqPYTjzPhs8Fd5ATa/uYA6GKxpgMwsOcZJYMG8zEWvIGZBMB/e
	BrDESdYYxF+SwoOlavlwhRO7c2x7ACAgYjPM8655kxJ72hS3ZsqW
X-Google-Smtp-Source: AGHT+IELl1D4jD0Pil3dg4IDAUhYNuPycNle+gjst0mX9jvHYh2w4AZBsfT9pNUDfDNhektHIVD+QQ==
X-Received: by 2002:a05:6870:4584:b0:25d:f8fa:b538 with SMTP id 586e51a60fabf-261214ef3a3mr2843230fac.29.1721499622933;
        Sat, 20 Jul 2024 11:20:22 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:3cb1:e977:dd25:9cd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5a748fsm2878608b3a.151.2024.07.20.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 11:20:22 -0700 (PDT)
Date: Sat, 20 Jul 2024 11:20:21 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: Recursive locking in sockmap
Message-ID: <Zpv/5bnA0giMJDIy@pop-os.localdomain>
References: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
 <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
 <CALye=_-oqMO-LRWd7pvMUnOxDCNVg0v=Wgmg8Qggg1Q3yL-jmQ@mail.gmail.com>
 <ZmMuh5mkK7w7s/3L@pop-os.localdomain>
 <666b43a9b2b4a_1995c208f@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <666b43a9b2b4a_1995c208f@john.notmuch>

On Thu, Jun 13, 2024 at 12:08:25PM -0700, John Fastabend wrote:
> Cong Wang wrote:
> > On Fri, Jun 07, 2024 at 02:09:59PM +0200, Vincent Whitchurch wrote:
> > > On Thu, Jun 6, 2024 at 2:47 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > > On Thu, Jun 6, 2024 at 6:00 PM Vincent Whitchurch
> > > > <vincent.whitchurch@datadoghq.com> wrote:
> > > > > With a socket in the sockmap, if there's a parser callback installed
> > > > > and the verdict callback returns SK_PASS, the kernel deadlocks
> > > > > immediately after the verdict callback is run. This started at commit
> > > > > 6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
> > > > > pointer dereference in sk_psock_skb_ingress_enqueue").
> > > > >
> > > > > It can be reproduced by running ./test_sockmap -t ping
> > > > > --txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap is
> > > > > available in this series:
> > > > > https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com/.
> > > >
> > > > I don't have time right now to look into this issue carefully until
> > > > this weekend. BTW, did you mean the patch [2/5] in the link that can
> > > > solve the problem?
> > > 
> > > No.  That patch set addresses a different problem which occurs even if
> > > only a verdict callback is used. But patch 4/5 in that patch set adds
> > > the --txmsg_pass_skb option to the test_sockmap test program, and that
> > > option can be used to reproduce this deadlock too.
> > 
> > I think we can remove that write_lock_bh(&sk->sk_callback_lock). Can you
> > test the following patch?
> > 
> > ------------>
> > 
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index fd20aae30be2..da64ded97f3a 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -1116,9 +1116,7 @@ static void sk_psock_strp_data_ready(struct sock *sk)
> >  		if (tls_sw_has_ctx_rx(sk)) {
> >  			psock->saved_data_ready(sk);
> >  		} else {
> > -			write_lock_bh(&sk->sk_callback_lock);
> >  			strp_data_ready(&psock->strp);
> > -			write_unlock_bh(&sk->sk_callback_lock);
> >  		}
> >  	}
> >  	rcu_read_unlock();
> 
> Its not obvious to me that we can run the strp parser without the
> sk_callback lock here. I believe below is the correct fix. It
> fixes the splat above with test.

The lock is still there, but just read lock. And I don't see any writing to
psock->strp in strp_data_ready(), so using read lock makes sense to me.

Thanks.

