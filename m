Return-Path: <bpf+bounces-77811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CCCF3565
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 12:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77607301BEBC
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF6D32B989;
	Mon,  5 Jan 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJVt47Yk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tEiLZn92"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279A30FC10
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613680; cv=none; b=SmnTvfv/MTsxYdthPQ5AibQa9hoyedn0GACOQebJcSrKVB+/Y0X+tMiAIZLPj6O6gXUfKIDKLl5vDUQ0j8V5mF+PV/1i6cgeMcyJ/WinsL4wsxQdBgaddQnxMrlm3E/mz897y2mNUUbHnnrvaDSNhvyow1UDJu2LimTCxtyJDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613680; c=relaxed/simple;
	bh=Ge4t427bDOOVbbyxmm6WKToUT86Yj4z7o+/cHmkHI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tvczbbyx/7R6meIxHTmCVAxqUupDSQL3dLwvlGKagmYPRxwdMoVT6yyDMqnHHBReezLnN9Vrl8kC3eu7KNQkVEG0cO1RAGDdLPb2aBSHdcQ/jfVPvBd9Zf6t55zZQfwdcmzahW87lvS33thhLlmWA7t8YGrU0IQ8YBkpogxavWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJVt47Yk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tEiLZn92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767613677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FTq0SRVG2GhbxGwoJ2wHpDXS98n9lOz+EoWA2XjToqk=;
	b=gJVt47YkL+6vTkuRy7dPyvSoD9jKjHAwUCSWtqHGyjwS9uDDwQWnfiMRKgWQCuBgPL3Adk
	YGVL8dOgULWpcl5i1kktFY1oSbOooGN1S1Itjev4rv9LttXh1j6BxHDHOT/LKD133UqFU6
	MLf6N1UomIlKLnMM9YItoRsPVZacIcc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-BIG_vnqUN12Ar_TBifK7zg-1; Mon, 05 Jan 2026 06:47:56 -0500
X-MC-Unique: BIG_vnqUN12Ar_TBifK7zg-1
X-Mimecast-MFC-AGG-ID: BIG_vnqUN12Ar_TBifK7zg_1767613675
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8068137479so974167366b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767613675; x=1768218475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTq0SRVG2GhbxGwoJ2wHpDXS98n9lOz+EoWA2XjToqk=;
        b=tEiLZn92WwFVrPmGWgHjbkHAmtFaZqjaqUvTfWi9l7wwcD3/AK1nJivx7yMTGAM81+
         Xe2/EcWcy4ccGN919XN6wHb8nsJbgqFyk3e7Dl7ney5jdDIOWKB9yJ5TVfaXvy8bK8i4
         kf+UwBAR5t0qaGUkhDLNlBmLd4piCTymf3biDnDYud2B7ZWGQtE0BOe9WOEo8jlk8tqb
         FD83kVN1gvNlR3J9cbsyC/GLPvRew9Zu1HgduIeAJt0wNkBTQmfmtpyWbgdNAykqwSnd
         rjC/07zC8CIDbt1lb5L7UkB5ZflzrU4T4/8glGqNytJS59L7wH05tQSj3xzX2dhrRJ4T
         nAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613675; x=1768218475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTq0SRVG2GhbxGwoJ2wHpDXS98n9lOz+EoWA2XjToqk=;
        b=G/T7VbT4HfceYC/QxVy8MKLkU34QkuokuOlhn9eAO/MvrkddawcTPPNcci6Lqr+Rha
         LevcXitG9jFB9biboQMdevoGqLYpRuPkzSXDjB2AzsHr2CghgxVBYhfRC+CeHxYMNnob
         kcwSIBwDXs2LB3fCluQd0PRlHVbSlCAWYQpCo/isul0txYAs3W4kHSMFFCrXlAThk2De
         MFovvOG4pGTBK2Az+ZCpigkrmDBOOsfQK4Kyj6YbpZ1I9dMipq+ZCMRRMUYL2EQY6Hvi
         hruR+Row+eD8ieohB2kY+c6/pnZV67G41TEDDEpSKueQPr4q8h2ryKRMjaiGp2al3FGg
         UILQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnhhF+f1tEiURkcq5ljBAEn7+e+/RY4S5Jsh09yUdMn9gTx6fajtpE9sO67xdRdiLiLLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG65qrIWpX7W5R0VlP4giiukt0w5bSoEVc3eRfha1NoLVbBtZu
	+NOy1KssyVZ8iGOsDVhG4HHJnpYWOBJfT1AfHry4Ee7gU8M1KXGtbksxtbXdhT5FqF8ynC66iZH
	6hkZShn0Zs0FSpMPHzOTFnibgj1RvSF1rTD1LDJcJUpOYGl18rvIBbA==
