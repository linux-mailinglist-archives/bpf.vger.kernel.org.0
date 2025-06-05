Return-Path: <bpf+bounces-59700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20080ACEB58
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1C189B97B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 07:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1272066CE;
	Thu,  5 Jun 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uLgXYQ7T"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554B201032;
	Thu,  5 Jun 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110178; cv=none; b=d2Cb8e6n1HSf5ZF+5uLE60Zt0jUfTsAMAk71hIFx+0jcXrQzlOgpI6B39DymbbXWm1+M1kbPWR5UmNYiEXh2bLsRS/Tj/DKzXnpnff5R07Uy4NecqZjUgL6nKMuLRRNqXhZO/QSpigcrKsmrCHglrOr0zQdgp294n+s3jS364lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110178; c=relaxed/simple;
	bh=WhtXNG/sF0mg8Hxs4NlLF3kfugzYfq/+M0VX23qYy7s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PC0vMd08Ojqbks90INab7iWsWB0yhp3WTPtgniSNat1+2iW8vdnnTLFTDZhm9KzN7NPHv1+ite01cc7+KcrElbPmqfxXwh4M5S3pmLiKDUfqnYfH7U/UTBVI4wq8tt0iSYFXKqsgJkZO6DHzzWiE1XAISWmZ+62Ktxsx1W4DboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=uLgXYQ7T; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749109869;
	bh=KGdcSsdIA4MrHGZNiW7o/ICS1J0ps9u96VST8rkt45k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uLgXYQ7TryKIU15g5ziG1/V2J5bdlPtkZ5+PVMNpPdugQ4Vax/V/L2conTy6ZaBZx
	 GUcjdxgByNMs1NjbSoYKsrv9HEQmzgmaIMSWkmf8/qgCC4bHRVnGveKdzmtB5t0L2T
	 eaHVCQR9ZylyZDnzEep+az/LNh2Eblh1KcB3xDdk=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id CC4A785D; Thu, 05 Jun 2025 15:51:04 +0800
X-QQ-mid: xmsmtpt1749109864twi44hfkg
Message-ID: <tencent_FB1D31D70047E82DCBF3D257C5ED75653405@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5SLh50X53HP3g51On3U391aYFG9zbjgvenvWjEUWP+y37mXdQ1I
	 UgXtV3YewOmkeO1vGYQUqrZoRw3yDyf1OL5L/WSdQtZuWxvcNGJK+ccHbEvkq2XNNubS8d9STHCy
	 BaqDyAyVwn7wZqh/vUeoR6T11cn4uCK+jjiWYf25h8yudglPaGuQxK3rxEuZ5lGYraVcPDQKyJtb
	 HB0UvU5loWbK/sCV0YHCvqEdeweijS18P8P72C5Q5loxkam+VjHl04V8h++mBbe6aDvDcdTT4Ts9
	 kCfWIoTAYf5OKozJ6WQMfFr9osqvWo1hTsWNDQc3KoIHqDH6sTBE8Uxj0O0YkIVthboCk2i+ud3m
	 hdO1SAVfcTy7cU2unqbfJXwo1dhyoFD5EwYoIqkkOpRtN8DOu5mLhYVBC/15t3OSJIum5chhOqN6
	 cxxv7dqGcNRC6uZqUCiIvpJrO0GhCzKa1dLB5ZxoukG148Cun9fv9cyAv0t70ekPMGfLxPqnW0AZ
	 jxHl0Mln1gpHzC8jwwb+W9QZYo8pMCSbKGHofzUWxTO2jH4mwix3mQYvZ6iT5y/7wBhGgYVtpxGW
	 UvzeqTNftudLhTatYPEOnO4fMe9dvi2vkmyONEY9hXpnC5gCgqJeuFhN15eKtsAsIAgX1Kl8h/Ij
	 q2dEKeV7ar0o4qyzS5QR7TejjMyFDtdnLtkxI7caO+nMmaiAFKV0vyVtbXtYDwnyIsmo+DL9grWS
	 v4ioYtg80Yc2cCPmARkC5GFVIYX7704DpFvJ+xlBa7ibDH1uMSCFD7kwyMTSi7rg04rr3qMj5sG8
	 CnIxkwKwxkwrhtZK6UirzZEuA6Z0hTo8LCMVr55Wfiqzg20pBqF3Q1TQ+Vu+o3Sw8HjkyOqFJ0Um
	 kF8Co3cxVOIFCrNe+1qNM4RW6YIGjQomLsY9T2FdM6H4OfnxvhGr9p9eqnypcr1HsMDXL7SfNoq2
	 j3Q7B2kuul0SWppnDZge3su5ZOXvMRFPuA+IYHVLlmlN42EF86mmQIQhN+FLcOfWcwnf33qNA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Rong Tao <rtoax@foxmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com
