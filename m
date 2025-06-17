Return-Path: <bpf+bounces-60788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CFAADBE78
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 03:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77963B1027
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475261B040B;
	Tue, 17 Jun 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpwsPJFT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9115B0EC;
	Tue, 17 Jun 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122694; cv=none; b=ZPArqeDPURRnOY471mmjsy2yLRftdhu9oo/aGtnVO8Pqyiu4tww/XHyq/5T0S2UndGAFZGxLnP2HS6iIGpx+PI9s8dWzKLg7haxw3TIoI6OktUzjsLr9I+Hy6ME4JYNTaAAP9dSQ9+dQNfEl8iuxxJgE4rGxAnN3XZ8IOwxyfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122694; c=relaxed/simple;
	bh=VDirG6A/g/TEdXqnGoFj1/CsBbPQO6xAuFa27Ep85Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGMlSLqByEIaSm+BKGFfLEurd0d+3+ebN1z3vCzoyp1UrRyH9iePJAn4Xu9p88q456K5koPCJ/j3yMmMkJUQmi+EO4QvsaSU9Exge7WABcC6Oh/+XHCqt86QcvZDL2THIrWuPTI254Ty1zD8ZemqlTtUBWmweXIBa8XBrgmsKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpwsPJFT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3134c67a173so6029266a91.1;
        Mon, 16 Jun 2025 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750122692; x=1750727492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBe6mnVPEoty7chluPQ6x86Gyik+l7YUJhx9KWhanMU=;
        b=mpwsPJFTfjC2wk7nzDfELHuZnOJZKOtzCWApNPRYq6osnXFnAZlUHOlqyMaWXZXP7E
         T4A90ksE4OTBOY4Z7uFo7ZcJh7w3h3ikBrl11ssYIy/IOjSEZyQ6qZGBNAkiAJ5XPQEc
         YC44kVM12v9sfjcHFX3IfzuAOUMZYo9HuvtO7KGsggg4W+eJXRWXCROavB/5En2/SMZa
         8TunDxPOzM5NhFKQQ0ZvfxiW/LWSuZNv9xTOJTCF6p2dn9CWLD93p+hEc4VD9sosoutZ
         aPpBf5tAzR0H31+jrnV9iz7mEgpkMXrWkaX7cZ3x0NLQIkHnWwS0LgfdmQ3TR48DnJpJ
         JHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750122692; x=1750727492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBe6mnVPEoty7chluPQ6x86Gyik+l7YUJhx9KWhanMU=;
        b=emNFYSsLfBW0SCL/wSr5CBdQDUZ+tkfBI19uOPWiQIdlQE0OMoi3wRc5ukGCwqN1az
         n2dbSfcdyFeiowOfNFMKknjhBtk1hnEdea/5SG0iJkPN89RoQTezCkHIJyW401cNJ3GK
         aQWiNXmhhlTmu4BoUI97fz5h/hBLRXEOGHEd8+8dUGDdkaSwcbq5VBLXN7Wskq7H2Lm0
         e4DU4d8HBEK2G9Ik3GwdAP7/23cCMYoqQxdPbQSORC+GXO1DpDKw3Cqw7hrKxyPvBfzJ
         5DbWO0bemmvbpQY4A0+t5D1O9ObsKtidoTa7iYfHiaoulZgSSzuxLgI903v5j0BMxQm1
         G0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXOWETUQZZCKohg+uaS0rEhsPolAVOMPPtF0yQU98/D8KgaKUK7t+YMlbeXDraXK4SyhrPRVOZ8@vger.kernel.org, AJvYcCXaWACI6US7Yz/G/kEl/D+cUK48KtceZS9BF7laSWRJlDuupfqAj+ONVZEGjqu8EFNwiDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IyTeoGZvNspekHLRjN28RlgCjGQXbBBndcZARkRRE98a/I+P
	P8X7DOXBO7sDwnA//vEvedwwMPgS6VkIwi42kbYKujHOrJESOudaEPA=
X-Gm-Gg: ASbGnctr9l8Nd5EVNqxRt9Z4yQNpcReA3ewfJ+T3+xe+KzcdPFV/zvocV9Dm8qPExBK
	J8RHfgONw/Ll08LGoY4HwTJkGDuwq8Qw1+S13B8Zn3/5MYOtoaRuM5cww0LjouKsFhepUuorM5+
	LXVlJG1tD1uhjlGW5dDXKL/6b5zXVmlxXDgvrhdoL1A8CC9E4AKSLn2d2iTGioykTaitHnfnhrd
	7RTxakHxrZvifX/X3WO7AqPFaNJ8PlBQX3z6kfEDy5ip7U5P1E5Ode4RjyKtLcnsl4n0h8n1LvO
	wVar/SGwTLNIDPKVCCJraMo7avQ/vag5hTtMxhw7lXfn2jajj1jquBriPSUR8klpr49W2bkuYg2
	e8KrYhH48ga6oXmJKw3lDNVw=
X-Google-Smtp-Source: AGHT+IFzPQDRIGM5kXz/uPr8WOIkUly3GXBqmdKT7BP8Ta0SSrkDREhdVM/Lq840MeRMt3Hk/BFdAg==
X-Received: by 2002:a17:90b:3a4b:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-313f1cd6841mr15161613a91.22.1750122692422;
        Mon, 16 Jun 2025 18:11:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c1bcbb6dsm9395479a91.6.2025.06.16.18.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 18:11:32 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:11:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Message-ID: <aFDAwydw5HrCXAjd@mini-arch>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617002236.30557-1-kerneljasonxing@gmail.com>

On 06/17, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introduce a control method in the xsk path to let users have the chance
> to tune it manually.

Can you expand more on why the defaults don't work for you?

Also, can we put these settings into the socket instead of (global/ns)
sysctl?

