Return-Path: <bpf+bounces-30489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBB8CE6B0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A6C1C220B9
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C812C49E;
	Fri, 24 May 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="fFcyELiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019E12C488
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559724; cv=none; b=f9Ey7IpAO1j9RyFnFlgf5o4X1TlumttwOU+xLOGUh/a/OE69BiTGYMpGbrtW5cf95DzGQXYt3ZMCQ6pYlGLu0PPbqWzHGyiJ5NQPeoaE/PsWXMYp6dApKyUee25nS1Yhc1KDylwysVKgyuUJq/8ZU5Tl4XdA+wOVS8ODH8sC7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559724; c=relaxed/simple;
	bh=q9tnOQooe9PI7e3SjCezUK1kAPk/OmZWIxtU+okF2KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbPtcepu59BJ7eU3lq6GCm5TMU4UkhpjCQKPCF+3x6XTE0WxP/lATaAPdR++6AOuRuRnCND+CHwZTZCXGmoji8HxWzSBZ5zqjsE6i48JbbGudP/H8HtHYtYVYV0gzqR6uo4hQGCuUuqZ0aia9V9C2DcXYh5nXvU98rxqgCgRQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=fFcyELiR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5241b49c0daso7213665e87.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1716559720; x=1717164520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99TECQ1cUmwOOxSZm3rzy2IiUVEnNv83aOFAXyx4tTo=;
        b=fFcyELiRTxN0+t0yEgV5M2CO5+epbYmMVqwZ/YtS+HK0PQvd8mBwwUzHIY2R1Hf4z4
         2regZAwF3Hk3fgjQoQIwuwI5g03F/MJOOJ88HVDVIQ4eEjIQaSJhwfS0k0o0CQaomaV5
         JxUyQmn6Qg/zHZlh0Rp5ynDzzdFlz8uCkbrqrbDhSDU7GoMD5Jz0+tXLWrVUGvJvX4GW
         ul49Ij838tg7Big/QNG6d1iFbunEAADPsixQyaIPOXec0v710dHZBg0PVzSqAbvXlBbN
         Ex0MhAZp4yzWpszqnTWNsXvAOwSbMT3bZn/NuDvjKX5qXJn0lhp8Qr85CEmV1iBtRFVS
         fssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559720; x=1717164520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99TECQ1cUmwOOxSZm3rzy2IiUVEnNv83aOFAXyx4tTo=;
        b=m5V+vGvyE3+PBlw1ILavA1yvEhbx+QJ8+PwVAM846QHn6+rukvZYGzPWJ1i06CRlWf
         MjXBam/Ax3O3+xAd2dMgmyBrkYMdJTLPUQJUOYNUlURxFwfhJKFoEyCBrbBF5YjifGw1
         K4JCmRcEW5lt3Ml6xqpekI4a7BJV8jr0R8mQAD1+06aOvuk+YRfJgdm7VbsVVIn5H4Hu
         kN410p3qiKTE2W3iyXVbrOyenzFguZHpCpTtrAZF9R5YHw7js+J/wR3sQjzGxRD+dZNj
         1sMz494tT7gQiJWZCxTXe7ZHzjFfqsVO5VymsJLyPN1PuCF5u9UYznA2WbXg2JsaCwtg
         5tkg==
X-Gm-Message-State: AOJu0Yxn2rYghAyyLlD8xQCXpPK5KQLzSoy+K+cLIlf+mKWaOrAbUtHs
	/2iWp0vMggIxQ3/x1v5SMIXpVIGXBgiTLVJBtHVdEZwL4dJE9xORJCuT9eqYhD0=
X-Google-Smtp-Source: AGHT+IHaoO84vz3MtS9f5/n7iE1AYo8TY+HFLolwK1jCye8w2lpMjpCuhp0rz68bNAVsIVjObv2MOQ==
X-Received: by 2002:a05:6512:238d:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52966bb200fmr2245358e87.53.1716559719426;
        Fri, 24 May 2024 07:08:39 -0700 (PDT)
Received: from [172.20.4.8] (92-64-183-131.biz.kpn.net. [92.64.183.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bae15sm1769721a12.86.2024.05.24.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:08:38 -0700 (PDT)
Message-ID: <39211313-38e4-400b-96cf-46fb5e82c5f0@blackwall.org>
Date: Fri, 24 May 2024 17:08:38 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/5] netkit: Fix setting mac address in l2 mode
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524130115.9854-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240524130115.9854-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 16:01, Daniel Borkmann wrote:
> When running Cilium connectivity test suite with netkit in L2 mode, we
> found that it is expected to be able to specify a custom MAC address for
> the devices, in particular, cilium-cni obtains the specified MAC address
> by querying the endpoint and sets the MAC address of the interface inside
> the Pod. Thus, fix the missing support in netkit for L2 mode.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



