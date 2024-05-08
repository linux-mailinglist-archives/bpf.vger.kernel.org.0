Return-Path: <bpf+bounces-29019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E98BF645
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280E62824C1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D6199C7;
	Wed,  8 May 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+y3fz24"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623E384
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149946; cv=none; b=bDzlsBfO1Wws5YwL6QdoGbfco1vUGnGpIjNjzZRNent+ddPJafdssBxPzyRSMo/GFrncagk3Um/uq/sAgsshikW89YKyV9uzpgehV4cdDf1UuypxGOJD448/PPtl7Xh9M6LPJ1QKd+rWrMopqVeZZe3DO0o2R+nEmKueKv04dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149946; c=relaxed/simple;
	bh=pCN0gUblbq3sf5AdhXjHdOKajyp+ZRRHTuC/nrcTzpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tB5sDF7BsQdD33qgv9QGnTfg9kn9gd8XWSFZExVpRzLfUVt0bgjfy1whoL+mOcHe5Fp1fkImxDzOFSbtEtC33jeynVfVZ7mBAh8mGGQuRum2OpJYYbZN2oZAVIBcZ3RakOeRzw1zw6T0nKU7MDJRXQjJ1FPXe87LDlgDzzpZ5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+y3fz24; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c989d4e838so62923b6e.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149944; x=1715754744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITUVE3cgCYC2CFtIbPVKh4YbIS+9WyVA1G9yycG1a2M=;
        b=M+y3fz24FmaYeQGTtquuJHogFDBmfZ0rZhPldppaeqGMiDAVxoP2QhKMAszD4nYlm/
         PIFOTf2LK+IXx9TQLfUF4Buu918LkLtkm/zH3KZD6hJ1iImCGziEnko+ntRxsuebH44N
         f6gLrmkReVViZM5tNDtB8PdwbUxSEYsiudn9+7YTRN7NFWdEI8CeM0OdglKHumX5IePu
         oUipEUPvQoPBzBVC8TFvJJ0u940HyEqvCvTyBeyanvc/RMN3LfFbb3OZ2fBtFIRYy8o5
         DojfVPuAVxNHVDF9VbMDG1UJtrH3LfYWgwKol0G/7fGh39LTZK4IFnBR6vheXe1YBFNG
         2mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149944; x=1715754744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITUVE3cgCYC2CFtIbPVKh4YbIS+9WyVA1G9yycG1a2M=;
        b=F5Epf0OWxRHfU7WVTWeFAJtmoYoUHmgC8SJxYmZNLV228TLHRYYTbP1eIM4Ma7O0wC
         cxzlGM/gWTiYr/jkJ0iyE2l56Udo2khYqviXmaDD/noKzMd3BXbGklsNyA/f5u5GhiS5
         FLUC/Th1nBnv6S+Cg4joeFlO8Tg5es/+PJspEeRu1dOFvh84GBa31IA3EPIAG/DfFyr1
         xGrx2sXBPLOe35Sw+Dswfy5mWIXTzyU5Pab/8frWAhdV5OxQ1+mZyMR7C8Ie57sEf+zY
         2ep6T2RrVJCVfFonDIRfT0xf2szOZA4b8H4CtLNOynK3U1ifVLTrGW5woM4lYppmQhKz
         usVg==
X-Gm-Message-State: AOJu0YwKlH6tZa0AtI/WMcv0K4TWyvPOS6wYU97b0m34lCnRYazcSsk0
	MO/Zg9OCJXcZiZv8h1NWTO4G/iPqm7/qeTrGXbjUXg/OmwSmJivdz+hRHA==
X-Google-Smtp-Source: AGHT+IHFLvtGS8t5Mrst9RSiZpgJVeQ/FFJ9Obe4fIMx0jCLzrxNr0PKwAGpSsahsLr9pj2Ka4xmuA==
X-Received: by 2002:a05:6808:18c:b0:3c9:63d1:6fde with SMTP id 5614622812f47-3c9852fb1a0mr1718372b6e.37.1715149943765;
        Tue, 07 May 2024 23:32:23 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:23 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 1/9] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Tue,  7 May 2024 23:32:10 -0700
Message-Id: <20240508063218.2806447-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_find_field_offset() always return a btf_field with a matching offset
value. Checking the offset of the returned btf_field is unnecessary.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7360f04f9ec7..b731d00cf1ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11640,7 +11640,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1


