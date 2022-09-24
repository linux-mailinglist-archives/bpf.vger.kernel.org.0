Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE05E8C2F
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiIXMR0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiIXMR0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 08:17:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB493AB427
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 05:17:24 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1278624b7c4so3598240fac.5
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=9X5JvEynvA1C1XoBtqAKn1QEESEwSN8OwfX84WuVYQg=;
        b=UjlhuPkqv33pEICdCtanevp2DqXCmvQzD+pkexFURcR5kFML4zKklx7JToIy6o0mod
         8WmImj81NZeqYe709RVMWyZwRrOWHmUtuvX51BksExvU+ymVkxitlcd+0Gz0tyZlPt48
         YV4rUDF/hKOiNvdq7gTnx6nVkB5UH2Y6CrbO1l3UEFe5B5pDH6HVFz4s4ikv16Kzxi5l
         d19ACjW+3p1cwBZ/Ya3EMoGwo767rbwBD6dDVeNrhuaFKtZnvUxVpVaifBTj9ey0zhlA
         p8E+K4lTmhft/KlBSxU1dTcET49B7X613wIgp0FtC/Nzp2gxDlIY/UBFJ1cqBn8e0ddG
         RPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9X5JvEynvA1C1XoBtqAKn1QEESEwSN8OwfX84WuVYQg=;
        b=06/ovS0ww19CLYTVuHsKisMyTX17+E/iq52gkJKwUzPAEnldbgF9cYRHCCG6B8QaNe
         GNKqc54JTYfE1wD7AddZeoiN65GRvGKG6zlSRc17U+A0IChouSByoRdY/3ik3qtPlwZD
         wbP2HhPQLeo/6KK0Ym2jEfymu3isSDS/Pk7ro3jhAJGDdbWxAmCxk48Xry+aqQSX+l0y
         oGvqIogS33GERbdtRIu7VKxEHsiY6/RiFTmbm/jorHdtkaxgCGRilpNv1e45h9sVPhiq
         yE8hr5nCk75y7Pc4NOgEb0PTu1ZHdY8o1px12ijHKpcPuPytNYTgMCumrEMXihW6grId
         D12g==
X-Gm-Message-State: ACrzQf3lAU562hOfzNqDt0qSU7ymd/OwzROmsZHMwyw/bQ6JW/LKAAf3
        AsrHRsYh+7k5Y6FPlgVOsnmghGsZviSl+4XfMhM=
X-Google-Smtp-Source: AMsMyM4Yd8HEf/u0YQWDl0rueY+eSug8AI8kvaD28HJY/TMIrIpXYHs39KvrFDGXHixr0VmFVq2UV13KEKdmggxb/Ek=
X-Received: by 2002:a05:6870:524f:b0:126:7220:c90b with SMTP id
 o15-20020a056870524f00b001267220c90bmr14188165oai.21.1664021843631; Sat, 24
 Sep 2022 05:17:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:49c8:0:0:0:0:0 with HTTP; Sat, 24 Sep 2022 05:17:22
 -0700 (PDT)
Reply-To: mustafakaboreadb@gmail.com
From:   "Mr.Mustafa kabore" <mn9638585@gmail.com>
Date:   Sat, 24 Sep 2022 05:17:22 -0700
Message-ID: <CAPEMB2cJwXoN=onDjHOKevHUaPawm-WZGvi=hkOiKYQgsTfqpg@mail.gmail.com>
Subject: GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello dear,

I am contacting you again further to my previous email which you never
responded to. Please reconfirm to me if you are still using this email
address. However, I apologize for any inconvenience.

I await your swift response.

Best Regards,
Mr.Mustafa Kabore
