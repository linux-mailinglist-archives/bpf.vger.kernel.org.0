Return-Path: <bpf+bounces-73798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197CC39AA9
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E59F44F76E7
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2443090D5;
	Thu,  6 Nov 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esRVAz9Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE12FB616
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419138; cv=none; b=CkjSur7IP8GCOkep1qztJL7uBEgMNdgSeSL7dtETdLTdfZ6AT3VTuN6AtnGVJecD3+Qv6ww6DlbRSOOZq1UbJSUH5MlNo7Z9yYnBz/qKDN3bEkzde7REvM6CecvW1tOMTz9lSYjXu9nHlyPY3QL2YxUM1tQFQodRG4s+RCnlV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419138; c=relaxed/simple;
	bh=uZWUHAju2MgIXw9KZYZtVjROBBtGB95ey+E8B9tXjfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqP0Gg/qWpvXx3TsN4MZewmWkTom30W5u80mwzyMCr/vO6W9ZEJGOwCBn6z2MyDDdL60bkcUWYoorKSC1DG8zEVJswQZ2A/toaZ/MN/CcOYJuZhGQfngwB2GIoiGTW9LctT+SPiNgLlZPVoJUDwohNT/f1TJszC1DEYRbrEQ0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=esRVAz9Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso276803f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762419135; x=1763023935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=esRVAz9Yygt3hCuqZcxTgYQDNVH6rKsFXX/4Qdu3oBhnLt2qzJ+mSipYUGcLYg96O3
         8uvzXBlsvQCMvhD5Ld7pw5FxjXpmOdgC7TcgAeywG6sE+OloGd7nmuTdzPcUYrRuBmlW
         vtd9IBArDUsG/hN2uL1WoUmzRVETiKq5jfKW3yW4kzHed9AqSpoWQ3R44gZ7PJXVq1ER
         3U7T98Vo5pt4Ify0M8ja8o/LPdROBqF0i3UyHuva97V0lDQAIUEeXYiiNNQ8mz85rXaE
         QSCb494oJZIVwv9z0sGV4fR1SJf5F/OuHxuiJTAcHHpyKKn3NPiGTswpLIC9OfN8+eFf
         ESOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419135; x=1763023935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYov8Dro2WY5QRaXiqC8LkQqfmaaDXZFDPXwFxciwfo=;
        b=DUVl4fzgXNM9ztTj4heIrFgGBw6fPddKa8GB7hm7OSFHUKWk/p8p897MX5iAsj0r9u
         JAn0PIpZ1vayDJUUA8oVSvxH9W6eMlWCNqGWrUOJhgPHGEtjFs+gDGTmeZTN+r+0Y7Ov
         MANr0ZaJNxaUYs6K49maDjnZskwdEX5Q4gOd2ZdJOKIyX9EBP7jxsaUFA78/R7HnQeFO
         nflySiFUkybqjzcsANhxOoI0ujdw0E814DWIJUWiQBwAlVhD80iGjbkgX9s/CQEJVyhN
         eA8UUMzfYB/QohAfBJgIp2mWUufVkKyDHTS9EaOMr1nZVzXPCHKnQ1jP6OZh/jD5j52i
         F3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUdtojtpXK5pJFQjuuQY5nftuHMsFc/tWq8NcwjiOnKuEonx6EpcmgxzI8rlAbWeonYO/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1Hulc3+oQ42zwLjQ+0HBh9AiVAPrcaBs9GnIjmLy2ZzFZJhh
	MjZIuwuGi3V/ZXb8781APin2NSIwrpKI1dcbl19oGrOjA+dVuqoUUr1zHnL8EVo5FYI=
X-Gm-Gg: ASbGncvmMlFq3ysXy6VhCtdB9sRpvOX0zkbjZrGGf2ET6zEaJmgro8XtKe9j7X5vM3b
	oCXTUpW0nTTkaR49LNfttQ16seuZag9q3zvQU2JWBgN5hu8m4eE97wXolo4lZjtFHsyGQBI+1aK
	W3643+lFMvZqQoZEIzAOG05PqedIaK7TqZj/V55hB5Z3CLNwv3hK6wBBGS2yGXAHpv4E3nAngK2
	xtHb9xVA5FsV89vRluWfxR0Xi4rkv4mc4iZIqOJfOw/Ndiaza4cjTa0WXuGthB4Pgt9xx+4Q6Kl
	cje8FpcTxoEFM6ibEr1KGyaSGWfO+E+sGP8uxSVsSLYDAek8wdq8vyyt1GxMI1qketDWBaTsbup
	W2DQPtx3i0tNTHbZ6e8od/S7vmJEjwmiprBb7VhXziLc3kREFK9fyHEYJlCxM3w3cnDrmU7WJG0
	Nggo0ZSErhDGBomfF5NJZcWMlw7C0jgp/UU336y4qXzkw=
X-Google-Smtp-Source: AGHT+IE4MYS5Wr19GhmhPW/lBh+nmvHM2VktPve27rlVGZM2YL1NCWMjNGClTXGoBm0OuhF858f5xQ==
X-Received: by 2002:a05:6000:22ca:b0:429:d4e1:cbb5 with SMTP id ffacd0b85a97d-429e32c4b31mr4414987f8f.8.1762419135296;
        Thu, 06 Nov 2025 00:52:15 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771cfsm3584100f8f.30.2025.11.06.00.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:52:14 -0800 (PST)
Message-ID: <1b7d3311-764f-4e73-94ca-74dd508d1113@suse.com>
Date: Thu, 6 Nov 2025 09:52:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] module: Add helper function for reading
 module_buildid()
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-2-pmladek@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251105142319.1139183-2-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 3:23 PM, Petr Mladek wrote:
> Add a helper function for reading the optional "build_id" member
> of struct module. It is going to be used also in
> ftrace_mod_address_lookup().
> 
> Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
> of the optional field in struct module.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

