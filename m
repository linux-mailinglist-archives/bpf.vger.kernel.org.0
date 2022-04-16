Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BE503525
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiDPIVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDPIVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 04:21:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AC15A3C
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 01:19:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so8739248plg.3
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=acpooba1BkAR6VGtBXXWnAmqTsG9Z1Z6Bt0jPG8Yszc=;
        b=Ylj/XayVIiE8ce/9PXRMm4YvmZIpegX03MLctvrzXZ2HnlRJfINfUfs0tjuHZkYa6A
         Tor08a8f+88mHE40Rw83Z9oamGvf+jYOY1ozHs8joWX/Ha8BCSadtK4O+njbYfgZT2ca
         dQP24mhHBEN9Jn4CcnAAl4A45nPw0y8rV3rpOJodJii1gRGP7k4Kk4PE70qGNAVFyWUW
         edVmr9A2gvnAr98tfnY+7TA6SMFhRNn24PxTSBRRLDYYefek4Xw3soKyjJjpcCVn1X3g
         2XbjHxlB/KdifpzhqMkUaw19xgDWv4Vk6/U1HbJeOGuXzTwu1HcyPGVHzxJZzI+i65vO
         7ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acpooba1BkAR6VGtBXXWnAmqTsG9Z1Z6Bt0jPG8Yszc=;
        b=agcGF+29YXus4HA/9XtjvhtBdcuji/j2AwvfaVoAT6Mqa6f8/xf6zdjMQ1KLyfi9aA
         YMYEc07omdjuORIdiy8+bMoW2Aw3ACjavqmUNhKo8kB+xhd7on0VQSrzrYoglmSSI9BT
         GDcrkAcZuxsKLEQlrkl3JKfhE53vZT5pq8pY8vNZ8eWP9A7YExmNDEcBFj6uQdctOt/T
         5rxErcuotFzoXGJ4M24JmBbjs/N16/1e6O82qEJDIgr1S/v9NEf3WswdPGPT0uw9WC86
         d28QiuHbPGTFGSm7BOYyC3JvXGl+nBAVq3u7uGHVT8PGQBG3anA5Y5aR66BiT6fXwL3k
         JdAg==
X-Gm-Message-State: AOAM533Wu5DOOMTmuu/JByhU5iU45gpFBYCYAslYRcZEXjaJF4aitv0O
        2k26Ct2N6EU9xCDazuNo52U=
X-Google-Smtp-Source: ABdhPJyghgZMDaQTyWjeKI9kROTD7APLsx0gRcAVJjzsLR8V/KxDJWmxh8fRvVkCCyGkUW81wtSw3w==
X-Received: by 2002:a17:90a:f01:b0:1c7:ea40:93e7 with SMTP id 1-20020a17090a0f0100b001c7ea4093e7mr8270348pjy.30.1650097157438;
        Sat, 16 Apr 2022 01:19:17 -0700 (PDT)
Received: from localhost ([112.79.142.171])
        by smtp.gmail.com with ESMTPSA id t69-20020a637848000000b0039831d6dc23sm6405680pgc.94.2022.04.16.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:19:17 -0700 (PDT)
Date:   Sat, 16 Apr 2022 13:49:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com
Subject: Re: [PATCH bpf-next v2 0/7] Dynamic pointers
Message-ID: <20220416081921.mn56boji5yrvgfdh@apollo.legion>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416081341.23istudnhlrwjztb@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416081341.23istudnhlrwjztb@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 16, 2022 at 01:43:41PM IST, Kumar Kartikeya Dwivedi wrote:
> On Sat, Apr 16, 2022 at 12:04:22PM IST, Joanne Koong wrote:
> > This patchset implements the basics of dynamic pointers in bpf.
> >
> > A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
> > alongside the address it points to. This abstraction is useful in bpf, given
> > that every memory access in a bpf program must be safe. The verifier and bpf
> > helper functions can use the metadata to enforce safety guarantees for things
> > such as dynamically sized strings and kernel heap allocations.
> >
> > From the program side, the bpf_dynptr is an opaque struct and the verifier
> > will enforce that its contents are never written to by the program.
> > It can only be written to through specific bpf helper functions.
> >
> > There are several uses cases for dynamic pointers in bpf programs. A list of
> > some are: dynamically sized ringbuf reservations without any extra memcpys,
> > dynamic string parsing and memory comparisons, dynamic memory allocations that
> > can be persisted in a map, and dynamic parsing of sk_buff and xdp_md packet
> > data.
> >
> > At a high-level, the patches are as follows:
> > 1/7 - Adds MEM_UNINIT as a bpf_type_flag
> > 2/7 - Adds MEM_RELEASE as a bpf_type_flag
> > 3/7 - Adds bpf_dynptr_from_mem, bpf_dynptr_alloc, and bpf_dynptr_put
> > 4/7 - Adds bpf_dynptr_read and bpf_dynptr_write
> > 5/7 - Adds dynptr data slices (ptr to underlying dynptr memory)
> > 6/7 - Adds dynptr support for ring buffers
> > 7/7 - Tests to check that verifier rejects certain fail cases and passes
> > certain success cases
> >
> > This is the first dynptr patchset in a larger series. The next series of
> > patches will add persisting dynamic memory allocations in maps, parsing packet
> > data through dynptrs, dynptrs to referenced objects, convenience helpers for
> > using dynptrs as iterators, and more helper functions for interacting with
> > strings and memory dynamically.
> >
>
> test_verifier has 5 failed tests, the following diff fixes them (three for
> changed verifier error string, and two because we missed to do offset checks for
> ARG_PTR_TO_ALLOC_MEM in check_func_arg_reg_off). Since this is all, I guess you
> can wait for the review to complete for this version before respinning.
>

Ugh, hit send too early.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf64946ced84..24e5d494d991 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5681,7 +5681,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
-		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
+		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
 			return 0;
 		break;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index fbd682520e47..f1ad3b3cc145 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -796,7 +796,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "arg 1 is an unacquired reference",
 },
 {
 	/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index 86b24cad27a7..055a61205906 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -417,7 +417,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "arg 1 is an unacquired reference",
 },
 {
 	"bpf_sk_release(bpf_sk_fullsock(skb->sk))",
@@ -436,7 +436,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "arg 1 is an unacquired reference",
 },
 {
 	"bpf_sk_release(bpf_tcp_sock(skb->sk))",
@@ -455,7 +455,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "arg 1 is an unacquired reference",
 },
 {
 	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",

> [...]

--
Kartikeya
