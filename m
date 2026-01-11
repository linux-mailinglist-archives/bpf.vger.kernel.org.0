Return-Path: <bpf+bounces-78496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66724D0F473
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FD53044878
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1BE34BA22;
	Sun, 11 Jan 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcg2xNu+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08B345CD8
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768144992; cv=none; b=TWISe+VjBdU2dFDBh5zaaHFt53+6e/MMiOoNEEUsxxobtdRy16VzdA3qm3RQBVVumRWj6SpKH9ZVEpbTSZDxY3sKRq88Cd8GVijW94167jTj3UdP4FgWKjLxDTmNhjyrxqFuttJoPHpdreCBH9y4ejmzdS2xIoLn6yI+bfo5udU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768144992; c=relaxed/simple;
	bh=T+gDWTj+kw2LypBPTs3CEX2G3JXpxfp1HqatCZBU8pE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgbeCE04xNd7D6jIt/Z1VlalZVcvuFyiEDvqMOVBqKZwVej+wDkXGdvaNz0GIwGjcoPrf9uH3L56qGyylJad5OuzAuOB70c+L86qrk3iW3Rt1v8mrD5H0g/vnVO7aUCq83Bv/QjlGw8wJwMH6Cm32LY35DFWasxChMIkHsF98B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcg2xNu+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso11265600a12.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768144988; x=1768749788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSvzQpALjz1fh8dcTVktmX6DSuWjODaELduox1pj198=;
        b=jcg2xNu++eRvTSbTVr9oRRoI/oMuGOIDiSkRLVQ+y/Z544yl/a9DJUi6L0Onj7k1I4
         sryP5EYusT5U5/690UuwdWo0LfRVfclV8xN89knWk+1q3JnRYmCxuOTkek4Go95NneqX
         cct7oinjJnA8QNvguvKrcoM7bWiLbHDXsgl5NG4QVHRLCJtvR4jZxdci3JDkl0P/Ux1v
         m8KWhnRETX7MyNkWLT7o7tZn4T3p0qLtC0Z7l1n7s18XafUyXRQYhW8Ya4v2XkQ4zpar
         hVfKfunB/iV9VYM/plT7i5ymyTZcvFdX47IXUk1xMx4hpK1skLE9GMHZgXRrXHAe1m+w
         JG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768144988; x=1768749788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSvzQpALjz1fh8dcTVktmX6DSuWjODaELduox1pj198=;
        b=Kfxj7gusPCY42ihFyE1s/Ab2KSZaNqUNSrhKonzSw52X7mzIDu+yCaaC5GW661EE6m
         vg2P+UPMGJntgvqusVfwyBPThXsom4ExpJ6yWYAJhHmR3cpU/BhgI+mveXXGp0XzxWS1
         nVnBFRH0xDQFlrYKMow5DLU5enJd22N1dHYxKCSToM/KT1x58DHsUx6TEC60h/vw9tS6
         xTVYeHNyWDZ3MhaKmRaEAIf7dkW3YIt8HnzMejN1dRneeT18z+Swo1fUOm6U+jyP+FRL
         kbQcBJcFUie2QPfOEkc8/ghObUx+WreE9vxKLn+RjU03apT3eNNgwcK64fKRK7SHbnzr
         j0Ug==
X-Gm-Message-State: AOJu0YwUSyUYNvySSxh6yA6GP45dt0ls5CKVBt32fZ0zYaIXBn9Gv4n9
	T+zPF7RpiN4nRrFhLEO/ZQclt/iMcvwvLmOi9tOBFt4n7Z88l8zbgDP7pWyJtQ==
X-Gm-Gg: AY/fxX6njnrqVGdgEhiqifqTWJb8W2tmkXd/Cxf5PRct+Am9ARre5zimB69HjZh4dqM
	h39Qkb6IiXkB81PoDnwPYRTcdi9i4C7IWcy36LI4J1AS7DpcQcFs2R53y1wGzZfRpaWksTrwRh+
	I9cKRAg0M+ZzyL/hdgG+G06sZcUXywC97jy8GWEFrrX53Cxf4M98DoR8g46M8fV9OaiG37zhmd8
	qnCUxpGpi+5C80Nb5Lgcxisb6uKQQlZLrA1ROCMn9CAUMudnJah/S8lxz0FMPrcfExgYVD7isML
	PbBZEq3A4YsV6ZW7nlE7PweJUmZK7yZqza2mkmlEVJx1P/94Zei4dxqV/6N0r5tV+Z0l3qexKMN
	2bcRdhTFpxtLvsDtXan1UzerTD/EZhfyyrDwZT3avUDqfgaFAQYYrKn83J+FAwWPCK4XllL1ED/
	8hp11m0VadxrCrW1Dmy/JOWJW1J28Row==
X-Google-Smtp-Source: AGHT+IHpnYdG/rK44LPYnPRafqBX0Lg/gXKbtWPYoLcY7MLQV6WViC7bpNhPM6Jh4RcylNWJ4jTDrg==
X-Received: by 2002:a17:907:7fa5:b0:b83:95c8:15d0 with SMTP id a640c23a62f3a-b84453eb335mr1410216966b.52.1768144988312;
        Sun, 11 Jan 2026 07:23:08 -0800 (PST)
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
Subject: [PATCH bpf-next 2/3] bpf: insn array: return EACCES for incorrect map access
Date: Sun, 11 Jan 2026 15:30:46 +0000
Message-Id: <20260111153047.8388-3-a.s.protopopov@gmail.com>
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

The insn_array_map_direct_value_addr() function currently returns
-EINVAL when the offset within the map is invalid. Change this to
return -EACCES, so that it is consistent with similar boundary access
checks in the verifier.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 37b43102953e..c0286f25ca3c 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -123,7 +123,7 @@ static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
 
 	if ((off % sizeof(long)) != 0 ||
 	    (off / sizeof(long)) >= map->max_entries)
-		return -EINVAL;
+		return -EACCES;
 
 	/* from BPF's point of view, this map is a jump table */
 	*imm = (unsigned long)insn_array->ips;
-- 
2.34.1


