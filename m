Return-Path: <bpf+bounces-19733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A114083072A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25871C2429A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A186A1F5FD;
	Wed, 17 Jan 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcsbxi0R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFA1DDEA;
	Wed, 17 Jan 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498545; cv=none; b=FHpbzjWbMTKlV+CE98XzoJoJPCKbJ5O6VYP5X8MUMxhNP/1t8p5CBmBXXS8nU2m/B8M+CyYqzKdWiB0Mv75i+rSatlEk5aR/tTlR1a4qPP5A7GxaBIF+BliPURbzaWKTcg4C/t2QNTg/gqfWInuA3E+hdcC4HMsQ/Q/TSp2255Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498545; c=relaxed/simple;
	bh=4PkCqWXiCJeINEgOlLi3mczfTlNmb99L3hNOtrSsW5o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=HixreDoTiBBmBRsaRgtA8Z4MhHfvAbxSef3c0xUPskZb6rEVJ+FxFOvEqXAepOVWdwP0GKhUbq3XzomcnGhQkuj+gpjZq2AEwQCQ8D8eC+PQcpEnVh5JpJGnNBrzZTKbUSTwbvq6t9Cw66qATLPZ867qcj8bIMFdDzMQFxsWN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcsbxi0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145D8C43390;
	Wed, 17 Jan 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498544;
	bh=4PkCqWXiCJeINEgOlLi3mczfTlNmb99L3hNOtrSsW5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dcsbxi0RxgskVZrsdkfGE7mn6KLiiI7FCyF8jPHgA0kAsgKGkm6Buuh2rxRaBtbsh
	 iSAyxXOwTg+PgHBSL1db+a7owBSfXak2hyzk8AABgX1Qtefs6Q9ClY4c7B3dDkXmSI
	 RwIyk2Oq4HEQIN/7MMZ/x0D+J52lveOllpTEwPAnEAWsvqu2zm45KJBnzTbFaZuOPv
	 ZROGXXp6HMESw7CcxPc0ln3PY6yJEs0nG2nSsFyfsSrUJjb0xoCByNh6V0m02HdFUP
	 U4qs0LSCLB36GN+lva0RWEHSKCkIQmwHHIXinMdhY0R6MW2AYd9lEaaTj8ILiexqlY
	 nrFcf/YGNcz1w==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 stable 6.1 2/2] bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
Date: Wed, 17 Jan 2024 14:35:20 +0100
Message-ID: <20240117133520.733288-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117133520.733288-1-jolsa@kernel.org>
References: <20240117133520.733288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.

v1.25 of pahole supports filtering out functions with multiple inconsistent
function prototypes or optimized-out parameters from the BTF representation.
These present problems because there is no additional info in BTF saying which
inconsistent prototype matches which function instance to help guide attachment,
and functions with optimized-out parameters can lead to incorrect assumptions
about register contents.

So for now, filter out such functions while adding BTF representations for
functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
This patch assumes that below linked changes land in pahole for v1.25.

Issues with pahole filtering being too aggressive in removing functions
appear to be resolved now, but CI and further testing will confirm.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230510130241.1696561-1-alan.maguire@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 1f1f1d397c39..728d55190d97 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
 	# see PAHOLE_HAS_LANG_EXCLUDE
 	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
 fi
+if [ "${pahole_ver}" -ge "125" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+fi
 
 echo ${extra_paholeopt}
-- 
2.43.0


