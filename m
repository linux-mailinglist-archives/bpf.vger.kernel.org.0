Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315A5680D0
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiGFILV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiGFILV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 04:11:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFC17A8E
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 01:11:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m16so2744247edb.11
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5hKyBI5xPjOWFUNgUvgDNmCchU5+WgvMGazYCgvvLNE=;
        b=j3fOvCbO2tYLvJB03QtPCvhTYoZKc79bc5g6rMFqk4g4tt5ckgyRjgOqfUXTL0wRRK
         uUSFmqV0K0969Hzu9UHH/n2aigRF8K7WwEPmJE0eTh/sdWIKTNqxY7Ond0cNLx6ixnQ2
         zROp9rxtp9JtUNsRcKQ1pikwG6bknoJ+fQydxn7wzOG7nLcOnx5HfdLhwJRwCi5TBFlc
         kDAfW3h4dvkk1UGnc4idlBBAxzrl9F4DIZEijgIi91T3dSd1lbMUqiRczDoKXfnNeGwm
         ZoBoKam1BgJFIwjXMHCbifwuZAmWoU1Kliiw2KnKoAYk2FyOvgays8OV7SyvuJ9deRIL
         DmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5hKyBI5xPjOWFUNgUvgDNmCchU5+WgvMGazYCgvvLNE=;
        b=66wgEoUtsGLiWimRxHhHntc3tBrLpO1RMFpcxvM41i5PPn/OLtfJ62HJPy7aUs1mU9
         +SgLol4XnInk9vDRg5tX39H4qVq4dMqomfIURgtPNwAI5PB3RUZW48ILC6+tvb3SBrMG
         1oV94E8N1vjzMZ5mbYDy3U9nS3rq63jtgjG1asuEYmfCk/7OwZgjomlzJ5KqbquJCN2D
         PlE09Nb81pq25k0hon4stHwUKDac0h2BissWuKBx1/vxt9j5Fmo9GkA8NBOidajsMdt5
         OJBn18BT6WlX47tGWxfLkTacD/mcD05jT9Ggp28rn5YAyqNa5a7X5lKzRJquRcI/SEPc
         Vxtw==
X-Gm-Message-State: AJIora+yNKh/YpVkp4NUhHISqy9tVBP+pwia9UCTrU/t0EaszQ778QXD
        g9FsLxwEawUG3zVSp+PzPL4=
X-Google-Smtp-Source: AGRyM1tX++VjpA/A+VHd4a5h+H8jAB90fYg0xUhics4wFyKqS/gqHEe0BjAseIVhLeIlpBNtabt5JQ==
X-Received: by 2002:aa7:c2d3:0:b0:43a:707a:72c5 with SMTP id m19-20020aa7c2d3000000b0043a707a72c5mr14810544edp.54.1657095078697;
        Wed, 06 Jul 2022 01:11:18 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170907770700b0072a815f3344sm7888881ejc.137.2022.07.06.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:11:18 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 6 Jul 2022 10:11:15 +0200
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/3] Fix few compiler warnings in selftests and
 libbpf
Message-ID: <YsVDo7XYPXD4Du++@krava>
References: <20220705224818.4026623-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 05, 2022 at 03:48:15PM -0700, Andrii Nakryiko wrote:
> Few small patches fixing compiler warning issues detected by Coverity or by
> building selftests in -O2 mode.
> 
> Andrii Nakryiko (3):
>   selftests/bpf: fix bogus uninitialized variable warning
>   selftests/bpf: fix few more compiler warnings
>   libbpf: remove unnecessary usdt_rel_ip assignments
> 
>  tools/lib/bpf/usdt.c                                       | 6 ++----
>  tools/testing/selftests/bpf/network_helpers.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/usdt.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c      | 2 +-
>  5 files changed, 7 insertions(+), 9 deletions(-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka
