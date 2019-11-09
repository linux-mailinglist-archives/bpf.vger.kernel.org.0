Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69CF6181
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 21:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfKIUhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 15:37:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726653AbfKIUhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 15:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573331858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eeh6JgWblBPbPkPYbRyiUwoJp0fyIERwt0uMQrhp3M=;
        b=AWmPmz4/WxhkXSRNaqx4LAa+fhnN5GXGsxAjzOWtZG7vlFktOoTPv6k5p3WUIhaJra5Pgk
        5xtRvbwJzbFIQsAf6laQ2AtrLHIqDC6KVlatidTrtG+AQ3VB/HZ7JwSS3aoh4piEVAP3Q4
        KteGiLAUE7T46KnNNoI7vwOtYs5BqwI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-N9PPpWjANbW_5Ki9KLrqhQ-1; Sat, 09 Nov 2019 15:37:35 -0500
Received: by mail-lj1-f200.google.com with SMTP id v22so396708ljk.22
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 12:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gBaL1gtNlBDHhfBJ4Xqo3UQIQzWjMYYMJE/uEoQa9aA=;
        b=Me5Z6SXHTugoQliUiMzN/G+SJk/48csFFhQzAREM1J5UyaERhSpMPNKBDPHoyWIcUF
         wGPUn2VYgUr85GBTRPoUSRJDtdytJ7Ho6fYyORqbzOZ05IMpszijYMiWE+eSjPaqo/Be
         sV1Ddz2LwmlyxyvNhdwFcArOvoR37fS+wJQdEo/b9/2jO9YnnBxDZnDV5pqlDT+YOfLr
         7EpYr0S2SRvBPaucVzuZBB+W8zpx5ym0FEEg7O/1veK4vgrZy6/PVBA0Agzqv4awbHfU
         8L9Gw0VqGXn1pSu8bYf9wav9nLGTp9jC2dG1BGqWnkKYeG4YCJaKyjW14qG9yNw8nvCz
         caCw==
X-Gm-Message-State: APjAAAVfWkrgAo9H1ytK3eQi7IR9M82+BM3E1d4Cd2HxJ8iOYg+h1r6Q
        ETfJa5B3RS3dtFwSi6WN3fDntLAlzabEws4W8HhC0kpDQDm3nnygylN2aHzlK/O7AEHshZ8lfYo
        F/bJXRm1ZBd7l
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr10988455ljs.26.1573331854227;
        Sat, 09 Nov 2019 12:37:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/iHnTdL75WIrWl8JErX4FiZEpmqYLmzaVeKNqrXl21BGqiNiQLAIMkBmi+gdfly1BMxXd3g==
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr10988445ljs.26.1573331854094;
        Sat, 09 Nov 2019 12:37:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y18sm5547099lja.12.2019.11.09.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 12:37:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C30661800CC; Sat,  9 Nov 2019 21:37:32 +0100 (CET)
Subject: [PATCH bpf-next v4 6/6] libbpf: Add getter for program size
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 21:37:32 +0100
Message-ID: <157333185272.88376.10996937115395724683.stgit@toke.dk>
In-Reply-To: <157333184619.88376.13377736576285554047.stgit@toke.dk>
References: <157333184619.88376.13377736576285554047.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: N9PPpWjANbW_5Ki9KLrqhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

This adds a new getter for the BPF program size (in bytes). This is useful
for a caller that is trying to predict how much memory will be locked by
loading a BPF object into the kernel.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   |    5 +++++
 tools/lib/bpf/libbpf.h   |    3 +++
 tools/lib/bpf/libbpf.map |    1 +
 3 files changed, 9 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 094f5c64611a..70fec4a565af 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4782,6 +4782,11 @@ int bpf_program__fd(const struct bpf_program *prog)
 =09return bpf_program__nth_fd(prog, 0);
 }
=20
+size_t bpf_program__size(const struct bpf_program *prog)
+{
+=09return prog->insns_cnt * sizeof(struct bpf_insn);
+}
+
 int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
 =09=09=09  bpf_program_prep_t prep)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f0947cc949d2..5aa27caad6c2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -214,6 +214,9 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_pro=
gram *prog,
 LIBBPF_API const char *bpf_program__title(const struct bpf_program *prog,
 =09=09=09=09=09  bool needs_copy);
=20
+/* returns program size in bytes */
+LIBBPF_API size_t bpf_program__size(const struct bpf_program *prog);
+
 LIBBPF_API int bpf_program__load(struct bpf_program *prog, char *license,
 =09=09=09=09 __u32 kern_version);
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d1a782a3a58d..9f39ee06b2d4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -203,4 +203,5 @@ LIBBPF_0.0.6 {
 =09=09bpf_program__get_type;
 =09=09bpf_program__is_tracing;
 =09=09bpf_program__set_tracing;
+=09=09bpf_program__size;
 } LIBBPF_0.0.5;

