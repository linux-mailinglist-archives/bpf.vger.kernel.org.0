Return-Path: <bpf+bounces-14036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AC7DFCD5
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8929281E4A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961A241EB;
	Thu,  2 Nov 2023 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlSieQbq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35F23742
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:58:59 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036B192
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:58:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc23f2226bso11829205ad.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965937; x=1699570737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IGkzuCjLv5zFnRniqT4SWqZjcb9N4mGztS9ZvMTe5s=;
        b=BlSieQbqwz+zCz1YKwNpwhBwPcKv6CtTslX0XprklqUCUXOGg+Mf63eDV1PVxq5fUU
         Bjyidpksx6m0M41WIMext+1qkSGmpmwRIXQrwg7lRhbKG9kW88vjV9XRON7w1x0X+Q5A
         EBLN0JlnpOm1sGDxBIkDm/D/ZJFCVKxNLWRqdnPQNl4K4BnVMiWWsmcyX5ss2EDaW0Kl
         5xvdeLGKTQqkVHrk7+MSIzRSvrINzmOOrzAj3LqhREoXw6JEPYza+JLZkhH0sytEzj9B
         sRoWRywsoUwRgX+SP4XEau1FoThxa8le+puk/VzvAT5EdgDiW8BUWgraR6KozpbKFm4W
         W6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965937; x=1699570737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IGkzuCjLv5zFnRniqT4SWqZjcb9N4mGztS9ZvMTe5s=;
        b=v1uoXwvtvKSDHeqpxXZbdffmjkt00DiWatDvWAsrpdtq96PkXC1aXiNmfx2kqujjrf
         RUZXgSxR1hHfIY5uQRjJDXmBG3NorZlyEVfx/pTj4XhI9mOsyxJ+ugX4urUKytnSpaio
         SZ/OG6gPZH+6tK5OyN2TphgnekTMkx3vgbwLON9HJPM1LaBU5VtuxyobXIgsQAQtoOdV
         q4ATVKqVhedWkdHwEKpEkKrwKQ+06c9TGlJZ4YlXE8LvO87VCRDaMELayZJd/3orVjFx
         3f9vYpr7OiPB+Amw65tMVwfIaL2nRJisbh0h5rzVRii12BXAlRfN6A3pV0zxu7MSzevy
         RE8Q==
X-Gm-Message-State: AOJu0YxdQvP+EdLeiQpLQ90dPdQ0UDWOazzV6S/W57ICeJmNjyVkKmPL
	CZlcpw+bzgy1QirfJF73ynOmqkBrWiknlP3q0s04qiqXiMRP5KnQvBgrNIytbg3Hu7ICLIu2vVK
	cTB0NNEwj5xLmz0ut0uVUeF09bDFbVm5DUEtYTtrwkJjCB5xpNA==
X-Google-Smtp-Source: AGHT+IH6Wxf2G64tR0jzO3T+h2cnip19vyYFp36oRClwsoNM0OizspJXCj9yuO9CV3dzDnbjyYHxgsQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ac8e:b0:1cc:30cf:eae6 with SMTP id
 h14-20020a170902ac8e00b001cc30cfeae6mr305364plr.10.1698965936662; Thu, 02 Nov
 2023 15:58:56 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:34 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-11-sdf@google.com>
Subject: [PATCH bpf-next v5 10/13] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Checksum helpers will be used to calculate pseudo-header checksum in
AF_XDP metadata selftests.

The helpers are mirroring existing kernel ones:
- csum_tcpudp_magic : IPv4 pseudo header csum
- csum_ipv6_magic : IPv6 pseudo header csum
- csum_fold : fold csum and do one's complement

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 34f1200a781b..94b9be24e39b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,4 +71,47 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+
+static __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__u16)~csum;
+}
+
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		s += (__u32)saddr->s6_addr32[i];
+	for (i = 0; i < 4; i++)
+		s += (__u32)daddr->s6_addr32[i];
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
 #endif
-- 
2.42.0.869.gea05f2083d-goog


