Return-Path: <bpf+bounces-65505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D007B24800
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC45F563A29
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509782F6586;
	Wed, 13 Aug 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTWhVgEB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A1C1A9F9E
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083185; cv=none; b=Wbsx+Tvv02N4qz7BX+oWar9OkSuIaJNVCu0ev0/wGXc+xwEGC92+Fu/lRQPa5tpF3QN7P9+LexorwDnF4LHdFM/6SmCybLGAZpTkvy/RJU94/Sn6XyLK8IYY0QZfDyyz3apKr6t5jHn0IlVhKq9x5V1RFeOeE4FTMZwwCaxVh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083185; c=relaxed/simple;
	bh=cACGEQpaz7YsuDS/UFhXmMOeRuWHuV4oQT0r4/yYB/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST+8VwF3LnMRRj5kQN8T5DfWA8fpM7TJITKi2jXZCdHH2LC2SRP/Fw1qNszjmy6ukopnOmcJke1tFQtGbOVLwTnpAwLlqpBNmJuGjRxd3hFp+UpCcYtV5X/MkXpjQmDpIarFx4Ecv7EJBI0C8PHJXI99V2EkSwTzBxsbXaJwvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTWhVgEB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755083183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biyu7frguHt914mTfrDuMKsFjm+yH8cJtMl8byXbQu4=;
	b=fTWhVgEBrtVoqWsjepMNZecR3FJMkghVd8lxStEsPpWGfZrOdaYEYxJ0D9dBLuzf2mgeZh
	wmVDIHX51vZm6IwSxuEjKbV5P+MqWipOwR/8Q0gRCzbTW00uYWFjPHMvrLELTyQkVJxKm9
	RHp7FWnD2cinW9wgDVtfouA0bqcfXz4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-QtzT2rU_NV60yRUlvUFqiQ-1; Wed, 13 Aug 2025 07:06:22 -0400
X-MC-Unique: QtzT2rU_NV60yRUlvUFqiQ-1
X-Mimecast-MFC-AGG-ID: QtzT2rU_NV60yRUlvUFqiQ_1755083178
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169cso6630429a12.0
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083177; x=1755687977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biyu7frguHt914mTfrDuMKsFjm+yH8cJtMl8byXbQu4=;
        b=R5lE8QQL2bxCfYYIvCI7eZbE01v9nry2ODp2AuX/pg2ZB82Xd4YhZ1qWsCSwpVQIbl
         XGAaLDLS4yS4ItBtIRa8YDuWP2+oJyQ8UkQmb+FVxzAPTtju9N2MnuIMVGPOW2zArxWR
         CG4vN0n6AeKo9Y0am1snXpmNrsDYJ+BG8xL1D5vO1rBLpvVGKYoTSfVV7a0ihwB+xQ6O
         yz/uJgdbfx5oTHoX0FJkUUFeOr5UUno+COOCzIglKpEWawzBCkJUX5MxROXUM8F5E06X
         9e7B8WxM17u/BU3I/xJW9OpJ6aKU5CFXhoASidX1qB8CPNxEqvRsEkGzI0KBcy10vqP9
         SQKg==
X-Forwarded-Encrypted: i=1; AJvYcCWHceaYDwAAJ6RpcnV8LxqDScYAgv5llkit/c3UKoYn8y8E7j7oXbHjA91wHePUTiGuGw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEn2ns4+T1ScUo0ar9hICW8Dm4mNnaJKF7RnQ1W/ZnKiaEH6o
	HoqGEYALFn8c+aitKQrpIgr9rrfF3F4bxEVxibtdswLBVhyd9AtKTnOpGljt8ylV6sq4IpGpYnI
	n53SMop61s/FruhIyGrWjEz+xcwqIIFTeInrKwMzvlEimJ4/8RODkoA==
X-Gm-Gg: ASbGncsa36JbN/TXIuNzh+mmD3+URAY/RpwxRTmjIk7VT9fiT61QyfLFXmICfaVvW4M
	skk+nWztSxu6qvH0eG4TDvEL5iDWVMRjyZZRc9CIpHKV6huaMA8pLzV46mwQZZyJKyVpHKZOND/
	JslquTt5BCCj97LUXyduH0D85ZAvD3o2zOnevWAAo1WG41GhfT/fDewhngSEdQtR8O+qtkhDaYD
	HztGm7fEzkgN5f9AfaZ2gFQrxgmLrChsAgoOGOIU077d3NOCY6rYcqXjOCWp8CJ8L/zkLQc+Qal
	jvcaEyeSWPjLPIrvopZXzhxSyAyXke3J2MbsfVG6lXBOKgWY9tvw1CuV6X/xnpw=
X-Received: by 2002:a05:6402:34d3:b0:618:586:34f1 with SMTP id 4fb4d7f45d1cf-6186bf66d00mr1752569a12.9.1755083177620;
        Wed, 13 Aug 2025 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG51LxYsiTqLYfdMBwLNCAjQxd6AZT09DhjoLQ9/EerHpDBdkNT+yVQ1yrUJyBGopCMMUPdaQ==
X-Received: by 2002:a05:6402:34d3:b0:618:586:34f1 with SMTP id 4fb4d7f45d1cf-6186bf66d00mr1752536a12.9.1755083177136;
        Wed, 13 Aug 2025 04:06:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm21081059a12.36.2025.08.13.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:06:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4DFFD19D183; Wed, 13 Aug 2025 13:06:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, lorenzo@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com,
 tariqt@nvidia.com, mbloch@nvidia.com, eperezma@redhat.com
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
In-Reply-To: <20250812161528.835855-1-kuba@kernel.org>
References: <20250812161528.835855-1-kuba@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Aug 2025 13:06:15 +0200
Message-ID: <87qzxfjxaw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> xdp_update_skb_shared_info() needs to update skb state which
> was maintained in xdp_buff / frame. Pass full flags into it,
> instead of breaking it out bit by bit. We will need to add
> a bit for unreadable frags (even tho XDP doesn't support
> those the driver paths may be common), at which point almost
> all call sites would become:
>
>     xdp_update_skb_shared_info(skb, num_frags,
>                                sinfo->xdp_frags_size,
>                                MY_PAGE_SIZE * num_frags,
>                                xdp_buff_is_frag_pfmemalloc(xdp),
>                                xdp_buff_is_frag_unreadable(xdp));
>
> Keep a helper for accessing the flags, in case we need to
> transform them somehow in the future (e.g. to cover up xdp_buff
> vs xdp_frame differences).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Does anyone prefer the current form of the API, or can we change
> as prosposed?

I think the change is fine, but I agree with Jesper that it's a bit
weird to call them skb_flags. Maybe just xdp_buff_get_flags()?

-Toke


