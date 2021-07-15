Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAE3CA153
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhGOPUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhGOPUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 11:20:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE9C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 08:17:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so4970931wmf.5
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8se7NGdlzzSrT0d355yuhAfvmmfXUCts5f7vp3eEJrk=;
        b=O9COXFr0NnQmTNwirLGlajW7p5tGYzcVqIYheFPZWbCeFdZO9icKJuF4S/PBBd6c+7
         1t/6DkaXXNKHa5v61dWvhITaPxXF602Do3BU4a9g7hY3VPqTpkN+d8XuPP3IipapHVU1
         UPuzphExoAVTM6Gfs5aH4ySkk+5oNuJK97IuZYvjXZdZ8K2n6l9quBD/Iuy5T1Nfi5U5
         63DkM7Wn7S7CMEwxsX5GVloYXOz8XkMJt0FVY3rq1wSNPs9DWfEw9vixofcZGag7MUEm
         /5x8llKwmMPZHupGso6woaUYu/AQehy0XvNwzAqCEarZrxvRh6YVXU6hnynbHCErAN7P
         Kq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8se7NGdlzzSrT0d355yuhAfvmmfXUCts5f7vp3eEJrk=;
        b=pz17J5O0il5NP4b4d9zLXFlv0mgDk2HnQt5pI6+nAZ3heN4M0jJBY3wTgs2OA1/Fx6
         y9WkrpQUn/3Vq3G3jWij7E2+ajH+99IbeEYAMpuLXsKkUlxtQdw3srAqtYjAvWUoEyZf
         43IYQYGGGrPkbIMtTjFMlsZCBUFFZ/wuFBZsAdaadvK96C9fpnixTig6bj+5jslPq1pE
         LWIrpeVzehKZMw4we4mrK/XRWooGUXYvez7ynbao6V32F+CMTl08SFGCNJqFJowjZtVY
         GyC3Zz1SQoYTlDTcqA15aEtUrv7b0+FKbHLs1WM/WRMPaoPSDUjKZ/Siwpv7Mt2Ik9md
         jSyw==
X-Gm-Message-State: AOAM530EawWua1rp5OPp0Q0QUEvg1lLVQBosKZV7pMsQWAEOtUQHzxZx
        lmmF8qdd8gK2zM7rJxpZcGyQNA==
X-Google-Smtp-Source: ABdhPJzwRIO6JM0geRsYAlJN036kCJGJ+FzO7CdxM1sFAb21lQNs5Em2y5dUjmO2Kjy1RpRMGMpehA==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr11096120wmd.179.1626362234827;
        Thu, 15 Jul 2021 08:17:14 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.80.45])
        by smtp.gmail.com with ESMTPSA id n5sm25506wrp.80.2021.07.15.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:17:14 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpftool: Check malloc return value in
 mount_bpffs_for_pin
To:     Tobias Klauser <tklauser@distanz.ch>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Roman Gushchin <guro@fb.com>
References: <20210715110609.29364-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <30aeaa97-d72b-54cf-7e5b-b72964f12a80@isovalent.com>
Date:   Thu, 15 Jul 2021 16:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715110609.29364-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-15 13:06 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> Fixes: 49a086c201a9 ("bpftool: implement prog load command")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
