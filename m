Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F556D89C3
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 23:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDEVrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDEVq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 17:46:59 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF3E44B6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 14:46:58 -0700 (PDT)
Message-ID: <8d2e09f0-99a8-d55c-d965-f3e67f74b7f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680731215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D20s8pb1aZ/8kVPVLDBJ/EuXPheGfLwtD5jDXSnifjc=;
        b=YB3HrRzZ7y+mbZk62Yhbdp8pmtrd14sS3PhqYm2iZ0PAC4qZTWHf7VYN6/8Ti0jYLId89i
        vMVJBesjeSec25cJg9hORRb8IPFmZF3FKm0Rfa3RU5KC8NpgkONU8tbr3zi4co+JVtBzja
        lDylEQNsrmyaWlWNBt4cc/GfBfuEfnU=
Date:   Wed, 5 Apr 2023 14:46:51 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf] selftests/bpf: Wait for receive in
 cg_storage_multi test
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
References: <20230405193354.1956209-1-zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230405193354.1956209-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/23 12:33 PM, YiFei Zhu wrote:
> In some cases the loopback latency might be large enough, causing
> the assertion on invocations to be run before ingress prog getting
> executed. The assertion would fail and the test would flake.
> 
> This can be reliably reproduced by arbitrarily increasing the
> loopback latency (thanks to [1]):
>    tc qdisc add dev lo root handle 1: htb default 12
>    tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
>    tc qdisc add dev lo parent 1:12 netem delay 100ms
> 
> Fix this by waiting on the receive end, instead of instantly
> returning to the assert. The call to read() will wait for the
> default SO_RCVTIMEO timeout of 3 seconds provided by
> start_server().
> 
> [1] https://gist.github.com/kstevens715/4598301
> 
> Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
> Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev/
> Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
> v1 -> v2:
> - Changed from a call to poll() to a call to read() (Martin)

Thanks for the fix. Added "Acked-by: Stanislav Fomichev <sdf@google.com>" and 
applied.

