Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02895B6270
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILVDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiILVDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 17:03:47 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72FA4055D
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 14:03:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l6so5190777ilk.13
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=mEkmnsvJcDoxzrCI7XRa3j6cxdtSQiMKgQbcT27Ej6w=;
        b=KapgYLBBYUAUfMsE/Ymk+sGqa4E+Zf7lb8SaVhpOKv4SGVLYFc2PG7EOTlehFvGs32
         sI4wMs/16/2EgC2CyFdG4iSAfCR8oQHW16Wqe1mKD2N9wwNvwSAPVjtLCnGCNBdUw6lO
         h2EPgqLRCRfB7i9pHebReTa4gghffPDCnbvuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mEkmnsvJcDoxzrCI7XRa3j6cxdtSQiMKgQbcT27Ej6w=;
        b=3mVTG+B8tvnwa1yjR8QdWwT24XygULvrYnvYJRiZ57WvRcsyKJ3KvT8HboEICVcwjH
         QkRoiIEDEPm47U2hd3FwAMhMSRFYWThTxpFo9d0mOKNECmco9vN1aBu2dMMCABhyF2K8
         l/qErf9ojoxW3y4YagLkz0tVLOhexZlGk8aMN93+DPnS5Vzdw9k3s845kpQ3ll1yrhOm
         BiJ3DiP2HbtviSXGIxjuFVM+Ak/V4SSPIJz1jmvN/r4VaVonmWmMdzn0hxH0YepkC3PY
         ekZPuoluAicQyS4G037XFXLRaGSjTJH/eZAJW21V4/TQMObLDx/mgT+ZGdwUn0TDg43+
         rkpA==
X-Gm-Message-State: ACgBeo0XR72tfaqOsH7Utim/Gf89sGroWrMcyXEwjUVS829K7i2Jiquq
        +yp6WDyRCUwvlOmBjU2qT9Xi3wGvSKfX+WHQoMHWx92rE47V/w==
X-Google-Smtp-Source: AA6agR7x3n7wH86D1+KqbzliXSv7uFh+IEVaYyIrIWRB49fMsotLdMbR9pTEc21772fThrXTQV8bAA2Uc9X+arfxwQk=
X-Received: by 2002:a05:6e02:1905:b0:2f1:d61d:e6cf with SMTP id
 w5-20020a056e02190500b002f1d61de6cfmr10955061ilu.127.1663016624110; Mon, 12
 Sep 2022 14:03:44 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 12 Sep 2022 14:03:33 -0700
Message-ID: <CABi2SkVyBLZdAGpjio+EbvaLRjPpEXowKzt+fMwp-_ymVOWb0Q@mail.gmail.com>
Subject: Remove dependency of BPF_SYSCALL from BPF_JIT_ALWAYS_ON
To:     bpf@vger.kernel.org
Cc:     Jann Horn <jannh@chromium.org>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings,

CONFIG_BPF_JIT_ALWAYS_ON was introduced because of spectre.

However, it has dependency on BPF_SYSCALL, this forces a system that
needs BPF JIT (because of seccomp) but didn't have BPF_SYSCALL
previously, includes BPF_SYSCALL, and opens up BPF loading from
userspace.

The work around for this is to implement LSM to prevent loading of BPF.

Is it possible to remove this dependency in the kernel ?

Thanks
Best Regards,
Jeff Xu
