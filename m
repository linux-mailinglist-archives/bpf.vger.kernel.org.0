Return-Path: <bpf+bounces-44325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F383C9C15BD
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B321C229E1
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 04:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186C1D63C8;
	Fri,  8 Nov 2024 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vYuCie+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DB1D6194
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041686; cv=none; b=bQyIxctik37kBuyaJf+SuGnYcfJb/BeFItZZopaLxtK78VumhyzboG20siRV5EjynTpGzqwp7OEYoTzaRhrwcqsMGa/N2Wf3IxqPaMgrz9HOKHaobd30tLp7Qxif35ONno1ZoRKLygxvbmzB8LqE39csaHoPK+EqZB9Z1ALTfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041686; c=relaxed/simple;
	bh=dIGeynGkMLjGNXXYNRqQVjC5Ja6EgwuB0H/jBnVmRu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UV/fJA/5t48g8k0Kzy7feuH0wsAv0vqkYk+Z1rrSlPbE74EraBn6XTQp43r8ceKR4KdE8idU/pYPbyC+fSjNW8tejdcrLlsMlw3X9I9AQj/T85ZMc39eyxLfjYj3rP31RkVAgH5FtnF6qJ+tz8Ppcixcmrm6fde6Gj2na+lokN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vYuCie+d; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1416066b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 20:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041684; x=1731646484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJgan6o2RSMXdq36KFGAXLuMMgpefFNHI2RLTAg8Qn4=;
        b=vYuCie+d7D/oZtQJjn6+2aegAsGu0i3OgsLGRraTCa5LOcIU5LCqK3iM7A7u8oj73U
         wINjabaNAbss84L3FfbK4jBx23El6++oO6vHAemHUtbHcLDl3NkqxK+GchH3kzq59Wod
         Y8RiqHme/oQf4KVaUpx13MkoQuel90tTPNz+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041684; x=1731646484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJgan6o2RSMXdq36KFGAXLuMMgpefFNHI2RLTAg8Qn4=;
        b=Zs/oFc8Ei29uXQq1SZ8ppD6HvS/ICDNGVDUtF22B4HcwZnbYX55l2zwDkEiBavMFOE
         RWhZBGinYaMDbA+9IGUXUf4y7ogebo0TdzIcnc47SHxJOBs3TMrSso/u8dndOD4MCMM6
         IZzaFwTBWezS99e5lvQm8EuQXK2DTWg9TxIHIyh/z+5H/vXlspfJpiNj/Zo74m3+64/h
         j4VnleO4rMJBb/itchXc67j8Umm6pncr8G7P0fdBj6JhuK5ICyoTSes367EVhIachiCz
         9394PJbJDFt/+v/c10yVTljssa/YnvjpI1n/DqSeaNaVdNuo2pBtgp5Jo3IKXhlBezi7
         xHyg==
X-Forwarded-Encrypted: i=1; AJvYcCX0L8XjZHybA3P7jbb2t2qaFjrFEN1xFdSCC4jX2mKHIQ34Ifevfi71hFCKx75Myl2Nk5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLE+e5U19jtkkNserWJPKkVt60MZkTulMzrrsdRzHgRBq/UX0M
	BgH8CX5n1dDxq6P4GUAfQFPCfwv0l/05sK7Vz1LxgtGeaWDOL9mGYMoyQbH3/rI=
