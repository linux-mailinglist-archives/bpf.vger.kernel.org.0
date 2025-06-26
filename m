Return-Path: <bpf+bounces-61681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60575AEA2E3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEA41886F6E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10E2EBDEF;
	Thu, 26 Jun 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hugWI0Qt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B012E6133;
	Thu, 26 Jun 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952268; cv=none; b=KCsPUqmcuUHoFFwQtDX9X+SyhdxSTCVJRmMsZFiX4fuUD8+I4ktTwrWHBQige6UAtZ6Fvnmg96hvCZ31M0Sc6tCPQ7cM9fb9tUClwyMFK7ZhQt6SpxF/0MiQ8KnKIPz6gg5+nx/L565AzxRMf5UjSq76VIuChhKgkcT6j6/rwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952268; c=relaxed/simple;
	bh=1kTchX7hydmdDHaIeR4b7vCB4DidJo22IPgQr6l+BIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkys7LPlGDpx/Kj7YQnebrw+0wEu/f2b+frm4MtXL+0+P6Rt+OvdTYDKU27XBs1Y5CS/OSD3LJg52atnaHJH4dKU8umbV20Tlrw+OUOeJlgUtdlrJkyjVuHZUKH0DlH0ai5RtvcGIeaYE2i684dakld6om6EL9VVadulilV/jsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hugWI0Qt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235d6de331fso16367055ad.3;
        Thu, 26 Jun 2025 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952266; x=1751557066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBS6+tGrLYEgP8XOrgQa7cC9L5XmsRCAXvGJg8Wcsyc=;
        b=hugWI0QtJs7EZAmjASty5aAOx9U73zagwL1RVxlL+GvrSb2ssIsXCnw7wM1ln9Gf6V
         GXeKPSMJF/0M2VqXx+aRZePH/9ujW/dttis2x7Zl8/jj4dfP8oY2ScVOR8dlhrQcSWeU
         oofnABbm8deyChDcdX/96+Fzs6t0ztAwShP8p9rvYkzBH49O90vf+C1tZ/PTvGUSEC2O
         yJoikCcH7lylEbXomx9bBZQ6Wg8lMhS3Ac+8vhDJqdRuXygOruhNeMhlfcrtWzphQFgA
         cKzgwfvMG6Y5enZlABlRfcNKwrASAI9j49NVBAIJfnkwEHsPM26rY2DEP4gx01rcgdp3
         EK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952266; x=1751557066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBS6+tGrLYEgP8XOrgQa7cC9L5XmsRCAXvGJg8Wcsyc=;
        b=Eiqz/wfl89uyAHuaZus5ScrIyI/tUGOiD48M8K0RuF1eE2gxWMFCY6Ivb73kMyDWcE
         /UWh9jZxgbTqrV2qorkKRDg/C7A1pgOgr+oeVF1MGtIbtzHvrT9EJJqjSOc0H5bjZ8Pf
         VWeGLNkg3yjXxDYnDCC/RmbDdboa1I1WIg/o7EFZErOQLVC6GfyXFwiukPlfSMvC6bQc
         OQ/WOoQC4Ar4sDoS/FTzIVpuf7Ymnp/4vM4bFirp2EQn9gleWpW5noeyMPGzBC6fGyO5
         zxLdMtw9Vr8WYZiceF2x/QNhhNgVeXGDUABJ3KfdoBv48y9F0OPd1C7i0MJRWjHHyQge
         O8ig==
X-Forwarded-Encrypted: i=1; AJvYcCUagjCGwrnRBhK/vkq9XtykoTsc/NcG0wYqvyQ2wg/HGEQ9EgjChXXyr3PphCWyd7ftwhj7LD8jyKCrhDZM@vger.kernel.org, AJvYcCXYZSn5jpadhBti387g9vSdRUVzQxQf74ovJKP0OwMtZSzn0T6Ce8SHY1tz2jgPaD/MlL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNrI0rdwIg4kZhsd/mX+6bclRv81xHdZm7t01J3EBUQKA5coA
	fGHLMMKxHdKrcQmwH9sLh+vL2zzsX1inQDol06420amxassCwEjSt0iqCbUY5w==
X-Gm-Gg: ASbGnctq527zRL49oznA5gr324Uoc3S/7DUeLbR2TGy2cBi7khaTVNyUgNxeM6cOqmJ
	6GS8l2YjPojPCZkl9MTmkM9CpNa2gH93QHu5ePa+Q04ueDB7Gu2zXO+zyrMYse7GExBezeByycr
	T5APvheDuslPE5Lcg23LXPQYvBc4Zkfn5ORSLdsaVJaDjQY95eFRg6zVoq7mrtCIkN76JREzNbB
	erg5Fpe9o9FZYr1T7PmUjjmHJE8lGqad8naky2a5gUBq+Eu/tZ287JOI2SZkTrKzpnNf8XqisMJ
	BU0ypq9nI08TCP8WFD2wLFio322DPUrYAugVnjHvoGc+hVqofnNnLJ7BLLGo+xn44GDcdvgI77W
	bb9TzHtKDtjLLAqTt+MoSxRWmV05FIkpZQNSKEnk=
X-Google-Smtp-Source: AGHT+IE9HZQVIg9J0bGTauaoFxunVzdT6LAv+3ddjqizR0AY608ymj/oowE40lSal+PsH63zgCKDHQ==
X-Received: by 2002:a17:903:2a87:b0:235:711:f810 with SMTP id d9443c01a7336-23823fe4dd9mr121698455ad.23.1750952266162;
        Thu, 26 Jun 2025 08:37:46 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1? ([2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe329d23sm1164745ad.54.2025.06.26.08.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:37:45 -0700 (PDT)
Message-ID: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
Date: Thu, 26 Jun 2025 22:37:38 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com>
 <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/25 09:38, Jason Wang wrote:
> On Thu, Jun 26, 2025 at 12:10 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, we have repeated code to check the received mergeable buffer's
>> length with allocated size. This commit creates a helper to do that and
>> converts current code to use it.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> I think it would be better to introduce this as patch 1, so a
> mergeable XDP path can use that directly.
>
> This will have a smaller changeset.

I'm just concerned that it might make backporting the fix harder because 
the fix depends on this refactor and this refactor touches some function 
that may create conflict.

Thanks,
Quang Minh.


