Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2962153AE
	for <lists+bpf@lfdr.de>; Mon,  6 May 2019 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEFSbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 May 2019 14:31:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfEFSbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 May 2019 14:31:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so7221898pfd.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2019 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FstzZCVNUourlCPKszpn9bb32SRAhjzysdw+vvrIXh4=;
        b=pR/MhP0a8C/4rn7h7f6KtuHjujH8POlivDuB+aDU36Q/jBPgBiGAw25b/1zZc0eej7
         7Ajb5YGFegbSah/Cp8WVamV5HEN4l9ncLTSHyHyMBunw5IWSkTQQO0kqrbQkws1H3O8c
         laukCErcKX4QcuBnE+nI1FvS2ri9wE2SScG78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FstzZCVNUourlCPKszpn9bb32SRAhjzysdw+vvrIXh4=;
        b=Z64ELRDh/j+cJknxkhXelKNnnYMubB4Pu/Z55nJbxfyR9vb/AVZMt0ll9p6rMlGFnA
         74a8KiGAqVEANb4JFJ2H0CZmfzmqcJfUYgzQSF1W0ECagfxtTUj9Kax3bCLLh+yRrMhJ
         d4m0vXxaQgLKZC5Fz67MWOa0A+McwxhJQOQHTF57c++uyA3IgcWRZ51i6ia+f6fufhBM
         SKnxQb6Vnfkzj77n7ul2659uw1Hckb7NurT8cdae1Q/1acVKVAJJ/iReO3gi+eEzSjBL
         j0+Fscr3o5j2IehmnX6zRO6OX+NtregHFYsek1I6VdAcH+3bRgPJMA9oRXLkPO2CWK9M
         8I0w==
X-Gm-Message-State: APjAAAV9BHA3bd7uOq0fjHTMQ+vN5Q9jlrBsVpfRVh1OaPrmizo8+o8o
        sQiiarMQwhl1xbY2M3Vi3mCfBg==
X-Google-Smtp-Source: APXvYqxk6tRHGmBNl5Y4dp6RElXceV2g0n+bZh4+P9RLG8k4yfZ4SvrflzQxvSoywiXAsYl8f2R6Lg==
X-Received: by 2002:a62:4697:: with SMTP id o23mr35488531pfi.224.1557167494792;
        Mon, 06 May 2019 11:31:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h30sm21412414pgi.38.2019.05.06.11.31.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 11:31:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        duyuchao <yuchao.du@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>, netdev@vger.kernel.org,
        Peter Ziljstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 4/4] tools: Sync uapi headers with new bpf function calls
Date:   Mon,  6 May 2019 14:31:16 -0400
Message-Id: <20190506183116.33014-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190506183116.33014-1-joel@joelfernandes.org>
References: <20190506183116.33014-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The uapi in tools/ needs an update after support for new bpf function
calls were added. This commit does the same.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/include/uapi/linux/bpf.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 929c8e537a14..05af4e1151d3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2431,6 +2431,18 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ *
+ * int bpf_probe_read_user(void *dst, int size, void *src)
+ *     Description
+ *             Read a userspace pointer safely.
+ *     Return
+ *             0 on success or negative error
+ *
+ * int bpf_probe_read_kernel(void *dst, int size, void *src)
+ *     Description
+ *             Read a kernel pointer safely.
+ *     Return
+ *             0 on success or negative error
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2531,7 +2543,9 @@ union bpf_attr {
 	FN(sk_fullsock),		\
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),
+	FN(get_listener_sock),		\
+	FN(probe_read_user),		\
+	FN(probe_read_kernel),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.21.0.1020.gf2820cf01a-goog

