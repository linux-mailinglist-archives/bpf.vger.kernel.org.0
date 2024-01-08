Return-Path: <bpf+bounces-19226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058A827A56
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A8C284B1D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04D5645B;
	Mon,  8 Jan 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="cBIt4aYL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FgdZY0Kj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y3q63QMd"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFC56450
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 488BEC2D8F51
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704750161; bh=B+Dkyl84WnE95vmRnerDPH9doqtGIIhw7HPnTrhmnVM=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cBIt4aYLTznEn4Z4YFg1mfx+M2o1dehru8tE/wycF7WUKowkXuYrxAts2lkxo038b
	 9Jq5Pmr8qrRuuHiD6BFF1JTf4exM4pFU/6//l2/cXh8LpX6f4VhcxFzxZzvIDOHjZl
	 82TFJB52k5DJ1rh35rXhzch7OqB0c29K+yiAxkSM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 36138C06F6AB;
 Mon,  8 Jan 2024 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1704750161; bh=B+Dkyl84WnE95vmRnerDPH9doqtGIIhw7HPnTrhmnVM=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=FgdZY0Kj2DxEMn7Rnzo3m+rMj1vyimA/L5aLiG1M82rinAbBk8L6W6rMUUIhFvKej
 RCukQrlnAe2lJdchhaq9OB5O8NHAg9ER828ustsT/K/f6IDtlSJ7EFc9+FXnUhXcxO
 sm+4LHgLLymoA4PoDNd3gB0cLwqbZKRc8bLCSsHs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2E6EAC06F6AB
 for <bpf@ietfa.amsl.com>; Mon,  8 Jan 2024 13:42:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hmJU9BbebXkI for <bpf@ietfa.amsl.com>;
 Mon,  8 Jan 2024 13:42:36 -0800 (PST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 649CAC18DBBF
 for <bpf@ietf.org>; Mon,  8 Jan 2024 13:42:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28c0df4b42eso2193802a91.1
 for <bpf@ietf.org>; Mon, 08 Jan 2024 13:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1704750156; x=1705354956; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Om0H2b9haCAXEMP5FMDOFAJIVidhFwipddb5hPJUKls=;
 b=Y3q63QMdaGxrcJYS9zhLNSXvyxabtbGaRoFYSGvPKVvfWTltW2km7XUFPqJAhL5F1W
 1T7Y+JBvdimuRizuqqoFVGTSRWaojBOo48jyoTjf+ufZ1SKoX4JHT1ZSPK+ZtmFS1C7c
 9rWPLgNZzrj+GpwYUsKncfZA5buAk+5AXo+xoENXH/SxL6ceYsIxqDWr3U59j60ipsfd
 0nIDp/Jxwt1wsJDyEaFHz/MVn0vam6qrsYQxw/R/jujPzTXkn+cCzIeiELeDaq2X0MEr
 TWJZDZ7De4Ve7a16jjD69VA6ae63lN+Qngymtr+wMthmvgnts0hGq4szlpnLe9RtDOxv
 //Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704750156; x=1705354956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Om0H2b9haCAXEMP5FMDOFAJIVidhFwipddb5hPJUKls=;
 b=jOHNhm/cSaHudw47iMHMRI6uSfwHNhPi6vR9bbmlz5fYvzGEcsAUodE+WNBcZc7FSo
 FI0flnREgbipen7wnAXFmaFuGXgo8vQN+g8l41P5hPsBtM/0++SQk6/cMWUVK8QyUJB1
 bO5WsnVPbcl4ULLUWU25595hk4IN6I7kriZDX2o1lA55utPc5WZpXkiDPWZy/BiYu5XJ
 +JQ7KI0+wghSRZG+qxmPytJaUN/7ARxIfkCxuH3DM4HnLjSyXDmfRb4G31F6qTmJt8Lh
 ztdFYSxXi1WSpEN3Uxo/bLgzspUs/KkVuOvO3u0frDPaa8CeXlekKFDBIBAl20kkE7eO
 8Z6w==
X-Gm-Message-State: AOJu0YyTvxKk4+ox1h050Pf9DE84kID8dmVS6KyJ4SvWzPR5H77WsL45
 gVQo3c/RGg4hgVCE90nMXZc=
X-Google-Smtp-Source: AGHT+IGqQ6p8gcYov8oECSdLI5LOB0wUi9ASVwIz98KzjcZzSG4XyOh009NeniuMLGNZ0eMDSnbgfw==
X-Received: by 2002:a17:90a:2bce:b0:28c:f3f9:ccb7 with SMTP id
 n14-20020a17090a2bce00b0028cf3f9ccb7mr426217pje.41.1704750155693; 
 Mon, 08 Jan 2024 13:42:35 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 23-20020a17090a01d700b0028098225450sm7668476pjd.1.2024.01.08.13.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 13:42:35 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Mon,  8 Jan 2024 13:42:31 -0800
Message-Id: <20240108214231.5280-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/X923xaQ2ixm60GgIHXpC_fwbjkA>
Subject: [Bpf] [PATCH bpf-next] Introduce concept of conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

The discussion of what the actual conformance groups should be
is still in progress, so this is just part 1 which only uses
"legacy" for deprecated instructions and "basic" for everything
else.  Subsequent patches will add more groups as discussion
continues.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 245b6defc..eb0f234a8 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -97,6 +97,28 @@ Definitions
     A:          10000110
     B: 11111111 10000110
 
+Conformance groups
+------------------
+
+An implementation does not need to support all instructions specified in this
+document (e.g., deprecated instructions).  Instead, a number of conformance
+groups are specified.  An implementation must support the "basic" conformance
+group and may support additional conformance groups, where supporting a
+conformance group means it must support all instructions in that conformance
+group.
+
+The use of named conformance groups enables interoperability between a runtime
+that executes instructions, and tools as such compilers that generate
+instructions for the runtime.  Thus, capability discovery in terms of
+conformance groups might be done manually by users or automatically by tools.
+
+Each conformance group has a short ASCII label (e.g., "basic") that
+corresponds to a set of instructions that are mandatory.  That is, each
+instruction has one or more conformance groups of which it is a member.
+
+The "basic" conformance group includes all instructions defined in this
+specification unless otherwise noted.
+
 Instruction encoding
 ====================
 
@@ -610,4 +632,6 @@ Legacy BPF Packet access instructions
 
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
-deprecated and should no longer be used.
+deprecated and should no longer be used.  All legacy packet access
+instructions belong to the "legacy" conformance group instead of the "basic"
+conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

