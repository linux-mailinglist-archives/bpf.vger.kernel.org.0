Return-Path: <bpf+bounces-37966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C372995D459
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459971F21BA2
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66023193423;
	Fri, 23 Aug 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QGL9lB6o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D190489
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434321; cv=none; b=pz/D2QQgHrYI9IICh+64QCNIMFACvEC4QeEtYeb0Bh7ovfdApsG0Yoy25nsWdxFNQF3COsUyhpdYzUCH0B9sp0C7qJpzsTCD3AA/cooUNFBIV8rOrg2IXqqf0AxZApISqZkO2NFeoXvaTJ4DirQZjtYkfFVEm1JUCC8NjLccSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434321; c=relaxed/simple;
	bh=A5hbTpFf9NReafBa0UeWIum+icaAKqweWQ059Dzzjcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqcSXJZul9fXy3IYntH4uZCYcs43fm2R+Ot4hvT4ccIQg6sxS+sSk2oe2OypYDpILsYfSvjrbqIFtz0rm9rknu1UywuUtWQ5H4Oxt2QyqO2uah6k0EP8AhNomfB59ScG2zs3cibdtmzn4/5hEip+iQ1r6CcHjg4akphUaD79YxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QGL9lB6o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71433cba1b7so1811141b3a.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434318; x=1725039118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRJG7gtnGEjX3zB/r9nH89EwAMVuBrmJ1/QaNGiIfQ4=;
        b=QGL9lB6ogoNYeGHIWooh8MVe/ffaB0F0a9lCxfSy4N18rwBI9mHQC1wPx5MNuIb02V
         XmbwF8I2dirzc4relE65P4bIEZrmwP9QKJbeGc6829Ub1+xCDFsNfZ29Tusi8JHuaXop
         w79qa/CawICQYQZHlQcetEnbf3aLyIZM/RYeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434318; x=1725039118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRJG7gtnGEjX3zB/r9nH89EwAMVuBrmJ1/QaNGiIfQ4=;
        b=UuJbFU2gXf4EEXSXFHvP7+KQ4clM9aQH2G6CFXyFERNyzKqlYQxj+U3n5BgUAxf/Md
         R5YiPY6sDI/j0ppD+g4g3sM2NHQEPoChY4u1Yt4d7Q4UP/RYDl3EMgn+VzWMz6NgKjH5
         whUlyHt6u46mibBPSIn8hAg7hdlr0bWnZS76zaMvq+3Cu2uSB7dZSqorz5bTf8jPsTBJ
         sj+p+tRuhUvrIYGGGllvwhTPFckTCQxlmG1qhg1qbXbRlVbGToxx+WH6spMAW1mu3iVk
         Ldsc8OyilWKlZYVmapz7qsU6CPrIeAeHHeLIy/mkw52CEVgQoo/7vCu3OkzPSp1Jwj7k
         ucyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvCUz/WTs9+zLECrVe9+3gzoh6k1uR1i5FG1DUh2J+hB65i3zuT1auiDPHC2G1nwOyy0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAkY4uW/usuKDtpFVD5fwHrcek0u0Zx/Fm88+/MIMgQMR742o
	zNGTzHw4Ga+jMUG+0ITr4s1O7eftnL0ftN7+W0H8ROfg6J70JyBh99dkK3JMlVg=
X-Google-Smtp-Source: AGHT+IE/GsHsdnuK6rqXk7/a6x4NQp6xoPAAhkZXujnf6d3K6GfaKiO9uswOkRtrYN+I8cZ8TbZK+g==
X-Received: by 2002:a05:6a21:2d86:b0:1c4:dfa7:d3ce with SMTP id adf61e73a8af0-1cc89d4cd1fmr3514127637.17.1724434318226;
        Fri, 23 Aug 2024 10:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:57 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
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
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH net-next 6/6] docs: networking: Describe irq suspension
Date: Fri, 23 Aug 2024 17:30:57 +0000
Message-Id: <20240823173103.94978-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
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
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 Documentation/networking/napi.rst | 112 +++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 7bf7b95c4f7a..04e838835b50 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -192,6 +192,9 @@ The ``gro_flush_timeout`` sysfs configuration of the netdevice
 is reused to control the delay of the timer, while
 ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
 before NAPI gives up and goes back to using hardware IRQs.
+``irq_suspend_timeout`` is used to determine how long an application can
+completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_POLL,
+which can be set on a per-epoll context basis with ``EPIOCSPARAMS`` ioctl.
 
 .. _poll:
 
@@ -208,6 +211,46 @@ selected sockets or using the global ``net.core.busy_poll`` and
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
+   not be desireable as many applications may not have the need to busy poll.
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
 
@@ -223,12 +266,77 @@ Such applications can pledge to the kernel that they will perform a busy
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
+  1. The sysfs parameter ``irq_suspend_timeout`` should be set to the maximum
+     time (in nanoseconds) the application can have its IRQs suspended. This
+     timeout serves as a safety mechanism to restart IRQ driver interrupt
+     processing if the application has stalled. This value should be chosen so
+     that it covers the amount of time the user application needs to process
+     data from its call to epoll_wait, noting that applications can control how
+     much data they retrieve by setting ``max_events`` when calling epoll_wait.
+
+  2. The sysfs parameter ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` can
+     be set to low values. They will be used to defer IRQs after busy poll has
+     found no data.
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


