Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E88D6C3DBE
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 23:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCUWeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCUWeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 18:34:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373A4FF12
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:33:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x3so65615308edb.10
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679438036;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygh2dOnchEjotW1npT2lXEsa/zQJph3IDmf55htkwdg=;
        b=I1HFpoVAYpnDcZyan3O1GnhqPY1svHBlZJ5KD+XYpOIFx/KOVehEZh6MVVe7jhFqS8
         HcMEP0DVCjbP+ZZ9m4dHSZNb7T02VEtvfxCYHNNTyao2nkBsYzZlWshXRTFA/9yHvJQ4
         IGC5m4h7XvjVZ1wwSYcWJw4HPoDoHvwBzyVKezS3CvPbZyCj028jmFNEI/hCYXlgHR5r
         podMV8SbJUVTYl3aJqZTvK7NH0UIPUHDvZqRPNB9lIXuaFmJIaFJtNKTx+qfwfXMP1rY
         8K1DUCzxkfFvDpBdZ+YGTanmala2Y+fIZtSFVt5r8IFKaxFBzGn5+XnPeQB3SIV9sWNU
         INHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438036;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygh2dOnchEjotW1npT2lXEsa/zQJph3IDmf55htkwdg=;
        b=Euygcd/6GI4ZjkC7f7wLv8P1WGWV9JmJOQ55rz6nOeTRD+OQYAZTdfhJIj+2LFjoVQ
         rMNuLC2cM2M5x6LmVQDFsJKERGnyCG0EBAvk2xL+Pi46w8Dpd3rGoPh9ibZxqy9FNUZQ
         e97Z4qsbZEA08VffdqDgVXGH+lAXkGG4BZj5GE3TDXEIP6iLAVBH90RDPUbmMLQCooW6
         tsKKAJkPDYWWiZRc7pItbDmqtUt8zPK7cb6l+YcV/dYjG5uQT/BT45+z8C+i/tGyjVQk
         yqys/kgsWq4MWEXkA3DcldFIFNy01MC5AGd/mh9JmSFs2hCQ/5Hfj41SfrDKEEEC0sE0
         2FYw==
X-Gm-Message-State: AO0yUKU1540dA3I7XuDiAWmzV6x+Lk6V2f4nhb3XauWa+4IlcYmebsFn
        +1OKjIfkC6JhPJIgJ6Gz7MGSbw0YQf7Sc60LNas=
X-Google-Smtp-Source: AK7set8sbLN+VwHN3olQtqhqTrykfLG9XDEAfx3ROKG9rWkdwS80TI/IJzhtwRJrRu3VaTTi+/oJK7RXczd1B17f5Pk=
X-Received: by 2002:a17:906:dd2:b0:926:5020:1421 with SMTP id
 p18-20020a1709060dd200b0092650201421mr2306582eji.9.1679438035723; Tue, 21 Mar
 2023 15:33:55 -0700 (PDT)
MIME-Version: 1.0
Sender: madh89103@gmail.com
Received: by 2002:a05:6f02:aa1:b0:49:b424:e9d9 with HTTP; Tue, 21 Mar 2023
 15:33:54 -0700 (PDT)
From:   Mrs Aisha Al-Qaddafi <mrsaishaalqaddaffi58@gmail.com>
Date:   Tue, 21 Mar 2023 15:33:54 -0700
X-Google-Sender-Auth: HWFPNyCeuCe_AvOduv_DiNLI0sg
Message-ID: <CAN++AGgsxxfgkQkomB85dZ2Hvr6CE2cDRT83v-9X+nxX4ox9Vg@mail.gmail.com>
Subject: HELLO DEAR PLEASE KINDLY REPLY MY EMAIL IS URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [madh89103[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [madh89103[at]gmail.com]
        *  1.0 MILLION_USD BODY: Talks about millions of dollars
        *  1.7 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the name of Allah the Merciful,Peace be upon you and God's mercy
and blessings be upon you
Please bear with me. I am writing this letter to you with tears and
sorrow from my heart.
I am sending this message to you from where i am now, Aisha Ghaddafi
is my name, I am presently living here,i am a Widow and single Mother
with three Children, the only biological Daughter of late Libyan
President (Late Colonel Muammar Ghaddafi) and presently I am under
political asylum protection by the government of this country.

I have funds worth $27.500.000.00 US Dollars "Twenty Seven Million
Five Hundred Thousand United State Dollars" which I want to entrust to
you for investment project assistance in your country.

Kindly reply urgently for more details.
Thanks
Yours Truly
Aisha
