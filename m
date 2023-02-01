Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D7686D53
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBARqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBARqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C007D6FC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675273503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UnFcxjROyyHWCwIAZDqaqY0Iq1ZK0gA+pssv8VO2Ju0=;
        b=KRuQx1xBPs0cB3T/XC/qf2wBuxHeWFUOJjgiuvlUaMry04IcRdMK0dqwm5akxkZho5zhht
        vAxIZrmhgM5pD2DZP6wGlT1ss1i1qzpqiBJiYfG4cHVwS0IplAWxLqcsGOc7ybq7P7EuKU
        ak49Rk8IFnaOJxw69MRnyq46WCHz3vE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-zodIXWu_Mz6GejikfMLJRQ-1; Wed, 01 Feb 2023 12:45:02 -0500
X-MC-Unique: zodIXWu_Mz6GejikfMLJRQ-1
Received: by mail-ej1-f72.google.com with SMTP id sa8-20020a170906eda800b0087875c99e6bso11947361ejb.22
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 09:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnFcxjROyyHWCwIAZDqaqY0Iq1ZK0gA+pssv8VO2Ju0=;
        b=SdkN2ygzfpPcpui+BTEReN/DgyvygSnMhb0B4bMAz/SyK5VOBGYQ/TsRcum7K/hTJm
         ZL52jSoZTs9nhWi8Cz+wCSWJxA+PoSMD8g45OmBqFmcElLGnPmvQFambxN6mgEWHK7+s
         SANLUIxXw+MqOqGbVpVfQqe4ENQhJKXw59EtW3SVdI7g5t/Goaww0UBJ38i5W2/MH1Ck
         o3U7xsCq7Uh9GctA3hiqxwEysFhYGl7y+RPxgmzVKvr/DS4SiJgaDKWDiDH5m7QCA3wO
         NCAWO202/BWjUqpJd2dKIX3SXLLzCkgLmPzpKtDDUEGnrKKunUxnE3Z6JuxXnbhtQYIX
         uQMw==
X-Gm-Message-State: AO0yUKXzVnJv9BwnZyidMrThdBzop4XxUDbYL5tJIBAVJCJImPuMiYN5
        Fw1FcrMLtUdTEu+lg/WRjxhN7Fm1OGDKfn9d8O39NpWTBGNiX6mA2HkmJq5nYEmVq+MknE5QxtN
        YUhsMv5Fbx4WM
X-Received: by 2002:a17:906:1659:b0:88c:bc3e:de46 with SMTP id n25-20020a170906165900b0088cbc3ede46mr3304018ejd.34.1675273500885;
        Wed, 01 Feb 2023 09:45:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/KqtE6h4GRwWHZNEK6grwN4jouLe6UUuMNIiP529laS3s+okzhvFXzgQVyOXgAcfolsg1HGw==
X-Received: by 2002:a17:906:1659:b0:88c:bc3e:de46 with SMTP id n25-20020a170906165900b0088cbc3ede46mr3303991ejd.34.1675273500533;
        Wed, 01 Feb 2023 09:45:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id os25-20020a170906af7900b008874c903ec5sm5763744ejb.43.2023.02.01.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:45:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ED1E69729EC; Wed,  1 Feb 2023 18:44:58 +0100 (CET)
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
Cc:     David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v3] Documentation/bpf: Document API stability expectations for kfuncs
Date:   Wed,  1 Feb 2023 18:44:48 +0100
Message-Id: <20230201174449.94650-1-toke@redhat.com>
X-Mailer: git-send-email 2.39.1
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

Following up on the discussion at the BPF office hours (and subsequent
discussion), this patch adds a description of API stability expectations
for kfuncs. The goal here is to manage user expectations about what kind of
stability can be expected for kfuncs exposed by the kernel.

Since the traditional BPF helpers are basically considered frozen at this
point, kfuncs will be the way all new functionality will be exposed to BPF
going forward. This makes it important to document their stability
guarantees, especially since the perception up until now has been that
kfuncs should always be considered "unstable" in the sense of "may go away
or change at any time". Which in turn makes some users reluctant to use
them because they don't want to rely on functionality that may be removed
in future kernel versions.

