Return-Path: <bpf+bounces-10082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCC7A0F8A
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFBB2820F2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFF273F6;
	Thu, 14 Sep 2023 21:05:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597226E34
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:05:05 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B92700
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-577b9a2429cso1103373a12.3
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725505; x=1695330305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tf19T9rRGxsZfukPPxPZNYc1yxG0C28TAql/7/AOXQo=;
        b=eiFAwx9Cp3H6u2ASKyqNC5QDFwljBq/blGWGUnE3GVh+0sRc6M0DTVqyuCP5kewW7D
         pStwu9HhmEjqNAWnhZLFVQcbVNhTKjGtBZtD0dgM4j6likQPuEaY9r2bWjAe5hKIyP4/
         5cYYIVw7oBHua2Q7EJYbp22WSlZGiIqK69kSeo7bXDpzXJ2mSJ+Ka6K3RBvsEhdlCZVj
         8j/QkshqjutPNHCyCs1E7wiCIt0gUn84uBt5jrB3D2vz9TKEfKuXZp/gt30r46qlwl2T
         peHxyAWlO22YcFkyBv+eQYhkdE11Xe+bZtjwo3Z5LmHwkLPL25xuqz0MYJHxZTt4TJ0g
         mbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725505; x=1695330305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf19T9rRGxsZfukPPxPZNYc1yxG0C28TAql/7/AOXQo=;
        b=RQztAMpKJZKcdexeFgIMXflkstiv4A9RLtbZkW+ll1vvqlDBnXxHwrh9VwXZXDatLr
         W63ffpNjvPfFIXcGCI1jypdyJvvfYo2bbqzAd8rAG3mbNPfxUGCdYVeXjRhSCxbyeACR
         2Oin7qsxIdh6scaAz5IBphj5QvQseSlnSLxW3okPRKmQRcqmtMqTtbK75JdqvUtcaOxq
         FdqAeB8T31m09kasq1UFnXIYHR+Ofh0vQbMK9aYCAhXhXVup5uXwJJDD5swo4qxjb6LE
         7ljcnPRKRJ7CElLE2Ja+9SIAUTJlx49l2E7L+iF1mLbr+CFa7oiNO0+Q1B9PowHSRrYV
         nMJA==
X-Gm-Message-State: AOJu0YxAimq+44IJ0VzJWe5WGeSSXc0UfawKDb3TXW00uivyBUtDzwPw
	Wy+ZlbbIx7aRb0bxqPUs7TjZm/xgOjWxIKp9cnxCVwa6EuN1FsQV+YRTr+aSnwZSu3CuWPyDcoK
	cpJmnROOok2W+JcIkbdiNlcyu6E78xk4qoo9LWQgZHlAo5lvhMw==
X-Google-Smtp-Source: AGHT+IFmD2hAX/VwTYHIHw/W7HhFYlJ6aK73uLJiGlxAHLq3ldCzLSUUUdBbFn8FvQzx2drbgbuGquY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:af06:0:b0:566:1c6:139b with SMTP id
 w6-20020a63af06000000b0056601c6139bmr145712pge.8.1694725504374; Thu, 14 Sep
 2023 14:05:04 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:48 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-6-sdf@google.com>
Subject: [PATCH bpf-next v2 5/9] selftests/xsk: Support tx_metadata_len
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

Add new config field and propagate to umem registration setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 3 +++
 tools/testing/selftests/bpf/xsk.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index d9fb2b730a2c..24f5313dbfde 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -115,6 +115,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 		cfg->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 		cfg->frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM;
 		cfg->flags = XSK_UMEM__DEFAULT_FLAGS;
+		cfg->tx_metadata_len = 0;
 		return;
 	}
 
@@ -123,6 +124,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 	cfg->frame_size = usr_cfg->frame_size;
 	cfg->frame_headroom = usr_cfg->frame_headroom;
 	cfg->flags = usr_cfg->flags;
+	cfg->tx_metadata_len = usr_cfg->tx_metadata_len;
 }
 
 static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
@@ -252,6 +254,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area,
 	mr.chunk_size = umem->config.frame_size;
 	mr.headroom = umem->config.frame_headroom;
 	mr.flags = umem->config.flags;
+	mr.tx_metadata_len = umem->config.tx_metadata_len;
 
 	err = setsockopt(umem->fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));
 	if (err) {
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index d93200fdaa8d..bff8e50d7532 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -200,6 +200,7 @@ struct xsk_umem_config {
 	__u32 frame_size;
 	__u32 frame_headroom;
 	__u32 flags;
+	__u32 tx_metadata_len;
 };
 
 int xsk_attach_xdp_program(struct bpf_program *prog, int ifindex, u32 xdp_flags);
-- 
2.42.0.459.ge4e396fd5e-goog


