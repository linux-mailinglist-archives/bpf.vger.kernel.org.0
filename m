Return-Path: <bpf+bounces-35589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB393B9BD
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B361282A13
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A81E;
	Thu, 25 Jul 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRxnOPtb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124757FF;
	Thu, 25 Jul 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866459; cv=none; b=FJp6Xghm87FxZwBwvMP2UIrO96bcl8MY1XwErs5pxs/0nhsSH3w7OZhE+7/SS/r/SigTnJTvBvaUb2P5ke/CW+x+UrrBgQHdT+59ApPu9m1NvXOWoM9Qg/wTi/K4IYT4cB1OatmJyTBmXg4HvgvoouoSwl6RdUQ4WrFPsQiP8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866459; c=relaxed/simple;
	bh=WZ2yK7PsPxBuvtXXwPdcQBORQgE4LR/AuZXU/o9ke4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ii12gS6F7KzyxvGlFQEpS2PzAp/QHl6alT2d0aKh3XkI7vSLsNwOIt+xFfhTocU6GTrhT73isknsMaAq0HHTJHxf2cEtT9KO35jGvCOWZ8tDN1gqGdJjHfsCgNey7RHXihtqayIw1vj8jYX9ZP5zm59X3LT2u6oYXgwe8mAi+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRxnOPtb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso532343a12.0;
        Wed, 24 Jul 2024 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721866456; x=1722471256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=recxymDG9l+qt/hRQ0OS05/62pT2tezJX9uBFqZF9wE=;
        b=cRxnOPtbAirQK0soTnr01CZtLKRwTXcXVaY2TcDq4CqxYFr9x1Fe8vUVkAcwIxUDYx
         fmengIvOZGlM7oAxXa1ErsYgQI6mPGg/EVEXZIPZYJ0awoPz+JQLyN2oTHEat+L+LZ4A
         pbAIaQzjU7jVDSY2kihsAbLNZicIpQMEdbOsuktsBLlMZwt497PvuLAc3a9KkBFGakDy
         sq3u/uPJSOeZjfIa1PoqqrwAKOWklUpr8yQ7M3nCRW9maKPEL1pqO++IGDh8S/S/Y9ES
         8xez8LrXVNkd9ZmZ0U7LGnb8MKfAUFqFWQ7we5WwlyCLZP2EQkFOE98r+LVtQyF7BIUu
         5XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721866456; x=1722471256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=recxymDG9l+qt/hRQ0OS05/62pT2tezJX9uBFqZF9wE=;
        b=gmA6URDD5CgVFgBtHewfSkiTwd83ISfQaZQHrb4B2pr7fhecfsrCMkfjIFw+X8XhiR
         fHWbgELiHb8lvF+g5OizXOURL2Z6LdyXZsGCopPNEAtD1nRy0P3ZzPalfibBTsYApa+4
         dbCOpre9ChsGbXrSe04a8sNQy1F3RZsT4rncpgmCmg+/17OK1qnWZ9BJTFQevA9z3+YR
         DXyEQNKh1tjUoB6AZb9vx6bNI9/5f6sU++E/y+wDtWAawznrLyjBOpGy8d0Cyo04yQud
         x4fOv6H5ZgMDnd06LtlVvr2SBXh/ISWEdUstyj1oYIFWZ/4RKPrTO9D334OsTBmtBOD5
         MOug==
X-Forwarded-Encrypted: i=1; AJvYcCXj1qegoi39PaUEVeqSPc3kZa5Y5GF1C/hc+l+yPvwhHc1/ivn2PRQzRR2/Xfj602qLF6FUr6YSauLB/vC7FgIWhk16yGOQyssaI/+zlwU5LxT6cOWjAXqAmDjXeWIXYlsOzY54yNGA
X-Gm-Message-State: AOJu0YywlLG/TIaUpnFGsuH5p5qJv1HeBcfVuTWEnfQvh+pn6hEpXjcR
	qvb0hbWUZXmlkaZWDzn4w4JPoaaGb2IPL9KaN4dbCfnOjDMUyuM7
X-Google-Smtp-Source: AGHT+IGw3VOJBAnOP9fux+euVCnewBcIrJ2IVimp0XBSVpGAHTrD81sWuL8Kon3b4beBPxif6JJxQA==
X-Received: by 2002:a50:c05b:0:b0:5aa:32bb:146 with SMTP id 4fb4d7f45d1cf-5ac643161famr187264a12.38.1721866456196;
        Wed, 24 Jul 2024 17:14:16 -0700 (PDT)
Received: from teknoraver-mbp.homenet.telecomitalia.it (host-95-232-233-251.retail.telecomitalia.it. [95.232.233.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3a18sm164988a12.75.2024.07.24.17.14.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jul 2024 17:14:15 -0700 (PDT)
From: technoboy85@gmail.com
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v3 0/2] bpf: enable some functions in cgroup programs
Date: Thu, 25 Jul 2024 02:14:09 +0200
Message-ID: <20240725001411.39614-1-technoboy85@gmail.com>
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
 kernel/trace/bpf_trace.c | 23 -----------------------
 4 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.45.2


