Return-Path: <bpf+bounces-33993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84F92940A
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48D4B22482
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E913A3E8;
	Sat,  6 Jul 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keZgZSMY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8724B5B;
	Sat,  6 Jul 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720275992; cv=none; b=Qkg8na8OPh+h+OGYokkQ2qjWOwYfXiuX+vebv+HiDDlS0kTLIzLuevtfFDQ0LvaeJvctZT/rxs0jehDtgK/1eG3BYN+XuxB1mzZz8r0su1Z5kDbDmy8UHJ2R6SlISSYR6FVKrUmLJLY+fzOUw3nHP0CsrwXweRN57aM/3Tk/p/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720275992; c=relaxed/simple;
	bh=1Yf5eXxazwQxeNpPUkRrRB1Xu3aBBRE79k2g+ye2u20=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=URm2dvq8q97tV7Cx2H8NTN6KdfTvXpoFWU5jvJZbQ+a8tHepM6f2ZFRqMk90uUaj8Cg66t5QYKNgNs8ncwUPabSU73qPAIIa2uk710Y83fPyIEARvt1RBbKbNzR5oiS+st+H4inWsCLVGtYBiXfhNRjQ+wT3na2sRXk2b0xZLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keZgZSMY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5def3916bso12385406d6.3;
        Sat, 06 Jul 2024 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720275990; x=1720880790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seYqp1dT5F5vy2P9brEQHllr9NxXw0Yqi8+EB26VwJM=;
        b=keZgZSMYeMUNJZu64O7p/gWG+a0bnSO/FX17ZC54Q1gR1PG9AnD0Y+m+LlS4FQ9hEW
         uRnLQW7xYMwjUOiCfsU61dmSxYt++jOkKe74ghfez5APLOE5hV69a3XPwoaxvArbC8I4
         dZxZhAhWQxAqAGj7o+hwtLwh25ok04ePRybit3RzpTEhPouKbelaw3BbWpmG6qDEd6yj
         TTeG2DI23VU2rHnG1TcL9nG3SvqJ5ZJMxt54Mw57Cw7FbgubZMqGxEJhcWwlXxhAZG/M
         s/WarVl+SXgFk2GL3l3RAqW9ZLHsEF0heo4jDgSqX5+lZVewtEfJNLbZmwO21YZxK/Mo
         glVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720275990; x=1720880790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=seYqp1dT5F5vy2P9brEQHllr9NxXw0Yqi8+EB26VwJM=;
        b=sy1vY7v0LYXsyN7Nc1dACy0bLxGhIRlXYHW60aR2BjgjREElUNMtCwOii4h4GBd58/
         HMoA35B5aOFZpMa8fJyX2vQFQkb+ImIhX/t0G432Nl0sU02MsazWTm7z/MBT4tYA/h5/
         m5yQ/zcHAwrYzOVVwlreUaO8x2O5Vm/RenQTcBhYFdFLdiiku3aMTpufWsgI2d5eNSoy
         aGB0Fs5Yo54WI48fi/pBwm9Cfj34HUA6f6UNzBU+0XTgDIR66VOfLleuiODlFZTedEBG
         4wHKmdTZ9vpjkqvxle/i3eKGdl460w4z7JvDcY/f+Uufljxm4e+nXH9wlMWPK96KeE+p
         erhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3jUOUhs9cMJQpo/RJDYuKBNjq0Bf81idhIesMTRRCw8K7vq/4PtJnP6mCXy8pCQiXfusRn6FwdVqyJayIWoS/T6S8OIupy5wmiOC5tJSglcWR1jan84AGYs1x6Sc8njBgD2JgW4J1zLiF7lB6n4ZJ2ktIpkHKQ/g
X-Gm-Message-State: AOJu0YxMhmuQzJqvVPz65uJkJguuzC5oJiKc3cvnTEYL40TnBsIl5t9l
	cpTsazmjk42Y/qOK02LBuZKOB97sATJ1/GLwXUt+i5pA7/SGb1Bs
X-Google-Smtp-Source: AGHT+IHCoEogj25RngjUznqdwqR1FD0j1Dq20vECsA/TsfiSL9Y7zCCU8h42SrUSaOAyGLsoH/xZFA==
X-Received: by 2002:ad4:4ee5:0:b0:6b5:e3f2:11c9 with SMTP id 6a1803df08f44-6b5ed19c47bmr106387576d6.49.1720275989786;
        Sat, 06 Jul 2024 07:26:29 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5fe1de71esm11176416d6.75.2024.07.06.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 07:26:29 -0700 (PDT)
Date: Sat, 06 Jul 2024 10:26:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Fred Li <dracodingfly@gmail.com>, 
 pabeni@redhat.com
Cc: aleksander.lobakin@intel.com, 
 andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 dracodingfly@gmail.com, 
 edumazet@google.com, 
 haoluo@google.com, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 jolsa@kernel.org, 
 kpsingh@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux@weissschuh.net, 
 martin.lau@linux.dev, 
 mkhalfella@purestorage.com, 
 nbd@nbd.name, 
 netdev@vger.kernel.org, 
 sashal@kernel.org, 
 sdf@google.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 herbert@gondor.apana.org.au
Message-ID: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240703122153.25381-1-dracodingfly@gmail.com>
References: <fd44c91884d0ebf3625ac85a1049679a987f8f79.camel@redhat.com>
 <20240703122153.25381-1-dracodingfly@gmail.com>
Subject: Re: [PATCH v2 1/2] net: Fix skb_segment when splitting gso_size
 mangled skb having linear-headed frag_list whose head_frag=true
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Fred Li wrote:
> > I must admit I more than a bit lost in the many turns of skb_segment(),
> > but the above does not look like the correct solution, as it will make
> > the later BUG_ON() unreachable/meaningless.
> 
> Sorry, the subsequent BUG_ON maybe should be removed in this patch, because
> for skb_headlen(list_skb) > len, it will continue splitting as commit 13acc94eff122 
> (net: permit skb_segment on head_frag frag_list skb) does.
> 
> > 
> > Do I read correctly that when the BUG_ON() triggers:
> > 
> > list_skb->len is 125
> > len is 75
> > list_skb->frag_head is true
> >
> 
> yes, it's correct.
> list_skb->len is 125
> gso_size is 75, also the len in the BUG_ON conditon
> list_skb->head_frag is true
>  
> > It looks like skb_segment() is becoming even and ever more complex to
> > cope with unexpected skb layouts, only possibly when skb_segment() is
> > called by some BPF helpers.
> > 
> > Thanks,
> > 
> > Paolo
> 
> I'll wait for more suggestions from others.

In general, agreed with Paolo. Segmentation is getting ever more
complex and the code hard to follow.

Maybe at some point we'll have to bite the bullet and seriously
refactor it. Or at least parts, such as the frag_list handling case.
But that kills any odds of backporting fixes, so not if we can avoid
it.

In particular, changing gso_size on skbs with frag_list is fragile.

Instead of adding another special case, how about just linearizing
sbks after BPF calls adjust_room (at least if called without
BPF_F_ADJ_ROOM_FIXED_GSO) if they have frag_list.


