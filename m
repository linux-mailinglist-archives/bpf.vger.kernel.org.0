Return-Path: <bpf+bounces-46493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB49EA898
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 07:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FE118828C1
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1C22ACF5;
	Tue, 10 Dec 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc0wNKPd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469191D0E28;
	Tue, 10 Dec 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811287; cv=none; b=UmCLRmzDiG6vrRjg+KzJ8HmgRms9/fLBLX8xiTkuxK8oVkUmaXQ2sVbUYIu3rtKe4owVmU2d1S/nkKHjVvCGoBUpKBPuOnR8q5RhgPXt9o45eo/cUG215qngvDreIC6eCNmHNQZfwsx4NlCJ0zFY3oWp0zq8qBsZMA7ibPoncyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811287; c=relaxed/simple;
	bh=AR06kwg4ea8BP6tJ/A64fwSQitfvxzNemx5F1/7aBsg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fOUmuoGwGN2bg/CjAWj53stScmNlj5rbRfaolShrrHUJmG4UtGyMrqhNKMhul6EkwusGRvlgACsQ8KNTgcM1LlAjnxEntSjIUvaXmwBw1TsRCYoo6ybT/QZJEb7XD8gAP2L5YZ3bLcEE/IT9byIuA7x6UrhOT1HLOD+m3laxYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc0wNKPd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso3792458a91.2;
        Mon, 09 Dec 2024 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733811285; x=1734416085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWcV6G4iTKswN4OQdoEZk/UPaUce620jWqio98BeEhk=;
        b=fc0wNKPdT7JuEOk5u838p/kOIg7uzWchAs6nUtT2lDLCGMSfTVQMeB8IXTvYLuWiZ0
         PxwOV5MkGelIuGX7LcPnxBJywhLWevD2uQFGcLA8Bp941zqHHHpWPaPzgX8xwFUV2ubl
         slnVxmIc5mCf/9vtp9rVNAHeu+WK1pakhq2okc+Er2sqg0cFrWHvWatH9aKgz764HGhw
         bUQ9qskL9lAqA0g/vOQ0qKvQ0/0a4HUuv45PoATDaZHme1AU+yTDgqiVLOm4vRcRp4lV
         /h25zofWIoz5668s/4QZYOOL7GnSL2WheJORz7foq+ns4TNcBfHZQGexdsZcYcfjAQRd
         8wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733811285; x=1734416085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWcV6G4iTKswN4OQdoEZk/UPaUce620jWqio98BeEhk=;
        b=QN6klolZg6GJa+/j91MzVd7xgNuiNzJ2hWYEAuD3OJ9hdfkalbHmEbUEEHtzv2ZzTD
         CExtvg2JrPyC5z/+BARXqI9295Qiv2b3OUCogIgxKVQH8aKCxZ0lKhuqpUxL8o8sj96I
         ZhcYUQ7kuR5YAMaFFtieRm0Ruhxwn4/SwJThNEY4JaV4WbcPaYka2H+SINB1WZDHciH2
         pm98QG6jneMENQxGUvGDSt7cFtq8MJdNpXwPiCMbxTpW4fCDlVZJeQd5nZ4jbDVlvd0N
         1Fu0gHHAHVKv2HXF5IvU+ZV19dae5+2DY62n/wsLQrvy+CtMrPq8ST62zS5jNpxFay8O
         xKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWon0suM1Oysg38Q0rGFqzDJTKbil/PfI1iKxoO5W0MTcMJg3yAYhbK0dLNFJAI3mFyYOY=@vger.kernel.org, AJvYcCXdi8JZye7YvpRXTJu4SztvUJWYsrCrHdkCITHnzyALRdwnE7eEBB5prKO11El/T6O+t5cCxkAlgpq8KO04@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSvlDBaQWDYJsGuv7Ubjd6rlAZKyQiFajbfdEEqQ/IlvRwd7/
	F0i8xNbVX6dnuNkp6GhgEEW8zz5Qm41zC8tQFvl34L6uvGpeu2Al
X-Gm-Gg: ASbGncu0ZgBdfn9xjzy9YLkxzUSpXTBRf2FgYY1oUgpKcL7FL3oQ3ujslwIi2uLlksL
	zQ6HnjtrzKJnzni31SSrtZNV1Nr+ge3wqoIdG7Spqx6+qf0Ex3PN2v6dpYUNpXZBXOM9AVgsiGP
	AivnGLDiJrI/t1DQFm3wyuJkSA8RFKNaZduTneVAqQUNt2qfT5kv6Vb1DUYlOeRS2cAhEErIa2z
	M3SkuTMbMM/mQvWbMecs5Dr6e0cZhvAuA0TP8+1hOnuwnOSM0U4T/o=
