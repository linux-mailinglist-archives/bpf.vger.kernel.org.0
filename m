Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB057289B
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiGLV2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGLV2B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:28:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C596D0E2F
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:28:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j22so16628180ejs.2
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qqe3vchI1vj06s2WyOtomNXamvDBZBJTCk3J89QZtZo=;
        b=UZPEo3kUC1cyLYfLUiBig6BkI0vufMbG0ZAOExGjCCGZGr467fFbLvfUNSi/20kvTv
         cVoR9iWQuWsh1j6dyuPrplXt/2uOM1c3DZWw5XC25tWmFgVkQiVKAOsc/7v+s2t0Qxfb
         +y/fJzHC+o15mIpWyEUqqcXaAWERKjPbHyMmLqKfpiF/m/ms0soNO+XdxxC7QS8+w2UC
         a63Pv67MH7TvaU9khgLJtaiEqlK1tZa7ywy6ocTFvXI+dtCD3FoMyO2O+SMyWmRYgH+O
         f8MgxhA2AoSRKBvbJAx2cdgI7kxzGcbDNbsD9PASTWqpGZbGl/gx++4q1mWpgGlK5zbY
         tw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qqe3vchI1vj06s2WyOtomNXamvDBZBJTCk3J89QZtZo=;
        b=gdaSDeEpH2GUP8PydIQLDvseaCYq4J/RXo5Nfv9L5C9lACTiyyCWdwKMArIih0/O78
         Ns3mrFuy5UW1d3jmMSKNqSgwAAPpEtEVMVI1xcA/VuXsew2QR50mbFgjUiPEAX2HBJ5n
         rYz/V8G+fu9F1bRTt3e0g1PhSGCei4sT97MGL+m39iMRNKs3Jtze3CGD1LGfC/+loSXd
         uL7j7wI6nJ10TgPd2e9UVCL0fs0zCWj1ZLC9sDJ9edl0ApHFqH16nEYu28VnlIGZU27J
         OIi6MHm/BuR+CHuYkEa57ireJb3bQS+0PaNetbErAWXsQdjX78s01BjKTxxJ876Xm6cC
         XyAQ==
X-Gm-Message-State: AJIora8wqRsSYwkigso9lxe9mOazb1gQ18NKp0jGEZsTL8pQG1JQPfL8
        P9WQW3nMK7udyRocZPTZ6J4l+eAFjrkJTuvIbKc=
X-Google-Smtp-Source: AGRyM1vgCCPMRMXoN2XUl2LRZnhSecDjcTPvK2rqPap75OFgId2aP4DHj4b4mVlcUmm963TCCd7eVPvLX1oeQHvVy68=
X-Received: by 2002:a17:907:c14:b0:72b:6762:de34 with SMTP id
 ga20-20020a1709070c1400b0072b6762de34mr147360ejc.94.1657661279081; Tue, 12
 Jul 2022 14:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220712212124.3180314-1-deso@posteo.net> <20220712212124.3180314-2-deso@posteo.net>
In-Reply-To: <20220712212124.3180314-2-deso@posteo.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 14:27:47 -0700
Message-ID: <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 2:21 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change integrates the libbpf maintained configurations and
> black/white lists [0] into the repository, co-located with the BPF
> selftests themselves. The only differences from the source is that we
> replaced the terms blacklist & whitelist with denylist and allowlist,
> respectively.
>
> [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d=
7112c1898/travis-ci/vmtest/configs
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
>  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
>  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
>  .../bpf/configs/config-latest.x86_64          | 3073 +++++++++++++++++

Instead of checking in the full config please trim it to
relevant dependencies like existing selftests/bpf/config.
Otherwise every update/addition would trigger massive patches.
