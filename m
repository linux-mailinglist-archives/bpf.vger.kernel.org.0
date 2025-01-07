Return-Path: <bpf+bounces-48085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B415DA03EBE
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921953A208B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC541F0E42;
	Tue,  7 Jan 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGZKwhbh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CB1EF092;
	Tue,  7 Jan 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251777; cv=none; b=DfRxyts3jz8/BExYHt+5fwuSy47TixPOgUFo+2V48yoqj5N/mSrVJ/f7VnVEH5NTbpNKEFP+DQ8kJRzfJzzKjqzwYUCiD+gIW17BTzcCR9xmJvWJGhC6hFA4Fg5Tp2ks2MttvzThHGUb40SAK/0RERZTuvrLpXl8HFDVlUObzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251777; c=relaxed/simple;
	bh=BcJ1+ErwhpYwGh/rfChvp0JPwe2mgonl6PVzz/hWq0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di3Oe86HEMvvuM4vtf3afH//V7VljkwR5QmjSgMqbGSbxSfilylYCY0QvEjTvNL2ug4qcMrmNUE2iTXXC6lYWF90hazsaVwPz+/yU2bypmkHEw6y7EVG9Zus8yx/u8Z/ToR+YcCy/LDMwfLJDsJqJ0vgNPDgZVAx8KNEI8h3U+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGZKwhbh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216401de828so212315825ad.3;
        Tue, 07 Jan 2025 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251745; x=1736856545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ+VSImmiXFzQePcnrhQ+GQSKc7zTHd3WIb9Tq+VcQU=;
        b=jGZKwhbhZe5dmKulvH3lvUFIl28F10h3VsucOdkdMB6K6Th2k7GqNkXHZdAY2AoEg2
         8z1TdOiK9QIJDPqeFAFUGjFFkPR84Wia8TwqYxf7oun0UKeM0tPtY/oqYl0YkBtiS8zY
         /rqNA2t+aEOb1xknTMG9+80OZi2nabn/jnDmCrN3OrP9evGDyOTYtiqNuw+j35N1uhhq
         CVEHjgDslhRSZBPkhD3+hy+1zsSP4CBZyagZBAeKTLOjNGU2keR2tPBmizHoHzOpEiRF
         2QXZxnfx0J5ImI3tnU79GoqynpT/CTMoMZUiMg4INnEX/OupKSy3mVbCPh10TJPjdQCk
         rbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251745; x=1736856545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ+VSImmiXFzQePcnrhQ+GQSKc7zTHd3WIb9Tq+VcQU=;
        b=rFrWTf15Ah+KzuYZBK7qrQbLMZ7URq9noP64wjuLjJIpmNqOhuhHrToRQVtZ7meeEC
         CQ9y0sBnw5CYfJP9/78+c+ez5tMR0xKJVuBjymBk4crETez7AKWzZYqTzI93TNYa3Ndd
         DoeaRvYs7z0whFsUg7ky2MtksKXXUuzfBELdbhvHUe9zTK3rTLp2ZltTjKUI2h5Zuya7
         N2BvGquVZ1WWQ5YoU9NNvP2mXPGlNpLPvct5GXFIuOwYZ86o57DXUPdw0OXVabSkrydx
         Ar/UzxCeWNvug7ZjZ3w/trf8lLXd6elxTxAp7ctBwkb/RBaUcEeMI4MOFb/BOKbrcYJ+
         G4pw==
X-Forwarded-Encrypted: i=1; AJvYcCUDIN9eA5MgEdw5NJBCzj24LclnXY/K+VlXcgHdz5PT7yYPw36xbSuzfvIzlDPJQBCDYH/USiYjnpMB8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWiRDu9ulhd0vjBfLfYmHCDW+FDedtoa2tNzi1M7xufOMBXgY
	LLnAiqOWjzfnpHcwiRIhzAqV4BMpy39wXVfSzMy2NxV+hJg7Y9gEzU9q3R4UunM=
X-Gm-Gg: ASbGncvpuirh/z3o2vhpOj3oW/q85eaIp1X25cDKY1sIyfvmDAiav/U7/0gJhXXPV7d
	NZ1ZKb4zZBby3vva0XfEK0Zk5fyNJMUJpXwlGRg31YoTqHDnnhZJP+QC83ARP36ldz8ekeHlk3J
	fmOesr4s2XBLc06leybBtyrzndM1XMELbv5FRjcywWJ4V+cKrcCxEFdKCjbn6TRoLJpwLFmM4nS
	ueNK+nDrUxSGyWfC4NzbO+zVXpfbOXKWVQOvPQsB17BgXj6CQTUBOSNuV98kvb+oEXl
X-Google-Smtp-Source: AGHT+IEMyh0qn+48/wwBvNg6K0uoHVG+djpoPH4ToP2Ro3iN6Tdbo264ul/fzW6g4ImCKpyQI8hUMA==
X-Received: by 2002:a05:6a20:8412:b0:1e2:2e4:6b2a with SMTP id adf61e73a8af0-1e5e044af7bmr93846638637.5.1736251744825;
        Tue, 07 Jan 2025 04:09:04 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:09:04 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 22/22] ublk: document ublk-bpf & bpf-aio
Date: Tue,  7 Jan 2025 20:04:13 +0800
Message-ID: <20250107120417.1237392-23-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document ublk-bpf motivation and implementation.

Document bpf-aio implementation.

Document ublk-bpf selftests.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 Documentation/block/ublk.rst | 170 +++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 51665a3e6a50..bf7a3df48036 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -309,6 +309,176 @@ with specified IO tag in the command data:
   ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
   the server buffer (pages) read to the IO request pages.
 
