Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED837578ABD
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiGRT3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRT24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 15:28:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8449A1AB;
        Mon, 18 Jul 2022 12:28:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cw12so9538577qvb.12;
        Mon, 18 Jul 2022 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kggq/8QR9J7+hQqC85Z7UvjwISsJybPyVWycNM36A94=;
        b=dhlOzRWSRCVDeB5G/ojYUTukZ+P2gcdtsU+jMLUstlXFlOrTp2ph3aG0NXBV8ztstI
         OXMYLzx6YxjDhp2P9YRr9zilu9HXR7fY5pvPhtwR3iRWzZwfVtgG9lVHCT2ZTqpw0+Ml
         +OgpMDSbWao5AC6+qrMwM3Db0YqXaBy6MaEv7wnj6amC+iUAq4cv2bT0A4L8zdy5Euao
         VAKc32hcR8GaNzT5A9JfavcEovAoouxP/ve/GxdRAbv82Ya4GcKRYbxbQkMPkB47IqRX
         kYT71Abd+YiP5O3A8ckxB+XNkCs6wKALUnGT5t/3o7qzxFLs7cpnxkdiCIV74UJKfkcN
         7sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kggq/8QR9J7+hQqC85Z7UvjwISsJybPyVWycNM36A94=;
        b=5BW/VUyenp3yQB7XiN74Oc7DdLNRhDtEqS6KBgj8nRDvJ5mk+E8AtO6eSsJs3MzDKq
         pmT0yinkz2c6d5PqbIxALQuPmTLADje39rMa1AwssWKLf4RqKePJWmKUVtynesXBidj/
         4jh5W9phBVQioPcVKT5BIh7csacLSvxxNMkm+SU7b3N0nLTSoLXInGballCL8Xa/yOwo
         Nu0X7m1uiNZTCJ53d096p5M9B2dPeKJD00c/9IWwvjxpZlel7M3x/IcAmiBXB9SpKJeF
         ISmBQ8WnZTmy9vpYZI/XCE06PEwG7j1QlOK1f9e4/FJSazt4i6ZJ7p0geysA1jGKyTBb
         fBwA==
X-Gm-Message-State: AJIora/8Rk2zN6TMWvKdn4/qJj5xtpZAlrS0Kk9zy8eQjLscICYysakW
        EBNKdArLoiGIDMreheeGB3KEzSca+XfB/g==
X-Google-Smtp-Source: AGRyM1u3EM0rXTHhAD/Z1aIEbA912gwLNc43tN+zBsepF5isd7Swws3o9Azy4V52O5TNXWBcbJiNlg==
X-Received: by 2002:a05:6214:246f:b0:473:5145:d906 with SMTP id im15-20020a056214246f00b004735145d906mr22495118qvb.126.1658172533740;
        Mon, 18 Jul 2022 12:28:53 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:ab01:d009:465a:5ab1])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006b5f4b7b088sm1783681qko.108.2022.07.18.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:28:53 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Segall <bsegall@google.com>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mel Gorman <mgorman@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yonghong Song <yhs@fb.com>,
        Yury Norov <yury.norov@gmail.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 06/16] lib/test_bitmap: delete meaningless test for bitmap_cut
Date:   Mon, 18 Jul 2022 12:28:34 -0700
Message-Id: <20220718192844.1805158-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220718192844.1805158-1-yury.norov@gmail.com>
References: <20220718192844.1805158-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of bitmap_cut() tests passed it with:
	nbits = BITS_PER_LONG;
	first = BITS_PER_LONG;
	cut = BITS_PER_LONG;

This test is useless because the range to cut is not inside the
bitmap. This should normally raise an error, but bitmap_cut() is
void and returns nothing.

To check if the test is passed, it just tests that the memory is
not touched by bitmap_cut(), which is probably not correct, because
if a function is passed with wrong parameters, it's too optimistic 
to expect a correct, or even sane behavior.

Now that we have bitmap_check_params(), there's a tool to detect such
things in real code, and we can drop the test.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 8bd279a7633f..c1ea449aae2d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -707,10 +707,6 @@ static struct test_bitmap_cut test_cut[] = {
 	{ 15, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
 	{ 16, 15, 32, { 0xa5a5a5a5UL, }, { 0x0001a5a5UL, }, },
 
-	{ BITS_PER_LONG, BITS_PER_LONG, BITS_PER_LONG,
-		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
-		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
-	},
 	{ 1, BITS_PER_LONG - 1, BITS_PER_LONG,
 		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
 		{ 0x00000001UL, 0x00000001UL, },
-- 
2.34.1

