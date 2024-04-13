Return-Path: <bpf+bounces-26712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA58A3ECB
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F401F21789
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724715676F;
	Sat, 13 Apr 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="YP7Zf++E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEDbRJR4"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80323AD;
	Sat, 13 Apr 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044354; cv=none; b=e/Q4duJwNmLkdzodjO2YTeWxdqMJhpICWzbkKt/NXt6PDrhcE67wlN9gAn13LKVBNSKPvNn6ovDTQ8kIXNfhs0t0gzbQsJl8CXrEGGaV6tQHrpYdSVoxJ08fscTqa45t5Py5aPj//4ofK3980ITTGPUj4nZZLer7lIg8d1uYPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044354; c=relaxed/simple;
	bh=HmOzFHNly2hJix0cNa5XXicHRCBr5Q2VGfkGUEaU+8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UC2uycRFa1hy2plxZ2BRSeIFF7WVrPyDviuoLANADDkQwaNpB/owqAf2HxJiRTgU+jG7yddLg8RiNT89K37lnjnXJPh8qEH/7KeKTzUbH9XnYeXhk/VauHgF8Vl07lkJEwzWMK3XwFXK3lG0JeyYr0syLtkYIMMqh9XjEYbJ2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=YP7Zf++E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEDbRJR4; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6FEF3180010B;
	Sat, 13 Apr 2024 17:39:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 13 Apr 2024 17:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1713044349; x=1713130749; bh=qimSkpcSGfdMhl5p572yB
	CeqpY7AKr5gRT2/6lHtvBQ=; b=YP7Zf++EPje/7vy+gilI9NgkNwFd5+RDxRDX9
	b1XLYE72FAOcuAxfa/gryVn4+aLTPTc1407JD+pxVkb/AhZMOS/G/J4wdbRhiam0
	9jpjXQ7vDwSQRzRUETqSMGajif308NX9mzBLvEF7BnFh4gnNPOHnTZ3nqRlqJcua
	Hkui5qVOJgnyMWHcWEp1Pu+fvOF43gBd/btJrhEbAImPThxg3j/FfiXlr0AJL6Vg
	Nv++zPK+k62SlU/Q4JlRDNlo8QmQhgVR6zuirvVgt93y9Ijq7HxuxnXZGuEN2Fx4
	ggZ7gPkNeBhX562sbhQZr/S2a4kUWjnQ6+rT2745+sG6H0qPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713044349; x=1713130749; bh=qimSkpcSGfdMhl5p572yBCeqpY7A
	Kr5gRT2/6lHtvBQ=; b=JEDbRJR4ZuVVHyqFczmI3ptR2M58oIRKFtlwb10UU/8I
	GzR6x+GmPFViUK7IbWrJECbBxNBOP8XOq4/NsCB1twRLlqJ0aVvvcCjd/mQlPp/L
	gyMHwmSSpwrtpG2I5fUIc1BmFoRt1Y4QkytrymElG2KTsRJXfm4IJfSY1Rj0n3V5
	Sq5Jd35jr47otepHYhnAaBtE1g/AFjR1OP/aP4oe5dnNG7HCWF+qvxtNecw0eQYv
	2y7b/6UfPjgrRgejK3WgXigtSD1RyqkN0jPxdjTu77oNc3MPQ4l/KVFJpmsA0c94
	jgx/wxvBa2EXx66XmIC8Ave6idsBGLgJzJO20InVcQ==
X-ME-Sender: <xms:ffsaZrFa6_fu-gw7rv81ZtmvWKMNIz-ZT3b5yXUxzkAFyEN_HVjLbg>
    <xme:ffsaZoW_0mNr8mhFo1PZWSuRrXVc09P00l9RWJmSqVuMNAOlrFBdKDMor1P7LK5xg
    so3vy_KVlW0mpeknK8>
