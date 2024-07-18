Return-Path: <bpf+bounces-35002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C29934E28
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA631C22048
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C713DB92;
	Thu, 18 Jul 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS0atrfh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A653746E
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309276; cv=none; b=URSSvxJsklgidoQecBAg8o1GjKnlLqUwzN1GHfyBuvNu68JH7i6IhJwsUqnDXmIJ7HXdAVo6zrOnT170GAL8gnY6WFCOnTFVNhIMcFDrqmJMFkljPQWgDN/yZjvLD62CK5u+syPF7dSg29N2YGhhNUAr8eg0Ih1oox1neZn0ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309276; c=relaxed/simple;
	bh=hmpnVOMMCq/A6I2LZwBt/DJ1YsRe79Rqc6YK6NMNcrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nybY7sTRd2iKjIKnZViZ7YbSwTH6+fr29nA20BQ1KIG12rxZ/A0GwDog8cGQ2RqPUFDQvJo4T0lYNGZMqOf7ysK9MSeKk23P8xGvfwtQwkpPkUwDl7q/GZNrl3xdOfmDy5pgBmqxQlN1aN3wnGOFgj5BXCoGK7YdnouPq5h439c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS0atrfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F298C4AF0A;
	Thu, 18 Jul 2024 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309276;
	bh=hmpnVOMMCq/A6I2LZwBt/DJ1YsRe79Rqc6YK6NMNcrU=;
	h=From:To:Cc:Subject:Date:From;
	b=kS0atrfhSAznhNyA+vtg+Y75EjGNuJ/jL3qOV2xJntqFyzmoR4ivx6hl+R3xWUejc
	 RjvUvCVDOdLBGXVrcUdUMF9v7v2HSZvJlQsC/a1aaJQxLYH9PkaI5Kvvi1nX+V7/LP
	 UpiTY/YX4Kg/PTFwcyuvmAgy0/wqXcHez+P+xDUnbLVk5UoRvhxdysCE3BzaG68XTl
	 5A3rdijlNgWq1STwurRM3AUsLk99A5ObX8fFFV4Lm6uahbWnSeQeecmkFCRblK5ca8
	 rdKTufHzRSfoMVDEqR14i4chd9HX54vFeK03OEust0QsaSylGRe5682wNJYDaBP1jg
	 45sN6O/SaVqwQ==
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
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
Date: Thu, 18 Jul 2024 15:27:48 +0200
Message-ID: <20240718132750.2914808-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding more uprobe multi tests for failed attachments
inside the uprobe register code.

v2 changes:
  - addressed review comments [Andrii]
  - added new test

thanks,
jirka


---
Jiri Olsa (2):
      selftests/bpf: Add uprobe fail tests for uprobe multi
      selftests/bpf: Add uprobe multi consumers test

 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 318 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c |  39 ++++++++++++
 2 files changed, 357 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c

