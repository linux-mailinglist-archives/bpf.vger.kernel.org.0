Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FC1A1FE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEJQyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 May 2019 12:54:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32958 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfEJQyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 May 2019 12:54:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so4323245qtf.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PgN7sGX1rYSND664NUmxJLWEQKSWJGZwIjpc7pKg3/I=;
        b=CHJmXopOWY2A/09/uAjveYDi3D8x0W3gsJS6g/nt7LLoviOewyTTfLjzmgVraXmBRL
         gRbNnje2vZNd7FC7BFW81mG9OPlaCKABFouxKI0adtTdBDZpP6g2bidbw0KJVE1e114J
         MfXDZUGM0j/rX34/HncMcYFMNmap3H9vWyAd6aPEPs0uS/+A/a7hG4hwrKCTlYWh6Baw
         H+JkYPszCvc6p9Bx5MWCx76fhdLIfBt/Bx52fxjBY9ehlcH9Sw4DBphlHNGplMyAGw1T
         5yKVH64hs52Dgw53jdsO4Fpdw8txzLvqjFQPamFmQYJNh0jyTqcSYUROh7Z0QfdfuNJz
         gDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PgN7sGX1rYSND664NUmxJLWEQKSWJGZwIjpc7pKg3/I=;
        b=LFBPKLMlWm1cUPLYgfB/cSMxwIlICe8nC5R4fhkMXjP0b6ye0/RRthEhXWkU87e8qE
         Gw3LQeDmEUQuTBjVYu8Y988cVd5N/BQQN48E8T4oythFI6q+uAefv9dSnn9sNGp8MBfA
         2NGHyLC+nMyC/8eY/Wo+It5ipQW8ounA2XobJat2DHnp6MqzrDvaaE2LVfrJJY50fTyn
         WECPD268Tc3003fyCuml2PYb73rebi7iyj85fgMJ+5p6d+3NVyBY1oJl+uxQcj/c4b3U
         TyZ2oZ2D3owwB3X82DtdF4UP/FTVLubGgypzTomO/6Rg6Yj3jDznvlv5H3vcXLr5wEP0
         2mxw==
X-Gm-Message-State: APjAAAVXgSFl/w0+JC2WRbAwxD0i26cMyeBrX6syo6kPygXQ5reP5evj
        6fTt24O9lA9c3PHYnPPyRmOciA==
X-Google-Smtp-Source: APXvYqysFzzS9tPGVKjpz6TmgwLQR7mrC2ChgrlBGYnFDUw2qxT/8K9ikHLlwoNfw2D4wLoVv/jMbQ==
X-Received: by 2002:ac8:28bc:: with SMTP id i57mr10711003qti.138.1557507247782;
        Fri, 10 May 2019 09:54:07 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k4sm2676760qki.15.2019.05.10.09.54.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 09:54:07 -0700 (PDT)
Date:   Fri, 10 May 2019 09:53:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH v4 1/4] bpf: tls, implement unhash to avoid
 transition out of ESTABLISHED
Message-ID: <20190510095352.59418a64@cakuba.netronome.com>
In-Reply-To: <155746426913.20677.2783358822817593806.stgit@john-XPS-13-9360>
References: <155746412544.20677.8888193135689886027.stgit@john-XPS-13-9360>
        <155746426913.20677.2783358822817593806.stgit@john-XPS-13-9360>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 09 May 2019 21:57:49 -0700, John Fastabend wrote:
>  #ifdef CONFIG_TLS_DEVICE
>  	if (ctx->rx_conf == TLS_HW)
>  		tls_device_offload_cleanup_rx(sk);
> -
> -	if (ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW) {
> -#else
> -	{
>  #endif
> +
> +	if (ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW)

Did you try to build without CONFIG_TLS_DEVICE?

I think someone spent too much time in Verilog land and decided 
it's a good idea to hide enum values under an ifdef:

$ git grep -C4 TLS_HW,
include/net/tls.h-enum {
include/net/tls.h-      TLS_BASE,
include/net/tls.h-      TLS_SW,
include/net/tls.h-#ifdef CONFIG_TLS_DEVICE
include/net/tls.h:      TLS_HW,
include/net/tls.h-#endif
include/net/tls.h-      TLS_HW_RECORD,
include/net/tls.h-      TLS_NUM_CONFIG,
include/net/tls.h-};

:(

> +		return true;
> +	return false;
> +}
