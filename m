Return-Path: <bpf+bounces-8849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B678B4F7
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BC1C208C4
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24C13ACA;
	Mon, 28 Aug 2023 16:00:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC134A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:03 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17CC10B;
	Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58fae4a5285so40344587b3.0;
        Mon, 28 Aug 2023 09:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238401; x=1693843201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l44VFUL+FDV3oNtmEFVudfrfsvVSq51rS4XMBKotbrE=;
        b=ja1p+PxdkbzzNSkhoQRCHXSkrOrIPpv/n3WmtUngDhGgHNiYmJB+CDDctveJba6Sl4
         77MSFQigGQIpsK8dN/mDPDODMOT6Klc4KVv5Eh1xHwoM5KAw4I9CSx/04Hbo6Y1aaCKd
         85Syr5Yl5e0San3UssSWyi4UCDkV52x9KKo0RjnnpQfvAafyJKamJ0hcQJLl5ePlmlUk
         8HVM9dHBnXj774RIjY9ibrEzMERt1DloOnhcaWw+kF9br68NkFwx2aQYINCVq3ak2PHb
         /pBAZ5URc4copJ4c6WGMz2E8k1vdVmYF6GNY72chIFkOKEDPo0rZxaBG7fX4BW2mUVxf
         n6Pg==
X-Gm-Message-State: AOJu0Yz9yJgBguQKUT6wE4kPrQVF4FWU37xkGawZVmDWuuYnf4XQ67QD
	PPInkaEO3TgVWXJuNSMX2Xp9ZBfNMoXv0A==
X-Google-Smtp-Source: AGHT+IE9ibDLAltsnoNQ4RK6viZOGuq4TBDw1i/bdN3m/D01sFB2/zauT6bmKleDUlcGQ2gWGUKDuQ==
X-Received: by 2002:a0d:ccd4:0:b0:58c:8b7e:a1e4 with SMTP id o203-20020a0dccd4000000b0058c8b7ea1e4mr29973302ywd.23.1693238400657;
        Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id j125-20020a0df983000000b005772abf6234sm2203214ywf.11.2023.08.28.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	hch@infradead.org,
	hawkinsw@obs.cr,
	dthaler@microsoft.com,
	bpf@ietf.org
Subject: [PATCH bpf-next 1/3] bpf,docs: Move linux-notes.rst to root bpf docs tree
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
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


