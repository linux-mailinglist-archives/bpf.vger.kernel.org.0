Return-Path: <bpf+bounces-77450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBECDEA91
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 12:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425283008562
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7E31BCA4;
	Fri, 26 Dec 2025 11:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtph3-08.21cn.com [150.223.194.133])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0271D86DC;
	Fri, 26 Dec 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766749274; cv=none; b=nioSXHbQ8vhEkqNuYz4B7SDqm7V40qkB+VE0cLV3SgRvvd4pps1R55ai/UgAnKsdOW8KCisd029HxUFQjSxgQp9ZzTBZYmpz3Dx9lIReJVankU9U4Fbk3n2UD0kNjQDU3aYWw0YuYCrqdvPgFhIk9T6CdRC9YBeIjizR0omwcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766749274; c=relaxed/simple;
	bh=ov/tVDT0o5AjuuB6Eg5oHn0MGnrxc6C5tTcaqBeiPXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRK4meKnex+jy11xtNKchMFSU2DbjMQkFfd9XgeTnQCAK+a5JUQcyDQpXbXKET0jVgIMMuVAiPCEKqrrZ/61gGYJS3CRV0HJyPiF4hUEgweZPR6+bn1IdCaQzl5Wa3/8VD8NpX2OOXO9jRm5CLiuC4CazhBwaCDHBdfxptie1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.100:0.1586089645
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-101.227.46.167 (unknown [172.27.0.100])
	by chinatelecom.cn (HERMES) with SMTP id C25231402E170;
	Fri, 26 Dec 2025 19:31:33 +0800 (CST)
X-189-SAVE-TO-SEND: +niuwl1@chinatelecom.cn
Received: from  ([101.227.46.167])
	by gateway-ssl-dep-55bdcd6d8-lhb6k with ESMTP id c6aa5160f52f4bd586fd9b981f521771 for qmo@kernel.org;
	Fri, 26 Dec 2025 19:31:54 CST
X-Transaction-ID: c6aa5160f52f4bd586fd9b981f521771
X-Real-From: niuwl1@chinatelecom.cn
X-Receive-IP: 101.227.46.167
X-MEDUSA-Status: 0
Sender: niuwl1@chinatelecom.cn
From: WanLi Niu <niuwl1@chinatelecom.cn>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	WanLi Niu <niuwl1@chinatelecom.cn>,
	hlleng <a909204013@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: add missing --sign option to help output (withdrawn)
Date: Fri, 26 Dec 2025 19:31:32 +0800
Message-Id: <20251226113132.3578-1-niuwl1@chinatelecom.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251225091352.3048-1-niuwl1@chinatelecom.cn>
References: <20251225091352.3048-1-niuwl1@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Please disregard and withdraw my patch titled:

  [PATCH bpf-next] bpftool: add missing --sign option to help output

Reason: The patch is not reasonable.

Sorry for the noise.

Best regards

