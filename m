Return-Path: <bpf+bounces-46700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3209EE49B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 11:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3044B165684
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42FB211488;
	Thu, 12 Dec 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9JaYYMk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DE1F2381
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001146; cv=none; b=Z5NFGzoAYJPhQBdGdPPmHKHanBnZI3nrdHoc6Hs53FeP98EJS7SNS2zK5QwYfJe5pQz8q25c5YD3vZCJ5iEkbqj6+L2zLCFIsp+JzC78/v5wmpBnFI8YIjVQCp1EZj1vNzjGHDw6tTu/vin75FcFfR9w6vW7ASesyq7rmPHMoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001146; c=relaxed/simple;
	bh=0rpgITi/RceK75eiLzwMBoatVGcV6ayulEuHj23hD2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bME0A1Pi4fT6Ofmsv5uMSqp2inLP99IYe1eJnR9fGtT3r5HfXX93VJhlwzokwRGXVC/ttEJzpsayqAp9Z3Loz8HItttGNsJsYEDQIcMJhh+RK3AsfDuYCUWI6R5mzJE59v2PjX+RZkHT+Tu3dh0AMjOYQzQhJCqi+1OFgz79nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9JaYYMk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734001143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6LMp3yhvNH7iDTlgkjr0Y+pCZOZC730ryRam7ekrww=;
	b=e9JaYYMkpzQQHDyVIQPU9+HB+Q+UMsHMCcnI22uyMst8ArNj+0SzhI06qVs+mPbpFucJVC
	8QltO9RFHpRnjSngZTCUKMcpCTiNMb3pcfLpwu4xO8Stl139kJv+AmSu3jJXTCPy6J+7j9
	0+N8EQTQldxB98dcvl5N4h+AgnJ5zGs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-SEz7m4EEMJaryonasxTfLg-1; Thu, 12 Dec 2024 05:59:02 -0500
X-MC-Unique: SEz7m4EEMJaryonasxTfLg-1
X-Mimecast-MFC-AGG-ID: SEz7m4EEMJaryonasxTfLg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436219070b4so2919285e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 02:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001141; x=1734605941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6LMp3yhvNH7iDTlgkjr0Y+pCZOZC730ryRam7ekrww=;
        b=N3iWYH62/8wxVQqxt2QPkVivbaWk50ZOONUWPV2isWvj8SeEhgdBZuib2JaAJVN+nA
         xECBaOBLHITq6oK/1B2hTfxwSSyWByZd+Cp/JsM4Mw56aFMMlbL4z4X19iYU+biu4/ah
         mkp/lZ27vRbx/91P5CRSBCPk/pwwHXDKAAsRoCHb91cUMWmjZCat24iBtGqCfmcM6dH4
         Vh95zzJFhHEWD0lKcBRw98sle6gbdztyIyZzMkHDgY4uno9cEr55IQY9lGRkiT9hSYWK
         2PMy2yPXUTtYOyfCLQ8dbsePupOZudgbIxq7GSSrfu70gEw66mOpDyRQqXUIPRbBz8sf
         QpWQ==
X-Gm-Message-State: AOJu0YxNYNujYOXin7x0h4AOS5+WpdaP+rlkLL2J6aT1egcOG73NWd2B
	rW7x/g/3v3tRjLF4TvTYOSth/Nz+JxKulkUE6N0xN/Kmfgvc6HDlHlk0YBvBBXjaCmRSe1vFybw
	OS1hd4lA56keNv7glOJoSabLBEt96smQITKZjwmmiQ0oSI1l+0A==
X-Gm-Gg: ASbGnctQShtImtd7nOWu06zCT0GQfWaIWU+Ioanw2EhDdXUPKOkXUZNLdWD8R80+sXo
	PwvVBPCpHKjZTn6kRCD6qyBJgTn7/9YRQxGzbBPgYUaDMeVRObZcul3B0kuIXuHo2gS0AXFjpbD
	WXHTLkIa2Vd9CjuTjccuNrTugN35RTK5shOEVwzcuSNrNecbsydxexAQaJIVqr3he8WQzguhofL
	oWziMkbwx1SvTb8/x/Qb8Vo3v3pFcLMsrjNhw4TsUfzvkExhIiRt5ImqWeadW+JKXCgh+8g8+Hw
	I5pOF7o=
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-4361c387b63mr51504555e9.18.1734001141116;
        Thu, 12 Dec 2024 02:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoVxQVOMsuvx1qd2xoaOEr5HS5OrNbDZIhPIUPF2afE1X/8AvjHvAcnq4miXjTWtR7LQiBWA==
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-4361c387b63mr51504415e9.18.1734001140831;
        Thu, 12 Dec 2024 02:59:00 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362555334bsm13179245e9.1.2024.12.12.02.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:59:00 -0800 (PST)
Message-ID: <9a19f3b4-d1f9-4686-968c-55bf80e0f3c5@redhat.com>
Date: Thu, 12 Dec 2024 11:58:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features
 helper
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, mkubecek@suse.cz,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org
References: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 15:12, Daniel Borkmann wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>

The series looks good, I'm applying it right now, but please include a
(even small) cover letter in the next multi-patch submission, thanks!

Paolo


