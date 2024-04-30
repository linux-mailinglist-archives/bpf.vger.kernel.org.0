Return-Path: <bpf+bounces-28230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181B8B6C82
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1121C222CF
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436ED45BE8;
	Tue, 30 Apr 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlBNsIno"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06F45025
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464628; cv=none; b=ayJXrx+l5SEs3eHWBfcUbdNVr1d0JyBDnlhC0yKG09KycfDUuTIGoxyGndn1Rdzco7XzAvjeSOTtptUlHM8B4q8S3alSq7jFBPNULdHQpa2eW8qpLO0aaS7+1IhpdjjLZsE4l2mhXOYnlLKSyCgcdIVvoAyJdGIW9CUV/j0VS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464628; c=relaxed/simple;
	bh=aJnQaOVqTb9Bp6WurKu9D+/M2fg3HH2UMDjs7VFEYfc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVFyTUohMLjBMaOxt/9if3z3Xl8kjNwNdlcVz/gkBn83YRiyMo/pap9HHMeU8c2wJJZAX7PxkiqanZoA98urRD9/nZz6Z+2AsJKQO/aZs/OuJ9cf9c8FDM9wBeHv8d3DzgzV2fP0Y3v4JfS1Imbf8C3czEl1qKZsPA10LfItrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlBNsIno; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso8045790a12.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714464625; x=1715069425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dn8ZfWdqGEjgZZlOYuujGlK2xNApuuosoIHRPPMUK74=;
        b=AlBNsInoX2Nrg9gagBrQ+oyWq9i+pJqkbRfC8XGy+FsdAAUtMarvj9ssUcG6ysbPON
         653cGFLfnyluaF1vdsBM4AJXOMthvQvWhTd23x3Jz2n5te7DVf+2aBVBiGg8Pf6rWrfH
         UGugeDaALXXnb2qTXzN0wYUa1bTa2HHrbsoRRmcsvs0rErgLn0QTwW9GS6ALzusBtWLw
         Em9vqUeVG7ON1mppx/9hqLnH9oBLd3145uXoLuqDVQ/XwsD66NTn05mXngaztIU81n55
         CQydXUvLQjv5rd2bCtSlotXiH/YWTWhzJI5bdg/m9a4kzxKS/3AieJkm1FyaMF5k6WJT
         f9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714464625; x=1715069425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn8ZfWdqGEjgZZlOYuujGlK2xNApuuosoIHRPPMUK74=;
        b=vwFWvQ/ClZASwlmCRS1EtrSyz1/PshqK5IjEy5G1cKZtZ+V1f8VEP3ROxcsLl5TOvW
         IcWw1aoomZx93tLbwZJrHHkx4W7EtgvTYnBqKsd1akMi+5oEi55l+dqtyUPZfsMHrNuS
         LeFkQePpTty1bhhB5/FqGVNn3YaVQSv1q+oNc8ybP+Gc7fMPXzi8FsWmxsxnjKKM01yU
         O9B96uWb4lvYFzxeo4e1Wr2MKA2qWT1vHFJaLOPbZFZZ9xMwsnJaTQHERZvFNV9fQore
         W5zStuh05IA/wjn0B4nr8IQ88g1wu4rvghtTs9AcT+ep+4Yx8ntNarTiFDuFM5RuUFF+
         1xsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoP1z32Bylx0T+YevfDg8NbLIf1ipwfedgCdtP25JWb9zRGmX8mm58ONcJ+EmaHyxe3gRTOiF5DsWCyLsRGfuRF/Xu
X-Gm-Message-State: AOJu0YyyZZd2OnGlKTqZpEigMylnqEm5oWUwATO/BEoe6U4SNbbrQ9Vq
	dsxGH7TgtnqlJHlXs4ETnfPeI3IK6wcIu6W46NpVXEBJu6DShSFC
X-Google-Smtp-Source: AGHT+IE2OW3EiVqZ9qw4f6duFpq3UwxR5h68A6K2yQCn2b+l7eK5k5d0b2cQE+aqPoFWvddGf1Dy+Q==
X-Received: by 2002:a50:d7c3:0:b0:570:5e7e:474e with SMTP id m3-20020a50d7c3000000b005705e7e474emr6783894edj.22.1714464624792;
        Tue, 30 Apr 2024 01:10:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ig1-20020a056402458100b0057272ff56f3sm3014021edb.93.2024.04.30.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:10:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Apr 2024 10:10:22 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add kprobe multi session test
Message-ID: <ZjCnbvVsWFSbUEkZ@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-7-jolsa@kernel.org>
 <CAEf4Bza2oReiAMhO3bUwP9LmdQ=+u98gEd2Vz_zGmB1PUVi4-Q@mail.gmail.com>
 <ZijwsrKWCbo57vUE@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZijwsrKWCbo57vUE@krava>

On Wed, Apr 24, 2024 at 01:44:50PM +0200, Jiri Olsa wrote:

SNIP

