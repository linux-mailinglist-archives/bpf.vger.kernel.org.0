Return-Path: <bpf+bounces-71892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2CC008C4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 705754F4E6E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC740309DDB;
	Thu, 23 Oct 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoIEKFsf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC32DEA9D
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216194; cv=none; b=hTaQ2KHujmRIcz9XVTqUCDeW3zzz7RT84VhFq0L+UeBrVhEHCjD/3RgQdzW5LhBuc7t8MkBTbfkOebbXFweAJICekWnp/Fym92AwAcMonQXn7VpdP8iqGkmr1RKiyMUbYV9aUvtkbvbmctG0stFf5cXE3ZqS74X3aCuo1/CHjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216194; c=relaxed/simple;
	bh=PSq4rzHsTZYmnPW7B8CFsP6cGQe5nHJwDQGMbKTQhlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ztb6Y66jZzTMCJQAa2a8TovD9+C5yfGY7IOJqjkXNaI9kBOmwjSItT0/oUKFEHnv1fhcR0cvVlMYUHdi/uIlHU1N3/3FyU0h3Hk2chpd6OkxRK/ZMTVPpWRD9vSZAJ9uC++EJwy9kO25MPTeKGfEhvcpjlww2SI4hdC5f9rACGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoIEKFsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
	b=OoIEKFsfd+wa7B+3LKuT7Q0VDVLEau24H/nFiTTaihE2RSoFazJwaS6triRv7xv7Oc/TZO
	U2daQW1JguY6pXSTfmXJ5DOkurcHrTfb9rkLxPECpIsd9fJIwJwstMKeFx59SDbQH//3Fp
	kvHWhVLZ/AcWrTw4kt+sln/4kutVJgk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-4Iv4Z0vdO7KOE_HIONuRkg-1; Thu, 23 Oct 2025 06:43:09 -0400
X-MC-Unique: 4Iv4Z0vdO7KOE_HIONuRkg-1
X-Mimecast-MFC-AGG-ID: 4Iv4Z0vdO7KOE_HIONuRkg_1761216189
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114d373d5so5208115e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216188; x=1761820988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
        b=r7uUchd2U4uujaebm3DSQkkg3D37Vl0mAbRiYnatvqAiXUFXrjC2Fnw7YUvwb8VmGE
         lWyXUr0bCWPVeQsTZoc1paXy6d5cq9X2rm1QzY/tJnoW54aJnDfBGjkSWCggYigwHEwD
         5AMQjQ52bb0PtK0JYFvv9YP6h8yEYWUC9tQwxZmmc9E48uXtMtSn3qAvgqhSzENnVvyH
         hTIIrEmur/fWjnXnH+J0VFEkH0qZNedoRXLd+3V/Q3aC7vAz1kVzP595jrz14ZBvE7XO
         0CWYHyzvx+OccX3gpZ6J7s40gYIk80jCTkU1rOxXBUZVpPU7PQtJ1oCkGtGaMFrO7xEj
         pRhg==
X-Forwarded-Encrypted: i=1; AJvYcCUeXbh7Fv10UvinBQwtMEQWi24hZaIx2iUYC6nl84Ud0A6yIoKfuHF3o0PSquAxgY2bUvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUMeOOwgAyFJyoFeLGGYOTGfyp6DXysbeRzadnYwa1AWdg4i3
	aCd9LQmVvt9xdGqGxiva77PD/I0hSriqIPJ7NqMHyDAuiqPDtKRO6OOVdlNEGx2kdriHnWScXdl
	hBYMfYWthlCtMRYZ9GQXqj1FfmuZ2YzP22aK3sNXgbr2Naa5Ar077tQ==
X-Gm-Gg: ASbGnctbTyPA2TzP6TpDSjlviu3iMocxQNg4LsP/EqqQ9Dn4IVXyWUiAn1QPtEHvGXO
	YCnmX2VDwAD7Q+UWjDbBpL5iQzmC06kdD/nUPhq6/DBs2bzWziLHtwdK8snS0mT72M75h/5wjI1
	fX4SL6Kplu65zqVw5Q3FdSuPJ2RMA7QrS1JzncWSFHctuqkSRnwN7HCKhLuV1XlmG9LEmgVBPiQ
	oCGqsciwUyGuVp7i4CbNFxtOAF7uKJYIrlTT6sAZm2sUEVaVprhcmP0kOUIF9HnqazoO/TEKGmV
	N30C79LEGewdfl5jH60KNVHIAo+fGYRYx3tvOjQcFudJs7E0WdpzYtuQpGD5osCFJfuNP843MjI
	+rjly4PL32p7f5DSShEqghtc2bG7kCUiFEZ0Xfi+ZkeBcDvU=
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243744025e9.34.1761216188624;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeZ82VrSnvpK1c3qyzIXLRxmMNdmjxKL2P/cuqpRB9ovXOV8FGWqUSGpOdh0UCletrBUBh+w==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243743745e9.34.1761216188204;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm31140865e9.4.2025.10.23.03.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:43:07 -0700 (PDT)
Message-ID: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
Date: Thu, 23 Oct 2025 12:43:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

Side note: sockaddr_unspec is possibly not the optimal name, as
AF_UNSPEC has a specific meaning/semantic.

Name-wise, I think 'sockaddr_sized' would be better, but I agree with
David the struct may cause unaligned access problems.

/P


