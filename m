Return-Path: <bpf+bounces-58496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30104ABC81A
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ECC17C122
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC720E715;
	Mon, 19 May 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl4raMbB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D71E4AB;
	Mon, 19 May 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684821; cv=none; b=JOg4s43z869IXBGsldOnAY2xefXEjQBqTWTCScHTdrkgK26pVuOCt6FTU6cl88rhCYzlFrB7CsvQGN0PoyP1YdRTFAgUn7vcq6MJq5gLYYfYdRWVv9n4vX9dob4uzxUrRy96ONrEpUWg95S5VXabxUI282p82GR8+I+ojP/v4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684821; c=relaxed/simple;
	bh=gDJDEDtqlLFibqDVY77tsX8YrdWJQP1Y3MY0GrR+7P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh49WNlgMWCZMRyW9VX2MHOu8lyk6wWvu5GhgsWpXWK8V+Ql0fOcg6DFbmmwCo6eX/PTy3oQxAtIlpFWR7PjOmQECy+pPVg0eCchytmB+Oc6sJFcRM+lpst4z68xEuO2H9gGyZZemlPu764hRKUwCisfsH9gp6kiEvxxqJXqzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl4raMbB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2321c38a948so20746345ad.2;
        Mon, 19 May 2025 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747684817; x=1748289617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyrSfMkWxF68QAYkbl+yVox/D2cWlK35xRBgggxH3m0=;
        b=Yl4raMbBBIeLkd0gsoQT0rPL1ejhUo2cnjmlpbON2xYT0sqbIe39sugQSjG5IKUjrp
         EsXLNlGVrRagmkfYarf0ReeeFcRp4oLLD9qvcAvWAUiS1apqJZ2Yzyxi9fijiPy0Z8OY
         ElC7ppDNoMlvaAOAVJMl2ss+xdcRpwUynVYommj52nctp2dZMVVmYrinC9FidbdbakXZ
         65duf9IQgbxuInZaI8nepVE0CtZujZuczmMOynZTu8Lx/H9ubGkaO+qEK6vCtpPKdLUf
         0pFLskofEOYs5cJkV6zbIh95UIItoiJG2bpdAfKmflAqzqXqwPZBRzv1OTmNwSrntVyb
         P3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684817; x=1748289617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyrSfMkWxF68QAYkbl+yVox/D2cWlK35xRBgggxH3m0=;
        b=czu/8KKZTbkMlGroEm5bBvsj1w9UnPzGe/k5b6I5dC8wTxHEiLAU8L85HxurWWq/dY
         z3kkDvipGjuRGo8rxFfcQxuEBculQ7Wtl2DOwIOo+1+zH40Ci7DKDr8DScrjk6H1Areu
         7d9X5xMGBkGjQa3awJUY4MBOSILCFk5CZm9Kjkzvw9T/0AchzrPfpttv4CyXc5X2V9ci
         TwerxPfKrMxiGOURi/b78j8CIFJzkkVk2m01OCBiBoWFwiQbsHXFTemjhvOTiT4KPNb+
         lq2xExjy3+fTQl1MhAMP/2FaMttzu3nD1fcQLxNWx8RRrMUP0w/RtjBq47MbmYwNhbFD
         M+6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbQ+7BY7+33gRB1g/+WMjM0Z0G3GMg82xV3VySS+JTzomvyHcKSFh/Hx6XM7OqIf7QUGJS6fHRq6Vde3jo@vger.kernel.org, AJvYcCVABzRxK9QHwzfriJ7Nx2JJllIrSWqDonbFnDRYKAGLhw3ijyyUxjsJ+i/+9WQSXKsQNLo=@vger.kernel.org, AJvYcCWFVm0ZlwfFVJirbA9Ma0S51H/G9Knd1pe1aeQkK/3w7N/c/XMMwD4wwMuazu1qq9LMOivfp3JK@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPMlIm860KGZqvBf4uCuxC3GwiInaXmBj7UsYbe9lkzw0wubn
	cgk3V93AvucFAw01WjbbdaV9c4egCOqEPoBUBvMh+xJQ1pa4eloMKwoQZPSA7w==
