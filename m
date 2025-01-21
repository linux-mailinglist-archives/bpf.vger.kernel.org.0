Return-Path: <bpf+bounces-49395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A11A180C2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31C63A5071
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AB51F4E3F;
	Tue, 21 Jan 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZGsKlqC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6A1F4280
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472044; cv=none; b=bi2Aec0cgd4Gr6HLkftAZNqdkDGcYNtyxmG9RXxA3QuKx5ozhcz0GWQs6cqjBlUva/0n/xFZBBwQWJgbSmNKNmHPsyNfh4lXLkFupNqANHX1+SNpIIQqrigKvRyeU3EVF9+sx6MQM5KlNezmXzqzRoUc0h1qtUk9e/dyMq3rxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472044; c=relaxed/simple;
	bh=tiZRx3B2HMuqovxcLXfDoQxoFVQ/Mn4COLH9Vv01p5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuR26bn0gA6h7Exh4UuTpkoNhWsYZAtpF+Lb3tZycdt/B5+eyI4zBIiGTt0cM7RSSn8Y7sRuYlvdu1kWACPVmrV/0xs98WiG/KtWX1FjCXIgUJ0GX6SIWafu/5Mjn2yayP//9ZAfk7pzvfKMX4v+0r8f0fx7Y0lFCyyAP5rR5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZGsKlqC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737472041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjbE/E9Mq2/nisrHRajqDYH+16MtQm8zpmU3v3KEuJI=;
	b=gZGsKlqCKa6tSlqafz0r4I1KFjxfvoLrthiazdUR2LrfXZNZfKF/QVvDzb9WHEGxLwk8re
	6p4sWstLE5u4u+y3HQGPthEmdv+nlHdwUbNGS3Kk0bLLv5PV8oy0i2buP9NFp0NcpSWYdv
	qq3+nMTgw5l0BB8b8D1H04CH1x0x0lg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-ql1KL0eCMPSFNCvDtqPmSA-1; Tue, 21 Jan 2025 10:07:20 -0500
X-MC-Unique: ql1KL0eCMPSFNCvDtqPmSA-1
X-Mimecast-MFC-AGG-ID: ql1KL0eCMPSFNCvDtqPmSA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21650d4612eso35129335ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 07:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737472039; x=1738076839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjbE/E9Mq2/nisrHRajqDYH+16MtQm8zpmU3v3KEuJI=;
        b=oLh3ocF/VrsWi2mqSvLivlIOLY7YscVBV1hyJQXeXMP/aP/m/9So2e2G557djuXuLL
         EmdvecT2d8RcTeY5JO/0/YASt9Vz01OgzR9ATJXhssAza3WJ/LRnkupMzwu4FQiAe5DR
         dbsRr8JfWm1BJKFcn5ZxSATYimswWBn0BCknjgG1s80usqUwjw1qBEahykLRNhgfwBR7
         iONkZqMZXgVt3wA62gLkMj+5RNAOOpcrmuOyEOPZqknddRvJoOco0VKCC5VjN79c9iom
         nkVt/SGDPTu24+9wNRWzoXgfQ/gK4o0a28MolxeBwLYab93790j5xH3u0S8BucmoR16i
         hiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQkp69ACOL/kkO64KTrSGIPg6QB2iuQvVZ0RhpOGYwvmEP2gymNHNpuSy1n9FBFoPy6zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95qDzrrsoIJUjOL9nrmVO2zXPeNN/Z+4usxHCgj9HWCRI3+RJ
	Wm1Q+zW+oQWnPVLZbvGtcsdttnfi4Cbow2jFaBKRt8IkkIR/qYLO1TygjcjxqC7c792NjiKVujg
	SWQ77IFo7ueR6R5Y7n8orv4Rr/xKZh11rVgndNKXSWhYwyCI7cw==
X-Gm-Gg: ASbGncu66cTbhaTpzerDbo3Dcflu3PY7c7WX3qitlHcvDP+0PuHVdSsfTl6gnUla5r0
	/OCtEh98Y0SVasQWSfoldgNPWN+ak1seuMD2yzn9uDMs+wThq+ZEpCTdMmrjbcGYumMMuQPRFb0
	f7acuEAxiHEMHFVRqwCmk2qs3aFsCuTStb5anqkS8LEzavNJFqsPgjDF80r4X+0THD9CFe8MPkj
	Q0G80uSDptslPCKo1yfJzKGfmKSzHJJhKySSyVXkKuYS3bvBwB5SA439tNNAZ0oPrSov6Qf8ert
	2Wx8R0zUemAnj0KqKVENmL3HHes4P51UOV0=
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21c3540d18cmr272622785ad.16.1737472039416;
        Tue, 21 Jan 2025 07:07:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGljEPOvi4LdYIJi1m/mh0EvC9Vvtm5uevEGtJyjU6lfXNp5gADbbEg1zX0Q/7CjZDObORDaQ==
X-Received: by 2002:a17:903:2290:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21c3540d18cmr272622365ad.16.1737472039096;
        Tue, 21 Jan 2025 07:07:19 -0800 (PST)
Received: from kernel-devel.local (fp6fd8f7a1.knge301.ap.nuro.jp. [111.216.247.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9efe3sm79066215ad.20.2025.01.21.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:07:18 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	lorenzo@kernel.org,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stfomichev@gmail.com,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have ETH_HLEN
Date: Wed, 22 Jan 2025 00:06:43 +0900
Message-ID: <20250121150643.671650-2-syoshida@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121150643.671650-1-syoshida@redhat.com>
References: <20250121150643.671650-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function bpf_test_init() now returns an error if user_size
(.data_size_in) is less than ETH_HLEN, causing the tests to
fail. Adjust the data size to ensure it meets the requirement of
ETH_HLEN.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
 .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index c7f74f068e78..df27535995af 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
 	/* send a packet to trigger any potential bugs in there */
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 27ffed17d4be..461ab18705d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -23,7 +23,7 @@ static void test_xdp_with_devmap_helpers(void)
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd;
 	struct nstoken *nstoken = NULL;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -58,7 +58,7 @@ static void test_xdp_with_devmap_helpers(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
@@ -158,7 +158,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	struct nstoken *nstoken = NULL;
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -208,7 +208,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
-- 
2.48.1


