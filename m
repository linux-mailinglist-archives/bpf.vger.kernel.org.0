Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEE204F7A
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbgFWKrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbgFWKrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:47:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28DC061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:47:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so20008274wrr.10
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nll0XgmJfyw5fc2Ngj4e//md+//4y6ZvQnLxV9tTvkI=;
        b=CAJEarQyQvdNisUs2GMNohZlLCbTuygrwMwvqEGD/QLI868cXTZDsYGb9E+mXi5+eu
         df7X0k4090B/fw+yPeuEuNFSNNwB4cTHv/OuXua2IguGNnAovcMT8tEOFmAfc8C23cyB
         4qBIeYeUEGunjqMa5BZwmqBkpg1dqLfEcOf4tEBYOk2nUwMpBrjsU52dcsMApNxONVbg
         P87H1jZWsXNEuRgIXNE34mDxQOI0aQlW8RtlQJ0NB27nk/SvBF5FgiqUvk8HgYQGuDqk
         ydSMTjVKThFd2LfXPWbTLt+eX0g2i/G/vNuShQ8iCSzGPCZxujv5ECbx09Y4MFuqW4oi
         yWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nll0XgmJfyw5fc2Ngj4e//md+//4y6ZvQnLxV9tTvkI=;
        b=CwBzeU/+dHeVaNJQh5Y2UNDD308Fs8JVZnumtP0/wEMk5tDqWd3XpULOwWTnml4KNv
         nqtXdo4ahQr/jSH4Z6VJugx3FnoNnqj6G+kAMpgmBHYOOkzOwR7qMeN/NuyldURR9aRt
         SPqqnxWNyBdnU2HxcJXRimcfIkyDSh6wMBf7QP9Hag+2hGUMbNZnpoq7vU8h0AodFxAc
         R06LndxzcqDhDW7lET+/GXWvtVpRUHUVAlXMMWVqtrhN6/p9mx4xxzwRvHi1ovlJz2Dt
         xeddvVWo8ITvyZqV05CZmyUz0iDC9Gz1EgauLW/y7PGLtNO6h0MPET266yOYAwAMHDr1
         jRng==
X-Gm-Message-State: AOAM531ere8Ku69DsAkeHRJd2M3I2zclS1Ly1sAdKvNXCWTdtyCAdMGH
        dJOtq/CoiUDTKn0HgiJVjYBEfodqIsST5A==
X-Google-Smtp-Source: ABdhPJzDSqlpOF/ZBSOuJNJryOK6EE5JMkYVlshbFz0XOPK7MrrhPSibnCC/BR65JKtOcnrbFRq5RQ==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr21936937wrp.268.1592909250294;
        Tue, 23 Jun 2020 03:47:30 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id j41sm22987446wre.12.2020.06.23.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:47:29 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 1/2] tools, bpftool: Define prog_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200623104227.11435-1-tklauser@distanz.ch>
 <20200623104227.11435-2-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <f0e5992d-d65b-fa70-1e53-d0bddf72d6c6@isovalent.com>
Date:   Tue, 23 Jun 2020 11:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623104227.11435-2-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-23 12:42 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> Define prog_type_name in map.c instead of main.h so it is only defined

s/ map.c / prog.c /
(But not worth a respin in my opinion.)

> once. This leads to a slight decrease in the binary size of bpftool.
> 
> Before:
> 
>    text	   data	    bss	    dec	    hex	filename
>  401032	  11936	1573160	1986128	 1e4e50	bpftool
> 
> After:
> 
>    text	   data	    bss	    dec	    hex	filename
>  399024	  11168	1573160	1983352	 1e4378	bpftool
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
