Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5FB5BB886
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiIQNcO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIQNcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 09:32:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1A3121F
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 06:32:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e5so23857346pfl.2
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=KdxDKNaUiNSTXGJ1UwNyBXcWUgXZGoOAy35EOGLkCmtmzfj4y2UDkTk/Dy2fX3f93d
         5u3xWcL1Sl0p2S9Y8GeHoLnooEIRqHq4ChCxdON39QL452l75DZLqKGaSfJstKm/r6k2
         53RKjonvRVzp1fGB4WnyUQny3KJcvHmDGXZf+SQbCSYZJdY8p1auCnnde1wtuqqt6xgR
         nITLuFAl165ZAWg6B8x9u8fuChKHZxQVR2wLdJf3qVTIDNzRrjvnnvBDOHzN7w5g0Pwg
         bc71LHm+2lkWyH+r4bs8gFvzrcqzigan2ducLxWT7fqazQpZMt+Uh0nlKGAGysFhQNqS
         hnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=79HcwfqS7PkEGZY8bw5RPAxhFB9+r5OZ3/YVZ6rgs/ggw3D9H00PmIslfs7+h48xy8
         K5llS67N6/AuvUwiWT4zVAkFGeu8RENFnBTClrrfgX3Wq+ubfYk8w3aKcJDLVa3itkwf
         rJijvg3APcuzl6tjL0ehLp+xZNys/Q7jMgyVyWvj+OZ1CSaXRz28EKZl/F9Ek1oKstOu
         HrUNSwFD4g2OOJXBNAYFmZxYP5K+pmnMwR3IkLViti14yDn+OnDXdAmAqjOko/pfMtIO
         fyhP+x7GUBXcZJ5VA2Solb0u++uOMN6fybkMqojtaFChRbSkWrBFZwbjjt0WlmSl4iB2
         N8Pw==
X-Gm-Message-State: ACrzQf1DGjOZQr4nN3alP4He5F2+PQ7BmKG54f6tiYZZeeRo7gVUbR/E
        nQQfxZblECKxehxJXncVBTIIMrNcYcu/jhkeaiE=
X-Google-Smtp-Source: AMsMyM6zd4xk4+KIRniGw3CCWwFoS4JPPWiKsp6wsz1V5mQWmyHiQ5s9rQEMKYnvngm2wf0hPS8Ex1i9JHG9IeLLrDA=
X-Received: by 2002:a63:e452:0:b0:42c:60ce:8b78 with SMTP id
 i18-20020a63e452000000b0042c60ce8b78mr8636576pgk.453.1663421530732; Sat, 17
 Sep 2022 06:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:43d1:b0:2f4:7ec7:3a99 with HTTP; Sat, 17 Sep 2022
 06:32:10 -0700 (PDT)
Reply-To: daviesmarian100@gmail.com
From:   Marian <kl576521@gmail.com>
Date:   Sat, 17 Sep 2022 13:32:10 +0000
Message-ID: <CAN2bDzmq_+AruKi0cKcHEHF2HinuB22QkaO=Owx2B2umXpSt9w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:434 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4911]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kl576521[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kl576521[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [daviesmarian100[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello
