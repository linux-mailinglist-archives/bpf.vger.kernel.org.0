Return-Path: <bpf+bounces-75057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2402C6E0B2
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 995ED386ACC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E96334DB62;
	Wed, 19 Nov 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJtshzyH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDWdNlvm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6A33CE8C
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549014; cv=none; b=KTPDR1Gze4Fbgd1BlpnhHDQxMs5uXHpQrOf9X1p7K5M7IgXasRPRfR6tGbbq2drULov0VX40ME1QYifpnXqDqdhGq0GUcy+ncZjY/2TnYR6BxnXJ+GUh3oHD5ReUoaTQS8GwpUC7wU9ZBaIqQwIddOvF7YebVV11HCPU8+DyohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549014; c=relaxed/simple;
	bh=ls8bqSOh5paIrQgIWm7KUHizx2alUb9qbX99d7lJac0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cxnLDXvLk9gcZQSENjuix4KRLPTyrhS58FR+sD/1YdrD+vW+AlTz6mBaeRavT1MlxllKf821YhV8jSwe8bzprpBbHMTO0SJMbFJoUrPTOaPlBsxATyy9l6KFOwpJ3kwv3aBnu0YAZbza0bSfQax/7EKzrMl5+xv2HFfwgTnf5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJtshzyH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDWdNlvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763549012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
	b=jJtshzyHlvYV2u7iuNHsFVIgkUSKspgrv4R7eAFKsd/ZJ19hJHYqoxoPNXD3PwSJO7bWGT
	2wxA7rbHHx7uYCULBz05E8Zg/WgMdh2j8lybwSRElJzshPzgGcB5N/XSO3fMEVv58hS5ii
	yOZkltNURFgUbcOhCmKnAMUep3WadW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-K8MoftTNNsSbHr-wPeJaqA-1; Wed, 19 Nov 2025 05:43:31 -0500
X-MC-Unique: K8MoftTNNsSbHr-wPeJaqA-1
X-Mimecast-MFC-AGG-ID: K8MoftTNNsSbHr-wPeJaqA_1763549010
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so19200605e9.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763549010; x=1764153810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
        b=MDWdNlvmNcMCm6tkIH8gZ1l9VyeGCELkkCc2LcZeimoUE+EnfG5psKehsmCdxTYX2W
         u6ZIhESbsLBatUE8ZKRF1JI7Zz+HIYEr5+20ekO1pP+Sh+xCZEKrL/lOE4JjBY3ixBNO
         Y4bZuwzB2jKaHdkecrD+U+w4OjmeIwPe6Z7pRJBjHJVJXRtFsbcRixwRnQDkQPlM0C7o
         938zFN41HVChgML+i498njELwKPrgDsdQHPWIYBUFEJhkQ90LeHG2+xnQW5oqR4uuKlI
         s0wwysd3DFboZMQ465CZcv5wlXmeIKCArYwHX8Pshoht5Hz3BHQGOxx5n2unajCGoejc
         8y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763549010; x=1764153810;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
        b=KwH6id9gIpYP7TxVJLYqWSJTGXApPRE7hwQ9Aktdpr/kZEWj+pSx62FP2nHXxCNnpr
         LQ40qgztPFLzV+zPQrUCbJV9FauG2rj9NqzRhOtsM8V9SySYHfD/gIU8QRWaRrHHY2w2
         iagZ6LhvpLt7xe6A7nsRrDVqZF/4fb1odUJH6u4JRfolPHMa1tQb6pI0PI0TLbhIT09M
         6k073QEk3l4R45XruIbEjZAKkAf3/svFTy7LW006LXxBOpOqHt5OUxVa4MZlF/e4fwdj
         CCtvlS6YM59Kk66eq6Mb1umeLL4MVuiDJxe739Vu44mDke4jzim4/OiLBeO7SmGIoypq
         frMw==
X-Forwarded-Encrypted: i=1; AJvYcCXV4zrmEz8xXx2X+HEdWjB56Sw3mK3gViatlTesHUi6pQyvvoVNuC/3+wdpLnO9vzgZ0n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPSfkDcBnxb3gTg3tby22/dYBLwCh7iv5DbllJfS92P+ESxA8
	6gG6E2n2BUPJ4rmYU/Fkmn4F8wmo8/n+nvou2uG9HnzjD1OYVmo5CfDTxRsl3t9dR63YRy1MrC1
	LFjTuEp27QWqmzAsu1QCRvF1vPwQZy57tNm9JJ8MFnXleJ8ZJh9/UWQ==
X-Gm-Gg: ASbGncunmyCTcoWfYS22GujE3QlSv2a9tbBtKtKv2yCxltuVBL7vUFvDl4LDGw04IZp
	p14rgD+O64BQ/m//JWbjqDSiueqqOFnEOG5vCJfFvtN7S4RZLGzb4T224Wu/Q/akGLmDYLQR1wm
	DjfrK1vK2LjjM4jaoi5AdDjeWrB0d40Q5YHSomwJh8z/Jno9vIrfFHP53dx8J8ah/qMb0v7vVrh
	vOgVvzixEcH4BtKjHma7q5yfdw5CkmSujOYI7kVg+dCvPoQc3qY5Xo1S1gkV7NM7yP6Ujcj1cXv
	MFALJcLankTnhLB6nMZQDT09in6eNWFzEjLLB2Hx+r/avLZP2fqhJzaqYqJlkQDgQTETu3KXFhV
	43hXIJbzcVoVo
X-Received: by 2002:a05:600c:c4b8:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477b198b88bmr18033265e9.10.1763549009790;
        Wed, 19 Nov 2025 02:43:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9VgMfr9TLL8O8BdB9euFkQ+122gpF3n9fR5oFdXmPTT7jiqyq2kRGJT8397RGEwGwHWuazw==
X-Received: by 2002:a05:600c:c4b8:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477b198b88bmr18032805e9.10.1763549009317;
        Wed, 19 Nov 2025 02:43:29 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1041defsm39874685e9.15.2025.11.19.02.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 02:43:28 -0800 (PST)
Message-ID: <da8a7137-dba2-46be-b528-6806b11204db@redhat.com>
Date: Wed, 19 Nov 2025 11:43:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
From: Paolo Abeni <pabeni@redhat.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Content-Language: en-US
In-Reply-To: <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:40 AM, Paolo Abeni wrote:
> On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
>> I was thinking to totally remove ECN from Rx path, 
> 
> ??? do you mean you intend to remove the existing virtio_net ECN
> support? I guess/hope I misread the above.
> 
> Note that removing features from virtio_net is an extreme pain at best,
> and more probably simply impossible - see the UFO removal history.
> 
> Please clarify, thanks!

Note that my comment on this patch is focusing only on clarity: you are
updating a comment for such goal: the new comment need to be clear and
consistent. The proposed text was not; a better/more consistent one will
be ok for me.

Thanks,

Paolo


