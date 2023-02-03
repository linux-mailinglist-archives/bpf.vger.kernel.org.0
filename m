Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A416689E97
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjBCP5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 10:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjBCP5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 10:57:37 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0719DEFA;
        Fri,  3 Feb 2023 07:57:35 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id f10so5934299qtv.1;
        Fri, 03 Feb 2023 07:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv2k/rSbHNVGfMMcn2oKVVjf/AEeRivvmMaZfagE7QY=;
        b=3idchrVQZPJKcsS5KdwljaE3Kz9GPTfFSVT/isbOQjpsg4XZ3R4vIy3+VACtpm817T
         dqwm+cWsUxKjhJ5wjo8ePzLQ7SDwCNv6N/1Fsz+Jnpal7ADZOEWor8CPgX3HxZQ+H4XD
         6nF2i9Jq8Es17jRFFk+o8A4k/r7APZXjHlnKCfgyKGoSNfFlweODM65sGpXyhY4sqwSt
         C1QXJigp3Ck7OxvpxHG2u7+k7p8pg0eDj9HgWLOWIgLkdsVd0ZWCNO/+SY+zX2SmVRx+
         orPx92cDTXH5rK9jG29JjDDL8IUuH7+KWKjEeOZIJQf3+CHsfnT7WgRavzIIBAVR9Est
         2Yog==
X-Gm-Message-State: AO0yUKW490q4ful+u4IkvuK5imTn0YzkcGCpSwXyxZHdL/PtKHK9TSOJ
        gkXhWtrHBJZUMnRCKFZ28d4T8QbaTu3R3Oil
X-Google-Smtp-Source: AK7set+TkYYQ2uF4s2UMt4bQMO5GUjDGa+8QUtgV1ctB+C3OF1g+GHEE4/+vqIpMtSLa2YDatJq6FA==
X-Received: by 2002:ac8:4e52:0:b0:3b8:543f:63d1 with SMTP id e18-20020ac84e52000000b003b8543f63d1mr18465925qtw.31.1675439854399;
        Fri, 03 Feb 2023 07:57:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:dd5a])
        by smtp.gmail.com with ESMTPSA id bk19-20020a05620a1a1300b006f9f3c0c63csm2082551qkb.32.2023.02.03.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:57:33 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, brouer@redhat.com, bagasdotme@gmail.com,
        linux-api@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle / stability expectations
Date:   Fri,  3 Feb 2023 09:57:27 -0600
Message-Id: <20230203155727.793518-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203155727.793518-1-void@manifault.com>
References: <20230203155727.793518-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF kernel <-> kernel API stability has been discussed at length over
the last several weeks and months. Now that we've largely aligned over
kfuncs being the way forward, and BPF helpers being considered
functionally frozen, it's time to document the expectations for kfunc
lifecycles and stability so that everyone (BPF users, kfunc developers,
and maintainers) are all aligned, and have a crystal-clear understanding
of the expectations surrounding kfuncs.

To do that, this patch adds that documentation to the main kfuncs
documentation page via a new 'kfunc lifecycle expectations' section. The
patch describes how decisions are made in the kernel regarding whether
to include, keep, deprecate, or change / remove a kfunc. As described
very overtly in the patch itself, but likely worth highlighting here:

"kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
development elsewhere in the kernel".

Rather, the intention and expectation is for kfuncs to be treated like
EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
safe and valuable option for maintainers and kfunc developers to extend
the kernel, without tying anyone's hands, or imposing any kind of
restrictions on maintainers in the same way that UAPI changes do.

In addition to the 'kfunc lifecycle expectations' section, this patch
also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
authors or maintainers can choose to add to kfuncs if and when they
decide to deprecate them. Note that as described in the patch itself, a
kfunc need not be deprecated before being changed or removed -- this
flag is simply provided as an available deprecation mechanism for those
that want to provide a deprecation story / timeline to their users.
When necessary, kfuncs may be changed or removed to accommodate changes
elsewhere in the kernel without any deprecation at all.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 125 +++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0bd07b39c2a4..7c2ca350f07c 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -13,7 +13,7 @@ BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
 kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
 kfuncs do not have a stable interface and can change from one kernel release to
 another. Hence, BPF programs need to be updated in response to changes in the
-kernel.
+kernel. See :ref:`BPF_kfunc_lifecycle_expectations` for more information.
 
 2. Defining a kfunc
 ===================
@@ -238,6 +238,28 @@ single argument which must be a trusted argument or a MEM_RCU pointer.
 The argument may have reference count of 0 and the kfunc must take this
 into consideration.
 
+.. _KF_deprecated_flag:
+
+2.4.9 KF_DEPRECATED flag
+------------------------
+
+The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
+changed or removed in a subsequent kernel release. A kfunc that is
+marked with KF_DEPRECATED should also have any relevant information
+captured in its kernel doc. Such information typically includes the
+kfunc's expected remaining lifespan, a recommendation for new
+functionality that can replace it if any is available, and possibly a
+rationale for why it is being removed.
+
+Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
+supported and have its KF_DEPRECATED flag removed, it is likely to be far more
+difficult to remove a KF_DEPRECATED flag after it's been added than it is to
+prevent it from being added in the first place. As described in
+:ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfuncs are
+encouraged to make their use-cases known as early as possible, and participate
+in upstream discussions regarding whether to keep, change, deprecate, or remove
+those kfuncs if and when such discussions occur.
+
 2.5 Registering the kfuncs
 --------------------------
 
