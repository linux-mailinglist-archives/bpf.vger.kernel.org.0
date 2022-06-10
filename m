Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6558E546DA5
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiFJTwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiFJTwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:52:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8B23CCF4
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v14so11555527wra.5
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=y3UITEx0SBsS5g1x4ULHaE+KbdORxtcufS3I0QAPCfO7rtbWxyDxBifiPRqpMkPjus
         X0sbLUkmKgfJJrjCa5GcA1ZmTsM0uVG5p3FSerp8mgTJDqYzZ0Dd+0w8n+ZqqlZCMhFx
         gqR+XnYmehwlcDxCZ6WGP1BL5334b88RrOQmFrgNaFHzzk72zUGuTQKkEYAMCW4oqMak
         O7tp4NaIScT82Cf4oFocLCBqueORdOGv1sW98SblpZ+FIX3X+MMo/dv5P0BkfAeHVoSN
         CgYDNH6EWMFDwa3blv4+sp0n2zD09/4LQ4PJ1rb+i93BTauFioHs9iM2Nm1KavIWTw2q
         LRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x81CyVir3pjK/ztFro5SKkqWERq2me/APMv8atNQetU=;
        b=uC0XNgc/DngnHOhIFbGaCjyL9mVnDwomWgvv8nDRHCMtyQRRZ1J9aAGZjYtq+COt6Z
         vZ0+zAt7lRqEeMq5ghA4aYHSNCRyeGqgud8KfJ6cQuIdx6uIIBvagAtanEZkVWiEHSOn
         W8ska1a8FU4zdpG7UpVdFMK6JRh/KdyOwB6Hxo93gS+a3GjsKyPkAxzWPYwR3cUV6YQf
         hePw67K42zvJBOrANA7FWSVV6YURTPTbbwWGNbYikxb3FznY9rI4AsEnscySAmHyGane
         oAyCg1m+0MxPMHsJKJ/9DrcEtrMXG8VkZeOIFGaQIqBLEoBgWtsGbxis3onRZKT4tCih
         JZqQ==
X-Gm-Message-State: AOAM531RQ4jdlApV7eEDiKPmO7W16GyuT6gv3rq0LX6h1HYLRXR735RW
        ZULf5LMdx3ml9XpsfCuWJUsEFX2skuyi7+48jyxB
X-Google-Smtp-Source: ABdhPJxM/c/b1H9ScCDVgTvg2CB9+5vuNvzZtf1lT8GASYKGK0T+lA3Wsnt70X/aY1aiYxbBDIvNYa/0m9HC35uYgEY=
X-Received: by 2002:a5d:64c7:0:b0:216:5021:687f with SMTP id
 f7-20020a5d64c7000000b002165021687fmr36417844wri.295.1654890738143; Fri, 10
 Jun 2022 12:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608223619.2287162-1-jolindner@gmx.de>
In-Reply-To: <20220608223619.2287162-1-jolindner@gmx.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 15:52:07 -0400
Message-ID: <CAHC9VhRfM0_zA6TbZiOGo8nCSRoh-g_J3iZG14DemnXTxGRsoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix typos in comments
To:     Jonas Lindner <jolindner@gmx.de>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        trivial@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 8, 2022 at 6:37 PM Jonas Lindner <jolindner@gmx.de> wrote:
>
> selinux: fix typos in comments
> Signed-off-by: Jonas Lindner <jolindner@gmx.de>
> ---
>  security/selinux/hooks.c         | 4 ++--
>  security/selinux/include/audit.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next (with the duplicated subject line removed), thanks!

-- 
paul-moore.com
