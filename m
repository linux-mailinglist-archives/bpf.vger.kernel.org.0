Return-Path: <bpf+bounces-39808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE2977BE3
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97321B27EA1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660691D79A7;
	Fri, 13 Sep 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbapdw/V"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705771D6DC1
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218512; cv=none; b=DsLi9K9s0nmOIVRMwt9lU0CNPnqC68mSqymaHKIQVdWozmSsikj+qxx6diNa4NMgwnXDH6n8d3c78UfdoNPyVbaCP8WW4BPV/2yHnlLDnLAnvzb8zYpFpr+JT8AoYq3OPHMgBaWmSfB1eH4jUB4B3RHoIzXrqwCzw29VJnouIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218512; c=relaxed/simple;
	bh=R+wc8evpmc4HT9aDiFp/1Wi2uhv80z4+DZFRw6CYiEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUokepIUg28amHAcArvKpmZI71HcX0Wdy8vQs45hRbAri80g9Zw1uZEZsmtQwGiDJHsRRw7H6Ylhhh/VBpZddxe79mZcbtIJly+wZIcKEQ7RbRSKoPTdC9r4tjaz3JUkFuMj5ycU2cnJ8ROtVhquxvEutKjRzmDtThIey9EHIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dbapdw/V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726218509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/qu/Mi6P96nxbNpRLmW/hvyLUcdhuJ0IeIbk9BzPBs=;
	b=Dbapdw/VIX4JgJNBkO8qbYx+A3AB4ycwKBazoiMPid02Gkq6pK/0kJenJsSjGZ2UFDGX+6
	a5z4h4mo9KyOA9hRMPTHj46eTI+jful7YF6cVvkqS2xTu4JeZS2YWGiEY24C105Kc4xcKK
	AUNzTAH202H2qJit4zp3j0yVo2d6RIA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-CffJHuoINEywwSil6SLO0Q-1; Fri, 13 Sep 2024 05:08:28 -0400
X-MC-Unique: CffJHuoINEywwSil6SLO0Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c9b0daf3so304076f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218507; x=1726823307;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/qu/Mi6P96nxbNpRLmW/hvyLUcdhuJ0IeIbk9BzPBs=;
        b=Q+x6YA4GgDZyMZKAZ26bZdKgeS4l+gUvUMbEY98QqZ2jbaOfx0MIPKqqf4D7+1F6V6
         iYvS2PT9PlMFOkiMMuJm3+K4m7QFwg3LRSvoe+cYTVS1MrNYcGmnSrTBBdCVyXLeTs/I
         2VUlAZv4nU83Zvf12Bc/zW6peLG6yHdxOpX6NoHpHwKxAsD9wL2ffhxgpVCrpe7oDh07
         hDnwAKKVz06q+xj/Xx4HM5OSNA6n1nRYUMmcu78K8LQfQo4lsbEXll3voOoHlVB5RRa2
         NLQanAYsFcOJSRbm1D5whOKZf8/LhgWD+AH4WPwEN5oN/UlzBb9lrXsh61sqKIG+0wvc
         Oh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2zhmB29jB/w76dhGlQMVZL5zS6xXafdcvtrGeP+BMW9pfHP7agdv8swimRqfqtHxZm8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBffSs8BCPGnBN3JDq39iz/bliDmDjGh79sJHSfvy//B7c1ma
	7WLsRSSTaEOlsmRBSOjEWDgF6yVVNdTtkZNFEos6uDMtDHF0T69S4UnliQu/GekXmOR4LH0A/j8
	CC8bYtZRsGufqXMjomwnvNnYLLvHz0GS6Py0XO6cfs0xhATCqgQ==
X-Received: by 2002:adf:b197:0:b0:377:2df4:55f6 with SMTP id ffacd0b85a97d-378d61e2710mr999151f8f.17.1726218506866;
        Fri, 13 Sep 2024 02:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYpp0G2XEPwQQL2G5P5Kh9FZsdJniPGQziF4Dl1Aah6cU2OdRkxvRBB8oV8kLCyUEwA2lFYg==
X-Received: by 2002:adf:b197:0:b0:377:2df4:55f6 with SMTP id ffacd0b85a97d-378d61e2710mr999107f8f.17.1726218505680;
        Fri, 13 Sep 2024 02:08:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789567625esm16331716f8f.64.2024.09.13.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:08:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DE0EF152C68B; Fri, 13 Sep 2024 11:08:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vadim.fedorenko@linux.dev, andrii@kernel.org, "open list:BPF [NETKIT]
 (BPF-programmable network device)" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
References: <20240912155620.1334587-1-leitao@debian.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 13 Sep 2024 11:08:22 +0200
Message-ID: <87ikuzc455.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Breno Leitao <leitao@debian.org> writes:

> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
>
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
>
> Set the bpf_net_context before invoking netkit_xmit() program within the
> netkit driver.
>
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on=
 PREEMPT_RT.")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


