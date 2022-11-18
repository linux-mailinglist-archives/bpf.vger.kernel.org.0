Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9F62FC33
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbiKRSIb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiKRSI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:08:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63208E41
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:08:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n20so15108165ejh.0
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vu3eNM9O+YyyIP5+0BNuJ+7deTa1ahsgA+9hzr8JCAQ=;
        b=pglRRk/x3dB9mIy7a41N4tpkgXwv0EXlsi+hMS2+k5BsjzbsCuUhbhAmSpCukR7UW4
         VNCgy8VrKysxgPEfi30rmsOCua4J3vDUWAMaX6pGCn0ipCj1IRuYrWsUMmuGf8AUVaQS
         wmYMDw+6NPI9LpK8ygqXgjr0wuQheu8hdX/TindxSBgYjEzbOT2ddV36zgMxPCg7hDA/
         MGxXhqmbhxZFinQOXysnbN2Cto1k89kwWy50YSvYQmb0G7MIXhfIA/k+/VfJFyRu2mmq
         UgsMwQtD4TkezW08DKzmOoyiQOR84Yi2fBIf4L1um6yiHQI8etLqiMlnlDEwjYK+z6Z8
         Aaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu3eNM9O+YyyIP5+0BNuJ+7deTa1ahsgA+9hzr8JCAQ=;
        b=Mo0Zl47NiHTzaEl9dP/ysEIPC5bchpnVnP61+dp3yeDx+tpBhG+3Vpvi51tBJ9CoZn
         W9a0du3kTeL4PzONIkSnn63Hfj8kmsntKNOXoOVpgqCGIjMXzlDQPdbUNXW36HE3PsQr
         llZYtXFCqeakoeNE8tC8xjKY83oeuGdvIxWQoJqzjWpH7SeUnRV3FhD1XWK0IsL806jQ
         nm/C3xHeF2OdSJ8j53/2QPbm0xHjCjXRH8shAAFMpuNw1rSqnHid1fJRf0vbme9ZeuV1
         JblEH27EuKQsCmuIpwK/TmvlvxkCUKuzB0+1ue6b7wavRZLA5qdPM4ymLIVzR66F22xk
         JBLw==
X-Gm-Message-State: ANoB5pluHD40fghdjnfud/sO/VJ8p/rholpSBES9TdVcdnXwnyBmvyhL
        qUzsmCwExSETZMl7G0EdMQdKnAXO0JSSkTN6Wmxo+cQznM0=
X-Google-Smtp-Source: AA0mqf6C6oUkdBZVtDjq6g1eM43j+O17wXijf5zKHnGWm+kTF/d5M5y5azlYbAulie90kAc4PMkkIsGvp1KXO9re0yk=
X-Received: by 2002:a17:906:1495:b0:7ad:d250:b904 with SMTP id
 x21-20020a170906149500b007add250b904mr6943450ejc.633.1668794904729; Fri, 18
 Nov 2022 10:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-12-memxor@gmail.com>
 <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local> <20221118103730.nbai3gzifkjk45eo@apollo>
In-Reply-To: <20221118103730.nbai3gzifkjk45eo@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Nov 2022 10:08:13 -0800
Message-ID: <CAADnVQLYKt5NpUjjEOWzQXYLM7Eo5ogLApRYKk3SAtX6LqeFUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> > Pls watch for CI errors and follow up when necessary.
>
> Will do.

test_progs is failing on s390 with:

test_spin_lock_fail_prog:PASS:test_spin_lock_fail__load must fail 0 nsec
test_spin_lock_fail_prog:FAIL:expected error message unexpected error: -524

I bet it's your change.
Please take a look.
