Return-Path: <bpf+bounces-4341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605374A6AA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C31E1C20E93
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435615AF7;
	Thu,  6 Jul 2023 22:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E031872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:20:38 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7331992
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-443746c638eso437757137.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688682035; x=1691274035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA6mx+9ASzacFRBAUrJfsMB96XaKjntSEu1gRx8IEUQ=;
        b=scV+LUZ/kqtYsdo/47G4UywhPrWKvYR4sT6fvLHxpMPsyREAvLSLEbH0EYrkfeg0tV
         ttNrO1mxiCoe1rW4Winc2vGHWWOpeMBxCti3pPO/r1V42PjrYzjJuk6sEKPaDEt6YZ3p
         7rvi5E806CuKwXCmekRNEv47OhWs56okkvGzXJpDhBYUS47UzkysO9ODFxIrC031iZtZ
         eJuQ+GFJxZaZZ1X86gqwNlF/DcqVXdenea/vWlrVeN+x3rvM1GhcQyw0hQJIjQwBht3u
         HpCr+bAvOnTzQq86vySZW+3IjPVSFdMhFt+wbUMit8bVteNgOBm8cBRSy/AW4y8fefUk
         Itrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682035; x=1691274035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA6mx+9ASzacFRBAUrJfsMB96XaKjntSEu1gRx8IEUQ=;
        b=AZcTtae7By/+RUF9IY+i3vUXe/L9NnqlDNH8ToPJo3RqOLOBGd3H84Zscft23FBfsA
         ydOwiNsTjHFx4jbRX2PLq/ySS07kLA4CBKIyF1OQJv01hJvcuP2g2Je/Kpl5Q3HuDdYM
         1maHHohQjqhYSgPu8gMTJIA81/r1cElond5unI3cU9QPJdnD7ptdOl9zWxEisLPHTYH7
         sPyEr1I0ZkBK8qpDZu0HHgi77t+3pK1w/JW/1PTooAOa3yJH2hgK/xTab6q5ioX0bNpa
         tU2qHluTCYA/PYEBlPz17OyBEgzBH2Zben4O0WT2wVwIUQoYuew1Y+rSE8lmKnFliEox
         IN4w==
X-Gm-Message-State: ABy/qLYUXXCklLc3crmNq62S5Bs9qXAcIJlUg3eDjiX780wIpN2pX0qf
	3HmXOvpy8oQRFsnIgN1jG/yk8Jy42omQHee0IgY=
X-Google-Smtp-Source: APBJJlFmCNjyzVAbwoEtL1bZFMIqIW4nbLFxVvtlm/es37G9ZH6IseOF0gAE/wDWhqE1tIMav0qFVA==
X-Received: by 2002:a05:6102:25b:b0:443:6212:60a9 with SMTP id a27-20020a056102025b00b00443621260a9mr2102859vsq.6.1688682035358;
        Thu, 06 Jul 2023 15:20:35 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id h5-20020a0cf205000000b0061b5dbf1994sm1322717qvk.146.2023.07.06.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 15:20:35 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] bpf, docs: Describe stack contents of function calls
Date: Thu,  6 Jul 2023 18:20:20 -0400
Message-Id: <20230706222020.268136-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706222020.268136-1-hawkinsw@obs.cr>
References: <20230706222020.268136-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The execution of every function proceeds as if it has access to its own
stack space.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 751e657973f0..717259767a41 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -30,6 +30,11 @@ The eBPF calling convention is defined as:
 R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
 necessary across calls.
 
+Every function invocation proceeds as if it has exclusive access to an
+implementation-defined amount of stack space. R10 is a pointer to the byte of
+memory with the highest address in that stack space. The contents
+of a function invocation's stack space do not persist between invocations.
+
 Instruction encoding
 ====================
 
-- 
2.40.1


