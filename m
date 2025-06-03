Return-Path: <bpf+bounces-59482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B190DACBF52
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC51890889
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D465187FE4;
	Tue,  3 Jun 2025 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ge0oo5IQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A5146A66
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926106; cv=none; b=Tx/CjCsj3VTS6fvaUbhoM/XtZsbkcags4dcjPwtdZ8YdTHkV5oYq/CCuo2Vcd77JVFvXBCuxc0eEbKCPjcTNONAvXtPinuZhRCwxRvogne2tHsAQtG6aS+8JYOp37RClhBih4fbQpltVahwspaZTzjqnvxN/g2Atd+OVGC72ATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926106; c=relaxed/simple;
	bh=NllOIGpaByDvSmSbLrJYL5Gk4SUKoHcjdQDk9IHf0tc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BQnI6FqrsQevobyc8eFGJxdCtyVcISGTSgS7xDcGyQs49jB98+MWDE/XDsOW4KV5uYz8OxPqeueTD4a/+iDxeJso0iJuiXhynWpiX6cb7f8Y1vNmt5PhTowtVozkCY+AaMAPyXxgGSR6m1AYMl9una2y1lgdMsh4qHEHZRk3qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ge0oo5IQ; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-60bf020e4b1so3734324eaf.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748926103; x=1749530903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQovLzfFYqS8ULAAc1LRS+ATtBISGpWrZbU6Yt/MC+M=;
        b=Ge0oo5IQ4NsF64XNN9yobCOxWvoklaEit5OElhSuRH6UeUF7Tj/GSE8Drg4mCzkEfS
         58IRWMzosVlMHftEHeR8ksTesM/JmkrEWvKXfSXkRTgF5Q9flMvz+VUXiPbROpLnc1A6
         p2pnH4O1Lw9NhAWN/jADJKTX/EhffQ1dnQU9l64IERNaWKZ2XXCFQhbzmIIEo1WWcU2M
         yrmk9NlrIEtAxbz/z7RVrAjPM535DcrDVhPZtAJq9RTeaBvmCY645EAKPD5MCkExaOI4
         tQml00dU1d3+4lKalZWdVNVJZV4V/cuGeqk4Nmb5Cul6voS4fml0uTGF/RfoLre7Kqg1
         MaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926103; x=1749530903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQovLzfFYqS8ULAAc1LRS+ATtBISGpWrZbU6Yt/MC+M=;
        b=RlX+51bktN7kQgW/loQwzIq+DPQVB1Bl0vbt1EBZvOriVuKDFtasbCUZjvwDCjwh5V
         a8ABC1Xwrl+vwkr56aX0kgaQq0QqTVzfIKML6LmD/wNBQRLIBiDmY2z2KL5mZnNnL9x6
         j+J6btuserEb8wNcwWWj+2gWVPXRXD+L/MjfikCJwR2iamucQXyXdN7jkKkjKCrLG5Ya
         8k7fwrkHJdgYSwKGl3T2+LQLZRS1cRieVfeZ2fYXmLdT+L1qSr0P+pfOMfTKtJS0eJNx
         8LbzGNTVud7JFYUEVbDLm83rQsjcke7zJ46xXVJStnbGqeD19rFuT9/yplGXd3awQ/In
         /hSg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8inViDwD11luyU3g1Je5RXUmOAYFyFiY976+x2ghoLISIRItnDbT03p5RPWfc48twp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Dj4PyqeyHSwBpfd4MAZvfu/LP0o/T1Zfgp5DBnt22Q8qLAuB
	pw2itmCY5ZHTdLm1IVWIIpUdkOHfwf63FpCo+nlG9AQXoXhEg5fig4t+nJzIByWIKSOSnX5M7MS
	hKXkescpO5HZCm99dTUhGWA==
X-Google-Smtp-Source: AGHT+IFIbl3uoV4l5J9b+gYBYAYxS0IF/Lwszpko4xEPrl37YlAgArfbXHX+mufmu2Lr7izvnMtwJQp1hAJW9Yhk
X-Received: from oabns6.prod.google.com ([2002:a05:6870:ac86:b0:2bc:6267:d082])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:7a11:b0:2d5:4f4:e24d with SMTP id 586e51a60fabf-2e92a11d025mr9741353fac.6.1748926102997;
 Mon, 02 Jun 2025 21:48:22 -0700 (PDT)
Date: Mon,  2 Jun 2025 21:48:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603044813.88265-1-blakejones@google.com>
Subject: [PATCH v2 1/2] libbpf: add support for printing BTF character arrays
 as strings
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

The BTF dumper code currently displays arrays of characters as just that -
arrays, with each character formatted individually. Sometimes this is what
makes sense, but it's nice to be able to treat that array as a string.

This change adds a special case to the btf_dump functionality to allow
arrays of single-byte integer values to be printed as character strings.
Characters for which isprint() returns false are printed as hex-escaped
values. This is enabled when the new ".emit_strings" is set to 1 in the
btf_dump_type_data_opts structure.

As an example, here's what it looks like to dump the string "hello" using
a few different field values for btf_dump_type_data_opts (.compact = 1):

- .emit_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
- .emit_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
- .emit_strings = 1, .skip_names = 0:  (char[6])"hello"
- .emit_strings = 1, .skip_names = 1:  "hello"

Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:

- .emit_strings = 0:  ['h',-1,]
- .emit_strings = 1:  "h\xff"

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/lib/bpf/btf.h      |  3 ++-
 tools/lib/bpf/btf_dump.c | 44 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..ccfd905f03df 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
 	bool compact;		/* no newlines/indentation */
 	bool skip_names;	/* skip member/type names */
 	bool emit_zeroes;	/* show 0-valued fields */
+	bool emit_strings;	/* print char arrays as strings */
 	size_t :0;
 };
-#define btf_dump_type_data_opts__last_field emit_zeroes
+#define btf_dump_type_data_opts__last_field emit_strings
 
 LIBBPF_API int
 btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 460c3e57fadb..336a6646e0fa 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -68,6 +68,7 @@ struct btf_dump_data {
 	bool compact;
 	bool skip_names;
 	bool emit_zeroes;
+	bool emit_strings;
 	__u8 indent_lvl;	/* base indent level */
 	char indent_str[BTF_DATA_INDENT_STR_LEN];
 	/* below are used during iteration */
@@ -2028,6 +2029,43 @@ static int btf_dump_var_data(struct btf_dump *d,
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
+			/*
+			 * When printing character arrays as strings, NUL bytes
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
@@ -2055,8 +2093,11 @@ static int btf_dump_array_data(struct btf_dump *d,
 		 * char arrays, so if size is 1 and element is
 		 * printable as a char, we'll do that.
 		 */
-		if (elem_size == 1)
+		if (elem_size == 1) {
+			if (d->typed_dump->emit_strings)
+				return btf_dump_string_data(d, t, id, data);
 			d->typed_dump->is_array_char = true;
+		}
 	}
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2544,6 +2585,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->compact = OPTS_GET(opts, compact, false);
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
+	d->typed_dump->emit_strings = OPTS_GET(opts, emit_strings, false);
 
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
-- 
2.49.0.1204.g71687c7c1d-goog


