Return-Path: <bpf+bounces-21905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6332853FAB
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ECA1C27BBF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A3633FE;
	Tue, 13 Feb 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="JowB9Xcc"
X-Original-To: bpf@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213462A12
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865638; cv=none; b=o7e3P3G0c+sGfWYG3oZCyrv8g8FtnVea2MuNjMOQ9XKheY1jvat59wjf1nH2a/nAMJ0G59yxXEqXahndpqXlpwW7uB52rhgigjV3dxAlDsVlBODz1LcH951Ys9sSQc/xUuZvefyCp1dofUN0kgLnAJX191X479/fjRSfi268BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865638; c=relaxed/simple;
	bh=IlOcdAFyrGcBZwjqGuF72RmOCiW8ydDgssaTemzVqmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XacRitk5PEWOEzJzoRn/pdu9H4Aft9wImij/qdziGB8b4/dfVmqHi4bGFNgF1vuZqhvNYkneHyP12XityT5oh+cknE9p096eJKDGhFXpMhL4weNzbqvMkljCAURmlrrZxb2emn9zKCxFyczH+IIJEjruhD7HO5E4W+OzSz8tef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=JowB9Xcc; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8E42C240027
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1707865627; bh=IlOcdAFyrGcBZwjqGuF72RmOCiW8ydDgssaTemzVqmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=JowB9Xcc5U4uBk9P8LK8XnTzPTBPoqKdwuOCs5M50eCXs32ntNmtYBuOowMZyLAV6
	 xGKZrJynU16V3g5XfaZqsac9zOXeVbm01DnYG6QuvPQap+B1l4d5RPHoetLor6/Cge
	 8TPE+Xi2y5EFJAqvHa5bnRBEIpGzYcTiu5xoqdM8LoeYriBlyaSdqvfw7AJAXvC+kY
	 8S0DK/LJbAXh16SzQk1YjVdgKUjD1nnWIU73rEmBUzaTFzUbLvfYg08/Y/bfmww6yG
	 /5KtXbBVef6wyHrqG9bmiERrS9ejBVpK0WaJwwA8I5JSRbQqJ8QyVuBkpI6yv0MOLU
	 R0VZB80gH0rfw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TZH5j1FN4z9rxG;
	Wed, 14 Feb 2024 00:07:04 +0100 (CET)
From: Gianmarco Lusvardi <glusvardi@posteo.net>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianmarco Lusvardi <glusvardi@posteo.net>
Subject: [PATCH] Corrected GPL license name
Date: Tue, 13 Feb 2024 23:05:46 +0000
Message-ID: <20240213230544.930018-3-glusvardi@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_doc script refers to the GPL as the "GNU Privacy License".
I strongly suspect that the author wanted to refer to the GNU General
Public License, under which the Linux kernel is released, as, to the
best of my knowledge, there is no license named "GNU Privacy License".

This patch corrects the license name in the script accordingly.

Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 61b7dddedc46..0669bac5e900 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -513,7 +513,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\\ () system call, and this
-- 
2.43.0


