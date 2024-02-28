Return-Path: <bpf+bounces-22849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F986AAD5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CDFB27756
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244D2E85D;
	Wed, 28 Feb 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEDzthni"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93B2E84B
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110969; cv=none; b=f9hQeiVV5fKCyvAsstuLNXfegt4pyIRGXpPgmpcTxefq62lSXhc27gafSeRayp12zLuWxJQXEY7HOCt6gdWh4hMaO7UcR76S/OmJ0tOktsxa2mIlbGXuVAbDK/rz9Nrzetk+aXPLmi12Uy0enFky+lTJtUWlxtCoI0gDssndRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110969; c=relaxed/simple;
	bh=vMA528+ZoLu0AhNGUmhxkS+c/uHxdd3mNN51rhW2MAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxpCogpufic/FEIZlLeHhQhlBpY+nYDsttCq387pbgmtYe9JKyQPVSpouz6fshAiJSOkc27nBV+cEp1VCqSXPQyW+pBWF8YWxIEg3Is+mGWDzesNlpUYPpR//j/+nqB9zL6n1dxHHoSfrQICkB1Hxx8ORg9w0HdDunvwQIXb2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEDzthni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF0C433C7;
	Wed, 28 Feb 2024 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110968;
	bh=vMA528+ZoLu0AhNGUmhxkS+c/uHxdd3mNN51rhW2MAU=;
	h=From:To:Cc:Subject:Date:From;
	b=uEDzthnihbLh3VoR3X4k0nPDn86lUbJvu63ZuPrq78dU/E/OUPV/I5naDJSKRIJxG
	 8ZRJqUMaesDKLEScKowpr5fpmnpwIYzw6z+h94UFCUZ0EFEYu7MHiVDSD1c0wTp73l
	 QrNs0dbj8FApKRkZ4pEPoLuYK5ZxYqG/Cmzp5KHjcZhYJBJ0yThWsiMIGgwh4ecQes
	 8KKNluK3YqxzzxcaWeYOrDnkXoQ2dGahz1YLefSfqrkUPanQxbnrtn13XNkF779oSg
	 1tvROA0Zjgv5PSktE5Mr6mM/3gcsSFOdQ/dz31Ikxv/ch3wwiG+M5jC4f6wc9mgZig
	 RHwpk/tjA0LaQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFCv2 bpf-next 0/4] bpf: Introduce kprobe multi wrapper attach
Date: Wed, 28 Feb 2024 10:02:38 +0100
Message-ID: <20240228090242.4040210-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding support to attach both entry and return bpf program on single
kprobe multi link. The first RFC patchset is in [0].

Having entry together with return probe for given function is common
use case for tetragon, bpftrace and most likely for others.

At the moment if we want both entry and return probe to execute bpf
program we need to create two (entry and return probe) links. The link
for return probe creates extra entry probe to setup the return probe.
The extra entry probe execution could be omitted if we had a way to
use just single link for both entry and exit probe.

In addition it's possible to control the execution of the return probe
with the return value of the entry bpf program. If the entry program
returns 0 the return probe is installed and executed, otherwise it's
skip.

v2 changes:
  - adding 'kprobe.wrapper' program that is called both for entry and
    exit probe [Andrii]
  - I kept the interface that adds new flag in attr.link_create.kprobe_multi.flags,
    because I don't see it breaking backward compatibility and it's much simpler
    than new attach type, I tried to discuss this in [1], but I'm ok to change
    that if it turns out to be a problem

thanks,
jirka


[0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
[1] https://lore.kernel.org/bpf/ZdhmKQ1_vpCJTS_U@krava/
---
Jiri Olsa (4):
      bpf: Add support for kprobe multi wrapper attach
      bpf: Add bpf_kprobe_multi_is_return kfunc
      libbpf: Add support for kprobe multi wrapper attach
      selftests/bpf: Add kprobe multi wrapper test

 include/uapi/linux/bpf.h                                   |   3 ++-
 kernel/bpf/btf.c                                           |   3 +++
 kernel/trace/bpf_trace.c                                   |  71 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h                             |   3 ++-
 tools/lib/bpf/libbpf.c                                     |  38 ++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf.h                                     |   4 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h                   |   2 ++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  49 ++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 259 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c

