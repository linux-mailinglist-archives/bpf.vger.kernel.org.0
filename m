Return-Path: <bpf+bounces-77617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA70CEC65E
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF0330133A0
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB922BE7A1;
	Wed, 31 Dec 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P2mJbFiI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58F299923
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202646; cv=none; b=SsCZQyc2ostyTGlpuuQutka0qe7uHRb6n7fw4oq/nNL7LEn6daSu7BWV+pOHaCQNl7r0FyIPRCZZMG2fyGykqNCHaL/2UBQC72UdE9k2ajyslPryKRlhn4f2K7WhKCF6XJn6Wrv3fhEeyYAG1U9dmIFrVK82MT1bS/LQB6Nr43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202646; c=relaxed/simple;
	bh=7sztx2cWvWIz9TKeoZ7WJJeq8MyUlFzC//jJbHulVpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/k0z2ZnzULVCav8PpJswrWzqU+HAt6VEeiiu5WHdOi961YMrl4XecBeN81LU9DZLDxWYetaiJr1sznWu4VtyA7MLq6Ok7+VRrkpzjac7d91N+Aw+TreHOI2imM2eFloT/IZjVvBLm+/U75VHx/NJxa4uezFlzDZnavmA/vxZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P2mJbFiI; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88b08fd376aso3535156d6.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/dTXIrnjBfrtWAAe53M4yTIg6PHJwwBbAiaJAY560g=;
        b=P2mJbFiIjxyvdqq/JX2llGW/WJojGB4kayCihusbAmL/yNlDIjsOKRLWjRyPWI3DLQ
         2CtA7ap8gGYXNq84Y6oj9Mu6UZcTaq+e5TMThl8Xb14mvo+olG8oZ516c19DahmPmXd2
         HdRU/B3SF2w8HaiHu8sFSN4Emg8DGyxDx28yRrZY6tRBPMshz+mgTha/6tpLs/DGoFD4
         8/kh/QbLbSbe0bKmG2pkNdWssaIwZ8MMMM/OQDrVjy0sw/eSHReM/UvSf/POjb18OOnG
         xdGuC9qHSgN+Y/8no06Ff/Q17rMSad4HBKIVUdAralaCrnDcWBheu4icsbsd4lR2Oxc5
         C0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/dTXIrnjBfrtWAAe53M4yTIg6PHJwwBbAiaJAY560g=;
        b=hHyC78GjX2GJ4TeM1eVd4PT1kiP/k9nW+bv1wPUmF8oGqYRlQIQGzuxi3U2Rs9FotM
         lhL+64Aq6PpHw2ESQ8xQn/KqnojmYJEek4xAt9KDBQ/nQLby0rUJhuYohTd3+7TsT6jo
         iU0I1DqyeDQZ/WxI5WBGo6yva7IwXCwtgdfLmMfvLAZTzqwYA2m4o3M42eEg+mo93HgX
         5oGZmD1ZNMJZjiH0cOvGWL0dk76W+2ftKTROOTV45Rd+Un9eMS3BKG8/WzN/7FlvMAGh
         zqu4OjGEAHSYimiwL1oUqVDg/g2dFOptoGkz+axGvOWbOK4E5BLidmWFCPEfiO1ZE70D
         pHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmTk+heK1ER6dDCp/ghFcz0xcnK/fPu4Dcm4NvVImRcnoDGzX+v7mAjGvsLnbUlEVuRWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx7dJox8/a4Kwo/CP9wLv6CeR4HWEoVpIFBkOIKMWnvIb+UJh
	W/YVd7dfObfEmu40nuH1FE1bzvcqFjxeajBiKY41k+gldFjmh6etmL+jkLNX+LKGiskKMOSilt8
	czEehyDOqGAQLT+0eyk9TbW092gL2mkB1l83uZxxkHJvGFIs+3DWcQqqLtr06oPR6/qbDuRRkZT
	mJXxpHLGymGXFyR3JvhuNvPczyOtf7qCiOUbm57ja8a+eF5klcWvexFR8DteP6jVjeRJWETjb5q
	z75XvNzf0cufE3Fwz4DQx1J
X-Gm-Gg: AY/fxX5R4Dw7aIenpCiGHYX1FwUEMU/9wFQwiZDR9XMSI/wpvxJB+n+7m1MdISe0Ul3
	wmXZWreLnG6UJXRj+BGO6W/YBxdfi3ZyJaHf/eppNJOzclBG5mR9C2moPAMpX7zCHSp2GyCpMYw
	d8KsFzGB1rK/LEUWOnV6rPstHihYIXeOKYfhyXUZA3b1zPoCf4esY9QvFRxwHJEd5amo9CM7kJc
	7mDxTa2F9GJIko5LjjSicxDDR/E24q4wjPefrEXs2TxLxo8Uv3KpB6OrEky3j/dJCcRhXbllpbH
	4c33v4rraqIrd1VQ9ja8uV5JHhkr/C4rhyan9Z8/2eqjwCFoQUUh+iHnMI5JaYBOCRMTkBPJFOX
	YBI6ywYWm2aLHvrvIzMGliugesYg=
X-Google-Smtp-Source: AGHT+IEwtYVxzJM5e94yPY3BVIRxsLzn9rKk7vTIuxyQqU0ow24Nub5lypi+z+bUWbmSnwSzc3qVcPo88ZOY
X-Received: by 2002:a05:6214:1c05:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-88d8404da77mr466260576d6.6.1767202642560;
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d97a82a66sm46301936d6.16.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 79CB9340681;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 71A47E4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/5] bpf: use const pointer for struct_ops cfi_stubs
Date: Wed, 31 Dec 2025 10:36:29 -0700
Message-ID: <20251231173633.3981832-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct bpf_struct_ops's cfi_stubs field is used as a readonly pointer
but has type void *. Change its type to void const * to allow it to
point to readonly global memory. Change the void ** casts of cfi_stubs
to void * const * accordingly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/bpf.h         | 2 +-
 kernel/bpf/bpf_struct_ops.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..d74189ea1066 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1977,11 +1977,11 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata, struct bpf_link *link);
 	void (*unreg)(void *kdata, struct bpf_link *link);
 	int (*update)(void *kdata, void *old_kdata, struct bpf_link *link);
 	int (*validate)(void *kdata);
-	void *cfi_stubs;
+	void const *cfi_stubs;
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c43346cb3d76..42cfc3e0bc68 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -321,11 +321,11 @@ static bool is_module_member(const struct btf *btf, u32 id)
 	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
 }
 
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
 {
-	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
+	void *func_ptr = *(void * const *)(st_ops->cfi_stubs + moff);
 
 	return func_ptr ? 0 : -ENOTSUPP;
 }
 
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
@@ -444,11 +444,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 				mname, st_ops->name);
 			err = -EINVAL;
 			goto errout;
 		}
 
-		stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
+		stub_func_addr = *(void * const *)(st_ops->cfi_stubs + moff);
 		err = prepare_arg_info(btf, st_ops->name, mname,
 				       func_proto, stub_func_addr,
 				       arg_info + i);
 		if (err)
 			goto errout;
@@ -833,11 +833,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*pksym++ = ksym;
 
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[i],
-						*(void **)(st_ops->cfi_stubs + moff),
+						*(void * const *)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
 						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
 		if (err)
 			goto reset_unlock;
 
-- 
2.45.2


