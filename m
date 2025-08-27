Return-Path: <bpf+bounces-66657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A7B3828B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 14:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA407A4B2A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C430DECF;
	Wed, 27 Aug 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLDPwZjZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AB3176E5;
	Wed, 27 Aug 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298306; cv=none; b=SfwI8xDBqY7t48Y6uBjMVdXYqrO59aZi2SL4HXhFBEKimbZVouUoNleTslAZCYo/ggO5HVM1WvR8bAaXmzehsiAAo4jlI0u+b0ZRQSPFmfamsiz9uFTScualvF11ZVF8BQV888mApkaFCaeyaWUBeSGqNkFf+hENLkGdFKbmuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298306; c=relaxed/simple;
	bh=KQEDyTE/eVCguE5D4TSpj8PriccLA6c7ixtkLAXfL0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjqSJDM303pPKQtmGf+SALv8/awpRaRynXVlaiY1Uooss89vg1/XAdN9m2mg8DNH/47At/zrUy8HoKT7HOPYNBH4V1xsmd8a77m/VAfvFY0tZMZSPHp4L5v6kzXVwozLiJzokx6ZTR2oLyMi2KFkj/SE3ycaQhZPE8uX45jjDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLDPwZjZ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24884d9e54bso12520435ad.0;
        Wed, 27 Aug 2025 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756298304; x=1756903104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkFeisdWuGtSooZ8J6GBTEPJpNnJZe4lobJCWe4FUO4=;
        b=GLDPwZjZM5PnNwQO8+a1DUNf+ZEnQ5fAc9CNxAFvcTDIfkUD4Gt2OP26jcoRheAy3r
         f/u4RBzxxqZBGT9Bgi8b6bithuQTquQIjXh6ttRXOjzVYksquq+slyx9WM9xruswazKz
         AjhN4AknstUHkFLZChqzJGLfiCmbgYJNCQFT2ZKiQs2Cq5HSSMkMpPrielnlxU6pHuAo
         +OKcZsk4qMuz9mkHIUX5U7RV+4gRrtCgVNDV2Wqhv+TszPhPepVPyTqUoofJlBldMhmv
         Uz04k6zwe1z14+jpMfQieC4UooPLKNk0dvutGARTBFPYka9/MjI4mqnfM5mHL91f6cCb
         4zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298304; x=1756903104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkFeisdWuGtSooZ8J6GBTEPJpNnJZe4lobJCWe4FUO4=;
        b=RwmUZO0zkB90i5pv6AnVJi0XQZDLpzEFx0lo9+uUPvvoeQgtQyo99grJPAO4d+mMuc
         tKCFnWa0+1BvPgG3YO+jAAcMeLNyB2mfxTqat8Q6aFXyCVPg9IZNRgPfoux5l5Xq03PY
         kCNyMUaZiCVUqrCHejmI37+Ue00em/gfe8szD7L4pM/549TM+Av/pXsbMjmdCn7ue+nO
         o1MSp9tv7I0bu9qEmzg+tCHyRu4Nrhvz870QKcPW4Ve4ZMyjao4KNwS/eal9efVJXEm0
         IYV832wjn2WfoRGwvKp4u4lDLki+Qqm3jij+7v9FW/1mUraNwKUKpJ8I6D3a0e5Ezmxw
         nSKg==
X-Forwarded-Encrypted: i=1; AJvYcCUttSqJQqcykSUkT2+HM0liDwFWvUI5RlAQJbkG3rxj0FNSvxlAEuukUhP/FteFxVzDnMvaAon9WvMKaZbTdE4DBVTR@vger.kernel.org, AJvYcCVfNclQWgpZ+h+241X3hfpk2o5u66oWzZt4g/VSroQMoejvVWKP9xtFu3ZRSoRKIO5lJ+8sgAcpDBGyoaYE@vger.kernel.org, AJvYcCXQuN7pdz17++Og7EIA8UN7bEYdky8CrRJfeDug2xLqRAvNDK2T0JJOB6e0FcGONxeCMY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZjl8UMIDxWxi8qWIdjAXdEr/bUTU+ftsxgMEWFTSeLtwQQws
	Yvt7CsaQBMXWmccuBUd3wK49zJUTNhym7MUPQE+4Ryl35lRfbP0bcRUr
X-Gm-Gg: ASbGncv2NIMkqSNv9gZButlg8gVWU0dRx1MwhfwI4Et3DxWJtbZ2yQl4uLlVDBnzP9x
	4h3GmwT5c4+sYvbzZCSsczut3rI2yYK77CpQMw+VGyij7lt5q5mz0mEe6eTb/03bC8bIsdBg5I7
	gC6UpDqVzypNJBp67FPu0NztPo/GOnFSTAyWfrt2iwZtGc4RGcqCldkkjBmAE9ssGcm/hpWHqVd
	FwG3MBiGScdSjkugRbz3y6ER6IGm30Bgeo+jkc6tDZsJDP5++72c0hkEFXemXWdUSjYGpxmkGtb
	f2xQF4nGqnG/SJuexeJ76zl3dM1s19FW4j9A5uF9ALVwJlyudybBg3paZuHQ3+Zv9Eu2XS0u8kL
	oALt6jFfy0aDDyYZ7nSFdwrXJGHA6TXuOG6piodvk1UHI
X-Google-Smtp-Source: AGHT+IEdc9MmrIVJnoVnP4AscfcDDZc1U92y5mv283W/cqy/SGk4bcEzXHjsoMbiPH2y2wB+vHiaEg==
X-Received: by 2002:a17:902:ec89:b0:245:fa00:6e25 with SMTP id d9443c01a7336-2462ef1ea0bmr269029765ad.28.1756298304078;
        Wed, 27 Aug 2025 05:38:24 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24692f981c9sm104588115ad.116.2025.08.27.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:38:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: jolsa@kernel.org
Cc: ast@kernel.org,
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: remove unnecessary rcu_read_lock in kprobe_multi_link_prog_run
Date: Wed, 27 Aug 2025 20:38:14 +0800
Message-ID: <20250827123814.60217-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preemption is disabled in ftrace graph, which indicate rcu_read_lock. So
the rcu_read_lock is not needed in fprobe_entry(), and it is not needed
in kprobe_multi_link_prog_run() neither.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 606007c387c5..0e79fa84a634 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2741,12 +2741,10 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		goto out;
 	}
 
-	rcu_read_lock();
 	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
-	rcu_read_unlock();
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-- 
2.51.0


