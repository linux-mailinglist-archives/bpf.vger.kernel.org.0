Return-Path: <bpf+bounces-35320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D99397E5
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5BE282C82
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AC134407;
	Tue, 23 Jul 2024 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB5lOOtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82B433A0;
	Tue, 23 Jul 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698114; cv=none; b=uvM8KZO9MwbfC+cNooQabkE/dfhgzL+6GX4XgrMn/Wzq1WOJqeNvA/GtSFIRv4JK0mKEcI4/+A8e28UZfz8JZtM9I+KdLGzBprrYJ51kwuBY0lPnFTGVOkE9d9dblhj7m/yh7+GvD97+bE2xVR6yHgHVRknPd9hBU0D3GSxFzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698114; c=relaxed/simple;
	bh=yjGH39SPD58tKkkaS9g1OTDSm4BKOetID5oYRjpbCpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRsU721TbuqbQU59fqIExnJJRJTdA/VONUhIeBzXZhfO7/sYacHtRZ35GhTKeAIMG7cGqbzo4AW46qKOMQJDH57SCzP/vJdFeqFT7SwNQjD0WULjsyLdIHfJPvX7dtWek+BU0wX36ZFmilfbLuIYilKsTUFidIOShlmjE/ycXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB5lOOtm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a843bef98so12645366b.2;
        Mon, 22 Jul 2024 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721698111; x=1722302911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sUCnc1nw0XSqrVsGJcDbaBalVpm03eTGsBAvPbAzRY=;
        b=gB5lOOtmHO+aDKOJtYzVqP8iZb4u2ORsOA49mtwSpoN/wif00Wf4nLa6rJROsECEUY
         PfO5qUl1WOvAIPPL3Oa+pjjsZztdCDVaeWhgYn2CwLm6B4+sjzK4UvYJGh6IxKRSfDVU
         02487eB8+lx3RGFBT6ECO5uv/VM4Ycq7l1QUbNUrznWdu+p8UEnMYRk9OTQ3FMJ/fcVq
         rgQm9wrpZ0DpJK0lOAfdvCycORZQcSGK+DB/bEAndtbqh1a+sQTf4WjLIHYDDbQyKv68
         k54mn2zgQYY/il0/qTdnmgSe11AiyBbi2bV8VsWoWvGuhzOLT5XXYNn48BzOHtyXn89C
         ZQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698111; x=1722302911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sUCnc1nw0XSqrVsGJcDbaBalVpm03eTGsBAvPbAzRY=;
        b=jxo6npMkaJLUkZHhKTAp0Xxr6vWOnqzxtKjmonZhuVh0PLcqICqsdIdahsVys0tIU9
         JvS3s/Ewnoijsskpzg7vVGL2zPsYW5ECPmbXgNCxIgn3GyR6F6/EehqJk03wvONA8T5T
         wL2AJe+tAenh3C53ij5g0tdIS02M/VPqrt8jvd7+acTS4nilBX1xcKSRSz0Yxkftqc0G
         xdzU/V97zSntZCN3hBCSi98NlFlIv75o+2Yldhhf5kUDNz/cikaHJqkVJdWPr5kTxxup
         NW1epkEr1KaiO2mrE4+4uMmIBZ3XvEZMhbgas3OLXcdpOCBXB2D8FroAuHT3ILKPD6C0
         gJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCV3RlRIvrDIFpzgyeTCpiwZwzoM85hhFYltf+EQPuTxQHPtapBt7Sp9/bcpnvTxUXzjbOJqFPYZRdS9RUo5wSF3aWc0x3+e3uHM0AL4BVSnl+HpZ99rY4jGnx/NfL9PVsqAjAq3GTki
X-Gm-Message-State: AOJu0YxHu4TPwidENKbq4wtfmrYHOZjIglJ1k37p1+FK30dAZ0tXdJe7
	JJ4O9hNNw1dvXskGjnNox9E4j9oICbUjH1M3fQkaUvt5ru49jsxE
X-Google-Smtp-Source: AGHT+IHr0fqGmoAQCN3JwcmLjpz+NgdPLLhpndRfXKKj9LEmlUAUgsMjZpvMMnCLXnvv8ztKENEJHw==
X-Received: by 2002:a17:907:96a8:b0:a72:6055:788d with SMTP id a640c23a62f3a-a7a4c12338bmr648515966b.42.1721698110949;
        Mon, 22 Jul 2024 18:28:30 -0700 (PDT)
Received: from lenovo.teknoraver.net (net-93-66-31-10.cust.vodafonedsl.it. [93.66.31.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8f3a47d2sm31435366b.81.2024.07.22.18.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:28:30 -0700 (PDT)
From: technoboy85@gmail.com
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v2 0/2] bpf: enable some functions in cgroup programs
Date: Tue, 23 Jul 2024 03:28:25 +0200
Message-ID: <20240723012827.13280-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Enable some BPF kfuncs and the helper bpf_current_task_under_cgroup()
for program types BPF_CGROUP_*.
These will be used by systemd-networkd:
https://github.com/systemd/systemd/pull/32212

Matteo Croce (2):
  bpf: enable generic kfuncs for BPF_CGROUP_* programs
  bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*

 include/linux/bpf.h      |  1 +
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 29 +++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 27 ++-------------------------
 4 files changed, 34 insertions(+), 25 deletions(-)

-- 
2.45.2


