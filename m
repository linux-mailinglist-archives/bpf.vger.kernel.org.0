Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B750256D46D
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 07:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGKF5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 01:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKF5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 01:57:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F762E6
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 22:57:14 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h16so2494049ila.2
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 22:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBHJWX3USvKxYN1Z7uNkJF+DxCbPdjhkMJNbV43onyU=;
        b=cODxLwMEbSn5r96wzJ9xGA715iFROSiNK6GTn4eFJFQdZD/x5ZEm3/yF5yF8vtUiUy
         an5pyUMJNb3LhpFrruwR8gDFXIJx59m3ldkYbq6AjSXGOBHNoqpJm4Z0/BKakMCwUG+t
         y1ARfGSrblnQh0u2rSf6zBOFsF1bp7DxBGG3Bfneo58H5W8hCIBx6+fIXMU37QHL1G4A
         mFNdGHdMzV2SmfrWsUPuTqqv9Fo7EBp2t2l8vvPKhFExLGfvyvQmcgn6LZ/zn4Rs/bEd
         UkzRSrM2ycUGOeaXu/7tGicmUUtF9+nAZj7mcw2aMZPq6rp0QTCrupi9h3S7EIXpZln/
         0jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBHJWX3USvKxYN1Z7uNkJF+DxCbPdjhkMJNbV43onyU=;
        b=45C1XIgSzFsqlJRscE0Jc9gP53rLK5mjtI9+SuPxEMQz4jz0vz1X94nXMRBYLkm26Z
         SpNFg3NkBAp5LdieLUohmkONP4S3rJ4LuJqpvt/C/S/PNEx2ue8jsC5SqXuj53m4xK5a
         C06XFV4ZBKl5nSF+1m8MzMaO1XoOXH0gRmkQVxQ29B/MNPZ0uwo1G6z+gWmyRYRccoji
         wVFEFY23RqSmuFIMN9WuwNKQezAfP2URMAhb3i2qPBsob9F2VgXwbq8DHuWeqgXI8XHw
         Z+hCd+nD6zjqfcIb1pmzqQMoJ3NzMQB6LwdKeuGVPR7URGpDVuOR/I1zeHfiC9S1OHKF
         5FEg==
X-Gm-Message-State: AJIora9AAUWW38Pxt/aNLclS/kQBNjec6vwA8D7dQZN2BfhkovOtfQqg
        x/ERVmrbjyL8170o6oZzYUuFeulRjVdLUit0ttKAxdtE3nE=
X-Google-Smtp-Source: AGRyM1tspn1kWuZM4CM6QnlN6DS/3BdpRI6xXzsTKAzUPuOu8agtf2Z8jjmNSA9aD3/ty2SLycc0uW6UtNPnP9WHHUU=
X-Received: by 2002:a05:6e02:178d:b0:2da:e220:518f with SMTP id
 y13-20020a056e02178d00b002dae220518fmr8481922ilu.211.1657519033007; Sun, 10
 Jul 2022 22:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
In-Reply-To: <CAJQ9wQ_tU-zy-f9rFk_sqiqh7y7WDz2tyYW6EJNzii6Y7AE3SQ@mail.gmail.com>
From:   Donald Chan <hoiho.chan@gmail.com>
Date:   Sun, 10 Jul 2022 22:57:01 -0700
Message-ID: <CAJQ9wQ_b=ssxO4RaQ4tLc723ubOXCaTUpmghebc94bYWQ+cBsg@mail.gmail.com>
Subject: Missing .BTF section in vmlinux (x86_64) when building on Yocto
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I am trying to enable CONFIG_DEBUG_INFO_BTF when building a
Yocto-based Linux kernel....but it is failing with this error:

|   LD      .tmp_vmlinux.btf
|   BTF     .btf.vmlinux.bin.o
|   LD      .tmp_vmlinux.kallsyms1
|   KSYMS   .tmp_vmlinux.kallsyms1.S
|   AS      .tmp_vmlinux.kallsyms1.S
|   LD      .tmp_vmlinux.kallsyms2
|   KSYMS   .tmp_vmlinux.kallsyms2.S
|   AS      .tmp_vmlinux.kallsyms2.S
|   LD      vmlinux
|   BTFIDS  vmlinux
| FAILED: load BTF from vmlinux: No such file or directory

I dug deeper and it seems that the resolve_btfids utility is not able
to find any relevant .BTF section (at btf__parse from function
symbols_resolve).

Dumped the vmlinux and also confirmed there is only .BTF_ids section:

  [2993] .rela___ksymtab_g RELA             0000000000000000  17174de0
       0000000000000048  0000000000000018   I      22807   2992     8
  [2994] .BTF_ids          PROGBITS         0000000000000000  0105c504
       00000000000000fc  0000000000000000   A       0     0     1

What could be wrong? Sample config is available at
https://gist.github.com/hoiho-amzn/964eb0cf2b4459f6775d7af1da7b4056

The issue exists on x86_64, I also have tried armv7 with the same
result so doesn't seem to be arch-specific.

Thanks
Donald
