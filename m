Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA752AEC9
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiEQXlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiEQXlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:41:52 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA335DF3
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:41:51 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o190so509156iof.10
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yRYTD3w51KuAZdPfN6kvA2iUq7i3Pbre7qpD/pccHE=;
        b=ASHBozjupByDhX0GAPujMqkmtRkHydZaPW9tuUYZnPoNy1A0Cr6jlD9IdrEAiiOfte
         WGrpPkCc6zOrRaZ00MEB92KwmEPSDLNpPwQCQErrCxz/pIvN/vgVrb9nTtvIpojkHL9l
         +qIzk/4Vr8+DbeA7QAEb2d/TsPfiAjIBb733mhQled6zNXWVPtGGZJvhvcHDyWdsMnWK
         4oDKNbF75WPUJucZDbY4DfNnp4HubGYVBqg/hE6okRvkZez+Hj4ZeucMWdAUIylMCG54
         uuhLMOISU6R9ltfu0ZM5H/SXxmU0xrdakXhHz3pp8yVCVz/ubx5iB1k6Kl+o9bGqS/jp
         V0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yRYTD3w51KuAZdPfN6kvA2iUq7i3Pbre7qpD/pccHE=;
        b=DrrnTt5ORs82aCJmRadYtqovGxBpnJnExURiJJ7LsPlH3sHJSiifqYK8XQrP1VI+KT
         lmAEhjyg1R+tApKhMm9RkSKukHB2HcddYomBaBDuAE4QpgMJlwUyz4Sk+TtUBA8yVk9f
         NCKZ1JPemVl3ZyniCbOIOSGQi/Z5F+TxNarEyE7x1WwKPnEPiNk0DWaGSzhlKjNNyYCB
         X2pLLCZzue0CIUrYQ4NgaBIPxLPWTejo9R0r6/LLgBLfGA0LZd14pw5N3sX+fR6pK4ky
         b2Hp2R9xv8raBMhcmFhzh29uHFnNNhtJbutznwItjSoO2hCLZ64PweYz+S2TyPj3Ppu9
         OZGQ==
X-Gm-Message-State: AOAM530I/Dm6unJlqDJL4G8lMExHNCu3vw0dHaS6h2TAT20dtbzVcfof
        HzZFooHr8ta4zqhGW0BmGmDD5Jfu7BKo8gznRiKqlHqJC3I=
X-Google-Smtp-Source: ABdhPJxQbN5+PTjVixsNFUSuMa3k7MYOxsqlp3wrDIhwAJ+J+G1vX7LV9h3HyApeNZXtjpSkQHr438/XauSryE8IkO4=
X-Received: by 2002:a05:6602:2acd:b0:65a:9f9d:23dc with SMTP id
 m13-20020a0566022acd00b0065a9f9d23dcmr11313498iov.154.1652830910756; Tue, 17
 May 2022 16:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031335.3246336-1-yhs@fb.com>
In-Reply-To: <20220514031335.3246336-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:41:39 -0700
Message-ID: <CAEf4Bzb4K1SWtUhxVWyT+1QnVmh--7ceCitqGQne=pAnDNS8gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/18] selftests/bpf: Add BTF_KIND_ENUM64 unit tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add unit tests for basic BTF_KIND_ENUM64 encoding.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 36 ++++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |  1 +
>  2 files changed, 37 insertions(+)
>

[...]
