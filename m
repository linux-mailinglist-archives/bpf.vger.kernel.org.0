Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC0516F52
	for <lists+bpf@lfdr.de>; Mon,  2 May 2022 14:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384908AbiEBMLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384903AbiEBMLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 08:11:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137210FE0
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 05:08:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso145055337b3.9
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2Jl5vcC02SFSusgeIDZwPWGDpK4CdDhLpHmFIBUH+/A=;
        b=WLNtctYFO33LGN5oYD6XiqtgIp4h7tSuka9fk43CYClKnEoGpv1Uv54y+Dk/HJO9TQ
         fKcV0ox9I9ZwHWJFeC/qVqA2SUEaT/8fgozkWnsmAN8kKvB5nieLkFxRZeudqL9BhF6L
         AfsMGqhXDjlYkryC65HDjnHCOW4Bzjzs1/Vuqqx/IWG0YUO7F+nXNXXjbtvNF5J7UJ8g
         +l36x8mRPfHpzl3gDTXQWpg/wvv/tJuGNL96SpE6TUgh9dZIWN5Yxb/N1CuD5OQpSgMR
         Pf0v2pyn0AgT94wsqN6hrfwNWSgAj64vbeRAmBhC2hLLP/z8NRA71ElvtLvFvrQnbx/a
         Zfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2Jl5vcC02SFSusgeIDZwPWGDpK4CdDhLpHmFIBUH+/A=;
        b=ndfClCCXA0Mf99txhOvBN08MhM3if+F9dBizEYcCmaumwV1Sn4FDDHnJqz3a3KQj6+
         DTW7Jrb+jhWyKcPaDNNA8ibrkxfVcQ7g+ecNitGJDpkKFTxF27mU8jX+eLEcAbDYIT0o
         t0bavy8DcIUEXnHsF7CBwafasNHyi/TZe0j7rLMTSG8g7hREnC8k+HSnTjx0OmED1Fs4
         jn/rh9v9Sxvcc9VybHc1leI/GeeITFjyJFfBAj+VrxJiEWu9+t0JXK6lFPsg3UUGOkKg
         I6tQYgx1HfucSk3Ku6gfQh1g+cVGN5VCylBMfR+zo7UTYuKUPPoXhij+q7gNW5yonInU
         aUFw==
X-Gm-Message-State: AOAM5335n/cTEpEztZrMafZwSJMaN/mIah3GNVNP9oT05KVICaacy83Z
        yrbkc4JDpowtAqX+OC5S94BERfaJa5oibBgViow=
X-Google-Smtp-Source: ABdhPJzrRd3xvptsPMuLMdQ4oQy1rQwuFt0EICjG1qnT0lfAb/prJ/n1ZojEPSZIkfCOGkPk4v3yp+vlIoWnBm0HuIA=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr10987176ywm.149.1651493284121; Mon, 02
 May 2022 05:08:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:21c3:b0:177:ee2a:850 with HTTP; Mon, 2 May 2022
 05:08:03 -0700 (PDT)
Reply-To: ahb2017tg@gmail.com
From:   andrea mamon <dauglas.ongdon@gmail.com>
Date:   Mon, 2 May 2022 14:08:03 +0200
Message-ID: <CAAmrL2jYC4M6T0SYNgjWF1mJLjC_pbPBzcnQDLfUC=Jsmczdxg@mail.gmail.com>
Subject: I WISH TO TRUST YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1136 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5128]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dauglas.ongdon[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

My names are Mrs.Andrea Mamon I'm from Togo. There is something very
important I want to discuss with you.
I lived all my life in UK with my late husband from Qatar
I'm a very influential and wealthy woman but I'm sick and dying. I'm
suffering from severe esophageal cancer and have a few months to live.
I send you this message because I want to make a donation to you for
charity purposes. I would like to donate funds for charity and
investment purposes to you.

Get back to me so I can send you more details about my fund.

Warm Regards,
Mrs.Andrea Mamon
