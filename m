Return-Path: <bpf+bounces-29173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A78C1060
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A70D1C22A5D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20291527B5;
	Thu,  9 May 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFF3xVA2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A21272A8;
	Thu,  9 May 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261403; cv=none; b=nii++1oYT75O58Y2+aj/4Bg1gL5Z/WYZSyPQCFjiE7yWpd+kFawgomTfZyX9uwp7Zi31nNOSUNwttEHtaHyTDdjWz4LVcf92fp6YTWyKi4piqPaTuQCj6NuVMRK+zDvUHEnCMLFd/sKVwjAf9aYNOq9canaDIhXUHREcICG8EAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261403; c=relaxed/simple;
	bh=Vqluo3CoEl0yjpeMMYMVlJn59yph0GEYTkGYgj/VXAg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ljnyKYGtfyMefbFVKlhzPCgOh/ss/Ort9GSz8JDICS0AjPxRg6jhvJADt9v5t+CmHmJSQAcb2XV760JzJhS65KYW0BOOgARAsznVCYcrJId3Wo32SbUmGvq0pgBDrSFBqBP6lmlKxASZjrW9MiCAdy1TOlp/IaLR2HK9Aa47Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFF3xVA2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b8d989e4so60969885a.2;
        Thu, 09 May 2024 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715261401; x=1715866201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELRiPzSaiwBksf6U0zKzkjH8xyzzGxI12XOql1C3goM=;
        b=lFF3xVA2EWnoha8f6ODTFylP6Bu4MiUDRGAeAXLl1zMoZBtRybFaylKVaijy5j8IQt
         vxaZi/X8How+W8wANNqXM8/x+5n1mCnXCYl5O65+IHlyOX9Bfd5RFA4xR5DTH4mN8oND
         hIZwyE43T7aBBldCckGUXOXCJfBbP/rFC+jbcv2W2q9IqlNgBQoqrmeggEDotsF69pDa
         T6Xts02cz5YAXlD9cPoR6dWRgiyAjue63LmA5nnYhL2Fx3oSB1k5ZN1BFEFyraXLNwbA
         AcNSrz7WIk2D3ftnem9PyjnSZaM9t5RZeBWBN7im45I9jYjFaFjomrWpyxR9E5oMB3wF
         y9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261401; x=1715866201;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELRiPzSaiwBksf6U0zKzkjH8xyzzGxI12XOql1C3goM=;
        b=uaU2fzndbg8KTmwaCPNNZQI4CO0wsRMSCOt7CIDkRMZePr0W63gpQ0up5IF0QON9ne
         GMTgZnlzQY2JzFYoRHo4RNJbuNtkVCdgeJzyB3xIeDDLnrJOPyAYeNjHHWOmZz+Yjnxj
         xoCTsOBzx8Dpp1A86Qbhhq5guRSsdZ1Aob9da6pPcHTDaFoorH8u/rfOb9jWtYJ5Pnf1
         kvxyT6hepNEc7BH49wVpRD8Pep/hVCcIZu+sieUPgbn4SRBgrjJAA7G/Tkroy3kRchxh
         127OucoTxjoUnN+6O6oSaGiVswHpVUH6HFnmbh28K72YmatCjzLndhAWiQu+mvyzuW8r
         LvzA==
X-Forwarded-Encrypted: i=1; AJvYcCVeHjTE16+nWVqWbcfzWW4x4FpZLZFRZHxXOh8Lwmqf7wkbGXNrcsZF20Wei1HDYNuVcC1GRxvlCOIoVtjW7+00ChXg7B2L727U2cq1dEoR1JBr4rtPO86VAq7xMsBEdMthorGNTzAqXNR/XP6s6jzeJ26AzhJvWtIA
X-Gm-Message-State: AOJu0Yww180FRwGfCiCooNj3zPTZWhshgtC+gZDtq1X8zNO554qhbhNO
	ih7rx1Um9CQbkvyhzYBuAc8yPIIWElf/jhoFYsGiTBlSrh19gDfE
X-Google-Smtp-Source: AGHT+IGR8QNz4Hr5GnYcPQ/hhmSvnn69uxTLGwX8KFiGnexA4jkVhDNdTatkSydDCIFPLPZqVBRsyg==
X-Received: by 2002:a05:6214:2581:b0:6a1:4580:9555 with SMTP id 6a1803df08f44-6a1514374bemr63898186d6.16.1715261400783;
        Thu, 09 May 2024 06:30:00 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d7040sm6828186d6.107.2024.05.09.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:30:00 -0700 (PDT)
Date: Thu, 09 May 2024 09:29:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <663ccfd7bc17d_12691429452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240508215842.2449798-2-quic_abchauha@quicinc.com>
References: <20240508215842.2449798-1-quic_abchauha@quicinc.com>
 <20240508215842.2449798-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v7 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based on enum defined
> in this commit.
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts tstamp_type to distinguish between mono and real time.
> 
> Also skb_set_delivery_type_by_clockid is a new function which accepts
> clockid to determine the tstamp_type.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

