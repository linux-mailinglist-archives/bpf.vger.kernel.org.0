Return-Path: <bpf+bounces-47422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB69F9550
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D0D165AC2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317F218EA8;
	Fri, 20 Dec 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq4OVhuh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF425588F
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708161; cv=none; b=uJGaqoVmPLey6KJuNSWBX3j3UMpznIr6C/lqQwGixgQOFfMQDmnI/PIgPdQNjMa05V5c3kG+k+B0iX+EXVEOG8MFyIWDqCc48/3a1SgNgEoOXQwEArrIEbbuAMc43N4fppTY6FbOnpR35/5cSERznGHUsJNQLRvYFF3Z5CemS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708161; c=relaxed/simple;
	bh=py4wxPNRT64EeJybmOfIYtXBNfx4xZOwe1/k/wprMYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDcWc0XORseG3KgWo0FkhaVmRea28QwFwWOe8pT/tl8mJCNRr/lvj7t5BF60LEWQoUwhJhuTreEcUQ/ot0qLrziG5lPfRfqIYohmPmkDvMgAVLh0ftZmDmqQG1BIKBU+hdMyzjuS159ekZIbyD8ZPqAEVg/5/VNrgV8YZeOg3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq4OVhuh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1420761f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734708158; x=1735312958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpklzEWJXgw1Gcp5KkQrC+ixCwlDxoZVZvtE3PON/Zg=;
        b=Iq4OVhuhyq4COaSM260OUxE1hyk2QbZkwJUl4EygXO8VdLed+U0VPkW81ahY4/Wm9K
         O9hQv6yPWWOYdBxrbRjcSZmaTwNwHTKSi3fynbcXADzdHhWgpRxr5/JphwRkTxFMAOX2
         4J2NEHS2QPUz/f+myMaMs+WTt4+8d9z5DXkNqjQiro2uBf+HLqv0dXYrKUsGtnf6idN8
         a2pTvmgkS70Q2XBVRKk3tnYuhFAtfKoBvvXTovbswz8hxErRIWGJHY4+S7FZHD9fMOE0
         cRlyliwIAz+KYJDibASWGb8nwuBLSrDIxOdtw21F0wWY4ULP0VgIf/ogmT1X8RL+L066
         kRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708158; x=1735312958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpklzEWJXgw1Gcp5KkQrC+ixCwlDxoZVZvtE3PON/Zg=;
        b=GKvMf1JsODwTz3kDHWxXaBDt1d9+GV4AdjVzqrYMDjQM+Vcf3dzl6f0LpeBfo5TBVI
         FhLEwRhMhEJ514C3wPCTwFbghVQgOvc6JJL5k0F0t8OB7S+9tjg0jux2Dk5K94zRF2v8
         S05oinp9qHub9yodMSkxOXhYpKHNtCNT28gJ93LnDY6YaRmrHGzb4vfVs11hy9VDzTAj
         /x6XAHlIfBDRxjkL9vZCnmmcq4HH94o68Yj/+upsxluOkiH7WTK4FX2LOSyXoY+afVaC
         U3+dUW4dxN3vkwSqGdNoFIVO1hoa/qBwvzBUeoinXNaGH1F8gjsHwsz2AsOLFDW6vFqt
         SMJg==
X-Gm-Message-State: AOJu0YwlBAi6o6LHjHbB6vN1DhnfMv/jaXsewBvPr2ua1SdAicWQ4P0k
	l4ITW0+BVOm3M5br+cTlLuh21GLHqUmy9bqeX8gp4td01OrV0NTjwA8B+ifgId0=
X-Gm-Gg: ASbGncuRHmLM6aCgHELFj50zKgocb02rGlkA91YOIP/OqJG9N91XDiujEOwyy8Uzke+
	rqgajacLZ+GV550xntefqNvblZUaVb3FsEd6fZlQ4IGm9aH7hD76Thd3ZMQgAnSBSgQj7lKLOnO
	PiiTRv4Q2AZDeBbTVtJHCQI2TQ3R3ktENiFozljqc1a1KT/bwooYvsNmqsJWxo3LrdvHl2vMmwq
	v/0FJdw5v/oUtHDntmRS8q/lTvW9k6tjDgyzsgbx8aWPeB2Yp93Y6NVyYNhxVh1fka6f3ZCUlWg
	9JglPZtyJ5Cm5SnKLXcwACFzR0V1WjiUUSmSE+Z/hnT9UZL77+f8IpMqbKmTZn+v974N
X-Google-Smtp-Source: AGHT+IHXxEyK4GjiunofLBd//fhSYCDFTYFFeCsjQr4BrpcnAQcruq4ssqpH82/oy3RbhVFCmw3g9w==
X-Received: by 2002:adf:a392:0:b0:385:fc35:1f75 with SMTP id ffacd0b85a97d-38a22a11b62mr2470760f8f.12.1734708158201;
        Fri, 20 Dec 2024 07:22:38 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (81.125.76.34.bc.googleusercontent.com. [34.76.125.81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm4316921f8f.54.2024.12.20.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:22:37 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yatsenko@meta.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: fix veristat comp mode with new stats
Date: Fri, 20 Dec 2024 15:22:18 +0000
Message-Id: <20241220152218.28405-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 82c1f13de315 ("selftests/bpf: Add more stats into veristat")
introduced new stats, added by default in the CSV output, that were not
added to parse_stat_value, used in parse_stats_csv which is used in
comparison mode. Thus it broke comparison mode altogether making it fail
with "Unrecognized stat #7" and EINVAL.

One quirk is that PROG_TYPE and ATTACH_TYPE have been transformed to
strings using libbpf_bpf_prog_type_str and libbpf_bpf_attach_type_str
respectively. Since we might not want to compare those string values, we
just skip the parsing in this patch. We might want to translate it back
to the enum value or compare the string value directly.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9d17b4dfc170..476bf95cf684 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1672,7 +1672,10 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 	case TOTAL_STATES:
 	case PEAK_STATES:
 	case MAX_STATES_PER_INSN:
-	case MARK_READ_MAX_LEN: {
+	case MARK_READ_MAX_LEN:
+	case SIZE:
+	case JITED_SIZE:
+	case STACK: {
 		long val;
 		int err, n;

@@ -1685,6 +1688,9 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 		st->stats[id] = val;
 		break;
 	}
+	case PROG_TYPE:
+	case ATTACH_TYPE:
+		break;
 	default:
 		fprintf(stderr, "Unrecognized stat #%d\n", id);
 		return -EINVAL;
--
2.34.1


