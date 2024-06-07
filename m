Return-Path: <bpf+bounces-31619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05631900A1C
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171CD1C2276E
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255919A281;
	Fri,  7 Jun 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSEKpS2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0028D27A;
	Fri,  7 Jun 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776848; cv=none; b=hUMtuej/ZAdtDnUAni+EEFm4Sbp2YeE//ucf/FWOHosmUjZSbOW3GFKh/fsvmBdIGH0K0y9W1sjCfij0QjwwUHZHwbMgh12lRzcp1zdmy2Us3mTMNRVe9LLZHmSRbwE6GwT0d9bNuPCNE1vxVI3QiTzsnSOJ66B+1ejGQyE8a9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776848; c=relaxed/simple;
	bh=7X+i6/m5S/SZaDMGnWrwXOVyR4lYc9mbLna/qqbUphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjL3ngAjYHsKGU/i1yt6+mC5MTvIwdsUJwdSi9z6HvVvojUS70rzQmRiMhAkAuGdGeGpNovX7eJANgMY+ocHQWJPaGH80zASeuOihtHb/gpatqSe73VWHaOgNsO6urG6u+zO0o97IWhM3mSqDLcU51i3O7fkDCeFimjxJ27TiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSEKpS2w; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb41c9260dso101418339f.1;
        Fri, 07 Jun 2024 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776846; x=1718381646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZY8pZG0Qp10WbpZe6DVvOQtoLlFafQT2Cqu/dEYMTA=;
        b=gSEKpS2wpUtdzryMtegMUPzTLc9M6yBIGvIu0K5D/7lj2vYEbDg58OuEx95wtbD/b5
         spFdz/oW2zPLMJ+sNdFt3aaOBVVLHczAYgkc/usEAWnmG3bG9Uk3t3EBBzOOXo9s1WaA
         StiH5AxC8jNJk9BYn/HCjhxGxjgZQ/b/+OQtB7kVbtasl4Fozo5MQQzfluk0yVziSL1J
         M1KXREnfUMIYkAtSquzNQxvaOUiZ4oth/gMrKABilDDXc0jk0dmmn5eoxbkTDsZWjRg/
         uNcLe4Lsd2OTTd+HIIfpHOx/hEy8ptTxFtA8RTfu5KjZ3e/Ia7uMBhBWHIG8TO273o1A
         IC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776846; x=1718381646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZY8pZG0Qp10WbpZe6DVvOQtoLlFafQT2Cqu/dEYMTA=;
        b=Fei5eWveAYOEr3VG6Dy4i4FMsp3buCCEESLXM+934xJy7r+mNFrxV5NORwGCkj3ldJ
         kNDD8yzjqlKIWSWUNzaPJ75RHFJn1WXCp2OZFK3wMS4JfzeDGLHW+5h6C9oCiCYFyiGD
         K4fjQDXViEmHTrOcgsbRxMsnM9oCaJwxuoyg/mHSKm8+ZC+abL2xvB4isVxCQdNdUmhz
         54ZgsvLDbmZTQOMSqI4yReUkH8gY35R/aBqjOfpqh2FiHaYbzvPYltvB95DmgGN4i58a
         VmzGIJwJVO5jghfKqbivh5soMoitR1CrsV2np8pnZYbuX7EMzVC9VDY5kL3jTVkHRx+X
         W71Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOdALC7d8/XnJez2Jzy6KfjhlVrd95j5g/kkCCiyhzp1ZE5wwJkOy/jWODOwC4+TJZgfF7HPxNBfhSWhAcA6eB9o0Z
X-Gm-Message-State: AOJu0Yza4jkiNNOEEdYy0uXA/tZOApRdqCyI2kTEGyFOqXC3FuSEQSh0
	LwM2jz94/XBQsIF+e7Q4mORFPkn1mw/4000XtlLbyTfU8F9Kdb9IOtbqbA==
X-Google-Smtp-Source: AGHT+IFni9DAIrTiKXd/4rxrsPqbglxdvZ5w7j+R04nvowc8J5xDCu4rTfd+30pr//9eb3GOtSa+7A==
X-Received: by 2002:a05:6602:3f8b:b0:7e2:181:a054 with SMTP id ca18e2360f4ac-7eb571d3377mr355942639f.5.1717776845734;
        Fri, 07 Jun 2024 09:14:05 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:ec8a:c212:32db:10a5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28e23171sm2772526a12.93.2024.06.07.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:14:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 09:14:04 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Subject: Re: [Patch net] net: remove the bogus overflow debug check in
 pskb_may_pull()
Message-ID: <ZmMxzPoDTNu06itR@pop-os.localdomain>
References: <20240606221531.255224-1-xiyou.wangcong@gmail.com>
 <20240606232747.GE9890@breakpoint.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606232747.GE9890@breakpoint.cc>

On Fri, Jun 07, 2024 at 01:27:47AM +0200, Florian Westphal wrote:
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
> > helpers") introduced an overflow debug check for pull/push helpers.
> > For __skb_pull() this makes sense because its callers rarely check its
> > return value. But for pskb_may_pull() it does not make sense, since its
> > return value is properly taken care of. Remove the one in
> > pskb_may_pull(), we can continue rely on its return value.
> 
> See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
> without this check, I would not give up yet.

What's the point of that commit?

The "fix" (I doubt it fixes anything) you had is merely exiting a few
lines earlier than pskb_may_pull():

 30         if (!skb_inner_network_header_was_set(skb))
 31                 goto out;
 32 
 33         skb_reset_network_header(skb);
 34         mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
 35         if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
 36                 goto out;
 37         if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
 38                 goto out;

Before your "fix", we exit on line 37. After your "fix", we exit on line
30. I don't see any difference here, it returns -EINVAL anyway.

> 
> bpf_try_make_writable() could do an explicit check vs. skb->len.

But why? I don't see the point of its existence. pskb_may_pull() already
checks it very well:

2741         if (unlikely(len > skb->len))
2742                 return SKB_DROP_REASON_PKT_TOO_SMALL;

Thanks.

