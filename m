Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09C661459
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 10:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjAHJor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 04:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjAHJn7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 04:43:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08122167FA
        for <bpf@vger.kernel.org>; Sun,  8 Jan 2023 01:43:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x10so5401917edd.10
        for <bpf@vger.kernel.org>; Sun, 08 Jan 2023 01:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=Qe45HwNg7p5qqmTnF6alKo9Ouj2BwgO9PcI+g6fIOW+QAfTSIb9Tu8sMWI+4Ipvg3t
         rifpCipOCFch7Pvhhi1elVRq26Ymr537oxctAWMo2taVACQZ5pdkXdOgI8ExXbTXIdM4
         YXVxmZsig9GTlQGnHvr/JTgDocuGbPURJYepelWpVbLekdtfoQmWTy4z6K/9uBA95Ob+
         kOt42yITqONu5yo+SYZ94NoAC6s7xhAblhtNyEWQ0LMoh60i6eltD+T51OabTEUxZ9Ft
         LbIlcmhicKmke3psco5qqwuVBxo7h4+Y7Ukc+sJb20E0AestQztLMxCX9J3tsVKtCjDj
         kUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=k9fCSnX2S6jceDz6SnUsli5Hedz6Op8f1YuPpB4iMk5MyYlYpgWQhhnGuaNYQScqWi
         alfwSOdx77Ab+ZGj8ah50F+hH3fxXa7RjBbEn5m/sixwgUoVbhe6bXvjpVQ3Iy/yRBEM
         n1pIIWEf1/vyQMLrkEsfD/Oi770Mm2fU23qPIL/jDSrpZHcu1gB18ulqFTpSauOV8zQc
         WidJzOHy1gh80+vGnz8K58roH2bjPpVXahrQyPP0snWbvTtLT77oNZxd7KdSODkcEUTi
         e4/1TIZtEpzw0NW//ZO9Q428CLbjxVsp8fmSdSnk7rjmKNqkEcME703cU4atAX8166dH
         olDA==
X-Gm-Message-State: AFqh2krKZmbDkKXrbre2tYH7mmbMj2yj1NjPAWa9hEcEHF8KU4LjSKaN
        t89mkij691/EK8xxhCT09HRAFSK8tOKuY/RbxYc=
X-Google-Smtp-Source: AMrXdXuWmenPHRUO7GL4gprWEAbayp5AOgCyrqagwKhtrGzDPzXW7dv9y0tEw8Wvp9fYjz6KsI2MbNTersFwNL3H4Fc=
X-Received: by 2002:a05:6402:291a:b0:489:644e:8bd3 with SMTP id
 ee26-20020a056402291a00b00489644e8bd3mr4038307edb.422.1673171036468; Sun, 08
 Jan 2023 01:43:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:8b11:b0:7cd:5a90:3400 with HTTP; Sun, 8 Jan 2023
 01:43:55 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <maryamm77775qqqq@gmail.com>
Date:   Sun, 8 Jan 2023 09:43:55 +0000
Message-ID: <CAFKE0mA_coGQE7MG8q1o_OB1XUaDsZD8-gfGDKtQa21mur7cWA@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4885]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maryamm77775qqqq[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
