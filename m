Return-Path: <bpf+bounces-53273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1467A4F473
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6797D7A8129
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39514B976;
	Wed,  5 Mar 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nM1FV1ti"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0A82C60
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140650; cv=none; b=lLsuhk4BLA3O1/4+RbA0J6Do5NfXSLtpJn+dwl3+1JbilDP9EshwBQnNswYpNeXY4BLzrNrYCqv61nG5M7JbURXNlFBuD+qhB5TE27nh/BxEDMcdm+B6W7oeK78/2RJUNKQug+VHHlmk34W9YQ5Ha87rtWIX7qxv2hrD/7Ko/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140650; c=relaxed/simple;
	bh=gpZTsjnjWpVGP+vZ+vClux0DTs2tN9Z3vaFFOYAbAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L29Jnooo53JGyA/SOqimMPU6mLkoQib37tsvIxf4KEZz68uOB8v05LsvtDS7cl0u/gjP5xOGepslwumkLiUGKkg/+Js/DEqKCbEPtnExWUSLcBpc8d2oE1tLXlANlWV0TmJWZ0/unreyb3puWhzGCKJAEYzgx1KxWD+cIY4oUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nM1FV1ti; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e889e77249so50866376d6.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741140647; x=1741745447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+VSDyFiLxLH/aJKksaZNBR/WJOnKk/5qvJcKwKXChk=;
        b=nM1FV1ti0+W47Niu107w9ruLhKICphWvhzRk9gNW1w+WWdVrk9P0V6s2R4pTJMi/OI
         xlGwvFvf1xDooOt8vRPliWnBE4ZbvJHxsb7B0u+8zUq8iWGORjXiU4q3aTgIiW0nG5I0
         N7MufRKYEBEbHiD9VBcSJbNZ1Cz2V/1n9rzKqABaqmVETha9uxmFQvX85LVF3xcerGc9
         zOK3dUW/BRwWVshQA9ijXi4SV29jsJ7dWsf2kRCnp7EMiWy1Mb44Z3i5bQ1cm3Bikwp7
         83VIW0KHpyj6JAZjqrLgMRhk8HQ+ssAOkbFBhjVgLfF5p9Xj8hxQ7J5r/qoom3Qxpf5E
         s0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140647; x=1741745447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+VSDyFiLxLH/aJKksaZNBR/WJOnKk/5qvJcKwKXChk=;
        b=A+BNb3CO+RhWOWu+TbGIiGOk585O5MWDoFed6pF+cAmtSn2470QnEoScR6Rw99LfJo
         URa1VTTpZ/P6CddCfAIRJmWOqZ6DwE1agecXQpdUAS7BpCZ98MGSFd6ZOHuK5/995le0
         ZJ4EkrztvJu1178QoLLo8txZYW2KrRB4tXKha8di6ero8MOB5i83Q1NMyOM4HYe9ZCoy
         1nfEI/kt5cnjFxbNFHhu6RDL7tbCP7MvMovhdCpRYXt6uZlaaHwXgQATm0Q5ITkB+/Wk
         xZjqrtsojlgKV6PnYcnLrWrLV0yQtO4yr5BwGNf7tS/VakWamaN5dUBMn/b0HJX3OHYn
         KIAA==
X-Gm-Message-State: AOJu0Yx+R95C7Kh7UY7VoF0DN24/WMVPvNQCUBq6tNms8g/WPiv/hFz1
	KlFDb5TejQYExJzovMwmxj6a4wd9WTHKtbfcsCJKe1mAl3BYjBD6wpUQ+6a/nttQL8LFYdqopWd
	t5chvcQ==
X-Gm-Gg: ASbGnctPG7LLLcEh8pfUC96G5GECpYYo9IO8NKXNq1zJLJZkHz9xsgyuaA/07BsofqE
	WrKqSQBa5aJ2APWg8jNQRtxiH2QTQVhiw/briWPYAiejwVKQMYt6/TPkg1Uq0QA84TC3yyZLciR
	LGSuACs/0nrf28bn+Fa/v8issIvqWEwmmo25rtb50mJl4c1VWjOTs4CSclbh/V6QDuYaaFbRaiz
	LqysaFvfz8Tb1sS2Im4BoEOjdBipYFtv8I74kw7XmjlvMVIq713jKGp/2RKz05Xs0o/c13LO49w
	xKVhHSPQodA60Z0vS05SMRgO52Nb9RmdGIwVngE89A==
X-Google-Smtp-Source: AGHT+IHHHGryHdxHhP2Vc1lgKRm7+rUHMRNghNeG1xKxWmLZGkBXpfItAeBKOnQFZVVeoHNErcTLqw==
X-Received: by 2002:a05:6214:5e0a:b0:6e8:eabf:fd55 with SMTP id 6a1803df08f44-6e8eac00118mr1714226d6.39.1741140647036;
        Tue, 04 Mar 2025 18:10:47 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm73622826d6.119.2025.03.04.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:10:46 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/2] bpf: introduce helper for populating bpf_cpumask
Date: Tue,  4 Mar 2025 21:10:18 -0500
Message-ID: <20250305021020.1004858-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Changelog :
-----------
v1->v2
v1: https://lore.kernel.org/bpf/20250228003321.1409285-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Add check that the input buffer is aligned to sizeof(long)
	* Adjust input buffer size check to use bitmap_size()
	* Add selftest for checking the bit pattern of the bpf_cpumask
	* Moved all selftests into existing files

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_fill selftests

 kernel/bpf/cpumask.c                          |  27 +++++
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 109 ++++++++++++++++++
 4 files changed, 177 insertions(+)

-- 
2.47.1


