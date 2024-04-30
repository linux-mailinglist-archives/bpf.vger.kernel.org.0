Return-Path: <bpf+bounces-28253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839218B7452
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF26B2254A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9812D75C;
	Tue, 30 Apr 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwkBlYqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142712BF32
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476568; cv=none; b=RfG66EOnPVDUpeuI1XFDxICIL7WDyQuNvoDPLVG6G3Cn28bcPz47m68sE3wg5DNtEK823UHJueDEKfORTlLT9bjpiCvW0KhC3/NasuvcbkkX8t+dHlRvjQ5cB4lbpU6ssPbsFpOxymiTgZUD/wtziiDyI2h/ZcJ24r3U+5crOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476568; c=relaxed/simple;
	bh=qMv0VUejK8Dz43DAiEt2MSwQ0RtGrtZudKf78kDh5B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmSaSxjLiMw7drWnZouK49qjXUecFs5Yu5+PNMadv1rqJA8SsXRpQif6/gni0mDs/sGTHY0zdrcvntrdME8PeClOa1PHMklflzVnjskgmIcixSdqVH8ZqNHcLprinkAh1YLtqMXYFIHsmF4M2CcNPexuopQCF8CsziHU1DOSO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwkBlYqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E6BC4AF18;
	Tue, 30 Apr 2024 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476568;
	bh=qMv0VUejK8Dz43DAiEt2MSwQ0RtGrtZudKf78kDh5B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwkBlYqWkRgN+k3G2q2Sucug4Q7gz8xyfyNbgPTVHSq5UveOgWlvhF2H9Iicu1Fdk
	 OTg54a+r9b6kS8S4dUOM05bzVHMXIJU2nkFtyKkvSF9dTPAJia4fu+6JQ+3QSnNpbL
	 ANp2bsh8JzrYVed7wtALFLzF4ulp/wFBzevlTtFXUafAXA4UqGpF64jFgsWPsirlJ+
	 zuJ482fM3uX3aAK0vSUaJtPz30zs1NE87eZG5PjJoBfNBg07Ai0fym0E/GOnqeW0bE
	 8aj24SKCmJJ8nvgWTNG5r0DVtQAvTqyzjtc+8+od5Q9JSJiUXbuVNWtNar6TUdNhOA
	 6KQFy/Q8i7DxQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 5/7] libbpf: Add kprobe session attach type name to attach_type_name
Date: Tue, 30 Apr 2024 13:28:28 +0200
Message-ID: <20240430112830.1184228-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
References: <20240430112830.1184228-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe session attach type name to attach_type_name,
so libbpf_bpf_attach_type_str returns proper string name for
BPF_TRACE_KPROBE_SESSION attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 16dae279a900..7667671187e9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -132,6 +132,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
+	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
 };
 
 static const char * const link_type_name[] = {
-- 
2.44.0


