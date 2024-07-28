Return-Path: <bpf+bounces-35835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A593E93C
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26B81F21733
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF486F2F7;
	Sun, 28 Jul 2024 20:29:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D222071
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198564; cv=none; b=B141Adeu6rvPKjLb/GabOLPjtPZvHAQd6HFu9JIXyAuQwm5uunn94OtgS2mE9YN6N+pyY9tnWlCMH0ALWDKe67CELnfQ1XdXmA/6eMR3gO8ILDtmfxlETGC+WKiUbNcnoTrW/2fV4xqVBuuJGHbr4FVI+wEEmOK7dyCFy/cGX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198564; c=relaxed/simple;
	bh=frlFbRu9v32k/jnpsYKwU+l6dJQ/+vf9rou6FeuVfZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvCj3na9Thdl14oM2T+rEZc6gBKHRqJ8r/mFBW7FlfgPa3bHWbZ8hs9SbVxmSME2RD1LpWDY1R3AwE8drFKJalq8b2m1LQ0jDvOlR1hQYBR3ze+jScgL2RPaPrIt/U47zKStPbZBNv6bXlCMI7ko1QzrRgq5iXxklcEwXZKwVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lobanov.in; spf=pass smtp.mailfrom=lobanov.in; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lobanov.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lobanov.in
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a0a:0:640:67dc:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 7E0EC60900
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 23:29:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8TabUBL5PqM0-8YwfFXmK;
	Sun, 28 Jul 2024 23:29:10 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass
From: "Sergey V. Lobanov" <sergey@lobanov.in>
To: bpf@vger.kernel.org
Cc: "Sergey V. Lobanov" <sergey@lobanov.in>
Subject: [PATCH bpf-next 1/1] libbpf: add an ability to delete qdisc via bpf_tc_hook_destroy from C++
Date: Sun, 28 Jul 2024 22:28:53 +0200
Message-Id: <20240728202853.87641-1-sergey@lobanov.in>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_tc_hook_destroy() deletes qdisc only if hook.attach_point is set to
BPF_TC_INGRESS | BPF_TC_EGRESS, but it is impossible to do from C++ code
because hook.attach_point is enum, but it is prohibited to set struct
enum member to non-enum value in C++.

This patch introduces new enum value BPF_TC_BOTH = BPF_TC_INGRESS | BPF_TC_EGRESS
This value allows to delete qdisc from C++ code.

An example of program compatible with C but incompatible with C++:
\#include <bpf/libbpf.h>
int main() {
    struct bpf_tc_hook hook;
    hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
}

'clang program.c' is OK, but 'clang++ program.cpp' fails:
program.cpp:4:40: error: assigning to 'enum bpf_tc_attach_point' from incompatible type 'int'
    4 |     hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
      |                         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
1 error generated.

The same issue with g++.

Signed-off-by: Sergey V. Lobanov <sergey@lobanov.in>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 64a6a3d32..494f99152 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1257,6 +1257,7 @@ LIBBPF_API int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id);
 enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
+	BPF_TC_BOTH    = BPF_TC_INGRESS | BPF_TC_EGRESS,
 	BPF_TC_CUSTOM  = 1 << 2,
 };
 
-- 
2.34.1


