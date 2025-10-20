Return-Path: <bpf+bounces-71380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13BBF0487
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BE43B923C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27D2FBE03;
	Mon, 20 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtfMpC4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AC2F83C4
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953202; cv=none; b=Mtd8Q4Avl7DEZTjMGGk+HJNJX+vOAR4Yj0SFQ6fNE275dHco88b6iIqn6EVGDHn35O7rNpeegVrCpT66vHoOoFbhOG67t54Uh3Lhh5W2accibylLyf3jRLHCBNhGI3vdiADiZrjV/VkBhmZS6kZ3uFJkcXDWT8+kjtPpWsN8KMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953202; c=relaxed/simple;
	bh=JiMogRgbGInBSVOsYygafwOmjgI5Wy/DT/oysvwSgB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+/UX7DEqXRSMDidfEvqimXsvt6E1YrFE+5pEIThuL8cJOOeEqszM9JQ3rN9GLbJKzlG6Xwhoaj45bboOYQAEKxoN16uMhsX0xaCt+TOD3YD/sQFAlA0WTdl5O/iSeNpknV1JAVsE8AbCo/3B90opfgS2z4J2DQBwlsXbIgwmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtfMpC4h; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so2851563a91.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953200; x=1761558000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+GuI+F+NaWE59KJ/k9RtDwOss9C7K5SDMuWex2KGKo=;
        b=GtfMpC4hrDbaFi6uNcfeZGjQ10k2P6U0iAPd6ePnvnDhCSnPp9TT5+mbGx3gY5qhw0
         dSX0RH9WywbL6x4hhnUh6bNsLpqj9LL/TY9GAqrhXoNRjdNQDaxch4PIS7PYiUIixWmU
         mOJ9/+AZTsD4Y6nRt1OakoibY7/wTjCjtQKHZM0V6A+wHOBOF6J3jP2lTjZPZ+Ptxjq9
         NSYB4h+oXpKjdUgJ3OBLtXODaxA163vOLy8xubv7LXlv1qfgQhOvn40Oyi4OfMM6AHws
         ISuU51VDn1WGh8b/bLr6QV3r3hjTHRoOxmj3vUv51AjfBzey8ttEtUBL2Oc00f4key7V
         YHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953200; x=1761558000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+GuI+F+NaWE59KJ/k9RtDwOss9C7K5SDMuWex2KGKo=;
        b=R9Gy5inDafAFSbBSUxb9Qv4IhUdkNtvvlxyBW/L/imTK4vSka8wkmHtXx6EM5+nzGU
         KOUENfY2/7iNN8rOq8n4/RI1cLbu94R2SXCWyb+GDhi23Wfx/oGgd9qrgqxEcHZmfYd2
         mWvmvfl6JcQATyy/2R0ZSiYZtSXpRhaMNriELyYvhoB8Zt6zmQclI4El/XMLKPp+1Q0w
         DWLRJDDQsTkp6EumhgIADqJy4YQb3T+qAtLGIYmMBnjjm+w7TvRbt7u9ihrP1VDbQBpT
         9B68odG5rKitEksyvaf35hqdmueCXLxZt8lYHWWDdrQEikrse3dPdIO/jP6tuHZ9Mgxv
         5eDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxrmAkSiWiBOTJbhsgmnXY3k+87897oW4MghJbJUY274bo13DeVyrJGJSUIrf+jLxce0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8csM9VVnDvimagY6+iIlYE0LTgQp8ZN6dwbu58rFDhu4SFl91
	uKQZw5KYFD37UXTkPOTynNlQTjaOulmCkKzlSUDb60bZWg01RlNjvsop
X-Gm-Gg: ASbGncvB0Sc2sD4NHlUiXIm1SFSye+C+J/KG8FgjbNtemZ8RK8ZusNwcGjHMRfYPTx6
	GVviThOve65Dr4ywZZay+x6qnvdlrdHDdDwwqRmDpFknzSal3r4+MjVVAAFpK4L4eBzME/cSebc
	xlVbx5QtJAl8/3zeMXVs1rhx4p/lEj8XW1xxObOxFanvo9Rvw9lbqUALaJueOTcKTKpvfaJvwZm
	+jvFk3O+F/MOL6f4pEv+qwBcS4nEmWeTHXAHEy7zDrZQNmd8x5xerpt5vryfbTTzWkcsmXnwpI9
	myjXb3HlSOzdz0mQ0wzg25HaD/Nf7b78xsD2xcRJpPnF67TydSr4ljIbhvdEIhCeOWB0zAlOj7/
	EUF/kKl0BRIiNNFSc20OGbWTD2W4Il7y8+B31XmGpHLSPHFpJ1Nt6iJay7XGViOs7uFyEcZwBQt
	JBV/zR+mmauZTG21BKnsc9C0JRK5U=
X-Google-Smtp-Source: AGHT+IGe3SkLpqxFGaI/6R57SnMYrFhU59st2Lrt2ihDY77Hqt1qbILgggp368MUDEPo1pjndWr6mA==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id 98e67ed59e1d1-33bcf8f7802mr16406334a91.22.1760953199716;
        Mon, 20 Oct 2025 02:39:59 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:39:58 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v2 3/5] libbpf: check if BTF is sorted to enable binary search
Date: Mon, 20 Oct 2025 17:39:39 +0800
Message-Id: <20251020093941.548058-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that libbpf supports sorted BTF types, add a check to determine
whether binary search can be used for type lookups.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 87e47f0b78ba..92c370fe9b79 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1091,6 +1091,8 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (err)
 		goto done;
 
+	btf_check_sorted(btf, btf->start_id);
+
 done:
 	if (err) {
 		btf__free(btf);
@@ -1714,6 +1716,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->nr_sorted_types = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
@@ -5456,6 +5459,9 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
 		}
 	}
 
+	if (d->sort_by_kind_name)
+		btf_check_sorted(d->btf, d->btf->start_id);
+
 	if (!d->btf_ext)
 		return 0;
 
-- 
2.34.1


