Return-Path: <bpf+bounces-69450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9814B96B9B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B79167115
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D94264A7F;
	Tue, 23 Sep 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2CLwhMfY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A9266B6B
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643569; cv=none; b=PhtNo5JBYgacNqGX0nz8j68Vj5G2iKpKMVHWotsSoT30G2JhaM/Vd9r7RVxeXVVOoSmyBWbs1WD7MMnY1N2dnMnNBW2cXArfF+W8Y2UhHgWVNyq+dBfDu+EuiX+HTMXSut/eSJCvVwpPmId6BgTKb3F3Ldn/1/Nlv2OKP0TWGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643569; c=relaxed/simple;
	bh=+elWHMdwyucxJxnLVF5sZ33MtWaAF5TQMhPS+5nZJfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4msH0Bf7qAgm2Tnvvb1BZgxI5IKkypShlxNHXeIua27u4D5HSU8YKK2hEcYsNG4LOteBc1nsOiVVZY+zgBeruTvfmdHwVC0iU37rOoKWLrcZQQOWWsVy4rD1QghA5SXY2O6R5wC9WiWcAeZBhH5BD+h6q1HX0XVQMrnFj017mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2CLwhMfY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33067909400so3809623a91.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643567; x=1759248367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x71NaeNBIF0XIXPAkDvf+aw7re0CQhVMKd4/I/OtWro=;
        b=2CLwhMfYBZ6hyY4q3Q2GPS5AA9G/f71+sOinbNjirq+SOFDkDYGL+MZ68reC5/nFYH
         1KEbUQzIsoBnXqYi6dkJGKAynXH4Mxx5IztxL8gQe+ErafXuXuXCCaGtKv4PXXvjjg8Z
         yAdQgM2Kb9e+0ECq/joGoiijSj3Y0Vd3B9k8rgn7AuTrCOwceK/HU53wiWKaV5RVBwkv
         QTUnWVOc5a8l5N1P8Rfnlq+aw2PaJYMtSk5AnsIUQQ35VHuN0UuNTYbt7H6g5xfiVBMi
         PtifPfZFC1kCBgmPDXtyfqqOvdOg8138yhZLF0xR52eMQvr1RN74kpf89uHT+6K3KTqJ
         2VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643567; x=1759248367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x71NaeNBIF0XIXPAkDvf+aw7re0CQhVMKd4/I/OtWro=;
        b=GqU0DBk/KigrUaz//s9tl1ERl5MSOUuj4BnO96UWkJJbkn5uy1y7AdCqcm/4yVwfIx
         MyxdnPrnQkKXT+K2D8fwNlY0TGFMX6zfQkd1TG9TEXRE157VPDw+kh9I4SFzPc+UsRzs
         o98XcHgdtdhSJHMWBL7BhGMrv+Blth+6nSpTF4FBwclOQTWZtwRVuQy312ZupZGL6iCI
         91Dy2zbSL8PWZRvgn2uHvwdIKOx+TvP6xVAINVsyJFNRi2vVZP8ZuEFj/CBiDjD15zGR
         MVkojIxgU6Ao7vVdN4AYp4ulDXryGV3kQjXrBA4A4D5tVfpKmC862RPi/d1ey42OsoOx
         ioww==
X-Forwarded-Encrypted: i=1; AJvYcCWYZ/OpGnkQOFIzEzQwadIHwvMaKn751z/Rdr+hQJ6kXtIRgSnHuTLHFZ8HpmmpNowaXVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WbN7aJUEwHmcrZBbNfES8MoQuE6B+sxm7uOLrKtIU1d31KxE
	4eutAu75RUm+p3xygvNGDqqrWcsK/N/mc3f4DoTp5QpvkDb8XufQYvrg6Nf1AlVpWic=
X-Gm-Gg: ASbGncvKnr9GImd3IqtjgACW9gEphePxFRu/7pGlHLl8ZpZeFH0Vyb/Ic4JyfZSDXKk
	DtsPGJc9d54JsEmMl2wQWOYdcCByxqYJ4ZKeQRLHLbzh2TcVIy4yM9rFOE2MfOun8fuqgYf7hHP
	SlkFW3OK7yI58cPkXRvGwqrCdGYx1LmOr5i1x9aKAZt6sKA+h4EpiRpqwIZHjta4x3CJTaxmTUL
	YSji3KGv+GbqyWaKlC+HiDSbTRncG29+p3hJqyL5/P/SHB6O2lYuoUktdQ2t6flBfalsSVbW19x
	1OUGbFQcQv8+NLQaWPp9DCFJrSzRLQYicZREKjvUc09rcKoztA+0Rma+AiaWsKDdSilxxSm1Kws
	IDAkYuvSOzuiqGgy0j4UNaIhQbAlJAQkG1b/V0gRNAm+viqZrrIfQalMrXqWn7lZ2
X-Google-Smtp-Source: AGHT+IGxbjHUkRogA/ixnfg9Umf6TlNL5FnLHgd4GBDTZCkGeyMIVUqswwXPZSfcq5ph4sQe8I4t0w==
X-Received: by 2002:a17:90b:4a06:b0:32e:a59e:21c9 with SMTP id 98e67ed59e1d1-332a990a97emr3752881a91.26.1758643566472;
        Tue, 23 Sep 2025 09:06:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a970646fsm1313303a91.4.2025.09.23.09.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:06:06 -0700 (PDT)
Message-ID: <dc23879e-1c63-4158-b002-c291548055cb@davidwei.uk>
Date: Tue, 23 Sep 2025 09:06:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/20] net: Add ndo_{peer,unpeer}_queues callback
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-5-daniel@iogearbox.net>
 <20250922182350.4a585fff@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182350.4a585fff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:23, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:37 +0200 Daniel Borkmann wrote:
>> Add ndo_{peer,unpeer}_queues() callback which can be used by virtual drivers
>> that implement rxq mapping to a real rxq to update their internal state or
>> exposed capability flags from the set of rxq mappings.
> 
> Why is this something that virtual drivers implement?
> I'd think that queue forwarding can be almost entirely implemented
> in the core.

I believe Daniel needs it for AF_XDP.

