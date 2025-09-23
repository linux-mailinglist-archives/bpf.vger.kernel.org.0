Return-Path: <bpf+bounces-69453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B6B96C1C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FB34A17B5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E02E7BC1;
	Tue, 23 Sep 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="20JRUndR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAF273D6B
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643715; cv=none; b=Tp8Sbvy4Bd9CvIhSPScgLAsHNrfBD8pkm8k9b0lF006+K3fIef7SRQ8UeuMcnO97D5BeiXYYepzUD2KqR4HWFiM6MPd8LC6MEbt3UPN8CZf9KnDy8xueVvxB7ilWraXw5Dz57+5ijMY9JMiWqiVOk4WrQ4rn9cm3SlWwebkycbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643715; c=relaxed/simple;
	bh=sxbRvK9OdGpAwngpaMvgersbDCyqlAMTmz6xBMO3hc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi7TsHNTzGlPdojZM3dIiG18yMe4Yah+rj0jEaMQuuCEuG3usRQ1W+Ma013SyeBBrKk0QHUAavTojrj8oL0vGn/0nkq+N7BXEFG3ViItqQkqBbh7oHGAckg8uRYdAig7QrDNsvvtnZ2x0mwPVl/EuI0cgoe/JSWuBW6AymWHcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=20JRUndR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55562f3130so1381069a12.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643712; x=1759248512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zn6Mvuo2dzjtDxM71s+uFF4wqTdcTSTG7aNq/ZOAW/o=;
        b=20JRUndR9x5VGESJ+S3eroNxQg82IWoVuoDIANZE8gEeJ/9C8an54eIr7po7xWxETJ
         3oRh1TcPMT/paV8SbOhT3VM0RHJGMEJoLQxmhTBlKQx4/tXCyd9OYD98VLbzuIl9GDUv
         Qic5ohrX2c4Vm/ciPBvOuca6/WJSiycdIJq05+IsbBXY8Hs9KGNl+ps0OaUaQebETgQK
         i9xp5bgblfmbwmxQEzYPWAsgk61nWSJ6ORX4dnZh+/h9VjcMU4DZP6oI8hiusXJ6r5Cp
         9HlQWqgZX6sPIuZPalYWkiPNzeSl7xWlaurS404tRXVc+mB+tX+MTCJJbdKObEkk6TIs
         8ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643712; x=1759248512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn6Mvuo2dzjtDxM71s+uFF4wqTdcTSTG7aNq/ZOAW/o=;
        b=OxW9PTs6Z4u7ulHBy5tG2t3LStU4cIX6QYe9/lryFGZe2RYc/9ZGcKHyHkSwSvXiis
         tJ6UbH+6SJ6QkOEImBKO2Mgu16GKAUAhl+3EPdLk4FqeAUdxSsqDmtvohDnELmAwzvuI
         F3vynHaAuBbC2JBZ1g0L7LASlsld+wwLlV3W5K86IwZ45qlputPndE6IIS+JDPU82weQ
         j5hzGzUVS1jY/Rqb1JdRbZVGOlC+l3Rm9sZaLBjs4oEF4ZnuzbLpo6abj9+rdDn399R1
         HC3UMq/jMHDuPho9XsVVuSymxqakhXLwtUNiPq+VNqwKsU+ldBJBRj9rbQWIUwN7BgFo
         bfuA==
X-Forwarded-Encrypted: i=1; AJvYcCXHIK/ZmJaWmgKz5h0ZntkhAG8tKmshNAGbBKuk/j6LdRxLGQMi7sKHo1BdCIFxSm0b2o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64hKGMTBvvQf5VkPVXKspZax8kD+2e4gKaYzAjaT+vva7Sx8z
	PDkImbNQRJnlJD/EWmwCMNdNhyDZqQQckrvBtnxbWZfSzThjxIER4izyTZQZMhoAQIw=
X-Gm-Gg: ASbGncua4SblUOFIglXtUUBszaJdZNTN3dg1Im9/2Mqdxa3kPCPpT5AsiVaxy5UYzDa
	Dhzr8GtZtd1VmsahboKMHNsY2ZPZjy+gkRn11/cCq1Zk0uyaTfp4wzma78j4T1EXvFje/rlbalJ
	wYSA/da8otlmxeajG0E2JPOkFvxSCk9VwJw0uXqTfNeXm7D8WUUQ/RtjchL5MXn0SkFLdfZvypd
	y2Lw3oAyUnUVlYqUBzxfidaG5c6dXfnds6tuPKlWIps1UNAqmDYOiS2YCaKdmEGYHbzAL9XVFSw
	VLLDkn5bRGdy6ctYGYirou8Bx2dBkpCReXKiJ3mJWhWXAprT30kSo0/fXg+yNHcY0/1wbfqDmrx
	89N+mViIbrgv3ug4Iv1jSE1XTgjECbhNpdtayM/ORrOmWSiMFm4XeIDp+qg4t8xLu
X-Google-Smtp-Source: AGHT+IF3cZHVbp3tgTRcPr3hT+w0SnmMM4i1lfdtUaK02T73T2tgrz/KXuRmiF1SvBIdqIZE8awJZQ==
X-Received: by 2002:a17:90b:2689:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-332a91ba786mr3612187a91.4.1758643712247;
        Tue, 23 Sep 2025 09:08:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6e7sm16482892a91.28.2025.09.23.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:08:31 -0700 (PDT)
Message-ID: <5709255a-6cd9-4c0d-970c-a7e2c92984fa@davidwei.uk>
Date: Tue, 23 Sep 2025 09:08:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/20] net, ethtool: Disallow mapped real rxqs to
 be resized
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-8-daniel@iogearbox.net>
 <20250922183449.40abf449@kernel.org> <20250922183842.09c7b465@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922183842.09c7b465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:38, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 18:34:49 -0700 Jakub Kicinski wrote:
>> On Fri, 19 Sep 2025 23:31:40 +0200 Daniel Borkmann wrote:
>>> Similar to AF_XDP, do not allow queues in a physical netdev to be
>>> resized by ethtool -L when they are peered.
>>
>> I think we need the same thing for the ioctl path.
>> Let's factor the checks out to a helper in net/ethtool/common.c ?
> 
> And/or add a helper to check if an Rx Queue is "busy" (af_xdp || mp ||
> peer'ed) cause we seem to be checking those three things in multiple
> places.

Sounds good, will add.


