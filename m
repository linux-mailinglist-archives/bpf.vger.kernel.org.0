Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC46D1EEA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCaLXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCaLXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 07:23:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1D1D869
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 04:23:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so88179802edb.10
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680261822;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+bthYeBxlfFCtMxOH15X91YQ4seRgou3RXDSyMiL/A=;
        b=SA4tCwzSi3GpHm1iUYv8dORw0cOHUoS3+0A5hAG+uYPRx7HAgzeyIzGGnkGVWFi7i5
         3OpPnsh8SlZy96f4/tbunn821vdnFaE/kSibiHFsRtFWmlp1FmWbkc4UHISJKu+U+xA1
         Xz/SoXjZvXIkW7lZssfyMNYo08Mnor1CU1VBFZPoYOVdP+CWd5meim7ZeVvgtcKakCXL
         IWQMdETJdP0ZiorEik4Qx70V5r+FAdCjcNRuPxDNWl09Ytmce/niX1Kbg1Vgs/YSMn+8
         yaF7+/n748SC5qBKBLSaSIkSLl6eNwWM9T0RlOZzbgix01NI4sBSqeB8Qw5KgFT/VwJc
         +wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680261822;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+bthYeBxlfFCtMxOH15X91YQ4seRgou3RXDSyMiL/A=;
        b=wM7dRYF/7/ZTlgvGXMv1J5n+HR7OATzUdpnZ/UWY7mMELQg0USzXAzlmOBs8Au/Q+0
         6CzZlN2otrHi6A6sDajc5F93/dZCQA+BA0ONnQFfxVB1plDige8YFmZ/lc0qj0CYdawF
         EOvm9KVKH59NlER2tuigKg0PBUgMXvspvmvcRrjhw1z2Rn9uclv/bVgQ+YV84Duxy55M
         tdXbHrSgqXPFw7XY3MRQ2T/h5wdQ74Ja4CHdF+uU4NIbaqcOLX+lV5FrKmFW26zHafSP
         hcPKlvl4/q4+6UAzs0wwvCNHGOPd6HRAS40OYZd1FeCw85BoEhyRRNEQbp9YgOASp3UX
         KT7g==
X-Gm-Message-State: AAQBX9c2LA9J8uWDyzlfQDEVBJjnH+3FYMOitXJoT4I2ka170Dh1uSpp
        Dp3yVNGaOHF3pemWDeg+B4WRV/DvODXoZHlIvFnJsTJNoCQ=
X-Google-Smtp-Source: AKy350avjkhtRZldTnDFRPGpF2LhVXe1UjOd37cQrKckDuOAGk5t5BIN8C+rHgEOZNlg1Ag6+MYlEqbUj5sExVHCR3M=
X-Received: by 2002:a17:906:7c54:b0:932:6a66:fc43 with SMTP id
 g20-20020a1709067c5400b009326a66fc43mr12990937ejp.13.1680261821817; Fri, 31
 Mar 2023 04:23:41 -0700 (PDT)
MIME-Version: 1.0
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Fri, 31 Mar 2023 13:23:30 +0200
Message-ID: <CAGQdkDuC9Cu2tvy1nnnaDvEhuE7c68KUUr+t8xi5BzipKis8_g@mail.gmail.com>
Subject: [QUESTION] BPF trampoline limits
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello! If I can I would like to ask one question about the BPF
trampoline. Reading the description of this commit [0] I noticed the
following statement:

- Detach of a BPF program from the trampoline should not fail. To avoid memory
allocation in detach path the half of the page is used as a reserve and flipped
after each attach/detach. 2k bytes is enough to call 40+ BPF programs directly
which is enough for BPF tracing use cases. This limit can be increased in the
future.

Looking at the kernel code, I found only this limit
BPF_MAX_TRAMP_LINKS. If I understood correctly, this limit denies us
the use of the same trampoline for more than 38 bpf programs. So my
question is, does the commit description refer to another limit or
does this "call 40+ BPF programs" refer to the BPF_MAX_TRAMP_LINKS
macro?

Thank you in advance for your time,
Andrea

0: https://github.com/torvalds/linux/commit/fec56f5890d93fc2ed74166c397dc186b1c25951
