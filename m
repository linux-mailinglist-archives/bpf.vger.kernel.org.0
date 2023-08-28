Return-Path: <bpf+bounces-8853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254F78B505
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DEF1C20985
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A813AEA;
	Mon, 28 Aug 2023 16:00:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730C134A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:10 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1ECA
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:09 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0B8DCC1595FE
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238407; bh=Yx2rMnToV0LEiBnRijpUaiaXo3XjmJpOnfWXLGu9Hyo=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=LfgAPcg0tu8ScdHNHNbnsFvGbgJYQGupwFBVQby1KboSgevcLbMEezSoJI5GcMRtP
	 ns165/bjicUe9Azjdvwng0PQmyT/Ttwbl7wKohrLbyzOufVyABc8X9Jz7plD5YgebI
	 E/ftWzlebwGqChXVpdLSOHKtwfrVvVrRNUckClek=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug 28 09:00:06 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CD58FC152564;
	Mon, 28 Aug 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238406; bh=Yx2rMnToV0LEiBnRijpUaiaXo3XjmJpOnfWXLGu9Hyo=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dRMObqZZU7TMVc19wzASbAFDwHIAmBeOLgcBPfwwQ54Tpz/Fjwo+DE4n84FXG3JQL
	 K8LvFv3V+KeFewCZVpItTi+PX0ViPDKWNSAXKH3qcoP52eZDqgn4tCJyf2zEZsHTVP
	 HFoDpA2cEZ2LHNIhlEyDMRyc0J9SXVybTT8dqfjA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4314DC15109C
 for <bpf@ietfa.amsl.com>; Mon, 28 Aug 2023 09:00:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: 0.092
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y_4trQK9RGEt for <bpf@ietfa.amsl.com>;
 Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9BC0AC151097
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-594ebdf7bceso22687767b3.2
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693238401; x=1693843201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l44VFUL+FDV3oNtmEFVudfrfsvVSq51rS4XMBKotbrE=;
 b=G3LUmFeFHn6Qr84+wnNCQs5qRDdOEAa+khwldqjO18IKaxvbWAmHOyLGXKgIq9PEhq
 tE6CPkFl6/ao5/FIZKjAwHusGiQqsddcFD0ohVF1NNe38BjPGg3wy0mTyZkHUmsTUVGs
 ZRmmCiI8jsPD1BroiWRu5Ch/UWlv+dYPId0k6L5zdh18Z9k9tPk9W+o5tZtRgUItMPS/
 dlLZ0xhofcibKeiE5KeLxxuyr1th9dAwdBzVvj6T3hFyrt15vjurM6t2igQGTCu4YDF7
 pd6zb6LvRbcbbrP9L167jBCuR1WxBqx0srA+zFWTi3xZLspjikJ9PHSarHeyd+tcoyZy
 KvyQ==
X-Gm-Message-State: AOJu0Yx53H4FkqD4yRJLigayA0zOnEvzWbolRQkZnzvjLGDkDB35q7NO
 GbP8PnR2wkP7TR+viFRrl7Q=
X-Google-Smtp-Source: AGHT+IE9ibDLAltsnoNQ4RK6viZOGuq4TBDw1i/bdN3m/D01sFB2/zauT6bmKleDUlcGQ2gWGUKDuQ==
X-Received: by 2002:a0d:ccd4:0:b0:58c:8b7e:a1e4 with SMTP id
 o203-20020a0dccd4000000b0058c8b7ea1e4mr29973302ywd.23.1693238400657; 
 Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
Received: from localhost ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 j125-20020a0df983000000b005772abf6234sm2203214ywf.11.2023.08.28.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
 dthaler@microsoft.com, bpf@ietf.org
Date: Mon, 28 Aug 2023 10:59:46 -0500
Message-ID: <20230828155948.123405-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828155948.123405-1-void@manifault.com>
References: <20230828155948.123405-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/j1HsOAwVmcqgDXrkZuQ0ktL-agc>
Subject: [Bpf] [PATCH bpf-next 1/3] bpf,
 docs: Move linux-notes.rst to root bpf docs tree
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In commit 4d496be9ca05 ("bpf,docs: Create new standardization
subdirectory"), I added a standardization/ directory to the BPF
documentation, which will contain the docs that will be standardized as
part of the effort with the IETF.

I included linux-notes.rst in that directory, but I shouldn't have. It
doesn't contain anything that will be standardized. Let's move it back
to Documentation/bpf.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/index.rst                             | 1 +
 Documentation/bpf/{standardization => }/linux-notes.rst | 0
 Documentation/bpf/standardization/index.rst             | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/bpf/{standardization => }/linux-notes.rst (100%)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 1ff177b89d66..aeaeb35e6d4a 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -29,6 +29,7 @@ that goes into great technical depth about the BPF Architecture.
    bpf_licensing
    test_debug
    clang-notes
+   linux-notes
    other
    redirect
 
diff --git a/Documentation/bpf/standardization/linux-notes.rst b/Documentation/bpf/linux-notes.rst
similarity index 100%
rename from Documentation/bpf/standardization/linux-notes.rst
rename to Documentation/bpf/linux-notes.rst
diff --git a/Documentation/bpf/standardization/index.rst b/Documentation/bpf/standardization/index.rst
index 09c6ba055fd7..d7b946f71261 100644
--- a/Documentation/bpf/standardization/index.rst
+++ b/Documentation/bpf/standardization/index.rst
@@ -12,7 +12,6 @@ for the working group charter, documents, and more.
    :maxdepth: 1
 
    instruction-set
-   linux-notes
 
 .. Links:
 .. _IETF BPF Working Group: https://datatracker.ietf.org/wg/bpf/about/
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

