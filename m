Return-Path: <bpf+bounces-68260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C447B5579F
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4F65C1E2D
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B672D24B6;
	Fri, 12 Sep 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCOTAc8S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1E54758
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708958; cv=none; b=Zb7FFOF/pXycw7EoySyC/aasCMDX14WQqxEnznkPZmr2BmMY/9CJXKerXriytVuwxHn5+JWqWAqwyK++lwoW8WcSGM/QeTinUDqpB8K7e/5/vqesdzfziRpUx9Rj0kUni2Gl+/UX7DJpEJhMQkkfVM7cTem+lLQHeLM49ZZadnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708958; c=relaxed/simple;
	bh=ig+75oh0gcE36/Jn7KdHD0WbkLoPuEorVfB6jtx/TkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mou0KPqizW6K32tZL2WFhfTCokL5OIGusjvnSLvQmKCyNk++g/ZTkYkg8+RVZeiClFC0u+hmV7dd0GPHMiZg83jHVSqwxNWuVFpdgAs0RJzmrIf0f7XEqCgAO/4LUd269LF73GsZMlbtPmuTDgaRbwTkasahTKjc4XZyx+ve5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCOTAc8S; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f581aeso24168765ad.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757708956; x=1758313756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n5hGVlmrXdeXio8Tx5JWPGOjnWVAQcGyTsRhYLQ3TDA=;
        b=SCOTAc8SUVyF7pSnbLGLG1JCTpTZVzg45/aDU5ZDCTNMYoUqWUHh+gerhevp0k6dME
         FKc6dmwOcF8k6+GCEBINp9e0aoqqI7BjJJlP285oxs0KsIFN19McvzL8qJL1ZsQm+DLo
         Tq+Xe/O81zsRvzvr8QcFlwyWpg3hNVbtjkDGIqMG7ZhAivpc9uMombQnt6P6JLGeNAIv
         LIMG+H8UgaRhIavtUdE2RGCpF8zEaU/x8bhX5F0QFOW/d2UIDF2FPb6UIIK7TvXddN3D
         MKfvO5Eoteex6etnIm67x2tBW4oFBdgGLeO6CKfl5YqVM+7P2lA8rX/CnAGi4Ni3y81L
         JReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757708956; x=1758313756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5hGVlmrXdeXio8Tx5JWPGOjnWVAQcGyTsRhYLQ3TDA=;
        b=S4WjFHdcF+oOD9ra8IZG8SLjWts7LQVKBMSU4kyPjjcmgTCEgf68U8I7Il2bBbwvyC
         CcOxSN1RW5VUlIfb1jnCWK/1snKy4BiHqxWRv8dNOM+SDu8MpDI2ZNup088bP4Z8zW3M
         eycPX7dmCkrf/D1/e5B2E7hs/tdYaK1PWpD/g/79KytQwiv/vi9tSDozmzqMS+k7nzT8
         +CH9EPzLm3eFzuTsd4TI9ok8BZCvZyop83RmUiLRd8SpFSTx6tztA8Ulb9jrnWVtjsQY
         fl/mq330ANVMH8Ofi9g9PMC88IkacjZ7a3YtXTmRWF0716HOAJ+vkjrT278lg90aGO2U
         Zk0w==
X-Forwarded-Encrypted: i=1; AJvYcCXA4ORPFP7rPe21ag85s5qtGrsIXQDWv3QNh2v5Quyg0x3sLLoWiB5C7M3aFX359xNWkac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoK0MjfXDmRCu9Iq5AQ8nTR5nIeii8UkUVuLedWu50s79hI5w5
	gwqh8XjEQvYxZeSPQtRM/YnaTVXrkgge4U4GyBNdpl3FTjsrfIgQF58=
