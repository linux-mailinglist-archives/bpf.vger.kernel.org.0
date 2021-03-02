Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C932B338
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbhCCDuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347086AbhCBRgT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:19 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA64C061D73
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id x29so6015853pgk.6
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4TZNoz7ocIF56TKRbY3Vad3YXgKTVwOO2I7OPJ9bdI=;
        b=Rq8g8G4z1aYt5VEo1BJL1lomrPLJDL8MogcsKXho9qnTQQsZjjcYppdO7Pgzg5rQ6p
         Yv3KwyxgU1SCK009bDta+0kKTZ0BUumGgSC7wCyx+vUYFINpAQupYFbSL6p73A2fORuy
         cYdiPm1jxd5z69yFQM+JbIA4fWaI47ocd3a+NlCBhfcGed8Yzs3nSMjoemCWHg4TZlgQ
         pQQZWhm3lwDtOQy6Q3BGJWUh8vIcDK5cdD8jArYQwjhW0b4nI/wtSLAIaoKWD5p5DxbQ
         yTOcJ6hyAuE2hLln6ldOtmK35PCndBIL7qUndNBnO7X3q22S14ihOneSfegT61NUPlrk
         Ia6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4TZNoz7ocIF56TKRbY3Vad3YXgKTVwOO2I7OPJ9bdI=;
        b=euGGXEpaMfiI/fE0JMYsmjaRXG5Ich0QSgJWZbThsOOYnpTO7HkFqzWNGrzB2L+Lb1
         IWhQHI294IjfKOhlh8loUKPf0bkwMRH9C8pQ48leqyVxRo+I+svk0Y4hWdypIsxvUxRt
         +vMO+G1rPbH2WqIiaS0Yra19Wp7OiYKXURRPuXrRcfsZ/BNGfehn511nctMSIbMPY74H
         /l787UrpomFbKUfvQzoweDIcBam5JGwW70lyNQtP8HeTFlTbzkoKhH5kiPNxMirEM8Ku
         00yBINfEA/533JnBU0EwaCXfV3r8Ub8mJGy6oulc4XgNFiB0ZBnqWxhcQW4H313L++eb
         YfiQ==
X-Gm-Message-State: AOAM530x9L3YmHWXxLEEEV8WFtfJvtKezP1CUCnd+n/KKRsT5Yl5jFLe
        +JQUh48oJq5dT6Ashx7g3EqQoBEBvTnendG8
X-Google-Smtp-Source: ABdhPJzzrU4EnuhRv5vP5CvUvDAT9MZzHUjANL8z8fBWR9KhipnfIrGMov1YV2gpQAV0C3+I1u4/Ig==
X-Received: by 2002:a05:6a00:1e:b029:1ed:b82c:bb64 with SMTP id h30-20020a056a00001eb02901edb82cbb64mr20018658pfk.78.1614705638819;
        Tue, 02 Mar 2021 09:20:38 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:38 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Daniel Mack <daniel@zonque.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sean Young <sean@mess.org>, Petar Penkov <ppenkov@google.com>
Subject: [PATCHv2 bpf-next 05/15] bpf: Document BPF_PROG_ATTACH syscall command
Date:   Tue,  2 Mar 2021 09:19:37 -0800
Message-Id: <20210302171947.2268128-6-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document the prog attach command in more detail, based on git commits:
* commit f4324551489e ("bpf: add BPF_PROG_ATTACH and BPF_PROG_DETACH
  commands")
* commit 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor
  socket TX/RX data")
* commit f4364dcfc86d ("media: rc: introduce BPF_PROG_LIRC_MODE2")
* commit d58e468b1112 ("flow_dissector: implements flow dissector BPF
  hook")

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
CC: Daniel Mack <daniel@zonque.org>
CC: John Fastabend <john.fastabend@gmail.com>
CC: Sean Young <sean@mess.org>
CC: Petar Penkov <ppenkov@google.com>
---
 include/uapi/linux/bpf.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6946dde90c56..a8f2964ec885 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -253,6 +253,43 @@ union bpf_iter_link_info {
  *		Attach an eBPF program to a *target_fd* at the specified
  *		*attach_type* hook.
  *
+ *		The *attach_type* specifies the eBPF attachment point to
+ *		attach the program to, and must be one of *bpf_attach_type*
+ *		(see below).
+ *
+ *		The *attach_bpf_fd* must be a valid file descriptor for a
+ *		loaded eBPF program of a cgroup, flow dissector, LIRC, sockmap
+ *		or sock_ops type corresponding to the specified *attach_type*.
+ *
+ *		The *target_fd* must be a valid file descriptor for a kernel
+ *		object which depends on the attach type of *attach_bpf_fd*:
+ *
+ *		**BPF_PROG_TYPE_CGROUP_DEVICE**,
+ *		**BPF_PROG_TYPE_CGROUP_SKB**,
+ *		**BPF_PROG_TYPE_CGROUP_SOCK**,
+ *		**BPF_PROG_TYPE_CGROUP_SOCK_ADDR**,
+ *		**BPF_PROG_TYPE_CGROUP_SOCKOPT**,
+ *		**BPF_PROG_TYPE_CGROUP_SYSCTL**,
+ *		**BPF_PROG_TYPE_SOCK_OPS**
+ *
+ *			Control Group v2 hierarchy with the eBPF controller
+ *			enabled. Requires the kernel to be compiled with
+ *			**CONFIG_CGROUP_BPF**.
+ *
+ *		**BPF_PROG_TYPE_FLOW_DISSECTOR**
+ *
+ *			Network namespace (eg /proc/self/ns/net).
+ *
+ *		**BPF_PROG_TYPE_LIRC_MODE2**
+ *
+ *			LIRC device path (eg /dev/lircN). Requires the kernel
+ *			to be compiled with **CONFIG_BPF_LIRC_MODE2**.
+ *
+ *		**BPF_PROG_TYPE_SK_SKB**,
+ *		**BPF_PROG_TYPE_SK_MSG**
+ *
+ *			eBPF map of socket type (eg **BPF_MAP_TYPE_SOCKHASH**).
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
-- 
2.27.0

