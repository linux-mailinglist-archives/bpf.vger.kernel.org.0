Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD8242D59
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLQdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLQdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 12:33:16 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256BC061383;
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id n25so1415180vsq.6;
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDTyV119vCkCoWtmcsmBHI9G6VZxWyQB9uqnHQ2UEJo=;
        b=Vbtr8kGXGoATutEkcauLlj8wpopiSgewlJiCnFNmllZgiFeLIV2gSoiiPuNtUbJUWs
         9zhl5OjiBVYwtPL/auDGkI1ifUarolnLedFEruL2MKKiWMRCtC4Cl+pVPzhv9OaaHf0U
         PsYbuoIdYN7kNukoa+qmqIY1/dTJD2bFJmnMBm1YbCcFTw9Kt67e817nIO0v4H3KtpmH
         L2wG5YXlE/ChVHOGD/CqbAMt2FDAsUzeqqMDfnJEj9Wc6tCGdyXGCuXl6hT/LOzONOl/
         16bij7yHbGrNTy/10fZrODQq33mi7q8KDNvE0emieu/C7yDC+h8JrbYnC0xLBiXEVfSV
         DlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDTyV119vCkCoWtmcsmBHI9G6VZxWyQB9uqnHQ2UEJo=;
        b=VmdHD/u60rGyuW1dvazj47dM7eUWI693Lbqork7ovFFQcQsx7Eq4L1QXvPw13faF81
         9mHThOow/IeiJK6HIvm2XqSst5Qh//Iw6d2O5afBVee6/4YSyhOTzl6mtdMMwawy7AnZ
         Ot9UOx8l3mf/aYz1J/VKTcYhGKmsvgTi8lDnERAmz5tsfD90DriAeSnJ1Uy6dlFIO9Jn
         Zqldv5hzeu3SHewA817DigH03mecahWE0EjGc0snaqRgDLRaCaRU2D4iG+GoTttTVPR8
         v5LnMe+6c9EPJH3p04FRMNCz1Wcpey4nNqkBemadRQ4oMsDRVIaWTCSERfEqNk6Bb+mN
         G3+Q==
X-Gm-Message-State: AOAM530+TMyZH3x6p5zXIwtL0QgL4bX8NskpayvUk7su0dr5/4W6Qj0v
        iWgYyrUQy5jK1U8ejCxTDUQ5nvp5e7s=
X-Google-Smtp-Source: ABdhPJxxpEhGeCxWTxJu/t9gT6QxtVYdd5SCor+PxYJ70G9ZOZfNjuUMd58E6M7m9Rs8jNeFrsZFUQ==
X-Received: by 2002:a05:6102:311a:: with SMTP id e26mr951620vsh.86.1597249994748;
        Wed, 12 Aug 2020 09:33:14 -0700 (PDT)
Received: from ebpf-cloudtop.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.googlemail.com with ESMTPSA id e8sm245374uar.11.2020.08.12.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:33:14 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     bpf@vger.kernel.org, linux-block@vger.kernel.org
Cc:     leah.rumancik@gmail.com, orbekk@google.com, harshads@google.com,
        jasiu@google.com, saranyamohan@google.com, tytso@google.com,
        bvanassche@google.com
Subject: [RFC PATCH 0/4] block/bpf: add eBPF based block layer IO filtering
Date:   Wed, 12 Aug 2020 16:33:01 +0000
Message-Id: <20200812163305.545447-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series adds support for a new security mechanism to filter IO
in the block layer. With this patch series, the policy for IO filtering
can be programmed into an eBPF program which gets attached to the struct
gendisk. The filter can either drop or allow IO requests. It cannot modify
requests. We do not support splitting of IOs, and we do not support
filtering of IOs that bypass submit_bio (such as SG_IO, NVMe passthrough).
At Google, we use IO filtering to prevent accidental modification of data.

To facilitate this functionality, a new eBPF program type,
BPF_PROG_TYPE_IO_FILTER, and an associated attach type, BPF_BIO_SUBMIT,
have been added. The IO filter programs are invoked in submit_bio’s
make_generic_requests_check() which checks the program’s return value to
determine if the IO should be dropped or allowed. The program type can
also be used to monitor IO if the return value is always set to allow IO.

An example of an eBPF program to filter IO is provided below:

SEC("io_filter")
int run_filter(struct bpf_io_request *io_req)
{
	if ( <condition to block io> )
		return IO_BLOCK;
	else
		return IO_ALLOW;
}

This patchset was created as part of a summer internship project.

Leah Rumancik (4):
  bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
  bpf: add protect_gpt sample program
  bpf: add eBPF IO filter documentation
  bpf: add BPF_PROG_TYPE_LSM to bpftool name array

 Documentation/block/bpf_io_filter.rst         |  28 +++
 Documentation/block/index.rst                 |   1 +
 block/Makefile                                |   1 +
 block/blk-bpf-io-filter.c                     | 209 ++++++++++++++++++
 block/blk-bpf-io-filter.h                     |  16 ++
 block/blk-core.c                              |   6 +
 block/genhd.c                                 |   3 +
 include/linux/bpf_io_filter.h                 |  23 ++
 include/linux/bpf_types.h                     |   4 +
 include/linux/genhd.h                         |   4 +
 include/uapi/linux/bpf.h                      |  11 +
 init/Kconfig                                  |   8 +
 kernel/bpf/syscall.c                          |   9 +
 kernel/bpf/verifier.c                         |   1 +
 samples/bpf/Makefile                          |   3 +
 samples/bpf/protect_gpt_kern.c                |  21 ++
 samples/bpf/protect_gpt_user.c                | 133 +++++++++++
 tools/bpf/bpftool/feature.c                   |   2 +
 tools/bpf/bpftool/main.h                      |   3 +
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        |   2 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |   5 +
 23 files changed, 505 insertions(+)
 create mode 100644 Documentation/block/bpf_io_filter.rst
 create mode 100644 block/blk-bpf-io-filter.c
 create mode 100644 block/blk-bpf-io-filter.h
 create mode 100644 include/linux/bpf_io_filter.h
 create mode 100644 samples/bpf/protect_gpt_kern.c
 create mode 100644 samples/bpf/protect_gpt_user.c

-- 
2.28.0.236.gb10cc79966-goog

