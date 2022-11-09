Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41B62216D
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 02:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKIBu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 20:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIBuZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 20:50:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3335C66C8A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 17:50:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k2so43132578ejr.2
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CHKwNY7lNvaQ1tqWSwOW2GC3Rryr6gJvU7SNmTbBQNw=;
        b=RJIvGegh3Vx+k8QeImlZZSBHZBibThgCz43HGluNa7VH1PLbIlZ/LrIUxjXEMWBAYU
         wJxoRL4s2lTl6IgHAxgE9p9aUGDG63PBsmId/H6ZhfbSK6AmH+Up5mNpw8t66/TB9wWy
         dYEze2inRgy2KF1Mme1UPCfYq4dks90qBx+qAH1/3+yGU4d8gC9pZ7VvqZz+An2Afzkh
         y+bRoNPftWDYhNiszRrZPhlNkmzRA4w+2gmJ4g056AvtxSLfFROQ83wEZJYOMXVOyzqb
         /awomErNQ6f8mNWjr41nTdvla5QFxik3/m7eTjC3y/TuNeUAzYWgbMyjqyj0FmNdjMBz
         gReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHKwNY7lNvaQ1tqWSwOW2GC3Rryr6gJvU7SNmTbBQNw=;
        b=xB7Jk09S8cUC7IQh5ir4NORd157Vm+CSjVBEH5Nh7ELFxT6WMhN8X/jPd6lNj3t+/R
         teN4IXq+scpOnhxUCplWc+rHsrHlhIod5Bb/V8KjkE7hInq/0uLu0LnzfZWg25WxrYd2
         32YzfJRWgXlHu4PmUwHgroDvsgRQasi5iQ7KSo3EcaUe1+grf7Z58eOPAYiu7YDfyC2E
         XiPafYnczVtliGi4mbu7u581B2MaskH8Vo+JyUvgrFgNWnz34LJcZeEyMFGqyv44hV6w
         I6wKwUIfrmSH8Uq3zN4LDjJtm0bmoMx9qrv7m1MBwpqJ6WU1aLJWZLuYncrpaPDiKqWG
         kVDw==
X-Gm-Message-State: ACrzQf255bMLMhG0lvO6iuW8i95BgB8uHLjtzdh58VN75feY8wooeCh6
        B9lRb3kr63F7Hgjut84yDdUYmQ0MX12L3B69Mxo=
X-Google-Smtp-Source: AMsMyM6BGHpTds++Gj69aAOY1x50al9k/k1k8qAAj3C3RRaCLeMj/gcrcGtSF5U7XN4kTUCTHwBT7na0hL/0O+ZeKWc=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr56201427ejb.633.1667958622757; Tue, 08
 Nov 2022 17:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20221027143914.1928-1-dthaler1968@googlemail.com> <20221027143914.1928-3-dthaler1968@googlemail.com>
In-Reply-To: <20221027143914.1928-3-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Nov 2022 17:50:10 -0800
Message-ID: <CAADnVQKZFkr8T9g=kQRujDWMH_i2P2Ge_jBFG6wjqO6PazfFEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     dthaler1968@googlemail.com
Cc:     bpf <bpf@vger.kernel.org>, Dave Thaler <dthaler@microsoft.com>
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

On Thu, Oct 27, 2022 at 7:46 AM <dthaler1968@googlemail.com> wrote:
>
> +
> +Thus the 64-bit immediate value is constructed as follows:
> +
> +  imm64 = imm + (next_imm << 32)

Are you sure this is correct considering that 'imm'
was defined earlier in the doc as sign extended?
Maybe use:
imm64 = (u32)imm | ((u64)(u32)next_imm) << 32)
?
