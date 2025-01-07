Return-Path: <bpf+bounces-48068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F929A03E95
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8761885363
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9101E5701;
	Tue,  7 Jan 2025 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avqW6gLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FD4C9D;
	Tue,  7 Jan 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251678; cv=none; b=VYdz43v/5H99d9P17t3vkCyYOZn5KHwmOA9ZusTAEIqswxVrY4OfTNzdbTyP92laM8QlFcviTcj7ouYUzmSyibRTsseLLM+8KZUH8MpM38xi4QNCsHye4A+jrNmb08AbbPuzw4V4ZFmo1MLMOeYEr2+MbvZs5maqModIgbDjps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251678; c=relaxed/simple;
	bh=t8ytsErPG3RKMarMwHaJCqB7FJkesKASuBfmHLcRqz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJ9p6CISp39+6nZk5jP+ZehRnV6Rpiu4XLc/c4QKn69qidnuWEhGmINpavAilZjVmUhnYcDfWtQ91Oe/cbqJTTnygKdF5mm73NdziJ353IyuFwjCWR32V67461PQPWnuLqiuDp5uua59zGHPjdHGR5TH2cpOc/MlvGtr18z2wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avqW6gLa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so46945615ad.3;
        Tue, 07 Jan 2025 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251675; x=1736856475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HvZGddzJ7OORRk3hn4nr/3ssx/cXkxwes1RfquKUgg=;
        b=avqW6gLaah7O6+t02gqsqW1wCQPkMtixRJ/hGP/PMRO0U8BpkNPzYhm7wEkdpVeYjC
         ZbGT0ME+rTeflgliyPaAGqbShD1avDiNcC+YKsWmGIIVxGhaVHtl/FdThVl7OFg3fiBf
         TEMynDmS2/oy6E5SJJZXmFahMGw7AdSSmYbVTIQW5Y9BSKBUhBss/F7YDqdamhVIEDcs
         pJ5NlZIoEyBLJc0/D9jtshi4PdwHpM2KKIEa7bIhx4uxUmuvlpMK0mfk8audVg9kyO9+
         auw+/HV4bN9bfft/AM8Ea4iYrUbLWgGld0h/+UjrithfXpRWL0K9N47zJuQH8lsy0OdF
         W4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251675; x=1736856475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HvZGddzJ7OORRk3hn4nr/3ssx/cXkxwes1RfquKUgg=;
        b=q4zJmUWIWZ7Ff+yklnj+Ys8QkYriUj7ifLbzqXlUFtTqlii9EsUozRKP2+ImB9nvxu
         iyS630NLfblyYBCPjGeW8cJbampRht1UizmxnY+BwZRS6xtbca7J9UROm/u6mNAB4HZG
         lD7gd72lfBzL+nNA6wyEZSMBlHrBzz90h0eDE4XKQwlNzxvta8iTymgd1LubdaphO81t
         rpxpZZ9Osb7/s9tFyDj/YNznH4Y2BjTWiR19zj6D40tCO61ATZdn7y/496fPqsS/gzfN
         cnvosvtrCIVCckfrdBNvOQNs6jKs+lxfNQ9aGxcdfvgPgNQCVE6OR1cbmSuoSGeBvs/y
         ywLw==
X-Forwarded-Encrypted: i=1; AJvYcCVYggpL3ESP9SzRVP46fOKR43KkyEfaEYij90aKl272a8lyjOWQqyk+5hPaYVwPjhRQB3FE1BrAYrfnTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtfr96bSV8zz1zCenIKbKyJsx0MosoRV2jTDr+SrAaPH9csLZ6
	pYKfFahKrZ08n9Z4U/LVOCqtneaN/smusfLafPubYz91X0N1fUq3v7VjS2vgRIs=
X-Gm-Gg: ASbGncsh1Mr2uHJYJRNb68FFA8WNs+QgdPI+xKmLR7xCMwuG11kSxndKkrTI3bG3KH4
	Myd8KPlLc/F6T7ofczN4KQxkT3VA4q23h33bD6jQT0fJSPvCEcevOQqcoTPaB2H5GQ91viRj6ad
	6It+kOd9W/bHPbXtOf6GfqHDsQHPCg8ZH2Pc4QgH+d+ZrVwAhGwy1Iy/BGByHBkt+q/zzcOSrg5
	QfQrjPD36UhGnPaQ2kW0bDFczLOwIToZenw3mU1qS/+P42L3kGiGxGUSTJw5xB228sZ
X-Google-Smtp-Source: AGHT+IEvmNUfujgmzzGvFZYXvDVy1QpIoRgbxkFPhinLRKlURmtYgf0nVttbt/u33VEuParMMEAcKw==
X-Received: by 2002:a05:6a00:4096:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72abdd4f34bmr90053854b3a.3.1736251674678;
        Tue, 07 Jan 2025 04:07:54 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:07:54 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 00/22] ublk: support bpf
Date: Tue,  7 Jan 2025 20:03:51 +0800
Message-ID: <20250107120417.1237392-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Patch 1~6 cleans up & prepares for supporting ublk-bpf, which should be
ready to go.

Patch 7~14 supports ublk-bpf over struct_ops and selftests code. And
please see detailed motivation in commit log of "ublk: bpf: add bpf struct_ops"
and the last document patch.

