Return-Path: <bpf+bounces-71103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51EDBE253F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395D5428111
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72523176ED;
	Thu, 16 Oct 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC2IBFB5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AC3090CB
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606238; cv=none; b=ppfGpTa4g0ksgCENkA7prCylU/a8QuSj+S7B20bAw5rkgCmqpbQ1k4xwjkzRkQ0E7fBZznYQFhf0jXB2IOjLKg1ueCIZlQuuMthHGmMVWFsgAF722ec0tzFaaOD2dgTQkHRxJfJfl+K1oGyh7G+fpMrrE+lLTPenDtyvGztn8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606238; c=relaxed/simple;
	bh=gfUY6k3Za1yX/HAAk7zG4178blXNgWT89fTHHoWhQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t77YomD0G2SqKsFeLFhVYCQ5vgt15RJarGruBSjrHHTd1KT/sKgf6MMxA17RlnGADcY4b90o36CkLh/H+s8DxdQZi8Dzd5ay9EaXxEDxvFHCCFK8rOrCZisGjCoARw/FX/I1FA+UOXixiViV3ajgnTXTlk0/Z0h1Vv/PWi9y+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fC2IBFB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
	b=fC2IBFB5yMDrW17Fu4vpessqvPPIAL/hJCGu40tA5HNCGMgZRgWUe6O+zmnvRlPX5gAHgg
	Nm8JpJHQ3AeatEaZYERlv9chEh8J0zOzGHmfR6h7Mu2jRhwAdbm8e2lq+3DDJ5ohJi155O
	wiD+zvJPfCVxc8s1+z1XbN9JgOtpfZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-IvKFfocKMT2Sv2MB9skc4Q-1; Thu, 16 Oct 2025 05:17:12 -0400
X-MC-Unique: IvKFfocKMT2Sv2MB9skc4Q-1
X-Mimecast-MFC-AGG-ID: IvKFfocKMT2Sv2MB9skc4Q_1760606231
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso5093975e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606231; x=1761211031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
        b=TUms+AVsJJ2ydp2yz0PhlCY8yVlbWguLwy08rfBiFH6WLzHqY8eDfEqGNG+51TeJxc
         QfksNwYnUD1FabHwIPyhoTWz+t6f7bhyXw+epedrcslEbUmSL/VPbKRXbHWi17r3TG1j
         mJ+kiWU7iDA4h7D7DDROkYvXZw5b/dlm3x1PhviIm5qfaKqGELqW/UtWRLVToHEIA9T3
         Yqt6Xsr2zmBoHXSAyNsuTunOoK2srgy7rNrZix70wU7I866UrAQ75KXLPr61MS+5GNse
         KP/cUpqsskhi9X6+AzfI9cpgkmwvNxvGmdgrpQq94ngsNjiKcjjFk5KUxz5lFyHwAn6/
         aNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVupnDEPx/Cb/IsqmWGre/EONF/Gt9281KzXdJckKMzsRBF3lZtxMxUAP06ZmsZhjVhPLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxecna/RSLW8otga8aq8fPwsfHr4RU4LwfieSFRDxodY0rayH6O
	T4Rt0mw/eb+UwqEHmtw8hi6oYp0HZgVtoPsxuOsNcz7pO0eN6lAlkh9GvUns1dfqYzpmquMbDoV
	vN+6ygn/2tnaaSPgi0JtoIV+UIPTJdzjI5pS+HbrOyvm0eKoQdX9btA==
X-Gm-Gg: ASbGncuJ44+l2VWAZFdluPitiOF7HSCPQVONEY5HJlMGUzrluN6/z9tBPNfxiFmmVho
	qVgkKJ5r/qKWonhF50j97x6IQ11TQxhCAh7yUauye8vjMXUOXnmGYcMSQmP4ZNUsZy5BqTnJ0Iz
	gYuVcTqF4dr7ki1bzHfezz7u8xf+Z2QOpvx9zmeAkeY66ZvOn5slZOAyucjFCh9TQA8oRNVCgy6
	Xn8UAhC7fkYhT8FuPZoIzcaCmT934l2P2tuy7839Oolh8qkOBMqARW3CcW2DmwkJpfMNZ4KLlHn
	Wm50V1B8PX89WSU00u2SH+BX8Y+TSwm9Thc0R7uGeG+FO3Gmw/oTnNqxoi2XN6MhnJjzzDVqebO
	N434MyOtYIUl+si+xbt5Kf/TEbkSe0YKJxw4pFOPZpWV6olU=
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222149305e9.36.1760606231078;
        Thu, 16 Oct 2025 02:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQayMfbwHyZG1M7ESHO0HokLA6DuGP71NEXIAOvlVT9W48cYSOggIbCg6sBW0bsUEfsGNsg==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222148895e9.36.1760606230619;
        Thu, 16 Oct 2025 02:17:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14301785e9.5.2025.10.16.02.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:17:09 -0700 (PDT)
Message-ID: <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
Date: Thu, 16 Oct 2025 11:17:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
> 
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

I guess this change could introduce additional latency for RFC3168
notification, which sounds not good. On the flip side adding too much
AccECN logic to GRO (i.e. to allow aggregation only for AccECN enabled
flows) looks overkill.

@Eric: WDYT?

Thanks,

Paolo


