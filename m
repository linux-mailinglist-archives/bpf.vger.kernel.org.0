Return-Path: <bpf+bounces-20786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3473843492
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 04:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C39289AE2
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB613111BB;
	Wed, 31 Jan 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OTuBZG3z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="pIsF3ncF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XFAeYhOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570718AFA
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672339; cv=none; b=bz1B03oJGnfQeBMMj9WEMTT3vsz85I8HURLHy7/eHEip8f10xO6XjRIX+TpMcrUDatvQKFClIdTE5MutsNcUCy5ZzrFtOxfBf21JgneqSl/oU7prZcnZZTY7ehU3FGWxEntPQpAqj3SR3XQBQdy1dnTOKxugfvf4ZJw9ERlep/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672339; c=relaxed/simple;
	bh=uWWxSOhEl+rQkqHnjofwA2RxoSc4vd30lBZWtwmEg5I=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=CuDAH/NJ2d1TPMltyDBojvN7EcmDzkH/lNvF1dwfSeuqeIkPVs15luy8yOV5IkktVGTuBvFolB03HAVOKaiJyqBQVpr5xBsRPHrfVtpI3AubYydNLmhKtK5ro0/w1Qm0r4qx4kuQj9PH0LpnWkdB1JgtMCISYJY8SekRjXWHEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=OTuBZG3z; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=pIsF3ncF reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XFAeYhOI reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B056DC151996
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706672336; bh=uWWxSOhEl+rQkqHnjofwA2RxoSc4vd30lBZWtwmEg5I=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OTuBZG3zgtO4LLnjOIMegOHLOSLsWQVaZ0Zo8aU+YInlD7T7WQLamj7EqJ1TnHkTN
	 d8hX3zUHMfcWYFuEu2+GQ0gdAVxKjjsYxH3zLQOvhD4nrPNj5mwQ47Ouz7DwCgNoHa
	 96Dyc9DwKcv4dxDupOZuxMwwehsnPrRa6Gjo97cM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8DD65C151557;
 Tue, 30 Jan 2024 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706672336; bh=uWWxSOhEl+rQkqHnjofwA2RxoSc4vd30lBZWtwmEg5I=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=pIsF3ncF7h9aopEgIbcULTaaPOCD1e2dk+y4YSpv2hhFe2yTvJUzIkL4DOdTnkuk9
 5N08mofBmJClEFY0/db2OFdnMB+riO1bh+7Ix1v+wZmB7auPfBIcPBXshvtBJ2TmOq
 OU3LczFfrCFnNjdy+sMHcR2gZgHTxL1zYQ+mIN3o=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B8606C151557
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 19:38:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwVIvvP7Vxyw for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 19:38:50 -0800 (PST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7866EC151064
 for <bpf@ietf.org>; Tue, 30 Jan 2024 19:38:06 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59a29a93f38so1328076eaf.0
 for <bpf@ietf.org>; Tue, 30 Jan 2024 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706672285; x=1707277085; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YhXNQgLXBlJmEoHckwon0RzHmRHma/rjdahanXvt4cw=;
 b=XFAeYhOIwSyoPeA2HjdBeVEjDIxXx4FLMalKDQ/y8bKd7rrB8GGjoUZGSdxemnrsNi
 vn80vWkRgIhLdnx1UulttDumLYDSco4FRIl96cEtVhacuD8JbSdmB4xymeBLspxscsxX
 xS8J8CYZ9MOYo1xteirGqEu2cm4RiG6OUmHM38zvVou6d3AVGrCaZ/9Qc6QQOb+GK9NU
 oFX/pjGDD686rXBGZzfed8THpLv/qB3e0ze29l6BbkI7Cgi6spLpsOgb/OkuHWjpHwkB
 5M2YfCPuHK24sjh/OOqyGzwn0MhcqkyDbOPaQIs7l0FxfugymF6ka+12hGyhYRpp0Y8G
 2GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706672285; x=1707277085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhXNQgLXBlJmEoHckwon0RzHmRHma/rjdahanXvt4cw=;
 b=xB06XL1mQ7i9JkpG2h6SK1TYaxerZlEMRychm7uuavFl1oxd6Y5vKC8o3YQFliHvyv
 jY80TMz+UVFbcCUXdDxOMKWMQ2iWYISgRWiUmIimupwykPVraFgdpAVzgZ9H1L1708AL
 oclFY6ArFh+O9FaoTaE1eazLSUlca/BSF4KMdHh4VBAdDxQ8qN97N/Q0qLVTkDoe13V1
 iKmqGWhV+6cZJGuP3P8Hw/5AgL+tTghnmVB5BrVp8ekGLybQXq++u524ENoWxrDaTO+l
 RTFHWiozNR7vocRbKsv7lHg3K88tcq6TIia6/lrpuNkU06DoOXvp/Fean0TwOp1S1Dln
 OP4g==
X-Gm-Message-State: AOJu0YzDroqlJUfQUtuP7n/p2hkpGw330NvmUEPdaNil5PSZjunSdXuq
 xmI5w0IW7ac2P4kwNYSJ3KN3nfKdzzp2PGFySSPdpH4iIgdB+Y6J
X-Google-Smtp-Source: AGHT+IERakJZGap0ueNR2PueNiFVwjj5vEYM2GYiFK+mo7oXsmC+CZCS/Nt12iwI/QzhUNhCMLZ+yw==
X-Received: by 2002:a05:6820:1c8e:b0:599:4cca:3f93 with SMTP id
 ct14-20020a0568201c8e00b005994cca3f93mr523919oob.0.1706672285711; 
 Tue, 30 Jan 2024 19:38:05 -0800 (PST)
Received: from ubuntu2310.. ([50.35.79.164]) by smtp.gmail.com with ESMTPSA id
 l18-20020a4abe12000000b0059a56e36763sm928496oop.22.2024.01.30.19.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 19:38:05 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Tue, 30 Jan 2024 19:37:59 -0800
Message-Id: <20240131033759.3634-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/0CrGSI3NZb4q_0VpdKvVH0mtBDc>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify which legacy packet instructions existed
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

As discussed in mailing list discussion at
https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
this patch updates the "Legacy BPF Packet access instructions"
section to clarify which instructions are deprecated (vs which
were never defined and so are not deprecated).

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index af43227b6..cf08337bf 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -635,7 +635,9 @@ Legacy BPF Packet access instructions
 -------------------------------------
 
 BPF previously introduced special instructions for access to packet data that were
-carried over from classic BPF. However, these instructions are
+carried over from classic BPF. These instructions used an instruction
+class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
+mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
 deprecated and should no longer be used.  All legacy packet access
 instructions belong to the "legacy" conformance group instead of the "basic"
 conformance group.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

