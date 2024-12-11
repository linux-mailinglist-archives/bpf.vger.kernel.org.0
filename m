Return-Path: <bpf+bounces-46673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E69ED93A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B79D188A3C7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C171F37BB;
	Wed, 11 Dec 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="MReR2S51"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BB1F0E29
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954439; cv=none; b=NAVn93Clpt6kxug6/QuZjt3QMgxAPpaviYqq8A8p0ldfbjyY8esEfIdwP+jrInnONNnFXMJo8XVXNpeizBEpbXS7WPFBGxBtLbq6TtgDHDuSAITxcrK7Nug14cVZ6XD5x9UHOeV3BS2LHXlfjgyovbbXPSe+c8ABePx6vTD0wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954439; c=relaxed/simple;
	bh=8R/s2n0xOvawyOKFmulrk2XWnpC3w9PqBZ/pmvvUVaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxPCKgDGGQv18la+FdYyj+7VAAoyJiokIljT/fKqlo63WhnBjsAo1jhc67I14E1Ct5yjy6iTVjhSu3k7RSOw6oXV2tc1cK6XcvHtPO5iODc3n6Cf25mHTDuAiPe5lZZ9k4i077zL6HlgOF8CmM5APeLk1Fb4CW7cae/hstggoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=MReR2S51; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1733954436; x=1765490436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8R/s2n0xOvawyOKFmulrk2XWnpC3w9PqBZ/pmvvUVaw=;
  b=MReR2S51FtZ7vukRUXBvPgO2VshD+Znsi/dbfiGl4X24L8t2tA7dNzrr
   oYjzUPnJHrrfMuGxWrG1O8fTMC9U8LNX1MN3VhK8LaQgy7d/lESzdrctD
   /3zozX24avLRabJ6IZh/rpU6nDN5d5u4+lgUPdJ16Dn+9b9raEgtrsV/Z
   4=;
X-CSE-ConnectionGUID: VuTNqt7PSrKFZScuN2KzIQ==
X-CSE-MsgGUID: sABJrqbbQAGrGbeukBuuYw==
X-IronPort-AV: E=Sophos;i="6.12,226,1728943200"; 
   d="scan'208";a="28138455"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 11 Dec 2024 23:00:34 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 4709627B9;
	Wed, 11 Dec 2024 23:00:33 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: bpf@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/1] clear out Python syntax warnings
Date: Wed, 11 Dec 2024 22:57:28 +0100
Message-ID: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is my first patch to the list; your feedback is much appreciated.

I have been using GNU/Linux for more than a decade, and discovered eBPF recently.

Thank you

Ariel Otilibili (1):
  selftests/bpf: clear out Python syntax warnings

 .../selftests/bpf/test_bpftool_synctypes.py   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.47.1