X-Gm-Gg: ASbGncsoHaAHLuR2kGe181huwGjeBa1t52NS7xUA1HjpxzxHPX3io3t/QC82yjlFrwB
	Y/MDmywz5uuT04ebe31Btcp1JGChkAUiCajzopg9LcBErrT3RVQ5syCeexqm82iUT7yzVONPfIu
	n4oNM8LN8MfvqQf+XLWlYTipdXzQtJgdUz/V3diS9SnmTix1VkCd+0mizkE3jIyNC97LxJFaXzC
	Nk7e+F/gFFobgNMDOZarZr2Q9S8vaRDTy2YppdQrjgw9Wf55Dm1ZDwXUeZSZJ2ugBvpZLVq45zq
	ldU5bgUdz9ZHhD+OBq4gZuAKZvNuGX+fNoH5LASBEO+Xah/zLXk=
X-Google-Smtp-Source: AGHT+IHt6QfA2F6kwpFWBtZop56Dyx7wuHXPSe127sz2HGe75T+9/4tLv/VECGkyWpD903a+rfF2mg==
X-Received: by 2002:a17:902:ce8f:b0:224:c46:d166 with SMTP id d9443c01a7336-231de3ae584mr206812435ad.40.1747684817188;
        Mon, 19 May 2025 13:00:17 -0700 (PDT)
Received: from gmail.com ([98.97.32.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebae24sm63905955ad.197.2025.05.19.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:00:16 -0700 (PDT)
Date: Mon, 19 May 2025 13:00:03 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix concurrency issues between
 memory charge and uncharge
Message-ID: <20250519200003.46elezpkkfx5grl4@gmail.com>
References: <20250508062423.51978-1-jiayuan.chen@linux.dev>
 <aCorf4Cq3Fuwiw2h@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCorf4Cq3Fuwiw2h@pop-os.localdomain>

On 2025-05-18 11:48:31, Cong Wang wrote:
> On Thu, May 08, 2025 at 02:24:22PM +0800, Jiayuan Chen wrote:
> > Triggering WARN_ON_ONCE(sk->sk_forward_alloc) by running the following
> > command, followed by pressing Ctrl-C after 2 seconds:
> > ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
> > '''
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct
> > 
> > Call Trace:
> > <TASK>
> > __sk_destruct+0x46/0x222
> > sk_psock_destroy+0x22f/0x242
> > process_one_work+0x504/0x8a8
> > ? process_one_work+0x39d/0x8a8
> > ? __pfx_process_one_work+0x10/0x10
> > ? worker_thread+0x44/0x2ae
> > ? __list_add_valid_or_report+0x83/0xea
> > ? srso_return_thunk+0x5/0x5f
> > ? __list_add+0x45/0x52
> > process_scheduled_works+0x73/0x82
> > worker_thread+0x1ce/0x2ae
> > '''
> > 
> > Reason:
> > When we are in the backlog process, we allocate sk_msg and then perform
> > the charge process. Meanwhile, in the user process context, the recvmsg()
> > operation performs the uncharge process, leading to concurrency issues
> > between them.
> > 
> > The charge process (2 functions):
> > 1. sk_rmem_schedule(size) -> sk_forward_alloc increases by PAGE_SIZE
> >                              multiples
> > 2. sk_mem_charge(size)    -> sk_forward_alloc -= size
> > 
> > The uncharge process (sk_mem_uncharge()):
> > 3. sk_forward_alloc += size
> > 4. check if sk_forward_alloc > PAGE_SIZE
> > 5. reclaim    -> sk_forward_alloc decreases, possibly becoming 0
> > 
> > Because the sk performing charge and uncharge is not locked
> > (mainly because the backlog process does not lock the socket), therefore,
> > steps 1 to 5 will execute concurrently as follows:
> > 
> > cpu0                                cpu1
> > 1
> >                                     3
> >                                     4   --> sk_forward_alloc >= PAGE_SIZE
> >                                     5   --> reclaim sk_forward_alloc
> > 2 --> sk_forward_alloc may
> >       become negative
> > 
> > Solution:
> > 1. Add locking to the kfree_sk_msg() process, which is only called in the
> >    user process context.
> > 2. Integrate the charge process into sk_psock_create_ingress_msg() in the
> >    backlog process and add locking.
> > 3. Reuse the existing psock->ingress_lock.
> 
> Reusing the psock->ingress_lock looks weird to me, as it is intended for
> locking ingress queue, at least at the time it was introduced.
> 
> And technically speaking, it is the sock lock which is supposed to serialize
> socket charging.
> 
> So is there any better solution here?

Agree I would be more apt to add the sock_lock back to the backlog then
to punish fast path this way.

Holding the ref cnt on the psock stops blocks the sk_psock_destroy() in
backlog now so is this still an issue?

Thanks,
John

