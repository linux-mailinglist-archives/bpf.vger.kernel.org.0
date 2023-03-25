Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D624B6C8D18
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCYKXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCYKXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 06:23:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2411164A
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 03:23:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16so3510719pjs.4
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679739818;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71PnYgVAJ2sH+p9bYNHJSsZPBskJ4aq6i5nHdj4FDhc=;
        b=p1rxStxyf0fuboB/iDcwz85fU5RIrsAtBI7ohdUh68udPVK/McMURQHPng4/WBl/4J
         iXEa37oMFORJMV+Ay9FSMWe/iYo6ccfYao3mpNHtGwZGgiTTLa8lRPjUuKV47a8e66jE
         E47jZ3jDbI2x6KYe0Qu5MLBsl+JFT01uie/XY2hQFNj7J+MX2unU/Sh4WBt0SlujqTRJ
         i+ZVvyQieggTUhhEw6ms4YJTNFVdQrwqyIOQCqGdMgxVlWdOLN+sRCSYD8/o0bl3Iu4I
         sk9J2CoudYgTajwMnj2gGE0OTxEff3/555dbvseMxSvxTPn2MZ1ZNblo42eHFoEI1pNc
         Nf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679739818;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71PnYgVAJ2sH+p9bYNHJSsZPBskJ4aq6i5nHdj4FDhc=;
        b=Ec4KHRtxBQZOkEOhlZRijq7nEl5/KrTpx840XNHuaz0xDjSD1KLVuRjvYlLKKG7LDy
         OCfGx91tRpPFSQvlqdHyel71yQJjt52ujNQDuo3nL2TpvKSZ/LR83Y4R91skXOHKMT5S
         783tAZ+wxcbg09braqBTE3wvydXnP8ekD1iwkspnD7bbjRjwfDAcqBTSaNUQnzZgmVdU
         Qfpuxq5pV2HXWtesSQGCUBpka1W+J26JpUVZLMf/gW30yB0NOsLIxLNy+RoS89feYAIE
         6/mmY5AygtEac8UPjnnuWXGKeNym65280Uvul4C+aUC0x9HAKoc1TvUjsR4F0+NXN5jU
         56Qw==
X-Gm-Message-State: AAQBX9c4gUtRPXAK5m6/dDa43MJJTZ8AoLorcNNcx5GLVid5deoazHwq
        2zatJwf12jCCV+LJcPwUrq3D+uTT8sCuee4hZBM=
X-Google-Smtp-Source: AKy350ZH1Hd/GigTxWCdiKE4Aupryh4uQDcjkT3Gstx1pz+doWOSsdjbi8njadaxvS1QYyOjetIZi+bi2BBTvXxvISo=
X-Received: by 2002:a17:90a:b881:b0:23d:2f4:af49 with SMTP id
 o1-20020a17090ab88100b0023d02f4af49mr1661729pjr.4.1679739818349; Sat, 25 Mar
 2023 03:23:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: abusalam8070@gmail.com
Sender: asimmahmood4040@gmail.com
Received: by 2002:a05:7022:491:b0:60:a367:48b6 with HTTP; Sat, 25 Mar 2023
 03:23:37 -0700 (PDT)
