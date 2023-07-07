Return-Path: <bpf+bounces-4487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A074B736
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329C9281918
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0718AE1;
	Fri,  7 Jul 2023 19:30:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F8182A1
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:40 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04FF2D53
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-577323ba3d5so49491587b3.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758230; x=1691350230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=soJ/4tm34L3bmuAuBxXjw7TVIvg3GBbPbu7fpYLry1k=;
        b=rbggUvrv6V32VM7k+4GTWk+PVZLun0x/s/A+BXLz5+P0UqGOKMDknhYUQXU8OHUrAT
         MP8jlFCrER3kggY8bDVb9dYiDi5wwDvnahZ2VIpduJGaWTOsoxWc5W4/aezbJDGywpYW
         m00Fh6uyXj+dd998dE0hKTiGAVV4S7qGqHZDfRccpe4YVafZV2giiRLo4XMMquRWh5cj
         NvR+kBXOOXU9Grkj95Mf4+AolE3RZnMVDm/Yhjng1EgmCQBav6cuf0GP/ISzvaLLHnfn
         cUunZVDGuWzQKYVQYf0E7ewCvt/Azf9OiJiDyo9X95pFpUZrpF8rUXtVxCLK7w+UHBXJ
         elVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758230; x=1691350230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soJ/4tm34L3bmuAuBxXjw7TVIvg3GBbPbu7fpYLry1k=;
        b=LvTgK0GzfROUlf7EmqfqZa/LuaKorefrZsewzTvz/Pe7JNmjY2tF2rMWYXWYVjbitf
         FX2kyCvKNz7Twb3Lh9HN5uKNQYOlT0MR47ZZ6+jq3v+ks94Wl6JeNOxXSTwV9ycbJBhR
         iKflxhgl2CuevtShlDV005CDD1Lp3ZoEK6pLxHb//RtoQkhaSornKICCGSxPa8s0yOze
         UW5l7NimQiN1mZmKGk2a6n4IphgkNTyE9e1XP1uoIGMrufvmLbPpGfBDivyLO4H4cUip
         fvWMyFVLkdkF0gQOJmEk3YlC58XTfc+o6k0DoMSx15IlsaDPUwhj2ANwCiG8I0FgOxvk
         QGvQ==
X-Gm-Message-State: ABy/qLYUbOJz6F66DqGoVcs7QLlQZESc3FkiAehXtIUzqRwuXqJ975Il
	LSV4EaPa4hWvJnp4gpaCu6dlNRPjQkuIIlpN91NGNYVy+WhQaw7kipRmKxIihHKNDiRuzat61ZS
	ZNWdYNgd619LDRxSqelBnQNGSFN0Vz90uSx2fF4XR9fuBzi2qFA==
X-Google-Smtp-Source: APBJJlHUj9XjkAjBTLuWn0CzrSP86fxiB9BWE+OEAKmhD8cb2VCzDN8mhoLBBbc4a8T/h8lYyG4/crg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af11:0:b0:56d:19ce:416c with SMTP id
 n17-20020a81af11000000b0056d19ce416cmr111873ywh.0.1688758229857; Fri, 07 Jul
 2023 12:30:29 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:04 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-13-sdf@google.com>
Subject: [RFC bpf-next v3 12/14] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 380047161aac..47a837c0d796 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -68,4 +68,47 @@ struct nstoken;
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
2.41.0.255.g8b1d071c50-goog