> > see below, even if array of ksym ptrs idea doesn't work out, at least
> > results can be an array (which is cleaner to work with both on BPF and
> > user space sides)
> 
> I recall in past we used to do that and we switched to specific values
> to be more explicit I guess.. but it might make sense in here, will try it 
> 
> SNIP
> 
> > > +static int session_check(void *ctx, bool is_return)
> > > +{
> > > +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> > > +               return 1;
> > > +
> > > +       __u64 addr = bpf_get_func_ip(ctx);
> > > +
> > > +#define SET(__var, __addr) ({                  \
> > > +       if ((const void *) addr == __addr)      \
> > > +               __var = 1;                      \
> > > +})
> > > +
> > > +       if (is_return) {
> > > +               SET(kretprobe_test1_result, &bpf_fentry_test1);
> > > +               SET(kretprobe_test2_result, &bpf_fentry_test2);
> > > +               SET(kretprobe_test3_result, &bpf_fentry_test3);
> > > +               SET(kretprobe_test4_result, &bpf_fentry_test4);
> > > +               SET(kretprobe_test5_result, &bpf_fentry_test5);
> > > +               SET(kretprobe_test6_result, &bpf_fentry_test6);
> > > +               SET(kretprobe_test7_result, &bpf_fentry_test7);
> > > +               SET(kretprobe_test8_result, &bpf_fentry_test8);
> > > +       } else {
> > > +               SET(kprobe_test1_result, &bpf_fentry_test1);
> > > +               SET(kprobe_test2_result, &bpf_fentry_test2);
> > > +               SET(kprobe_test3_result, &bpf_fentry_test3);
> > > +               SET(kprobe_test4_result, &bpf_fentry_test4);
> > > +               SET(kprobe_test5_result, &bpf_fentry_test5);
> > > +               SET(kprobe_test6_result, &bpf_fentry_test6);
> > > +               SET(kprobe_test7_result, &bpf_fentry_test7);
> > > +               SET(kprobe_test8_result, &bpf_fentry_test8);
> > > +       }
> > > +
> > > +#undef SET
> > 
> > curious, have you tried implementing this through a proper for loop? I
> > wonder if something like
> > 
> > void *kfuncs[] = { &bpf_fentry_test1, ..., &bpf_fentry_test8 };
> > 
> > and then generic loop over this array would work. Can you please try?
> 
> yep, will try, let's see if it gets nicer

ok it looks better, I'll send new version

thanks,
jirka


---
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 14ebe7d9e1a3..180030b5d828 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
+
+extern bool bpf_session_is_return(void) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 51628455b6f5..f6eac16a9339 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -326,6 +327,46 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
+static void test_session_skel_api(void)
+{
+	struct kprobe_multi_session *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int err, prog_fd;
+
+	skel = kprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = kprobe_multi_session__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	/* bpf_fentry_test1-4 trigger return probe, result is 2 */
+	ASSERT_EQ(skel->bss->kprobe_session_result[0], 2, "kprobe_session_result[0]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[1], 2, "kprobe_session_result[1]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[2], 2, "kprobe_session_result[2]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[3], 2, "kprobe_session_result[3]");
+
+	/* bpf_fentry_test5-8 trigger only entry probe, result is 1 */
+	ASSERT_EQ(skel->bss->kprobe_session_result[4], 1, "kprobe_session_result[4]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[5], 1, "kprobe_session_result[5]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[6], 1, "kprobe_session_result[6]");
+	ASSERT_EQ(skel->bss->kprobe_session_result[7], 1, "kprobe_session_result[7]");
+
+cleanup:
+	bpf_link__destroy(link);
+	kprobe_multi_session__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -690,4 +731,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("session"))
+		test_session_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
new file mode 100644
index 000000000000..3f4137100482
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+int pid = 0;
+
+__u64 kprobe_session_result[8];
+
+static const void *kfuncs[8] = {
+	&bpf_fentry_test1,
+	&bpf_fentry_test2,
+	&bpf_fentry_test3,
+	&bpf_fentry_test4,
+	&bpf_fentry_test5,
+	&bpf_fentry_test6,
+	&bpf_fentry_test7,
+	&bpf_fentry_test8,
+};
+
+static int session_check(void *ctx, bool is_return)
+{
+	unsigned int i;
+	__u64 addr;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	addr = bpf_get_func_ip(ctx);
+
+	for (i = 0; i < 8; i++) {
+		if (kfuncs[i] == (void *) addr) {
+			kprobe_session_result[i]++;
+			break;
+		}
+	}
+
+	/*
+	 * Force probes for function bpf_fentry_test[5-8] not to
+	 * install and execute the return probe
+	 */
+	if (((const void *) addr == &bpf_fentry_test5) ||
+	    ((const void *) addr == &bpf_fentry_test6) ||
+	    ((const void *) addr == &bpf_fentry_test7) ||
+	    ((const void *) addr == &bpf_fentry_test8))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+	return 0;
+}
+
+SEC("kprobe.session/bpf_fentry_test*")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return session_check(ctx, bpf_session_is_return());
+}

