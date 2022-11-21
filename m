Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86B632D87
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 20:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKUT5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiKUT5e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 14:57:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20B5F84
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 11:57:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f18so31070581ejz.5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IeUmtbaNYKWaRY/9dEUloawtMQYjXo2pD2bTbvxe96E=;
        b=BMG2CmL3pM6p/qQM23Da8jBpKamps5uvUFNDTQCxOc7sQQ1mEklNjz8QtIY3jqClN9
         7I5m6Iv9z2qnoZeVbBIPnxPmhHYl0tM2aO+SuuCQY3dFm7CQFvaoa4vy/W7XanXKxoYW
         5OByZiGt7BIBXKZXSbsSGXUHgmfURdLxE3tCNuXShb/VjhGY6QzoH1iasbK4mVfX/SiV
         20kyG68zmdm30D7/wx8UHpFlUdzzejYINXYQt4K/rHexAp0aIgk2dHRF0qcQDsEVP78U
         DwhhV/MpBVZr/0/4Rwx7Sl1tjWLQZH08rbkHFRm/T5EG70UO7jvk8qkYBXSkRMYLBhCa
         4nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeUmtbaNYKWaRY/9dEUloawtMQYjXo2pD2bTbvxe96E=;
        b=Z6EtC+/gl0Q8MJMM++EN/RSnGlnBsNr4U57U3x07Vb60uQIFFH3qXBL2iTVmaOizSd
         lbSBRLOPrQvAHuJLOYd5M8Csv8VwIuQXwyFSph2G0iI+jz9VqQLy6tPMB/L0/tT+fDMj
         xLPTdoNcb0ylYA1zWBxWdj98sBodFmzgjXplbh2IKooLvfKX8oS+rrGX9xAH952dbocu
         UOqx+/bDU0yPq2tOaiI7piKftyKU+AufNM5U7QyHq7wgsf17wBsoTpWn+YrYSoUpVYM/
         3ZR068XXm9/U67epCWEYyyy4V5+kQWDjCcXyiE3BOZvfVmNmGrBm18tuKo2XXBy8QmhY
         inmQ==
X-Gm-Message-State: ANoB5pkAaN/zRkQajL8UIpXt3vYQDAXB/rNX6xhPgUHahWgrNuvFMDyM
        GYZJEIYgIcH4HV5NnMTKnKCcc4lLcaBNEVdGFnEsDk2b
X-Google-Smtp-Source: AA0mqf69NCJxLsb8IBx9TsMzwF8WYsDyZqLXcKDXiqniFomfM3wMbbXCrXEaPHCXX0IBm1hlUyA+d/bIcNYZf+jQvq8=
X-Received: by 2002:a17:906:34d0:b0:78d:c16e:dfc9 with SMTP id
 h16-20020a17090634d000b0078dc16edfc9mr16996569ejb.327.1669060650447; Mon, 21
 Nov 2022 11:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20221116100228.2064612-1-jolsa@kernel.org>
In-Reply-To: <20221116100228.2064612-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Nov 2022 11:57:19 -0800
Message-ID: <CAADnVQJXyn+A9hshF_139=9kbm8ZOdbd9yhUKEdMknf6LpZOtw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Filter out default_idle from
 kprobe_multi bench
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Wed, Nov 16, 2022 at 2:02 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Alexei hit following rcu warning when running prog_test -j.
>
>   [  128.049567] WARNING: suspicious RCU usage
>   [  128.049569] 6.1.0-rc2 #912 Tainted: G           O
>   ...
>   [  128.050944]  kprobe_multi_link_handler+0x6c/0x1d0
>   [  128.050947]  ? kprobe_multi_link_handler+0x42/0x1d0
>   [  128.050950]  ? __cpuidle_text_start+0x8/0x8
>   [  128.050952]  ? __cpuidle_text_start+0x8/0x8
>   [  128.050958]  fprobe_handler.part.1+0xac/0x150
>   [  128.050964]  0xffffffffa02130c8
>   [  128.050991]  ? default_idle+0x5/0x20
>   [  128.050998]  default_idle+0x5/0x20
>
> It's caused by bench test attaching kprobe_multi link to default_idle
> function, which is not executed in rcu safe context so the kprobe
> handler on top of it will trigger the rcu warning.
>
> Filtering out default_idle function from the bench test.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

That fixed it for me. Thank you. Applied.
