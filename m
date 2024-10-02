Return-Path: <bpf+bounces-40737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245498CD1E
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200891F247B2
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D012C491;
	Wed,  2 Oct 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MubHU7lA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0A81723;
	Wed,  2 Oct 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850310; cv=none; b=qUejHFGjOs4G/i2utNsHEQjeiBrKLNQB0UiG9fBS6KnUO9IKt4AjXrAoi6ay+fr2WlwnDYGI8Jcfo8x3Icb5WCLV/vEa5/5YudvyGiVftie4maicWxGxXiKO/AiXLW6/Ti9St30tKZSE3NV6n5n8+myhs+pRaL8B1auvs1hW9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850310; c=relaxed/simple;
	bh=z+eCDAaSPzfM1pxkw+jPin5pFbh6ryABjAf9UppbCPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lg/h9BsPJL2zdv03Ci4Pl6tVgMKZPhweJG0NthLtBwmxyw7aC1/46gL1nBEhgphOa2THQs5Dq554k669SLd/pEBWAsLDzRe2b4/IV6r9wrbhcjDHL0kSnCEVCJb1T7YRWXzDydJnp1IBUCj6gmTPhUiduAT46eSm2TCuyUXLuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MubHU7lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E462CC4CED0;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727850310;
	bh=z+eCDAaSPzfM1pxkw+jPin5pFbh6ryABjAf9UppbCPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MubHU7lAKDMeHYLdRDGkMSrMajCQs76rPOiY4Q6jPmN5ziqtq5x28WLcBzUYv9Ynz
	 QpVvETpirluARJMWV0zvNs2C6v3+V5anr+gNr+qg1s4mSKL025Wz6B2OwEVtisIgQl
	 4PFGnEK5lhExINwNrWB3rMw8Orqds8ZPIQxXorRpCSxwj/LI7cTHjrEGCdJmLBlEuw
	 jx+Zm6ksd2kiWEvNgcU2UgRNQW7F/r6H9r36WATK1Dy2d1gTt1xf5kHiH5iRdBa+AW
	 WiHi16OVsgdTK8JHNVSx7mA28qvsBCBzANT87IyqCJVnL8bE3Pzf4CeVtA1ksTe/vS
	 Icogd2y5aUbCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6EFCF3195;
	Wed,  2 Oct 2024 06:25:09 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Wed, 02 Oct 2024 14:25:06 +0800
Subject: [PATCH bpf-next v4 1/2] libbpf: do not resolve size on duplicate
 FUNCs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-libbpf-dup-extern-funcs-v4-1-560eb460ff90@hack3r.moe>
References: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
In-Reply-To: <20241002-libbpf-dup-extern-funcs-v4-0-560eb460ff90@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=GityEu5UW6xiYc03h/u6D/purlYEFBNe2K5e1StUi1s=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGl/nru0N187X/O127LB/qHvtrDw0IV7WHbk1N7YoTGT3
 8zW/9GFjlIWBjEuBlkxRZYth/+oJeh3b1rCPaccZg4rE8gQBi5OAZjI9WZGhv53Fz46u+jWrmrX
 q4o4mH/3RaPSr+N+U3c+bbtjI1koZMTwP6rSdIOk9lXzXSu719RUBu7gkrxls3ViwZf76q8k7L8
 XMAEA
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
index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..f83c1c29982c3d9d7f6775cd98a6f3387a4e9c50 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2451,6 +2451,10 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 			if (glob_sym && glob_sym->var_idx >= 0) {
 				__s64 sz;
 
+				/* FUNCs don't have size, nothing to update */
+				if (btf_is_func(t))
+					continue;
+
 				dst_var = &dst_sec->sec_vars[glob_sym->var_idx];
 				/* Because underlying BTF type might have
 				 * changed, so might its size have changed, so

-- 
2.46.2



