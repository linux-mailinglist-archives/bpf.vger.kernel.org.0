Return-Path: <bpf+bounces-45952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C5A9E0D48
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 21:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9695D282DBC
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC081DEFE7;
	Mon,  2 Dec 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO/neEPO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA81DED6A
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172369; cv=none; b=ceyhlwVti7yLvccdgp41GN36XQtXD31CVcBNmPbWmmHxQccaxu8d4iTJUxlgLk415dPqOA4JHjYdr2VhguIUbzFYWebCWOakw43yVrx9pPshK3KvQNYl39WiUlXenTXRh3WUh+A/450e5B46QibCfPl52S4qAOuFtoGpaQGZ/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172369; c=relaxed/simple;
	bh=7w5jtlMySZQoS+zMq475MlmmQftq+ycbDtwSTI+LilA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z0ksJIvOmxY92SvJ2jy64al5eHcDbI4egHX3Z58aBeV5lIAVqPg0efLPEmcwz3dPBjA+lzSJMrY/PvglpG6Z3angGfdtUx+OgTuIsd3ybDGz7dN81n8wcQZ57E3EXBJCt08yfxUBltojJhsMoN6YwrvSakuDmYVrWpbwgrOTifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--leogrande.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO/neEPO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--leogrande.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee6df32602so2783041a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733172367; x=1733777167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++YWSthJPN+yl8B4rg8mre41jdfYSO6YhO5ASg1YrDo=;
        b=IO/neEPO5XnN1QXJuN8fK3ssgNK8HbVLczId8D2R+ZDo3JJP4yya1UGwXF87m0/YuE
         HxqAnE4F+y8YgJFtqq4llptfrEoeZEwfWQZziiozNRVkauVGHu6HX+qReOTuaj56KcQ9
         nmYVvis28hRaCF9+HzDaEFGhSt/pf6JQ+yBxH4tsTkgeo3mvQjQib9DKl5eHbpy4hWBs
         OU0MESMhgBzu9eAwWzSrdCzpP7B3Hbt3SAEbRKVk4bhZdCRigdbpU57/WzocHKSKNnSu
         Tx1kU6+tniCNbkFsVuItf3KSpbKt4z2DYFd74ORTEK1pDwpWS5MUGfm44O93agE0Xcat
         2dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172367; x=1733777167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++YWSthJPN+yl8B4rg8mre41jdfYSO6YhO5ASg1YrDo=;
        b=MluwBr+1/60NMQSP77wcoBWDESmK0s06Q25kPLDw1KD8eGZoXOxNJh/1CAvLVCJ7jc
         i4gA8j18LautweMM4RXvvcjOwnyT9vyQsAN39UN+xa7PtwTuNa9oWAt2ymOs8zGMtTch
         okcOvL5ehTmVtmpFYQEocuD+IdIwNfY7k9tigwzMLAl421t3n0zMq9n8gZTVo/O+mnNl
         rTwSjderBOjD6EUwPA9MmCkTAkKVYOV+p+gz/zhuFAcfvj13tsH9mswc1NjpBYbd733V
         KTn1++UfggSJJwyW8ozEywIZML/dfFicceNK4HUNUZOn9e2goiofEBAAnrgy/WsZ6ZfI
         DuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFLzGNrB7fJe1SmkqBXeQFrbS+wlYn4GWdnXtUPd4S94QqnnhrnAHzAhUowA4x7V6SLEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYgJPB1lO2TXxXKEEK/+mWFIutnYJJztLavdmnQJB1E8bMeyh
	pR/uvDCXfpGXvapQtQk64sDnPPmeN12g3J6A5drPTEL0WbwqXNQGel0UUGP452YtQBCRMCSBcQG
	ZLGESo6anc5Rr+g==
X-Google-Smtp-Source: AGHT+IHi3CKqhjk1y4/ah/p9hu+6bIeHbWyM875rhMinItzIxmg3+i5QKD66Ne7FIqUVR0zKYvLu23a38o+QpG0=
X-Received: from pjbsz16.prod.google.com ([2002:a17:90b:2d50:b0:2e2:44f2:9175])
 (user=leogrande job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d11:b0:2ee:8008:b583 with SMTP id 98e67ed59e1d1-2ee8008b80bmr17580578a91.16.1733172366857;
 Mon, 02 Dec 2024 12:46:06 -0800 (PST)
Date: Mon,  2 Dec 2024 12:45:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202204530.1143448-1-leogrande@google.com>
Subject: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix
 wait for server bind
From: Marco Leogrande <leogrande@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc: willemb@google.com, zhuyifei@google.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Leogrande <leogrande@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit f803bcf9208a ("selftests/bpf: Prevent client connect before
server bind in test_tc_tunnel.sh") added code that waits for the
netcat server to start before the netcat client attempts to connect to
it. However, not all calls to 'server_listen' were guarded.

This patch adds the existing 'wait_for_port' guard after the remaining
call to 'server_listen'.

Fixes: f803bcf9208a ("selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh")
Signed-off-by: Marco Leogrande <leogrande@google.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7989ec6084545..cb55a908bb0d7 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -305,6 +305,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # serverside, use BPF for decap
-- 
2.47.0.338.g60cca15819-goog


