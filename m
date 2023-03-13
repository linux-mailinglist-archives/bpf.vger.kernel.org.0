Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A36B74C5
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 11:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMKzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCMKzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 06:55:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB410F8
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 03:55:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id er25so18758055edb.5
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678704911;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3XSqvrj9FGCYS1ksd0C9vpvihqJ2xRJTy45N8qgQwo=;
        b=CgbqrbEduUhQDA9T/3gqqSZSP0kToMpjUPlu2g15XORIeBRhioUz89n7ENsspLUv7i
         jkdHvAhv0N/qQt8l6In+TE9NG3vDbycUDDAc/GO/0Xgl9kwumC9Ti5UKQZUIKZSLdtnX
         rcdWAnuX24zdAkbBqHB2DfFTfxLNQZko80aC4PKEZIt3YQxRNPUfNEgkZz7FC0WwiweH
         vQ0CrrrgStAhS84H8UQ4beC2FRXUY1zI3Ggj+CpiBpmb3ETJyIiI4GImo1/vtd1QL/RC
         +SOCnXc1zv5HUUN2g92XoGJutacpY5ODo445LQYtQWk6LUysXyhoiJjt9vtj15JxONLD
         YX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678704911;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3XSqvrj9FGCYS1ksd0C9vpvihqJ2xRJTy45N8qgQwo=;
        b=5Y10AFV+YrJTnNEs36RporbsX3i/j0PRU9bjJwat/FWy+UsUw2Gc4mxvdbyxoCdHiU
         Jj2FD9f1YUMKN8vNsAK2FqjBa4U3dzPY2M+xN+sI8IVAgLI+aIPqWGI+hJqtBR+lj/oq
         eiNQukVa2zy4lFYwjM/PlCWtto5aweU5WzSI63wYSm/Eot331YPyPAMv7k0ickygjPAl
         FYIwMKPItO32WpfW3sUPDZahXoBUmoW16wfHcDXnbEOiWKNho7ePKNowpio99iAyAc0a
         oNU4WyTlaYCl9fGPtL4gHkFSNsrB+3b10p+b5XP2r6hBMAyFWDWCkgVJbbFRIEtK/HOx
         202w==
X-Gm-Message-State: AO0yUKVP1BrHqTo3NRFziTxLAkQoD7e4jgnyX2Bt8DMememehIFYPB/P
        zag5s9zzWgg/HzBb+vz9XXWaGgF/EEfbppIytL8=
X-Google-Smtp-Source: AK7set/epR7+acaEnX9czNGb15cbPJKc7ZXjktDg9cIgLkT+/KVU4RGvBYXWE/KQEFiTj58wMHSsaklEl7GPW4VR/0E=
X-Received: by 2002:a17:906:3141:b0:8e5:411d:4d09 with SMTP id
 e1-20020a170906314100b008e5411d4d09mr17307729eje.15.1678704910658; Mon, 13
 Mar 2023 03:55:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2650:b0:925:24a2:1f83 with HTTP; Mon, 13 Mar 2023
 03:55:10 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <barr.williamboafo1@gmail.com>
Date:   Mon, 13 Mar 2023 03:55:10 -0700
Message-ID: <CAK0gjPjNEu5ZSNO8zTa2poxsQVeL=-t2XueGi6zWN1A=Zy7dPQ@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5058]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barr.williamboafo1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barr.williamboafo1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello

My name is Hinda Itno Deby Please I want us to discuss Urgent Business Proposal,

 If you are interested kindly reply to me so i can give you all the details.

Thanks and God Bless You.
Ms Hinda Itno Deby
