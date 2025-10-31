Return-Path: <bpf+bounces-73205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEBC2717A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF703B22BE
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F532AAA9;
	Fri, 31 Oct 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPACvDdA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26532329E46
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947940; cv=none; b=lPFORZbsL1QGU+pWQewkntM2YU9R/iRit6yFmSMxxFuY2sgyh8EMdu8xndAkl48HryZhw7esx5jXGBAfW082yZU1bMRw3swJAQ87tOdIuAC9NsCYyHWdNrq4BUliH5KZwrLVdVZ3gnAShjyfTD6bbk8z44qf45Rq8eKH0YNMlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947940; c=relaxed/simple;
	bh=mtNIPduX7GrYGJBCiqw5SgvNfC9+oNlk71KKt5+QzJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZVznqz/gCUVttrObCPNWKv/JKTIlqUe49pxAVLCvmlBfAaEY+GO/VcF+0Fp4dSw26yyTGSAKTaouRyeFRxjNuac59elT59hc5Rm4IHOQhb7GoDTxtniqUx03tlMX5oxsT/+MyZ9e8UuoUBBQGnJ3k9ymXERN8R7qqzsjunHH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPACvDdA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so21946245e9.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947937; x=1762552737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsfKN/oyy4LpZxJAQ03AiM0cMDbDS9vgY6h8jFtH1kM=;
        b=QPACvDdAkxoNjPDdpb/nTFuiVxltS6IYYJtEWqbyOEekxMSKU7Vm3lkMlMx1Rq+XdC
         kqHxl8FwXgN8Olr6DtHFn7Zq05kvjP7IDXnPGCmRKmxFt/VXDvKw+p8xQnR5xp1yFGFQ
         6+30nXqf39P5med2kv6ikYgxjROv12NsKLXZZrGRgtuZepUoXcRhUUMdJRhJDSuyGDbi
         OqZ1HfJY1gi7BivHXPmykbDyV2Mh2t2aaXJKgLx8MsFiANBnGsYPGnmKUtlbo53CeNW0
         VXtanOtVGBf2Sy1omba6S8K0pYZrUX0vtQumMd1OIIwHVT4adVTHEK4W2/hMS1VO/Qgt
         ubbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947937; x=1762552737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsfKN/oyy4LpZxJAQ03AiM0cMDbDS9vgY6h8jFtH1kM=;
        b=ks63kM3Qc+DXVAQ5SFh5ASToXME/PVjETNrT/pHwQ5CGxBM5m8V0qG6474ngz4wEVc
         wYqKJiFZ3Q/psNit3ceTYZBMCHQ0aFXooXYFSFmu/hrJ1oOYPv1172VJceZiFxvnn2zI
         NVnpDjnybCuawYRdvSeSWphmzOB9vB033bDGicJH03QJWafB92ORznsQmpTp9ygnoidV
         A6t9k6mtB3GCds7LG22myuTxKoRj3+hd4WGknrXtwiZSG2eVCIOQB/dc5C9EK65GHhCd
         /aHxOjrtBjrQjsMbjVt57s96t/Yhdb4Nk8dCbFpy0WMHCaQsbeYMSd3lSi+vudBQyNs1
         +wWg==
X-Gm-Message-State: AOJu0YyGyL3rjoTZI+Svrj414IELdlc50I6Xf4KoPGiJESt8CxZfJ1e2
	thCkMTfPUvsXG2TnZTC4QvaSPW+Tu5W7obhML8NR6AOBw6eMHCp4YJ3YaPCL7A==
X-Gm-Gg: ASbGncspL6nxlkOOApkma8qjZ2WLXPxfcYBunkkBjTxr6rhuPopFm9mPk8wEqGIm1LP
	SPTX85btF0Fg8rNEgy8EXFC6NBxROC2ENweBUzX0hXHNqckwb32X+AY3U3EoZZaMl7SGhtEmq4x
	omnBFRCOl6pwD/kBosbEqNOyHrEWdnMC0vccEY2r/i7eJeKc0qHWIn7hVWkvF41RwhyYUz4Gls2
	ZYcC5JVjzKptzK0Hn+IR6aVQl2Nc2U1J9V5VtEvXElnsirKeZjA8MxlvJWKp15zajmueuNyqTPh
	NIu6U55QTwi1c10T18iecnyzcp4pVuYPGSIcV/n4O+gUVQM3q8/zvEs8MrmU3NlnKUy3v3pjW0e
	5p7eN65HdMbxpfIXXMGFXb6fszXqudIuqPzmrTc3E5NCDiTQvhzd22sEvoM3H76lPkDnWa98Go9
	EATws=
X-Google-Smtp-Source: AGHT+IHBYX5lDVqYUBW6rRRHZ+WNQb69aWVQucD0wFe1a4LYJdLqdbuoVqv7PEBFO6opwrcmlE7v7g==
X-Received: by 2002:a05:6000:2084:b0:427:5ae:eb89 with SMTP id ffacd0b85a97d-429bd69905emr4346213f8f.34.1761947937130;
        Fri, 31 Oct 2025 14:58:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm5628033f8f.0.2025.10.31.14.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:58:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH RFC 0/5] bpf: avoid locks in bpf_timer and bpf_wq
Date: Fri, 31 Oct 2025 21:58:30 +0000
Message-ID: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251028-timer_nolock-457f5b9daace
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This series reworks implementation of BPF timer and workqueue APIs.
The goal is to make both timers and wq non-blocking, enabling their use
in NMI context.
Today this code relies on a bpf_spin_lock embedded in the map element to
serialize:
 * init of the async object,
 * setting/changing the callback and bpf_prog
 * starting/cancelling the timer/work
 * tearing down when the map element is deleted or the map’s user ref is
 dropped

The series apply design similar to existing bpf_task_work
approach [1]: RCU and refcount to maintain lifetime guarantees and state
machine to handle data races.

This RFC doesn’t yet fully add NMI support for timers
and workqueue helpers and kfuncs, but it takes the first step by
removing the spinlock from bpf_async_cb struct.

---
1: https://lore.kernel.org/bpf/175864081800.1466288.3242104888617580131.git-patchwork-notify@kernel.org/

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

---
Mykyta Yatsenko (5):
      bpf: refactor bpf_async_cb callback update
      bpf: refactor bpf_async_cb prog swap
      bpf: factor out timer deletion helper
      bpf: add refcnt into struct bpf_async_cb
      bpf: remove lock from bpf_async_cb

 kernel/bpf/helpers.c | 309 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 189 insertions(+), 120 deletions(-)
---
base-commit: 23f852daa4bab4d579110e034e4d513f7d490846
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

