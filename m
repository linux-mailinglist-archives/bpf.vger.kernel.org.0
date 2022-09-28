Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948E5EE51C
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiI1TS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiI1TSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 15:18:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F1F595C
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 12:17:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e18so18581620edj.3
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Jp2+0zPKkE6nX/YkemnITgSbfTJKkrwqY/v0lBmVBwA=;
        b=VVZ2yU7dO03yvaucqbH1YykOsPDj++Sf9tkDTmkaSzikJv6HsdpCs4wUZ3gMlnH+Dg
         LHK84EntzxvpHATUr1gmdqhmUqEgqGXR/1dBINya7Fqrk80OzSij53avCLqjAob5Uj1t
         KIAuDWolQ7zdDWYn2A2CVdBy7aZl07ghlHGkzGiJCbss5J9UtpeSL9Dr++1GF94otLgK
         wbPk+8m2y1oH7g5BBzXO46eqtUaW/7njnJHwMDoqzP5aJJ44yLiF8vqbi94YJTC8MA6l
         FlUSHNOccUyVoWRU7g/w9ka67oIgkcom6V6//HerCH5RKH6ySUi9ltd1jFBejUxU/dFX
         BFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Jp2+0zPKkE6nX/YkemnITgSbfTJKkrwqY/v0lBmVBwA=;
        b=dD+kkt4lNoUN+a7MQ10Qmz59WsSvuqHRHjFWIgj/+E6DDA2wqh25BOwWj98/FIr9ph
         cpmVRUT2I8tMNZxO5ea+Lrj/tKD6yzMqsUeGwPhHEHVLLBTPgUCDItDFcyz4IbOPgEvj
         aK90H8FZ+LrMcP/LVeG/oC7IF4WlpR9JCd97MPNjjC1wa0CDyrScuKTmT46u/mZNNdrW
         /CAgRmpLfXGRUOvXdXISm8wjgwvBUgdiGOKSTkeJ+Vp9kK4b2B4YbwFDi1+a4U8YtCkB
         /TQ3fcH5KCFz0vTIXEluChB4U8RRq3kih70lXDqYYFsEvAGs/KJ0VYBfl5aYQPEH5cVL
         p4ng==
X-Gm-Message-State: ACrzQf1zrIA2Ubx3WctoZMQB6C+uoOJROVeBThQf8d6bxmDpxJuChc3z
        Ig/BMYQx27BDDQ0OeXowVGX88lpG7FDylB6/dLNDzAiSOZkUysio
X-Google-Smtp-Source: AMsMyM5pq7kIWAl0OO8NZ9PCC0X6Qw2EkqYPSi6riIqgWrYddAzT8iiYownGNcuCvRK9+BuqNkKFyPLGF3dNFqnods0=
X-Received: by 2002:a05:6402:1247:b0:456:eb22:1978 with SMTP id
 l7-20020a056402124700b00456eb221978mr25758925edw.374.1664392669274; Wed, 28
 Sep 2022 12:17:49 -0700 (PDT)
MIME-Version: 1.0
From:   Johnny young <johnny96.young@gmail.com>
Date:   Wed, 28 Sep 2022 12:17:38 -0700
Message-ID: <CACbfJv8tn5dZmz=6+SMC4HZV05s-vnV2Nq19pC0D=eTLUu91Pg@mail.gmail.com>
Subject: Is BTF info sufficient enough for BPFTrace and other debug tools to
 run ?
To:     bpf@vger.kernel.org
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

Hello BPF

I understand that CONFIG_DEBUG_INFO_BTF=y will generate .BTF and
.BTF_xx  sections in the kernel image which are much smaller than
those DWARF sections.  But I also try to understand how BTF can impact
bpftrace and the existing debug tools:

1) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, can
bpftrace relies on BTF only without kernel_devel ?

2) Can the existing kernel debugging tools like crash(1) or
kgdb(1) take advantage of BTF ?

3) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, are the
symbolic info and types info in the debug-info section replaced with
BTF formatted info?

4) Given the current upstream development effort for BTF, can we run
bpftrace without LLVM now ? and can we run bpftrace without the help
of kernel header files (kernel-devel) ?

5) Has bpf CO-RE become reality now?

Thank you!
Johnny
