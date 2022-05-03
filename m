Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C871F517F59
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiECIHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 04:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiECIHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 04:07:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8D186F1
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 01:03:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so31930100ejb.6
        for <bpf@vger.kernel.org>; Tue, 03 May 2022 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hYDRpHnxXjWPMvYH/KM9kBWOvFJKIHzs21f3ZI3HBgQ=;
        b=SY9qahOeqk66kmJ5hZx9kzobwu3vL4hsdh7lJBKtFiYWK6k8Kb8u6AhTbJg1khqWuX
         hngaFoK3EXd2t1nsEACqkX1IXlnaYmHAXdv/7KVwMO35Rs6xRoCMZVnDH4cKVHm9aShx
         1Oz2g3O5YrVPL3tAQ+r4ktBfkGIEz2oMwgWz+24mR1FZG56e9vZ0Yo315XdiGJJQ+xuk
         rCw3f5OLz5Ovmu2Op93B5FLmviXjh70opxnCDYVvstZErPXfQQCu2if7DyVGG7VdsJ6B
         nrw32yFRZStVSo13qxIqjbtSamaa/IjtHjANZrG507KoRB7y15agC+xycD3iDnIv5D2k
         fgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hYDRpHnxXjWPMvYH/KM9kBWOvFJKIHzs21f3ZI3HBgQ=;
        b=kgEKsFJ+2E0YcTfXfVUsIUirt24XkHSsP4dMonvA5dATizx097xrffKU7E6hDS9SNy
         qt8s+b7JK9SWBAlwD9ZH1ER1st7u2Dg5vX52hJejyfcsSPwVJkUr1ujxgtI3PduwB+2e
         oyurQfTxKqFSEfeIPb+GvkVLdcfrW11/cejUkfw8yh0jV28hxF/sQbnvPWETfTJqXi7M
         Dm0z+UTtjjWdF6JHii4GDvh9ZcklA/7Q/XvcqUVRdqytcRhUHST+r0dCvLGwLIWstsHh
         L9mgzV3z/KPRIWAUkZn7KbSoy012CuSqwESXwAV2yrRZOIh5IG/nQhRMjng9j+khiBZE
         MfDg==
X-Gm-Message-State: AOAM53076Ztb/GFnH3sNJnU7m+HkvGEHB3fYnTWg567gquDindByd++S
        qvISKAfmRikma10gKR2SpDfPOHrU72oYwPFKdmoPmZ+e8Jo=
X-Google-Smtp-Source: ABdhPJyA3I7ajO1Qh/NHlulyJ3S971o3HjoyFjXa85BLpW4BMr5yww7qK3LouzdDXNuEXe+gZ7JrvHeBJnyaLarHhWY=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr14471201ejc.132.1651565025525; Tue, 03
 May 2022 01:03:45 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Zimmermann <sigmaepsilon92@gmail.com>
Date:   Tue, 3 May 2022 10:03:34 +0200
Message-ID: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
Subject: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm using a kernel which has TRACING and FTRACE disabled and it looks
like BPF programs are unable to communicate with usespace.
I've reproduced this on aarch64 and x86_64 with both aya-rs's XDP
sample and bcc's "tc_perf_event.py" sample. bcc's sample uses
BPF_PERF_OUTPUT instead of maps though.

Everything seems to run and work correctly, but there's no data being
send to userspace resulting in no log output.
Is that expected or am I running into a weird bug here?

Thanks
Michael
