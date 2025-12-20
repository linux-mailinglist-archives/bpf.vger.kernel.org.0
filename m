Return-Path: <bpf+bounces-77255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FCCCD34EE
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962943011402
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89022FFDEE;
	Sat, 20 Dec 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Agy39tfG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="INt2TyLQ"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CF18DF80;
	Sat, 20 Dec 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766254749; cv=none; b=VS36FZiyBLo/8ZTAe7GAJRudQtLf5XgtbgvI52BbEyAFBlHAW7mwpoYWbNsygT0oTnFJBodAjIvfDoPeyqyprUMfvHvA5zuFzJX39FlsHwx3f0UMMt2yDcJRTy4TsCQfJ5VYAMn9cZ1ozMNKJqn70KsQsvJBrsIbmvXraGERmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766254749; c=relaxed/simple;
	bh=z98fgVAElpIWEn5pzTR7JAHTTJIUEhEvWNh6CI5TNo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVjPbFehT+VGlQya3e7se//4Il4yiJsX7LVizEg99dsq5GZJSjWBPldyVw61QREQ7XEFToIbMC91UF+vdo5iwv6ZL3430yGpRZOh167d1NFNpEBqJcavbisK7xyvoBQ5wl0C6NP1fpLVnl81vX0grPYdHtHvcJLENZz7USXz/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Agy39tfG; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=INt2TyLQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dYXjG719Wz9sxL;
	Sat, 20 Dec 2025 19:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QXxrOEVITJGj5z3HA/YPZ+p2C9DX/MyyDl+5dahe3U=;
	b=Agy39tfGcBbJyaA8oGEwFSV01cVCyynBWCwMTTOKgCDSfkMN28agaf84ODbtohRBv9gHBd
	aQDXLyyAkS3mqfA6opdLBtX4SWlHekFH/GNmUDmXdi4rPSf9GPh701sjpFS7p+j7AJhcLe
	92Fp7OdTHLjP+Z23QZ44Fl990vmHmqsZd8k79bQMEzOG+D0oxeO02q4fhyWNlWduIk5GFS
	B7stCnsORmfqNzsO1Y7ozHDrhthESBz4tBPJ3ttfqzOchnPgnrSiDAp6gHkKjC8hm/Pxit
	L8rQAOXpII437RbvIHlk5JnapBoQ01buV2IWYD8eJep0JiR96OKqSdQud6ewZQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766254736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QXxrOEVITJGj5z3HA/YPZ+p2C9DX/MyyDl+5dahe3U=;
	b=INt2TyLQ/KjjqTrBEwatwjlqRjzKPJFjWkTA/ifs2dFZypJsVJEcF4ftQYDTOPXL2Z/yi1
	Ux48b79gKPvBQCO0JT+TTq3FdpWogBNGElFKtAq4YAPkajqFGRnxDvS7cWi/Z3NZUhQMPt
	8bsXqJwK99Ug58C0MDHrQmOykPN9q7aumG7u6wqQeec+nTF/t5bYiVFfqobiNg5MNnHHeV
	WF+La0uw1bpUFRzVsg8ngMqZbiZHQ1ycHE3FXzwAzOmxuVCydVcJatq69RopL00xsrblv/
	7M7eGjUmOWUPbZJL01ax5xs3kTo077C7bSZ61SYvExGLyUIZO/aIrM5LwZLA/g==
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: georges.aureau@hpe.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v4 0/2] kallsyms: Always initialize modbuildid
Date: Sat, 20 Dec 2025 19:18:36 +0100
Message-ID: <20251220181838.63242-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 961443fca8f85b8c18a
X-MBO-RS-META: 4sydgrc6zfdghwcu1opmywd5yn14ff5w

modbuildid is never set when kallsyms_lookup_buildid is returning via
successful bpf_address_lookup or ftrace_mod_address_lookup.

This leads to an uninitialized pointer dereference on x86 when
CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.

Prevent this by always initializing modbuildid.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220717

Changes to v3:
- Split the changes into separate ftrace and bpf patches
- Replace IS_ENABLED() with plain #ifdef

Maurice Hieronymus (2):
  kallsyms: Always initialize modbuildid on ftrace address
  kallsyms: Always initialize modbuildid on bpf address

 include/linux/filter.h | 6 ++++--
 include/linux/ftrace.h | 4 ++--
 kernel/kallsyms.c      | 4 ++--
 kernel/trace/ftrace.c  | 8 +++++++-
 4 files changed, 15 insertions(+), 7 deletions(-)


base-commit: dd9b004b7ff3289fb7bae35130c0a5c0537266af
-- 
2.50.1


