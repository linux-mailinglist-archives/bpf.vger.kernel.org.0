Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9865B9913
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIOKsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOKsQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 06:48:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007071BE9
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 03:48:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y136so17664304pfb.3
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=tOzsb0wsleSC7D446UOdhMDMVHYTzuFRamlibx9jOVA=;
        b=Lalxk+0C1ITvdkdFZ+w+1Qu4dI/ga+bNpF6ki8f3EMObLyg/3cn/JXSV8glNDYtaHO
         B8dmYHHnlEER05+HcYAoIHt9NNb3qWaejvwwLFFkNUT/+eCuqryuAXiBmskD1vSg/VNI
         y/p5eOV6alaMPy2JlwtBOt/0DkfW0tl00ZOkr64QqNbqUpyt5b8D2hdF/I5E0371my+S
         f6XhlhdMhdMJuTZaiW/fXL9IUyZJ7GFcd3hKiPZit5M613iIX2/bojaN1ZaYCkiAOtcT
         oQHu1hJl9PFy91oG3zT7OENTq+L51jnwcc6v3QkxGnUZQSK2qMaV32tGz/VArPjjFSEW
         3gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tOzsb0wsleSC7D446UOdhMDMVHYTzuFRamlibx9jOVA=;
        b=fDZGi24ZCA0VfgTpx3qFpNQiiDtzvekEisuUTp96nev2unO/XD85Fo3Io20FU65hVo
         iZN6su8udJjNdBENaRxWvj2y5i1KASzLt9o6J52o4i9ftAb2UMCySw1c4ho6cTis6cE6
         Q6bca6kPCVbOjnWTbI4HMMGKhQT9SHIwkywPb7N6FldIpr8GaEL9b615UtjDUX7OFW34
         lagZzm9wsEKRDCbxuhIwpbioQ5mmxzhIPJ9G7eM4AcP5YlFUuXW/t6z9oAr5umI/EOMM
         neF7/x/i22YciHs5abYYbemcl8PhVBuGV3SfjEMPJajs48cyNCEVfxEWG0eGUeKu9zfe
         MVGg==
X-Gm-Message-State: ACgBeo1KHEDrwLPj7b81bY7IYWRu+v2G4+PX0viQZTqUaUhIDt0mE/CL
        VCYzl1F0s8P8pk5wl7EZGbfQtFLmb4kX3qPJ7lo=
X-Google-Smtp-Source: AA6agR5yZhOdbEk4aFT2ZGyr/xIEI2FhBR5V5hU2bzGyQ+jrvYOkLPU4cqTSl/hqriweYa9DLRg37VG4/5Ko5MM9qwY=
X-Received: by 2002:a05:6a00:21d1:b0:542:b916:c48f with SMTP id
 t17-20020a056a0021d100b00542b916c48fmr22451339pfj.56.1663238894879; Thu, 15
 Sep 2022 03:48:14 -0700 (PDT)
MIME-Version: 1.0
Sender: khalissylvester411@gmail.com
Received: by 2002:a17:902:d486:b0:178:1f74:e5a0 with HTTP; Thu, 15 Sep 2022
 03:48:14 -0700 (PDT)
From:   "Mrs. Jacinta Kwakeso" <kwakesojacinta1975@gmail.com>
Date:   Thu, 15 Sep 2022 03:48:14 -0700
X-Google-Sender-Auth: KZSU6WRUJOgvie6p7c-9TfqxLWg
Message-ID: <CAKixAHAGnm29iTVswMSQKtOq5brtVm=oVwRJq4_f1xVp6JP0Mw@mail.gmail.com>
Subject: PLEASE CONFIRM YOUR INTEREST FOR MORE DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Greetings my dear how are you doing today? My name is Mrs. Jacinta
Kwakeso, I am from South Africa but I am working with Banque
Atlantique in Lome. I brought you a business from our Bank for our
mutual benefit, so please do response if interested for more details
to proceed.
