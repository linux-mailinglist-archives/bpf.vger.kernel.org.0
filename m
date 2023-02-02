Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6676889E2
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjBBWgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjBBWgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:36:05 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE546952E;
        Thu,  2 Feb 2023 14:36:02 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id ll10so1901929qvb.6;
        Thu, 02 Feb 2023 14:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1aXSivOa6fEp47i/SYTdC+SGcs47yHpVudFviMOi1s=;
        b=acMM9xzJXrtJsjMqMZ7fYtQ3j+iSdDqW3KAnQ2aF/5QOMr8m28A9k7bQFO0apwuc/M
         c++SklXeY85ueZaGRaMGd6we289cv1VJ0ZOZOMoVpvcwEXHkc32CNw22wbexemtaIBtL
         FoCIljJeYLNG1t8/jcYNVMsoxxTr6DjheADcLmtmvGrFG2EXSuVRpJGSRqGqj7ZgrX/g
         2NYFOtiKoIKYJBz9MxAm+Zw3yG+IODoR+FyIZDeD0K1ma8tJxaMUg6aVZ/q4FdeJE+Ls
         MW3/o8dHH3vDyktl7Y9Dn9HDzoTUj0h4VKHWGBXC7oXncguOpPwfTDyZaJ8H2zJKU1AE
         CagA==
X-Gm-Message-State: AO0yUKXUcE1RoS43SLSIdKHWoBs7aASquuLSHiQbRULWvanlOXPKYsEm
        sCQ4OOJLEaN5HqgHeTcExLFBchSZ9CNIcKQh
X-Google-Smtp-Source: AK7set/G/57P1dWVhlNtTGawXNY+nfAemHmTjdb690TC7PMwKs0mIhk1wIQzJfkQeyVP9f9EPIYymA==
X-Received: by 2002:a05:6214:12d0:b0:537:695e:9f13 with SMTP id s16-20020a05621412d000b00537695e9f13mr11472812qvv.34.1675377360906;
        Thu, 02 Feb 2023 14:36:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9cc7])
        by smtp.gmail.com with ESMTPSA id d136-20020a37688e000000b006fa4ac86bfbsm587983qkc.55.2023.02.02.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:36:00 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, toke@redhat.com, brouer@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle / stability expectations
Date:   Thu,  2 Feb 2023 16:35:57 -0600
Message-Id: <20230202223557.744110-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202223557.744110-1-void@manifault.com>
References: <20230202223557.744110-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF kernel <-> kernel API stability has been discussed at length over
the last several weeks and months. Now that we've largely aligned over
kfuncs being the way forward, and BPF helpers being considered frozen,
it's time to document the expectations for kfunc lifecycles and
stability so that everyone (BPF users, kfunc developers, and
maintainers) are all aligned, and have a crystal-clear understanding of
the expectations surrounding kfuncs.

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

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 138 +++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0bd07b39c2a4..4135f3111b67 100644
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
@@ -238,6 +238,32 @@ single argument which must be a trusted argument or a MEM_RCU pointer.
 The argument may have reference count of 0 and the kfunc must take this
 into consideration.
 
+.. _KF_deprecated_flag:
+
+2.4.9 KF_DEPRECATED flag
+------------------------
+
+The KF_DEPRECATED flag is used for kfuncs which are expected to be changed or
+removed in a subsequent kernel release. Deprecated kfuncs may be removed at any
+time, though if possible (and when applicable), developers are encouraged to
+provide users with a deprecation window to ease the burden of migrating off of
+the kfunc.
+
+A kfunc that is marked with KF_DEPRECATED should also have any relevant
+information captured in its kernel doc. Such information typically includes the
+kfunc's expected remaining lifespan, a recommendation for new functionality
+that can replace it if any is available, and possibly a rationale for why it is
+being removed.
+
+Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
+supported and have its KF_DEPRECATED flag removed, it is likely to be far more
+difficult to remove a KF_DEPRECATED flag after it's been added than it is to
+prevent it from being added in the first place. As described in
+:ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfuncs are
+highly encouraged to make their use-cases known as early as possible, and
+participate in upstream discussions regarding whether to keep, change,
+deprecate, or remove those kfuncs if and when such discussions occur.
+
 2.5 Registering the kfuncs
 --------------------------
 
@@ -304,14 +330,116 @@ In order to accommodate such requirements, the verifier will enforce strict
 PTR_TO_BTF_ID type matching if two types have the exact same name, with one
 being suffixed with ``___init``.
 