X-Google-Smtp-Source: AGHT+IFgfvh+QHowslIBqZJc21vdMHIl3ls4qtIxXIvIlZiFqGdsq4XAvXi4sA+rcyQiQnHxK7ApEg==
X-Received: by 2002:a17:90b:3b8c:b0:2ee:b666:d14a with SMTP id 98e67ed59e1d1-2efcf1693a4mr5667249a91.17.1733811285439;
        Mon, 09 Dec 2024 22:14:45 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270790b9sm10859140a91.40.2024.12.09.22.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 22:14:44 -0800 (PST)
Date: Mon, 09 Dec 2024 22:14:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Levi Zim <rsworktech@outlook.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6757dc5255b71_404920841@john.notmuch>
In-Reply-To: <MEYP282MB23125E657B3605921535987AC63C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com>
 <675695f1265b2_1abf20862@john.notmuch>
 <MEYP282MB23125E657B3605921535987AC63C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Subject: Re: [PATCH net 2/2] tcp_bpf: fix copied value in tcp_bpf_sendmsg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Levi Zim wrote:
> On 2024-12-09 15:02, John Fastabend wrote:
> > Levi Zim via B4 Relay wrote:
> >> From: Levi Zim <rsworktech@outlook.com>
> >>
> >> bpf kselftest sockhash::test_txmsg_cork_hangs in test_sockmap.c triggers a
> >> kernel NULL pointer dereference:
> > Is it just the cork test that causes issue?
> Yes. More specifically only "sockhash::test_txmsg_cork_hangs" but not 
> "sockmap::test_txmsg_cork_hangs"
> >
> >> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >>   ? __die_body+0x6e/0xb0
> >>   ? __die+0x8b/0xa0
> >>   ? page_fault_oops+0x358/0x3c0
> >>   ? local_clock+0x19/0x30
> >>   ? lock_release+0x11b/0x440
> >>   ? kernelmode_fixup_or_oops+0x54/0x60
> >>   ? __bad_area_nosemaphore+0x4f/0x210
> >>   ? mmap_read_unlock+0x13/0x30
> >>   ? bad_area_nosemaphore+0x16/0x20
> >>   ? do_user_addr_fault+0x6fd/0x740
> >>   ? prb_read_valid+0x1d/0x30
> >>   ? exc_page_fault+0x55/0xd0
> >>   ? asm_exc_page_fault+0x2b/0x30
> >>   ? splice_to_socket+0x52e/0x630
> >>   ? shmem_file_splice_read+0x2b1/0x310
> >>   direct_splice_actor+0x47/0x70
> >>   splice_direct_to_actor+0x133/0x300
> >>   ? do_splice_direct+0x90/0x90
> >>   do_splice_direct+0x64/0x90
> >>   ? __ia32_sys_tee+0x30/0x30
> >>   do_sendfile+0x214/0x300
> >>   __se_sys_sendfile64+0x8e/0xb0
> >>   __x64_sys_sendfile64+0x25/0x30
> >>   x64_sys_call+0xb82/0x2840
> >>   do_syscall_64+0x75/0x110
> >>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>
> >> This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
> >> size (8192), which causes the while loop in splice_to_socket() to release
> >> an uninitialized pipe buf.
> >>
> >> The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
> >> will copy all bytes upon success but it actually might only copy part of
> >> it.
> > The intent was to ensure we allocate a buffer large enough to fit the
> > data. I guess the cork + send here is not allocating enough bytes?
> I am not familiar enough with neither this part of code nor tcp with bpf 
> in general and just
> hit this bug when trying to run the bpf kselftests. Then I decided to 
> debug it.
> 
> In my perspective the buffer(8192) is large enough to hold the data(8192),
> but tcp_bpf_sendmsg returns 12289 which is a little surprising for me.
> 
> Could you further elaborate why 8192 bytes are not enough? Thanks!
> 

There is some bug in the buffer allocation sizing that is happening
because of cork'd data. The cork logic is used to hold extra bytes
in buffer until N bytes have been received.

I'm not really opposed to the fix here, but would be good to understand
how it got here. I have some time tommorrow I can look a bit more.

