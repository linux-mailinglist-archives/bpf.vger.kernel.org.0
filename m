Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A088556C913
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGIKuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 06:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIKuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 06:50:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F84E86A
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 03:50:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e132so946886pgc.5
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jxNGQ1VJJ8xK6WwefPrA3m5Fd0FF5gJlzU9B8KV6EkM=;
        b=DvGnGeSh7CMJMBGm4VQmwsHvrmQZw4FI46sdeJE3jb7GyXG+3pA0z6V+yeqb401f6D
         AwxqVQxIbLIKnPr6kugp8iZIs8RpZ6BVi/UfBP9q7mhYnFvj4bBTwoAW43Dt6FQ5a1iq
         92N1LvEnvEp+b7yp0F6mc1VGrYf05iamLTir3mnmdsYjis/FB0JNhwkx3cIqaMDvHvS6
         oOo2UcOPiMIHHrfF0GElJSD3JXk1gWjTUDOplczshgaYxBsDh/7aHE/Ndm8qQc1bBcIS
         oqWIlU4B6gLARpXpQQt2A1u7sMWdp/+9JgyRjk7lhL9E9i87KT8v1WrO0cKc6zHMOgtO
         bS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jxNGQ1VJJ8xK6WwefPrA3m5Fd0FF5gJlzU9B8KV6EkM=;
        b=GsGIfZA7gBfr7UU5o2vqrQbep0tOHzoEXcv9lVX+IirKFQtmqQ9zen8IhLLoJV131c
         Y/5LqucScOlDAsIQoWGedVPDUFCgQtZZavR/giw5X5Hg1eL4edSQ7u/JfFSff5pBEu5v
         OM7nf30sJibA6t7zs7ZzFjiA5z7hTLSA2IBgLr9I72jvxz4wZn/cGGd3dr8HX1eKvExa
         8wVhT8WbcDCzzlS+HsqNMCFHwkjMd1ZHdTJ7llmvQzbEXJVM+bhXh2vMK8rU8xW934LB
         ZBFDK2rQ6sx+dXt879SnBDXIspcnRpM1CG4ayaBVFB+tEC6VyAnJIPcZ1r+MZilacHMB
         D+MA==
X-Gm-Message-State: AJIora88DfAiCvN0bAPQcRE8TKpGDcdNZ5sIp6eqj+Nc1R1Dt6bi3Oyx
        IYK5bIwosrxIXBn0pVONee9EfmmsEEay3THD6sM=
X-Google-Smtp-Source: AGRyM1vwElww8RLUd5nVBn4fjW1J4HrIM4oNsl+ObSCI1QcBLZYoeyEeIpxOE9vezp+/+mFR+g69Ts6t4F6sMi0qMnk=
X-Received: by 2002:a63:4a0b:0:b0:40d:d4c1:131f with SMTP id
 x11-20020a634a0b000000b0040dd4c1131fmr6945477pga.242.1657363839239; Sat, 09
 Jul 2022 03:50:39 -0700 (PDT)
MIME-Version: 1.0
Sender: rassimlatifa400@gmail.com
Received: by 2002:a05:6a20:7d9e:b0:89:72d0:f71a with HTTP; Sat, 9 Jul 2022
 03:50:38 -0700 (PDT)
From:   "Mrs. Rabi Affason Marcus" <affasonrabi@gmail.com>
Date:   Sat, 9 Jul 2022 03:50:38 -0700
X-Google-Sender-Auth: lIScplIYWZMNnSd2FU_-_nqvybw
Message-ID: <CAPuVzFfi0cJYyRmXRTVOsh67gwg4Hg1VBZ2GarmG1Ys9WzdkhQ@mail.gmail.com>
Subject: PLEASE CONFIRM MY PREVIOUS MAIL FOR MORE INFORMATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good morning from here this morning my dear, how are you doing today?
My name is Mrs. Rabi Affason Marcus; Please I want to confirm if you
get my previous mail concerning the Humanitarian Gesture Project that
I need your assistance to execute? Please I wait for your candid
response.
