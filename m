Return-Path: <bpf+bounces-4340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2374A6A9
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1E1C20E67
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49715AEE;
	Thu,  6 Jul 2023 22:20:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5251872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:20:35 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175621992
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:34 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635e3ceb152so7614916d6.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688682033; x=1691274033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcZcPcvDLuTHi258y77yahK6XXeK4B+Il7OypjQgctw=;
        b=MCh8dzwhbG3DQcbOyFyr/Gvh75QRh+0MYrOPppZ3QqkO6WkmTphuQvb7DCIl1WpZAI
         T8MVN3n9ZDa3di6IdS1a6B1EN1Tza1mcK5hzyOyXzon1hicIKdqoCpTAugEX7DT/dAha
         we4Kn1Ho/TvsGCJ6yv7OgNREBq37hznXT2EVT7RzxGpxqCBICX1b/QYyMQzw4GkKxvLB
         8/f6Fpiqn4Jtk9pGCI/yuhPCdrGnKYPb+f70IfOYY2HQ9pFRdGoxTru/76FrujJlje7C
         rEo7UE5MYyAgAK9GZYri74Bx8tY+iXzTLwvzOEJEyyYgcAiasohy10OaAGJb0m0uStYH
         Gb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682033; x=1691274033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcZcPcvDLuTHi258y77yahK6XXeK4B+Il7OypjQgctw=;
        b=Q1RDOs7F5Bz2UTm0/AXtL2h9W3kLnY266zYBVFg2ODPouo75wWMFu7/S0wWQcolMev
         xPk/DnmVwnXo7DtlYtXF9XWt0uYQlF50iWVZ7j94QBeZzspe08o16qq+/rS5+A1CJsgv
         aX1DF8B2sGc3aoSjuk6wSAtlw2iXXlB7puY2G61ewwJ2dVkckB4p8fRXMAMvPyechuDo
         ne7pbdEEieAnfG/SgqTNL4+MPsuccN7juNKhk2e+G2WOlmNe2u44X/IGc7/D45mAIgat
         1nUVq6cDtGRjulLCOwIUHVjI79+KcvnNbvoc1Mw6dtBgJyEwFolMogQGQ8Pl5BWmKGAR
         prkA==
X-Gm-Message-State: ABy/qLbGQbm3rar0EiVkSmlhuEN3EXXJQoHp6M+u8KnpnKo8EnOxubQe
	0RXXpxwMpkP9ActR8LCWzN23J2KKSzzjs1x4nhs=
X-Google-Smtp-Source: APBJJlF0gywZGYyK183FavLX53tfDuw+l2/1oKaPq5cR+4xRGBCMDMnyMMczfILT1rR/QrpDwfPq6w==
X-Received: by 2002:a0c:b20b:0:b0:623:855a:9226 with SMTP id x11-20020a0cb20b000000b00623855a9226mr2622557qvd.23.1688682032991;
        Thu, 06 Jul 2023 15:20:32 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id h5-20020a0cf205000000b0061b5dbf1994sm1322717qvk.146.2023.07.06.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 15:20:32 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1] Describe stack contents for function calls
Date: Thu,  6 Jul 2023 18:20:19 -0400
Message-Id: <20230706222020.268136-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
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

Although I am sure that it is patently obvious to those smarter than me,
I thought it would make sense to add language to the ISA documentation
about the contents of the stack, especially with respect to bpf-to-bpf
calls. 

I hope that this change is helpful.

Sincerely,
Will

Will Hawkins (1):
  bpf, docs: Describe stack contents of function calls

 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.40.1


