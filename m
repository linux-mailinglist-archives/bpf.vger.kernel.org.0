Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC019579A
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0M6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 08:58:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34564 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727345AbgC0M6i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 08:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585313916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EygyYiy7VJ/xUDDaZg0TPV7uApUx+KhaTTcjHYhMfv8=;
        b=KYg8F4owiSQfIPRc2mArviHEMgnwEp9i5QAyw9WrUh4T7uQ5A7e2vza89e/ZxXOyxABzlg
        uGNLHI9UHH/EZkjxFRNZWq7RQttJBf1H/LWEvmXWGvVqwtLf9Q7DeBO3yyKDyMJC/Qu+Cs
        4BvZ6yeaS2IpbpiyfLtdrjcslyDTrL8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-BzxfwAw2PISa-lsiW0EQkw-1; Fri, 27 Mar 2020 08:58:35 -0400
X-MC-Unique: BzxfwAw2PISa-lsiW0EQkw-1
Received: by mail-lf1-f71.google.com with SMTP id s6so3737169lfp.15
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 05:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EygyYiy7VJ/xUDDaZg0TPV7uApUx+KhaTTcjHYhMfv8=;
        b=n3Nlks3W8nLsteXEAT8F50jLBwFR0gT845Y2XJskyTLsxz9uShP8TyqRkFCWtNkm5c
         Ar9lcwoD54L8CPJK9xHMLb8cYehafovBxQM0oK4m6x+M7+0L3iMvp2o3Adhq+B4+QVf0
         olCorFCfBNQVlt0qLB13QtKyrvB0cEnbUSznGl21Z3YORTjl2NxYun9dzFigc2sNoT5f
         bshlW2ahHxrw3Ykyzgm9ROjpKeb/zUzcu7L4OsBvkGn1/q76rYQEVie73bpfmkhNDjLI
         olKnejeuugdE8DYtD5Xr6r43HueCb8hcz4faH+JTwhiMQtR1BJ0nK5YWua5wVV66Zi2k
         jXMg==
X-Gm-Message-State: ANhLgQ29qufMH9EUd3MYMBJMpxKno8mtMTt757hhBRz2CIj2UJK2t3Px
        FUkhFYzbpK+gK4M07ykHgt2mCgHwKDxWvlDTgkhFmg2XxdLsTeuUMyHqvMWm38DOgReOe6lf+M7
        nn1kj53CfXVBh
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr9002779lfu.169.1585313913640;
        Fri, 27 Mar 2020 05:58:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsrF8gsvXkFpJTpCPXhKIgfAa/8ZF2rzSy/WN05C56caLv9dHalpeiBrUTmLaz+Z+ux0x322A==
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr9002763lfu.169.1585313913443;
        Fri, 27 Mar 2020 05:58:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z23sm2701884ljh.55.2020.03.27.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:58:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 13EB218158B; Fri, 27 Mar 2020 13:58:32 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: Add getter for pointer to data area for internal maps
Date:   Fri, 27 Mar 2020 13:58:18 +0100
Message-Id: <20200327125818.155522-1-toke@redhat.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326151741.125427-1-toke@redhat.com>
References: <20200326151741.125427-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For internal maps (most notably the maps backing global variables), libbpf
uses an internal mmaped area to store the data after opening the object.
This data is subsequently copied into the kernel map when the object is
loaded.

This adds a getter for the pointer to that internal data store. This can be
used to modify the data before it is loaded into the kernel, which is
especially relevant for RODATA, which is frozen on load. This same pointer
is already exposed to the auto-generated skeletons, so access to it is
already API; this just adds a way to get at it without pulling in the full
skeleton infrastructure.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Add per-map getter for data area instead of a global rodata getter for bpf_obj

tools/lib/bpf/libbpf.c   | 9 +++++++++
 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 085e41f9b68e..a0055f8908fd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6756,6 +6756,15 @@ void *bpf_map__priv(const struct bpf_map *map)
 	return map ? map->priv : ERR_PTR(-EINVAL);
 }
 
+void *bpf_map__data_area(const struct bpf_map *map, size_t *size)
+{
+	if (map->mmaped && map->libbpf_type != LIBBPF_MAP_KCONFIG) {
+		*size = map->def.value_size;
+		return map->mmaped;
+	}
+	return NULL;
+}
+
 bool bpf_map__is_offload_neutral(const struct bpf_map *map)
 {
 	return map->def.type == BPF_MAP_TYPE_PERF_EVENT_ARRAY;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d38d7a629417..baef0d2f3205 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -407,6 +407,7 @@ typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
 				 bpf_map_clear_priv_t clear_priv);
 LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
+LIBBPF_API void *bpf_map__data_area(const struct bpf_map *map, size_t *size);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
 LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5129283c0284..258528045a85 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -243,5 +243,6 @@ LIBBPF_0.0.8 {
 		bpf_link__pin;
 		bpf_link__pin_path;
 		bpf_link__unpin;
+		bpf_map__data_area;
 		bpf_program__set_attach_target;
 } LIBBPF_0.0.7;
-- 
2.26.0