+
+UBLK-BPF support
+================
+
+Motivation
+----------
+
+- support stacking ublk
+
+  There are many 3rd party volume manager, ublk may be built over ublk device
+  for simplifying implementation, however, multiple userspace-kernel context
+  switchs for handling one single IO can't be accepted from performance view
+  of point
+
+  ublk-bpf can avoid user-kernel context switch in most fast io path, so ublk
+  over ublk becomes possible
+
+- complicated virtual block device
+
+  Many complicated virtual block devices have admin&meta code path and normal
+  IO fast path; meta & admin IO handling is usually complicated, so it can be
+  moved to ublk server for relieving development burden; meantime IO fast path
+  can be kept in kernel space for the sake of high performance.
+
+  Bpf provides rich maps, which helps a lot for communication between
+  userspace and prog or between prog and prog.
+
+  One typical example is qcow2, which meta IO handling can be kept in
+  ublk server, and fast IO path is moved to bpf prog. Efficient bpf map can be
+  looked up first and see if this virtual LBA & host LBA mapping is hit in
+  the map. If yes, handle the IO with ublk-bpf directly, otherwise forward to
+  ublk server to populate the mapping first.
+
+- some simple high performance virtual devices
+
+  Such as null & loop, the whole implementation can be moved to bpf prog
+  completely.
+
+- provides chance to get similar performance with kernel driver
+
+  One round of kernel/user context switch is avoided, and one extra IO data
+  copy is saved
+
+bpf aio
+-------
+
+bpf aio exports kfuncs for bpf prog to submit & complete IO in async way.
+IO completion handler is provided by the bpf aio user, which is still
+defined in bpf prog(such as ublk bpf prog) as `struct bpf_aio_complete_ops`
+of bpf struct_ops.
+
+bpf aio is designed as generic interface, which can be used for any bpf prog
+in theory, and it may be move to `/lib/` in future if the interface becomes
+mature and stable enough.
+
+- bpf_aio_alloc()
+
+  Allocate one bpf aio instance of `struct bpf_aio`
+
+- bpf_aio_release()
+
+  Free one bpf aio instance of `struct bpf_aio`
+
+- bpf_aio_submit()
+
+  Submit one bpf aio instance of `struct bpf_aio` in async way.
+
+- `struct bpf_aio_complete_ops`
+
+  Define bpf aio completion callback implemented as bpf struct_ops, and
+  it is called when the submitted bpf aio is completed.
+
+
+ublk bpf implementation
+-----------------------
+
+Export `struct ublk_bpf_ops` as bpf struct_ops, so that ublk IO command
+can be queued or handled in the callback defined in the ublk bpf struct_ops,
+see the whole logic in `ublk_run_bpf_handler`:
+
+- `UBLK_BPF_IO_QUEUED`
+
+  If ->queue_io_cmd() or ->queue_io_cmd_daemon() returns `UBLK_BPF_IO_QUEUED`,
+  this IO command has been queued by bpf prog, so it won't be forwarded to
+  ublk server
+
+- `UBLK_BPF_IO_REDIRECT`
+
+  If ->queue_io_cmd() or ->queue_io_cmd_daemon() returns `UBLK_BPF_IO_REDIRECT`,
+  this IO command will be forwarded to ublk server
+
+- `UBLK_BPF_IO_CONTINUE`
+
+  If ->queue_io_cmd() or ->queue_io_cmd_daemon() returns `UBLK_BPF_IO_CONTINUE`,
+  part of this io command is queued, and `ublk_bpf_return_t` carries how many
+  bytes queued, so ublk driver will continue to call the callback to queue
+  remained bytes of this io command further, this way is helpful for
+  implementing stacking devices by allowing IO command split.
+
+ublk bpf provides kfuncs for ublk bpf prog to queue and handle ublk IO command:
+
+- ublk_bpf_complete_io()
+
+  Complete this ublk IO command
+
+- ublk_bpf_get_io_tag()
+
+  Get tag of this ublk IO command
+
+- ublk_bpf_get_queue_id()
+
+  Get queue id of this ublk IO command
+
+- ublk_bpf_get_dev_id()
+
+  Get device id of this ublk IO command
+
+- ublk_bpf_attach_and_prep_aio()
+
+  Attach & prepare bpf aio to this ublk IO command, bpf aio buffer is
+  prepared, and aio's complete callback is setup, so the user prog can
+  get notified when the bpf aio is completed
+
+- ublk_bpf_dettach_and_complete_aio()
+
+  Detach bpf aio from this IO command, and it is usually called from bpf
+  aio's completion callback.
+
+- ublk_bpf_acquire_io_from_aio()
+
+  Acquire ublk IO command from the aio, one typical use is for calling
+  ublk_bpf_complete_io() to complete ublk IO command
+
+- ublk_bpf_release_io_from_aio()
+
+  Release ublk IO command which is acquired from `ublk_bpf_acquire_io_from_aio`
+
+
+Test
+----
+
+- Build kernel & install kernel headers & reboot & test
+
+  enable CONFIG_BLK_DEV_UBLK & CONFIG_UBLK_BPF
+
+  make
+
+  make headers_install INSTALL_HDR_PATH=/usr
+
+  reboot
+
+  make -C tools/testing/selftests TARGETS=ublk run_test
+
+ublk selftests implements null, loop and stripe targets for covering all
+bpf features:
+
+- complete bpf IO handling
+
+- complete ublk server IO handling
+
+- mixed bpf prog and ublk server IO handling
+
+- bpf aio for loop & stripe
+
+- IO split via `UBLK_BPF_IO_CONTINUE` for implementing ublk-stripe
+
+Write & read verify, and mkfs.ext4 & mount & umount are run in the
+selftest.
+
+
 Future development
 ==================
 
-- 
2.47.0