-3. Core kfuncs
+.. _BPF_kfunc_lifecycle_expectations:
+
+3. kfunc lifecycle expectations
+===============================
+
+kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
+strict stability restrictions associated with kernel <-> user UAPIs. Instead,
+they're modeled more similarly to EXPORT_SYMBOL_GPL, and can therefore be
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
+   be more difficult to justify being changed or removed by a maintainer. Said
+   in a different way, kfuncs that are known to have a lot of users and provide
+   significant value provide stronger incentives for maintainers to invest the
+   time and complexity in supporting them. It is therefore important for
+   developers that are using kfuncs in their BPF programs to communicate and
+   explain how and why those kfuncs are being used, and to participate in
+   discussions regarding those kfuncs when they occur upstream.
+
+b) Because many BPF programs are not upstreamed as part of the kernel tree, it
+   is often not possible to change them in-place when a kfunc changes, as it is
+   for e.g. an upstreamed driver being updated in place when an
+   EXPORT_SYMBOL_GPL symbol is changed. Distributions that bundle BPF programs
+   that use kfuncs must therefore ensure that those BPF programs are linking
+   against the kfuncs that are supported by the kernel version being used for
+   any given release. Additionally, BPF developers are encouraged to upstream
+   their BPF programs so they can enjoy the same benefits as upstreamed
+   modules, and avoid code churn.
+
+   On the other hand, while the hope is that it will become the norm to
+   upstream BPF programs, the reality is that most BPF programs are still
+   out-of-tree. This means that users with out-of-tree BPF programs that use
+   kfuncs should be considered relevant to discussions and decisions around
+   modifying and removing kfuncs, despite that not being the norm for
+   out-of-tree kernel modules. The BPF community will take an active role in
+   participating in upstream discussions when necessary to ensure that the
+   perspectives of such users are taken into account.
+
+c) A kfunc will never have any hard stability guarantees. BPF APIs cannot and
+   will not ever hard-block a change in the kernel purely for stability
+   reasons. In other words, kfuncs have the same stability guarantees as any
+   other kernel API, such as those provided by EXPORT_SYMBOL_GPL, though with
+   perhaps less burden than EXPORT_SYMBOL_GPL changes thanks to BPF CO-RE.
+
+   That being said, kfuncs are features that are meant to solve problems and
+   provide value to users. The decision of whether to change or remove a kfunc
+   is a multivariate technical decision that is made on a case-by-case basis,
+   and which is informed by data points such as those mentioned above. It is
+   expected that a kfunc being removed or changed with no warning will not be a
+   common occurrence or take place without sound justification, but it is a
+   possibility that must be accepted if one is to use kfuncs.
+
+3.1 kfunc deprecation
+---------------------
+
+As described above, while sometimes a maintainer may find that a kfunc must be
+changed or removed immediately to accommodate some changes in their subsystem,
+other kfuncs may be able to accommodate a longer and more measured deprecation
+process. For example, if a new kfunc comes along which provides superior
+functionality to an existing kfunc, the existing kfunc may be deprecated for
+some period of time to allow users to migrate their BPF programs to use the new
+one. Or, if a kfunc has no known users, a decision may be made to remove the
+kfunc (without providing an alternative API) after some deprecation period
+period so as to provide users with a window to notify the kfunc maintainer if
+it turns out that the kfunc is actually being used.
+
+kfuncs being deprecated (rather than changed or removed with no warning) is
+expected to be the common case, and as described in :ref:`KF_deprecated_flag`,
+the kfunc framework provides the KF_DEPRECATED flag to kfunc developers to
+signal to users that a kfunc has been deprecated. Once a kfunc has been marked
+with KF_DEPRECATED, the following procedure is followed for removal:
+
+1. Any relevant information for deprecated kfuncs is documented in the kfunc's
+   kernel docs. This documentation will typically include the kfunc's expected
+   remaining lifespan,  a recommendation for new functionality that can replace
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
+3. After the deprecation period, or sometimes earlier if necessary, the kfunc
+   will be removed. At this point, BPF programs calling the kfunc will be
+   rejected by the verifier.
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
@@ -387,7 +515,7 @@ Here is an example of it being used:
 		return 0;
 	}
 
-3.2 struct cgroup * kfuncs
+4.2 struct cgroup * kfuncs
 --------------------------
 
 ``struct cgroup *`` objects also have acquire and release functions:
@@ -502,7 +630,7 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 		return 0;
 	}
 
-3.3 struct cpumask * kfuncs
+4.3 struct cpumask * kfuncs
 ---------------------------
 
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
-- 
2.39.0

