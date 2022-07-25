Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A33580569
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiGYUT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGYUT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 16:19:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF1526F6
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 13:19:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u5so17537731wrm.4
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=mzMFJ2M2TiuNpLYrrNYmC2VWaR6cUSAWUjcyFrYHiY4=;
        b=o/83RK4e4HVIJrN8bokPLjEht9xZGdJa76WfKWL0JNt/iy0tQ6Z9MtesuFOMm4X4Li
         YXC7MHslqpQ5UCTVExB7wX+McA2UBYDOK45T7a5U99MHi5gZpU4O+AidZvMTZDTEV0VN
         G9PwKPsyM7t2tKy+AMotj81uaMelEsdWz4NyQJr8sbm4xhgdB1HfsZVdwbj49mE5WAGF
         O6PDv8lZBI1LlYRvl5+QjRtbGcPoyyZagPOZzW0RR8oqma69f72RvtZ98IF3Y6whjpLz
         n/8SrLOA/q7cWPpWrGKkgWTB6Xp2yUYMXvh54u9NK+h6z23KlHf7tplbVE466ASajq1c
         0dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=mzMFJ2M2TiuNpLYrrNYmC2VWaR6cUSAWUjcyFrYHiY4=;
        b=e1Cqgp/ox7Rw0i99ubJ7kZS1AUOrABIQsBIzmNzaBH0w2CZquljBmXfeJFJAWW9kDi
         rEjLzN0GY46ggdK7ZkNh9HoXKiknmJIP6v2Vt6gbhyH5Hl0sZw7qg2MnYEXbumZSClD6
         b1jQEKIRUD38/2Q2/0QpHbf9NAa7+gMYLdDJkUW4ZVES+x4RcGUo4Vr3GAyCHlhYibPl
         h99nr0ZdjmcCX9ZYn0b9/jgbWVdCa/2tOdm/EXEHwIlt3j+GFAfro/K/DRR+fhnMspJv
         IeqI4OYvVUwVcgEYkfrS0KeV1CWfgD9E8EWcMUeX9azjVnGQGc7moqyoazP0TieSUWIQ
         eD+Q==
X-Gm-Message-State: AJIora+smLeeFDMLfX1ya4rTQdG9GzWUsVY5T7oCIefyoSDz8p1522Vq
        5DVy7eFXz/D0a8ukRpGrbFBW2/kCwK6aV85zVdA=
X-Google-Smtp-Source: AGRyM1vxl65AjvuBFGz/Xb52gCQvJkAwo6KeupIuhsBycWEPrFTaiaK8KZ7mULdJrFTFSJ6vGBC12k6xZOOew4uXPeg=
X-Received: by 2002:adf:f746:0:b0:21e:55e7:b8c3 with SMTP id
 z6-20020adff746000000b0021e55e7b8c3mr8512820wrp.251.1658780364510; Mon, 25
 Jul 2022 13:19:24 -0700 (PDT)
MIME-Version: 1.0
Sender: gb676779@gmail.com
Received: by 2002:a7b:c5d5:0:0:0:0:0 with HTTP; Mon, 25 Jul 2022 13:19:24
 -0700 (PDT)
From:   "Barrister. John Benson" <mrjohnbenson.esq@gmail.com>
Date:   Mon, 25 Jul 2022 13:19:24 -0700
X-Google-Sender-Auth: lluofH5F8rzD7UTeCQKbUr3BJNg
Message-ID: <CAO9H84O1UsDyKqEaHvg27eMGRLvvtVZZrRdwysugjccGtQH=XA@mail.gmail.com>
Subject: PLEASE CONFIRM YOUR INTEREST FOR MORE DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:434 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5013]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gb676779[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrjohnbenson.esq[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I am Barrister John Benson i am contacting you to partner with me to
retrieve the sum of (US$12.5 Million)only. The deposit was made by my
deceased client. At present left in the Bank is the sum of the US$12.5
Million. I seek your partnership  to claim these fund to avoid being
confiscated by the Bank Authority. Please reply directly and get back
to me for more details, and I will  want you to reply back directly to
my private mail box(mrjohnbenson.esq@gmail.com )for easy
communication.

Regards.
John Benson Esq.