This patch adds a section to the kfuncs documentation outlining how we as a
community think about kfunc stability. The description is a bit vague and
wishy-washy at times, but since there does not seem to be consensus to
commit to any kind of hard stability guarantees at this point, I feat this
is the best we can do.

I put this topic on the agenda again for tomorrow's office hours, but
wanted to send this out ahead of time, to give people a chance to read it
and think about whether it makes sense or if there's a better approach.

Previous discussion:
https://lore.kernel.org/r/20230117212731.442859-1-toke@redhat.com

v3:
- Drop the KF_STABLE tag and instead try to describe kfunc stability
  expectations in general terms. Keep the notion of deprecated kfuncs.
v2:
- Incorporate Daniel's changes

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/kfuncs.rst | 88 +++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..6885a64ce0ff 100644
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
@@ -223,14 +223,90 @@ type. An example is shown below::
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
+``EXPORT_SYMBOL_GPL`` macro.
+
+While kfuncs are similar to internal kernel API functions, they differ in that
+most consumers of kfuncs (i.e., BPF programs) are not part of the kernel source
+tree. This means that callers of a kfunc cannot generally be changed at the same
+time as the kfunc itself, which is otherwise standard practice in the kernel
+tree. For this reason, the BPF community has to strike a balance between being
+able to move the kernel forward without being locked into a rigid exported API,
+and avoiding breaking BPF consumers of the functions. This is a technical
+trade-off that will be judged on a case-by-case basis. The following points are
+an attempt to capture the things that will be taken into account when making a
+decision on whether to change or remove a kfunc:
+
+1. When a patch adding a new kfunc is merged into the kernel tree, that will
+   make the kfunc available to a wider audience than during its development,
+   subjecting it to additional scrutiny. This may reveal limitations in the API
+   that was not apparent during development. As such, a newly added kfunc may
+   change in the period immediately after it was first merged into the kernel.
+
+2. The BPF community will make every reasonable effort to keep kfuncs around as
+   long as they continue to be useful to real-world BPF applications, and don't
+   have any unforeseen API issues or limitations.
+
+3. Should the need arise to change a kfunc that is still in active use by BPF
+   applications, that kfunc will go through a deprecation procedure as outlined
+   below.
+
+The procedural description above is deliberately vague, as the decision on
+whether to change it will ultimately be a judgement call made by the BPF
+maintainers. However, feedback from users of a kfunc is an important input to
+this decision, as it helps maintainers determine to what extent a given kfunc is
+in use. For this reason, the BPF community encourages users to provide such
+feedback (including pointing out problems with a given kfunc).
+
+In addition to the guidelines outlined above, the kernel subsystems exposing
+functionality via kfuncs may have their own guidelines. These will be documented
+by that subsystem as part of the documentation of the functionality exposed to
+BPF.
+
+3.1 Deprecation of kfuncs
+-------------------------
+
+As described above, the community will make every reasonable effort to keep
+useful kfuncs available through future kernel versions. However, it may happen
+that the kernel development moves in a direction so that the API exposed by a
+given kfunc becomes a barrier to further development.
+
+A kfunc that is slated for removal can be marked as *deprecated* using the
+``KF_DEPRECATED`` tag. Once a kfunc is marked as deprecated, the following
+procedure will be followed for removal:
+
+1. A deprecated kfunc will be kept in the kernel for a period of time after it
+   was first marked as deprecated. This time period will be chosen on a
+   case-by-case basis, based on how widespread the use of the kfunc is, how long
+   it has been in the kernel, and how hard it is to move to alternatives.
+
+2. Deprecated functions will be documented in the kernel docs along with their
+   remaining lifespan and including a recommendation for new functionality that
+   can replace the usage of the deprecated function (or an explanation for why
+   no such replacement exists).
+
+3. After the deprecation period, the kfunc will be removed. After this happens,
+   BPF programs calling the kfunc will be rejected by the verifier.
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
@@ -306,7 +382,7 @@ Here is an example of it being used:
 		return 0;
 	}
 
-3.2 struct cgroup * kfuncs
+4.2 struct cgroup * kfuncs
 --------------------------
 
 ``struct cgroup *`` objects also have acquire and release functions:
-- 
2.39.1

