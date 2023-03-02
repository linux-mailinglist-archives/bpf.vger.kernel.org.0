Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58F66A88F6
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCBTFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 14:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCBTFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 14:05:34 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C67EE9
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 11:05:13 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r4so307330ila.2
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 11:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4geKM5E6GOWwgyfUhOHMscrwDUdCmpED2dRL0jhQ8sE=;
        b=M1V5tYRq5yzUTv7DK/JKcy2Gvf4ELWo8NmprFu/X6B1Xf5FROn7IOme9HNOYJHLhKS
         cKX8OBZ6a9g7cRkfsISVpauySkehutfACUEUo2QLxbFlyAsCj6+hGtHvdb724byj35Xn
         i2+qUD5Zi1ysBJCsftM6COBIXfOp+OjJq5K26hiAJwSAfgVpZKexxgH6e/ioxA8S/ZrQ
         hTK2RGvlB+MgWEAiuATCmVfSRIAe2v8wopEqJX2AflFyorzOvb2uOTLEoe5U+TC6vvPn
         iLWjU75tYmFA4f9UAShtfZIZmQQV+hQUsQ+8LOAjl8a0fiXHqGcer/6YtyC/JqJfk8a3
         lA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4geKM5E6GOWwgyfUhOHMscrwDUdCmpED2dRL0jhQ8sE=;
        b=uEkoYGgMkSQyFIV5vGCk1/TF6hLs1+YSIIJ5AsEr/2Qmg2Ux1C26feJ+/ytE8goWpe
         D9tISjnCmh/TfM+25CiWx6bf9lLzwVxFOvjejCYKGB4u8+RCbi2OwE6hhTePGEdrbpxK
         RX3wQmhSs5XME0kRO3fOGYp0mYWiQ6V0DVMiHiOvlnsAZpSRXfgbMUNtOh4B4s1h9yjC
         0mRnsCq+eCoeptJzFqFMIkt9RcSMihW4FSUup05f/482RZDI0GXINH6Ot1aP7m0gXuVe
         RkEicvn9vxwasuWOi/QIuRd5bDfWWbn2byR5Jz0kCWZ3BRhwlbJPvnZH7b0WnCPEhyDG
         h1vg==
X-Gm-Message-State: AO0yUKWjFJsGFEFzR9YewVKPyovE1neYwWcCCrazI4J+B+izBI57heDG
        Q0U/QNEvwRqxAfe5qL8I1jyFbpsziAk87nTmWxKrnnDX36bs+g==
X-Google-Smtp-Source: AK7set+8e8PXIyCcOZi0zV6Hw01zYfq8W6lg5Mrjy08Oc54R2CuOii96b40iLofou2Q1E34I9vuVquDxPDZ9bsiquO8=
X-Received: by 2002:a92:bd14:0:b0:316:ed77:e325 with SMTP id
 c20-20020a92bd14000000b00316ed77e325mr4811941ile.1.1677783913028; Thu, 02 Mar
 2023 11:05:13 -0800 (PST)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 2 Mar 2023 14:05:02 -0500
Message-ID: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
Subject: [Question] How can I get floating point registers on arm64
To:     bpf <bpf@vger.kernel.org>
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

Hi everyone,

I'm writing a uprobe program that I'm attaching to a function in a go
program on arm64. The function takes a float and as such loads the
parameters via 64-bit floating point registers i.e. `D0`.

However, the struct pt_regs context that uprobe programs have access
to only has a single set of 31 64-bit registers. These appear to be
the regular general purpose integer registers. My question is - how do
I access the second set of registers? If this question doesn't make
sense, am I misunderstanding how arm64 works?

Thanks so much,
Grant
