Return-Path: <bpf+bounces-78740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F9D1A82B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 679E53040297
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F00350298;
	Tue, 13 Jan 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JhDK7wHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEF34EEF1
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323506; cv=none; b=FLvchXeeQeQa/B6Ye6YeCOO1UPczwnmy/b7ptnTD3LDi81sWobHwzrutOZXGNv+ueWpn0SAvP+xM+B+CEArEJ4zuPod0XsHBQDYdq8XUMUXUew4gwLY4LXeNh5fxeTz30NEmgn/rnYxie7LomcFfCmpSenNWEoiOBRitresfo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323506; c=relaxed/simple;
	bh=tSOcPb7ZAFlwQU6op9fudwzWNn1hmHkkASUV4coELWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VamSPR0EpDaZsQlJPl7YXh9K8Nf3fKroQcvFanG7Z26AxSRsb3KPkldeq/QUS0U7jjkbV7kVU6wmiFIIfczT/vNXtQjt26/dBz+YV7RfPo6RKQz+negmElDMtEOmfTyY4/FBnWB69/7gQphl25FlX61R4bp9RPZ5oOsqKiIgXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JhDK7wHk; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121b14d0089so8651252c88.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323486; x=1768928286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ON88RRtAB2t+A02dvq9Ch82cNipWI4+bDnMpxNyjngk=;
        b=JhDK7wHkTwMKLDV2L6IAKLEx8KACxj0l1psCIX7tCfCs2cY3ktIOQqvOb2Yt3n4Rm2
         7AqZvJajl6FF4HsVvfdD8TMReqz+8/1DTU2/+PYuC7boUP/Bd7dl9ih6t3cYnG8WFXtX
         f5vt6uhp+j0bpX/vLGuOEqfNx+GTHX7Jw6sAfM9Y0HLasy3IFor3by1zifwwYAQSB5Dm
         5/5azA7ORvFqgrA7Rv5FAfYHAhfDrTHqHQ7X14gmSXn2Fot5JQJPVGOX5/7hJN+YeMBF
         Yw5+BUKlphEtaflT88R16jT20O1qiINm/WS2iMlF5DKnaTaCY4wpKDFnvHUBaC2bkfXm
         Zzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323486; x=1768928286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON88RRtAB2t+A02dvq9Ch82cNipWI4+bDnMpxNyjngk=;
        b=WLoyickUm/mzxb2dIV81m+iU57XpjAEp+xV2ewb4p+etvRXVMjATHwsycxZimUDaBp
         rUo/8NfU8s5YmBWMDUFy+En04clbmAJxsAVK0NCceKPquyDtUXyeqUvnxpVQDQgwFJ3J
         xZJP0xAle8lBzwPksqitLJNk/8fgeBhMmhTTyvMYed4xFZZvpZP2r8JRPSSM1mEJrWte
         ep6Za74DNbqWSUcnzxv6qOmMALXWtBPuHxG/KKFK4YxDJNSck7xRQsCpr8E+6EW30vTk
         /aRY2KsgzHLcjJf5Gn3e/s5K0Sh6i/GYZAGWQ5sbA2lQIA6Pe57DDq672jXgW4QzI9mr
         xhQw==
X-Forwarded-Encrypted: i=1; AJvYcCWG0fOPjY6LtOnYwZCfWwN2jJVrPMDwaVd1JoSld9m9IIh5Auiyng93e1q1iAghgDcX7dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdI718/mWo0m9qsp3IgzkyPFhr2CqJ+TUA/0jYYjFc4RD4QYMJ
	Du6wfve0/rU5o4Hj253o3n/82gJuGxd9nZzCSKkWK8E/BaiQpEUUX8X4gxBfZNkaP+Y=
X-Gm-Gg: AY/fxX4g9nuayRvs7zQ/2V2gm85gKHwnGW+bLWEcYuQ0WFiFObbtSuvU8Mt8TqzLHMj
	wriQwdR4b2fmEJvOSU9PgInvOhcLdWzjaqWVKOwq9jjxt/yIrSFFXsJyEYCCHSW1AfF2Hwmo/KS
	fv2UDvMbeRjRIlQJLiJLIDuPKzMj9eebDp1P9rWeTgFO7wg9Av/1RTCNyQmDEOVw/3aizybp7YO
	CaQqdCQsfTZ59YiD8x66rmzZirKuekuaL4EuQ16p7hQR+SVYfvek/oayNr7VnxZi9C498T+++rn
	hDieemh4X2qB6KDWDemsz/CZ4nec9WD0AGI93pd/V5fGPasfkw+4m+B16WmyYDwMREm1VaCAPD6
	aKPynklIozKvaNBQ1Si/tHi6iG533nW4nOY3YqsX0oBht/9GfxgnisiQyJEkKntFCzsxsE9JU6c
	YppveAJ4CszLk8M2LN3Gw1cdwokZfnPM5aiWqhSkNsX1yy55SYxNyfZ5sxgO7jGmbiAy9haM79w
	VOdXo1V6g==
X-Google-Smtp-Source: AGHT+IGVQRe1fdI9Qq2JBPWbzVxXkMCTfRiu053lQwRYE6yRyJOQ4RpPEZHGOsc/7AMUQsuHSS9lmg==
X-Received: by 2002:a05:701b:250b:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1232d9da967mr2625938c88.17.1768323486006;
        Tue, 13 Jan 2026 08:58:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243496asm27149784c88.1.2026.01.13.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:58:05 -0800 (PST)
Message-ID: <1b35b5d4-f1f5-48f1-84ae-fd975893ef19@davidwei.uk>
Date: Tue, 13 Jan 2026 08:58:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 14/16] selftests/net: Add env for container
 based tests
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-15-daniel@iogearbox.net>
 <20260112195834.733c0ffe@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260112195834.733c0ffe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 19:58, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 22:26:30 +0100 Daniel Borkmann wrote:
>> +            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}").stdout
> 
> tools/testing/selftests/drivers/net/lib/py/env.py:380:12: W0106: Expression "cmd(f'tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}').stdout" is assigned to nothing (expression-not-assigned)

Will remove and remember to run Pylint myself in the future.