X-Gm-Gg: AY/fxX6gxQkbu8xYRW8hgdKAncEbnJXTn0YXHJHsfz/2s8nnl9q0tlx2BpjWLWzpj5A
	XSGMSYWVdAjvniohTdYUwVdRbds1x4n2QCAdkfasknsckvt1U1KtqFO8IUMLWXakYAU3fWIkytU
	2WUaBZWc30hNREBg3Orjs3z5P8RZeM+DL26CGECP5X3UpMouETEwzDHXixeg+UEa0LRhjHLJuRm
	Tn+XalJ8AzX8jw2pp6bpMsB0nFlxJ2lC96lgHBAWI9b/G63CPMKRyn6CZ9GgtWoG1lq8Scvd7hO
	lBIDgIdebXkSZkox+tTlqWh0FDaRI6AAvFdAHTlgul3KT4BdeQrl4ZlN6wLF6fuIJsKsgp484On
	JtXwmz3tttGMnW8F1neqnslv4ezE9Sz4ibKsO
X-Received: by 2002:a17:907:cb09:b0:b83:8fc:c64b with SMTP id a640c23a62f3a-b8308fcf401mr2519597366b.38.1767613674986;
        Mon, 05 Jan 2026 03:47:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOO1wGyvAPubPA3xIUEgRxLSshivKNVRBI838uDhukv4Vv0lIJ9Qr6trIs7oNMz6CK4yHlTQ==
X-Received: by 2002:a17:907:cb09:b0:b83:8fc:c64b with SMTP id a640c23a62f3a-b8308fcf401mr2519595466b.38.1767613674496;
        Mon, 05 Jan 2026 03:47:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5519158466b.10.2026.01.05.03.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:47:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1E9E3407E7D; Mon, 05 Jan 2026 12:47:53 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, test_run: Subtract size of xdp_frame from allowed metadata size
Date: Mon,  5 Jan 2026 12:47:45 +0100
Message-ID: <20260105114747.1358750-1-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The xdp_frame structure takes up part of the XDP frame headroom,
limiting the size of the metadata. However, in bpf_test_run, we don't
take this into account, which makes it possible for userspace to supply
a metadata size that is too large (taking up the entire headroom).

If userspace supplies such a large metadata size in live packet mode,
the xdp_update_frame_from_buff() call in xdp_test_run_init_page() call
will fail, after which packet transmission proceeds with an
uninitialised frame structure, leading to the usual Bad Stuff.

The commit in the Fixes tag fixed a related bug where the second check
in xdp_update_frame_from_buff() could fail, but did not add any
additional constraints on the metadata size. Complete the fix by adding
an additional check on the metadata size. Reorder the checks slightly to
make the logic clearer and add a comment.

Link: https://lore.kernel.org/r/fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn
Fixes: b6f1f780b393 ("bpf, test_run: Fix packet size check for live packet mode")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..e6c0ad204b92 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1294,8 +1294,6 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			batch_size = NAPI_POLL_WEIGHT;
 		else if (batch_size > TEST_XDP_MAX_BATCH)
 			return -E2BIG;
-
-		headroom += sizeof(struct xdp_page_head);
 	} else if (batch_size) {
 		return -EINVAL;
 	}
@@ -1308,16 +1306,26 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		/* There can't be user provided data before the meta data */
 		if (ctx->data_meta || ctx->data_end > kattr->test.data_size_in ||
 		    ctx->data > ctx->data_end ||
-		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
 			goto free_ctx;
-		/* Meta data is allocated from the headroom */
-		headroom -= ctx->data;
 
 		meta_sz = ctx->data;
+		if (xdp_metalen_invalid(meta_sz) || meta_sz > headroom - sizeof(struct xdp_frame))
+			goto free_ctx;
+
+		/* Meta data is allocated from the headroom */
+		headroom -= meta_sz;
 		linear_sz = ctx->data_end;
 	}
 
+	/* The xdp_page_head structure takes up space in each page, limiting the
+         * size of the packet data; add the extra size to headroom here to make
+         * sure it's accounted in the length checks below, but not in the
+         * metadata size check above.
+         */
+        if (do_live)
+		headroom += sizeof(struct xdp_page_head);
+
 	max_linear_sz = PAGE_SIZE - headroom - tailroom;
 	linear_sz = min_t(u32, linear_sz, max_linear_sz);
 
-- 
2.52.0


