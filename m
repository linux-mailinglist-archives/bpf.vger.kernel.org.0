Return-Path: <bpf+bounces-41979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0E99E11A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8B31F21C52
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EB1C82E3;
	Tue, 15 Oct 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4Rcykp1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E93185936
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981095; cv=none; b=PzhUZkklPGQ8wlTrnqcbU/ixArdlJoxYb8thcQFSCVGVHCu7N20S/tOp9SL2W93UIjsO9KIWSs303Kz5zIaTe7PowRJauZLHomIQepPJEB8Ip98gBuDWlTbUJKfvs97TgdrR+lveXA+jPp32glC088Segck+NZZapSMF49Bmunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981095; c=relaxed/simple;
	bh=hgqAAx4EXuLzjTAMpE/1zx1P9x/Ou/rzS1Y2g4R0qeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKJV5FIAqV+Tles3KY+lcysl/LLWzuavzyjXSFzFZRqRcq/mnWV8vy48V4J+LofFzOnt0HCIO5ZA2v3gRZUbbCtpnfY10kyiPVDMu7UPckvZ3ZZ3kEBbw/VT5z1CSBXjEk7Ia1RHqfxJot0aK/TJT6KPsSvtxW1GBb1dHyBRYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4Rcykp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728981092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vU1tV99MICfeCvP47NVxkR5AS+mMop7OeRAQ6h/1+Po=;
	b=M4Rcykp1jHKDhlK0AYJCD3wHi8ulb1keXreewipWLbfTgwTeLMJaGFLt5lcreylSjx76ew
	vPTelK6SaqFOSkK1YJx+mahkJngXgMIzvgAkxndnPm+EIFlFOTVwhwQ80M2xZNcH49lqOg
	2SsFTwla3dsilSxtNaMjySI2UBUWr4g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-YhGQhuhJM_OJygknT0b-LA-1; Tue, 15 Oct 2024 04:31:31 -0400
X-MC-Unique: YhGQhuhJM_OJygknT0b-LA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b11ae88effso740864185a.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 01:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981091; x=1729585891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU1tV99MICfeCvP47NVxkR5AS+mMop7OeRAQ6h/1+Po=;
        b=T03pgE6Uy+8VX64G8+1uAMbnqaErAqQX9EK/dxuYJHlOjiZbm0Z/9OFkmtcsdUlkcB
         immm1115Igah6cZWOnLqUlTDU0gnCl244tgQwXIfQp8h5dyWmc6XeG0bCUXGLlADkvwS
         QxKELEY1AMPP+Xll7oNASHGuOoaFsD+CXYDvTyPSiREGYKie3gTsorPcasjgmtSg8lRO
         wYeh2GHkYTGxJBJSeYhFUf/ro/XJ5kg+nwoSrWQnVUsi5yE2edPsaw8PitlGXASk8YdW
         0xgIRnOFkzvy+KdbI0YgJElMwXFA6Z2UOXk3TUX09K7F9O8T77pavp1hWP4rF+j3R9Fy
         KzzA==
X-Forwarded-Encrypted: i=1; AJvYcCVY25ngBIHMxaJlFeF+Eovy4uLX4eZ/U6K5pze/iv5bldW04Ic2Ue8toRTz0NrZRnu3D6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxATu1nOgfqbL3Xe2K5GnSCszIk33PRT5dUXaHlNmOdIoG4oBY
	MOgeaHhz6q2weaFur6n984l04KIPuyfC/mqHVuGX2jZ3A8HUYLonUTchUVYh3+LievNKh7Z77x5
	6AFD7KyDau/TlYPi0xAXrDRG/7Ex5X0hNQyojKfDu6rAfuFWPkw==
X-Received: by 2002:a05:620a:269b:b0:79d:759d:4016 with SMTP id af79cd13be357-7b11a35f88amr1853080185a.11.1728981090733;
        Tue, 15 Oct 2024 01:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP+1imT6eQmZuNh3f2P9AoQ77FpHYqXCEyc78GwkbX2P9i4NBcMxSLOaZ+ozuJjTN34arlEw==
X-Received: by 2002:a05:620a:269b:b0:79d:759d:4016 with SMTP id af79cd13be357-7b11a35f88amr1853076785a.11.1728981090132;
        Tue, 15 Oct 2024 01:31:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13639560csm41873585a.79.2024.10.15.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:31:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:31:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
Message-ID: <ledcus5cpzgm5oymzc7ezdzl7ddequt7tnqricgj4d6rrwlsoa@2buj3owbqard>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>

On Sun, Oct 13, 2024 at 06:26:38PM +0200, Michal Luczaj wrote:
>Series consists of few fixes for issues uncovered while working on a BPF
>sockmap/sockhash redirection selftest.
>
>The last patch is more of a RFC clean up attempt. Patch claims that there's
>no functional change, but effectively it removes (never touched?) reference
>to sock_map_unhash().
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v2:
>- Patch 2/4: Send a credit update [Stefano]
>- Collect Reviewed-by
>- Link to v1: https://lore.kernel.org/r/20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co

For the virtio-vsock point of view, the series LGTM and I reviewed patch 
2 and 3. I don't know BPF enough for the rest but I can't see anything 
wrong.

Thanks,
Stefano

>
>---
>Michal Luczaj (4):
>      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
>      vsock: Update rx_bytes on read_skb()
>      vsock: Update msg_count on read_skb()
>      bpf, vsock: Drop static vsock_bpf_prot initialization
>
> include/net/sock.h                      |  5 +++++
> net/core/sock_map.c                     |  8 ++++++++
> net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
> net/vmw_vsock/vsock_bpf.c               |  8 --------
> 4 files changed, 25 insertions(+), 10 deletions(-)
>---
>base-commit: afeb2b51a761c9c52be5639eb40460462083f222
>change-id: 20241009-vsock-fixes-for-redir-86707e1e8c04
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


