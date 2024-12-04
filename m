Return-Path: <bpf+bounces-46042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A579E309E
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 02:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E041615A2
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 01:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CC579D0;
	Wed,  4 Dec 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io0b02hF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF933D1;
	Wed,  4 Dec 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274119; cv=none; b=MIQL3pv6GaFQQ5s6lHEK4JoX8xeLoACNtrpJCPelcTJ3aIDwFUS7C/C5fAzf9GXj/w43rPauu/jSm5ZN23J/EPj3JBZbUp94gGxbHuusHN77zFZvPdOjo6sxmP4AuBbltaDyUOP4FAbhYjBs9rnFmPwmvbMiPhKkZZjxCumLfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274119; c=relaxed/simple;
	bh=Q/hE6vafS8AK9DXxlgN7oJoBBfn5dM/iZsb7tKqHl08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe2ePS9jwV3Jh9jMTgilqa2Tg61Sflg2kboSJOjta9rMDhn1mIE6wZgsJnb3P7yQAx2CwDZZoSloehhHSdfTbqAMeYhyDewMwDAEsEpZ2aqLtkvgyuV3OANM/PJ/ZW63E7rXHZ/FMk3ktihnb28T/s9sB2+SVfwJr2CFkW0b5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io0b02hF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2155157c58cso30727985ad.0;
        Tue, 03 Dec 2024 17:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733274117; x=1733878917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwZUXExGPKhAMcqBJ8vWwXOyG5Enp2SY9gQFDpob96I=;
        b=io0b02hF8bgk6xZnqZPnPQMPjxH8TpaHtONfV9rlqZJxrLJ9i/08DyaWJ29tD15BU6
         eXANYKZIB42dkPOpA1RwZqJNQZNnk14mUk2SFQECMQQgLPVitXd9cr0Qaebz6jYA1CPW
         2WA+EE8EskwrOrPEV655+Bq37P5rbKWKI0qQD1/tFU7qh7jFSq8ZYrs7yx1049azeVIV
         e0xC5rYpxAET/vxgnHKtur/j9QXx5bQ6/fMZZ2OjEsqx3c/GWDgcPZ7HsQzA2NDRo+rW
         mlecIDmqTSN1SBBqxmeeXvQTDkvEgpOMlKRgBZ2HXo2tKYw648WTBbLYc9NsHBXsbvF/
         jxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733274117; x=1733878917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwZUXExGPKhAMcqBJ8vWwXOyG5Enp2SY9gQFDpob96I=;
        b=LaWxHRx/yASyxPY8ihKBWn39ucQFm9ge866N7Pbb2hIG2UkE5flItY/qkEjqNND66C
         QAe3L9HWQTKjm0cp7mtKZmY6skYspeFrDG5kKTYUgfiqQV8WDkWv0oHfaZT9QXmOm4AQ
         o1lJnMk+XqYtqbyGyHidXLU71Gil/Ii2HB9QaKnsfjePCWM91mWJW0ycJRN4mdmFpYq+
         Sft9pasumZMbdfsgo7tjRpqcXLK7Vbu/IUcuh1GNTr2RSVPZw/3DFxKum3UPb2m/qJVJ
         KWzL0vI9umSSArR+YCuQ4dnB4VLRUk1DJ8OemHG7TXrxfJF2BqjqEHzJUxa0A9agi1Ly
         gwfg==
X-Forwarded-Encrypted: i=1; AJvYcCU59lKX97mZJHPuFuhLVm3moYDGtF8HJvqGcGXDofmpn3lkxkH5XFvjANCGe3yrR7KL3CI=@vger.kernel.org, AJvYcCVKRthlYPg4Tzr/5zLp92Iz4UP8Qbe62/TV1wmTgpkIFQI+QypUOijuPLMZu4tsbQzcT6bpmDGxzTFyxnkA@vger.kernel.org, AJvYcCW3l6lVWRRFH45NxD6gtiyQgL2vrsQSyQOhzqc3aydbEXH94MbRX8OyfDL8M0EXzelyba9HhOc+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mCGQrcKHiuPPuM+JOXBotKzfR5Mp7k8VShocD5IiVu0IHc8U
	eh08R2Jp/LWIPD+IGZ7OPlRcVsDCwIAZw3Hcn/XqIVFHuoo5SG5z
