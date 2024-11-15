Return-Path: <bpf+bounces-44906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AE9CD4BA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC372828D4
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E523E3A1BF;
	Fri, 15 Nov 2024 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="M0vQzEIq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BB1DFFD
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631395; cv=none; b=ATWnDqa/0IeIgiMKFzRlK8I2vWBTD7x91QfGTpkU9gwr8vPXuN2PlwJvdfapFtWJwrt7DG4rDpbVHAxoNQAQ9P7kL4PsLmd9LcyihlNFFGHIHWJYgqQ4poQ5XbTogAmk/1kMLsUFhrAtavQD2W5+G5WePf2mrg9fR5tZn9laHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631395; c=relaxed/simple;
	bh=9hwNcQ/l8thVwk78y3YnSdR3MPCyIfhclKv5mSjhUes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFwExTSIgtIl+019hpkZyUAWSnGwvFfyrvNq9w2N453EVW57DLnrghYBbgQeiq+GyzmnfP6VstM/xAQEOw/12vHtXorTJv4r546kUurRlybQNXwLKB48B2LZ+GbLZD59Xo14LX+kXljHKx8ttJ0abui+Jy8qe098LjRhOJppFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=M0vQzEIq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314f38d274so13644265e9.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731631391; x=1732236191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UH1ZsiyHYpawr5oqbFRVKhiuH3bQhE1Dj6RrkfqPLU=;
        b=M0vQzEIqPQPcUbMFI3tzym/2M6GnxxLZmVg3kMe+trkXBv9sZzeQLSJL97bNW+UhD5
         pO+u35jHJWV54hHgDBi8rGYhM6jyslMR/0PcRvIjNY8uMdwr8mOtrGDAhu182MDeUtdh
         upvdDBCYH1wc8BFBU+AV9MckIaFrmjGz0RzDJLnm5/nJShsRrNW5TG8AF2vQrhKXwyAq
         XL8wM7yp73purx5723gV7V2MgGnQN6eXQu9Cyt5Lm+4k/f7qISh22E9pbyMRsOSZR1lR
         FD9IPoUgW/MJhNqNOO4X2qFmIE2g31yEWWwJcdJj8o2/x0NVH1B65rGpe6q3Swy3bH6V
         ELkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631391; x=1732236191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UH1ZsiyHYpawr5oqbFRVKhiuH3bQhE1Dj6RrkfqPLU=;
        b=W5LIoTr8tHf9sDNtY0SkkUIkwPeVCqgw6BTEuPz+UUrFGhLtgG63VNgR9sL3T/LQtT
         zhRBi/+Fj0chy1HzpTivt2t+g5HPdrZFhD32l/kKNap6h4IcYVs+VoUU2Djw75/pAZw6
         wdZDeRIxbzneAwOsuR9QmCshtIMzx1VbW6PHMReGSdXtgVqlNvXKIy42rqfHF5zCwHVe
         btCoAjDKMWIL3ATx5Li247J4NGsJ0/O8P9tM+nDQOF9X4ow8tHHiLAoz4TrI+KgSVX7w
         EGCj9vM9bYdvpIgFQZaoQtayyq+no8XJzE5Q6psRsfUsbQYayIn4B81gVgDrVT+FovIz
         7XTA==
X-Gm-Message-State: AOJu0YyaeuNcIz6Yk4eQ+6d+D75SncX8BP8c5sSqO/MTJZNKjSRoVfI/
	sDrEuCx/JCFsp/Tsdos3kQhg7aWPTAV5mrUt8omGptTyadNAKV7Zo7EpjSZAEm2SPiNjl7tSspG
	0VM8=
X-Google-Smtp-Source: AGHT+IGeaX+eRpcNUBMmygANmowpA8MEFKMSp0qLvIW2IxnZTJn/KjBZ1Gn8kkWd/reuIxXYRLAsmA==
X-Received: by 2002:a05:600c:34ce:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-432df680b18mr6372065e9.0.1731631390835;
        Thu, 14 Nov 2024 16:43:10 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm36781975e9.12.2024.11.14.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:43:10 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 0/5] Add fd_array_cnt attribute for BPF_PROG_LOAD
Date: Fri, 15 Nov 2024 00:46:02 +0000
Message-Id: <20241115004607.3144806-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
new attribute is non-zero, then the fd_array is considered to be a
continuous array of the fd_array_cnt length and to contain only
proper map file descriptors, or btf file descriptors, or zeroes.

This change allows maps, which aren't referenced directly by a BPF
program, to be bound to the program _and_ also to be present during
the program verification (so BPF_PROG_BIND_MAP is not enough for this
use case).

The primary reason for this change is that it is a prerequisite for
adding "instruction set" maps, which are both non-referenced by the
program and must be present during the program verification.

The first three commits add the new functionality, the fourth adds
corresponding self-tests, and the last one is a small additional fix.

Anton Protopopov (5):
  bpf: add a __btf_get_by_fd helper
  bpf: move map/prog compatibility checks
  bpf: add fd_array_cnt attribute for prog_load
  selftests/bpf: Add tests for fd_array_cnt
  bpf: fix potential error return

 include/linux/btf.h                           |  13 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              |  13 +-
 kernel/bpf/core.c                             |   9 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         | 204 ++++++----
 tools/include/uapi/linux/bpf.h                |  10 +
 .../selftests/bpf/prog_tests/fd_array.c       | 374 ++++++++++++++++++
 8 files changed, 557 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

-- 
2.34.1


