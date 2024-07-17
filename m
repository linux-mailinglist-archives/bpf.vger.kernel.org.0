Return-Path: <bpf+bounces-34951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70D933DE9
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F2C1C2390F
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677141802D3;
	Wed, 17 Jul 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK+RPD/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066517F37F
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223931; cv=none; b=oF/sS9X0bZ97eq7yTgt9SjiHGPjpIg+1Oa5QAKat7rmdMS5xahrEixPpReWvGmv+kXhDLW2BX6jClZ+KtipntjNoIN0SKrn92QX3aUvfaGFggN/BwD7G64jiZW3euJMg+8s1pbP/LC5yg3mSp2SgAa2v0oGLLo+wLI/cipHudOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223931; c=relaxed/simple;
	bh=7ZnriI4w/GfdtzmwhHwrpYcCo007XOwaFu8h9DQcoK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4fc3jbwczFSQSvaTaJdT+xtcOxKn52EAMbv1uCGgjoOhSiS+N/skrxKglR0Y4l2nw7Ih9rip9zEwTb9xSDs8IXWnpE1ZLIVvCQRaLNsm/VL8F6HmgSVA4EUDkiI2gu9NnBKMRIsvz3QZzKLIksyPDHXAjqQzAF9DgqHFvwQ//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK+RPD/M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367a081d1cdso3524880f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721223927; x=1721828727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RP/KTHR3PKeyw0Q5a8CeS7rXF7/3yGUa0lInjxBzDq8=;
        b=fK+RPD/MUQppt3v7jqrIWHMT9HLiEcLoI09LT/vXOiBXOx2LfTme9AUwVCXbBiJfP9
         Dspyh+T21RjCKj75J9hvmRS/hdwocTTDbclswdv4RSlb2cFAD3099Nfxg+56ibpe3dFW
         EaRO4BZUytF2rNSVfmmLcKhhRgmtSPPlWFgwY1ekq7LPug5qWQMQcqhfVN1p9X36jdeV
         I//Q4TG1UK07NZ8JMqOx03DQAWyGnWcoG68vRxa6tkRjRPqgC7P95ZCCZF45LfTIFd4F
         SjcZiS6S6u0JPGJUgy2HsVHSNrNLjfHhD2RGFsIqsDhAYe+4fn59bIcdw++Tsv1IPn4o
         vhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223927; x=1721828727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP/KTHR3PKeyw0Q5a8CeS7rXF7/3yGUa0lInjxBzDq8=;
        b=mKL50ikCy+NOZMhj+jAwN3+LyQjQyXK+Z2RKuRYNFzPVQfQaE7Kr+MycTL6HOuVg6z
         RPaGwGzHn/kvxz+aD+0spK3SkEH5gUn/y2oCBAVMqK/uEctDdGjYbSiedMHct9vrH2Zu
         s0j/s91kRQKc4cKPWs7TexMWKl1avH3ianZEVDbJb5DeBOUqmt/mavUiRX6wQwVbnZIN
         UU4ypgGIFR4aBTTwAyAvUdRMFHLFkwr+Qhr0eHU80tDomYwwZMOG3KsmZLNIdmmvgkBI
         oPKSNgQwQrUQZOqeIbVYHOGyvq6RUE49nCKVhXF2xi/CC0HEHiEffRDn1xyEpVDITTqa
         9zVA==
X-Gm-Message-State: AOJu0YyTTsg7K/6rOusQtJrzGPaE5zL5RG1YU1UpaRfDvnsIw6pAvNFR
	d6tGHXkSjdfp02XomqXbr40bChJwrThAxriwqB9NSw+Ccu5vYWpFXmMTxPCD
X-Google-Smtp-Source: AGHT+IHpWI5IPsLgIgDJ7KC9OhJN0JM+rC4Pq8mz4yZfdlJ4KTKA4wQJ5IKV1gmdN1dxZrpIWEqwQg==
X-Received: by 2002:adf:e708:0:b0:368:41bd:149b with SMTP id ffacd0b85a97d-36841bd171dmr552390f8f.34.1721223926600;
        Wed, 17 Jul 2024 06:45:26 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a446:8596:96cf:681b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccdffsm11814455f8f.54.2024.07.17.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:45:26 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next] bpftool: Fix typo in usage help
Date: Wed, 17 Jul 2024 14:45:08 +0100
Message-ID: <20240717134508.77488-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The usage help for "bpftool prog help" contains a ° instead of the _
symbol for cgroup/sendmsg_unix. Fix the typo.

Fixes: 8b3cba987e6d ("bpftool: Add support for cgroup unix socket address hooks")
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 40ea743d139f..2ff949ea82fa 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2489,7 +2489,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/connect_unix | cgroup/getpeername4 | cgroup/getpeername6 |\n"
 		"                 cgroup/getpeername_unix | cgroup/getsockname4 | cgroup/getsockname6 |\n"
 		"                 cgroup/getsockname_unix | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
-		"                 cgroup/sendmsg°unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"
+		"                 cgroup/sendmsg_unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
-- 
2.45.2


