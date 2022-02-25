Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02CC4C41BB
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 10:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiBYJqz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 04:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiBYJqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 04:46:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B434239D4F
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 01:46:23 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p14so9639808ejf.11
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 01:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=N3vbBTU2JsxlWKuASglZbHF1OZSdibvdkfjGghC7fB0=;
        b=NDVJ7z/xqLtYtbpsWZ5Z7FUch2q1KPmr4NumUHSZmUlKjzvv3qCw37ubGw+YHtj4u7
         HqRRgh92eCKDlFJoFY56pa24PnKwHPhme8kICbuwm6Wf5d9xi/ZMRe3PFW811kRK2jIO
         yAtmdb9HFOzQqwtDZShdoSpUv47Pu2BhguJoSD7QyMGBIGVelP37/zxIn+3D9qLHBbCi
         SfYjZ1bL0mcAXrQSRvW56bbuDA4+D3c09R+mP7lLbbqnyAmDyPcI8akEG85Nfieb/XQX
         JWGpWYTaHTnGsrkKve+FIdTaITPwW0N+Qtb47sejCyyjAIdSlB6JMozDEIj1ZSnKO+jO
         zqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=N3vbBTU2JsxlWKuASglZbHF1OZSdibvdkfjGghC7fB0=;
        b=V3PeKrP5/46NH4vQ9a8R9LTCaheVX+dP1CXJoOOAVbfJg3/HeyUQqRmRnqW6pG5hnc
         k1DtrJJU7jXfgtjm6i8B5/3aYZjK1wghr8OP6BqyD6ILwsG/cZf6635xoFC1BR/+NoD4
         5HiRe9huAWdGneAXSdJKLivucPzVgt9LvofR9zlPFL8r3eMHvcNPBqnjDaSY8XKK4PTH
         5rxCa6C5D/zRuezU8N+LkCzk0dWi/TDZvcQ8qxRJCEtWOkJR4gJVsFdZ98trOuM9xjWs
         A/vDz+BuWT+ppk+jX25pYLwKvFa5oTUsRQlaTuavE0moHU2Fip3i4KU1vQaQgX6/4V3u
         oo0A==
X-Gm-Message-State: AOAM532booG2AMyeAsIre0XEpzbitKHDX8dpD5hpxOzAnqllLIsWJGZ+
        lA/hfC0vvRKuJl55LG9FEeLrC69kuvb/XtIn6ss=
X-Google-Smtp-Source: ABdhPJwlV/9btwDoLCltc4BcS+34/erGUu6/xL94+7MxCk4uO4bksW6G6h0d+NKpwcBjiIyD1trpRkP514FurxpsMb8=
X-Received: by 2002:a17:906:85b:b0:69d:eb3:8a7c with SMTP id
 f27-20020a170906085b00b0069d0eb38a7cmr5476636ejd.427.1645782380034; Fri, 25
 Feb 2022 01:46:20 -0800 (PST)
MIME-Version: 1.0
Sender: soulekabore7@gmail.com
Received: by 2002:a50:230a:0:0:0:0:0 with HTTP; Fri, 25 Feb 2022 01:46:19
 -0800 (PST)
From:   "Mrs.Yunnan Ging" <yunnan1222ging@gmail.com>
Date:   Fri, 25 Feb 2022 10:46:19 +0100
X-Google-Sender-Auth: lyIcry2f5-QOEzP_wtMVBk8NEdU
Message-ID: <CAPvkLO7ASXYG8gDnvZ10_hUJotOMWhdYdc4iS=U4ZxYioeiZjg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of kin to and I want you to stand as the beneficiary
for the claim now that am about to end my race according to my doctor.
I will want you to use the fund to build an orphanage home in my name
there in your country, please kindly reply to this message urgently if
willing to handle this project. God bless you and i wait your swift
response asap.

Yours fairly friend,

Mrs Yu. Ging Yunnan.
