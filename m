Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5F5FD915
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMMSP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMMSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 08:18:15 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346404B0E8
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 05:18:14 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-360871745b0so15837767b3.3
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=MXdaMowxIxQa7KffTw3r/a1Kzeq+uqWEDNtwOR6o1Myu5uHg36hwttdR/MhzlaMfLv
         MycTQHfjcMrBB/FddCe0qOQgn58bbhbMFM1AnPjz/wbKLh3rrKKINjPcrkQBQVc1zNNF
         hdFefCVaXiV4g8MdhxsekZpbopUoLPoxjjPucC0kJVwmrnwfOOPxiHrUHHXtb7F4mFhR
         dACbgrMp4VMJ+GMJpIBxBdOIn6faRtKzo4Wvfcj+p6WooW+QRFrVVIbsWOYjI1EJ+DEm
         U9rEEIqg0WNcziprj3GCDwMopu0EurGa5lcC4vZ675WuZFrQDZv+WsFhl6KO0tM5seH2
         1iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=VhasH7QyW27YfSkGwpvSCFi4B6RMrGK/aD5Wwna1Qe8iHHDndVtzXIW+ryWS1TanvN
         sZHa/i3UB75t89ZTX9D6OR7slxtzKMrMuE6myyihfG/xBLueTaDfuGcfU1+Y3vmeLadS
         SpZqZIwts9jUUQcYreRRVcdIQbh70gK8fcolSx7Yc6qxTrsJ3xGRm9OdJG7K2UErvi9J
         FR8KHmcn+xzt9KOyOZGcaQr/jWrlC/x7RkB2i1YdJ/Qv/tdwO0zkFVma7bEXd8KHg3If
         OW9qAKSj5rGD0jmIVglsOSMlwoaNPfQsfgLkVWrQOXta3SCyg92D7jfmlGOX6y+uhiAs
         d9jg==
X-Gm-Message-State: ACrzQf1hXg3gUN9lrcBgTqSypWWZm9L3MVvpyOG69bJ+hKyFN1CdsKGb
        tVeqe7Yr9ZV//ZFBgZM95dU9UC0LPXnDJAKl2gs=
X-Google-Smtp-Source: AMsMyM7sF2STv3zGaUOaDbgMmi+RqGyRvJroL9oK/lftdgf1ZOHKklZYDuSRyioSUv5h8kx1ZfZ32sw1a1hSkyR/LIo=
X-Received: by 2002:a0d:c203:0:b0:360:8d1d:72d9 with SMTP id
 e3-20020a0dc203000000b003608d1d72d9mr23614196ywd.216.1665663493510; Thu, 13
 Oct 2022 05:18:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:11c3:b0:e8:97b3:80ac with HTTP; Thu, 13 Oct 2022
 05:18:13 -0700 (PDT)
Reply-To: financialdepartment0112@gmail.com
From:   "Financial Department U.S" <hughesthomas399@gmail.com>
Date:   Thu, 13 Oct 2022 13:18:13 +0100
Message-ID: <CAGPC8EPF=oYFMrzX-0cxV=ADfm7hPe7qn=-evNEA4R5e_9x44Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5499]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hughesthomas399[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hughesthomas399[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment0112[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear Friend,

I have an important message just get back for more details.

Sincerely,
Mr Robert Liam
Deputy department of the treasury
United State.
