Return-Path: <bpf+bounces-6339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631C768399
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 05:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425971C20A4E
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 03:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD21639;
	Sun, 30 Jul 2023 03:52:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAF39F
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 03:52:09 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447DE172D
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb29b9044dso3087054a34.1
        for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690689126; x=1691293926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSSBGKcVR/Xy/Y5UaBj7CsgSJakQRT3q15ljgDsccIM=;
        b=vFIEma1gJXyvi6Sybnpui3q6sPWdEvE9Jo+rh9tP55Zdn+d0wiXlbwcLY+GMZfxZbH
         fMIbOTMcGykJLMzvMwJX8J5PcoR1bbVtAVF9ddw6HMGEpy9TK68dgV90UzcoYnlhy28X
         ziEkmlXfmbcESU+fONsq2XyJpMjvbewGcSzmPiZdJqxr7yg6LTAdW0dzFvGaD+CLJ+3V
         sdec5VLsmbeSAgtjN1T/hTdqN9b5BdGXFakS+cr3+4xq5bLSxvwg8BZpyLXwybcepwW0
         WZW4Xwmqir2P9CDnN/AvviyBR/2xtv0yzX251EGjGFGovQTsCygzhUMy5TY1kWD/fGij
         G3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690689126; x=1691293926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSSBGKcVR/Xy/Y5UaBj7CsgSJakQRT3q15ljgDsccIM=;
        b=KcEJXtslhqv+L209XyK07xjmy8jf7LkgXbGIqDJsuKr98odKCY+mypsMzI/y/cFcq2
         h7cFzBMJAnTlLinPLVxoEm+8V8dn6YiibNLNL7W5XSr2Q/iRIVnH+DwxT+Jlq4xyblYZ
         /yO8lcgN7KJHG7x/aKXEMzDcMFX7jB9nU1xRk+SJbt+1lR86tJfPXArJvFempB8iEjMY
         BxZ0L785yh5JICH+ma4Eteu8UaBCQLfpdNSfGHdpEEOn7KvinJmau0+DEU4DLVLVSNaV
         FpeUKH1NA783CyIxOEIcPIlq13mXYzaXD4rT2evuJiSveUpyYBwpFNcHn1T0mWmWGgv7
         cpGg==
X-Gm-Message-State: ABy/qLbcZD2HgJC0rj2vyIrSlxz9DXHhFoL83B0ggM0DSuCCfNMgiY7h
	GILc3/bYzbdSsHafbcz2SQfxCC4Z9BgT/F/RKus=
X-Google-Smtp-Source: APBJJlHlOgfV6KunwS2tzSfkLdPPWsEVc5I3C7O3M6ieJjQiXNkHMiEDgoTlRUuTOqBjazskV5to9Q==
X-Received: by 2002:a9d:6205:0:b0:6af:9b42:9794 with SMTP id g5-20020a9d6205000000b006af9b429794mr6350900otj.35.1690689126435;
        Sat, 29 Jul 2023 20:52:06 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b0063cf9478fddsm2583073qvm.128.2023.07.29.20.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 20:52:06 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1] Formalize type notation and function semantics in ISA standard
Date: Sat, 29 Jul 2023 23:51:55 -0400
Message-Id: <20230730035156.2728106-1-hawkinsw@obs.cr>
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

Based on a conversation with Alexei, here is an attempt at condensing
all the definitions of helper functions and type shorthands in a single
place.

I hope that this is helpful!
Will


Will Hawkins (1):
  bpf, docs: Formalize type notation and function semantics in ISA
    standard

 .../bpf/standardization/instruction-set.rst   | 65 ++++++++++++++++++-
 Documentation/sphinx/requirements.txt         |  2 +-
 2 files changed, 63 insertions(+), 4 deletions(-)

-- 
2.40.1


