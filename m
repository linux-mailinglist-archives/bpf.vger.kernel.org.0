Return-Path: <bpf+bounces-51096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CAA30185
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC21883F29
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7517C91;
	Tue, 11 Feb 2025 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqTqA0eH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAA26BD94
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241252; cv=none; b=MwWveejUeAo3hscTpZ3RuEv3JHpbZ3kOxQLGTSOv03bQbH7tNNPONF7/zm48hBQCBgFjz1ywRV0uGsPwCX9mB/mIFKA1Lqua2xYIwsSFNA0IkFBK+SJ2DjetT9fTioY1xYMDKAREsafKsUbBtFqKpDg9WoQAFUvEU2lJssXlc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241252; c=relaxed/simple;
	bh=iOEE0D5jRrVe25YEPmhVC9ReYjvPJy7YLnxcnnqlOBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUM8njT8/S7wFzkRFP5EFnuhRwe863Nb9YKF7hoOcFYVUPP6ZW7enhSQxvLTvo7H8PM6KEQR2w0cWZLfrWoO/FEcEoeqvQi2X5dp/76ATWXLITFbeKZr0kGEa+R5ADHhOTgOKMZIb9FnTjV9qp1iW98WtMlSPPtAXoCKMlsM8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqTqA0eH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f818a980cso33388175ad.3
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739241249; x=1739846049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkaZP4OShdejuyI65doqjZg3XdNVLRE47RaSVrlyweU=;
        b=hqTqA0eH6uFtMehngOC3sFchPpA6dckgA3sNmK2YRS46IqEfZWm/joa7U3YMtCHhXN
         n7YBCC0bnnLzi9z0mYhz8lKb9lZ14IJwSQkmHwJeyooq289YJv1lh0ZMBTwZcakY1zh5
         kxRje4hMB0NCB16PU4Py/4Axx+60TA02knNxWas67CfSy2dVv61DWkyjvveKK5T34oDw
         EmSY/YOBwWoywO4OGaELePKAwiI/WdXw8iY2QwHGVfZbRvAS8BY6QwBoYkJFvDdpeSwj
         5ovkubQzcJhWJQKc+KeMalz/TDuROQi+QObqt+CQSc0biIGjzYJmd5hnAnooQD4QesOh
         fHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241249; x=1739846049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkaZP4OShdejuyI65doqjZg3XdNVLRE47RaSVrlyweU=;
        b=qYJzyvRYW2uDFV8RjNYgA0Iq14dyHxFy8Qc3WlBu93WExnBed6Vedw4buowSzjMTn6
         FiWm8JseJudTHgkGTHtEFNyBEw7riwFYlea1pgJhdJadTxltHEApN0NjC+OoDQEzFYON
         Fp8AMYlmuNgD6wSEfEq9u/olwdhpOZfom6Z0jWvDNIaYVFGRC7RMqYlpvuPHmFzX31js
         6BaTwVVvc0r1/0P2M69z1hpnRzcoO6lwT499urQHFH9UO9E/Nqq+SwlpfZ4+tWq50ZLw
         vXo943hcbEOK3Pozdyj39STDBUGimq+EbB0qzjRDFdAXYxX527AhAiZPr9eTlFG55BHQ
         GRWg==
X-Gm-Message-State: AOJu0YzAA7PvEc4cPVva6S9QZXm67rLSEpuM3KRI7wUY0Omd90cFE4ad
	9wyy19edls/rwNY3xprBAaPOhUgEbr07LcY6MRIRfmHxfG6QiL2v
X-Gm-Gg: ASbGncsEa+nrrwn/n7wI8moTQvu23GTDSSPs9d4HiGgpvFPS2/mcIB7XLMIvtY2YnMP
	k4yl3uGKipikObQEh6hnsbeNsNB82qrPr/BTWEKKZlF6g/RCiR7MmY/VII/74wj1vApPfH4RI/p
	XGEg4PpdJoOwE4Ifc6YAmb7CaNw28NdeiwqV/9nl218zO0qNxZLVuY4Wz/n5LAzr3W7JujEM3Jo
	4WqafuS4cz/n4JK0nJMG+HXYwq31EuXVkmT3Tv+lbfrNWDA7id5mux+OkvyyutsiJm70Tw2/h5i
	aRaiZtXWGQwtkYoXH99bntduCB/oKATf7KrQuSg=
X-Google-Smtp-Source: AGHT+IEnQubMxRlnDvg7Q/1zEz84IDHgcakk7aJ2JDjcvwPedrHr3YS0pRjXqUVT/purbYPtbIfwMA==
X-Received: by 2002:a17:903:32c7:b0:21c:1140:136c with SMTP id d9443c01a7336-21f4e6a5851mr239034955ad.3.1739241248710;
        Mon, 10 Feb 2025 18:34:08 -0800 (PST)
Received: from localhost.localdomain ([58.37.132.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f8dc43971sm30916315ad.66.2025.02.10.18.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Feb 2025 18:34:08 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: Reject attaching fexit to __noreturn functions
Date: Tue, 11 Feb 2025 10:33:56 +0800
Message-Id: <20250211023359.1570-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching fexit probes to functions marked with __noreturn may lead to
unpredictable behavior. To avoid this, we will reject attaching probes to
such functions. Currently, there is no ideal solution, so we will hardcode
a check for all __noreturn functions. Since objtool already handles
this, we will leverage its implementation.

Once a more robust solution is found, this workaround can be removed.

Yafang Shao (3):
  objtool: Move noreturns.h to a common location
  bpf: Reject attaching fexit to functions annotated with __noreturn
  selftests/bpf: Add selftest for attaching fexit to __noreturn
    functions

 {tools/objtool => include/linux}/noreturns.h  |  0
 kernel/bpf/verifier.c                         | 10 ++++
 tools/include/linux/noreturns.h               | 52 +++++++++++++++++++
 tools/objtool/Documentation/objtool.txt       |  3 +-
 tools/objtool/check.c                         |  2 +-
 .../bpf/prog_tests/fexit_noreturns.c          | 13 +++++
 .../selftests/bpf/progs/fexit_noreturns.c     | 13 +++++
 7 files changed, 91 insertions(+), 2 deletions(-)
 rename {tools/objtool => include/linux}/noreturns.h (100%)
 create mode 100644 tools/include/linux/noreturns.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

-- 
2.43.5


