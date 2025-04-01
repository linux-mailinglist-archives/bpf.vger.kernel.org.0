Return-Path: <bpf+bounces-55066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A934FA778E0
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC016A5E8
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EA1F09AB;
	Tue,  1 Apr 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5HMXC4w"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1421519B8
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503597; cv=none; b=b3fQdE4fQqKqvKQ73e1n2Bt331gi9zHBWVw0E5dhD3yxcvD+jn/7w6de8uafbzGNBRDPsn8wnMB5gZidzkF4KqxdeH2Xs6p89P5NtFr1EpkHyjy8e7cO3ESPoQFq8M0+q3L1CkcFEOTnbpnkOED/bPq3I01q3xakH7EnDu9Zidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503597; c=relaxed/simple;
	bh=ApBnmgcKqMD058hx45MHE4QVSw6qEmgZIyz8Wmp0Z8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdvlT4mo4JDJiLvr99pcdK5umX/wJEQO7nYGTO3z0+pgRDaCZSpvot35ErQgukBvzYQCfKYeCdXndTf9yjkrbnDBmZpF9mHEUnKD7gNUmACnMocyjM9pjYTPCGwhtSqHvjSqqrC/lRBS6F8wArdP2dFQKc+wcGHqk3O2hx99uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5HMXC4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TsOOeVbIrS0kLjU5o00N+CHVLz6q84BnG/iW8mymGA=;
	b=O5HMXC4wRotUbBHqnAThf8R2t0IKOHhCdwlsa3dXKDW63P3kzYciCFaOVVAq9jyW5+SIeU
	kRIPJVl3HnsysxWezdzRkPnWrjWSrRXRAHmvwQR1GxPpzY/8gaXji11WUaRFvaHr8P1O9x
	WqIIX8ZaMiiNdIMk/6MkoY4reYHC5h8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-NangF_DGNSOJ8VdRyXDSZw-1; Tue, 01 Apr 2025 06:33:13 -0400
X-MC-Unique: NangF_DGNSOJ8VdRyXDSZw-1
X-Mimecast-MFC-AGG-ID: NangF_DGNSOJ8VdRyXDSZw_1743503592
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d01024089so47883985e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 03:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503592; x=1744108392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TsOOeVbIrS0kLjU5o00N+CHVLz6q84BnG/iW8mymGA=;
        b=b4SLqqF1JMgsvpHj63IUacOv+9nU33Fr/NMRseEEqKnYa3tp1RTp+X7/T48RoJM9XH
         K8LR7zEPkHkyOmXUmYxQRpA3cZlBEHoY+5FOyJa98zNZu06OFggzMwSDmN7h0n5Medtv
         NDlFMdyDxX0Y7J3/iZnoNKJ2xEf/yGMBZ6k8KDw3dbWuLs5rp833p0e8lvyb3Iir94kI
         A3kMV3YHLs0BMV5w6e9kwbcheoImQnIrQN9LbHGMeVBxPcK7okc60JbkbwZKrY/tuBg6
         TXoGGGNrniZfybOOcar4UwN5j0+ggyDVBcAHr2dnnD2dCub2+jQACLmcF4LkiSVwkzQh
         Avww==
X-Forwarded-Encrypted: i=1; AJvYcCWfD3hbmXe1wT7vklcWFkYLt99X5Nau6UsBNKKRHr+am1BjfroOWS9ESEksiLJWXd7LKJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRHwbv8p6qWLkmb3G12KeRznWMrm5jK+eVS1a1rYLdTm8TRoZ
	4W5Lj1+3q5WHXiED+F9wknlpCB33Jwhldg3qJVxOOeoU8Qhm5kvNMM3xGFWXDLONgky1UoHc9UJ
	nvyFE/QQ85vVPUp9XvsPaDV1zM0/Mg+3q2oXZAAGaD8Y0sAladQ==
X-Gm-Gg: ASbGnctryf7i+GIO7RIXpqK9v2Tru8KmfYaF1SPniNrQWiUe26IaF+gfEkfSsG4KTi3
	GJltpEK/Zn7nGXfmSaSu6+rmcoz0eUz20Z2jWZkpBPAQMTj3gU6DgoHz3cDhPsJXa1ZdfHWtVSr
	3vq9JyPgpXRf+kitmHy7M/W5orcxFPd3RKChDD4WO/Y/AP8yeg2PhKrA2jM/JavztyIBM5prAgu
	JBnNiurOid9KHrcThs4bbqo+Ei1TB93E796Uro1iKpyPRn519ecGkMoJ/hhr/aApI8IQl6OWYIC
	nL/7cYC+wzZ3v0ASR2yShKggaq5arLYsmcyQ9RP7xxACNw==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43db6228823mr106308215e9.7.1743503592246;
        Tue, 01 Apr 2025 03:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMLjX+su0ElU+wdiotWIkpWOESzlWW59YNDgOLOqWSNKSZCQnxyBq6YuI7/DjQUyGF1DSr5g==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43db6228823mr106307925e9.7.1743503591949;
        Tue, 01 Apr 2025 03:33:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm193576985e9.18.2025.04.01.03.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:33:11 -0700 (PDT)
Message-ID: <d2914c9f-5fc6-4719-bf6b-bc48991cd563@redhat.com>
Date: Tue, 1 Apr 2025 12:33:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
To: Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, hawk@kernel.org,
 syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
References: <20250331142814.1887506-1-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331142814.1887506-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 4:28 PM, Stanislav Fomichev wrote:
> Syzkaller points out that create_link path doesn't grab ops lock,
> add it.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@google.com/
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

LGTM, but are there any special reasons to get this via the bpf tree? It
looks like 'net' material to me?!?

Thanks,

Paolo


