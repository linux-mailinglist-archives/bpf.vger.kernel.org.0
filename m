Return-Path: <bpf+bounces-78495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28565D0F46D
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 489873042919
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5F34B68A;
	Sun, 11 Jan 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqk9aKXV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C951D5CD4
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768144991; cv=none; b=TCWZxgRpV3U7Mi8mJ/XQoV10JY3AQtiFpwovSrFJ2CRrW99geSs+yUTeezlwnel0osdB7+xJcxt77peMPMh/BCZUmBxNfIIQUDLzvuMoqRb7O8+1200C77PMzRhC+ViGdDsKpR7YehqrdxDo9JCG2eFi7Ty9ZmTwbv30aoW0xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768144991; c=relaxed/simple;
	bh=CuDNZaIf4LLg43wMo9Z/er+74xCsL8EFRBJx1yuRuA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzxXo23hvswMAlO8wDnSuj9cQdBiOB/bJ0YmdZAn5Ww3VhPt/eluj2UT2nn2+YnBwogNWn4+nvUFDTXad0831kfNegKZfP20egq2hwVhoeOvHZnMorPuw5eivP3xdOmlD37oc8NQrj1pYmbBxuVcAYkFQlHFdiNGrPAWcVu01yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqk9aKXV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so9093330a12.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 07:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768144988; x=1768749788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3GbLmbAVgVg8W/QD0r2d/BD7HhJciuFt4uAdzkvZuM=;
        b=Kqk9aKXVxjTq3k2kuwAowFT5oHeftvWaWkhav5dYV3f/P0U1WZ5TjegXCZOlDoRwAp
         FWCNgR4QsN1mL7AkKftrPkX7AFIyrmgffNR95F809dbhDifhboBTPEYRLq56KzrJn82l
         NmtoOiAvkdTkE6e6SNvVoLz9S2k4njOU45XHy614AbcEamOva/62/vMSCashoUD/Pag4
         GJ6MrfSAEIUJAODs5ZDE/v5B044R/Wp8oborsxrHUVl2/7TcDO5gUIIkTsbdnA9TFe69
         aoaAjkdq96LdNrlhfs1hXCLpMfWFrsHuqLQneCFRax803CIr2MTdQUCtUESF0F1JBsJ2
         b1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768144988; x=1768749788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3GbLmbAVgVg8W/QD0r2d/BD7HhJciuFt4uAdzkvZuM=;
        b=GnuAJi8R/byHbhecbxiYrG+Jzg3sjlbdb+cR3BbjS9IdyXFKwvvT3hnlpsExpfi/6R
         mwxoQUudwTpTBIrFM4wLa2hz/o0hAhgZ6nQGbUjuIXD6s5b+2cHbu+5aUdOH49XWW9w9
         LsOEWRkEuVlrYPOnhw6GcD5O0KSHFVZS95QU54ri4MoMlotXfrvrt3JN3zCYesTXO/MW
         /dj+s0lZOUm6iCgkDd8/d1dQ9PfKDXnkfoHFiDLM5GYEx4HCADxw1NZGIJMhD3xTo65+
         evPbUIaJ4lY1nYgLospFW+BDSnYJuZHcQqgoCIxeVHNk27+qNM443YYOh/N+jVnOBPQo
         vKwg==
X-Gm-Message-State: AOJu0YwDZnTFbhgz9OuR5el7flCGbGulVDomd9eaW6JGvAr02E03xliz
	hyIbIU2KMTyKRrclvhi/lRMEiPro2pCWZeqRregFPu4z7iq8i8TbYdSIQlODJA==
X-Gm-Gg: AY/fxX7eecYBbQRJCo+Og/8dPjhdgFR9vlufBC/p8SUosUHhr6B5hwRRamtqh0P8lfP
	NLHd22GUBRNZ+DUgjH5aRbAtCzOwUX+Xx+Nql1lXomhu88BVKBVDzJs3gKCXZDhhopK93D1vdbu
	nLoAQD8cmjuW11trAzcn6yBnDqjfwVdn6YqXZmSE346Q6Zk8gVGxr6QhhTmh5ZgU7Im6f3F6EdS
	2Tpnmce8t0XtHMIfsfQwCbVGTFpU0Hba3zbwiyxjtXYfNMpdYfN79x82erHJknOyr2Cg4+k/+yg
	VmnQwTTjehDExisfZFYA5k+5D4bmlKf4/ljhft+xnqokyXjbxpOwgGtUwTMaH7tSpWofgSyOWKd
	5bTyXunmHYv3PmuaklioWtYR/CnZLrbifgCGx3rkRR9knAeVLKeT8Kdaj9WMsmOFYeeLYkBDhN7
	fIL5HSIeT9vIowMzXOswUmeiEOAEGyVQ==
X-Google-Smtp-Source: AGHT+IEAYq319CDksUSOEVhsM2M8E1vPeHluzuUDK9ei+eCSgYi9cFTh48eOksWfi+RQrH+OGNnSiQ==
X-Received: by 2002:a17:907:e90:b0:b80:2b9b:39e4 with SMTP id a640c23a62f3a-b844501195dmr1533725066b.55.1768144987611;
        Sun, 11 Jan 2026 07:23:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd08b2sm508698866b.25.2026.01.11.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:23:07 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: insn array: return proper address for non-zero offsets
Date: Sun, 11 Jan 2026 15:30:45 +0000
Message-Id: <20260111153047.8388-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111153047.8388-1-a.s.protopopov@gmail.com>
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The map_direct_value_addr() function of the instruction
array map incorrectly adds offset to the resulting address.
This is a bug, because later the resolve_pseudo_ldimm64()
function adds the offset. Fix it. Corresponding selftests
are added in a consequent commit.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index c96630cb75bf..37b43102953e 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -126,7 +126,7 @@ static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
 		return -EINVAL;
 
 	/* from BPF's point of view, this map is a jump table */
-	*imm = (unsigned long)insn_array->ips + off;
+	*imm = (unsigned long)insn_array->ips;
 
 	return 0;
 }
-- 
2.34.1


