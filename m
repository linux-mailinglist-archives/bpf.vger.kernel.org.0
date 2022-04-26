Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B751064C
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiDZSKI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344816AbiDZSKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 14:10:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400F62121
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:06:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so8832875lfh.8
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=q9PgJYIkekpT1PeN0Ula26SP1wr4OzzucTU5M9tDI58=;
        b=SiupGIsP3jfzaC5yIpI4Nug3pVEDfUf4e8v6qVX36LldNn2Eagnug/8etwBwtz0CuZ
         v1e3e2UiM6LmeprOK2udgxfIj0cwqdF77wJKPWwVBA/8cgf2Wj3h/AuYO4HURfu0dden
         7VkEQ/jfg5qOCa6GZPm2e2sEggo/UVAjcw3SbKpNcCVIe/3IXkQcj254+QhXNvIS2afD
         U99DoIOV40+Bd94ONHyk4lklJ1N4nvjIPtda0yvtAOji5rgXEUZh3Rn8DuOARTx1O4RD
         D8Fg6cvT3Nb2rbw9TI6l9iG5cbYgpp8I+TS0aQgbx1qNh5h+F+kcM/rd/SBzgD+aNeKT
         lFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=q9PgJYIkekpT1PeN0Ula26SP1wr4OzzucTU5M9tDI58=;
        b=khDJqboTf/3DV0GfPkuOvxnrpmKsVeFA/xXq5pqVnRSuWs22o1jolQMxS0fnU3G5dF
         yv/jc6BBTObbyqFJ3xwcYnUwX/obypueDkEwKR2jsp9/9378fpbLllATUTSjVVTMzVtq
         DLLphHhDkJQ6GlyqNYRbTZIGm5mBtGeHxSd29pA2jqJDKr06vlE0f0ALCKwqDE769nHh
         erQRfrlbO/0In1DE8Qpc00rqqIA+Szr+Nim/xQBV1BVDyVi4bn4ljIbPFercbukg/ooB
         rnV0OQ3aaLegzqLo4TWRoSOQ3BURYaJRgIPxdXJLd80CBmIuTHRznCf1hUXh8PKoMZaN
         YuEw==
X-Gm-Message-State: AOAM533mxIjckAhOU1JjsD6iclpP99pdAmli7t69eomNiOXZfhQP7im2
        79HJ/T1KufWrDKQ04jyOdtlYGALM/KEPtzhyGvg=
X-Google-Smtp-Source: ABdhPJzOQZTVGCprR9BjqYcqI23A7O5vl9s1Q7d43zXgy1xiBhB33NG2xUTyUHceB3/+amHoFw1D5gq1XowdJrgLqPQ=
X-Received: by 2002:ac2:5989:0:b0:472:d3d:ba07 with SMTP id
 w9-20020ac25989000000b004720d3dba07mr6013613lfn.158.1650996415436; Tue, 26
 Apr 2022 11:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:40e8:b0:1aa:f98c:d5d1 with HTTP; Tue, 26 Apr 2022
 11:06:54 -0700 (PDT)
Reply-To: mrbeliyogo1997@gmail.com
From:   MR YOGO BALI <mrhuasink@gmail.com>
Date:   Tue, 26 Apr 2022 11:06:54 -0700
Message-ID: <CA+WieDntH3XLG8LLR83mjfok09_C+vCmU2Qr275iOnA=o+m7kg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrhuasink[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrbeliyogo1997[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Good Day,
I am Mr. Yogo  Bali,the manager with SBG Bank i contact you for a deal
relating to the funds which are in my position I shall furnish you
with more detail once your response.

Regards,
Mr. Yogo bali.
