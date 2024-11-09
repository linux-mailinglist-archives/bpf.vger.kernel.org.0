Return-Path: <bpf+bounces-44440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58B9C2FD6
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ACCB2164C
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F214BF92;
	Sat,  9 Nov 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO+6NHqf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDF143725
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192768; cv=none; b=abYWV1gz6FpP3MwIx+qNVlZ+Obdo6sp1I5vjWZInIlsvh5Xh+4qBrZMvUHmG3iFwsqhJVkdujayDmEyLDey3bUX9w8o1ZgkFY9LMeQ3KFX35eICAjYPbbZrq/ndq0f2qWIKWsSp/Kljp+uJg8KBxlzP5WhnRFgPQzFzaMWYCTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192768; c=relaxed/simple;
	bh=yiCpU0FzdQxdp7SxoXIEDVlZCmqng6CjyDx+Og3AmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hrs72qsB9U8zJ+BWiby2jZSLd6YD4sBelJQAcG+3z7HzNXZ9oChjTa/WXVPOlMEnOdOKywTjFDhHS7NIMNI7/COo56YlW9kt5v3jeZA7HIBglSL9vV3rfPL/6SQfNafLV0/qcLvBPH9R4dv0M4axvs1xvs3RtlE8cTfwQL6wblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO+6NHqf; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4316cce103dso41203175e9.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731192764; x=1731797564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLGQd/JWPr4EZutxVCBFJd68jLgEQFGR/PfHJAwGQQA=;
        b=kO+6NHqf3HdN2QDu9hUcqWwhj80vxip3MkfkY/46twPQXxKmZm2B96zuFJ7+W0FBdF
         DefTM5qUD9qm5ZKFD+Woj8BxjTh/oB1DObPD2HhCgwhPHmyr0b8AAOCzzcWJVSJZEoZY
         zNsZY8SpI8RBSJhvtmJ0DxZFy1MfExKAOiK/NqNiPCDtFGptWdmHMZRU+l1aD5JgSj++
         p9RzNql3vZMl0sDhr9WoOhIz8+Tm/ZAjWMbQRhyc0o7iXulLgPwumVaDL4XNrJXC+lV7
         Y7U66PbX2D86RolWwpNUqc2qtGy/x+gr04RkG1FDZibgdyJlsfjjiU2PCFMGVYwiZGHE
         sRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731192764; x=1731797564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLGQd/JWPr4EZutxVCBFJd68jLgEQFGR/PfHJAwGQQA=;
        b=N/YO56OhLFtxFGy7uiyamvZTZB+JJ3XJeNdc27wjLs5VRXZNKDuEC3rNDgH7EVyD3V
         VVkFsusC8S5NcXxomAS8pKLYk4Ge7uAV0SzeCidUSsy1Q6yKytajwyiaCKoaDmJDLsS1
         NMrkUr5LkoxXVv2f/RozqZqHJJQf0hxDwQGfVqw30KwedK1m0HMj84qgTjjOPhJCsw2n
         rxyXXkro7K2nHcpSElb2hgjRdpv9sETqxih0oamJd0j7b9pm6Wq/tigN/udNgg0vGLuu
         L+GWD8nQ/F0I2Kk4pXGtIbV3bBimiK1L0ThDt89ZWPtTHfZ7J+gZP3dVSi71r1zbCTWp
         CeBQ==
X-Gm-Message-State: AOJu0Yw8Eh9X/QL1kCl8VowcBD02g/M01krdgPPtNngseTbFs1XJ8oe2
	3hoilud0Ed0dDTiYbGlgk4sDTnCHIC2Alxe1J3bw+s/oMYLcltY1vqjbCJoNizI=
