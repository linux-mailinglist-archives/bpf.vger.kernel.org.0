Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0324CEE7E
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 00:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiCFXaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Mar 2022 18:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCFXaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Mar 2022 18:30:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752076396
        for <bpf@vger.kernel.org>; Sun,  6 Mar 2022 15:29:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so28394111ejb.4
        for <bpf@vger.kernel.org>; Sun, 06 Mar 2022 15:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LBbYRpychyx/epr4+qrpYhKlN5yyV6mbRE3oixtpU+Y=;
        b=jXs5cplpJmocTFoGKzgGONhhVj2nj7/Xo9i1F0rCeX46kbFWTfVy0+8dETCGIKj5KC
         er6/C93PqDyHdY+vIrDroAeqYN2udQuDfC8Nt0x/d7rs3wPcUfo4UuMy0Xw3T260apbd
         NjHcEjxq9v/NsAjIjX6JZO7Lwddky1B52U9xu1HyJc+/iWWxlJpOgKTgfKUXRCKR5LXF
         fa+F/r+PiaPTXU4HeffKjIcn8xHqzzES5KXrIycX9h1c51uUiCpgCdQe7GMhiW9wolD/
         cRDFE+hVtDRkZZTHrZgQAcueoWsBc5H5D00hL8x02xgWZtEeeP948Dsr3/8bp3lSihm3
         Gy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LBbYRpychyx/epr4+qrpYhKlN5yyV6mbRE3oixtpU+Y=;
        b=44t4Dv5XRzherX+dHGxZp+oE8bcqwdfUCLeDxVTVkUtM4H47tV9MtOZd2vJIZOOQ3A
         nkb7AQM/mg68BDL7N57jnmVzE69+4Fj9+6DeSo/o0HPqqpa2/T174zJLaildV3l+/Q/G
         hbPaDt/O7xMmkZ5JzhcWtd+l+WB28YA0NmJ5acAMJhY9a7KIB8VcQfoWD4gcN+OktW44
         CZXinE3ks9HDf2mJRWtAcEdscmd89j70dGn57CkFF2qu9IYPgMjyDyzjq/69QY7IGn4t
         4FsuHs0Q/7MmU4B4wPk9a7MAzsfZnL5UAXjGE+X2c/DEH/Qtba7Nyt0qB3iefUfz0nD3
         kMyg==
X-Gm-Message-State: AOAM530vawPdL8jlc4ziyk3rJ+dSPnIfRN9fCpWd62xYR9obEvGdQg8l
        jLwT5pzlBqx+mCmuaeH64Mh/r60FddHXntH3XgQ=
X-Google-Smtp-Source: ABdhPJytBtBxgQFuPjqleoWdER80drRKb9RHwdOFOfrjCx0assaGmC9JkRHUZnBfpkFtaTBmh0dpZsRYNX55XcUyeJQ=
X-Received: by 2002:a17:906:4e8a:b0:6da:a1df:98fe with SMTP id
 v10-20020a1709064e8a00b006daa1df98femr7181547eju.66.1646609347075; Sun, 06
 Mar 2022 15:29:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:60d1:0:0:0:0 with HTTP; Sun, 6 Mar 2022 15:29:06
 -0800 (PST)
Reply-To: j33ciss@hotmail.com
From:   Justin Cisse <marieouatt4@gmail.com>
Date:   Mon, 7 Mar 2022 00:29:06 +0100
Message-ID: <CAGd4V1t1T3cdWK-vhkRGqp8OXf9_OsFMJ-WusfC0SECHwz3Wgw@mail.gmail.com>
Subject: TT:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1402]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [marieouatt4[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marieouatt4[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
I solicit your partnership in a transaction business that will benefit
both of us, detail will be disclosed to you upon response.

Best regards
Mr. Justin.
