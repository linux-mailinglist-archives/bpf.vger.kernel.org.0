Return-Path: <bpf+bounces-16177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A127FDF0A
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A334B2115E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39075C3C4;
	Wed, 29 Nov 2023 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in+YGbXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA790;
	Wed, 29 Nov 2023 10:04:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4f60064eso238815e9.1;
        Wed, 29 Nov 2023 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701281080; x=1701885880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZLzQ7Dj1ScTKkfZpKniwF/WkNtkEi2sNjddLCuEIwg=;
        b=in+YGbXs+NYP1jnSZIj5Vo9T8HJdftf4z1QQSYDwaZEgUa8Kwwhmqc2Z1uA5yIw+8z
         rmHpW77cTrT1ZUQI2OujBV2HuzpfibtEu2Dn+KAGSn88f/W++DUO5Uu8eJM1vtsLSyD7
         3auJpcErW/6WECcZ1CWJK4uYhT9Ic8IpknKqkDzutk29Uxcqov8dGdRvXuNNT1eiQZK/
         Num36O1ZXVOTwDobVIp+axfnjPhlQY8m57s5jsZ8eFXPtQhkIjH+1Mn9P4Flcd3+8HhQ
         2oLMtobDWHU+/gEthGv+410mogttHjQjpYo57ZmUHYS8+0bb8dbt2A57eYjVzGgnBbEl
         CMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281080; x=1701885880;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZLzQ7Dj1ScTKkfZpKniwF/WkNtkEi2sNjddLCuEIwg=;
        b=JUqo7fS0sKRh8UMoufy/oR8rCvrs1+SVydn50gcLjd+EVoc5Aqx7789zM5pKhZW2UZ
         GCgigHwR1oH3BcwlAERY3yAfQ7NWBDThMx5ISFXQ3Vt2/kDTaYZL8/xRtBmiJqMlgnva
         3Rx5NXg9os280rwMtzRhyXYKc9fJ5tm6tRk+W+90z616WC4v961fHS1ThqDRAhbHWvch
         GtbKuGiO4G0d35Sz8R8g+CLyOn52vV95WLyPKvJ153jJ1Ip6iYeSeHlOP3OoudaLEXEP
         HK02qO5thlW8D4E/iY7NButqfyUfoCcyEiiunGe+6Fo3qrRete3ghKT6VBV0K9c39NQC
         YS8A==
X-Gm-Message-State: AOJu0Yx08tngYmwax/RYE5yRp7z6F23mZe2T4r2u74aIxe9FIWZcGioF
	J+32eifaHv1wVKgqVHCnPV0=
X-Google-Smtp-Source: AGHT+IGGelJRxSuDYh6LBV/x6XyCK6GA9EDLykUoHoVze6v/OEDVVgOTIVyRMMd8AxDWzzQWiDcfAw==
X-Received: by 2002:a05:600c:3ca0:b0:40b:37d9:b646 with SMTP id bg32-20020a05600c3ca000b0040b37d9b646mr11575831wmb.3.1701281079877;
        Wed, 29 Nov 2023 10:04:39 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c3b8400b0040b40468c98sm2941544wms.10.2023.11.29.10.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:04:39 -0800 (PST)
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net> <87fs0qj61x.fsf@toke.dk>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
Date: Wed, 29 Nov 2023 18:04:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fs0qj61x.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 28/11/2023 14:39, Toke Høiland-Jørgensen wrote:
> I'm not quite sure what should be the semantics of that, though. I.e.,
> if you are trying to aggregate two packets that have the flag set, which
> packet do you take the value from? What if only one packet has the flag
> set? Or should we instead have a "metadata_xdp_only" flag that just
> prevents the skb metadata field from being set entirely? Or would both
> be useful?

Sounds like what's actually needed is bpf progs inside the GRO engine
 to implement the metadata "protocol" prepare and coalesce callbacks?

-ed

