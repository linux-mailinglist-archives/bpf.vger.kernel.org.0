Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388015E9E15
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiIZJnF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 05:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiIZJmu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 05:42:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0986B4F
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 02:40:27 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3452214cec6so62794717b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=5qHKLyi3te1dt1RyL7QjIxdHK0ufwCmUQNApODwOuqI=;
        b=kaRy0Tf7DlVS9aJJvMvOFK5L5p3KRlmkUGCNd4HNnSXjqq+3rwmaihyNuWAc2O5SJy
         bXIiZ6dluQ3RhB/wRdqLTc+wCu7DEfxW6VL6/oM2wcGgE3lPGj/sKDHqPBiFOItDgqBg
         M+PM99+PYX2IQP70pupVv8Q6VAb85d0QT+ekalgm1WeDi/U5cC/KFktejquTWQD8ScNS
         HQ47t7Yokv6l+RanD5vl6WVRq/npN4bVKD9obZ3/cj/k1W337bWyA2b3un6fDbeKYA1N
         c1DAEb4sZV5ZwximgamCrEC3ALzrpJMUpkDOlpukRIkBwoooL/C/JL5ARtToIi6fExPh
         3U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5qHKLyi3te1dt1RyL7QjIxdHK0ufwCmUQNApODwOuqI=;
        b=f2iF3KjJVp6sRgVwAKVff0zgcB1r+4Wc+j2TcnA4vV4PmQfkqPkWVvs0k7r0O1AdG3
         7dcHWLWqOiU6Y776OLXdhlRUft6u8vDV+Ib0T05JjdeXm+HKErF9l+mnqmFwz72c6WQx
         cgAXWOtXXB8IWuRASjmhXZm+WRgHYCIISt7ON/kXrMMCWiWs9lj72RQV2JnQXnOalWeT
         MVVX+YAeCC3Altqn6FbcCN84IuAb0/3DFto3rogG4BSNjpDmtFBfcfCcCS8HfYcrrNaW
         Z4zpIGYTmipRC8KBhVsEcRe2Fme+Mnn1DXV++/9cJRYooR5DONWfRcwDWBodNwznkair
         uCNw==
X-Gm-Message-State: ACrzQf3JRi4E9UH5uzC/Snr8Os19xjfM7gH81oqZQ4RFEUwBSmPRaptX
        gG5aF+erM98BlpFMUOpbJCddcDqhndc3NsqpX10=
X-Google-Smtp-Source: AMsMyM6o9yr/F9grm+602Uy9ASsLtVimsf2Pk9EkGKjwxFWY0Lonu1Zu0BVRlLBAOrE31u7VjN9gFblF90reOPVaylA=
X-Received: by 2002:a81:d4e:0:b0:345:16c0:7cbf with SMTP id
 75-20020a810d4e000000b0034516c07cbfmr19693690ywn.73.1664185183938; Mon, 26
 Sep 2022 02:39:43 -0700 (PDT)
MIME-Version: 1.0
Sender: ibrahim.kabore1985@gmail.com
Received: by 2002:a81:848d:0:0:0:0:0 with HTTP; Mon, 26 Sep 2022 02:39:43
 -0700 (PDT)
From:   MRS CAROLIN WILSON <carolinwilson566@gmail.com>
Date:   Mon, 26 Sep 2022 02:39:43 -0700
X-Google-Sender-Auth: x7D4wcqZNHgPfkPuD1YLMlaN9hA
Message-ID: <CAMumKkn0dYQK+imagOw-yOTSCTfibVZnWon7HPLo09eKjb6C9Q@mail.gmail.com>
Subject: I NEED YOUR URGENT HELP
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6649]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahim.kabore1985[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ibrahim.kabore1985[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.9 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

MY WARM GREETINGS,

 I AM  MRS CAROLIN  WILSON  FROM DENMARK, I DECIDED TO DONATE WHAT I
HAVE TO YOU  FOR INVESTMENT TOWARDS THE GOOD WORK OF CHARITY
ORGANIZATION, AND ALSO  TO HELP THE MOTHERLESS AND THE LESS PRIVILEGED
ONES AND TO CARRY OUT A CHARITABLE WORKS IN YOUR COUNTRY AND AROUND
THE WORLD ON MY BEHALF.

 I AM DIAGNOSING OF OVARIAN CANCER, AND I AM A WIDOW NO CHILD; I
DECIDED TO WILL/DONATE THE SUM OF $10.8 MILLION PRIVILEGE AND ALSO
FORTH ASSISTANCE OF THE WIDOWS. PLS KINDLY REPLY URGENTLY IF YOU CAN
DO AS I HAVE SAID WITH THIS FUND.

WAITING YOUR REPLY
MRS CAROLIN WILSON
