Return-Path: <bpf+bounces-33088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C1917145
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21367B21510
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03317C228;
	Tue, 25 Jun 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIP7+67l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BB17C7D4
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345070; cv=none; b=ByCbHyYSKp6Zs2XyhvYo2FHupea8TTQdiJZhjmHjM0XHXQFBtd+x13Jwcb0UZBN1VsV0q8AdUQ+J7V13nNjjGoxm1D48VoEeY1DpJ5ZVTgPpJu7L6LVPCuVNKhS1TJEzq0fh1ZyLtOriU75tztbfsMG2s8qJEhoRquEIQB9PCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345070; c=relaxed/simple;
	bh=x8/IU9en4kAKcbxDAQ1wW0b1kwJxByOCW2IRgOib+dY=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O7I+tNcD/lsZ9ogDIpNnGNyqh5myCZPjERPaMcBZl0xovcCZQbdCZ9zi/KaxZlAd9Xbi/76a7RDTIkQYw9cS6ORhtamSOs2D6StVbMTRBNfqs7M1ZKPntkZovyUNRA1hZeoglya+/74F3ZzMQbE0V2vVkzvNT8yEs9TL0I2Pjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIP7+67l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4c7b022f8so50850425ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719345069; x=1719949869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8/IU9en4kAKcbxDAQ1wW0b1kwJxByOCW2IRgOib+dY=;
        b=EIP7+67lHkkc1LVI47oo8NKebOFj707/HqNvfAYWenIUTM2mnyF74HiFQMenJxXsW9
         ckI2mJwWH+HaPhw9JoIuqVytnl8+4Y/5stOiVvxGWp5Q5vBGdvSXtNWq8uf95B1vSvML
         G6i0Lkn+t4EExGU4zILw8DlWT3V0F+n2WjCqRw9Z4PBctofQTxA4Hr+vuBUJoeIs9Kas
         HLyzXD7d0of8W+l2huKN2IK4ncdxLb2WzhR0AuzTul3yKNwZB0j2mSt9Q1GEtlqIMs8b
         0/erwDYrBXOK2N6Xf8Qt6cy4DswgDWvqWCKMtgPTpXvwBQhmHCyqAedsn+0GRpRq3pn8
         vOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345069; x=1719949869;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8/IU9en4kAKcbxDAQ1wW0b1kwJxByOCW2IRgOib+dY=;
        b=QA/scw6BRWtgTDLx4t84N6c6vtHdRnv/+1R2gMw2xVW/9OSoWpesS9PI0/UXJEGu9u
         t46h8nUUIDRmxuZPO0VGuqSxfuysp2IlfAW7cE6FPzRcoO+ClhG0RmlZZ79SQ7qDcwOV
         gw8nL6oJ+EEKCJibjjc9XE6ccG56Mwq29GRGCm01qC4OmAo4szxsIUhlI/0m6xPGT914
         aw50yUJLQxlM5v6PWb7anJ3+0GxQJQ27bfe6WNOuG4HJnIWOfgdN5iuv+c6aBNWk6KBV
         coxsmHaFT5RBowKF42kkbLvYVPPsoZkKpu7hw+mum6WMSVBWGGDeo9zDJnX8/rSe2kou
         SysA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8dEuhP62Osvo29YNENJXbvHOiJzLCvcN35tlj5bHTPwAGEAhmsrTGc8ktTmuxV3evbdVcEJ753Dd5RRv3An0Qa6Y
X-Gm-Message-State: AOJu0YzQyVVuY0k6EwrWSUmVeHkopbj2Yo3EznfJK7NFC6qHJ0kT8A5N
	aUaeqcnUMFMaAzOPmnWloe8tgUv2tYgXpsMBFTxDgHTTPFwSF+VCIiOJCw==
X-Google-Smtp-Source: AGHT+IH7p1cDQkk1dcuWyLCbfYgbS30xu7C3Y9HCKrsF3hKPoJNFsb9vvwxyYyXDpefVU8dC5MWmQA==
X-Received: by 2002:a17:903:244a:b0:1f9:a602:5e39 with SMTP id d9443c01a7336-1fa238e4665mr110292035ad.11.1719345068615;
        Tue, 25 Jun 2024 12:51:08 -0700 (PDT)
Received: from localhost ([98.97.39.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbbddffsm84880795ad.285.2024.06.25.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:51:08 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:51:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zhengguoyong <zhenggy@chinatelecom.cn>, 
 =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEpvaG4gRmFzdGFiZW5k?= <john.fastabend@gmail.com>, 
 jakub@cloudflare.com, 
 bpf@vger.kernel.org
Message-ID: <667b1fab10204_5424208f@john.notmuch>
In-Reply-To: <4cf6d911-9dc4-4588-be1f-cfee675e174e@chinatelecom.cn>
References: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
 <66706d48967f3_1c38c208e5@john.notmuch>
 <4cf6d911-9dc4-4588-be1f-cfee675e174e@chinatelecom.cn>
Subject: Re: [issue]: sockmap restrain send if receiver block
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

zhengguoyong wrote:
> thanks for reply.
> =

> i mean the sk_msg with TCP protocol. in this case, sender use sk_stream=
_memory_free()
> to check if memory is free. and in __sk_stream_memory_free(), if
> sk->sk_wmem_queued is bigger then sk->sk_sndbuf or sk
> notsent_bytes(tp->write_seq - tp->snd_nxt) is too bigger then
> __sk_stream_memory_free() will return false and do sk_stream_wait_memor=
y().
> =

> but in sk_msg mode, tcp_bpf_sendmsg() will not create skb structure and=
 not use seq to
> recording sending info=EF=BC=8Cso sk->sk_wmem_queued is not changed in =
tcp_bpf_sendmsg() path,
> and __sk_stream_memory_free() will always return true.
> =

> in bpf_tcp_ingress() will copy the sender msg and charge it, and in
> tcp_bpf_recvmsg(), it will uncharge the msg after sk_msg_recvmsg()
> receive it from psock ingress_msg queue, and if receiver is not to read=
 again
> due to application bug, and sender continuous send, then the receiver
> psock ingress_msg queue will continuous increase and cannot be uncharge=
d
> until tcp socket memory is not enough in the fllowing path.
> =

> =C2=A0=C2=A0=C2=A0 tcp_bpf_sendmsg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_bpf_send_verdict
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_=
bpf_sendmsg_redir
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bpf_tcp_ingress
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_wmem_schedule

Shouldn't the sk_wmem_schedule push back through __sk_mem_schedule() and
cause us to return a ENOMEM here? The ENOMEM then will free the msg and
return ENOMEM all the way back through tcp_bpf_sendmsg and to the user
eventually. =


That sk_wmem_schedule() for ingress should be sk_rmem_schedule()?

I think the fix is to ensure that if we try to bpf_tcp_ingress onto a
receive socket that it pushes back if its memory limits are reached.

> =

> so if a sk_msg type sockmap receiver is block, then it may consume all =
the
> tcp socket memory and influence other tcp stream,
> can we limit per sockmap tcp stream link sk->sk_sndbuf ?
> =

> thanks.=

