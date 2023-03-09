Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F526B2C01
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCIR1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCIR1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:27:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2721DBA2
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 09:27:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k10so9898987edk.13
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tCLmbHD9y6gyufZVIPlSHWsBD+rIiQqYH1V3TEjx8s=;
        b=hQhcDlhBgKBuG9JWb8ZG0K2ntGSxDZNsUjIw3HTrorXbi3C6c5O/NJYn+In3brnhTf
         1QBOJM2WPuaC7QD8g25tlTPLTV5QVV32jbmILewVpZU9RmJv8691Jtg/oyGJsNu3si/u
         4kXF44MciZWYBHeKxw5wPTRbB/XXbTl1O4bnju87z98+RdWsiRwR+IIno5JScB0aoTcj
         Aoo8Ny/VriATiCVxlUMQp1oQkNnnxsI5RnInVm4hAZ/2+RFrM1DcXIK7LiCgmbuVaAcM
         /Dsjy1/gro7cRQ97laISZ6wBL3VScGmbnzoaCemjONCbRbmQuVgtwW6HXuyJWk+w8bf7
         4y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tCLmbHD9y6gyufZVIPlSHWsBD+rIiQqYH1V3TEjx8s=;
        b=hGsBYhXcJFDFNAQDajriy/RSHSQugfNEhQxPzJoBz852xb080disTOeUjUHqe2+f9e
         KBc8hMpMBs5Bsh/LnRNSZGqJB8dTbYqa1HpqGO0hf3Vn3SOIb8Wbxk/IoE3yvwnqIsTN
         dbLIjO9PF9QLeKv2r8XmhqupvxkslPzgrKLM4xF7OJfYMlc2VephzmzdRScKZEs5ImxH
         ZafpvVm2PbCVgcPchwzkfziUrUAYVOTIVShP2wr8Oia+641C64ShS6aXtCs4LXjQrRwU
         ui4wIcoxNgpiHDb6mJFxlYJJxIPHSiluW3jMQXuSiIzo8VuHftIozjSnP56CHCUQteto
         bvWA==
X-Gm-Message-State: AO0yUKVlwEtTF+3xkM2VX4DrNzvcNnkehHBkhttU2pgpj+A1GuXvF51l
        Xq2zpvINZemIBDzSvrwPP+aeJR8UJ/jo+LDw0mc=
X-Google-Smtp-Source: AK7set/WYOujeoYIlI95LepOsRwTsFodGgDXSquX0Z9WeFF2xwL2XlTrxR8+W9Im8+ItFTh6P+Dt+voNxyoIZSb9wu4=
X-Received: by 2002:a17:906:edac:b0:8f3:9ee9:f1e2 with SMTP id
 sa12-20020a170906edac00b008f39ee9f1e2mr11529362ejb.5.1678382830474; Thu, 09
 Mar 2023 09:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20230309004836.2808610-1-jesussanp@google.com>
 <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org> <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com>
In-Reply-To: <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Mar 2023 09:26:58 -0800
Message-ID: <CAEf4BzbggD36JS4Z1dukPBqpTBapO-ptbfa3Qc8m9j5j-7ue=A@mail.gmail.com>
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, sdf@google.com,
        rongtao@cestc.cn, daniel@iogearbox.net
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

On Thu, Mar 9, 2023 at 8:06=E2=80=AFAM Jesus Sanchez-Palencia
<jesussanp@google.com> wrote:
>
> On Wed, Mar 8, 2023 at 5:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf-next.git (master)
> > by Andrii Nakryiko <andrii@kernel.org>:
>
> Andrii, are you planning to send this patch to 6.3-rc* since the build
> is broken there?
> Just double-checking since it was applied to bpf-next.

I didn't intend to, feel free to do that.

But just curious, why are you building libbpf from kernel sources
instead of Github repo? Is it through perf build?

>
> Thanks,
> Jesus
