Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8E637CD4
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 16:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKXPWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKXPVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 10:21:54 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DF10BC
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 07:21:38 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id z192so2183924yba.0
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihut9iEAujirpurbKCNL/zw1Q0Wu/szAUozcuq6crd8=;
        b=kLvkNNhrq1JQdyx/WAaeyr/+FrsK220fe1a3ZWGr4Db56S//zpEIRuGVdGUKckKMwo
         7EF94MP72Dv/ibJN1cRlVhOsyPs3qmnbVcVk+SOo6P73oZiov7oJC5SsbatPI5kQHvPu
         RRLiL2lW0Cv9DOAXFQ9TFjfb5uODX3nEt/yDsXkpFQdC6GONVV/9IVluOEY/bnOjYZvx
         icPkIybNXS5mk83QnJo6B3gXWjprdAnQQ1SkENu2brtImccrUcacfnebBEb/zylEQR/1
         8sgUye7qjNQmu8aBCoBdKZr1sCERiPcTvVoyZHGOr2DvsBwNtHxhJI5Btd+eEgPuwXyw
         KSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihut9iEAujirpurbKCNL/zw1Q0Wu/szAUozcuq6crd8=;
        b=taVflxwz2LfDvC1AQp4JZhiTrlOBxDV4caJbtHlaxkvEeHG+nZAnuN4ABXo1maYOpV
         Hle7D2ifUIRz+qiZkMa0ljpYqcSP2ELVOiq21loRyQD2EaY+/VBoVNfekrxGGA8wYGXp
         zwAIAvx0a18J/gMEMOOVs9FAZs1m6pWazPg5go712TGs+cCkG1D7FrbMxIq0RK1dGChm
         bnzud4x7cYxFrzuHr2vGbL4ujh306RZKgUuWTbAvk+o+gap9rWze4SY469jg2hgvL60C
         jRcMWq0vwwe31m//aTZJqPbCyuAHpA/wbJVZzL/UcRSw24gQceiQxu7VBNM8HIgumKYN
         UkLA==
X-Gm-Message-State: ANoB5pk2LihYwPZ96iKCadyf2LVow9eZ9OUxD8ujAi7XCBfbAg7XbMLe
        S603yHIPP7y2Z8muBuMvSl4+PCHLgym7iPxTLHnv+ReHK094rhzB
X-Google-Smtp-Source: AA0mqf6Ky0pbvfRoYwZhFpfiheWgO/DIIySWrko793BVtTH4UX7ONMFvZb2H1NB1iB2lkDJh8mAFS0lgRXBWgxCLyY0=
X-Received: by 2002:a25:ad8b:0:b0:6de:6c43:3991 with SMTP id
 z11-20020a25ad8b000000b006de6c433991mr12135978ybi.604.1669303297424; Thu, 24
 Nov 2022 07:21:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Thu, 24 Nov 2022 15:21:26 +0000
Message-ID: <CAC=wTOgOMCh7bBdiQMLPPKRUui53oQUKtBUim5LVZz3w9Aqp5w@mail.gmail.com>
Subject: Re: xdp/bpf application getting unexpected ENOTSOCK
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The reason was a mismatch between the levels of libxdp and libbpf in
use. To fix this it was necessary to add -fPIC to the CFLAGS when
building libbpf. I have raised a PR
https://github.com/libbpf/libbpf/pull/631 with the fix and a little
more detail as to why I need it. Please review and merge.

Chris Ward, IBM