X-Google-Smtp-Source: AGHT+IFYYh1KVm1vnXo5i8A/6ou6NmgzKihA4VZltJB5Zo+fMOwiLuAlcOXdy5/ladTFMzB0AHqKfg==
X-Received: by 2002:a05:6a00:17aa:b0:71e:f14:869c with SMTP id d2e1a72fcca58-72413294bd3mr2293325b3a.6.1731041684075;
        Thu, 07 Nov 2024 20:54:44 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:43 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
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
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH net-next v8 6/6] docs: networking: Describe irq suspension
Date: Fri,  8 Nov 2024 04:53:28 +0000
Message-Id: <20241108045337.292905-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 v6:
   - Fixed packet processing loop description based on feedback from
     Bagas Sanjaya so that it renders properly when generated as html

 v5:
   - Fixed a minor typo in the epoll-based busy polling section
   - Removed short paragraph referring to experimental data as that data
     is not included in the documentation

 v4:
   - Updated documentation to further explain irq suspension
   - Dropped Stanislav's Acked-by tag because of the doc changes
   - Dropped Bagas' Reviewed-by tag because of the doc changes

 v1 -> v2:
   - Updated documentation to describe the per-NAPI configuration
     parameters.

 Documentation/networking/napi.rst | 170 +++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index dfa5d549be9c..02720dd71a76 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -192,6 +192,33 @@ is reused to control the delay of the timer, while
 ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
 before NAPI gives up and goes back to using hardware IRQs.
 
+The above parameters can also be set on a per-NAPI basis using netlink via
+netdev-genl. When used with netlink and configured on a per-NAPI basis, the
+parameters mentioned above use hyphens instead of underscores:
+``gro-flush-timeout`` and ``napi-defer-hard-irqs``.
+
+Per-NAPI configuration can be done programmatically in a user application
+or by using a script included in the kernel source tree:
+``tools/net/ynl/cli.py``.
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
+``irq-suspend-timeout`` is used to determine how long an application can
+completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_POLL,
+which can be set on a per-epoll context basis with ``EPIOCSPARAMS`` ioctl.
+
 .. _poll:
 
 Busy polling
@@ -207,6 +234,46 @@ selected sockets or using the global ``net.core.busy_poll`` and
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
+Alternatively, if the application uses SO_REUSEPORT, a bpf or ebpf program can
+be inserted to distribute incoming connections to threads such that each thread
+is only given incoming connections with the same NAPI ID. Care must be taken to
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
 
@@ -222,12 +289,111 @@ Such applications can pledge to the kernel that they will perform a busy
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
+  1. The per-NAPI config parameter ``irq-suspend-timeout`` should be set to the
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
+userland, the ``irq-suspend-timeout`` is deferred and IRQs are disabled. This
+allows the application to process data without interference.
+
+Once a call to epoll_wait results in no events being found, IRQ suspension is
+automatically disabled and the ``gro_flush_timeout`` and
+``napi_defer_hard_irqs`` mitigation mechanisms take over.
+
+It is expected that ``irq-suspend-timeout`` will be set to a value much larger
+than ``gro_flush_timeout`` as ``irq-suspend-timeout`` should suspend IRQs for
+the duration of one userland processing cycle.
+
+While it is not stricly necessary to use ``napi_defer_hard_irqs`` and
+``gro_flush_timeout`` to use IRQ suspension, their use is strongly
+recommended.
+
+IRQ suspension causes the system to alternate between polling mode and
+irq-driven packet delivery. During busy periods, ``irq-suspend-timeout``
+overrides ``gro_flush_timeout`` and keeps the system busy polling, but when
+epoll finds no events, the setting of ``gro_flush_timeout`` and
+``napi_defer_hard_irqs`` determine the next step.
+
+There are essentially three possible loops for network processing and
+packet delivery:
+
+1) hardirq -> softirq -> napi poll; basic interrupt delivery
+2) timer -> softirq -> napi poll; deferred irq processing
+3) epoll -> busy-poll -> napi poll; busy looping
+
+Loop 2 can take control from Loop 1, if ``gro_flush_timeout`` and
+``napi_defer_hard_irqs`` are set.
+
+If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are set, Loops 2
+and 3 "wrestle" with each other for control.
+
+During busy periods, ``irq-suspend-timeout`` is used as timer in Loop 2,
+which essentially tilts network processing in favour of Loop 3.
+
+If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are not set, Loop 3
+cannot take control from Loop 1.
+
+Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
+the recommended usage, because otherwise setting ``irq-suspend-timeout``
+might not have any discernible effect.
 
 .. _threaded:
 
-- 
2.25.1