Subject: [PATCH bpf-next 1/2] bpftool: skel: Introduce NAME__open_and_load_opts()
Date: Thu,  5 Jun 2025 15:51:02 +0800
X-OQ-MSGID: <2b7aff0ccfd7a8e017f5568b476fdb3b8d5f9b2e.1749109589.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749109589.git.rongtao@cestc.cn>
References: <cover.1749109589.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Introduce functions that support opts input parameters, Obviously, it is
more convenient to use. for example, skel with name=tc will include the
following functions:

    static inline struct tc_bpf *
    tc_bpf__open_and_load_opts(const struct bpf_object_open_opts *opts)

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/bpftool/gen.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 67a60114368f..1487e61c6970 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1371,6 +1371,7 @@ static int do_skeleton(int argc, char **argv)
 		#ifdef __cplusplus					    \n\
 			static inline struct %1$s *open(const struct bpf_object_open_opts *opts = nullptr);\n\
 			static inline struct %1$s *open_and_load();	    \n\
+			static inline struct %1$s *open_and_load_opts(const struct bpf_object_open_opts *opts = nullptr);    \n\
 			static inline int load(struct %1$s *skel);	    \n\
 			static inline int attach(struct %1$s *skel);	    \n\
 			static inline void detach(struct %1$s *skel);	    \n\
@@ -1438,12 +1439,12 @@ static int do_skeleton(int argc, char **argv)
 		}							    \n\
 									    \n\
 		static inline struct %1$s *				    \n\
-		%1$s__open_and_load(void)				    \n\
+		%1$s__open_and_load_opts(const struct bpf_object_open_opts *opts)\n\
 		{							    \n\
 			struct %1$s *obj;				    \n\
 			int err;					    \n\
 									    \n\
-			obj = %1$s__open();				    \n\
+			obj = %1$s__open_opts(opts);			    \n\
 			if (!obj)					    \n\
 				return NULL;				    \n\
 			err = %1$s__load(obj);				    \n\
@@ -1455,6 +1456,12 @@ static int do_skeleton(int argc, char **argv)
 			return obj;					    \n\
 		}							    \n\
 									    \n\
+		static inline struct %1$s *				    \n\
+		%1$s__open_and_load(void)				    \n\
+		{							    \n\
+			return %1$s__open_and_load_opts(NULL);		    \n\
+		}							    \n\
+									    \n\
 		static inline int					    \n\
 		%1$s__attach(struct %1$s *obj)				    \n\
 		{							    \n\
@@ -1530,7 +1537,11 @@ static int do_skeleton(int argc, char **argv)
 									    \n\
 		#ifdef __cplusplus					    \n\
 		struct %1$s *%1$s::open(const struct bpf_object_open_opts *opts) { return %1$s__open_opts(opts); }\n\
-		struct %1$s *%1$s::open_and_load() { return %1$s__open_and_load(); }	\n\
+		struct %1$s *%1$s::open_and_load() { return %1$s__open_and_load(); }\n\
+		struct %1$s *%1$s::open_and_load_opts(const struct bpf_object_open_opts *opts)\n\
+		{							    \n\
+			return %1$s__open_and_load_opts(opts);		    \n\
+		}							    \n\
 		int %1$s::load(struct %1$s *skel) { return %1$s__load(skel); }		\n\
 		int %1$s::attach(struct %1$s *skel) { return %1$s__attach(skel); }	\n\
 		void %1$s::detach(struct %1$s *skel) { %1$s__detach(skel); }		\n\
-- 
2.49.0


