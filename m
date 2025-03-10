Return-Path: <bpf+bounces-53735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B7A59906
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8708218926C5
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0C22F17A;
	Mon, 10 Mar 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPC9LmCl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604622D78F
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618638; cv=none; b=lrj76MG0XfqYl9Jp7lb0Gu9uhjfS5YULVwnGG/Fftf9aEeGQDCROOcsjDGplUHnt2naDCO/q6sjlB4NjkP1JXTadya5T7Zo7syGeoDyK/GQ76tuw3/D3VRfjC5TmphiMp4d3b1Fl0m6oPSyzWFbn6WOEioOXyrGk8gI9hWUxY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618638; c=relaxed/simple;
	bh=DDFSBY+EihpyeoK5HiOTV5WFyxGVogpelwrvov4Lxpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpeOyacIZMIY/Tx4ycljXXhFFa9Q+2pMaBfOvYy5XzfiT+EwJ60j8T2G/DIzYV8eNBYQ3bIKJwwoVv8iQFltz0AtOWImcoCoflhFrqWrXPNvYsyXSyQ8Wo0E859v7kJRQUm/MLigm9P0wX3b36OTH6eCJPSYCbxw0FWFXYMc6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPC9LmCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741618635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jWNWb95iV+mWVJ+4wh8JfosTFPQltaYwNbslh/GR93Q=;
	b=GPC9LmClCAJ+SsZyXWsSX6/4fABWSekeZujXVedQIjq9/aER2bv4ouz7Ax8MkFxRHxaUsr
	LuQNZna/ZLblHRTmNnhOM0FHBZ3mJwxVJjPMgcRrsmXDxVSMNHjUTBYk4+TsjZLTHEoEmP
	u2ZP4b9EKKqYte19DLvB75EIHBtPYTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WAPM9nNSNOGCjuNvtsfOhw-1; Mon, 10 Mar 2025 10:57:14 -0400
X-MC-Unique: WAPM9nNSNOGCjuNvtsfOhw-1
X-Mimecast-MFC-AGG-ID: WAPM9nNSNOGCjuNvtsfOhw_1741618633
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394040fea1so20869315e9.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618633; x=1742223433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWNWb95iV+mWVJ+4wh8JfosTFPQltaYwNbslh/GR93Q=;
        b=XdhktKRV8cuSHI424oOOSzsJYakgwA85L2Eww3gfxw8GafvktLPP3SIgebzxPJerlV
         lDRNaJ92PbWJS3RfYTWr2VHwBkhiESKNpkfuMxt8J8gTxgYm3y1q7WfzVPEsMcQe+kJ9
         waQhzRndXF+CDMEX+SdGy1vkcsn8uFvniqidwlIAB1u4aFUxwSKwOmhGW/CEsG6d3uiN
         FkVS4Ova0XXeigcLabrSejzyJOg/lciPl0/NmKHnaAbSQLX1tTUNgJZ2Bbs5QByBFx2Q
         FKdo7Be2hdpTXH+AFyfJiVsfW8KqE12oomv1L82Ij2t8SSdqrQq5DpJMwUwY6fYMWu98
         +qbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp0jxJ2iIVcVpaog4fTRALffbIgKNy3u5foFeoBRSymgo8SjlPoslJdgVexT1PGlNqGfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPB6x57kIhk8372DVVTw4UL+xQh/qI/JSdt/h1JdhEG5Yo5Z4I
	ff9Yha7cgiJtcKnPz3MT2a3vn56J1BHAglyzskzuoN7cYG8u/VgCoQ+5jPpueHvG+w1Z5T7guHt
	cBlqZOeHaFzS+3eo/OxoFoKXwv+CwcXY6WnHKhsVPGi3EPrOVIw==
X-Gm-Gg: ASbGncud7nYDMLL5BsyrV2vLMKo3teiKQ+pI7WOokX3mgdZeYplAKU5/iDdt5LyczcZ
	owLTufyP45K6oLY6cmNAylzQdfwRAz/W+cU2KCfXNtsgWK4wEdM919tObHINruTG6OmyLJq+r15
	SLFIgEx4m77YYim7AZWVT2aJiZ4rHJHAahqz/0Uv5z9zZuBpICjrz52p4snX/4qBt2c1GDHo+v+
	Xe3u0EKIh+55kDW73M9mU5CdXQ0uqTBXoh2d5AF8UX/3vLy1YoRCrzpRGDevGh+31VX3tSVcxBo
	LOB5i6agviPZXdnT5uf29Izmov3C3W55S5cvKI0gUr7CJqN01MeRGc2QREB8wqdI
X-Received: by 2002:a05:600c:a297:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43cf3e1aba4mr29889545e9.12.1741618633102;
        Mon, 10 Mar 2025 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzpkMUlLsha9DGTnq1BtbAasQwodmyA9Pe+3Lsyz/kRmAtG7EMWFM+0qhRV1W1xI6hJpv6iw==
X-Received: by 2002:a05:600c:a297:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43cf3e1aba4mr29889105e9.12.1741618632510;
        Mon, 10 Mar 2025 07:57:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d017a9fa2sm901115e9.1.2025.03.10.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:57:12 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:57:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <d7xxfu4af2wafmlj73ffhvmncg6zfuhc5cacezijddshbgmicx@37acg47rvclu>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
 <96121a41-20b4-4659-84d1-281b2b1ad710@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96121a41-20b4-4659-84d1-281b2b1ad710@rbox.co>

On Fri, Mar 07, 2025 at 05:00:08PM +0100, Michal Luczaj wrote:
>On 3/7/25 15:33, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:27:50AM +0100, Michal Luczaj wrote:
>>> Signal delivered during connect() may result in a disconnect of an already
>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>> been placed in a sockmap before the connection was closed. We end up with a
>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>> contract. As manifested by WARN_ON_ONCE.
>>>
>>> Ensure the socket does not stay in sockmap.
>>>
>>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>>> sock_recvmsg+0x1b2/0x220
>>> __sys_recvfrom+0x190/0x270
>>> __x64_sys_recvfrom+0xdc/0x1b0
>>> do_syscall_64+0x93/0x1b0
>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c  | 10 +++++++++-
>>> net/vmw_vsock/vsock_bpf.c |  1 +
>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> I can't see this patch on the virtualization ML, are you using
>> get_maintainer.pl?
>
>My bad, sorry. In fact, what's the acceptable strategy for bouncing addresses?

I usually use --nogit so I put in CC pretty much just what's in 
MAINTAINERS (there I hope there are no bouncing addresses).

Thanks,
Stefano

>
>> BTW the patch LGTM, thanks for the fix!
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks!
>
>One question for BPF maintainers: sock_map_unhash() does _not_ call
>`sk_psock_stop(psock)` nor `cancel_delayed_work_sync(&psock->work)`. Is
>this intended?
>


