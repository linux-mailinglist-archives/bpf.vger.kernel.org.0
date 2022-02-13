Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057FD4B3D2B
	for <lists+bpf@lfdr.de>; Sun, 13 Feb 2022 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiBMTpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Feb 2022 14:45:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBMTpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Feb 2022 14:45:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545756C32
        for <bpf@vger.kernel.org>; Sun, 13 Feb 2022 11:45:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z21so2959753edb.13
        for <bpf@vger.kernel.org>; Sun, 13 Feb 2022 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=CnehUZwQrYVBpmc2ighYqjEhs4i4jCzhX9nHmTruo5A=;
        b=dJ2lplGTkJju0aWIBQbK4yFg1I0ft+hQqi8HYctWn5GI3ukByFbay42AxEOHdL6hHL
         cOoGb2phFJjf4OkOkioFigB357xlcQ+nilzHYgFNTXARTEl6x3b7/taWIpfyM/jvVO+B
         jav9rnBlRsxcs/M7hgpZt+dpwlnNzC0lX6yEaxsw/S+tRg1REROqZUNx8PSnSIJCAQYy
         6n+QcxJvaTJV+PUTgCAfUjubftlyCZl6X8+oHf/NrKDocHJTsVDGxU1XIphj3L/zQ71z
         v9ITUJky4Y4To0GRHYqSZfOCOvIUxeZCRlZ8UoNoX9SjRx5r4nLQ/kRH3bGZiMega08E
         sJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=CnehUZwQrYVBpmc2ighYqjEhs4i4jCzhX9nHmTruo5A=;
        b=ejCtucb+m+kicq3HAaRK3acjE7RsVFkMqxlMfqKLsNS3QcHDGNkc5XubJlLyEsmoxO
         6Fd1vQusN8K4LoESNLCArDIQDD6c3oOXX0EQ1e6CvItxkR/92DPJzMunVsQa2GgO1O1+
         U0hy+Jq8ZMw93SJORtBDuZZ4lyEHI+YqLq4rIdzhgD2WAORTewFW75paN/rhHYbfh44D
         9mOt/+rZ2LtBqtsP5sYnLUhF1A8V6ualQT2Qm1T5ZDWpBvl58VOw/ClmhIbCdyNQ+LgS
         JvCIKKrlTk0n64LEMgV28jv155ylMy2CEo8iHbDbiuu93Wz63byML95fBKLaJ23d78VE
         Kh/A==
X-Gm-Message-State: AOAM5305OsMB07mXPDlUz6WStLhWwZ6Vcd8PXj+Z7glouptZ9WE5EmAm
        89BOn58BzVMcxuNe3VYckBbQiyvHmwl7INRXdeU=
X-Google-Smtp-Source: ABdhPJwBnu1AFAit/IXX9c6qDpqpG6Q1Su6OlhXdr4cfKk+xPdNwB5xccbt1xFtjHICeDA3Jd40iAi51lEjAwppQnFA=
X-Received: by 2002:aa7:c793:: with SMTP id n19mr12054623eds.74.1644781527947;
 Sun, 13 Feb 2022 11:45:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:7218:0:0:0:0:0 with HTTP; Sun, 13 Feb 2022 11:45:27
 -0800 (PST)
Reply-To: werinammawussi@gmail.com
From:   Werinam Mawussi <christopher.mulei12@gmail.com>
Date:   Sun, 13 Feb 2022 20:45:27 +0100
Message-ID: <CADQsUqiTkO0TLfDAw0co205fru10no9SvHR1_pSG7kyoD20L9g@mail.gmail.com>
Subject: Important Notification
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2945]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [christopher.mulei12[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [christopher.mulei12[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am bringing this notice to your attention in respect of the death of
a  client of mine that has the same surname as you and his fund valued
at  $19.9M to be paid to you.contact me at werinammawussi@gmail.com
for more details.

Yours Sincerely,
Werinam Mawussi,
Attorney At Law.
