Return-Path: <bpf+bounces-44151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAC9BF7D7
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E52FB21ED5
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0C20C003;
	Wed,  6 Nov 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2/swPpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504820ADD5;
	Wed,  6 Nov 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924055; cv=none; b=oPBgznQZeY2NJz2NfouCVBK3OU+IOeCs6IkEOLHpo21YrKUY2XXsokogy5dDG3YU8hlqM3apuPqtX4JlrigP92siqdJ8dMn5VI/0EuWsVBcrPfRdPm6gBjIWMwDYyrhi4H/Y5oQebMCP9pjXJRkBgoeRDNJuhYdYHLOldY0YdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924055; c=relaxed/simple;
	bh=wi75TRb/esULtFCaR1cC8dPnXGvP95FgyG4wOpt8DxI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PuiRVbzx/JzE1l+2xBJBqKs4a9ioMboerFEwXVkc1aQj8nTJCylglDP6iQb/2zGUlDG5a4xROhZr7bX3AUw1/cYXpWenPAl+JHwZM1Bcq5enBZaEt4G6w5POHsGyu1C4GlEz9H0CJx18rGWT4cmUodb39r52Z8RNmpyK5oQ7kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2/swPpR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d5aedd177so106708f8f.1;
        Wed, 06 Nov 2024 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924048; x=1731528848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8VE3dFQLe/sXCOQV5eKWN92GAfnUx9NwFqd/SWFDPY=;
        b=T2/swPpRLYOD2PJLBzV8zxCYmy8vS7qLepJR1X4U9y8iHrxhx+9Mtb80SMUXIuxK1W
         bX+YXW3Am3DY+jr6DW2WyImfqDFxPL3P/TfPqasyVzCz7/T7vEU/hfggAL4oMgEZkWox
         hGjwgLHdSEYSxkvHRw1XYkP86WE/IidCgnly+0KBasrN4TtvaWlgJCoKiqeF840gS6B+
         VRheMMmkChoJTi9VKULocsm1zl2PTqqIFQdsacU4SEtAKVqyEKcDn4jOBXqdAAhIpqTD
         6FNuoLl3xrCoyPM3ncUHRRaCjeRNX1QsuzBAE0pZCXZImz2LE4rX1L7xZV43Z+5sRjOO
         FCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924048; x=1731528848;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8VE3dFQLe/sXCOQV5eKWN92GAfnUx9NwFqd/SWFDPY=;
        b=fVmzSbgXSKHDqSM+bFahmtzENGvfkXIWxnc6GjsiJEPCIzscPwvZ0h910KLeIkDQo9
         w+836OvQumS0/IzU7wzHSQ2ij572PUYaI2nIvNv2kDE3g8PIjj20khXR0EEPr8PcOroZ
         i016ln5vAYBJiyrbdUZLmiSO/Mbf7KxHzaC+mMgRnTu5klVvSqsEE1OVI3x/8xQ7tdEI
         g9pKniKCdDiwQCm/kKXCo/qwiRQSEbZjVNOgC3Dluh1CC0HlnjhmdY56HdleQqvXsxTm
         yRd2RPCcsMm3RIgkUmp/gOGk0bYUKKv37tlfSJ3l/YvW1z4v30s8oiTsD6UzAHFlDplh
         TiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAkppxMWXbnruuDIFnEAlLkfaXyprehVAR6D6sQ8yB36RRjV1XMEF8w/JPnpAoY4TD080G9rKfJz1dF1mP@vger.kernel.org, AJvYcCW1ae9W8dn1nw+WrzMcn3R5ReryWPtAJSmWrYoLE/gq6N2wNOKwPmjaQhyVQz37h/Cba18=@vger.kernel.org, AJvYcCXbKx8h1RQL1ae3zJkS+2fom4e1NIOVhMAozGZK/Qal+PWJITBUR4l+1LRgj1gsmnHXiOA7fnQh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbc+5nnPt10uoI/g9p5mo6/u8AL8HA9MTYGxmEPkY+jI6xUIBL
	q5bPRZUSJpjLUZJG7wPuvEHdNp3FPqiUlDueFi7cHi53Xm/w1tc9hQjkZQ==
X-Google-Smtp-Source: AGHT+IG8YjCGwSwe7cSYU5D05Kue0A68YEkiZBJAKkkfAearDvF/FvVGgkqqJfQUuc7jGRQ9C9v6dg==
X-Received: by 2002:a05:6000:4013:b0:37d:4517:acdb with SMTP id ffacd0b85a97d-381be783511mr21359365f8f.20.1730924047997;
        Wed, 06 Nov 2024 12:14:07 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c7530sm35175855e9.25.2024.11.06.12.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 12:14:07 -0800 (PST)
Subject: Re: [PATCHv2 net-next] net: sfc: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20241105231855.235894-1-rosenp@gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d6d6a813-762f-b5a1-6a61-1cea24ba6618@gmail.com>
Date: Wed, 6 Nov 2024 20:14:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105231855.235894-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/11/2024 23:18, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

I was initially curious why we still needed the 'n_stats++;' bits,
 for the record it's for .get_sset_count().  (If you end up needing
 to respin for any reason, perhaps make that explicit in the commit
 message.)