From:   =?UTF-8?B?TXIuwqBBYnXCoFNhbGFt?= <salamabu370@gmail.com>
Date:   Sat, 25 Mar 2023 10:23:37 +0000
X-Google-Sender-Auth: N2aT57i6wTPjBc8t0ekRPKXnqwQ
Message-ID: <CAPmk-nB+PwNQS-uxH7Xa-1Q8WcA7eExn4nm3jN7m2JUZRdD7oQ@mail.gmail.com>
Subject: REPLY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1036 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [asimmahmood4040[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salamabu370[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abusalam8070[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RGVhcsKgRnJpZW5kLA0KDQpNecKgbmFtZcKgaXPCoE1yLsKgQWJ1wqBTYWxhbS7CoEnCoGFtwqB3
b3JraW5nwqB3aXRowqBvbmXCoG9mwqB0aGXCoHByaW1lwqBiYW5rc8KgaW4NCkJ1cmtpbmHCoEZh
c28uwqBIZXJlwqBpbsKgdGhpc8KgYmFua8KgZXhpc3RlZMKgYWRvcm1hbnTCoGFjY291bnRmb3LC
oG1hbnkNCnllYXJzLMKgd2hpY2jCoGJlbG9uZ2VkwqB0b8Kgb25lwqBvZsKgb3VywqBsYXRlwqBm
b3JlaWduwqBjdXN0b21lcnMuwqBUaGXCoGFtb3VudA0KaW7CoHRoaXPCoGFjY291bnTCoHN0YW5k
c8KgYXTCoCQxMywzMDAsMDAwLjAwIChUaGlydGVlbsKgTWlsbGlvbsKgVGhyZWUNCkh1bmRyZWTC
oFRob3VzYW5kwqBVU8KgRG9sbGFycykuDQoNCknCoHdhbnTCoGHCoGZvcmVpZ27CoGFjY291bnTC
oHdoZXJlwqB0aGXCoGJhbmvCoHdpbGzCoHRyYW5zZmVywqB0aGlzwqBmdW5kLsKgSQ0Ka25vd8Kg
eW91wqB3b3VsZMKgYmXCoHN1cnByaXNlZMKgdG/CoHJlYWR0aGlzwqBtZXNzYWdlLGVzcGVjaWFs
bHnCoGZyb21zb21lb25lDQpyZWxhdGl2ZWx5wqB1bmtub3duwqB0b8KgeW91LsKgQnV0LMKgZG/C
oG5vdMKgd29ycnnCoHlvdXJzZWxmwqBzb8KgbXVjaC7CoFRoaXPCoGlzDQphwqBnZW51aW5lLMKg
cmlza8KgZnJlZcKgYW5kwqBsZWdhbMKgYnVzaW5lc3PCoHRyYW5zYWN0aW9uLsKgQWxswqBkZXRh
aWxzwqBzaGFsbA0KYmXCoHNlbnTCoHRvwqB5b3XCoG9uY2XCoEnCoHJlY2VpdmXCoHlvdXLCoGtp
bmTCoHJlc3BvbnNlLg0KDQpJwqB3YXPCoHZlcnnCoGZvcnR1bmF0ZcKgdG/CoGNvbWXCoGFjcm9z
c8KgdGhlwqBkZWNlYXNlZMKgY3VzdG9tZXInc8Kgc2VjdXJpdHkNCmZpbGXCoGR1cmluZ8KgZG9j
dW1lbnRhdGlvbsKgb2bCoG9sZMKgYW5kwqBhYmFuZG9uZWQgY3VzdG9tZXInc8KgZmlsZXPCoGZv
csKgYW4NCm9mZmljaWFswqBkb2N1bWVudGF0aW9uwqBhbmTCoGF1ZGl0wqBvZsKgdGhlwqB5ZWFy
wqAyMDIyLg0KDQpJZsKgeW91wqBhcmXCoHJlYWxsecKgc3VyZcKgb2bCoHlvdXLCoHNpbmNlcml0
eSzCoHRydXN0d29ydGhpbmVzcywNCmFjY291bnRhYmlsaXR5wqBhbmTCoGNvbmZpZGVudGlhbGl0
ecKgb3ZlcsKgdGhpc8KgdHJhbnNhY3Rpb24swqByZXBsecKgYmFjaw0KdG/CoG1lIHVyZ2VudGx5
wqB0aHJvdWdowqBtecKgcHJpdmF0ZcKgZW1haWzCoGFkZHJlc3M6DQphYnVzYWxhbTgwNzBAZ21h
aWwuY29tDQoNCkJlc3TCoHJlZ2FyZHMuDQpNci7CoEFidcKgU2FsYW0NCg==
