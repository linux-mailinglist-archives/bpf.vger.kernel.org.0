Return-Path: <bpf+bounces-29698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA78C5679
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 15:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBE41C21BD2
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878C14038E;
	Tue, 14 May 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6Gg9Vgn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC612E75;
	Tue, 14 May 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691790; cv=none; b=OPVgEg6kgc0Z7V1CafGmKNZStQ6aDBXs+dUx2q9KAbh1G56Bbb+dc5Jzml2R6uLx3XvOFwoSnWXc0IuwF/MZvWthUa9Cj+XBpy/DQFeBYnRhI8+BTVEOCzcn464ixu5hubveRw/wu3L3pR0dwTOSstEty6VTAoVduTvdj/iNsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691790; c=relaxed/simple;
	bh=2FTtLgcS3g90jTCZ5RW/k0IA6dKK6r07EQMnwhcdDsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQtGUCqUffuU08hPHCrsTECCAbZCrImeYuJ5CYcpqWuIoDNDC1+CDc+wwuLNZwKOBdp9ll3Bkheo/LaII4oDYLs9GvXwzmWwQz2SiKoOVKhEtBkDhjUjHGGG0WxGzfl7zkk42smOJi1Cfcleaj575PlqARobYhEWu4unmcCfqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6Gg9Vgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5EFC2BD10;
	Tue, 14 May 2024 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715691789;
	bh=2FTtLgcS3g90jTCZ5RW/k0IA6dKK6r07EQMnwhcdDsY=;
	h=From:To:Cc:Subject:Date:From;
	b=N6Gg9VgnCAwncIHMa2lhOv9v4evkV0q6kVNau3l1W2CCJMTOCEU0KD2JxGF1P9vkF
	 3XnMSvaY15fderWIjfSpCrK+jYTRKoHP0RN+Q215f5/ibt9xXGHNBxehDARbZjwZ//
	 1eQE4lRU8V/oNu94yIabzVLG21iRTi2Uf3my+gM+q3yB6PKT9WNctgaHeoHZDdeJfN
	 8B3Vtqm1cLqY8jAvb1bTK9bQNj+PN+u50fEjxoka7oQndVrWatnP3iVsbhZMnNe9Ja
	 LjL5ItFBaONciSjp8U8LZPiZNp3q3kNH9LIsEiKGOkkKnXptYXXcSPRQr8xrRfCJXv
	 7dbDajh9Eu1Ug==
From: Puranjay Mohan <puranjay@kernel.org>
To: David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Thaler <dthaler1968@googlemail.com>,
	Will Hawkins <hawkinsw@obs.cr>,
	bpf@vger.kernel.org,
	bpf@ietf.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] bpf, docs: Fix the description of 'src' in ALU instructions
Date: Tue, 14 May 2024 13:03:03 +0000
Message-Id: <20240514130303.113607-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ALU instruction's source operand can be the value in the source
register or the 32-bit immediate value encoded in the instruction. This
is controlled by the 's' bit of the 'opcode'.

The current description explicitly uses the phrase 'value of the source
register' when defining the meaning of 'src'.

Change the description to use 'source operand' in place of 'value of the
source register'.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 Documentation/bpf/standardization/instruction-set.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index a5ab00ac0b14..2e17b365388e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -292,8 +292,9 @@ Arithmetic instructions
 ``ALU`` uses 32-bit wide operands while ``ALU64`` uses 64-bit wide operands for
 otherwise identical operations. ``ALU64`` instructions belong to the
 base64 conformance group unless noted otherwise.
-The 'code' field encodes the operation as below, where 'src' and 'dst' refer
-to the values of the source and destination registers, respectively.
+The 'code' field encodes the operation as below, where 'src' refers to the
+the source operand and 'dst' refers to the value of the destination
+register.
 
 =====  =====  =======  ==========================================================
 name   code   offset   description
-- 
2.40.1


