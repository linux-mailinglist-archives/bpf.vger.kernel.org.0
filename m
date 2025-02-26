Return-Path: <bpf+bounces-52698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D1A46E69
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 23:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081733A9539
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF425CC6D;
	Wed, 26 Feb 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm1zb0fU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315525CC61;
	Wed, 26 Feb 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608519; cv=none; b=bpnUrMRbkkG9gUm+0gTbffWeZuKqSGmJqyIenGpMCXUEnBcYZDsdnIdDlcUvwnIMYfIZ3keWrmajezOuP5bfBLELP56TF0Yulia0c2jKDYhWTwS59v3mbA5dsBSU13B9yqqXNEYn3ol9xI2CnEW65+MCMK2Rt1W8qTV0WTq34Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608519; c=relaxed/simple;
	bh=HXyUqkCKyonoD/i85uid9JPezXEkxc0LGOd/QM6n4yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaBMX8fvSebVxofJuPE1CMI4VYGnpdTAtRsn1tEv3XV/wb/NDajYiFAtGGr6E/d5aMM0tvMOXjPKI2UmzuI1e/b+Aem46Hpnxn9Wa60mgY8RViuTy2UjreEJfCeItjvp4z1HjICe2POh7BRkK+srcc2VH4NBfzMT8gL4soLY12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm1zb0fU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f42992f608so579677a91.0;
        Wed, 26 Feb 2025 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740608515; x=1741213315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUmzfiox/3jvbaM/fwzHzjWIDzglvr/7YZ92pZc/Dc0=;
        b=hm1zb0fUiJLECY2sBb9Wh/HH0eYFWaJKK5zFa30MAHF0tOH5i75MFYwO1MqL4MCmVd
         SBZXh0/il6EBhmcdvjF65vYGoBvELsFicj1vdhRzsFsJSIItuEfWEBvniyd7oytszF+1
         ZtFrQOa+MGmo5DF581UYEbrRAtjBQ6U4QsTa0uF5W9ZZf5lr6lb0hLAdSUKF940aaKeK
         oJ2V6JKVcCOLzREGhzC36pAbpRpftVN6jWK6nDekU84UPKsUE6oSneMqI/n5BqulYgtW
         usFKZRfTNFRYuJCdtH4UnASiWxT1wyO3sae16sX4At3UZs62UpYckLzb7SC9HwMWeoJy
         yojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608515; x=1741213315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUmzfiox/3jvbaM/fwzHzjWIDzglvr/7YZ92pZc/Dc0=;
        b=FqQL+LiAXP2IrvJ2JSFod5NGsXC+qy7sheocyyVpP1NktF2WhHaaaIpL53V/2GIh1F
         FO9M+0nykB3YaCCglAj/mfWzHf831bfCtNo7XkwUd9PXqLXD7flHG6lQmj2SBs97zNEM
         +B1E4SqVP2JszK7OMugW3E68j9f0F5nUcLOJYiYflhY/zbUTQC9EW6xZd0QIOFbkpCIw
         CUi3kK/1f8IYFkPfeigkIX7sPU3OJqwYGjhgnSr99rZB5ZCsdWtNZAPqers0KzMJYNWi
         MZLuC+h6TktQhQRoKSdttFG2cNz/w4aSxZjCcfLEPh3hMNEfSymLKJVS83wbVhoj3xUc
         ZpNg==
X-Forwarded-Encrypted: i=1; AJvYcCVYX6xdO0Vw9zOV91FsWOfafyq+k92i+V+u6kMvihrUtOwY36yYE+vA/cYfK2YbPjjbRdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9skQoLoezDIvFc0+1gAwmli+PBbSceZwOeIt0w9ubJpJ0eXu
	CQJgs4n/nT13vi52Tq9LSgfhTsGKQITuGVM0Ih2xqKhWAkL/T+i5
X-Gm-Gg: ASbGncsk/6L3Kw1Dhoz3CrdxNUEyumBlNKhXwt7PPjDv/mXvOrFlvsfqaBKj5xzkMnz
	fFGN8oxxJUIDMVVFcNZ2wK6Wmt2tBRomYVNzTQaiH52jEaW5iR9QXmn7qyNcv/pRSPcn9AZO1Ek
	lqbZiPjVL+yLswcRP0MDfyIf4iSPYaUPVIZplLo0DaWoU2OS4xWH/t4JrWQyp7XHDzuAwUny4d2
	Q0h6ljJabWUgY7e8wxDFSqhgrXLmePWeiL/d+a9J09a6Zk0WyuR3hHDPsj1cx5xkMlhz18ENDnF
	J8waTvQJre7J2T+h+3IztQqLlFzk/Q==
X-Google-Smtp-Source: AGHT+IGRGzMs1q5pMy6lmn6oCgl14QSnsvDMKuTRDGlJK2WIcAZZlvN1hQ7MKzMzrEF3S+WKjQ/sWg==
X-Received: by 2002:a17:90b:1f8e:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2fe68ada3bemr14818472a91.11.1740608515042;
        Wed, 26 Feb 2025 14:21:55 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6cf95a04sm2222017a91.0.2025.02.26.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:21:53 -0800 (PST)
Date: Wed, 26 Feb 2025 14:21:52 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com, zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
Message-ID: <Z7+UAA83/n9XgIdU@pop-os.localdomain>
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
 <20250222183057.800800-4-xiyou.wangcong@gmail.com>
 <87ldtsu882.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldtsu882.fsf@cloudflare.com>

On Wed, Feb 26, 2025 at 02:49:17PM +0100, Jakub Sitnicki wrote:
> On Sat, Feb 22, 2025 at 10:30 AM -08, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> >
> > psock->eval can only have 4 possible values, make it 8-bit is
> > sufficient.
> >
> > psock->redir_ingress is just a boolean, using 1 bit is enough.
> >
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >  include/linux/skmsg.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index bf28ce9b5fdb..beaf79b2b68b 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -85,8 +85,8 @@ struct sk_psock {
> >  	struct sock			*sk_redir;
> >  	u32				apply_bytes;
> >  	u32				cork_bytes;
> > -	u32				eval;
> > -	bool				redir_ingress; /* undefined if sk_redir is null */
> > +	unsigned int			eval : 8;
> > +	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
> >  	struct sk_msg			*cork;
> >  	struct sk_psock_progs		progs;
> >  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> 
> Are you doing this bit packing to create a hole big enough to fit
> another u32 introduced in the next patch?

Kinda, or at least trying to save some space for the next patch. I am
not yet trying to reorder them to make it more packed, because it can
be a separate patch.

Thanks!

