Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B06554E2B
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348154AbiFVPBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352962AbiFVPBb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 11:01:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BC3DDE9
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 08:01:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so7892376pjj.5
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=GeAai5ggL5ED27lapUlubyV5RKczyzZpKFmASb2DELt1Tsg1Hpx3AsjZ45k5Wh2r0L
         WtO1eFPFAkbNauhRZAAYFQKX0glbJpJV0ZuN2qf3eGc0asDtBWLn7mlETudubSEP1hnk
         NzcphurocGeMVlgpMLj7PUR2eR2Lp4h0JPRERHFBD8Tzz7X3sItnn9hGT8tybK3nvHmu
         t7uJVXVuf++/i+LsLQofdhOugkpS+2A5bnPZKH+n/96kCACuHra/CmVK6La9AmBpIh1s
         kC+2Nb1mHCluxmPl5JsheR6qW19Vdo48bhW+ijXOdK693c2Npx/Hxx3uAp0LkN4B9CXZ
         kHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=GzDQJp2QqErkmKsqoXFw13ANqd5L/hFN0nWhNtlOYruQNZlL93xSJgXDroMSWk3RgJ
         ItK1HipeCSvgCsmJ3D0fjFtIXK0WzVY9HNSF7wdw8gC1yPsd75uZaYmjAFIec1bBvjLh
         x20NZk1ydQK+JJtMoeDsaukOKCb8aSSOKYgi/4g1e3y9z7ZuL8UZ1mEXyE6/9jaoC66n
         L+Wq1iEVsJOQ/noi1I1mf6DXNj/xxRFDsa5UnNSUm/G9iP+Jhgs+Fai6DkpuIrc29oXU
         E/otxh2flRyt1b2KSVa0rCPtNIhQv04S0djybte3os/wghpofSgbXps9XxVTgbinQhZr
         2LwQ==
X-Gm-Message-State: AJIora8EsSkUhAJo4TGC9qjAZYNWKO4WWktiwoSJc8Zrho2HNBymbGKr
        qn4PDVNCmgDs90yy7v1QFpLfs5kyKBkkMf4fnCg=
X-Google-Smtp-Source: AGRyM1vRS3SbnxGLdXB9F5H/43Ax+nASo2xXssBGr5RIUya7NECDwqWwkb6vZkRvKxeygLW6PQ8XL6LtYBAb1l5fJCM=
X-Received: by 2002:a17:902:d481:b0:167:770b:67c with SMTP id
 c1-20020a170902d48100b00167770b067cmr35097265plg.77.1655910090310; Wed, 22
 Jun 2022 08:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:01:29 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:01:29 +0100
Message-ID: <CAFkto5uqi1Qc=yzisU1KPGkp2KcGr60-08=33tyyW2AEWvHMLQ@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
