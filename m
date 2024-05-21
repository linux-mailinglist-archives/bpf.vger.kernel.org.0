Return-Path: <bpf+bounces-30099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BC8CAC25
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169101C20B33
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E87E58D;
	Tue, 21 May 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QKrHGL7h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4527352D
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286748; cv=none; b=qAJdo8f8Wq6FgEzvBv7oXHh8rJfFTm9bBp8qletyfErr4lSD4e+Xeg0Zzgp7OWq1iMlcIOeF1FbhD4HJDr2+jrks5AFUsroi4+TmtAOAbWBDM4pwZJhWaapMWSF0PWCstZ+EeWcyuqsQ4oWim5mBAHt7+HOhn/9jck7cLAKUM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286748; c=relaxed/simple;
	bh=aTLAfJ7NTAq195IS6FqbKzM3Y760wbMl85VWvhcZgbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDNHzC+prOj7uI8TeK8zdQo1jG6DJEk0NKdX3LVm1uSFgDtey8KQUlitNGgkwdb37BLZy/mvpz9atTOL91rVqeZ4bcL5k+JjuKvg+FRkp0hSRMC6WKfmFvOVyfA1DwQC83e1gySnk+L69zYbb094PExUL3aQJw3xW7gT+9siTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QKrHGL7h; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e428242a38so72078841fa.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716286745; x=1716891545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVE6+ZCNpzwGUe1XsnJn7ueU+NKyXAImX94cXiq0K+c=;
        b=QKrHGL7hpwz/uI3zNsDl72G93KBtnl+z4XG+5T8OcIhPVRxm0n1KBQQD27xOKbAd4B
         42Ks534ejYQ8O0n3675IaGEMnfLTcyydEuyVRGgn3e4+neAeUE3oVcVIFB+veCl4IeXN
         +IZFT0SK3tGrrRyjCcdrBdlCDYwBTX3QPlCkpSY7ncqu6BXCsuH4VH3A3vCOaiGkuYgC
         qmzg/FBR5LFaSeTYeWIFC9qTkJtNLI6sh/RmFzkpvXtRzgvrbID/tRhJvqkyP9DxLSwv
         NL+T0nCUpJJPtRmzBZjT8tLOwvJll6tEQyPyZzgXfH/L5UGGz6wKRnmV7tc2JQ7uXxl7
         ZLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286745; x=1716891545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVE6+ZCNpzwGUe1XsnJn7ueU+NKyXAImX94cXiq0K+c=;
        b=KPObRc6GRKp05tEUS0JWtwBIJstOpMeMcWr8LOmX20s59Psrk7KyRqhmiJvOn9W/mm
         QmIddvLQTSsT5atS87r21mll9NCbdoJ3aqFlEiHWR7e4uDsudf9RdFlUUyttD22gLCEP
         BXQ1nybeezsYqsDUg9vVgedRCUmoN5s8hkJ711otq8KxXQqJ3arqJ+ztNfzFwm4wif+4
         j+U3vZPmlX7zQOVDia589PORNnFmjhK5IRf5sSQIXabUCcrzzXwQxggqvRfSDXkEuRQW
         fbGuu9xinIJzLjMsUP+I0KOyVttNMojBDizg1sTS/+x5lav+75OOHrVRTX5dWgZgpbc1
         C6uw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6MJAej5ygtv8QepJyvm89TPdvuC5X/dMDeH24kshTFMNaBpPgQsdHwcrdCjItt29tsVXnFRZYovs9aD0uK3V3qys
X-Gm-Message-State: AOJu0Yx42PN8DQiACztcHNrJlZhLrhOnzzpskvrOhRyPT7lDFWQISktt
	t65U57ayOSRqiHKjYULJpVtrIRHHi0SMQx3dc/P6Xt1IC3EQREvar/pJB4Mz01xbrl/T9NGj2mo
	I
X-Google-Smtp-Source: AGHT+IHkv0xLQlJx9nmGqPzFCA5HSn/x5Ym5Kxlwi2kfYV/zoIdIVyZNAL9J7SEi3/cktsuxGCgFKQ==
X-Received: by 2002:ac2:592f:0:b0:51f:4d57:6812 with SMTP id 2adb3069b0e04-5220fd7c8dcmr23637379e87.19.1716286744270;
        Tue, 21 May 2024 03:19:04 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fcfsm1577106566b.119.2024.05.21.03.19.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 03:19:03 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.6.y] bpf: Add missing BPF_LINK_TYPE invocations
Date: Tue, 21 May 2024 11:18:26 +0100
Message-Id: <20240521101826.95373-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

commit 117211aa739a926e6555cfea883be84bee6f1695 upstream.

Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.

The reason is missing BPF_LINK_TYPE invocation for uprobe multi
link and for several other links, adding that.

[1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20231215230502.2769743-1-jolsa@kernel.org
Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
Hi,

We have experienced a KASAN warning in production on a 6.6 kernel, similar to
[1]. This backported patch was adjusted to apply onto 6.6 stable branch: the
only change is dropping the BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
definition from the header as netkit was only introduced in 6.7 and 6.7 has the
backport already.

I was not able to run the syzkaller reproducer from [1], but we have not seen
the KASAN warning in production since applying this patch internally.

Regards,
Ignat 

 include/linux/bpf_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..dfaae3e3ec15 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -142,9 +142,12 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
 #ifdef CONFIG_NET
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
 #endif
 #ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
+BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
-- 
2.39.2


