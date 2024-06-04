Return-Path: <bpf+bounces-31287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0E8FA9F1
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34FCB21979
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 05:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340813D897;
	Tue,  4 Jun 2024 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoIyvbkS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4013D608
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478610; cv=none; b=Xyy2gpGBU664m+FbtCpB47e76Kg+JY80Dp9zQa8KwIHjq1Lg3lU6WhrmXiCImFlDji+RcdJnr4qqTurJLBVB5MgO56ZMBJTRqjiV/XkuBB1Noj2S3w+M1IqiiXUg9f+c9LDEPOrlxq0hAFVElVGwtEpBRKAtvvPbva8BOfA0dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478610; c=relaxed/simple;
	bh=FZLzx58oEA7aCRE0PqDQHU9jv6LLC1li8S6wXsTvBuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TI6EP2+XDe/KQcfGXZVNuC4FsWlW+QT08uuN91qsy4z+r0tBJ9ypRsWJLIh8ndYmgUYW9YiLgo38p41m/Cd02V+OcePpdOLbCuPvsZmSXLwsI53d06kmpMomL3PQlsJubpeGzPLAniQmMB4/3+QjEPjVQKAG0jPuGPEP4/GxbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoIyvbkS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfa7faffa6cso3751977276.0
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717478607; x=1718083407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P/Xbhgh0bHbjneKg22PQyKkApBBqCGUUHo3j1iPzT8=;
        b=QoIyvbkSUcq4+Vo2YMjdnXY9M1D3hKOLT2VGwZBeqm5tV/sj3SQTX8Iw+I9zYnu9pe
         DMSXj1R06364nGskwtvXzXvEq8vpw1oINz5KJ52QTtVe7zph0nJgjMro8I6KsddG/DgN
         Hio9mVDXx/c9H6bMpp9WNTnLj3YzDwv9i7rH9OAusfjZg52PPHdPaWtc4M58yxC+iSHJ
         KLb2PcqbpmzZozjAO0iWXufMkuD6F04mJHr+530CB+guR6GWvHwqkAYuCK0omIgBX3Xu
         bnVffoos3iawJhjLAuynZU1v1IM+CViYq+3yO0ZM69g5EDsRcPpz9piBm1JSrlWMY3uk
         tLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717478607; x=1718083407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P/Xbhgh0bHbjneKg22PQyKkApBBqCGUUHo3j1iPzT8=;
        b=npsg6udP3wjbNiWaOKIoJiKoNa2TML+6OiisxUOHcfhfABIF8PYw1UdwIJ0pBjSpsI
         +EZYD66Rj76trKEpZLZjM1baGs8lZD4iLesAaiAz51iguHEDBRHDIurDGg55KRcPf7lC
         rGT5bVBWYHYkVfAeKVKPj+pXxYdBqKnVGXMWH+hmKHwZV8RaWwRmcYXXxAEPM4Kn5HHF
         eIHE20BudwgAJ7/SnYhIlOrUMjLwadJsvgI0RpTIRC/ViMVD5GatV92oLyzQ1bk2jSlX
         +eZI7nSY62Pq+IRZyAybru0yLKnjx2f1fa4b1Nn7Lmgn1WgJadl7fM6qzqomUPmm1EAQ
         Bw0w==
X-Gm-Message-State: AOJu0Yx++VdjoAy9OR01hfB1WhI/6qHL2Za9gVznag2sR/HXhttK1UMb
	ynK/q3ONVaVasj8Qpg8PDreFWuCecDonV5VwTJfsypBUpaY0O1FwuUwVicBz
X-Google-Smtp-Source: AGHT+IFQFuBVqwlEN0pbhBHBZNRRdr1VEQ7LFSzsGuRevxc0Rgb/5luoUpZtQvKsp9gt80Ezz9TuAw==
X-Received: by 2002:a25:2ca:0:b0:de6:1534:e0ec with SMTP id 3f1490d57ef6-dfa73bf26f5mr11206049276.13.1717478607190;
        Mon, 03 Jun 2024 22:23:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a496sm5303785a12.73.2024.06.03.22.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:23:26 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <Tony.Ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH bpf v2 0/2] bpf: Fix linker optimization removing kfuncs
Date: Mon,  3 Jun 2024 22:23:14 -0700
Message-Id: <cover.1717477560.git.Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717413886.git.Tony.Ambardar@gmail.com>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes unwanted stripping of kernel kfuncs during linker
optimization, as indicated by build warnings from resolve_btfids e.g.
"WARN: resolve_btfids: unresolved symbol ...". This can happen because the
__bpf_kfunc macro annotating kfunc declarations is ignored during linking.

Patch 1 adds support for the compiler attribute "__retain__", used to
avoid linker garbage cleanup. Patch 2 then updates __bpf_kfunc to use this
attribute when LTO builds are enabled.

Build-tested locally against mips64el with gcc 13.3, and run through
upstream kernel-patches/bpf CI.

Tony Ambardar (2):
  compiler_types.h: Define __retain for __attribute__((__retain__))
  bpf: Harden __bpf_kfunc tag against linker kfunc removal

 include/linux/btf.h            |  2 +-
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 

v2:
- move __retain macro to compiler_types.h (Miguel Ojeda)

-- 
2.34.1


