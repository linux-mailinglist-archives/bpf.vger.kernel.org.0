Return-Path: <bpf+bounces-8461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D954F786CBF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C881C20DFB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57012B66;
	Thu, 24 Aug 2023 10:23:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6B12B61
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 10:23:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511619B6
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692872587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzTfbUgHc72NrNoOv+tWEcEaymTZdKO41i7Hv/lMOTk=;
	b=GsWtgQnxhgtyMfB12YSmCVAfk2MlCtCY1MCc6ytdIlwQTLNOE9FI6Ds9TdOzo3IIa8GUg3
	T8OPCUzgiL9zpAkjRDXZ+Igihdn7BzpI0r3HKVFmebnKgQarEK2OxWoCzUi5tlid9SDKdT
	MGcZXCCw8U0gZTGa2eoMn9CMRKCo8WA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-xm5Ch-usPrSVy8EKSD7Zrg-1; Thu, 24 Aug 2023 06:23:05 -0400
X-MC-Unique: xm5Ch-usPrSVy8EKSD7Zrg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bfe6a531bso466001466b.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872584; x=1693477384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzTfbUgHc72NrNoOv+tWEcEaymTZdKO41i7Hv/lMOTk=;
        b=GN5/nnZlZ07piUz1ExeVDCjzfj0b9Uj4HAaAmh9/v855Z0TMcXK/WUIm20xCXyHMqO
         xxsGSSTeRq5mMxhvmseqzU75OE2FqxSDD6roCHl4mUrr8WsqX1mRHlfZr76yYlAzcst9
         ixi6hU/4fLGNXn60xtzyhGKVHMdpo7uZj63W6YTKoktny2T4hh/RPiJMUg9c6Blq/dqp
         HlUIPrVs1Z0b5C4Om7KqNTSXi/Kvy3BQ732vRXR6t4S6DKdZk8/3UhabPUukriZCq68O
         TyrYO0DzLkMT+AalrZXc2SlH9N5FOnTwvl9rQoAz8S9r53/U27wlSpJmX8+OPeLhCmyC
         IeQQ==
X-Gm-Message-State: AOJu0Yz68WXrHnD/79wdL1zhheS4YKG9Bw9l2t0DskzDdF+n01JM6VKE
	v3rPMIGGtfXLuXgWkMH9UqmpKR2g8YdWLXcUGiW+p8wstZFddYArFKdzHARlIrtbLEOUpb5fcHl
	Jsl5sWslzVrfS
X-Received: by 2002:a17:906:10dc:b0:9a1:c352:b6a2 with SMTP id v28-20020a17090610dc00b009a1c352b6a2mr5662147ejv.52.1692872584448;
        Thu, 24 Aug 2023 03:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZn9AXP7KO8ah81pJz8MCwhL6gIwhx51Q4q9joGl03vF6yPTYE1J4ICb5Doy5tNDnibQ7lw==
X-Received: by 2002:a17:906:10dc:b0:9a1:c352:b6a2 with SMTP id v28-20020a17090610dc00b009a1c352b6a2mr5662134ejv.52.1692872584159;
        Thu, 24 Aug 2023 03:23:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090648d000b0098d2d219649sm10870340ejt.174.2023.08.24.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:23:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B236CD3D0A7; Thu, 24 Aug 2023 12:23:01 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 7/7] samples/bpf: Add note to README about the XDP utilities moved to xdp-tools
Date: Thu, 24 Aug 2023 12:22:50 +0200
Message-ID: <20230824102255.1561885-8-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824102255.1561885-1-toke@redhat.com>
References: <20230824102255.1561885-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To help users find the XDP utilities, add a note to the README about the
new location and the conversion documentation in the commit messages.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/README.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index f16fc48e55a5..cabe2d216997 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -4,6 +4,12 @@ eBPF sample programs
 This directory contains a test stubs, verifier test-suite and examples
 for using eBPF. The examples use libbpf from tools/lib/bpf.
 
+Note that the XDP-specific samples have been removed from this directory and
+moved to the xdp-tools repository: https://github.com/xdp-project/xdp-tools
+See the commit messages removing each tool from this directory for how to
+convert specific command invocations between the old samples and the utilities
+in xdp-tools.
+
 Build dependencies
 ==================
 
-- 
2.41.0