@@ -304,14 +326,107 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
-3. Core kfuncs
+.. _BPF_kfunc_lifecycle_expectations:
+
+3. kfunc lifecycle expectations
+===============================
+
+kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
+strict stability restrictions associated with kernel <-> user UAPIs. This means
+they can be thought of as similar to EXPORT_SYMBOL_GPL, and can therefore be
+modified or removed by a maintainer of the subsystem they're defined in when
+it's deemed necessary.
+
+Like any other change to the kernel, maintainers will not change or remove a
+kfunc without having a reasonable justification.  Whether or not they'll choose
+to change a kfunc will ultimately depend on a variety of factors, such as how
+widely used the kfunc is, how long the kfunc has been in the kernel, whether an
+alternative kfunc exists, what the norm is in terms of stability for the
+subsystem in question, and of course what the technical cost is of continuing
+to support the kfunc.
+
+There are several implications of this:
+
+a) kfuncs that are widely used or have been in the kernel for a long time will
+   be more difficult to justify being changed or removed by a maintainer. In
+   other words, kfuncs that are known to have a lot of users and provide
+   significant value provide stronger incentives for maintainers to invest the
+   time and complexity in supporting them. It is therefore important for
+   developers that are using kfuncs in their BPF programs to communicate and
+   explain how and why those kfuncs are being used, and to participate in
+   discussions regarding those kfuncs when they occur upstream.
+
+b) Unlike regular kernel symbols marked with EXPORT_SYMBOL_GPL, BPF programs
+   that call kfuncs are generally not part of the kernel tree. This means that
+   refactoring cannot typically change callers in-place when a kfunc changes,
+   as is done for e.g. an upstreamed driver being updated in place when a
+   kernel symbol is changed.
+
+   Unlike with regular kernel symbols, this is expected behavior for BPF
+   symbols, and out-of-tree BPF programs that use kfuncs should be considered
+   relevant to discussions and decisions around modifying and removing those
+   kfuncs. The BPF community will take an active role in participating in
+   upstream discussions when necessary to ensure that the perspectives of such
+   users are taken into account.
+
+c) A kfunc will never have any hard stability guarantees. BPF APIs cannot and
+   will not ever hard-block a change in the kernel purely for stability
+   reasons. That being said, kfuncs are features that are meant to solve
+   problems and provide value to users. The decision of whether to change or
+   remove a kfunc is a multivariate technical decision that is made on a
+   case-by-case basis, and which is informed by data points such as those
+   mentioned above. It is expected that a kfunc being removed or changed with
+   no warning will not be a common occurrence or take place without sound
+   justification, but it is a possibility that must be accepted if one is to
+   use kfuncs.
+
+3.1 kfunc deprecation
+---------------------
+
+As described above, while sometimes a maintainer may find that a kfunc must be
+changed or removed immediately to accommodate some changes in their subsystem,
+usually kfuncs will be able to accommodate a longer and more measured
+deprecation process. For example, if a new kfunc comes along which provides
+superior functionality to an existing kfunc, the existing kfunc may be
+deprecated for some period of time to allow users to migrate their BPF programs
+to use the new one. Or, if a kfunc has no known users, a decision may be made
+to remove the kfunc (without providing an alternative API) after some
+deprecation period so as to provide users with a window to notify the kfunc
+maintainer if it turns out that the kfunc is actually being used.
+
+It's expected that the common case will be that kfuncs will go through a
+deprecation period rather than being changed or removed without warning. As
+described in :ref:`KF_deprecated_flag`, the kfunc framework provides the
+KF_DEPRECATED flag to kfunc developers to signal to users that a kfunc has been
+deprecated. Once a kfunc has been marked with KF_DEPRECATED, the following
+procedure is followed for removal:
+
+1. Any relevant information for deprecated kfuncs is documented in the kfunc's
+   kernel docs. This documentation will typically include the kfunc's expected
+   remaining lifespan, a recommendation for new functionality that can replace
+   the usage of the deprecated function (or an explanation as to why no such
+   replacement exists), etc.
+
+2. The deprecated kfunc is kept in the kernel for some period of time after it
+   was first marked as deprecated. This time period will be chosen on a
+   case-by-case basis, and will typically depend on how widespread the use of
+   the kfunc is, how long it has been in the kernel, and how hard it is to move
+   to alternatives. This deprecation time period is "best effort", and as
+   described :ref:`above<BPF_kfunc_lifecycle_expectations>`, circumstances may
+   sometimes dictate that the kfunc be removed before the full intended
+   deprecation period has elapsed.
+
+3. After the deprecation period the kfunc will be removed. At this point, BPF
+   programs calling the kfunc will be rejected by the verifier.
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
@@ -387,7 +502,7 @@ Here is an example of it being used:
 		return 0;
 	}
 
-3.2 struct cgroup * kfuncs
+4.2 struct cgroup * kfuncs
 --------------------------
 
 ``struct cgroup *`` objects also have acquire and release functions:
@@ -502,7 +617,7 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 		return 0;
 	}
 
-3.3 struct cpumask * kfuncs
+4.3 struct cpumask * kfuncs
 ---------------------------
 
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
-- 
2.39.0

