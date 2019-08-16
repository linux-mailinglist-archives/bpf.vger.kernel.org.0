Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBE90AFB
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfHPWcU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 18:32:20 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44639 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbfHPWcU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 18:32:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44E342007;
        Fri, 16 Aug 2019 18:32:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Aug 2019 18:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=nULmcyQSNr8cA
        ELFcrkB+0TUhwAeBpe1wH20rK6qw/k=; b=NMhyH+jiRhrSy2brSY3lU1nZBqFP1
        W8GX++tTQhQA4yyPYYyUnFSbZgHUj+vMi5pi41nUZMgvkTOoZrNJOjIYfwGv8+Ei
        IqjOEcQP1kYh+BVN15OgmdKLk01jSEwtHVbJbhGPbVimC34HjRB78VzeoYIfOno/
        mWNQrKy9YHz9/6nPCTia9UWV6qDg2a19eazMLb/xOY0TwZtRK+Z1cRt13VaUYXH4
        tViHao4oFagpIccy75kwLUTC1KqpAaV0ErTXP5KVVgnTYpXxUmP02ZB2MdUhNZ5k
        bvPLJqDL3gZeMaS8GV98OS3hgDsFNXRieMCKZIW8xLczQ4pk2twkQW8RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nULmcyQSNr8cAELFcrkB+0TUhwAeBpe1wH20rK6qw/k=; b=c9etP3Rm
        xbrP3YguVt+iLsILMZzSo3wa24oUzSg+zC6xrZPgE7QjP7UrbgX5xibfPkbt7VLY
        Cd2FbkOtV+aH+s/sNeJXlvobJrEdqCPAyGm+nVZ5uwZKPiICiF3yRlFCKWVkTqs9
        Pwbc4PwBGGJnBlrUZRuA6RZU5suMrRdVCctfvDilXMNF9Ew/5x413/P2f/IrDFuM
        T/8m0HhEywbWKtvGbpFBCGj1WdnqgcUZhp9hCcuDV/DBtWIhgfTf80YYU2r2/v8k
        ho3H4cPgA6OY7ZvVNdW/9aCkWhb3XrGBKy0BMgTLJ+XLak4C6S89CIwr5xzfJmMp
        HFcCoODihIbl+A==
X-ME-Sender: <xms:8i5XXZUn9S2vUtlP8DRIDrWvemhAxJOLPdWA5VWsekMMzCtaJKzxDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:8y5XXd2tcickRucyFxBkyM7q-xCmhqHu5XsTYwkJ0tCoFc1VqW4W2Q>
    <xmx:8y5XXQaCb4OuRyGwpaOPvVMapfjd40ZjmKnT_Rt5Mi0drpWBtXvJGw>
    <xmx:8y5XXQrK0kUx6R2MWcsYltrCI8W66cdStlxhJv-rgOuXijuC13TJ5w>
    <xmx:8y5XXbvI-mQC7ZrtVaTl5T5j-DDFEWn7F6q_h2V_GYK4A7McFDnO7g>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CCD58005B;
        Fri, 16 Aug 2019 18:32:17 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/4] libbpf: Add helpers to extract perf fd from bpf_link
Date:   Fri, 16 Aug 2019 15:31:47 -0700
Message-Id: <20190816223149.5714-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816223149.5714-1-dxu@dxuuu.xyz>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is sometimes necessary to perform ioctl's on the underlying perf fd.
There is not currently a way to extract the fd given a bpf_link, so add a
a pair of casting and getting helpers.

The casting and getting helpers are nice because they let us define
broad categories of links that makes it clear to users what they can
expect to extract from what type of link.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c   | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2233f919dd88..41588e13be2b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4876,6 +4876,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 
 struct bpf_link {
 	int (*destroy)(struct bpf_link *link);
+	enum bpf_link_type type;
 };
 
 int bpf_link__destroy(struct bpf_link *link)
@@ -4909,6 +4910,24 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
 	return err;
 }
 
+const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link)
+{
+	if (link->type != LIBBPF_LINK_FD)
+		return NULL;
+
+	return (struct bpf_link_fd *)link;
+}
+
+enum bpf_link_type bpf_link__type(const struct bpf_link *link)
+{
+	return link->type;
+}
+
+int bpf_link_fd__fd(const struct bpf_link_fd *link)
+{
+	return link->fd;
+}
+
 struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 						int pfd)
 {
@@ -4932,6 +4951,7 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 	link->link.destroy = &bpf_link__destroy_perf_event;
+	link->link.type = LIBBPF_LINK_FD;
 	link->fd = pfd;
 
 	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
@@ -5225,6 +5245,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 	link = malloc(sizeof(*link));
 	if (!link)
 		return ERR_PTR(-ENOMEM);
+	link->link.type = LIBBPF_LINK_FD;
 	link->link.destroy = &bpf_link__destroy_fd;
 
 	pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e8f70977d137..2ddef5315ff9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -166,7 +166,20 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
+enum bpf_link_type {
+	LIBBPF_LINK_FD,
+};
+
 struct bpf_link;
+struct bpf_link_fd;
+
+/* casting APIs */
+LIBBPF_API const struct bpf_link_fd *
+bpf_link__as_fd(const struct bpf_link *link);
+
+/* getters APIs */
+LIBBPF_API enum bpf_link_type bpf_link__type(const struct bpf_link *link);
+LIBBPF_API int bpf_link_fd__fd(const struct bpf_link_fd *link);
 
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4e72df8e98ba..ee9945177100 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -186,4 +186,8 @@ LIBBPF_0.0.4 {
 } LIBBPF_0.0.3;
 
 LIBBPF_0.0.5 {
+	global:
+		bpf_link__type;
+		bpf_link__as_fd;
+		bpf_link_fd__fd;
 } LIBBPF_0.0.4;
-- 
2.20.1

