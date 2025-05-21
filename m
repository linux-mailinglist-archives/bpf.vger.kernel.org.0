Return-Path: <bpf+bounces-58691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319BABFF7E
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0544E1757
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F223BD1F;
	Wed, 21 May 2025 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkqgLQAb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07D23A99D
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866457; cv=none; b=Phf5k8fnCucv7+V5CUSfUTQc1UGTFAHXz7O18Nps14g1iAiotrCXvCZ2z3LdvoETtbz2Art7erZXN4FhM2+OgKS9I/1WjLVE8ozsTF5GM5pEqJjV2rZulcgdFEvJ8+ezB2uZh8REhInZeQF4Jajop2R93e61dUT34kRLwqghkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866457; c=relaxed/simple;
	bh=aMZ4AYJ3M/DhRPmbWLQpDVxaBCdOgCFI+6QJcEMCLII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3xop7anT1ER9OArTvdASYPJ6EzQ/25VO/9B3/oSQsgyzeXvxvhkSbmQh5W8/hBUBpP1giJxpWLmrJmk7y4ZRd91B2t1i315jQZR2uAhIxzSc5bUV2h7OKYzOsyLAbiMQCFbG8HsrWweG+n5d/UOqAkjDxPeYFW2BzmuEgC84KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkqgLQAb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c9c92bb1so3496608b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747866454; x=1748471254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFzAdIN3ADd6NVAF4nynmA4pWoTI5Or9NT8etnM6Hdc=;
        b=KkqgLQAbtYA8wqzYtflF+sNQNJRgL1Cd/RY9BQBYxTSOoeXfawLQmCh++poGJvO/+8
         ZeNPftrtXZQ31eGXAsyalrPzL7vydUChzWb8YEaXZBAKf/G0hocWP/Op2cjea3vh/wak
         3onAKDkRaAizSuhoQ/0zkWvNWa+MQVO0l7EDmHXQGkR4+PHLP5OboSMYr00Eo6UDzq6n
         PyqO7cRB/LL9VP6Xq4Rbgb0DIRUXEymVNxtGXVBQDfbRnYPUXuulPeCyXoSHVZnxC8kh
         LuLSSSp8e6TgG7dEDzRDyWz9KRbsUgRmdj2U8YmbtZhMhUzT5kq1pgozaniGbj/IgC1n
         uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866454; x=1748471254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFzAdIN3ADd6NVAF4nynmA4pWoTI5Or9NT8etnM6Hdc=;
        b=dS3NwWuPhwXMdNvOdpNIg2hJMTiLpzmW3kurRh8QW11UyIZjLgvFdaAPSnxzb6F5Xw
         nHG8n2Z6RSc9TWosFDk5dZssb4LH+/1388J8anLkfbpnJ2r/N/UWwZxyNvGK4kLaoWpP
         riTMJFgZeXze4ePsktHVRtWzc8jK8d4Bsu9zaX3LHxFb2677Ab54tq7vrKKQxWWWeqz4
         Pf5jtTeCtgDOjvGsCY5H6VWv1WVbiiRlF7cwRA6K7MgNlFoBWrh5kCH11IRAN/zpChih
         P5gS6Xh/mt4FlckcUGSSFuUk06l7ZBBFb+IccyXF08a2LwTXYE2TkcjrFeEjJ01/38LV
         hipg==
X-Forwarded-Encrypted: i=1; AJvYcCWp4UnN6wEeQjPMdOp73LdmA18cejdcBTabGkoE+16fCLtirfUJKvv38rkVu56Z2bkppHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNDA1VZZ9MkRCkmhzPJ5W+nJ6FqPCa7fH9rnsxt4HzXNeT+KI
	kv8B/JZAEXeHXn2cjoD5vXmgtMTRYBzUs6peNiqT3U0FEROXikYZ2LmGgX9WByNK3AdowNTdORz
	7YmWrmCrLTpOoPv0oapAuAg==
