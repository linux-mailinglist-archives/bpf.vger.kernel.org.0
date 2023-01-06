Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C972660559
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjAFRLi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjAFRLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:11:34 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B359FC1
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 09:11:33 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 78so1547498pgb.8
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=WkokK+c0Sr+irZu7nnC8iLgGb8L5C70UTLkGQ3LqnGTNEBUDq+Opgh1kHlgoItqC/X
         +z7zLBeV+rJiHVyFpIhJTCAaKdzaVLRLqYj+e3LuttGswCkZzxFQtVVUoZWG/rwL/5yS
         U1O5w9IbyZoH+G47c+5Hgzv9I5wr7t3ohQGA0MBPOUxRKPUoD7JFqtdJ0ZeCnX0qj18M
         A2wDX6ihf8o1lvRU9s1a5PSM7/2SxZvtvbOejlnCUMbimDuSHPH/BWU2Jq5aoYyyEfYd
         LAHB5+Wn98hoBDcaSCjv9KXepKvtBlEJlQdZA9JS3z/dWTGKWOITXAmxjukHEIhp4/eV
         SExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=N0j+Tl3guYMxjxkYwf8iErbEgGMDWa3xTZxwv7KYDqKD/uMgcSVO7q5O9liVjw+0Rk
         U6vubPHCXpdvRdFLQ4dfxLP6oPAeu+18XaTBADDDjxPQrraBD/eJUIe0MZqwzmGzexg4
         CTdluyJm7cF2r9gQx79Xty+UUPH5rK3TRjAJqynj+PHChnrOxYtvAYPuLwJrTMlz1qLw
         0NFz/LOUQ76Ufy7/cMuAUbpFgyzm34CIoyPWCsWQNaVkQFRCg7/dFjOtr2hW8zDHaa/K
         +CfjPWouC6UUIWp09L9HanzOlhrfJzHZxR48c4YtFV+gXU3e0ynukQqV7OBmki7JGCHp
         pHBA==
X-Gm-Message-State: AFqh2kox5l3j/GVaH6kV+lwfPuTsP+cNM61JfgZoSrVIJZU3rVwyNnQZ
        Yj8YF94Ii7QbtuNYQQ2Z5Q5lJfwDQufdWat1zto=
X-Google-Smtp-Source: AMrXdXvsKtFEMjynR5GhYRyJ9zEc5pt1Bd6n/+GBzrFKgGbRcGtFoCNck39UT8aOx78WVO30kjw9feXKwuD0n5PhZ/4=
X-Received: by 2002:aa7:8051:0:b0:582:e939:183d with SMTP id
 y17-20020aa78051000000b00582e939183dmr1067436pfm.63.1673025093096; Fri, 06
 Jan 2023 09:11:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:a483:b0:96:8605:6af7 with HTTP; Fri, 6 Jan 2023
 09:11:32 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <smith0110sm@gmail.com>
Date:   Fri, 6 Jan 2023 09:11:32 -0800
Message-ID: <CABD4N3=8PoA79wSxVQJJAzcQSrt0+-iJRAmMBRxuPbYOupuW2A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7177]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [smith0110sm[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ava014708[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
