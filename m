Return-Path: <bpf+bounces-22446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C885E4F7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1583E1C23A1F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A91A84FAD;
	Wed, 21 Feb 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LoCV1Aw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096883CBC
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538066; cv=none; b=qLcT6rn86S1fxfitgIjTshmvj++dcSlduz9Xwrind7SPDs2Hac4wcqU569tj7lyBwzDb+y44K7jWRqbYQlfLbDcHU9DUhDcZuDhGeFTqmJpyTUl2tRYzu6rM7tsZREArBxqfIJL+OUo4G/4PbcX55I1IGh3C4WQZsZqdRw7xi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538066; c=relaxed/simple;
	bh=C7yBYa7ZYxxBime4Tjcbx6porJcRqpBcrjQi54yOQuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvtSHttbqje9WAe6C5GGgiv67Gjm5zSX6KAjNhHpnlioMd/oLLKlCskQsuegNNLnhhuW5DnSj+XpPM8hsCjxKwqRwSS0MV+DIRdCdFB16DcMueycdTN6xzJfH0PheTLGBes+8fo6V6DGhKSRMnk+nAVp9aeS8leq29vax4DdrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LoCV1Aw3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso910725b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708538064; x=1709142864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAiLZN0pi4jLVX7vFnkPjwRpkLJWTLMpGcIfhD7FtF4=;
        b=LoCV1Aw3oNOAa6Z4GUVQ5Bi3AlJKFKUgJ6wnyEo0QFV4JYOr836xzA/e8QCk4GuMk2
         UpvfV2vZOo7xhkF4FxcSsO0HfbQM9B8Ivk4JmYHsrpWM0klwHlsgrRziage84sGzmfam
         vAR711B/U46XdclsXlSQHMJW7tDDBFpPZk1mMP0ejLh5Beq0zkrgisweEBWUlO2kl9ar
         Q5y+mpR5wTGL8ai7PifmVTgqBM5oP8hMPLvna5jXp5DZ2yIMM/GQn7FglOEW8RWPZCiR
         ZKin2m7Gl7R/hPBROXhmeB3MRypZDh5lV5hMxbKzDru+8ZZ4eEQR7PBsh4GvyaPuCxpG
         eogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538064; x=1709142864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAiLZN0pi4jLVX7vFnkPjwRpkLJWTLMpGcIfhD7FtF4=;
        b=PmOqyklP1GLL1Em29PQcQmhiMcC/hKtwaIsci/nLFe78y6j4YvSd1SlesQs+Hs3ZZ+
         Kx9cgJwJIUYikutJQbW1Lf/NAeHe4PcAmRWyBNNSMt/Ghk7505qduC3EbhAb0xpqsgeX
         NchHwmT4SoAp+QdppK7miDFrnxTrfI3y40+kcJvH7k0qKiV8GjCjgaCKB7b/sYznx+/i
         RLHsvBqdz/cYgnsVCs+JndWm4EESDhf+sn24v5cUHRMbHkwuAOIGUyOv3pJ78W7evEI3
         V4SnGPReyY/+JcXeoxhcGENI0T7A/KHMSjAhTmo2TM1pWMvHuHzlN3los/Sac5Y0cPKc
         GnxQ==
X-Gm-Message-State: AOJu0YykqyPigIr66U0/5LFG+hPinkP4aewc038OqBYpL71vlSh0ZTKV
	1DFFufMlF2D9f34iAj5QsfXTPNyAmQijZ26mqgzgG7ucNb2+eo9z6Qn/ippkeiw=
X-Google-Smtp-Source: AGHT+IFAhoJgj8lUvdtNWDvCdSpWzoSxplp41JWr24eC0mdWkPZ/MJj6PzFGzcvtZVTAUw2u9PahbQ==
X-Received: by 2002:a05:6a20:e617:b0:1a0:912c:ebcc with SMTP id my23-20020a056a20e61700b001a0912cebccmr15782753pzb.43.1708538063685;
        Wed, 21 Feb 2024 09:54:23 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id kk8-20020a170903070800b001dbb11a5cf3sm8427669plb.63.2024.02.21.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:54:23 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: specify which BPF_ABS and BPF_IND fields were zero
Date: Wed, 21 Feb 2024 09:54:19 -0800
Message-Id: <20240221175419.16843-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifying which fields were unused allows IANA to only list as deprecated
instructions that were actually used, leaving the rest as unassigned and
possibly available for future use for something else.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 868d9f617..597a086c8 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -658,6 +658,7 @@ Legacy BPF Packet access instructions
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. These instructions used an instruction
 class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
-mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
+mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields were
+set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
 instructions belong to the "legacy" conformance group.
-- 
2.40.1


