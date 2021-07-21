Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B683D128B
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbhGUO4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbhGUO4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 10:56:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60152C061757
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:36:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d2so2715066wrn.0
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpRa1ix6hAPuB8DnQBcEdSj7KsogY+yLTzijguZVYEE=;
        b=vE/GJOEreeJVhFCyCovuk3FjgCOfbv96LXVD7h00p3L1b/8EiSqzRQaX1QZ4Yryltx
         7qGHUrtcO3thjbt4KHFUvKTzBc2+tDQAdKOtUTHyHKA9zGnuiWXenn/mZeX7J33DXOze
         Yilpy7fqEDUJXEUZY2EDaTiSvL0ris599qQOuXz9CyLPc1KpI4GnONQjr2EtvkLZEdEJ
         YLJraFUfOO2EungFqULlWFh13m+pxD6kgG8/Lbxbsmjd4fsrPulZvbe8WAn1gPfLt7uL
         Bsk70zpnuuLnOKuFVw129pfDZtIWM7hJlpgr8vnwY0biTBgioVr/B7yTo8Y+Mae80Zub
         5zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpRa1ix6hAPuB8DnQBcEdSj7KsogY+yLTzijguZVYEE=;
        b=K/8HFrnpRGCAh5hQqegQ2gAunjiKZmF8brPPa6eAdk3/6RGs5WNLuxezqBTgAKacLJ
         MjShKiCCi74Rrb18qBLi3cvtRMjFk4KVkphkrOWyccNHv58fzNZJTkZSkTBVkXyGRoHx
         S1227cofgA0YG7bM0iQO03l+0si/JGX2M/uTzJSYUkePYoIcD00iDppHXP6jMI/kkBzn
         erKsSfW10ymZYyGxoZFO8UKHlDQsCS3McAjmi0bj6jcuCWHVkgsf1LW/J2ngsjtr73g/
         Te/FaRYpYU7RmW/nTO0c+/xyWWqVSKitTIAhbcXz6CGtjXPJtlZ/haXcU5/rVmOthgEI
         upzA==
X-Gm-Message-State: AOAM530bzRYL6JW9l1TOTjsftGi2mONTlw2y7jzIFWoF92mZZbPjZ9Ge
        SJy+lfRsjs8rC0qa+NwrqUubuo0zF8SOKqH0b48=
X-Google-Smtp-Source: ABdhPJxdlaRbaRZ+Xw3OSc0sFmb0TLDA9ktxG7vqe0pwwHe0JL80+SWxuK1MDPzWG6H5vsIXHZoTkQ==
X-Received: by 2002:adf:f110:: with SMTP id r16mr43054628wro.358.1626881807641;
        Wed, 21 Jul 2021 08:36:47 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.71.195])
        by smtp.gmail.com with ESMTPSA id q19sm225785wmq.38.2021.07.21.08.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 08:36:47 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/6] libbpf: rename btf__load() as
 btf__load_into_kernel()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210714141532.28526-1-quentin@isovalent.com>
 <20210714141532.28526-2-quentin@isovalent.com>
 <CAEf4Bza=5GjYyDCZNMbUFyQskXunT8S3R1jCfvZmy3f1joRVFQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <69d16c23-12bd-31a9-d025-230efec8eb6d@isovalent.com>
Date:   Wed, 21 Jul 2021 16:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza=5GjYyDCZNMbUFyQskXunT8S3R1jCfvZmy3f1joRVFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-15 21:32 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>

> we haven't released v0.5 yet, so this will go into 0.5, probably

Oh my, I still haven't done the mental switch since the old release
model. v2 is coming, with this and your other points hopefully
addressed. Thanks a lot for the review!

Quentin
