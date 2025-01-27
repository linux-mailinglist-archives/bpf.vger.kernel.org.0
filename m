Return-Path: <bpf+bounces-49857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23041A1D669
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA35164DD9
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA911FF7C2;
	Mon, 27 Jan 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU25kWsT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09651FF5FC
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983637; cv=none; b=GrlbxM4atSk8x4QHR/aaTatjT5i7IRMbXSeSN96ILwHKjjfL68S2KBOIQhKRMgXhCQQFJWo2TAy+3mqyTtXn8/pqOn9svsGK+HsRFe5DYhVtsFZl5NfKZS9FsStJKyntdweBcJ2nTuTpS4/CtygeaCeu65qXSG0Y0ueciLEGzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983637; c=relaxed/simple;
	bh=8OZ7144oa1zhpCyIBB77wB9B4bLPgwKS/BgrajyuRMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQREPGRuzIX6CEPu+NZFvAiozMpZdQwYr27WaLOHIendZAujoKvcvtXz9pVSBvlwY7XLnkwBaGB2HAPKVft4S9dW8cCSHNPRcVRjQkPU/ig1IVwxX4Ar7PkbvbFO7uOKV39Z5ZRUwkwqQ4mt0hsry+X21YanHLZOiMIckUe1hOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XU25kWsT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737983634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwstsfkpYg4IjZDk0+qfOY/IluGTSBwJqLS1TP8vKVY=;
	b=XU25kWsTcwSt/FHrO/sgAHrj+iGkOlprAdj25LrsYr24G4zf0ZkW0iqZltH8pUpC6/VEjU
	J9plo+2hCXrcHbV8G6CAc178xO6omZz9fItds+XUCsk5dMwqf48xqYlPkz3nxpwDLwJJpe
	RDLWgELSKxyyOoEmrgUWbK5GQ0bzhBs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ppIUBQPROB65LxjBxzqzGA-1; Mon, 27 Jan 2025 08:13:51 -0500
X-MC-Unique: ppIUBQPROB65LxjBxzqzGA-1
X-Mimecast-MFC-AGG-ID: ppIUBQPROB65LxjBxzqzGA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8396f65fso430584766b.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983630; x=1738588430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwstsfkpYg4IjZDk0+qfOY/IluGTSBwJqLS1TP8vKVY=;
        b=KVzvGtY5O/ESIvx371+ndl1B1OEIHTxWsieY4y4DXIH5uj8VceldQF2IABgXVBohYM
         l0nJgfkTjmouRkQcZu2pEZZbyZaJsQNQzue+o2Zaa/3eNnBuxwdytDQm3sIDdsteLnwn
         PyybDyMS0qaPmL4QHN/JUi7u9XucN3ujW5OxVSHhcL7XmpA7a8GjoqntUe1jcqUTRrtr
         +5yJp49b1rwnZV0z6PdZiVgzy2a37Icy3M4B82WO9esqNTcsb3DDfSTraoMNlE5CgWEq
         IK5IvMoVCMslUkAE3Z95NLJCcM0X9gYKRLA1I329ByrZPn9GlXowxpqnmReDyn6Pl5O3
         vyUA==
X-Forwarded-Encrypted: i=1; AJvYcCX0fLioaHSTy0xJXIyjqEdfkf9CEQgyZRL6TZTmFLOaAqprKswIFMKYuS1r9j3BlbEaWU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9jd/G0PA0SPCndmkcfhtnQPFqSsYzg7gBgjjse2/I7ifoxyQ
	m7vlxjvqQf5UAgSIJMyhCYy1is7gnk4GwzyqEVWDie4qRivZ1CCjtEMhoPmWbvSzfCwGpH7xtKv
	mPc09OYXIaTdN71lhWC/53GzdC4tMXNze2juSwzQ9SfZkl5JmXw==
X-Gm-Gg: ASbGnctm/JsQFmASxx9jjghEqSp3DPCzhwZp9UO+Abtoniq9N5ZcAUpcfpPIUo+PG5b
	I6ZKznGj0m7l8AwkoLiC9KIYoeiOxLVY81J78lqNM8bfhW6OJb7U8sm1Q1VOplfhzldnTI5IM+d
	UA66co2UdrVUStlIcrkl6WY8mUQQYsHM4e8ibV1QJlK7O42o/rAyx9T1AiL34owvVU/OA5kHH6P
	3SbynN1AZM3jaDaaQYq6S95EjINuCNlpXJmB9BYW+Z1PTsnMPr0TTJqLLs0jGPzr1Ahj8n2t8+F
	yw==
X-Received: by 2002:a17:906:560c:b0:ab6:3aac:de5e with SMTP id a640c23a62f3a-ab63aace8eamr2326937766b.36.1737983630434;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEntOF7lQgLECst1EbclToF8ZfSOkUszcYnSKdNXE1+HyGjA+45oaKOAyk87OgxdvulVnumCg==
X-Received: by 2002:a17:906:560c:b0:ab6:3aac:de5e with SMTP id a640c23a62f3a-ab63aace8eamr2326934666b.36.1737983630063;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18640df4sm5297745a12.48.2025.01.27.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5C0E0180AEB7; Mon, 27 Jan 2025 14:13:48 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 2/2] selftests/net: Add test for loading devbound XDP program in generic mode
Date: Mon, 27 Jan 2025 14:13:43 +0100
Message-ID: <20250127131344.238147-2-toke@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127131344.238147-1-toke@redhat.com>
References: <20250127131344.238147-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test to bpf_offload.py for loading a devbound XDP program in
generic mode, checking that it fails correctly.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/net/bpf_offload.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index d10f420e4ef6..fd0d959914e4 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -215,12 +215,14 @@ def bpftool_map_list_wait(expected=0, n_retry=20, ns=""):
     raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
 
 def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
-                      fail=True, include_stderr=False):
+                      fail=True, include_stderr=False, dev_bind=None):
     args = "prog load %s %s" % (os.path.join(bpf_test_dir, sample), file_name)
     if prog_type is not None:
         args += " type " + prog_type
     if dev is not None:
         args += " dev " + dev
+    elif dev_bind is not None:
+        args += " xdpmeta_dev " + dev_bind
     if len(maps):
         args += " map " + " map ".join(maps)
 
@@ -980,6 +982,16 @@ try:
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound",
+                      dev_bind=sim['ifname'])
+    devbound = bpf_pinned("/sys/fs/bpf/devbound")
+    start_test("Test dev-bound program in generic mode...")
+    ret, _, err = sim.set_xdp(devbound, "generic", fail=False, include_stderr=True)
+    fail(ret == 0, "devbound program in generic mode allowed")
+    check_extack(err, "Can't attach device-bound programs in generic mode.", args)
+    rm("/sys/fs/bpf/devbound")
+    sim.wait_for_flush()
+
     start_test("Test XDP load failure...")
     sim.dfs["dev/bpf_bind_verifier_accept"] = 0
     ret, _, err = bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
-- 
2.48.1


