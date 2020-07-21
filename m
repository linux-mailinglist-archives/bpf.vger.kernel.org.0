Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8F227DA7
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGUKwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgGUKwU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 06:52:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C91EC0619D8
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:52:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so2372019wme.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OY3QGVSKcFfHohMrmSx96RCvy1aRKiLiM4uYhwLftto=;
        b=donHqPZXjffI/NgeFxBt9yQDw7ceJ2UyFPVcufJe9sDccFr/EWsmipSx3BoJs1juCo
         ROvuTbbn80YG+8YD3EIn6IiSTIY8pqm7E6stUCRNoaOqLTZDZKB85gMYammxrYUNqcw0
         SzlSU6fgOSiK28izfgjeqYbEwazGCuuGGJsSk4F6irxghY+EntSZzONijdP3NA3k+nPX
         AxGBQpgbjwbkF4EGTmD5g0Vv2zsDKVK1LluX3k+PEL1Vjia4KWg/VGkGpjhPzJLHaO9m
         t8qUQss3ujzLz/5vpt6A/41qBEJ0uHbCC/VxUtLs+smTi7vGfQAWp2TPtwk31lR8D18l
         1yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OY3QGVSKcFfHohMrmSx96RCvy1aRKiLiM4uYhwLftto=;
        b=Redamq07BP8oiGJZtz5X6TtpIN8W4Wtlx45OryKp6c7ZcyZ6HhjacnVsiT/lFQpxdz
         h//yKhkBBJz7pisDSegRr7DdvFK2op9RJM2Bg58501LzIJbSyR4Mu2Qzj8z+5BhFA9rF
         BQgpIoaGIZV6H6g3Lv/Km6P5/ZDjaaWKv87xdi7oa3ebfFp5ulXXYEu6Py5FWrfpRsjV
         Q5whTTf80BOxzrGcj/twt3k5FKEGNWM7vungHw1vdKf8YpDT2wnBtPD8x6VKwBvtU23h
         QRhb8o7hRyuKeg+nawZUVJfhwlVPfPUMqZj/Bw1BMlvO3qjd3zneOnynhhxzviR0xfWX
         ZQsA==
X-Gm-Message-State: AOAM5334NAHQnaQahU4AGDuD+jPFG2qO//JlRjHKxLOcFAW63Fv5Qzc/
        y5yuL5C1TWlslzLmC7Ssf9PgR92iMPng3Q==
X-Google-Smtp-Source: ABdhPJypqE8AUYRQZ6oN+QxyiZSL8uoI0qGb8k5A5f6x35QrGu4ayPoolWKv8jhM3f2oJS0910z3VA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr3510204wme.139.1595328738918;
        Tue, 21 Jul 2020 03:52:18 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.117.141])
        by smtp.gmail.com with ESMTPSA id t2sm2795905wma.43.2020.07.21.03.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 03:52:18 -0700 (PDT)
Subject: Re: [PATCH bpf-next v4] bpftool: use only nftw for file tree parsing
To:     Tony Ambardar <tony.ambardar@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20200717225543.32126-1-Tony.Ambardar@gmail.com>
 <20200721024817.13701-1-Tony.Ambardar@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <b0242ee8-b5ca-3e89-a7ff-c1f11a0b432a@isovalent.com>
Date:   Tue, 21 Jul 2020 11:52:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200721024817.13701-1-Tony.Ambardar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/07/2020 03:48, Tony Ambardar wrote:
> The bpftool sources include code to walk file trees, but use multiple
> frameworks to do so: nftw and fts. While nftw conforms to POSIX/SUSv3 and
> is widely available, fts is not conformant and less common, especially on
> non-glibc systems. The inconsistent framework usage hampers maintenance
> and portability of bpftool, in particular for embedded systems.
> 
> Standardize code usage by rewriting one fts-based function to use nftw and
> clean up some related function warnings by extending use of "const char *"
> arguments. This change helps in building bpftool against musl for OpenWrt.
> 
> Also fix an unsafe call to dirname() by duplicating the string to pass,
> since some implementations may directly alter it. The same approach is
> used in libbpf.c.
> 
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

All good for me this time, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
