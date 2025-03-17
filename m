Return-Path: <bpf+bounces-54213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C2A65907
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313EA7A5DA2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88F1A8F61;
	Mon, 17 Mar 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SphrnGmx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4E1A238A
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230147; cv=none; b=rD7CzFoeDPBeuQWg1V0CJb1gfI9DnC4PZ57yq0cqI+oxhbaRoI3NCV644ZTpiQ68LY6eV1WQyXj5ZIxIhfuIuAOAikPnl1j8C6WluXriN7ZeWGq+wl1Nc7YYj5eudLxMUKWr7uYR9CZjfuV6wstZFbQeS2ASzhGZTL2wuVGuuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230147; c=relaxed/simple;
	bh=eM5va7AuXLT0rsHrtPonGC4+dBUXGMAWOPLF0ULzaE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLGmLIejfz78dsECKR63Ze+X0ps0SVVq0YBz3yAxgF90Tr5N8JuIBNAuiSkf2P8cGmAYV6T+YsqFlxAocLJFTRGFyYJDnpwrp2YNXycU69PxSf0YW3d6DJ0kbBGVnUnmyGLdx6KACS7Vf1WbqPx9UvbmB8/c3Rp68U/RmNQZsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SphrnGmx; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60009c5dd51so1077676eaf.1
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742230144; x=1742834944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hR+2cdo6mmbMt3HXD2jP5VNCtOJ9m0Gv6fbcgcv/bBU=;
        b=SphrnGmx4itMCN/ExoJlagg96dOO2GROqAOk5kcZ0CBC0m1fxSmJO1kDeb6MLPPW06
         kB+NGW1cjPfDCQ56bQrADRBckubZ8uqZ529CRVpA5/c1GEuz+0M6B0nlJHURzm0bET24
         cXVldmTY5NvTAyszkqxWY51qrbWCt3++YmLm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230144; x=1742834944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR+2cdo6mmbMt3HXD2jP5VNCtOJ9m0Gv6fbcgcv/bBU=;
        b=Sn/8CB7Zf5ZPyTs0LsLXYzg9Mi6JSkS0WXip0GnUggZt23lag+d5COUGqdW2NsoNCy
         E3Sw1jTc+kzX9HIt6DxVJjXwEbJCVREVmN+SiwLDPu1dJsIuLdRKtmClAb2bEe2cybZS
         Uid8ALXzrQO3Il2Gcj7KwJFrzKSVZvDwc7PpaLJLaFwWXAmBgaM0bGKsn4CtXM2VWhan
         LkszmnkiD4Wqp3jh56HaKhv0M0xh9bfHtURIzdB/QWNPWO4Wgvhyxq77rQFyPQBma3uY
         gYAHMIr+fCHLay+cnixiRJe3WEYXlCtdgNxDh4/QbW0fYDY8Z7z3SuEuuJzJfw1QJsl0
         bpFg==
X-Forwarded-Encrypted: i=1; AJvYcCXmYGubwWFLQVK55+rroA7MAVdZ9ZuIfnf2xmsEl9+DwVy1CWlLaRq2F/kn9TrSzJu7/JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCC//D4y5vnWp12TN+XuH/985h2qfSewCcXXyEsM1ympbdqkn
	KX8iK4Wa4BX5WIaWBnG6A3y75uQLo9s77oc5rmXlcCVS13X+vAOFs3mHkCOEeA==
X-Gm-Gg: ASbGncsdi7eCgGTprpN+Sym4xMjpbI1sy8cGiIthfnhcFS8zkdkPFNAeAHjpmX22edL
	MMu/WInkzyqWOuz96ahcIlG/dw37GntsuUXL60ex97ox4aJfnmCa3QePrJrBUxtB5v3kmkdJX5o
	fxDCcJrNnIieUGg1Aq9nwTU+hEzS58ZgvhSJ5jrRsGFo1ECCGeAbkW7fUOspAuH+0FFaIhsUpwg
	mEiQSWk9OKRa/8pmJiSE/klcLgIKaC7G5AamW3NYW/5USNkLffkkXRvyQCkD8ODj+Knuh/Z0rya
	r3K8Hvqk4cmfCELE+pL7+hXhPpurYpgg39/L1lnCc/IKG5pxsN/wGVvIUqQA6nvIbC45xxe+PsL
	yJWf93JIw
X-Google-Smtp-Source: AGHT+IEXhCY9xr89eX6tBMG7DkAAspzRtGTTpjNmGgFlbsiwNx2AOKEyzh8EpraAE7G5FQCFX748sA==
X-Received: by 2002:a05:6820:883:b0:601:b7e1:9233 with SMTP id 006d021491bc7-601e45c8543mr6433144eaf.3.1742230144551;
        Mon, 17 Mar 2025 09:49:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db6598aesm1673541eaf.5.2025.03.17.09.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 09:49:03 -0700 (PDT)
Message-ID: <2464508f-864e-4697-8fd5-ffa5c06f64a0@broadcom.com>
Date: Mon, 17 Mar 2025 09:49:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.4 0/2] openvswitch port output fixes
To: stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Pravin B Shelar
 <pshelar@ovn.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Sasha Levin <sashal@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@gmx.fr>,
 Xin Long <lucien.xin@gmail.com>, Felix Huettner
 <felix.huettner@mail.schwarz>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 "open list:BPF (Safe dynamic programs and tools)" <bpf@vger.kernel.org>
References: <20250317154023.3470515-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250317154023.3470515-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 08:40, Florian Fainelli wrote:
> This patch series contains some missing openvswitch port output fixes
> for the stable 5.4 kernel.

Scratch that and the two others targeting 5.10 and 5.15, I missed that 
DEBUG_NET_WARN_ON_ONCE was not added until later. Will submit a v2 later 
today. Thanks!
-- 
Florian

