Return-Path: <bpf+bounces-42562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2DD9A58BA
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907C281225
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5182940B;
	Mon, 21 Oct 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dQV3fgXV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911F126BE0
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475647; cv=none; b=WbAAV9IjRESlalwnPu6D0buV9pqL81ukfcUnCv52+M6Ft8yYFTsa9ybxnzC2KVnVWl2DrmtozJz4mM3cLkZx9wGyDiWfSym2mLDOmO7KKRry14z5nZdVrT130CSgYfjBjIyEhNPqtlnwlH737KIxs5HNSHg+8iYdmjbRPjc5ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475647; c=relaxed/simple;
	bh=UKcbLgaIhruPiHQVux7frT2vyssaPMGMH3qyAhwocGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVCsy/+vNddY1R3LyIEW4by+N1a0ZHKJ5ZG5P7qdCImkR5qSfXH9+BijLyv1xbQULygHstf5Llr1FU01Ae5of0qSkMxbrhOZcozvsiMy1I+oqWruB5BEniJ0x2TCfbG7BxmgvNXO4gnD7TwDieERrJNxeCq1wvNR9Kt+v1tCPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dQV3fgXV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ce5e3b116so29605435ad.1
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729475644; x=1730080444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov+a74yyWVssGZ0VVpLag6M6zuR8CKA5GgGeFDgsMcI=;
        b=dQV3fgXVYxTZflvEtCMJCkH9wPk6AyRT1vExTi+WroPVPIehXv/5vhvLdRIfoRe4iM
         MxPrXj/K3sHSPtluNRlbHGTP3uDS+1mmLw95ncELP8qAqog2nP+4snjohk3ucVQw+7ff
         2ydJrPXGimyuYMfPOyPrZzjScL7DvU0vn9X3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475644; x=1730080444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov+a74yyWVssGZ0VVpLag6M6zuR8CKA5GgGeFDgsMcI=;
        b=NfnyE6Zay8W9em0tq5Fg5huoo3h9zbLtL68yQL5sNgWoXqn0dHxtf5LYwVA7TKw7gR
         6Dytk9UyjessG55AYNUAJ4/Xnhvzs66nqgMEg/1B+C8ajLSFvuJ3KYtbmwbVVRgqznV8
         LKOq3xoBwE4YuAo8e0etWv8ktJw6K9tG7x8E2thZT8TJ1/LYkfYdA8bRkr1QKn05rvzE
         OsrVl5z7yPafufGOZjFsWZtXRu4ehDbFBugfzt5qGDm9CDBZ/AFPdv9S3e+FPwgCBt77
         N///eoNzLLLxXZcDU95g0cA5UhtA7zEEc97S0Axs/qzBpGTSDaqfg3AFIVHmxTpGhvep
         Io7g==
X-Forwarded-Encrypted: i=1; AJvYcCXG8MzIScirZ4u9fshkUcyt2Opg5MXzLl9AnZrJctYWSz60NhwkddDk1qJ5wmUKdTGGaFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOwif+gdJ/Ct3dPVeDVZGC1IoMDraykxOwGjQfoDSYMYWAXJ3
	DU6ksPHlTp77tJL65K0BlK2hi1PaK+P8hzArM4YVFntYR3KApXOV+cWcc0FYL5w=
X-Google-Smtp-Source: AGHT+IFRh1M+as63n98NkQTDVZCHlHy/fZhBOPIE+Ea8KXRBufysFtL+AR7pOkA5nc0vjrv7IGmlBg==
X-Received: by 2002:a17:903:22c2:b0:20c:f9ec:cd8a with SMTP id d9443c01a7336-20e5a79f596mr152490435ad.7.1729475644492;
        Sun, 20 Oct 2024 18:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee650bsm15859985ad.34.2024.10.20.18.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:54:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH net-next v2 6/6] docs: networking: Describe irq suspension
Date: Mon, 21 Oct 2024 01:53:01 +0000
Message-Id: <20241021015311.95468-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021015311.95468-1-jdamato@fastly.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe irq suspension, the epoll ioctls, and the tradeoffs of using
different gro_flush_timeout values.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 v1 -> v2:
   - Updated documentation to describe the per-NAPI configuration
     parameters.

 Documentation/networking/napi.rst | 132 +++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index dfa5d549be9c..3b43477a52ce 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -192,6 +192,28 @@ is reused to control the delay of the timer, while
 ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
 before NAPI gives up and goes back to using hardware IRQs.
 
+The above parameters can also be set on a per-NAPI basis using netlink via
+netdev-genl. This can be done programmatically in a user application or by
+using a script included in the kernel source tree: ``tools/net/ynl/cli.py``.
+
+For example, using the script:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-set \
+            --json='{"id": 345,
+                     "defer-hard-irqs": 111,
+                     "gro-flush-timeout": 11111}'
+
+Similarly, the parameter ``irq-suspend-timeout`` can be set using netlink
+via netdev-genl. There is no global sysfs parameter for this value.
+
+``irq_suspend_timeout`` is used to determine how long an application can
+completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_POLL,
+which can be set on a per-epoll context basis with ``EPIOCSPARAMS`` ioctl.
+
 .. _poll:
 
 Busy polling
@@ -207,6 +229,46 @@ selected sockets or using the global ``net.core.busy_poll`` and
 ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
 also exists.
 
