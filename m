Return-Path: <bpf+bounces-36138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36527942CEF
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E450B28B1F4
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9E1B0122;
	Wed, 31 Jul 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5dxRfUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79911B0110
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424123; cv=none; b=A5WJNyQDpzssMT991LgT6oAMWDT2ZKibrbeqSwIDYaAxjgCfQuLVkt3ZMnPZ2hio6z58WvZ53KA3u/DGM+59KHEV2sX4kUitHJhMzKPHP7CZHFV3opVoic2cwj4jRfSspUcePx2r/FNppbvtUDIvd0Wr5orZxzG/LTuOBrjnv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424123; c=relaxed/simple;
	bh=bHcIp/RWXMZulfuXjX1cIB7FcxFbBj96swtDAL2L0FU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R3wmtC6Wy36U8cZJ8tea+A7z/BB7MNyCbyfK0HXEHUDKf6OYU5i5XKLjEKKtgSmVTfVwiseloAwtBKOHQ3ee9A1dJJfxd/pYvlxR1UXSvDhIrskA+ebyV/iNLXjOjyTu4gHyBFk9zv0qcSC5RVyIYlfF3I01xim4TKlJ2KyL18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5dxRfUt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7ab81eea72so483530766b.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722424120; x=1723028920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfLQlsHgObJ3zjZ94VMUpiBu/ZKf1Bowg3k2SwDzaks=;
        b=X5dxRfUtuA1u2izsb+2NK0KzTx2r+Fx19R0lg+FxcP9PEgqouzcmwd26NTA7RhTNb8
         PILoUeVRcUKHqRIgn/7axtrBSWryfFwT/waeL2pV9iOGl6kvepqoLJcPP//PSSoEcaAn
         A0hF2szc8d4v3YUeseIpprws3iTriz8xLkKKDbymw28kZnXx9La2nntLpEQFpU950id8
         0eyC1q2Md0klg3pZ9124WImMK4nkFvvo534M8JcxMvoTuB5Eq51PASpktd+XfQ9eMCGB
         EEdtizEYTZsShoYxUR00J8M769V0DdWue/q0GKLYK5X6osIZgFdJ01vi26UD0ePKmssg
         RXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424120; x=1723028920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfLQlsHgObJ3zjZ94VMUpiBu/ZKf1Bowg3k2SwDzaks=;
        b=YBKHUMfHTdmZ5Qc1TYfqTW6suIL/qV5zfryh0vYMAtPZr3ULNJ1nmAxRjxEhIt3GAc
         AJc7xSUcjr+7XNCB0v6jd39zRgdpx0aq02mQ3hCNOQbpiRgm72bRyqhmVg+8Xlr+PJrQ
         TtjPVttWEPS1BskElGFW62W5tC2LTiIJhjv5XSumRU5DfCBwmVYYz+whlC3wUwi/XovG
         oZVElRJKyQwQUMVAHzyDU5OOKnbTb2jmOEDtl9p8OuBCkI/PFCiIqgcdP6zEyo7+uc4G
         7j9fJMA1wuh86wnUOV58F5SpTsdfaJyxmrLI8q4MieU9k6rqDB52se5tbVtN67ZHMh7v
         G6mg==
X-Gm-Message-State: AOJu0YyiIWX7Nh5ElVes1sIVF+PKUPx4LG8mCnyO+duH/CxJAjfz3QK3
	IYXvJL60HWMmt2ypf027Y9KLo/9umOqdB/dKDVFKOVNrC/aiWkwarMkJ8J8jSMLMjbJxOiDeNoA
	nTLc2sweVQthS80ankxdH1C47w+vqDDqilvhUO04fQjFL7skPqZkyuM9NYv9zJRW28gohmngVhe
	icKFiJg/JVbhQgons+mCEtiTHqhb3kdL0FjOL67omLBXtC1VhIrpIexcsjCXRdAfuZHw==
X-Google-Smtp-Source: AGHT+IEM1M+K8r/qQKjGewx/AmQ6X+wh5vqszxa61hdrMv2xQNIKs/CYfNL8FNbj8LmCKQ64nCQNxa3OReYaSg4vR94i
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:28da:b0:a7a:b423:47b9 with
 SMTP id a640c23a62f3a-a7d400e537dmr1079266b.8.1722424119031; Wed, 31 Jul 2024
 04:08:39 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:08:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731110833.1834742-1-mattbobrowski@google.com>
Subject: [PATCH v4 bpf-next 0/3] bpf: introduce new VFS based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

G'day!

A respin based off v3, which can be found here [0]. Original
motivations for introducing this suite of BPF kfuncs can be found here
[1].

The primary difference in this version of the patch series is that the
suite of VFS related BPF kfuncs added can be used from both sleepable
and non-sleepable BPF LSM program types. IOW, the KF_SLEEPABLE
annotation has been removed from all of them.

Changes sinve v3:

* KF_SLEEPABLE annotation has been dropped from all newly introduced
  VFS related BPF kfuncs. This includes bpf_get_task_exe_file(),
  bpf_put_file(), and bpf_path_d_path(). Both negative and positive
  selftests backing these new BPF kfuncs have also been updated
  accordingly.

* buf__sz conditional in bpf_path_d_path() has been updated from
  buf__sz <= 0, to !buf__sz.

* Syntax issues as reported so here [2] have been corrected.

[0] https://lore.kernel.org/bpf/20240726085604.2369469-1-mattbobrowski@google.com/
[1] https://lore.kernel.org/bpf/cover.1708377880.git.mattbobrowski@google.com/#t
[2] https://netdev.bots.linux.dev/static/nipa/874023/13742510/checkpatch/stdout

Matt Bobrowski (3):
  bpf: introduce new VFS based BPF kfuncs
  selftests/bpf: add negative tests for new VFS based BPF kfuncs
  selftests/bpf: add positive tests for new VFS based BPF kfuncs

 fs/Makefile                                   |   1 +
 fs/bpf_fs_kfuncs.c                            | 127 ++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/verifier_vfs_accept.c |  85 +++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 161 ++++++++++++++++++
 6 files changed, 404 insertions(+)
 create mode 100644 fs/bpf_fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

-- 
2.46.0.rc2.264.g509ed76dc8-goog


