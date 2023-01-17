Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D791B670D67
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAQX2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 18:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjAQX16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 18:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1905896E
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 13:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673990859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BxWZSbIETD+Gj2frl8QIczIRAzvpXAb2SHtV3qVw/JU=;
        b=MWEK2Sp45+2cIPIIaHs/Cbed34sZWIQDtr6VoPYQKuDJEGHq95HZGmu+akiT/aof0bPJtt
        j7dZPCuVW5ClMSMan0yJjK/qjSircF/9Vx5u8vPS8zydmtU63rHQ4ur8bccwaog3vZbyCh
        VRmXreYpiEcyPP7ItBIqKi0AGVkGcLQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-V8GHnDjoP5e36-CJGN3_fw-1; Tue, 17 Jan 2023 16:27:38 -0500
X-MC-Unique: V8GHnDjoP5e36-CJGN3_fw-1
Received: by mail-ej1-f69.google.com with SMTP id qw29-20020a1709066a1d00b008725a1034caso2532180ejc.22
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 13:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxWZSbIETD+Gj2frl8QIczIRAzvpXAb2SHtV3qVw/JU=;
        b=iHHpAkkBFXmIaDkRjYRw2q6sk3HB3n0I/pgtwRCRZxqxn+gqfW3M/2H+5WoWiY3eji
         JWOwQ5q8/pI8no0xfu4cBsYi1zvgU9tOOTLx61kGuoRbTXk5CpJpu/Lf6y2RUbyII37t
         26QbOoZc/KSJrKmQOqm/sHGj3IsqdueQpwJa/sM2Qcx7roK5QiZ1eguqIMI/ERCfmn2G
         o0rhqKyDZbA4xGS1TesS0DzLHhOZQEPhgHKIBEdKhiujuIq+0SR6LPLrOr93fcuZ23xm
         YwwCyxMKBhr1Ash93ntoarwrIpJInbdfrpfpv9lSlmeRP3w6SDtgnuW/7ul/5h7u4J96
         xHrQ==
X-Gm-Message-State: AFqh2krtlJyexqXxeTDmEtIqhP6J8JR6AKqM3aemF/QKh1QIWMdoRv+x
        ykizhk1iV2KQwj1GI+lE5kDnAg5JApaPl2PhloVJxfEyXv93uuzQYTOt08xlnp0r+1MZ0DFd8EX
        Vyi9gAYgy9c9c
X-Received: by 2002:a17:907:1c08:b0:86f:de0b:b066 with SMTP id nc8-20020a1709071c0800b0086fde0bb066mr496118ejc.76.1673990856018;
        Tue, 17 Jan 2023 13:27:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQpy6vFapYVNfd7aLkLk7TuZSTz4HnTmtO9Yg0cWf0pxFnH+n+0r76gkCuWJjdFQmGd1EZjA==
X-Received: by 2002:a17:907:1c08:b0:86f:de0b:b066 with SMTP id nc8-20020a1709071c0800b0086fde0bb066mr496026ejc.76.1673990853882;
        Tue, 17 Jan 2023 13:27:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b0084cc87c03ebsm13552281ejh.110.2023.01.17.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:27:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8E186901190; Tue, 17 Jan 2023 22:27:32 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf@vger.kernel.org, David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
Date:   Tue, 17 Jan 2023 22:27:31 +0100
Message-Id: <20230117212731.442859-1-toke@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following up on the discussion at the BPF office hours, this patch adds a
description of the (new) concept of "stable kfuncs", which are kfuncs that
offer a "more stable" interface than what we have now, but is still not
part of UAPI.

This is mostly meant as a straw man proposal to focus discussions around
stability guarantees. From the discussion, it seemed clear that there were
at least some people (myself included) who felt that there needs to be some
way to export functionality that we consider "stable" (in the sense of
"applications can rely on its continuing existence").

One option is to keep BPF helpers as the stable interface and implement
some technical solution for moving functionality from kfuncs to helpers
once it has stood the test of time and we're comfortable committing to it
as a stable API. Another is to freeze the helper definitions, and instead
use kfuncs for this purpose as well, by marking a subset of them as
"stable" in some way. Or we can do both and have multiple levels of
"stable", I suppose.

This patch is an attempt to describe what the "stable kfuncs" idea might
look like, as well as to formulate some criteria for what we mean by
"stable", and describe an explicit deprecation procedure. Feel free to
critique any part of this (including rejecting the notion entirely).

Some people mentioned (in the office hours) that should we decide to go in
this direction, there's some work that needs to be done in libbpf (and
probably the kernel too?) to bring the kfunc developer experience up to par
with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
them discoverable), and having CO-RE support for using them, etc. I kinda
consider that orthogonal to what's described here, but I do think we should
fix those issues before implementing the procedures described here.

