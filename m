Return-Path: <bpf+bounces-40637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1E98B2DC
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 05:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2287E283224
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1F1B0121;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsFDypdD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6641AFB1B;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727754926; cv=none; b=HGRZPbLjwsJ1cWrVsVYuVMx2mDRZ59yQ3W2GQIV1rXpjiMncnddlMbWayEsxCaTgRZHJTB6pTsm04CMnImuCFJbYJjEFm2odGXYPbkLefTwk8VHb6s55jY+aal9XAO956tdr2tF3R4zWFgwsDysshy6s020bFDioQF0Kj7LZlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727754926; c=relaxed/simple;
	bh=coqPH2PT882k6BNfPMpwWVzbrZUXQnlAGeXR1RPfSXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr5WTe6qTYzNTwC0POWe/qKRJKERCOQbmdxA2q7X3LbK2f4P7+TTJ3qXw90mv7qtDMU9eW1UfcmAS6+yTOXAZmupcg/b+Dh6aGK6lSMh4qGf3mVLyYzBZTiRJWQpgkX14KCW+FQS0/g3toH8FpwaQbw0nNZ5ubEJYqu2lNoQ/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsFDypdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24836C4CECE;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727754926;
	bh=coqPH2PT882k6BNfPMpwWVzbrZUXQnlAGeXR1RPfSXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PsFDypdDm/LNrlEd+CrkEyEQlh9TQeu4QnPzNfm+Mn8V7CboW17Z96aWwX1/qcbGM
	 x51+KT0idNVDGenGSEzvvSRkVbzZwk6IrBYwFjSnEyEKnco8fFZ0mGMWcx2l+2w4wt
	 69FuiV5OFWv7fC0ea0kBLNHVqyW8ozPvgwNmxh2bzZxuwrUXYUa6KPGDGt4j9j67fO
	 P3OE6LhW1f6nLdf+LYw3xyK/92On7IE0Uc3q57fg+oQdkR7+cHNsOtUDqx/A/pYOGA
	 jEQYE36PGDD2lIif7YCA18hc+boIpjsmgYZNLawF0lI1XmVtHS+SWNRJ5iAUHPsRO7
	 MMCVbg23GWMBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE5CEB2E3;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Tue, 01 Oct 2024 11:55:21 +0800
Subject: [PATCH bpf-next v3 1/2] libbpf: do not resolve size on duplicate
 FUNCs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-libbpf-dup-extern-funcs-v3-1-42f7774efbf3@hack3r.moe>
References: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe>
In-Reply-To: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=IhJnEF2eUexSNHu1rLCPbrDJ161gDmPF/o4WkeIj0mA=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGm/i9asrJm/+HGWVJQDW8LCpVfs0m+arxTg0O/t+uvZJ
 rZlvn16RykLgxgXg6yYIsuWw3/UEvS7Ny3hnlMOM4eVCWQIAxenAEykXZ3hf67L4aPHn51hkLiV
 e7y48NrFQ5K/2R6cjM8Q0Koo2tBS5sDIcPlU9JHbnMy5BYJC1jXuP44veRv4K21uWfBu0wBZjhU
 aDAA=
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

From: Eric Long <i@hack3r.moe>

FUNCs do not have sizes, thus currently btf__resolve_size will fail
with -EINVAL. Add conditions so that we only update size when the BTF
object is not function or function prototype.

Signed-off-by: Eric Long <i@hack3r.moe>
---
 tools/lib/bpf/linker.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..ff249ba0ab067526e82d91481d21ec88a2732b4f 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2451,6 +2451,10 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 			if (glob_sym && glob_sym->var_idx >= 0) {
 				__s64 sz;
 
+				/* FUNCs don't have size, nothing to update */
+				if (btf_is_func(t) || btf_is_func_proto(t))
+					continue;
+
 				dst_var = &dst_sec->sec_vars[glob_sym->var_idx];
 				/* Because underlying BTF type might have
 				 * changed, so might its size have changed, so

-- 
2.46.2



