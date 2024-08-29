Return-Path: <bpf+bounces-38344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0F9638BA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 05:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF261C2204C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310E38DDB;
	Thu, 29 Aug 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4ObwqPc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8419481B1
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901482; cv=none; b=s0o24aavcSt14hI8/zm9ctLrV853QBp1EGEaldcVpFQJMqLJ8q/btaPWh0zpguriZuVJpEpOWlAoOkBjYFF2Hx5S2QvNPFiP1zEY6wAaHJE0FezG9OmtrJO8EsWbwS2FHF4348A0SQRMMMYRpKkCsMGUdu2q0dx3r5zwJ9EbMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901482; c=relaxed/simple;
	bh=VUDprWFPT+7ptpVw5vdF8LPlLuDUW94UltuEcftIuMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwuS7+6nKxu9C6uQACllGY+mgF+B++vJhNBUVd0/cnVso/q/M9qB1pgE11PhcODNQA4VhN/F1xYiNQKsU+nFw6VdTLU7uNAyf3383u7oEORnGO8Xiy33vBFyLq1+Uiyowt7XWsIItPvUS7SYpdnnwkisuydBuVevFbn59RfXcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4ObwqPc; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a7ff6c4fd0so9912885a.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724901479; x=1725506279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7JlWE775CZTAVtI9SyqEThll5/ysJumFj4figvzPeo=;
        b=W4ObwqPcVS9sSuNxI/Z/OYc8PpPR3sR7agF0kilWGmjFtQ/PdkIEYqQB2wikPBiQ5E
         YwGbwpCIFm5fdVXideTEQT/Vg6I5qhEX2oUY12wp5KpKl7ityvVQRcW9Jl2YGILoKAs3
         AQLAmM4HdpdZb4w4jiobnkhgD5sfWzbsncb7xcv4VjE2EXjcb32NDW5+u7uOjUfxqIH2
         mHMQgCPaDiIGzFmstIsXRCpBMFlZvoTeKMARz72cKkeDKzAQFopUjApLWWNaJUGpbokS
         8K9jP1thtePsnMQIMZ97fhUPkca8xLt/iV0TmqHrTDcrkpamDLW0pPD3oRkog3KoMocs
         c31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724901479; x=1725506279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7JlWE775CZTAVtI9SyqEThll5/ysJumFj4figvzPeo=;
        b=JLG87XnKQKdzfQ5RwvuwIYXERfzjdAOW6/27U9/vYvWerdl4xy6FIGCrkihVhheAL9
         L9LC9kj/uZWZIRO9lcpdR4jh64zwmT28CBsjgT57NhBwqazzWuX1ErxPDx6Ily554voR
         c+9uW+OL0eukOy7xkOf+5XwowOjgAxsUJ5h/P2UyNt1Q3MTcaIqEdWYtuAFuCxuDL5ta
         7ItP5QTvWUBbvHh6luhdVBf9OCD4XcjrPb1DqLyffe6aLFZH25Pf/VQ2EFyUzc2e6cyE
         +jRkDIVg7GbXnzU6uVAQHpjtIhDJeHT/GG4F656QhAdUYVNizVXLCZVU8zIt7rOKXX51
         zPKw==
X-Gm-Message-State: AOJu0Yzkrl/J0pkqtCQK307M1Kx1URfDGtr6sczGqUp7lhL0SUKui2FV
	6fTa2ffWCZBBudFI94Txgn+aGFjKpcmk0DxMdW6YrpGWqMm9KsVZBEfvyA==
X-Google-Smtp-Source: AGHT+IG15vuiVNxPvBF3vsfqBajOdb+I9oRNK2OcTBnra5hR7I5ht/crlIs54iYbG5J+NzFKALIg+g==
X-Received: by 2002:a05:620a:3909:b0:7a3:78ac:827d with SMTP id af79cd13be357-7a803f34c4bmr151144685a.0.1724901479317;
        Wed, 28 Aug 2024 20:17:59 -0700 (PDT)
Received: from linux.hsd1.mi.comcast.net ([2a09:bac1:7680:3b0::74:38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d36a60sm16888885a.83.2024.08.28.20.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:17:59 -0700 (PDT)
From: linsyking <xiangyiming2002@gmail.com>
X-Google-Original-From: linsyking <kxiang@umich.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Yiming Xiang <kxiang@umich.edu>
Subject: [PATCH] docs/bpf: Fix a typo in verifier.rst
Date: Wed, 28 Aug 2024 23:17:12 -0400
Message-ID: <20240829031712.198489-1-kxiang@umich.edu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAADnVQKp0uH+vt5e43rOtFtamSs4zssh+RHKwQrRfgSDh98E9w@mail.gmail.com>
References: <CAADnVQKp0uH+vt5e43rOtFtamSs4zssh+RHKwQrRfgSDh98E9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yiming Xiang <kxiang@umich.edu>

In verifier.rst, there is a typo in section 'Register parentage chains'.
Caller saved registers are r0-r5, callee saved registers are r6-r9.

Here by context it means callee saved registers rather than caller saved
registers. This may confuse users.

Signed-off-by: Yiming Xiang <kxiang@umich.edu>
---
 Documentation/bpf/verifier.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index 356894399..d23761540 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -418,7 +418,7 @@ The rules for correspondence between registers / stack slots are as follows:
   linked to the registers and stack slots of the parent state with the same
   indices.
 
-* For the outer stack frames, only caller saved registers (r6-r9) and stack
+* For the outer stack frames, only callee saved registers (r6-r9) and stack
   slots are linked to the registers and stack slots of the parent state with the
   same indices.
 
-- 
2.46.0