X-ME-Received: <xmr:ffsaZtJhybQrzz7FsCHOsmNo60dPFkXfxfrsgPTwCJyShZjy9ato0yXQB2S9VDFKzdK8WfD3keG0reCDa1hNt0AIjo65axA-nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeijedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhi
    nhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvg
    hrnhephfffieeivdeiheegleejtdeuieejlefgffejfeehhefhheffieefgeduhfehiefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvg
    esnhgrtggthidruggv
X-ME-Proxy: <xmx:ffsaZpG-HHZux2KeLb0G5Uqf4HHFErQPfoUcZuGSwzF8jdcg-3Pu8w>
    <xmx:ffsaZhUuY8VENpZmbshqgZez_h9D417ugrU1idMQ04d9k-nKYjK6uw>
    <xmx:ffsaZkMZ5Fiep3m6VP0U_9l3QFIgBdMj1_7d6IFbkYIelQtTBGKcIA>
    <xmx:ffsaZg2FMp7Y3biik2FOCIEHghnOmhIenhuvA-CTN5r3FPFjtXq6ow>
    <xmx:ffsaZlmO1m6u6yLhnDXjwc0nVH0S2wZ4xuxPUYrdXOD-mSJV2C0iYqVR>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 17:39:07 -0400 (EDT)
From: Quentin Deslandes <qde@naccy.de>
To: bpf@vger.kernel.org,
	Quentin Deslandes <qde@naccy.de>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next] libbpf: print character arrays as strings if possible
Date: Sat, 13 Apr 2024 23:39:04 +0200
Message-ID: <20240413213904.146261-1-qde@naccy.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the new print_strings flag in btf_dump_type_data_opts. If
enabled, libbpf will print character arrays as strings if they meet the
following conditions:
- Contains a nul-termination character ('\0')
- Contains only printable characters before the nul-termination character

If print_strings is set to false (default value), the existing
behavior remains unchanged.

With print_strings=false:
.str_array = (__u8[14])[
    'H',
    'e',
    'l',
    'l',
    'o',
],

With print_strings=true:
.str_array = (__u8[14])"Hello",

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 tools/lib/bpf/btf.h      |  3 ++-
 tools/lib/bpf/btf_dump.c | 25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..cf190900d483 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -284,9 +284,10 @@ struct btf_dump_type_data_opts {
 	bool compact;		/* no newlines/indentation */
 	bool skip_names;	/* skip member/type names */
 	bool emit_zeroes;	/* show 0-valued fields */
+	bool print_strings; /* print char arrays as string */
 	size_t :0;
 };
-#define btf_dump_type_data_opts__last_field emit_zeroes
+#define btf_dump_type_data_opts__last_field print_strings

 LIBBPF_API int
 btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4d9f30bf7f01..d396a10f37b2 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -67,6 +67,7 @@ struct btf_dump_data {
 	bool compact;
 	bool skip_names;
 	bool emit_zeroes;
+	bool print_strings;
 	__u8 indent_lvl;	/* base indent level */
 	char indent_str[BTF_DATA_INDENT_STR_LEN];
 	/* below are used during iteration */
@@ -2021,6 +2022,21 @@ static int btf_dump_var_data(struct btf_dump *d,
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }

+static bool btf_dump_isprint_str(const char *data, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; ++i) {
+		if (data[i] == '\0')
+			return true;
+
+		if (!isprint(data[i]))
+			return false;
+	}
+
+	return false;
+}
+
 static int btf_dump_array_data(struct btf_dump *d,
 			       const struct btf_type *t,
 			       __u32 id,
@@ -2047,8 +2063,14 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
 			d->typed_dump->is_array_char = true;
+			if (d->typed_dump->print_strings &&
+					btf_dump_isprint_str(data, array->nelems)) {
+				btf_dump_type_values(d, "\"%s\"", data);
+				return 0;
+			}
+		}
 	}

 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2533,6 +2555,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->print_strings = OPTS_GET(opts, print_strings, false);

 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);

--
2.44.0

