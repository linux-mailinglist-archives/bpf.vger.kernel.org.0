Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430556D438E
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjDCLfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjDCLft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:35:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B62B460
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:35:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so116047351edd.5
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680521746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtE7tV0BJ1X9kRhDE14KjV/Fb1R+O4UUB9r9GwZWHwo=;
        b=o3vCAWCphfEADsf6/95NRHzkL1jz+Vky1MmSf5xdgXS9fzGpMmWYi8ZQONoeeS5gJj
         NGvHL5Zh/1nkvJfx4L8oEb1CsTICL++1jR5kbKxy3AzeDHtnbj1b5k9FyvxHL03anMYX
         qoOrxjNj5jkQ2B43jxieaG9sl32GhSlueiUK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtE7tV0BJ1X9kRhDE14KjV/Fb1R+O4UUB9r9GwZWHwo=;
        b=nkHYbeu2owhLVRUigyh4S7UNq29s6H9Kpl43PHKXGFouhTwTLLPm60CVvaXoc/ZCBd
         A7i4VCkXUmfTp55fl4kOzmEFVs/dQxfOEXRjzCLLhwIlcac81OLH16sRsbElvFv6VY6I
         zjOnzIaCeYh1QEyWoKtpWhBq2MR1imwniTQraBg4Dr8i81IXL7nZ3JTWrjFylSppYn/X
         9ZhRBEvH7D2PVKZwwSWzdjJLBwIaICtY3/uuSIiscqG4OT0DPw4xLDO/p1bfq7uq0zag
         bcEMIpN7RtkOrx4Z8GZUjdQs1u1ba1UZ1lrnF0qLwRo+w6HFFdDGyElUfHgIyVA9My2b
         G1QA==
X-Gm-Message-State: AAQBX9daf2h+7sirflDGZERHahTYtm6CH8rwb8elX5tTyYxpm3kXVR5b
        afvgV2zf75VkQwMKrcieG1+iVA5Je8OUPncqsdKKrQ==
X-Google-Smtp-Source: AKy350YHk+VumZlyk8Dikia4bU8HuhDFbXRE1v2w6I3NT+rYijEYQ2uNrwg/BoeLVEvlcTh/IngcPwMBYTWYI9etBKg=
X-Received: by 2002:a50:f692:0:b0:4fc:fc86:5f76 with SMTP id
 d18-20020a50f692000000b004fcfc865f76mr17964995edn.6.1680521746373; Mon, 03
 Apr 2023 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-5-kal.conley@dectris.com> <CAJ8uoz1cGV1_3HQQddbkExVnm=wngP3ECJZNS5gOtQtfi=mPnA@mail.gmail.com>
 <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
In-Reply-To: <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 3 Apr 2023 13:40:26 +0200
Message-ID: <CAHApi-mp7ymJ2MP_MFK=Rcv--YCz4aqtKArMwF1roRZHh0to1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/10] selftests: xsk: Deflakify
 STATS_RX_DROPPED test
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> Can I send patches 01-05 all together as one patchset?
>
On second thought, I will just send out 01, 04, and 05 already
separately since those are all completely independent.
