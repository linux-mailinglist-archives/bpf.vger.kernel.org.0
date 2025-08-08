Return-Path: <bpf+bounces-65266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4DB1EAB6
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5563C178003
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BBC27F012;
	Fri,  8 Aug 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahOE/isF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF5280CC9
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664704; cv=none; b=adgpLDxT0emgiU28tAy/zJXmCn8p/Fice3riaqReqXCJjg/W/S48FRle0HwoZtkecu1Lq5KqggiftZbXGSX/zLlgXYz97Hrw+bZQqIRfuxaklmI37FBLRm+pEvaDdrJezmmIPixh5/Ot+GpKXSX668qCcaFv2gm4lszwUlstqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664704; c=relaxed/simple;
	bh=I5rM8gqdNv32uDfduqmsk/p7yggCsLTS2zDpjzTYado=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5E/7r7/7jHMojXQq0kbhSPsiCH6etO7zQZhy7OZM7EP8+X/1ixdZcaoIBTHlJrkj5SVbqvOsCB5tbpMZ0Zzbb5fBUPwUoPdblk4Gy4s+UvyWMmwtDTmybBaJqBNYIS5Nr+f8q08amUv8D1KQTAJpQra/bavinF4HtVCNn111rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahOE/isF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so2553580b3a.3
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664701; x=1755269501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdyeHUIb8QzOJMuge1HlRqv1awIMTSfUxfsKc4HK6Tg=;
        b=ahOE/isFSqIg0OAKYKln7Yglj6+Nqm996NN/uOzfEqngWPOZlfgYUsXVrxElRvIGnv
         oqMCCJ0GdJCursuf6ql44klDuZ/uxRtErHscvnwEGDfuZc25yT82KfUcZJbhnMZmsfva
         +gRH8fBqJqwY+DRlJpjwMDOSqsRSQTQX4iCHOtp7kDHInb8+R2pFqxCauwDJQ2QeYO1G
         x4XhU5E1s/YTAvgN6q4y4f6LydKQes5G8GI1hNclAcyovMDFc7ULcuDG1p3CZ6HKjNew
         /qdw3Wp8H6Lm7zDZBl7ndAYhrZ/XIclS8Q3QUABbn9zxz/IpTOS/QNOiCHk7+Q4AMeWH
         I5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664701; x=1755269501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdyeHUIb8QzOJMuge1HlRqv1awIMTSfUxfsKc4HK6Tg=;
        b=q9vrBX5ammkKGQoVaJl9ns9gfcbnYC4vRtgVeqdpxOTu/T7NEaXjSyAWlnXZwvr59f
         XwWuCqbimC9xsRYaWtGo9bZEc8e0BL2SGU/cNKAmJzJOgI2s8NIddVbzu1EYOLUHNxHo
         2WnhleMLc5mFHLX0wkQ7GRRPc0KdDSc/e299LqwYQteWze26/eX29jMbBcgWR9KwPGot
         /nzbLpqLej4NPbeSCXizzcwjL+RCk0YcBI7HP043guSYlJM7Us+ml607mAzMpZ5gjBkM
         HCLQxCXrNuU7++MrjFGUtG/O7UcojEG+6uhWwNbM9CJr/lDpQ2iBB0EmPAltstUdAsqF
         ShFw==
X-Gm-Message-State: AOJu0YxXPnov39cqaPLRgh8ZFZ6bD00Lsbb+7Uz00w/tFko9gUJFsJBf
	QdboQ1oE0DGqIfRHJ9G2eOPLm3he6TFHfZWsk3FQrJh/hvsY1xU8cQ/HeNWgFw==
X-Gm-Gg: ASbGncsLrFbTyYtZwmpbu/iPJRxWdAalYhYbtCQiO4HypSqQ/D4uchxYvnH0BcONkgz
	R6HUZthzvBsElLGyxou3UU03rRKceSjlR3RyumXGyojL3ddHiE58xuOaBAqE62CFhWiz/DF+yMu
	SYwDFgoDDnZ5sjBsSRfmBb2o74uozhiB+7+DTd9+pM92LgXtIa6cLWnkeO+06K/qJpdDlugekqD
	fFCGMG4NzZrVB56R3Gaco91dAUTivUL4/eYR29H/HUd1itmJMhoj6AksyzOyvuJ0TMa3AMhhkGd
	m9Bx0uI4fRSVzCxq0uDGshu1iRQ/QrVRqEFXvRtPGngWe41ZRrXOvdnpHXnb31ZObCcd1moe4N7
	cjK/RmzQcKYWfIZAnrANkEYJ52jdG9MrX
X-Google-Smtp-Source: AGHT+IF8S2P1re140akiPMWf6fpiLHrH0iLyFwDQabvS4SJC5KuhEJwPi3TmJGEypCjjp3yBepuHBg==
X-Received: by 2002:a17:902:ea08:b0:240:4faa:75cd with SMTP id d9443c01a7336-242c225554emr54468325ad.48.1754664701449;
        Fri, 08 Aug 2025 07:51:41 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:648:4280:48f0::2390])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef66fdsm212282725ad.38.2025.08.08.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:51:41 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH] bpftool: add kernel.kptr_restrict hint for no instructions
Date: Fri,  8 Aug 2025 07:51:33 -0700
Message-Id: <20250808145133.404799-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

from bpftool github repo issue [0], when Linux distribution
kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
instructions returned", this message can be puzzling to bpftool users
who is not familiar with kernel BPF internal, so add small hint for
bpftool users to check kernel.kptr_restrict setting. Set
kernel.kptr_restrict to expose kernel address to allow bpftool prog
dump jited to dump the jited bpf program instructions.

[0]: https://github.com/libbpf/bpftool/issues/184

Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9722d841abc0..7d2337511284 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 
 	if (mode == DUMP_JITED) {
 		if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
-			p_info("no instructions returned");
+			p_info("no instructions returned: set kernel.kptr_restrict to expose kernel addresses");
 			return -1;
 		}
 		buf = u64_to_ptr(info->jited_prog_insns);
-- 
2.38.1