v2:
- Incorporate Daniel's changes

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..dd40a4ee35f2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
 
 BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
 kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
-kfuncs do not have a stable interface and can change from one kernel release to
-another. Hence, BPF programs need to be updated in response to changes in the
-kernel.
+kfuncs by default do not have a stable interface and can change from one kernel
+release to another. Hence, BPF programs may need to be updated in response to
+changes in the kernel. See :ref:`BPF_kfunc_stability`.
 
 2. Defining a kfunc
 ===================
@@ -223,14 +223,89 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
-3. Core kfuncs
+
+.. _BPF_kfunc_stability:
+
+3. API (in)stability of kfuncs
+==============================
+
+By default, kfuncs exported to BPF programs are considered a kernel-internal
+interface that can change between kernel versions. This means that BPF programs
+using kfuncs may need to adapt to changes between kernel versions. In the
+extreme case that could also include removal of a kfunc. In other words, kfuncs
+are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought of as
+being similar to internal kernel API functions exported using the
+``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
+initially start out as kfuncs.
+
+3.1 Promotion to "stable" kfuncs
+--------------------------------
+
+While kfuncs are by default considered unstable as described above, some kfuncs
+may warrant a stronger stability guarantee and can be marked as *stable*. The
+decision to move a kfunc to *stable* is taken on a case-by-case basis and must
+clear a high bar, taking into account the functions' usefulness under
+longer-term production deployment without any unforeseen API issues or
+limitations. In general, it is not expected that every kfunc will turn into a
+stable one - think of it as an exception rather than the norm.
+
+Those kfuncs which have been promoted to stable are then marked using the
+``KF_STABLE`` tag. The process for requesting a kfunc be marked as stable
+consists of submitting a patch to the bpf@vger.kernel.org mailing list adding
+the ``KF_STABLE`` tag to that kfunc's definition. The patch description must
+include the rationale for why the kfunc should be promoted to stable, including
+references to existing production uses, etc. The patch will be considered the
+same was as any other patch, and ultimately the decision on whether a kfunc
+should be promoted to stable is taken by the BPF maintainers.
+
+Stable kfuncs provide the following stability guarantees:
+
+1. Stable kfuncs will not change their function signature or functionality in a
+   way that may cause incompatibilities for BPF programs calling the function.
+
+2. The BPF community will make every reasonable effort to keep stable kfuncs
+   around as long as they continue to be useful to real-world BPF applications.
+
+3. Should a stable kfunc turn out to be no longer useful, the BPF community may
+   decide to eventually remove it. In this case, before being removed that kfunc
+   will go through a deprecation procedure as outlined below.
+
+3.2 Deprecation of kfuncs
+-------------------------
+
+As described above, the community will make every reasonable effort to keep
+kfuncs available through future kernel versions once they are marked as stable.
+However, it may happen case that BPF development moves in an unforeseen
+direction so that even a stable kfunc ceases to be useful for program
+development.
+
+In this case, stable kfuncs can be marked as *deprecated* using the
+``KF_DEPRECATED`` tag. Such a deprecation request cannot be arbitrary and must
+explain why a given stable kfunc should be deprecated. Once a kfunc is marked as
+deprecated, the following procedure will be followed for removal:
+
+1. A kfunc marked as deprecated will be kept in the kernel for a conservatively
+   chosen period of time after it was first marked as deprecated (usually
+   corresponding to a span of multiple years).
+
+2. Deprecated functions will be documented in the kernel docs along with their
+   remaining lifespan and including a recommendation for new functionality that
+   can replace the usage of the deprecated function (or an explanation for why
+   no such replacement exists).
+
+3. After the deprecation period, the kfunc will be removed and the function name
+   will be marked as invalid inside the kernel (to ensure that no new kfunc is
+   accidentally introduced with the same name in the future). After this
+   happens, BPF programs calling the kfunc will be rejected by the verifier.
+
+4. Core kfuncs
 ==============
 
 The BPF subsystem provides a number of "core" kfuncs that are potentially
 applicable to a wide variety of different possible use cases and programs.
 Those kfuncs are documented here.
 
-3.1 struct task_struct * kfuncs
+4.1 struct task_struct * kfuncs
 -------------------------------
 
 There are a number of kfuncs that allow ``struct task_struct *`` objects to be
@@ -306,7 +381,7 @@ Here is an example of it being used:
 		return 0;
 	}
 
-3.2 struct cgroup * kfuncs
+4.2 struct cgroup * kfuncs
 --------------------------
 
 ``struct cgroup *`` objects also have acquire and release functions:
-- 
2.39.0

