Return-Path: <bpf+bounces-46131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC09E4DF7
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E621680D6
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06D1A8F77;
	Thu,  5 Dec 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0hwx7CZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A519D062
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382437; cv=none; b=rZKb1+F5Ru7kuBX5eAtcAsvAj5mutJ5L4lzUf2xIEEe5ScFdwe9882NmrW+XvdOp0JcL4O1lX6ZPQ2v4G04XeM28MXEbnRJ+W6EIfabmdjf7uqEuNuFoZuC4pohauQ8Mbziwkbvyp3GHY2U/dx63b5asbk0GiXR45Qwmw5eNpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382437; c=relaxed/simple;
	bh=Kl6HsgQctyt2rdur8ZJtX/2K/egEmXkE4LXfmhmDlGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agh25g2ruiGMt7OayQ/+2Iw7EDc/7T9w2TwViFx3ioHiUusgCe1x0sTvFIDGiA/gbeInE567OwB44jm/SU9k+Pwa1TzJJpo3K/z4HZaN5ntQVcVCfdnHv6zfzfVxhXW+jPSpLn6uUJJAXehsqyDzS4SGUoL6rHTnO/KFADQLz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0hwx7CZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733382434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIlUHOSRKSIeBx1KVH3cLJABAeJijyq34BeBAY+BX6k=;
	b=F0hwx7CZQGjCkAo/yzpuhgPc6/xb5c2Ebi3eKUAwbvqdndolVlgcVsgBbBl9dIbZ4MfhsX
	ei+UY1xkCdedEWtayrc4rc5N/lxacu8bEp/Giy3Sc6mzc39JkRqS77PjAzKtMCSLnVyKq2
	1QByYTesb0F2BXUkRBSYkJPChHrqF8M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Gw7QW1_BORmNaTNMKf_mnw-1; Thu, 05 Dec 2024 02:07:12 -0500
X-MC-Unique: Gw7QW1_BORmNaTNMKf_mnw-1
X-Mimecast-MFC-AGG-ID: Gw7QW1_BORmNaTNMKf_mnw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa525192412so54082266b.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 23:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382431; x=1733987231;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIlUHOSRKSIeBx1KVH3cLJABAeJijyq34BeBAY+BX6k=;
        b=bqPJvehMmYJv/dCAQkXbDaI0i5TKlWS2EHUX/hDSzASiboVdlvgS3nc5312ITwlT2c
         5C3F4WPsBsTY5g1tHCa0pKp4jAC+JntNddGU+iRdb11yWCiv4VT4zJCP6K5S8t0exM4V
         b0JUb9s9XgrHrODevldSXuR/4Cl95P5gqN5CdxiXEK77mwahCiBOZngJntKBzDhJ2HmQ
         9uz/TES4oZX9ym3H9ADaqlnvjDb+CXOIgeOQhfTTmBZ4eh3IPnAJvo2Hs4TTnAPvYnWx
         XwEomJxy1WY8djzV49NdR25Qyi3ofkGfpERqrdYU3if8DOlvJEWqFYBJWPeP4nWgyJsY
         sglA==
X-Forwarded-Encrypted: i=1; AJvYcCVc5sJiSCOj/dTdLVU1czfU4/zztLi0tktMqvhn3vyz34wmuka3iN/vmoUkUy5H3vJITDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTu7dWHBuoVsoHv40F4AdVIy3FJA26a3jxBUhEL3XGmtnZAFgA
	n7fSge9D7O199WJyMFiB1QRBELIKXSKJAllYAOJ73QzqOOlhh/pxjq1WpZ0QJiTvei3YbOCZwnr
	oQzdnlci0a3AX+8PtvR4NmpKceLfXIHyUIr+l0aQWl6OLdCOC
X-Gm-Gg: ASbGnctrEp0PW1G5rsRnLnekhpIreUmDUhEndWl1eL3cFq3yf+u3s6B8mwCGano7tjn
	Qj8n8AHPnmfOTh2U3l9CCwAP2deqbfmJwZN7PluEqVcu+fMRk0CgYPUvSDNc8upEY8kK+TZ5IFk
	ahkvJ/QUme6q9BM5OXhQOTBk6LI+gqz8cF2JnNhWlJdBHzjE8JNOVhBL6HCU7ihXP1VrHBxkjXK
	KEhV2s76nPF/hZscawJcH1AGMKEwbU9mbIwUfsaBI5z8V8oYOZMx5ul0ME1EgmYwZPXqjzyDQwe
	GetdNLmp
X-Received: by 2002:a17:906:2931:b0:aa5:b54:7549 with SMTP id a640c23a62f3a-aa5f7dc9013mr618994666b.34.1733382431162;
        Wed, 04 Dec 2024 23:07:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDfSYvrco8iFPmdIa5N0bPaEVYtA3msRfhL4TfzhO0Kwo5KXHZgxXAzBdIpgETp61pc4TMVA==
X-Received: by 2002:a17:906:2931:b0:aa5:b54:7549 with SMTP id a640c23a62f3a-aa5f7dc9013mr618992766b.34.1733382430807;
        Wed, 04 Dec 2024 23:07:10 -0800 (PST)
Received: from [192.168.0.101] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601c22dsm50951466b.132.2024.12.04.23.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 23:07:10 -0800 (PST)
Message-ID: <239dadcd-30d5-46a2-a80d-ef184add6b11@redhat.com>
Date: Thu, 5 Dec 2024 08:07:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: pass TPROGS_USER_CFLAGS to libbpf
 makefile
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev
References: <20241204173416.142240-1-eddyz87@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20241204173416.142240-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 18:34, Eduard Zingerman wrote:
> Before commit [1], the value of a variable TPROGS_USER_CFLAGS was
> passed to libbpf make command as a part of EXTRA_CFLAGS.
> This commit makes sure that the value of TPROGS_USER_CFLAGS is still
> passed to libbpf make command, in order to maintain backwards build
> scripts compatibility.
> 
> [1] commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")
> 
> Fixes: 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")
> Suggested-by: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks! Works as expected.

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 96a05e70ace3..dd9944a97b7e 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -123,7 +123,7 @@ always-y += ibumad_kern.o
>  always-y += hbm_out_kern.o
>  always-y += hbm_edt_kern.o
>  
> -TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
> +COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)
>  TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
>  
>  ifeq ($(ARCH), arm)


