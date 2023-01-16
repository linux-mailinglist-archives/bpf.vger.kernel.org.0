Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD766D219
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjAPW6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjAPW6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33F274AE
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673909852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J3mVtpvZzDmkZmwAioBV7odLAUPRl8QYb/xQhJDNdYg=;
        b=ZnQ6it/TAt9k9GcAEQ6ME61IxTlKhtZy2uHBLeqP0FsgECLRSq6lm9lcrQaIViixoJN3vo
        irohg2fv/EMj4RweJcog9cwGOm2nN3VyZ5lqQR1Xlu1ZZDTB6+WXiL7TAWdeatdS2iLkfW
        PjkHB+CmhCDCkruqjdjOzsQ7ox3nHck=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-S90cSdTDNuul0vmNfneAeg-1; Mon, 16 Jan 2023 17:57:31 -0500
X-MC-Unique: S90cSdTDNuul0vmNfneAeg-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020a05640234d200b0048cc3aa4993so19795243edc.7
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3mVtpvZzDmkZmwAioBV7odLAUPRl8QYb/xQhJDNdYg=;
        b=fKvIEa/MwTICTGPQP4zMQWzp6uXUfSD0fuwqdTRsg+8xjECGbMLsN7kJxj5reWp35m
         P2qKQaF1SqmBa0pp6hADXrISljT0usQJf6//awR2O/5fl9rWK3wr6QWhdwEgkPheyUne
         Zbyp+TACJDYjfs5SBpUlvMN7sh7KcKbcPexZq+irmbrH6B54AwlRQQa/TrX2snzSH5bH
         8LcyzPUtPeRvRj7XpayB7WP8WzUhCxwEU0ARSCcBqe8WfBSuQUdxlgz68/YvvcXiFIAM
         AQU9fq9dXPEHUyPefh+tNrAq996TBYGzKhJeWSTSOwWMZQUfumh+wLFpRM7OdufD+1Of
         wIfA==
X-Gm-Message-State: AFqh2krUxxYxwdX/Ioiv2dDq4VoVRzb3kn0wrSIadRTJWvpoxr/nb2xj
        e6MuYz2Dmr2KLMuYU+zTEiwHIG8VC5zSg37BbPWrq8kA49wS3NP0KRJwYZnRoTkIa5xl0EYYSdX
        worBjw8S6iHfE
X-Received: by 2002:a05:6402:1944:b0:49c:1fe4:9f17 with SMTP id f4-20020a056402194400b0049c1fe49f17mr11192263edz.37.1673909849760;
        Mon, 16 Jan 2023 14:57:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXueq5+5h92myedmJM1I7Wod9ZBtMF9VWk3CCHu3Dvgge5Z8zJfhu0KGE87cYoZP1FKCmXZ9vA==
X-Received: by 2002:a05:6402:1944:b0:49c:1fe4:9f17 with SMTP id f4-20020a056402194400b0049c1fe49f17mr11192224edz.37.1673909848905;
        Mon, 16 Jan 2023 14:57:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f4-20020a50ee84000000b00494dcc5047asm11904182edr.22.2023.01.16.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:57:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 88554900FC3; Mon, 16 Jan 2023 23:57:27 +0100 (CET)
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
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH bpf-next] Documentation/bpf: Add a description of "stable kfuncs"
Date:   Mon, 16 Jan 2023 23:57:24 +0100
Message-Id: <20230116225724.377099-1-toke@redhat.com>
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
"stable" in some way. Or we can do both and have multiple levels of "stable",
I suppose.

This patch is an attempt to describe what the "stable kfuncs" idea might look
like, as well as to formulate some criteria for what we mean by "stable", and
describe an explicit deprecation procedure. Feel free to critique any part
of this (including rejecting the notion entirely).

Some people mentioned (in the office hours) that should we decide to go in
this direction, there's some work that needs to be done in libbpf (and
probably the kernel too?) to bring the kfunc developer experience up to par
with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
them discoverable), and having CO-RE support for using them, etc. I kinda
consider that orthogonal to what's described here, but I added a
placeholder reference indicating that this (TBD) functionality exists.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/kfuncs.rst | 79 +++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..c40726c5d3bb 100644
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
@@ -223,14 +223,81 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
-3. Core kfuncs
+
+.. _BPF_kfunc_stability:
+
+3. API stability of kfuncs
+==========================
+
+By default, kfuncs exported to BPF programs are considered a kernel-internal
+interface that can change between kernel versions. This means that BPF programs
+using kfuncs need to adapt to changes between kernel versions; these kfuncs can
+be thought of as being similar to internal kernel API functions exported using
+the ``EXPORT_SYMBOL_GPL`` macro.
+
+The libbpf library contains functionality that can help applications discover
+which kfuncs are available and the CO-RE functionality can be used to handle
+differences in kfunc availability across kernel versions as described in (TBD,
+once this is implemented).
+
+3.1 Stable kfuncs
+-----------------
+
+While kfuncs are by default considered unstable as described above, some kfuncs
+warrant a stronger stability guarantee and are marked as *stable*. The decision
+to move a kfunc to *stable* is taken on a case-by-case basis based on demand for
+a stable interface, and only once a function has proven to be useful in practice
+without any unforeseen API issues.
+
+Stable kfuncs are marked with the ``KF_STABLE`` tag in their definition, and
+provide the following stability guarantees:
+
+1. Stable kfuncs will not change their function signature or functionality in a
+   way that may cause incompatibilities for BPF programs calling the function.
+
+2. The BPF community will make every reasonable effort to keep stable kfuncs
+   around as long as they continue to be useful to real-world BPF applications.
+
+3. Should a stable kfunc turn out to be no longer useful, or otherwise become
+   enough of a maintenance burden that it has to be removed, removal will only
+   happen following the deprecation procedure outlined below.
+
+3.2 Deprecation of kfuncs
+-------------------------
+
+As described above, the community will make every reasonable effort to keep
+kfuncs available through future kernel versions once they are marked as stable.
+However, it may be the case that BPF development moves in a direction where even
+a stable kfunc is no longer useful and/or becomes an unreasonable maintenance
+burden for further development.
+
+In this case, stable kfuncs can be marked as *deprecated* using the
+``KF_DEPRECATED`` tag. This will have the following effect:
+
+1. When using a deprecated kfunc, libbpf will emit a warning that the function
+   will be removed in a future kernel version.
+
+2. Deprecated kfuncs will be kept in the kernel for a minimum of 10 kernel
+   releases after it is first marked as deprecated (corresponding to roughly two
+   years of development time).
+
+3. Deprecated functions will be documented in the kernel docs, including a
+   recommendation for new functionality that can replace the usage of the
+   deprecated function (or an explanation for why no such replacement exists).
+
+4. After the deprecation period, the kfunc will be removed and the function name
+   will be marked as invalid inside the kernel (to ensure that no new kfunc is
+   accidentally introduced with the same name in the future). After this
+   happens, BPF programs calling the kfunc will be refused by the verifier.
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
@@ -306,7 +373,7 @@ Here is an example of it being used:
 		return 0;
 	}
 
-3.2 struct cgroup * kfuncs
+4.2 struct cgroup * kfuncs
 --------------------------
 
 ``struct cgroup *`` objects also have acquire and release functions:
-- 
2.39.0