X-Gm-Gg: ASbGncvRdDza6xmaEpy3juUQjdlc42ddC9uKT/d8LBbG8QtFgOv+ITWVCfIy/TauVIh
	y5Y6Oi4XI09HVWgi5dmRl+BJZxXd7+8eQ57UDBmL/Fpl4dkiRS1bhj8tRUTCjlkyRjrOeJeAfS6
	tvyrmHyvVCKQWIFe8QAiVL1+65k2HAGzpBJunSawYPG7eWvT3EXixTxYuqqwIRM8Otxk7iuqi54
	DAjD1VKE445m/7ZH4mdqnyoVQtQ0RFlawcrZE/rh1e10YaSpkZxeqEyuz3ME9+FNj6zn5plj58/
	fJK4hl9ohzebJb6TFlcEj3jT4wMf+iis0fE5V6aqqoFkTBriKFpfuW8SowQcuiSI91IHY48DeqQ
	ABuREjr3xNHW/VajVgsHGq3RdMbmgLW9t9uHGG+OSXEn9CP6k0RUkJkNzOLflhVuYzpAbsgkdlR
	SQZExlNBZIqT8u1J9MRqI4wxtveT/AhxcZ1znzexKiO9PfR0JlnF1Rxs5T4lYO3OkS1KpyZhxMq
	D3vmuvF86ikW8M=
X-Google-Smtp-Source: AGHT+IE5E029ZvTMIB7+BwmZTsd0bNjKLBkB1UNmmRztGtGuddSZ2DcTmo3AVdH1yOM1Pj1j7DA19w==
X-Received: by 2002:a17:903:46c3:b0:244:6a96:6912 with SMTP id d9443c01a7336-25d248c9d3emr46478005ad.20.1757708956187;
        Fri, 12 Sep 2025 13:29:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c3a84a5d6sm58975235ad.93.2025.09.12.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:29:15 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:29:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tobias =?utf-8?B?QsO2aG0=?= <tobias.boehm@hetzner-cloud.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Subject: Re: [BUG?] bpf_skb_net_shrink does not unset encapsulation flag
Message-ID: <aMSCm_t9g0WSyB8k@mini-arch>
References: <4bfab93d-f1ce-4aa7-82fe-16972b47972c@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bfab93d-f1ce-4aa7-82fe-16972b47972c@hetzner-cloud.de>

On 09/10, Tobias Böhm wrote:
> Hi,
> 
> when decapsulating VXLAN packets with bpf_skb_adjust_room and redirecting to
> a tap device I observed unexpected segmentation.
> 
> In my setup there is a sched_cls program attached at the ingress path of a
> physical NIC with GRO enabled. Packets are redirected either directly for
> plain traffic, or decapsulated beforehand in case of VXLAN. Decapsulation is
> done by bpf_skb_adjust_room with BPF_F_ADJ_ROOM_DECAP_L3_IPV4.
> 
> For both kinds of traffic GRO on the physical NIC works as expected
> resulting in merged packets.
> 
> Large non-decapsulated packets are transmitted directly on the tap interface
> as expected. But surprisingly, decapsulated packets are being segmented
> again before transmission.
> 
> When analyzing and comparing the call chains I observed that
> netif_skb_features returns different values for the different kind of
> traffic.
> 
> The tap devices have the following features set:
> 
>     dev->features        =   0x1558c9
>     dev->hw_enc_features = 0x10000001
> 
> For the non-decapsulated traffic netif_skb_features returns 0x1558c9 but for
> the decapsulated traffic it returns 0x1. This is same value as the result of
> "dev->features & dev->hw_enc_features".
> 
> In netif_skb_features this operation effectively happens in case
> skb->encapsulation is set. Inspecting the skb in both cases showed that in
> case of decapsulation the skb->encapsulation flag was indeed still set.
> 
> I wonder if there is a reason that the skb->encapsulation flag is not unset
> in bpf_skb_net_shrink when BPF_F_ADJ_ROOM_DECAP_* flags are present? Since
> skb->encapsulation is set in bpf_skb_net_grow when adding space for
> encapsulation my expectation would be that the flag is also unset when doing
> the opposite operation.

+ Willem and netdev for visibility.