+epoll-based busy polling
+------------------------
+
+It is possible to trigger packet processing directly from calls to
+``epoll_wait``. In order to use this feature, a user application must ensure
+all file descriptors which are added to an epoll context have the same NAPI ID.
+
+If the application uses a dedicated acceptor thread, the application can obtain
+the NAPI ID of the incoming connection using SO_INCOMING_NAPI_ID and then
+distribute that file descriptor to a worker thread. The worker thread would add
+the file descriptor to its epoll context. This would ensure each worker thread
+has an epoll context with FDs that have the same NAPI ID.
+
+Alternatively, if the application uses SO_REUSEPORT, a bpf or ebpf program be
+inserted to distribute incoming connections to threads such that each thread is
+only given incoming connections with the same NAPI ID. Care must be taken to
+carefully handle cases where a system may have multiple NICs.
+
+In order to enable busy polling, there are two choices:
+
+1. ``/proc/sys/net/core/busy_poll`` can be set with a time in useconds to busy
+   loop waiting for events. This is a system-wide setting and will cause all
+   epoll-based applications to busy poll when they call epoll_wait. This may
+   not be desirable as many applications may not have the need to busy poll.
+
+2. Applications using recent kernels can issue an ioctl on the epoll context
+   file descriptor to set (``EPIOCSPARAMS``) or get (``EPIOCGPARAMS``) ``struct
+   epoll_params``:, which user programs can define as follows:
+
+.. code-block:: c
+
+  struct epoll_params {
+      uint32_t busy_poll_usecs;
+      uint16_t busy_poll_budget;
+      uint8_t prefer_busy_poll;
+
+      /* pad the struct to a multiple of 64bits */
+      uint8_t __pad;
+  };
+
 IRQ mitigation
 ---------------
 
@@ -222,12 +284,78 @@ Such applications can pledge to the kernel that they will perform a busy
 polling operation periodically, and the driver should keep the device IRQs
 permanently masked. This mode is enabled by using the ``SO_PREFER_BUSY_POLL``
 socket option. To avoid system misbehavior the pledge is revoked
-if ``gro_flush_timeout`` passes without any busy poll call.
+if ``gro_flush_timeout`` passes without any busy poll call. For epoll-based
+busy polling applications, the ``prefer_busy_poll`` field of ``struct
+epoll_params`` can be set to 1 and the ``EPIOCSPARAMS`` ioctl can be issued to
+enable this mode. See the above section for more details.
 
 The NAPI budget for busy polling is lower than the default (which makes
 sense given the low latency intention of normal busy polling). This is
 not the case with IRQ mitigation, however, so the budget can be adjusted
-with the ``SO_BUSY_POLL_BUDGET`` socket option.
+with the ``SO_BUSY_POLL_BUDGET`` socket option. For epoll-based busy polling
+applications, the ``busy_poll_budget`` field can be adjusted to the desired value
+in ``struct epoll_params`` and set on a specific epoll context using the ``EPIOCSPARAMS``
+ioctl. See the above section for more details.
+
+It is important to note that choosing a large value for ``gro_flush_timeout``
+will defer IRQs to allow for better batch processing, but will induce latency
+when the system is not fully loaded. Choosing a small value for
+``gro_flush_timeout`` can cause interference of the user application which is
+attempting to busy poll by device IRQs and softirq processing. This value
+should be chosen carefully with these tradeoffs in mind. epoll-based busy
+polling applications may be able to mitigate how much user processing happens
+by choosing an appropriate value for ``maxevents``.
+
+Users may want to consider an alternate approach, IRQ suspension, to help deal
+with these tradeoffs.
+
+IRQ suspension
+--------------
+
+IRQ suspension is a mechanism wherein device IRQs are masked while epoll
+triggers NAPI packet processing.
+
+While application calls to epoll_wait successfully retrieve events, the kernel will
+defer the IRQ suspension timer. If the kernel does not retrieve any events
+while busy polling (for example, because network traffic levels subsided), IRQ
+suspension is disabled and the IRQ mitigation strategies described above are
+engaged.
+
+This allows users to balance CPU consumption with network processing
+efficiency.
+
+To use this mechanism:
+
+  1. The per-NAPI config parameter ``irq_suspend_timeout`` should be set to the
+     maximum time (in nanoseconds) the application can have its IRQs
+     suspended. This is done using netlink, as described above. This timeout
+     serves as a safety mechanism to restart IRQ driver interrupt processing if
+     the application has stalled. This value should be chosen so that it covers
+     the amount of time the user application needs to process data from its
+     call to epoll_wait, noting that applications can control how much data
+     they retrieve by setting ``max_events`` when calling epoll_wait.
+
+  2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeout``
+     and ``napi_defer_hard_irqs`` can be set to low values. They will be used
+     to defer IRQs after busy poll has found no data.
+
+  3. The ``prefer_busy_poll`` flag must be set to true. This can be done using
+     the ``EPIOCSPARAMS`` ioctl as described above.
+
+  4. The application uses epoll as described above to trigger NAPI packet
+     processing.
+
+As mentioned above, as long as subsequent calls to epoll_wait return events to
+userland, the ``irq_suspend_timeout`` is deferred and IRQs are disabled. This
+allows the application to process data without interference.
+
+Once a call to epoll_wait results in no events being found, IRQ suspension is
+automatically disabled and the ``gro_flush_timeout`` and
+``napi_defer_hard_irqs`` mitigation mechanisms take over.
+
+It is expected that ``irq_suspend_timeout`` will be set to a value much larger
+than ``gro_flush_timeout`` as ``irq_suspend_timeout`` should suspend IRQs for
+the duration of one userland processing cycle.
 
 .. _threaded:
 
-- 
2.25.1