X-Google-Smtp-Source: AGHT+IGf7o1wYn1RnfmKD7BQARuEoT4Z1GextaVvb0wlpiIJOBIdDdpZa4QUdV/gO9myKp5uPwsElA==
X-Received: by 2002:a05:600c:154c:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-432b750acb9mr70302805e9.15.1731192764302;
        Sat, 09 Nov 2024 14:52:44 -0800 (PST)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm119432205e9.25.2024.11.09.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 14:52:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 0/2] Refactor lock management
Date: Sat,  9 Nov 2024 14:52:41 -0800
Message-ID: <20241109225243.2306756-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; h=from:subject; bh=yiCpU0FzdQxdp7SxoXIEDVlZCmqng6CjyDx+Og3AmQ8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnL+eaiirPY/10mudm9PrRcFSsXgMvwU6M5MWcqjoG 0JtkuO2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy/nmgAKCRBM4MiGSL8RyvBrD/ 4qufrvc8yLsna90WwaVzJ1tbIWCKCFumCeaMLEm93itb3pxsXf2YwKscQHlYUY/qo8q20oSjKy9Sb5 /+CkhLdewP+bFzeMZfb5x1X2MFTegfR5bDElI0ABzcvJyucR07db1G3FkviGpVCj2nLPji2Brw3y0+ eD1ZIYfuf4xCbzhj2mJ5AzYLnjOZxfKpozEfv+TADPLZkFIK1GH0Uouds53aGmXGcrzr4iVAsIUhBz uEoXletjUtlGQ2J7iicXyzgknU8FPdUzRRdUoj0UpJwYK5TqNtUSMjP5+6UKyjkX0LHW2eLpHjpvoJ HkceexBmYax/CSA+5C6PwbP1gZRBiYNB5pAo25VEBWewOCJm+F61U3LLaZ4PdR677tMwGXqMRiC46j HWsxSzWWL3T/dY87W0copQJ4d1dS/+I6gqjKZ3p/yE5XE2ObOQ0xtFS7BKW/W7BFGONDYPoq2it7io ANsHLLGdKuOxZ/E3/+xcD++vhMeoYkf8kDj5Ba4D9wqN9Ju/GANp2GSJbI0L8oIurE2DTdqgtrKII0 5hef3UKeI7Mb5OgBb3Xxmjz6kyuRmAnH2FOMwAT5+QCLmY14Axu8rsAEKmvcm1Zzm08wZivmXVA3OT P5cYcuCyncsurJtJVjsfNzJYG3OifwV/wqeD/LEUJlNW9PR6K1zgtKTX2ACQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set refactors lock management in the verifier in preparation for
spin locks that can be acquired multiple times. In addition to this,
unnecessary code special case reference leak logic for callbacks is also
dropped, that is no longer necessary. See patches for details.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20241109074347.1434011-1-memxor@gmail.com

 * Make active_locks part of bpf_func_state (Alexei)
 * Remove unneeded in_callback_fn logic for references

v3 -> v4
v3: https://lore.kernel.org/bpf/20241104151716.2079893-1-memxor@gmail.com

* Address comments from Alexei
  * Drop struct bpf_active_lock definition
  * Name enum type, expand definition to multiple lines
  * s/REF_TYPE_BPF_LOCK/REF_TYPE_LOCK/g
  * Change active_lock type to int
  * Fix type of 'type' in acquire_lock_state
  * Filter by taking type explicitly in find_lock_state
  * WARN for default case in refsafe switch statement

v2 -> v3
v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.com

  * Rebase on bpf-next to resolve merge conflict

v1 -> v2
v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.com

  * Fix refsafe state comparison to check callback_ref and ptr separately.

Kumar Kartikeya Dwivedi (2):
  bpf: Refactor active lock management
  bpf: Drop special callback reference handling

 include/linux/bpf_verifier.h                  |  40 ++---
 kernel/bpf/verifier.c                         | 168 ++++++++++++------
 .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
 3 files changed, 126 insertions(+), 86 deletions(-)


base-commit: 163ea3dec3c8048618f561a2c3b30f4c5795e991
-- 
2.43.5


