Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB216E14C5
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMTD3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDMTD2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 15:03:28 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF7E59;
        Thu, 13 Apr 2023 12:03:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 348542DC;
        Thu, 13 Apr 2023 19:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 348542DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681412607; bh=L4JeuRvGa15wh4mz54UBqqdEIMtwL/jGbQrm1LND5vs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nHDHLbDjocW/QkvZhKuqvmBrHcvL4rG3ayMAvq5c0iAj/HTSxv14B07Wsx7HD8cd4
         qfpIxK6V8FFjZFn8tRRFCMk0YO4HK767omJIm01eGK4g3ou+XvbYn85NoXKOvCIcW/
         SUETQlnW/J9XiStU2x/4+RQAF+hAG9SNjnlE0aIKHm6dGKjWytp3rh2h7h0Vkevx5F
         xPiVJ/6wBb0jyZZW32jCubI3WijAy94Z/kvLG7jfqGDX+zzGWSpSiyFMPnBevYf8Xr
         /vFn9mPU0e6cTtjC4WHvVvtI/HmXj1A3AoI3yLPV+4KUdJGh3Ck6FwaXsq8JYLVm7c
         aVT22xBHpIkLA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
In-Reply-To: <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
 <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
Date:   Thu, 13 Apr 2023 13:03:26 -0600
Message-ID: <87leiv4nb5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> Why do you prefer such
> an approach instead of going with no extra permissions by default, but
> allowing custom LSM policy to grant few exceptions for known and
> trusted use cases?

Should you be curious, you can find some of the history of the "no
authoritative hooks" policy at:

  https://lwn.net/2001/1108/kernel.php3

It was fairly heatedly discussed at the time.

jon
