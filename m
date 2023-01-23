Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD24678903
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjAWVBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjAWVBe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:01:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D97EF3
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:01:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a184so9810699pfa.9
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd7o2UMmddkZne8X5PwGLBEuvMIib1DaoXugXil87f0=;
        b=apkgIAHulnPAYoGM/ZboHnSFsPZgmTCF7vwBDEG1hcOo7IzqiAv7TQCOdSSEbPVpXi
         ICIC8n4/B9ib7Tx/CitG89uNOdjy78PJSxSp/qXpFlb8a6CpOHU9s1PCYjMgbUARNT6r
         iLNWsVCTHrGLDec3sNP4dOvM+9bIhi0wdh49JcF61rVk+MGUbEHxZXW5kkaqiDEFdgZ1
         OAk/F86EhDLicb6glvYgYoUccWdeHJBIqEXRPQszc+TvuMPJ06+pWkFC34mSSeEfR5Y1
         5MpgyoLti5tkE431tIcTXShIZ9WeTApvbkHJCWLO2YtxEbeyfQeapKaPaeIEUv4RxNp+
         T7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd7o2UMmddkZne8X5PwGLBEuvMIib1DaoXugXil87f0=;
        b=PqS3xuUDD9xVRUqXHGptYqPgEjJ9XbIX5myl0EebDi6NVtsWNJ8nxsMFibHvdg3roy
         DEcUoKYr5cVBp+k/tWGs4MnAGFkpW2GPX9TWfK7jfVENRbTLRjK2kBwdrnZrZE0gg/WZ
         WCF8nI07V1971b4ecojltUPH5gJ1a4ehGk2ELCaA7O6n4mArdIeLH1R2p1r+VEcAh85K
         VirfBdRJ1wYUnfkh7jLza3dogudwmoE3+Y7Z7uBVIaUsgrRtPyJ+JoOaxOGRgRpAsFXz
         aQ78og7aPFuM7ja01FJdpXL9f0jL5O4FtUDxBn2z6SeE7ZN0VGCSI5ZwzdG+aSGetzyF
         O2Gg==
X-Gm-Message-State: AFqh2ko2bMW793kKmhSsI4CIcK4Tsx+XPUkmRuTQNioKXBWAMzRiHPsC
        J/cNiHgZedp+p8CltxUoJLOwvSwgcoWhmRdwCYo=
X-Google-Smtp-Source: AMrXdXtdP7XvuBkkOoCRUPhMd1d+grDnKMSgWYxGuHqHnrcZUe8gHH7U3JzzW7OHMWK4+sfZJ4sCN09NdtVvVgaOVzk=
X-Received: by 2002:a05:6a00:f91:b0:58b:a1bd:6aae with SMTP id
 ct17-20020a056a000f9100b0058ba1bd6aaemr2495023pfb.25.1674507672072; Mon, 23
 Jan 2023 13:01:12 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev>
In-Reply-To: <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Jan 2023 23:01:01 +0200
Message-ID: <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=90=D7=AA=
 =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
<=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> >>> interrupted the first one. But even then, I will need to find a way t=
o
> >>> know if my program currently interrupts the run of another program -
> >>> is there a way to do that?
> May be a percpu atomic counter to see if the bpf prog has been re-entered=
 on the
> same cpu.

Not sure I understand how this will help. If I want to save local
program data on a percpu map and I see that the counter is bigger then
zero, should I ignore the event?