X-Google-Smtp-Source: AGHT+IHlq2IKbk0B/4Exi52CVMnW2wIsd2uu9LhDEluot7rft40H1p6F/fVChZv0umGaaYkzUtyGx+eovn4ubOGg
X-Received: from pfxa34.prod.google.com ([2002:a05:6a00:1d22:b0:73e:1cf2:cd5c])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:432a:b0:215:eac9:1ab2 with SMTP id adf61e73a8af0-216219f04e0mr36376303637.28.1747866454479;
 Wed, 21 May 2025 15:27:34 -0700 (PDT)
Date: Wed, 21 May 2025 15:27:23 -0700
In-Reply-To: <20250521222725.3895192-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521222725.3895192-2-blakejones@google.com>
Subject: [PATCH 1/3] perf: add support for printing BTF character arrays as strings
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

The BTF dumper code currently displays arrays of characters as just that -
arrays, with each character formatted individually. Sometimes this is what
makes sense, but it's nice to be able to treat that array as a string.

This change adds a special case to the btf_dump functionality to allow
arrays of single-byte integer values to be printed as character strings.
Characters for which isprint() returns false are printed as hex-escaped
values. This is enabled when the new ".print_strings" is set to 1 in the
btf_dump_type_data_opts structure.

As an example, here's what it looks like to dump the string "hello" using
a few different field values for btf_dump_type_data_opts (.compact = 1):

- .print_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
- .print_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
- .print_strings = 1, .skip_names = 0:  (char[6])"hello"
- .print_strings = 1, .skip_names = 1:  "hello"

Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:

- .print_strings = 0:  ['h',-1,]
- .print_strings = 1:  "h\xff"

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/bpf/btf.h      |  3 ++-
 tools/lib/bpf/btf_dump.c | 51 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..be8e8e26d245 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
 	bool compact;		/* no newlines/indentation */
 	bool skip_names;	/* skip member/type names */
 	bool emit_zeroes;	/* show 0-valued fields */
+	bool print_strings;	/* print char arrays as strings */
 	size_t :0;
 };
-#define btf_dump_type_data_opts__last_field emit_zeroes
+#define btf_dump_type_data_opts__last_field print_strings
 
 LIBBPF_API int
 btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 460c3e57fadb..a07dd5accdd8 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -75,6 +75,7 @@ struct btf_dump_data {
 	bool is_array_member;
 	bool is_array_terminated;
 	bool is_array_char;
+	bool print_strings;
 };
 
 struct btf_dump {
@@ -2028,6 +2029,50 @@ static int btf_dump_var_data(struct btf_dump *d,
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }
 
+static int btf_dump_string_data(struct btf_dump *d,
+				const struct btf_type *t,
+				__u32 id,
+				const void *data)
+{
+	const struct btf_array *array = btf_array(t);
+	__u32 i;
+
+	if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NULL)) ||
+	    btf__resolve_size(d->btf, array->type) != 1 ||
+	    !d->typed_dump->print_strings) {
+		pr_warn("unexpected %s() call for array type %u\n",
+			__func__, array->type);
+		return -EINVAL;
+	}
+
+	btf_dump_data_pfx(d);
+	btf_dump_printf(d, "\"");
+
+	for (i = 0; i < array->nelems; i++, data++) {
+		char c;
+
+		if (data >= d->typed_dump->data_end)
+			return -E2BIG;
+
+		c = *(char *)data;
+		if (c == '\0') {
+			/* When printing character arrays as strings, NUL bytes
+			 * are always treated as string terminators; they are
+			 * never printed.
+			 */
+			break;
+		}
+		if (isprint(c))
+			btf_dump_printf(d, "%c", c);
+		else
+			btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
+	}
+
+	btf_dump_printf(d, "\"");
+
+	return 0;
+}
+
 static int btf_dump_array_data(struct btf_dump *d,
 			       const struct btf_type *t,
 			       __u32 id,
@@ -2055,8 +2100,11 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
+			if (d->typed_dump->print_strings)
+				return btf_dump_string_data(d, t, id, data);
 			d->typed_dump->is_array_char = true;
+		}
 	}
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2544,6 +2592,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->print_strings = OPTS_GET(opts, print_strings, false);
 
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
-- 
2.49.0.1143.g0be31eac6b-goog


