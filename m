Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A621467E03
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353354AbhLCTWN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:22:13 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43885 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhLCTWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:13 -0500
Received: by mail-wr1-f41.google.com with SMTP id v11so7674544wrw.10;
        Fri, 03 Dec 2021 11:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KHxIUD5Ri3UfWfOOeIflcqc5lfKcQ9rateqQdRDovU=;
        b=he8d3JX7QLGb20zAzhn7TQOOu75x6/42t/2XFR5Sya2hKN7dD4NEGhGD7Yu3HdQzVV
         jR8BFhbVxB6zw9Xzy2OQNOU8858uspphuJnaH6d3j3Hv7AyK5MIf/ja6uGSwXEZ9Anbx
         hhGhSQpIsROlETumReFUrfLNESlxIwPXEX5hK7grGNaUHSZ1BgM8nlbK65sAuEbfendF
         pnH8TrqGIa8PPP6jBBdhKDJzlgVvJBr+sbiXEg4XHAz3V2zIaZ1xYtsXVU6a5VmATdRY
         nomzQ9Fi+jOhmtPfpeIgyRfe7SIb+7HXhmXLhDD+RlODv+paaDEpix9WSzLwu3+cpu0J
         kJ6g==
X-Gm-Message-State: AOAM5302EZGUAgf1aviihDa79LwoWqnxGYwIDMDGcRyOT5BhaC1wtL1s
        NwhS+ilSUvJeSBYtlGmvDPqdVDe2XA/7IQ==
X-Google-Smtp-Source: ABdhPJw8lpV5j8xbV+wIGMFudjroFhtVkgHT/Y3lC+FMQQOo9XKN9yUwy2YHpJUyXmkWD993uKcQqA==
X-Received: by 2002:a5d:59a2:: with SMTP id p2mr23800415wrr.252.1638559127619;
        Fri, 03 Dec 2021 11:18:47 -0800 (PST)
Received: from t490s.teknoraver.net (net-37-117-189-149.cust.vodafonedsl.it. [37.117.189.149])
        by smtp.gmail.com with ESMTPSA id z14sm3472374wrp.70.2021.12.03.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:18:47 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf: add signature
Date:   Fri,  3 Dec 2021 20:18:41 +0100
Message-Id: <20211203191844.69709-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This series add signature verification for BPF files.
The first patch implements the signature validation in the kernel,
the second patch optionally makes the signature mandatory,
the third adds signature generation to bpftool.

This only works with CO-RE programs.

Matteo Croce (3):
  bpf: add signature to eBPF instructions
  bpf: add option to require BPF signature
  bpftool: add signature in skeleton

 crypto/asymmetric_keys/asymmetric_type.c |   1 +
 crypto/asymmetric_keys/pkcs7_verify.c    |   7 +-
 include/linux/verification.h             |   1 +
 include/uapi/linux/bpf.h                 |   2 +
 kernel/bpf/Kconfig                       |  14 ++
 kernel/bpf/syscall.c                     |  51 +++++-
 tools/bpf/bpftool/Makefile               |  14 +-
 tools/bpf/bpftool/gen.c                  |  33 ++++
 tools/bpf/bpftool/main.c                 |  28 +++
 tools/bpf/bpftool/main.h                 |   7 +
 tools/bpf/bpftool/sign.c                 | 218 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h           |   2 +
 tools/lib/bpf/skel_internal.h            |   4 +
 13 files changed, 372 insertions(+), 10 deletions(-)
 create mode 100644 tools/bpf/bpftool/sign.c

-- 
2.33.1

