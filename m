Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFC13AFD3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgANQqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:46:53 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35525 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgANQqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:52 -0500
Received: by mail-pl1-f201.google.com with SMTP id v24so5386952plo.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQls5+iJi5Kqz7m3pR6x7QjrYUU6eZohn0NALbSGdKM=;
        b=fxhBY6GJyfZmJR7rTwfsKpKUIE04Kq0SWTO9fSrJydbyqAZ42ZVfBxUf2cZ1MzpoXX
         HITp9Cai+fr1dHgI3V51RVruG5RorGsWMyN5/CI7b6DOMq9eDOdfUXoxNB7vw3CJp2v0
         jcGjw1bpE3K2LG3UQz3ZQoc/7rjuvDUibLkKhQfGlzDsPtd6e7oOT9eD1AdlGH3XYbIS
         O5xCae37Owl9agHMXCJNt1obzV2ks2PQVaTz5MlrTqAZbop1P4zEZJSozMoJD+PUMbyG
         GtfhTT943n+DR6wff+3Iy5x13KDeRAiuABvRCE0kTCuKHTmnXut7e24JHadrdTVFomMJ
         OJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQls5+iJi5Kqz7m3pR6x7QjrYUU6eZohn0NALbSGdKM=;
        b=jxaxjeJpl1JQ6gduRxQKtJ/q1q2FaIK2o/H5OMimBZX2woeSF/47FRbKZD2K8FJRMB
         kbFXgvaxgefUIARH5al1cb3S54TAVjQ5HWrIp68DZ+Uhr+d+Kl9zCWoNo2iVYIsNGFMP
         3kD5qb8TYPmmXzfe55svhEi/Zw+dy0HLAggfyhTCBpPkpJ/qzAB+i8joZ5Jmw59LZ3Me
         XsAhcsE+3SosMguK+kqWeAGAMNFxECzdeZb4AbmGq8mo+xxMGL4mTQinJJxkTmAk1Ao7
         FAij7d0+ayFOkdpvB7nonvsmNUy38nRcGgWLyoaKyHAt2ZqL2zKg4WRtn3OOv86fVUvb
         8IZg==
X-Gm-Message-State: APjAAAU9qk5fPddszyVm8EteM3aHVLdNozv9J3zdvbLcwwYoXBW0TLbV
        IWIuZZKOs5f7xmzIlu+QMTd2PkOB0G8V
X-Google-Smtp-Source: APXvYqz4O0SYpBmBS3JghD5AxAlsNFp6IkPmhyVtKyPudG10ac42CeBOdTM+nz5pu1/pgfl7g9k/aFCkvHyF
X-Received: by 2002:a63:4a1c:: with SMTP id x28mr27353866pga.7.1579020411670;
 Tue, 14 Jan 2020 08:46:51 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:11 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-8-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 6/9] tools/bpf: sync uapi header bpf.h
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

sync uapi header include/uapi/linux/bpf.h to
tools/include/uapi/linux/bpf.h

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 52966e758fe59..9536729a03d57 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -107,6 +107,10 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_MAP_LOOKUP_BATCH,
+	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+	BPF_MAP_UPDATE_BATCH,
+	BPF_MAP_DELETE_BATCH,
 };
 
 enum bpf_map_type {
@@ -420,6 +424,23 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_*_BATCH commands */
+		__aligned_u64	in_batch;	/* start batch,
+						 * NULL to start from beginning
+						 */
+		__aligned_u64	out_batch;	/* output: next start batch */
+		__aligned_u64	keys;
+		__aligned_u64	values;
+		__u32		count;		/* input/output:
+						 * input: # of key/value
+						 * elements
+						 * output: # of filled elements
+						 */
+		__u32		map_fd;
+		__u64		elem_flags;
+		__u64		flags;
+	} batch;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

