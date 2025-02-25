Return-Path: <bpf+bounces-52532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C94A44633
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174783B8C26
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FB194C75;
	Tue, 25 Feb 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzO/cAYd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44072192D9A
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501077; cv=none; b=D8kPmxjpjr9UVIKQALo+gwpA75TCNh3A1keky6HzFWjkpvV6TQKBMY/gPbnMQe6TlgKw+S1CCoF6azOCp84qM6g+GdX7/GKGGKi9ttf2X8gbEJmshEY+semmCwsy2/RyKwphtxrvnz/l0GjW88Edf7J3tbf+8Y8I8i1Zwyt6cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501077; c=relaxed/simple;
	bh=VPCOImxXQJ+8Kf8SzYCWjTWOCtqLYoheuiMQQC5/96A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLHW6ZoKidotMVENgMvuA24zkmnM6ZIHaDEhf3aANIVLhKiowOqV45dg+f/otnLQhdR/t0Qcg1rhzrXkOFR5C8kiuVQl04vZ+xEXoQPRqqMmoWfd1iboouqEw+PlCXg9nz6CR+jBMp07pv5jV7kN+/Y01rDwVpJtgPJLhnBVxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzO/cAYd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab744d5e567so983315966b.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501074; x=1741105874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHPcD6dSFZAgUGsKbsKMxoGzYRdtDJmtemVeq0bcae0=;
        b=UzO/cAYdpeJm7Y6oUjrFczlsBOOaIVI+BM3ofDC3v9EaOKhU70cjCOtvxNTjmcwqX9
         i4JXP0kbqrAYx6KRCdw+ThcgzUumf2KZJ0MKmAl7eOgj2kqAH0wGV12hJtN0FEWQj8Ef
         SQRPM7QAiwzUMzgPl9hAGpMl8c4lMCGEXUo/zx4wHth9HNa/Y/3XGXd4RBI6cyhiz2E6
         +PXJEOYLbzd9IVHdDax9D7cZLaWtOFqp99ptC23nBC+mm6xPM8YsLMkMi9xzDbLFcw2l
         5a4aU7N1nmHErgyT67nLZKqcM0lR2LYY8DCnoPM4aHtG5DqeA1BFY4Hdqx35321ubKAH
         fUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501074; x=1741105874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHPcD6dSFZAgUGsKbsKMxoGzYRdtDJmtemVeq0bcae0=;
        b=oe92XXsUwJUSxMhF7jb5VJktgWBfRp4P4r0IXrsO7UtHCzgMhiKJd2OCvqXDz32AzP
         JymyIU4akGT/1r3MWLq3iB+d/WLuGo3myontB5ZyyoJmJHiA5ZrnC8NY1SFnxoGCMZVn
         BiL+ep14OcerdnhWlNU1u0aGslY9pnwYW4L8bx1TIYiAsaeexoeT47eRCYv+lmjblTJO
         QGAdqXt2K0hNxXVueE8ekqzvCB+GBy99TprV9sz0uL9cC9NutQ4j6g5SEHV8lcsSyc5O
         qSqKwoH992bWWtC6kn8PjJl9xprmOE5l+qaEFuaUOAZ4x+NuoLakQPhO3tcYDfbPo3ny
         w/Uw==
X-Gm-Message-State: AOJu0Yw7SAltM0Wf+WWHicpWo5xX/5SYRamSNoUDFUdNuk1W/4bGxnMv
	tagMwG3C05Wkp3owvVOEy2lcglXBK9obb87nhHxA4PV3fi4ZWTicZ7buXg==
X-Gm-Gg: ASbGncvzUC4QxAkwnzOuJk0syQAfocW3n/y0Y/GUeHF1gHREqkty6MgT8rxO70ByOSV
	mvPOPAGDfH+vH8FW6dqL3/iKkS3m9Qs8ACoxpfoMv5RSrBWxbk/osnrv7TY4bKCgqn4rB3L8ZnI
	9Ie6VR5JFtQn5mI+i4FWWOfdU3LdpbYLCKb0DHsbcbliK/xk9cK9Qc/0Pqkj24ZDdy4UUSW0hjT
	HZi4Ygqku63rDLQ0qOBetcvhiUFMIXNmJDZiD5Mh+tw8qTjxNWFImaSvvToZ90jLPiBHSIL4qqX
	cqCDFHCC3poIRzrGI5Pb8f4mFCgzb3/Jx/1a+HF5
X-Google-Smtp-Source: AGHT+IGDHqnzG3eNCCLdjQhZy9suf1NAJ3h1S+wzFw7RsMsa374yPTL57it8U/lmm8YFHVickmwgNg==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abc0ae5728bmr1921660766b.10.1740501074257;
        Tue, 25 Feb 2025 08:31:14 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::7:2cec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013321sm167178166b.96.2025.02.25.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:31:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 0/2] selftests/bpf: implement setting global variables in veristat
Date: Tue, 25 Feb 2025 16:30:59 +0000
Message-ID: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To better verify some complex BPF programs by veristat, it would be useful
to preset global variables. This patch set implements this functionality
and introduces tests for veristat.

v4->v5
  * Rework parsing to use sscanf for integers
  * Addressing nits

v3->v4:
  * Fixing bug in set_global_var introduced by refactoring in previous patch set
  * Addressed nits from Eduard

v2->v3:
  * Reworked parsing of the presets, using sscanf to split into variable and
  value, but still use strtoll/strtoull to support range checks when parsing
  integers
  * Fix test failures for no_alu32 & cpuv4 by checking if veristat binary is in
  parent folder
  * Introduce __CHECK_STR macro for simplifying checks in test
  * Modify tests into sub-tests

Mykyta Yatsenko (2):
  selftests/bpf: implement setting global variables in veristat
  selftests/bpf: introduce veristat test

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/test_veristat.c  | 139 ++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 +++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 tools/testing/selftests/bpf/veristat.c        | 309 +++++++++++++++++-
 5 files changed, 503 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

-- 
2.48.1


