Return-Path: <bpf+bounces-77929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D2CF6D9C
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A0430351CA
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625033019B2;
	Tue,  6 Jan 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="JIC/aonL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5552FD1B6
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679827; cv=none; b=jl0X9i6xloRVIehV9xHeE/bKOtHlFT4s7mbgQEwI9lSpKSSUVlEPGXqmIT5yZFclzMtmviYZwTx9u+reOHMCB4CqrdrtzqUdoWwx6c0EvKFNV3OOe218MZ70kX8WdWuDBCriQ3WnX8vvfIJYvul4crEZKl06IJdY4xmZUbn3cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679827; c=relaxed/simple;
	bh=dxGjWZX31TCuBKpYeKDhNPW9XyNz2uK9NMjn9mEzZwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV2WCPd3lC3yyOArn1w98g6+RIMnHYrQvWsAJj93A40i79ZH9L3Nc58NwjwO2FSTC0QCcpDJzIWdfuWrk/F0609jzk8BOeWAjMj9kaTszSp7jZkF6os7i8TrIpKWdRLM405WHpcTSF2ir57QmCVA+r2GFz9Z93poVHLtbIjVtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=JIC/aonL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f4a88e75a5so5778001cf.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 22:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767679825; x=1768284625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfWpd+nhodLWMufnagUhjHyt1vBOGHHcfb3PN8OsP7o=;
        b=JIC/aonLxtZP0vz4lo73dBVnRhxl6iZ3lOTLgMWV/ZkXgZsRDpTV+cG24IobVyP30I
         6M/QATD5qmmo393GDSPvHGmMg//13GoDw4xPSnyESwm5Ya3aLHNKxmBUFF9gcS/aZX1y
         6QxRvXdcRczAJJ8i0JeeD0GxmSEVckw1pCj0p6ml7uyTHW3olHhM3gacrzeP5xay+Xcb
         4ePO4yXdmUUHXUM64bohK9m84aD4ljXGrRDDhwAQRcV63col/6Ns0hvC3hy7ab5o61Jj
         MhLYO/B3lF+42zR1WZgRoB/u9+0S4lvj/B1VLx5oz1YLB5o5NJ9MIidIf06EyYRCICQp
         SlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767679825; x=1768284625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfWpd+nhodLWMufnagUhjHyt1vBOGHHcfb3PN8OsP7o=;
        b=fKD8FCzYdzD4GkU3QIGmiY8Wc/PBQeLgrhHipWVCF1MEieh5Jh5qKUDuAyecl7pC3X
         OrDivIoLhOh3cQh6rKwwBc/iDUA1Yst2QGln/VqvcUQFa9x18E82PYoDS0eWwToMUXk/
         UpwynZipgRoJddU1Jq0pRIRlRrGuzAKc15EwTGk82x6BrLeLLgclJjtn9/TdIvRqFWB8
         1wAfje/eMxM4OPMQIhQDF8C2L7wIbE0cLwUaI1Mpr6KGu9ylGEZGZQSmMQQvbmOcAiky
         QGP3paqp5a8XfzfEnsECZqI8mzHtq41iqEu8sN1/hFnqeQ/6JxfOXI0Bz63rl/wh8hkU
         he5g==
X-Gm-Message-State: AOJu0YxIfnAjEdO/+X9Hldx3gLWs8peWGYMWueIn3xOd6r80wdSGitSu
	ZgVv2rD/VIp5xtrNGXzlgNETW+GGz0ghTIVAmMeAxBSJHbdybe14rtoKhXOVphRqqSy5z0IqV+F
	dMRku85c=
X-Gm-Gg: AY/fxX5diZwsHs5TzeFQ5euV87CZ98tq3Y2J1qw7/9KAYZBzBSwYKqyA0VgPp3JBzxE
	h46i2jM2mq5M5smte6VhEQAVPv3zhqEXPFT6nzr9b/2z9KZbg8frTjpi855kjXrcFyvhWGrD2qB
	n4BBlS9+Yw3yQkFuZlUJQ5681Go5JZ4tFBsvPtlyWpPBFYSmVwyaKioUJZyUxqVr/FemK9AV8ry
	Hm43vfNt/UGMFulRib4owMZL3xugVH9VbBHOVtRiw5Xc7prnRi8aCc0plscJFswcLMp6zDeUllC
	vauFZKCUBOLOkRNy0ln1i2bWLdwroEOrPv13RVnnmuNWjo+oR/Qpx6E3t3W4h6pWv8pJAXjYZtz
	vkiQxwYVgw3Jg/F5wX5oAf6Cnv67yX9Z/BvaK58XyPbl85bnaLZjKQWdHrC+7OzHTnzJ8pAdnPh
	xqd+G5RSSLPQ==
X-Google-Smtp-Source: AGHT+IHVGj1uSu7WqqMhb2nitEHDdNYdV3AjFQ3lUb/bKMqArwMoQMuyDE+zl7plK9SZPrF/G+DHKg==
X-Received: by 2002:a05:622a:4d47:b0:4ee:1ff0:3799 with SMTP id d75a77b69052e-4ffa77a86aamr24168781cf.44.1767679825046;
        Mon, 05 Jan 2026 22:10:25 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e363b7sm6845511cf.20.2026.01.05.22.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 22:10:24 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 1/2] bpf/verifier: allow calls to arena functions while holding spinlocks
Date: Tue,  6 Jan 2026 01:09:52 -0500
Message-ID: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com>
References: <20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The bpf_arena_*_pages() kfuncs can be called from sleepable contexts,
but the verifier still prevents BPF programs from calling them while
holding a spinlock. Amend the verifier to allow for BPF programs
calling arena page management functions while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0085690b0a0052f82cd48d8722e89..9b3067b16507146d7348111ed55ee361a6d9db45 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12372,6 +12372,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume_impl,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_arena_reserve_pages,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12448,6 +12449,7 @@ BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_arena_reserve_pages)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
 }
 
+static bool is_bpf_arena_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_arena_alloc_pages] ||
+	       btf_id == special_kfunc_list[KF_bpf_arena_free_pages] ||
+	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
+}
+
 static bool kfunc_spin_allowed(u32 btf_id)
 {
 	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id);
+	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id);
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)

-- 
2.49.0

