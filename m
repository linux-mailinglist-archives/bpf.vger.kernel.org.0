Return-Path: <bpf+bounces-52797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB7DA488D6
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592497A9ACA
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B926E959;
	Thu, 27 Feb 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT4o6cEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FC26E94D;
	Thu, 27 Feb 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683691; cv=none; b=GMIt33NtdgPs3PV2g1yRqkSGeF8BvoKdguH686WUC9hH6pw90Joz29XSEYRqLg1KH6M8j2ZBszQKsdavh9vWRNLIeNgcZpjwyzl9mp7pIT4gGvV96wXSK+ha571tvRV/iKbDpjnL+MsxlofiC7RaEOUiL1IuZiS5f9DW+zDKzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683691; c=relaxed/simple;
	bh=blYPvDH2ACr8bgPkdI15DSzbv23Pg8uT/Ia003sNOV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHIA7J+UcgshEL0L0V5kIz9rEmxp+wK5o6C75oyX2Vk5vQNb2gaujnV3BOeRtC2eRstBP3aE1fiXVSmCo4ZOUzCQi4NV4FkX/ifo0KadQ9rY7PY93wSSgGLp1pPAkbvtAc3ZMjMKx3IOhFiKy50h8WsrKNFEbLso52T+J5QE9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT4o6cEG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2232aead377so27409025ad.0;
        Thu, 27 Feb 2025 11:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740683689; x=1741288489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITI0j5SAALSQksAHWBdv3yk+wyS0uEKSyMIjI5OOl5s=;
        b=TT4o6cEGn7O4GXxdgT62MqVYqYgRqUhPtkb8QQp2yh6czObq5pYs5vLZEnji9GCzJP
         xPqt8oqAJxoItOQloZubDAVbwEQOsxRQ1YNwrEQLD30UdaUFLw89YsDGkOrYLHG+pjR2
         3uDe5ffF75oJJJGaWkz6IYo3RdzGliNnJvrXwowpuj95dMTG0qXlhjAnJc4H7synALNA
         NV7P/bSE6vmaq30spDVKj86D7kDkhpYIzzCxHg8fUOX9A22ILHnmmiuuOapMqezCBbdr
         6ER8RRNMmHwws+NgiklU9wY6VeTv/9YOibdHaUuXYDphHWVa4I3MdyzyuY6N+EgG+psc
         72rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740683689; x=1741288489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITI0j5SAALSQksAHWBdv3yk+wyS0uEKSyMIjI5OOl5s=;
        b=CqR0qMJHANh8nP0ufWttEv07wOlDT89Tcy2qoMMAQ4pJz0h3SQnrCcrAZLMTu95aeP
         A7lYz9qkn7v4QRGqmo4P1ZTZIG+KDpNDtpHWgxiVqS1p9TZ/s3EFg9nI8Yps2J43AfnC
         VSQD7igq6m/CG2iULbOh72sM2g8QxPLYLgohkbeSvpyG80poVsZtnR687BpzOCQ4uIqZ
         NT0qhd9KshFu+h9fC0rYgWhVpDiJ73EKZxPYZUVeYw5j4N3o6b356DJdKNN/HbMhZKYu
         WE+nZEnUN6R8sadkOQSK5sf89rQsNobP7nnOBnw/ThUO50i6jGoAywgXxTc1usz0VXSK
         kClg==
X-Forwarded-Encrypted: i=1; AJvYcCXf7BER97xSFvipEjYUbcMlb6xVoFF6E0No1fPgwVqXMxDFtkhJZv3aMh00VmYcIeTmabQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FPAr7wl98aB15qOahN+8XhECr9xcovgF6WRSCLAZzqHey/wb
	9MC9jsMF/TwE5yBmeXTDU8AnBKa7K178cXGxg4zwqIUkA0MpDhnX
X-Gm-Gg: ASbGnct/UcUQofheD8PYVGRqABq9jxr/dCuJRkYS4rNDpmlIZEWNjjz5jvbwA5OHV+V
	uBPLb1zvtLXMWOoy3EnC8n4YcrsXILGi7DjCiCnLKO6JXwwFBxZ6egcc+61/+VHUv9RH1vXfv+k
	eKPjQnYm8XHrnZQkLe4/5z9ihjcKRTL4rPWgpx4jVuhkmpCtkqpiCSUHePKIVj6VSb6EM2M2656
	ohA82arDwfTIZuk9uPTei3BiLxSMArr1b0B5kPVGtrqnIRWFmMB7MDQDw9KfrKTUTM+QUA1mp1/
	42dI0X7M5LXzefZXXvZn5BsWyJ8ALQ==
X-Google-Smtp-Source: AGHT+IGDzIkY5yHYl0IHOp2oPGj2SXmtdjk14H2yQf0nF0VaYoG8N+ji3afgP4KihV8+zf1RQlWz9Q==
X-Received: by 2002:a05:6a00:464f:b0:730:9a85:c940 with SMTP id d2e1a72fcca58-734ac467393mr885641b3a.20.1740683688717;
        Thu, 27 Feb 2025 11:14:48 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cd66sm2056821b3a.74.2025.02.27.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:14:48 -0800 (PST)
Date: Thu, 27 Feb 2025 11:14:47 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com, zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
Message-ID: <Z8C5pznZoY6fuZyV@pop-os.localdomain>
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
 <20250222183057.800800-4-xiyou.wangcong@gmail.com>
 <87ldtsu882.fsf@cloudflare.com>
 <Z7+UAA83/n9XgIdU@pop-os.localdomain>
 <87eczju30u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eczju30u.fsf@cloudflare.com>

On Thu, Feb 27, 2025 at 10:53:53AM +0100, Jakub Sitnicki wrote:
> On Wed, Feb 26, 2025 at 02:21 PM -08, Cong Wang wrote:
> > On Wed, Feb 26, 2025 at 02:49:17PM +0100, Jakub Sitnicki wrote:
> >> On Sat, Feb 22, 2025 at 10:30 AM -08, Cong Wang wrote:
> >> > From: Cong Wang <cong.wang@bytedance.com>
> >> >
> >> > psock->eval can only have 4 possible values, make it 8-bit is
> >> > sufficient.
> >> >
> >> > psock->redir_ingress is just a boolean, using 1 bit is enough.
> >> >
> >> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> >> > ---
> >> >  include/linux/skmsg.h | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> >> > index bf28ce9b5fdb..beaf79b2b68b 100644
> >> > --- a/include/linux/skmsg.h
> >> > +++ b/include/linux/skmsg.h
> >> > @@ -85,8 +85,8 @@ struct sk_psock {
> >> >  	struct sock			*sk_redir;
> >> >  	u32				apply_bytes;
> >> >  	u32				cork_bytes;
> >> > -	u32				eval;
> >> > -	bool				redir_ingress; /* undefined if sk_redir is null */
> >> > +	unsigned int			eval : 8;
> >> > +	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
> >> >  	struct sk_msg			*cork;
> >> >  	struct sk_psock_progs		progs;
> >> >  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> >> 
> >> Are you doing this bit packing to create a hole big enough to fit
> >> another u32 introduced in the next patch?
> >
> > Kinda, or at least trying to save some space for the next patch. I am
> > not yet trying to reorder them to make it more packed, because it can
> > be a separate patch.
> 
> OK. Asking because the intention is not expressed in the description.

I will add it to the patch description for V2 (after collecting other
feedback).

> 
> Nit: Why the switch to an implicitly sized integer type?
> It feels a bit silly when you can just declare an `u8 eval`.

I have no strong preference here, either should work. :)

Thanks.

