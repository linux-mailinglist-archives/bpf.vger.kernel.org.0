Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFE6A2F1D
	for <lists+bpf@lfdr.de>; Sun, 26 Feb 2023 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBZKgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Feb 2023 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZKgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Feb 2023 05:36:46 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716B12F04
        for <bpf@vger.kernel.org>; Sun, 26 Feb 2023 02:36:45 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id de15so1083424qkb.9
        for <bpf@vger.kernel.org>; Sun, 26 Feb 2023 02:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Stk+hX3OuWDNaHgh5OMlTcRkR8tppWAbqwoblN4Dzs=;
        b=gpg92ti2YoS2NHUcQcHNYOZluLQRZpc1d3E+gVVOYfKXafmybeGraAtv+uIMkfodXv
         jIULPMV3grD8oC58GXw9hRx31RnCfS9mJbfWW1NXUoIDqNC6yOWJTn6ByI7L5ANxzyh7
         ZC1Z18LfItOMBT6CW3fJ/Vc2zs9tk2aqf0n7PlaJn64aRwsBdC2yF5uX5+l/LUR2cmLM
         sHsa/J5A9BFOKNGZqWblzuiEAmXAZVUvfJK1TJO5mqGcYID1SyN6LMRFS0kOvy04o3TA
         dq6tZgFEJzaKybbjbrHwA1q279U+EwfdLwQvnIxOWB7MfbBejTHtZmzMubsL/bM+2WMo
         UItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Stk+hX3OuWDNaHgh5OMlTcRkR8tppWAbqwoblN4Dzs=;
        b=PDqrAIA1pakRBCWZuJoMYmFH+zj90Vwsn7ulzTQHLYdXqHikxWq2mDyTO8Ga15CIQf
         /qx92YcFjlRKdOM2fAfKngLb3mEPtHE1pGsMFzh9zv6jcKoUKhB5xsoZsSgjfZoQUhmW
         F2UYfXexIBRv5D8MxikRqZskYCeUiirDnNjr/4CGejoxqOby3siueY/P+kYlOJIVCW1g
         A15zESZqwNUADMprzs+xK7jNZaanVd9cvfsK2MU1UjnnEhvHSlgI2VpwCGQADKWsJxPW
         RTX+mG5hEDndYKvBSB+PnzbT3Rb8kjHq++KQ0tqE5KPAb3WXlsISIHOHjxo1umFe5KtZ
         hZYA==
X-Gm-Message-State: AO0yUKUawzSmQ4HgWHgDiPE5coKk/YXUwJJNUioFfkNe2AsmpLF+obq6
        sMLMFQvL0pKZ/bkbiv7QtwLgr+GYF6MTgg5miPU=
X-Google-Smtp-Source: AK7set9SXRZ3H8TQlEZH0qZehB0wA9Qf99L9jWyx4zm5IFQScvkai/um2m8IpQWCOM3sw+NYEzPMjvr8IUlhwFcyxcs=
X-Received: by 2002:a05:620a:10a6:b0:742:3013:1aa0 with SMTP id
 h6-20020a05620a10a600b0074230131aa0mr3298826qkk.3.1677407804087; Sun, 26 Feb
 2023 02:36:44 -0800 (PST)
MIME-Version: 1.0
Sender: okoinemarry@gmail.com
Received: by 2002:ac8:6b9a:0:b0:3bc:db05:c801 with HTTP; Sun, 26 Feb 2023
 02:36:43 -0800 (PST)
From:   Mrs Aisha Al-Qaddafi <aishaalqaddafi3@gmail.com>
Date:   Sun, 26 Feb 2023 11:36:43 +0100
X-Google-Sender-Auth: HLuvuRJTI67f9Rw3bJeuRDjJ9ng
Message-ID: <CALDqwgD0AWKdhUM5ZpRZ593uLEzeSS-_UDoj7Xdj1JDNT5RY7A@mail.gmail.com>
Subject: Assalamu alaikum,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:743 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishaalqaddafi3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Assalamu alaikum,


I came across your e-mail contact prior to a private search while in
need of a trusted person. My name is Mrs. Aisha Gaddafi, a single
Mother and a Widow with three Children. I am the only biological
Daughter of the late Libyan President ( Late Colonel Muammar Gaddafi
). I have a business Proposal for you worth $27.5Million dollars and I
need mutual respect, trust, honesty, transparency, adequate support
and assistance, Hope to hear from you for more details.

Warmest regards
Mrs Aisha. Gaddafi.
