Return-Path: <bpf+bounces-79409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE6D39CD1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EDAF300286F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DB626E6E1;
	Mon, 19 Jan 2026 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M12IOvm+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DE2135B8
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793204; cv=none; b=VBDXfcrVMUs5ls3qaxCJReecWQ45nfC0MR+kIKFFHNgMAYC4fZA5wSVqY2lC55V067XYcibm/bk5cVmxwR8WMOJat/lJW3DPV2E1E0zLwz01mbr86acma7BjaMUlzuUq8VcsyQWtNio4QXnZFTMpL5P8ikx/CMvU7ruyrmwtaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793204; c=relaxed/simple;
	bh=aEw1imkLf5wrWkotMxEW4yfr8s+cq8tJZ3ShfO4l2Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXKa7/9/mHBSlMUDrbH3lhyBh+KPWAXMzLYU48DME6Z4xj8W3EC2+7cOk5+jT6NVVQjRiiKwn8fYw4euPk4XRXd+uURonb0YPnOkPd7DvogY4FekiMJge08ouerRUC0aC9KOmE0ZU0n4EqYX2Nf8DGsLjU9tUU13BuLnqmxJvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M12IOvm+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw3aB1Il7lON1+TKtraAyWydt+eFZrLxkMUyC2AOIMc=;
	b=M12IOvm+MDa/RbWrJ2iTOlymhPvuUhI8kZiMPonjF6BfFxBAuov+K0TwyGMHqhZ0l1OkBN
	iQPxdtJR5oUyhGvg5zgbmPPD1wZErPChZah1biiqUS9HRrfWwhR/9YAk55/1Qhvx9ZK0cA
	C/plkFETYgliJ/B6ohJpj2bCZah2fUA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-oldMCqooNXCBv0xnVXj0ww-1; Sun,
 18 Jan 2026 22:26:40 -0500
X-MC-Unique: oldMCqooNXCBv0xnVXj0ww-1
X-Mimecast-MFC-AGG-ID: oldMCqooNXCBv0xnVXj0ww_1768793198
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08771956046;
	Mon, 19 Jan 2026 03:26:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5642F1955F22;
	Mon, 19 Jan 2026 03:26:26 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 07/13] kexec_file: Implement copy method for parser
Date: Mon, 19 Jan 2026 11:24:18 +0800
Message-ID: <20260119032424.10781-8-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Copying the bpf code parsing result to the proper place:
image->kernel_buf, initrd_buf, cmdline_buf.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_bpf_loader.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index bd6a47fc53ed3..5ad67672dead1 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -82,6 +82,7 @@ static int __init kexec_bpf_prog_run_init(void)
 late_initcall(kexec_bpf_prog_run_init);
 
 #define KEXEC_BPF_CMD_DECOMPRESS	0x1
+#define KEXEC_BPF_CMD_COPY		0x2
 
 #define KEXEC_BPF_SUBCMD_KERNEL		0x1
 #define KEXEC_BPF_SUBCMD_INITRD		0x2
@@ -281,6 +282,32 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 			}
 		}
 		break;
+	case KEXEC_BPF_CMD_COPY:
+		p = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
+		if (!p)
+			return -ENOMEM;
+		memcpy(p, buf, cmd->payload_len);
+		switch (cmd->subcmd) {
+		case KEXEC_BPF_SUBCMD_KERNEL:
+			vfree(ctx->kernel);
+			ctx->kernel = p;
+			ctx->kernel_sz = cmd->payload_len;
+			break;
+		case KEXEC_BPF_SUBCMD_INITRD:
+			vfree(ctx->initrd);
+			ctx->initrd = p;
+			ctx->initrd_sz = cmd->payload_len;
+			break;
+		case KEXEC_BPF_SUBCMD_CMDLINE:
+			vfree(ctx->cmdline);
+			ctx->cmdline = p;
+			ctx->cmdline_sz = cmd->payload_len;
+			break;
+		default:
+			vfree(p);
+			break;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.49.0


