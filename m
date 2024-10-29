Return-Path: <bpf+bounces-43383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AF9B499D
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140431F23638
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267520515A;
	Tue, 29 Oct 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vt7t35wH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C42205ACA
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204813; cv=none; b=CMBGGwtDQcHWmZ/XdqNNF8DtyAncK4o76EdsFWxZy1rj27R6ZP18Swa9uka/jHUs/rkERxDFZEOEyf6eNU73Ct9xBadfGOzWb+ZHxCwW29YE+vZ6dLNw0RMz2lVJ9sk3LESqRh0OGUwRLzdQXdEfXkb0Lac3Fb0+UWTarkhU4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204813; c=relaxed/simple;
	bh=OIiNsApqwgm71NjUFM1ADgAthsV5yL2jS8pl3Uc8ZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OMIf22hMpnD5zq042Q2yYcmG0QHyJRa+NRuYk7EHksBU1vGJ+lyNjr94iokPLxw1zFSjTvMEo+W0UpC8hKRCmstzEp17R4s0Tc27FeMuDVUkPQnELPfqDWhal7dRvxZdKtVWCamapJJZxG8GSMZ+iQjFdoubeE36GRn0oJCrOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vt7t35wH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730204810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOZTaD4SZpZxUnHx9eqNQXCMnDT5MQfWDHUrJEYUGAI=;
	b=Vt7t35wHnLgvy7vBnA8aqxcVgERbWrFMxWnwQgrGj4imxl/s9ozfpv9tsw9y0+NxYUx7Lq
	fIJtCFZK7jZeclL4HvRjU2aS02r+f4PCTY82b7zuaK3aI51tt0kZYy/QDpZBcbXA4dy8M+
	KDwyM7GSgcpB7a+g6Z6wKekYfBbDTMo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-4iM2-uMKMDWEPXYONvstSA-1; Tue, 29 Oct 2024 08:26:48 -0400
X-MC-Unique: 4iM2-uMKMDWEPXYONvstSA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4cf04be1so2545659f8f.2
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 05:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204807; x=1730809607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOZTaD4SZpZxUnHx9eqNQXCMnDT5MQfWDHUrJEYUGAI=;
        b=d/4bPJ8270xLJgoNgrrPPPxIIdoRCXssJ12dG2XZcogmO32EOZXevFoZeFbTFHKjTe
         f2NXjAT0P9cgSuiTxUuimsWMyIpaf/Xc4Wd9B7OIut8shmfv39a3n9/pdmJ5FmZT1V0G
         jbto6Pe4wiQdhlotnbiV/TdlvZefBtj/qzeKsxyFXhYf8hGA1XwyCKcxrMweYCLVX7DM
         koDQtc5z2Bnug1LvCSt9GVXuX7LfHHamw1xGM1nOdNDp+7lEvhKwBub6d4lZYRrZ4AnH
         edyJc3TdkXEgZp5Saixa2MGleShygDt/aICWqOs3V+qaRsqn49X64yEY0s+TOl3oQShM
         NdUg==
X-Forwarded-Encrypted: i=1; AJvYcCUcz2/jUZbWr4Rxtu6874cuRPjkYcUbm1fLr5tWfNkhvvO5KszI526SFol3yAPYPkxfu5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO4VtnoGhJKxGec1NQgi2jI8TWRSuPEby/8UTvf69ztSKz0rt
	zLIpfTpj2Kdt7w2MLmBwq8nFw3TPAD2qSS65unzgt8r5QSqtOztkkUgpqIhHkvoVNLqD/SZsApB
	ziQP3zpsqr3jooMUoRb4KbDPFqsfkbfGSTwBZnCAF8JcuKrFjJQ==
X-Received: by 2002:a5d:4849:0:b0:37d:4e03:635c with SMTP id ffacd0b85a97d-380611441bbmr8953985f8f.21.1730204807538;
        Tue, 29 Oct 2024 05:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7KLM8OM21izjqXfNP/B0QCUjjPNIlLTzWnqUD6a68rC1KUBMbMRh54JsB8kR9ClHY4mPX5A==
X-Received: by 2002:a5d:4849:0:b0:37d:4e03:635c with SMTP id ffacd0b85a97d-380611441bbmr8953961f8f.21.1730204807135;
        Tue, 29 Oct 2024 05:26:47 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b46bffsm12311553f8f.46.2024.10.29.05.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:26:46 -0700 (PDT)
Message-ID: <dee9769f-d86b-471f-bbe2-f0165489618c@redhat.com>
Date: Tue, 29 Oct 2024 13:26:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.

How many sysctl entries will use such value? If just one you are better
off not introducing the new sysctl value and instead using a static
constant in the tcp code.

Also this patch makes the commit message in the previous one incorrect.
Please adjust that.

Side note: on new version, you should include the changelog in the
affected patches, after a '---' separator, to help the reviewers.

Thanks,

Paolo