Patch 15~21 adds bpf aio over struct_ops and applies it for ublk-bpf, and
selftests code.

Patch 22 adds document for ublk-bpf.

Git tree:

	https://github.com/ming1/linux.git  ublk_bpf_rfc
	https://github.com/ming1/linux/commits/ublk_bpf_rfc/
    
Kernel selftest:

	make -C tools/testing/selftests TARGETS=ublk run_tests
    
Comments are welcome!


Ming Lei (22):
  ublk: remove two unused fields from 'struct ublk_queue'
  ublk: convert several bool type fields into bitfield of `ublk_queue`
  ublk: add helper of ublk_need_map_io()
  ublk: move ublk into one standalone directory
  ublk: move private definitions into private header
  ublk: move several helpers to private header
  ublk: bpf: add bpf prog attach helpers
  ublk: bpf: add bpf struct_ops
  ublk: bpf: attach bpf prog to ublk device
  ublk: bpf: add kfunc for ublk bpf prog
  ublk: bpf: enable ublk-bpf
  selftests: ublk: add tests for the ublk-bpf initial implementation
  selftests: ublk: add tests for covering io split
  selftests: ublk: add tests for covering redirecting to userspace
  ublk: bpf: add bpf aio kfunc
  ublk: bpf: add bpf aio struct_ops
  ublk: bpf: attach bpf aio prog to ublk device
  ublk: bpf: add several ublk bpf aio kfuncs
  ublk: bpf: wire bpf aio with ublk io handling
  selftests: add tests for ublk bpf aio
  selftests: add tests for covering both bpf aio and split
  ublk: document ublk-bpf & bpf-aio

 Documentation/block/ublk.rst                  |  170 ++
 MAINTAINERS                                   |    3 +-
 drivers/block/Kconfig                         |   32 +-
 drivers/block/Makefile                        |    2 +-
 drivers/block/ublk/Kconfig                    |   52 +
 drivers/block/ublk/Makefile                   |   10 +
 drivers/block/ublk/bpf.c                      |  370 ++++
 drivers/block/ublk/bpf.h                      |  231 +++
 drivers/block/ublk/bpf_aio.c                  |  266 +++
 drivers/block/ublk/bpf_aio.h                  |  118 ++
 drivers/block/ublk/bpf_aio_ops.c              |  174 ++
 drivers/block/ublk/bpf_ops.c                  |  344 ++++
 drivers/block/ublk/bpf_reg.h                  |   77 +
 drivers/block/{ublk_drv.c => ublk/main.c}     |  267 +--
 drivers/block/ublk/ublk.h                     |  237 +++
 include/uapi/linux/ublk_cmd.h                 |   16 +-
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/ublk/.gitignore       |    4 +
 tools/testing/selftests/ublk/Makefile         |  236 +++
 tools/testing/selftests/ublk/config           |    2 +
 tools/testing/selftests/ublk/progs/ublk_bpf.h |   13 +
 .../selftests/ublk/progs/ublk_bpf_kfunc.h     |   44 +
 .../testing/selftests/ublk/progs/ublk_loop.c  |  166 ++
 .../testing/selftests/ublk/progs/ublk_null.c  |  177 ++
 .../selftests/ublk/progs/ublk_stripe.c        |  319 ++++
 tools/testing/selftests/ublk/test_common.sh   |  119 ++
 tools/testing/selftests/ublk/test_loop_01.sh  |   33 +
 tools/testing/selftests/ublk/test_loop_02.sh  |   24 +
 tools/testing/selftests/ublk/test_null_01.sh  |   19 +
 tools/testing/selftests/ublk/test_null_02.sh  |   23 +
 tools/testing/selftests/ublk/test_null_03.sh  |   21 +
 tools/testing/selftests/ublk/test_null_04.sh  |   21 +
 .../testing/selftests/ublk/test_stripe_01.sh  |   35 +
 .../testing/selftests/ublk/test_stripe_02.sh  |   26 +
 tools/testing/selftests/ublk/ublk_bpf.c       | 1673 +++++++++++++++++
 35 files changed, 5101 insertions(+), 224 deletions(-)
 create mode 100644 drivers/block/ublk/Kconfig
 create mode 100644 drivers/block/ublk/Makefile
 create mode 100644 drivers/block/ublk/bpf.c
 create mode 100644 drivers/block/ublk/bpf.h
 create mode 100644 drivers/block/ublk/bpf_aio.c
 create mode 100644 drivers/block/ublk/bpf_aio.h
 create mode 100644 drivers/block/ublk/bpf_aio_ops.c
 create mode 100644 drivers/block/ublk/bpf_ops.c
 create mode 100644 drivers/block/ublk/bpf_reg.h
 rename drivers/block/{ublk_drv.c => ublk/main.c} (93%)
 create mode 100644 drivers/block/ublk/ublk.h
 create mode 100644 tools/testing/selftests/ublk/.gitignore
 create mode 100644 tools/testing/selftests/ublk/Makefile
 create mode 100644 tools/testing/selftests/ublk/config
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_bpf.h
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_loop.c
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_null.c
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_stripe.c
 create mode 100755 tools/testing/selftests/ublk/test_common.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_02.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_bpf.c

-- 
2.47.0


