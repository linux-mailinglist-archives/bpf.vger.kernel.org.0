Return-Path: <bpf+bounces-45479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546F9D6570
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD5FB21BB1
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419DA189F45;
	Fri, 22 Nov 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7aj6uat"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BE8614E;
	Fri, 22 Nov 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311892; cv=none; b=DLHTxkQtywDRYS/ZaeRJWdGTDg6/M0NGZiq1xJjJkCCDXG+ZqWe8Gowx06zc12X25Ohxv9xLtzBuoftWaWl4wAHkqiQNaRCk4tQ/cKClY5Yvnb5SpADq66KDiMxPnaSmvAf3GixfKG2/YcHQaRLVicX8K6jJ/+2fvb0i/azK7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311892; c=relaxed/simple;
	bh=W2IJraOY1P5D/RQG2p6rR44D8M7FvGmIp5qEv45s84E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjenrXGCSaMaZIZEm9TG/o/MXsOQ4fwd6rsizNKOwCz4pnr4SRrs9/dR19WJheO0fb2U+vyiP8udEF5D76QHWj0oOul6skEMvA3FgC/XxVEaqUZWm/eu+VbEyFoGTvUMnaVRVLts6k5rZLrCsS3E4kRkhPeVjAULgUpk0rJ9Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7aj6uat; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so1802708a12.0;
        Fri, 22 Nov 2024 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732311890; x=1732916690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2Vcd8hR14Tv13wsJpKStwfz7Aeop0Fu2RvyIRF3tGQ=;
        b=P7aj6uatqaL+b5JDNImF7dmVDr4vqy8UvwtznhhWFhAvBi9FqCs/ynVcWjdzNp+u4t
         igclQEna7bGmbRyeGrPCu1xA9S/7OsKrRoa2HW3z77lis8Ho2uH9zQYNSKYLgCkQNYXq
         td8E4PIV3Q4fcazu15LXWoPC9XsMST07rD8X1K4NsjD97/66dg8bEv3wi2N3SsisMYvL
         ntlWU8c+mFSRwojcvOQuGWRfbaGFxHCz63Hi4uub+RLLLCqkwsDpYeAFZ8iRYrKydGyr
         92obakyeO7Cbb+QtQLioQphm1Gl2AFTWuBcj2dmX85rrDdpA+BLl0Byk5BBy+p5nUPQS
         1o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732311890; x=1732916690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2Vcd8hR14Tv13wsJpKStwfz7Aeop0Fu2RvyIRF3tGQ=;
        b=X9zNzTPWoem08c9R2zldtmNHsg+DeQzutOyfp3k4/jsrjG4/pHd7hNrZikdXYwF81w
         qcTODNVITsf61ldte5YIpJbztmby2BdjqifZ+Z3bKgGDexAAIDL2T5jYM9ccLeG0KE9s
         bnCaj/zVD+9AZy34ZQRUHCOhSLKVkeNAzQlbKZzoVVYzNLMn2jmvUA0tkl4H8QNT4jm2
         RPy2uzocoGDR1GgXMHLHbppqpDXB05OXo1jo2gpn1oQuJ7VGNk9zTyd+uonarlUqRWy6
         KYOZSGJsJ8pRU5NP3Pd+3qcm/U/Oip3nd0z83Rlxq7GN2gojPEgLC+dgCKW9zoc0x0XJ
         stXQ==
X-Gm-Message-State: AOJu0YzXfqa4PVBQ0DhVBZojzqVOK8gSmmO36i8Q+PzMElg9rOIYNwIW
	esBJYDb5ZIk8S8P2cc03TC00Jdtp41btZenBT7GTQvuHdA3hAiU85s5/GA==
X-Gm-Gg: ASbGnctLkjrEUej9siCBkXv6qlq3tVJ/eiMTjke2NOQSYTXi9TCLGwX3HLGpDEdf1EM
	Dowr4yd0IB8tZlACF2pzbhh45uW8UosPz1tAqb5M3Be6PX+mundhznncW1OQTv9vIJoXUmMG1vg
	TEu8czGFk7Q4f08WOBejirs4gp055LwHHYwr+uMUy1HTWyQTmWASTZLElzU4+zY0XWgLrf7RMbb
	u0Gden6CaV0vJiOB0YB9t/7M36KwunipBztP69QssrlMg==
X-Google-Smtp-Source: AGHT+IHoZKJPOtsFaeJT4SfYqC7J9Ikqb4h2Hsnw7xCdytv05kAOMO08SwRsumIx+393qLHtfxWFYw==
X-Received: by 2002:a05:6a20:2447:b0:1db:e584:a92d with SMTP id adf61e73a8af0-1e09e476099mr5869391637.26.1732311890430;
        Fri, 22 Nov 2024 13:44:50 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfbc69esm1838329a12.6.2024.11.22.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:44:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH dwarves v2 0/1] btf_encoder: handle .BTF_ids section endianness
Date: Fri, 22 Nov 2024 13:44:30 -0800
Message-ID: <20241122214431.292196-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pahole does not generate kfunc declaration tags when
generating BTF for ELF files with an endianness different from the
host system. For example, this issue occurs when processing a vmlinux
built for s390 on an x86 host.

To reproduce the bug:
- follow the instructions in [0] to build an s390 vmlinux;
- generate BTF requesting declaration tags for kfuncs:
  $ pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
           --btf_encode_detached=test.btf vmlinux
- observe that no kfuncs are generated:
  $ bpftool btf dump file test.btf format c | grep __ksym

This patch resolves the issue by adding the necessary byte-swapping
operations.

Changelog:
- v1 [1] -> v2:
  - avoid modifying the 'idlist' Elf_Data object directly.
    Instead, use struct local_elf_data (suggested by Jiri);
  - update the description of the .BTF_ids section (suggested by Jiri).

[0] https://docs.kernel.org/bpf/s390.html
[1] https://lore.kernel.org/dwarves/20241122070218.3832680-1-eddyz87@gmail.com/

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>

Eduard Zingerman (1):
  btf_encoder: handle .BTF_ids section endianness

 btf_encoder.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

-- 
2.47.0


