Return-Path: <bpf+bounces-74306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A254C53326
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 16:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269C7562FD0
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396D33F397;
	Wed, 12 Nov 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiddHnr8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuJAD5LN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B633BBD8
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959060; cv=none; b=K0aenEDCDLvQQSA1jimslCsTZ3ssW2fXUT6sKRhKZj6FiMKMielUn+TOrCQOKINEiEhFD7mYhqbJjjtXiDkwYntA8chYlwwR+QtSvECDWndPv2/Cd5cEJ7sFZO2jP7DuiTiUH5wSfc/d8HB9AVTn2xNzz8JvYMR+odcNOO5oV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959060; c=relaxed/simple;
	bh=zMRRdX2owS8FdV/BiqPTU+IIEcG54+CqIM+8HoD1Ms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD2TP/bUTCy1WxJe7vRHDVU2Kgu9g9zSBdDx3/+WjWo5pHHK3J6inHo5OlBMepA5aAyCfuWkEdN1WchgGNDCEwDsjBM0j2k91pAPHvtwNA3lEnx6hNFHhUfRIY47XaCmHGp4PuAb4Rtd7h9GMAFpP8YfasloCrIX9ESlmLsouWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiddHnr8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuJAD5LN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762959057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
	b=BiddHnr80q5SMkcVeTbdXFjuotw0/v+2Ixhoc78agTd4ggBeqmO2zrAuUVS9c+gmeW4a7O
	0vqNMIGWz/xq8aMDsi1ygDqtBZclOjIJPztwMHKDGhemAjpNynyIgoaj4BdfcZnX0WxOEJ
	Q0GT82wpvCrzXwC51a6nCAaH+TXiCIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-S_dxge_XPduO5fGsVLJ-Tg-1; Wed, 12 Nov 2025 09:50:55 -0500
X-MC-Unique: S_dxge_XPduO5fGsVLJ-Tg-1
X-Mimecast-MFC-AGG-ID: S_dxge_XPduO5fGsVLJ-Tg_1762959055
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so413357f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762959054; x=1763563854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=VuJAD5LNRfTxWTKfLAa7aDsbHtoC/EchRMf+Q/NPebSfR5nnxJWsqZTxN2jGWKgpnm
         ONxKy7Qeb/NPfR//2ycVJjkI2qZEWFdOdiPqwvCm50n4bF3F149AyzI/bMKLawetjqpa
         KknIgVswgVn1Uu7G28tjQ/mXI0QqVRrzFhXk2HKvCdxPVS3+OfBZIb3GkZ0bgD9bicyv
         TgK/QoZvK2WPp6UHYnph8NCyrkEmpp4tgex/1YzhReW1fmFG/ZwcavXQ+kLyYTOaAPj4
         ULqTCdsbnN6OEQ4tOgoteTzRnTcFxJZZYjGc2TW20UHBsZDX/jPDuWvTYrDIzd1F9Ua2
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959054; x=1763563854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=eVQ7/28piqqQGzTZDts+MdpU4JGE9NF2W6lRUTjwgkzvVe+zW1CUDzQaeneSRT5si8
         eRI138qNHZ/VVIOObmmioPGwhJLBdYuOt6wkOMkytC2M6PSePa8L5obpU5GsjeKgWm0u
         5V2d/sUdzqiZ9cVm8c931KuaV0R9FZ3P5TwX4cmYhBUv6tnw3J65e2XwcZ9Xf3TFVTN9
         TsPfAe0DUx7DSPwUzXOE2UZs/Dvw4EubTp9Eevo0OQuQnL7O6PFhPTKDX0ggH3B1NGho
         Ps1hknAcc44gDMA31jlraBX2v47GVzLV94mdRSV5WPgIHHD2p0rsLYR4QCuq77fmaxSQ
         8Qjg==
X-Forwarded-Encrypted: i=1; AJvYcCXtd6K+4fG7QkiNlYKyLm0FMCuUkYpR1dpaqO04ThWn+PnKtEhrhsZsJ1uWH8DZDl6YPRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1dsEc51t9xCwDyuijDTL9FMuMLtnkColhhP1BA6NGSCBJj/K
	QrJ985qPPLNWQ2cz8BV0HHTzyxbzUrDyr1/CvN+XTz5J/f8aka4yI8IQ3i2vmb+4rVuFkFBdRZ2
	Jx5+JEAb3GUUO3LtJ9JtB8VJ1EwLGkV2Dm5TPhRs+UE4VrqIYuUv6og==
X-Gm-Gg: ASbGncs3jofaQx2yKMQCS3vMV8Q+59f6rNWLvI70+aL78UJgpxwj7AmfSnO/StjhRZ7
	i8KirWxkTu0EOi1br50SvW+l663h87gKazQHPGjA4R/M6OQEXTvCodfli/vQNxBqns6v5V+MbjW
	R4Ospm5mwG7qhKGgmOvYZbwORv4cw4n32cgTJmU+Zw9UtxQ8gnSapgsWXFHoyCG6mA6hTzv7Isn
	H/BvDJaEHlbSuv8IQ5EeFCqQW9QxxQTp+ogsldMQgusjqYxF7xpT8ntLb96vn/OHFarV1PfKrFX
	VzjNv06UP6x8nPEHlvAT+dV31/rTm+OoJ3+2FFIEmANIInFGXQ35SjIvwBVUcqbiuZ6Ciau0LB2
	9gg==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031628f8f.18.1762959054582;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERB5IOiGOtuJUGWUEr7UkS6m3ACPJ8/nI92NfUrVDc35tes2Rnj+8LlolGWnYHhDlrIMnvBQ==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031587f8f.18.1762959054156;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33392697f8f.35.2025.11.12.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:50:53 -0800 (PST)
Message-ID: <0944325d-158d-45a4-a1d4-d61e645b07ea@redhat.com>
Date: Wed, 12 Nov 2025 15:50:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
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
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
 <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
 <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:02 PM, Chia-Yu Chang (Nokia) wrote:
> This bit will be set by congestion control (TCP Prague, which will be submitted after AccECN patch series).
> 
> It is intended to use ECT-1 rather than ECT-0, and we were thinking this flag can be irrespective to AccECN negotiation.
> 
> Shall I put in the Prague patch series?

Yes, please!

/P


