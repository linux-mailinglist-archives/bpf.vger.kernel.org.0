Return-Path: <bpf+bounces-71497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD0BF5B8D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184923AED3F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38A329C63;
	Tue, 21 Oct 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtividXJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDF2877ED
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041647; cv=none; b=EwopwyHcv1X0Y2XO+GbvZcCMdfYubzH6eVp0qNnOLyz7p9085CQRKCZBCf863HJnX2gerMrcMB2fYzLy6UlLjTlfF94dokPbmOcyeHhKAyGbIULcdclNUpjZfnC6xa47j0dgkEi47jNRiE/cImUQqjW2c5MP+ZBLXtK5Cg4aPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041647; c=relaxed/simple;
	bh=hZFYqccy3hrzjkUJnAWqrJtsjPd4X/Rq5BGUoMThiBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9l72Uyund1G1Q/q0/7/jMQ0VwCzclbn3yr9s+0cZVS01Ribv6BaXb01t22phNjufcmD4Qw0MINtpeoCiUHqG0zlTZukR8qdT10NUK2ZqZfRzmnio1bt2j6gHZn6TcxuC/lN5iFcENeDZ+VRIyiJ/zmlBIvhuA7SFyt0EW+IBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtividXJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c184bb78eso833048a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041643; x=1761646443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=UtividXJcfovqe8wKQVSC1Iwlws+W3vm9+YGgu9nqkRy3ZOFluhjxN9jHfUPQwf8LG
         pPrDc4wh5WlXIWv+a4wea/lw3U0FpnvBljkCmvMD0RozwB67Q9aP5zeN7tCA485hujDU
         5YZiZcOlLL8OZPmNgmwI16zXW3+vpD6pCaaKyNSgCa8ypWpFwDZCCLji3knfQtlTnbx4
         0chBktbiOp+kM7Kkbsrp6hfQJnimQgGLa3l7jT5ztxZGnkyKo5XlQ5JXq3H04Q324olL
         Swb5G+4gqTnvnjE1k6TLXHTgz4704Lu13NplwlW2DPk5yvHit/KLgnPMw+lXVozWxlMB
         /1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041643; x=1761646443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=p6NSHCl+Ih7XF2OYeKRZGe6jinu2KwLCe2WJQpdiUoAgSst5g0cnd8zbk7Txbfp+fk
         1J8H7jIfk7duTZ9z9fzOf6zV8GIWOzuhRrmHQWs1DmQj1lNZKjheswqwjfWEy67MDrO8
         SdE9Fm2u9qtvcer+ZQmVGQQjV4gYx7SoXSRPH7vohyJ+UfE8yB4hg8n9wzrfTHV344sb
         QVgzGKY3NUKWv+yKObCSD1qegOuTx1MCWiOzqOa6+yrIz/QzvbiWNZvvjYGRvdnNSFlQ
         gvMuHZLE/SC0C39DpiCQJlQZSwvBiex8byfEojCIh3JeEOTf/IUF5AP8fnK4hA9q1CRg
         J5yg==
X-Forwarded-Encrypted: i=1; AJvYcCXre3iUMmC8qF46ZYFDbWaugjON/v/FitbOGkX3WiYmCj5Q+BQiuW9U4HT4H4y9QuHulYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FXqVGFdXVcT3ddTQ5f8aY4Rxg7AwghCyMUcTLpc9KzsjqbMS
	LscwY2ymhKVaDSzzMHH9iBBy4LmVEGjA0RPgUGxyoojCpgUguyeFZ8ei
X-Gm-Gg: ASbGncsTdBdQX4XGe/65vwi0PErPOs6hfszMGKAEcUuZLsW7HLN/qsYmZe60juZJd3q
	goj5ia1l1afUI2MXA8p9gu9aldoA8ZWNrKzblho8DYdddlvatDt+Wfm8E5/RZ/piDyDdy24ROgh
	ruqR35mhbtcsgTNljUZOKNSiA/7Dbx5RrCkeghsi5voUoLEvbP89v3zB3cdeI9iwuUaJJ01PRxL
	b8d98iQ8ftFuh9WGPvTLb/7aAy7hgBpsf2bHZT5pCrjRZTEoNe4duABaWqbP9/285XNpcBsivGB
	E2kxbLmavyuzDxOT36uXjsCY6HGycfDo4fRJ3PO7L2iCc5PPDYTB9JLBkrS6SWMPdUJyw0duqQL
	sUjk3WSL8hHV3BCnSITyy2jQmkohM4wVlUCp/JuWI6eCf0fbct3hc6L30AtVn+VY9DV2axJGZnG
	fduy4e8qQzq7p50+m2qEH3EfqQgmQa
X-Google-Smtp-Source: AGHT+IGp3+5iFHi5zRWLe8YxHSX3njxzZcoBp1BcVGuZR2w2gCAwViee0Dzqam5RCqIQMql4fNoXCQ==
X-Received: by 2002:a05:6402:4307:b0:63c:1d4a:afcb with SMTP id 4fb4d7f45d1cf-63d09d3bd06mr1476817a12.0.1761041642678;
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4869746asm9018625a12.0.2025.10.21.03.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Message-ID: <4c849c04-6647-432c-807c-5fa7afa7fb47@gmail.com>
Date: Tue, 21 Oct 2025 12:13:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
To: Jesper Dangaard Brouer <hawk@kernel.org>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
 <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 10:37 AM, Jesper Dangaard Brouer wrote:
> 
> 
> On 20/10/2025 19.02, Mehdi Ben Hadj Khelifa wrote:
>> After discussion with bpf maintainers[1], queue_index could
>> be propagated to the remote XDP program by the xdp_md struct[2]
>> which makes this todo a misguide for future effort.
>>
>> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
>> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Changelog:
>>
>> Changes from v1:
>>
>> -Added a comment to clarify that RX queue_index is lost after the frame
>> redirection.
>>
>> Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec- 
>> aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
>>   kernel/bpf/cpumap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 703e5df1f4ef..6856a4a67840 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct 
>> bpf_cpu_map_entry *rcpu,
>>           rxq.dev = xdpf->dev_rx;
>>           rxq.mem.type = xdpf->mem_type;
>> -        /* TODO: report queue_index to xdp_rxq_info */
>> +        /* The NIC RX queue_index is lost after the frame redirection
>> +         * but in case of need, it can be passed as a custom XDP
>> +         * metadata via xdp_md struct to the remote XDP program
> 
> Argh, saying XDP metadata is accessed via the xdp_md struct is just wrong.
> 
Ack, I didn't clarify that XDP metadata should be propagated via the 
bpf_xdp_adjust_meta like mentionned in the link[2]... Maybe I was 
thinking more in the technical side that xdp_md->data_meta would hold 
the value internally... I will send a v3 with appropriate changes.
Thanks for the review.

Best Regards,
Mehdi Ben Hadj Khelifa
> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
>> +         */
>>           xdp_convert_frame_to_buff(xdpf, &xdp);
> 


