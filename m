Return-Path: <bpf+bounces-4343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C374A6AC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BAA2814B4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCCF16406;
	Thu,  6 Jul 2023 22:20:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272B1872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:20:45 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1D1725
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:44 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EAD41C16950A
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688682043; bh=3+lNeCz2mbB71IT0dsPfwNxaHKMY3rZJtlr81ZYqOCI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fWcdoa3Z1PqzzS9xb+3PSWAQvbg+ibymofoyo5EnR5ymRPDqYMHIy6uAj/ojazFUo
	 Q3qcVHxT5maqjg5X6WTJJN3nZXDKTQCHJq8lGs+L0yzsGaJrcmR7X3MtPNkdYC14cU
	 q1G57XljFJ6IWxvUn9hGB4XTUD0hIv+SaXC470Iw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 15:20:43 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D91BDC1519B2;
	Thu,  6 Jul 2023 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688682043; bh=3+lNeCz2mbB71IT0dsPfwNxaHKMY3rZJtlr81ZYqOCI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=fWcdoa3Z1PqzzS9xb+3PSWAQvbg+ibymofoyo5EnR5ymRPDqYMHIy6uAj/ojazFUo
	 Q3qcVHxT5maqjg5X6WTJJN3nZXDKTQCHJq8lGs+L0yzsGaJrcmR7X3MtPNkdYC14cU
	 q1G57XljFJ6IWxvUn9hGB4XTUD0hIv+SaXC470Iw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1C656C15107C
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 15:20:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.897
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIcVsGv9FNzp for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 15:20:36 -0700 (PDT)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B508EC1519B2
 for <bpf@ietf.org>; Thu,  6 Jul 2023 15:20:36 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-444f9c0b2a4so443874137.1
 for <bpf@ietf.org>; Thu, 06 Jul 2023 15:20:36 -0700 (PDT)
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
 b=grZwRWDDnN7NaoKWK9HBq0HE70zwHLMFK/LBaI/0WEpx5VP2RjXN+vdU0vDVjfit+p
 yNOUeAm689JalSu7IXXnHzezvlSP5RQc1Kj2UcMIlUp/dRNwp1OZZQX1DJVVwZ6EFWE2
 vI0bCUZiy+QYVAb9LMbuOrbIuUf08+f52KqAf4KLkX88Yf5l6Pq1qK5Pgb62LQb5Pq6d
 dIBj2aaWoZeoyepTHSmLuTxwVUo/QdAbfsOSNX6KPodBKc45AJpOHEe+X9rUjlqJDSoe
 lb1ndSj5qTSfGvDy6PaLD67/WP4KY5JKWwhBAI/EVf+QfFLywQIK6sor3bpnrVLNsLhU
 AOLQ==
X-Gm-Message-State: ABy/qLZmTG7R1JG4XgCnfiwAIsSZMEE0/RpSmWT2pLQiwiPSihSbjxJV
 AeAs0giGqTL8qGwCZfHEP3WwfgV9jGtIxk1tNlk=
X-Google-Smtp-Source: APBJJlFmCNjyzVAbwoEtL1bZFMIqIW4nbLFxVvtlm/es37G9ZH6IseOF0gAE/wDWhqE1tIMav0qFVA==
X-Received: by 2002:a05:6102:25b:b0:443:6212:60a9 with SMTP id
 a27-20020a056102025b00b00443621260a9mr2102859vsq.6.1688682035358; 
 Thu, 06 Jul 2023 15:20:35 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a0cf205000000b0061b5dbf1994sm1322717qvk.146.2023.07.06.15.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 15:20:35 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
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
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/mlY4Avz2yP0JBFW4JyM3e_2CxbY>
Subject: [Bpf] [PATCH 1/1] bpf,
 docs: Describe stack contents of function calls
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

