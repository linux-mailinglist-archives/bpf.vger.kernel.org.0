Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8438C528123
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiEPKAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiEPJ77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 05:59:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520026E3
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 02:59:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq17so27605820ejb.4
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kwwaIlAPzbUtG98dYHYYx2ThGuQFm14zkpYkXTJuiM4=;
        b=EAZbWu4HE8adUn3cFR1p8ZhJGunEY23iXRbfqgLia/qljJyGDtdIh/MFTialRPooOU
         d6BYX5f0F1cMtqJ4T59XVtMRK2PBJy1rCtO06pptHEahsCay+ke5EndF5UZJ7lG16ra2
         AJh/MO6vbrEj1aDGDquz3wVlu7wRuY/P2MwVlDrwI3ako7VXhmaI1Wz/O6kBm0cQe3Vu
         R3EZs/z6Wrwajc4vqzdGp1C5Yk4PvYST0zcYCE940M9vXdy/qDhS0qRnW7l1KFCyHXwT
         BSagi1aw4BqByRBRHqum2xESeFZIs34C0PhO1l2RTiaw0ot9bzBwxzv3/7JiTysaKtPa
         z9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kwwaIlAPzbUtG98dYHYYx2ThGuQFm14zkpYkXTJuiM4=;
        b=2c44iGhFYg607SYMt7l6S1Re34BXw7Q7AMX0GmzEBfb1q8KCJVbYVhN9Xnw6NsmuOc
         NaY6uRtT6mOxaqHBOOlJ9W7w2JVAqWVzvl82EATsZXPoFnmFVkhGuM7CnE2jSzXZUnrH
         1zL/I2A0i1D/itykQXVoKPf3b7/GJeet26dayCDRp4XJ3pLnJI2OWhJzlRSRGmhia2Jz
         GfajzcPnx03pQOMbnkFTmrqdPWsLClHUuwYTSwYPrMmwhusNVBE0wOo6Ko8Bj9EaGNRS
         T4vbX9LBr0Ccjrn3r0qkd/USmwMlS5xGk/Iz3atXG9E8TGRuMNoERKq3432f+EPLCbRe
         +4Qw==
X-Gm-Message-State: AOAM5333qX37qkoonZs4CLCY4zWArgxcE1am+g76HJ/j4RtnHa+KaKe1
        ShS9CzaHWSHH5oXSu0+P4sgIdwh77xJkekQ40OI=
X-Google-Smtp-Source: ABdhPJxu0IISOc4IY1o0yUCoz9xrc0Otk9TFTOJP8KORcyqU33oiMW5JyLPyxIURp8PX4g4hXyXNW7aqfwVTrZ2ov94=
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id
 fj2-20020a1709069c8200b006dfbaa29f75mr14182030ejc.762.1652695197042; Mon, 16
 May 2022 02:59:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:e88:0:0:0:0:0 with HTTP; Mon, 16 May 2022 02:59:56 -0700 (PDT)
Reply-To: fundsrecoverycommittee@aol.com
From:   Geoffrey Bristol - FUNDS RECOVERY COMMITTEE 
        <cathydampry@gmail.com>
Date:   Mon, 16 May 2022 02:59:56 -0700
Message-ID: <CAJt1Du+tP72K9XnbrfV7m+=ZXxjLBYMMA3kJ=TPqtB9hB8VdYw@mail.gmail.com>
Subject: COMPENSATION PROGRAM
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cathydampry[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear victim,
										
The United Nations in conjunction with the European Union,
International Monetary Fund and World Bank is offering compensation to
internet fraud/scam victims globally.
If you are interested kindly indicate with your response.

Geoffrey Bristol(Chairman)
FUNDS RECOVERY COMMITTEE.
