Return-Path: <bpf+bounces-42674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6A9A90AF
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CCD2813B5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0981F4715;
	Mon, 21 Oct 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk4CB540"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0271E5705;
	Mon, 21 Oct 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541511; cv=none; b=nBlS6VdAdeivr9THbGJxrUWCEe35ZXyxUZvZnErcERjtUQQ3R9pB0IveAn3YBl50FtsnXQkiTUDX/BMwsem6uT5jY8q4t2Lhy0UWxJeh13Yi8nY527a7e09m7gcvBuNvE5DG5ZfyDUVAMvdwwlnKA4gPTeOPT83ROZGnE04qC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541511; c=relaxed/simple;
	bh=L+bPveamp5Up8QfmRalReBC7vZcwf4CN636xp08tdBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kg6bWBeTKzL2UOH9gGJyiigz5ab+5HFFInMbAqNaluv41gJhivcw1S83+jyd9sWjt9Ax7Q+vTPUKo/ujjQxzUXXGCa15ZNey6FMsBw9+r/yvKu4BLvu3+ub+gpBlVPNsMBLI9EwyLBbFRI/5poJJ9tAvMZK0/YiAqI6hs9aObY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk4CB540; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so28082995e9.3;
        Mon, 21 Oct 2024 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729541508; x=1730146308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXIkEwDxzRZY1Rvj6v9iJoRMe3jxeSDgW0jycdPfu9w=;
        b=Mk4CB5400m3lk8nOm9o70V2vivv1UWuRqIfY8ry0HXEf9C0gQp+Zc50/xUqjirX3lC
         hDcYrySte6twtAno9rlPbwYsr6MQrkJiU9QaUbDI6QlaKRGNNfc5AleCvz9RTmWW/tJ0
         eCOkLCa/ScYSGNqC0sYxrLkCA17Z1lHKaaw+bep4vvmbKwCq+pXad96kPngrlqrmBs1O
         XX2DICy4xzpRJBduWs9mQjpgZe9zrJQojJxiuH0III18wn7VZ4xP3IS8OPfIHL9AVlfW
         18jXIu1xY1AL7wk9r2TXiQobuGIuw/eDu/Ln14BavfXAvRua/iLP8NlIjzu/oeif2Aml
         fK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541508; x=1730146308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXIkEwDxzRZY1Rvj6v9iJoRMe3jxeSDgW0jycdPfu9w=;
        b=hxxaTs5hDCIxH38IszwKtA6aauCueffSJJzhJ1AYjEzU+/MMJg18pbJlR43OgcNGXe
         YWjTftDfAPmismYmvv1HlE+T+F/A6uMpE6hKp9PNpACZa8l5LHhJCfzZDbaTPfWo35CS
         egqhBVQprxtd7fRukxhbjGO9KGlJ/TjiRCuM5LPYv422yCM85QdjaetT4mhBxzPigiw0
         ltS384eAfELScGuGJL9tBgMNtGaEjowqqaGYzCaXWS929Inb8SIOizbbXcFeu9iDmoFs
         jV88/szhrnDV1nIHZlu2eM6qrMScedwj85moiTT4q174tY2Bckab2KjcgofDVyie6bAe
         SOXA==
X-Forwarded-Encrypted: i=1; AJvYcCW/5rtd3OmGJ1KWcV8C8luvUs0cOiyPC43oiYfUqj0gkoBP/IhJHsJ/cxN9SKFzIMbccI/Cmdk1lYAcYWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1B1jYVIpiWICklRLXWecS6ofpeP440eK4ymbdDI0WYLlGj3UB
	7Tc3ZT7TFG+/vrhxzWZ6HL2WgXtExzt9sF0oYbiIzaIUic9wSKfnoJOK4JbasZY=
X-Google-Smtp-Source: AGHT+IFwJZ5rk9dFFB9Xf7mJqH2Mq4VOAF3zzVVMBMhnDpuKWZvhyfgxly9Qtoq9OP467huXQDDtsQ==
X-Received: by 2002:a05:600c:3b08:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-43161687de8mr102655375e9.23.1729541507851;
        Mon, 21 Oct 2024 13:11:47 -0700 (PDT)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm66978965e9.22.2024.10.21.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:11:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched-ext: Use correct annotation for strings in kfuncs
Date: Mon, 21 Oct 2024 13:11:43 -0700
Message-ID: <20241021201143.2010388-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; h=from:subject; bh=vjfYZLqQSH7h/t029Mgp/CGO5FDKATlcePto/Di95JQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnFHyac2Ch4lEZWgky8K+mc4NPCx1FIX0qw256I+VN mZodhQWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZxR8mgAKCRBM4MiGSL8Ryli5EA C2Di+Dv+vv4eFZM3w+hNSZyWPd9bRv/wOcrLz1A2vh3KO5YOELnQLRQRwFXC1T8mM7H1jkTIRJbwVP 0yaowoQIevrpRUX5EeioViYwPzGzehxaCUp0tjMZ8MIPj7meSzhcJXq+xZRuO87yuVXGcxLmjQPnXs O56aP5cg6iXrl196HqIoQGU384z5ediUzcb/lNdxp+pTVSoXUcIkyR1OcuktHTwX0XFTRgUPVoqfX/ OX59Z5j20VaRLn5eDK6pc+ey13Sv93RIhdD/yofajHLy3XMWRwU1npy/PKmsVSBeUvxIUz72g1sJZv 6LQFeQtn7j3v7oZR+YK2LFw2mgDAf7SXMgrXkNO2b+HSiqprqT/zw9rfGqUALqHAo1WyPjc62/UJyu AYrnoTxwtIzqUjj0T04KRAKzWrzLUv8H1vHFFjTpKdd6G5WC5BnczqALvqZVbpQ29TVtJXLOD3XAgx 4aCMVz4U86QClK6hk1KWj8bXv/abxwrAo9yBBBwpDdgFnteAa8CEGb4+3f2FsOQqcWJxAJ+g0erjoh fneciFwdZkvifTftn9G+1NlcchMhM4g8YqywbTPqz3pYhFTZWi3DIFxE0b5FOxi74Kl+zJFDPhzR5H /h82YvhZF78WSpTWRq3q5cbHO/evjNMdUhbS+IvVdTw5rA8Oxk6RKiN+Lo4Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The sched-ext kfuncs with bstr suffix need to take a string, but that
requires annotating the parameters with __str suffix, as right now the
verifier will treat this parameter as a one-byte memory region.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3cd7c50a51c5..8b8e3c907340 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6708,7 +6708,7 @@ __bpf_kfunc_start_defs();
  * Indicate that the BPF scheduler wants to exit gracefully, and initiate ops
  * disabling.
  */
-__bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
+__bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt__str,
 				   unsigned long long *data, u32 data__sz)
 {
 	unsigned long flags;
@@ -6729,7 +6729,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
  * Indicate that the BPF scheduler encountered a fatal error and initiate ops
  * disabling.
  */
-__bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
+__bpf_kfunc void scx_bpf_error_bstr(char *fmt__str, unsigned long long *data,
 				    u32 data__sz)
 {
 	unsigned long flags;
@@ -6753,7 +6753,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
  * The extra dump may be multiple lines. A single line may be split over
  * multiple calls. The last line is automatically terminated.
  */
-__bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
+__bpf_kfunc void scx_bpf_dump_bstr(char *fmt__str, unsigned long long *data,
 				   u32 data__sz)
 {
 	struct scx_dump_data *dd = &scx_dump_data;
--
2.43.5


