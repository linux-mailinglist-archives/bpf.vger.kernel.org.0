Return-Path: <bpf+bounces-6341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86A76839B
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 05:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C01C20A6D
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 03:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384357FE;
	Sun, 30 Jul 2023 03:52:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C77F9
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 03:52:13 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893F172D
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:09 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4E7E0C15155C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690689129; bh=vau6NKtfMr/K676k146MnpVmB01OabnO1dS9XP8f/Bk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=gaULp2MxvctsUYYQWMubAH1ru7qps78xJZyCNaNmaf+trjiy/X1pSY6nB0F9b+MUu
	 L3bWXpgNwF1XZpClxBy5Qoi/FGI5Q4M3ZDv44/HAB9q+V7hl0RkwECYa1pajHcdLXA
	 n4pCcwnvaURlOgXVu8IAz/QHM6/K7emwa9GePjzI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Jul 29 20:52:09 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F73CC151077;
	Sat, 29 Jul 2023 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690689129; bh=vau6NKtfMr/K676k146MnpVmB01OabnO1dS9XP8f/Bk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=gaULp2MxvctsUYYQWMubAH1ru7qps78xJZyCNaNmaf+trjiy/X1pSY6nB0F9b+MUu
	 L3bWXpgNwF1XZpClxBy5Qoi/FGI5Q4M3ZDv44/HAB9q+V7hl0RkwECYa1pajHcdLXA
	 n4pCcwnvaURlOgXVu8IAz/QHM6/K7emwa9GePjzI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3C49BC151074
 for <bpf@ietfa.amsl.com>; Sat, 29 Jul 2023 20:52:08 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXyfRKbIFMNR for <bpf@ietfa.amsl.com>;
 Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C0C5AC151069
 for <bpf@ietf.org>; Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b9ec15e014so3106818a34.0
 for <bpf@ietf.org>; Sat, 29 Jul 2023 20:52:07 -0700 (PDT)
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
 b=OHcejMhAQiXEBfg5tEzLRMi73hIEp713fEMjNcVPJ2buoJ1ElqQTwuYJNMJm2rcnhm
 Op0hKV7qiHaedLbmccma5m4YFZ0uBCIhgfTlqphcmY2lqtzx03nh/I2jYl/4y7dOQZYd
 GLG0juJEhsEicSJhlxjtpQhiNqKGG/iEhzk2nkK/mGUtz0sSqaGhfosb4a7DLsoFcXGY
 ksO/L2GZf2TpCeU8FFeBi7iNLkcKUevk9SxWOZ6ew/yqIIVEOjwvfhRxuy4WUA5MdDiX
 OhxO29kWGK0NpxJEzSTFCnj5caqwpXFY4bK+tHrVTTi8QO7eEXthBc2YWnHSy6ToVQKl
 14qw==
X-Gm-Message-State: ABy/qLa1LHdcxcbbhod8G20LbgHJWbNJKNH5R5OlbjbqFoZ8FrxbLMMH
 NbySafzEvmDTWALPtqkLUwlAwQ==
X-Google-Smtp-Source: APBJJlHlOgfV6KunwS2tzSfkLdPPWsEVc5I3C7O3M6ieJjQiXNkHMiEDgoTlRUuTOqBjazskV5to9Q==
X-Received: by 2002:a9d:6205:0:b0:6af:9b42:9794 with SMTP id
 g5-20020a9d6205000000b006af9b429794mr6350900otj.35.1690689126435; 
 Sat, 29 Jul 2023 20:52:06 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a0cf48b000000b0063cf9478fddsm2583073qvm.128.2023.07.29.20.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 20:52:06 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 29 Jul 2023 23:51:55 -0400
Message-Id: <20230730035156.2728106-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/oJ6j7TVzHxFUgP5hUMLo0m_M-vo>
Subject: [Bpf] [PATCH 0/1] Formalize type notation and function semantics in
 ISA standard
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

