Return-Path: <bpf+bounces-50303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1CA24EF0
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA12188467B
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC21F9F73;
	Sun,  2 Feb 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkukWyu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBB1ADFFE;
	Sun,  2 Feb 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738513780; cv=none; b=s3CYuNhVsE6qX6g03PUCE2ofYfdeAJOX91c7Mkd1AXu7MKpIuDhQppxK6Nj2Ua/3U9TS84HLRc8DGQLbxXlwTk7AVBnt81Azo7bfHL6GpwhtpBPHGpMeP6ECwd5ni510vjJQeoiPnpY4o05VmXRCaeW/Egj/OV1drs1d+iXB1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738513780; c=relaxed/simple;
	bh=e2mh6TTcDzXJIkgzSUVAzKX+yZCSiN7ytIoogmggqts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlu1MzN/dYw1q+61m1GuibF09056T9mvkBm4ghtMdVnLoaz84LXxHvrq2ov0gy5q+1bBK9OTIltHxlAbaSBtvaIzbcYjz5Of6LZJoKLRMGGtWqeypSZpLMLBQMPf/s/uZAIj4jDwneejSwbXmpeYeqSTDr5lQ8OiVSHdrJLgjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkukWyu4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21654fdd5daso61281865ad.1;
        Sun, 02 Feb 2025 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738513779; x=1739118579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9UQSQGwwSc3ZkbYQaSP3JwemKDJqC1iBrUfH4aLmwQ=;
        b=ZkukWyu4bE14NjTB8bXWqgQKHhp63n/75AsROGXEq6/vR3XrqzMxtw4qRp1fzIpQYo
         MLI5JiZ+yx1b0YnMQltDt7vAfMljA3KtJCxsYcCiUo1U5b1WDoiBXfkiY1NIzB+m6j4+
         8aGdzMrZQECypxCzVpfLDxXSFgRIH5d6DUnW5Jk9trZTKSEgaD/w5bEeorap6HTX1K3v
         AL09dmfyCj4hLVd/7Su+LVZa+/TlEz0m0POr/lVTLlaLnyAby9mSO3gANzADUPWnR22L
         E3a4iJHxBwbUxjEtJ5MT8VoXvm//GqtfjnRd0QwndBRRV4fLqf1MRn7LwZiAQyK3fnH0
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738513779; x=1739118579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9UQSQGwwSc3ZkbYQaSP3JwemKDJqC1iBrUfH4aLmwQ=;
        b=I0SYREv4qZg0PK5wXFKFlwcYF1mIdQc1+PTdWB2xpniH7XPiscJ7hT9Vivqp3BRxAE
         GdTXydmCyK6Fpx3ZoJK9GaZFC7cuf9vFVsL5tRaSJxO7pisi2aeb/ldVsAa+q51jMjXh
         0UVcdbBLtSbSxGBlmrGa439MoWpY5EJ3W0Q9JLPi2tk6bCRb2MhwoO0QV4oJTwTEoRQK
         uPJbbdUGr/2Z2X3djYA7Q6pGDALIBY8lifWtu8XG7twHtHJ5sumX/sS294qYTDiR7e3T
         I4c3UUClgNDcFkSlAJBFWgJH0glqmML6Qd3TTGIGe8aM+/Zc3Hm4z1aX+eBdhXbZj99f
         lPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcR9co6V4a7zHqAnBdHAlnJ+KRORnQd2I29WWJkuup/uyoVfVBXUY8v4IeNWY8k+4vHYg=@vger.kernel.org, AJvYcCUnk5+dt140KU4BNIPfDHX5qo/704UwpjHW+hoxthbHy/jf08fsGorzpCtUelrmAH3oIHk4aZJ88JxffcTI@vger.kernel.org, AJvYcCXCeCsqMN+DRILQbgCTuVCMX9GN6NyZRK9mevD+Tu82uLEP89oOf3dVPjdt8nDOirQvgShh4Fr8yJpd@vger.kernel.org, AJvYcCXv0UAhImRfqvxBmTsDhhv1ba0QQUQrSGng3RUHtOq2T3KnXcSHDeAUQGxOSSFSxX597+KqvdjvmNbeGm/+NOCDBDLY@vger.kernel.org
X-Gm-Message-State: AOJu0YxxVP2T6juFUWXEgXwCxBKrs+9RttpI5hK3z3YeGhewo6ZhLXj3
	tWK6ZjyfIZqeyNu9xMEsYG0HNuVIMtLUDHJxsWncNjLM14njUkBV
X-Gm-Gg: ASbGncv1+X4e8VadyO7HDNalCgLPtyqk0ISY8WUN2QcuIprNIdpKNjiGzmy2schYaQi
	OgUPCCdU+q8Avgc8v08uiCXX0qMo2AgA5XYSLj2f7wP2j18afIfnO2lUUzufZ6uGpFbKk/8UHCI
	c9ELpd0OARnsSts9TFE954V0jPDnUZS/dvROpsZOlR41mXIcfW3a23cx29j1IXp51zD4JoxGqie
	n5tF71h8AYWEd9MXZJOzrkfd7lduT+4xQuHisBV8146kgvPb0buIqOL+HS6Pj8v6j/jKJLQ+Uac
	cebp9sp7SUcVBJOK2JvGFGHMyz39zPWYNvss4cLslwNIOUOIMRwAvKJFoMOOFjrpz5f0CQ==
X-Google-Smtp-Source: AGHT+IEzVF+l2M5kDXHPy5tgSDcJ/G1cPVMzdD95grM/Ohux436hYja6DKvJK0CjWrvv6GxnbkC0NQ==
X-Received: by 2002:a05:6a20:2583:b0:1e0:c6c0:1e1f with SMTP id adf61e73a8af0-1ed7a6e0b38mr36837848637.36.1738513778646;
        Sun, 02 Feb 2025 08:29:38 -0800 (PST)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1ccd0sm6834671b3a.178.2025.02.02.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 08:29:38 -0800 (PST)
From: Eyal Birger <eyal.birger@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org
Cc: alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	cyphar@cyphar.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii.nakryiko@gmail.com,
	rostedt@goodmis.org,
	rafi@rbk.io,
	shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
Date: Sun,  2 Feb 2025 08:29:19 -0800
Message-ID: <20250202162921.335813-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uretprobe(2) is an performance enhancement system call added to improve
uretprobes on x86_64.

Confinement environments such as Docker are not aware of this new system
call and kill confined processes when uretprobes are attached to them.

Since uretprobe is a "kernel implementation detail" system call which is
not used by userspace application code directly, pass this system call
through seccomp without forcing existing userspace confinement environments
to be changed.

To: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
To: Will Drewry <wad@chromium.org>
To: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Eyal Birger (2):
  seccomp: passthrough uretprobe systemcall without filtering
  selftests/seccomp: validate uretprobe syscall passes through seccomp

 kernel/seccomp.c                              |  24 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 195 ++++++++++++++++++
 2 files changed, 216 insertions(+), 3 deletions(-)

-- 
2.43.0