X-Gm-Gg: ASbGncsZD2t/HgIr24Eu26wQEPCE6LoeliHppovTsNcgwrRrxHyEeLRnAQbqEfsZ+WN
	Qj4Gl0DDYLxnMlHABvm+AMoMF1J/mrwH0WpzBwHVt1Bf/HRLZM3KxVueDgoMQNkxSANOR//e46W
	DnV2Hx4wr/cxpT+Q2CRp7fsn8W27eH/ES+mrgmPiRX1E3iEHu/3tBogXsO8PgEUwF6DKNyZj/7c
	IZ1hUVv4cNTkj/et309M6fGEJ3rl+hPafFQXBexDSozVYUaCWjZt4B8
X-Google-Smtp-Source: AGHT+IG8NXj6SK5e+9gYKjJFpUbhvuBG5Y8EpnYjjYRQzPOKD43zqUoo13ElslwuS4fLvattED1nDQ==
X-Received: by 2002:a17:902:e846:b0:215:ba2b:cd51 with SMTP id d9443c01a7336-215bd0d71e4mr52971975ad.15.1733274116866;
        Tue, 03 Dec 2024 17:01:56 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:32d6:f9ea:3b48:6054])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157597c2f6sm53000185ad.204.2024.12.03.17.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 17:01:56 -0800 (PST)
Date: Tue, 3 Dec 2024 17:01:55 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Levi Zim <rsworktech@outlook.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
Message-ID: <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>

On Sun, Dec 01, 2024 at 09:42:08AM +0800, Levi Zim wrote:
> On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
> > I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
> > test_sockmap.c triggers a kernel NULL pointer dereference:

Interesting, I also ran this test recently and I didn't see such a
crash.

> > 
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> >   ? __die_body+0x6e/0xb0
> >   ? __die+0x8b/0xa0
> >   ? page_fault_oops+0x358/0x3c0
> >   ? local_clock+0x19/0x30
> >   ? lock_release+0x11b/0x440
> >   ? kernelmode_fixup_or_oops+0x54/0x60
> >   ? __bad_area_nosemaphore+0x4f/0x210
> >   ? mmap_read_unlock+0x13/0x30
> >   ? bad_area_nosemaphore+0x16/0x20
> >   ? do_user_addr_fault+0x6fd/0x740
> >   ? prb_read_valid+0x1d/0x30
> >   ? exc_page_fault+0x55/0xd0
> >   ? asm_exc_page_fault+0x2b/0x30
> >   ? splice_to_socket+0x52e/0x630
> >   ? shmem_file_splice_read+0x2b1/0x310
> >   direct_splice_actor+0x47/0x70
> >   splice_direct_to_actor+0x133/0x300
> >   ? do_splice_direct+0x90/0x90
> >   do_splice_direct+0x64/0x90
> >   ? __ia32_sys_tee+0x30/0x30
> >   do_sendfile+0x214/0x300
> >   __se_sys_sendfile64+0x8e/0xb0
> >   __x64_sys_sendfile64+0x25/0x30
> >   x64_sys_call+0xb82/0x2840
> >   do_syscall_64+0x75/0x110
> >   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
> > size(8192), which causes the while loop in splice_to_socket() to release
> > an uninitialized pipe buf.
> > 
> > The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
> > will copy all bytes upon success but it actually might only copy part of
> > it.
> I am not sure what Fixes tag I should put. Git blame leads me to a refactor
> commit
> and I am not familiar with this part of code base. Any suggestions?

I think it is the following commit which introduced memcopy_from_iter()
(which was renamed to sk_msg_memcopy_from_iter() later):

commit 4f738adba30a7cfc006f605707e7aee847ffefa0
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sun Mar 18 12:57:10 2018 -0700

    bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data

Please double check.

Thanks.

