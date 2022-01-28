Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F884A0260
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiA1U5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 15:57:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiA1U5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 15:57:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA8161E4E;
        Fri, 28 Jan 2022 20:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D6AC340E7;
        Fri, 28 Jan 2022 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643403425;
        bh=zeo1UHi+IGexbC9aOX2A85Rq3v6bRqkaULGFEtkJBVU=;
        h=Date:From:To:Cc:Subject:From;
        b=He0JHEF5lY65gJ/G0/GwjOaBkX7EXoHEn8kT7HAfSpQS+XLPg0igdgKIU8RzxxthZ
         +YIYpmapeIrQ+WLuE/K1e5AI1CmM4UMZvYFOXoPrdYQwKod2iwfr2yAsiGr6qqT3/A
         9Iny3V0RSC6sI0/DFMq6SijdtdEE4YZsEO1Y7XrRhR3L2PT74/shunYrd84ZK6HO+r
         4uLapB2yjQzvFhbMhfNEnPn2y25OJw7yHSgwjR9LtZsJ8yt64o/Oj8JK1J9ZC4TC8k
         pyU8hRp2MGPyq0/P+QWxu4Fpi5jaz9bWI2tkb4ooNhBuAOwse8PKy5Op0UehHzXP87
         YIxNOrhLXvn+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE66F40C99; Fri, 28 Jan 2022 17:55:02 -0300 (-03)
Date:   Fri, 28 Jan 2022 17:55:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: [PATCH 1/1] fprintf: Fix division by zero for uninitialized
 conf_fprintf->cacheline_size field
Message-ID: <YfRYJjhvyT2OROqS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Douglas,

	While testing the BTF encoder parallelization work done by
Kui-Feng Lee, I noticed this problem.

	The whole tree is at the 'next' branch in my git repo.

	Please check and consider providing a Reviewed-by or Acked-by,

Thanks,

- Arnaldo

----

tldr;

  gdb pfunct
  (gdb) run --compile tcp.o
  Program received signal SIGFPE, Arithmetic exception.
  0x00007ffff7f18551 in class__fprintf_cacheline_boundary (conf=0x7fffffffda10, offset=0, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:1319
  1319		uint32_t cacheline = offset / conf->cacheline_size;
  (gdb) bt
  #0  0x00007ffff7f18551 in class__fprintf_cacheline_boundary (conf=0x7fffffffda10, offset=0, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:1319
  #1  0x00007ffff7f16af2 in class_member__fprintf (member=0x45de10, union_member=false, type=0x45dfb0, cu=0x435a40, conf=0x7fffffffda10, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:869
  #2  0x00007ffff7f1717b in struct_member__fprintf (member=0x45de10, type=0x45dfb0, cu=0x435a40, conf=0x7fffffffda10, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:983
  #3  0x00007ffff7f1945c in __class__fprintf (class=0x45dcc0, cu=0x435a40, conf=0x7fffffffdbb0, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:1583
  #4  0x00007ffff7f1a6bd in tag__fprintf (tag=0x45dcc0, cu=0x435a40, conf=0x7fffffffdc70, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_fprintf.c:1906
  #5  0x00007ffff7fbf022 in type__emit (tag=0x45dcc0, cu=0x435a40, prefix=0x0, suffix=0x0, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:333
  #6  0x00007ffff7fbed3d in tag__emit_definitions (tag=0x6b21e0, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:265
  #7  0x00007ffff7fbef45 in type__emit_definitions (tag=0x6b20c0, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:315
  #8  0x00007ffff7fbed15 in tag__emit_definitions (tag=0x6b3b40, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:264
  #9  0x00007ffff7fbef45 in type__emit_definitions (tag=0x6b31d0, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:315
  #10 0x00007ffff7fbed15 in tag__emit_definitions (tag=0x4cb920, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:264
  #11 0x00007ffff7fbef45 in type__emit_definitions (tag=0x4cb7d0, cu=0x435a40, emissions=0x408300 <emissions>, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/dwarves_emit.c:315
  #12 0x0000000000403592 in function__emit_type_definitions (func=0x738ad0, cu=0x435a40, fp=0x7ffff7e17520 <_IO_2_1_stdout_>) at /var/home/acme/git/pahole/pfunct.c:353
  #13 0x0000000000403670 in function__show (func=0x738ad0, cu=0x435a40) at /var/home/acme/git/pahole/pfunct.c:371
  #14 0x00000000004038e9 in cu_function_iterator (cu=0x435a40, cookie=0x0) at /var/home/acme/git/pahole/pfunct.c:404
  #15 0x00007ffff7f1296b in cus__for_each_cu (cus=0x4369e0, iterator=0x403869 <cu_function_iterator>, cookie=0x0, filter=0x0) at /var/home/acme/git/pahole/dwarves.c:1919
  #16 0x000000000040432a in main (argc=3, argv=0x7fffffffe1f8) at /var/home/acme/git/pahole/pfunct.c:776
  (gdb) p conf->cacheline_size
  $2 = 0

We need to pass a conf_fprintf pointer to the chain starting with
function__emit_type_definitions(), i.e. dwarves_emit.c needs to receive
the printing configuration instead of, right at type__emit() synthesize
a conf_fprintf without initializing conf_fprintf->cacheline_size which
ends up in a division by zero.

But to fix this quicker just add a helper that checks if it is zero and
uses the conf_fprintf__defaults.cacheline_size field that is being
initialized by all tools via:

  dwarves__resolve_cacheline_size(&conf_load, 0);

Fixes: 772725a77d3323c6 ("dwarves_fprintf: Move cacheline_size into struct conf_fprintf")
Cc: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index c5921d77d326579a..5d4329b718a7f65b 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -148,10 +148,30 @@ static struct conf_fprintf conf_fprintf__defaults = {
 
 const char tabs[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
 
+/*
+ * In dwarves_emit.c we can call type__emit() using a locally setup conf_fprintf for which
+ * the conf->cacheline_size member is not setup and is thus zero, so check for that and
+ * use the default one for that case.
+ *
+ * We really need to make the *_emit*() methods to receive a conf_fprintf pointer for
+ * which conf->cacheline_size is set, all tools call:
+ *
+ *   dwarves__resolve_cacheline_size(&conf_load, 0);
+ *
+ * To have a conf_load/conf_fprintf with that resolved, but that is not being passed to
+ * the *_emit*() routines, duh.
+ *
+ * Fixing this properly will entail a series of patches, so to fix this problem
+ * more quickly add this helper.
+ */
+static uint16_t conf_fprintf__cacheline_size(const struct conf_fprintf *conf)
+{
+	return conf->cacheline_size ?: conf_fprintf__defaults.cacheline_size;
+}
 
 size_t tag__nr_cachelines(const struct conf_fprintf *conf, const struct tag *tag, const struct cu *cu)
 {
-	return (tag__size(tag, cu) + conf->cacheline_size - 1) / conf->cacheline_size;
+	return (tag__size(tag, cu) + conf_fprintf__cacheline_size(conf) - 1) / conf_fprintf__cacheline_size(conf);
 }
 
 static const char *tag__accessibility(const struct tag *tag)
@@ -1316,11 +1336,11 @@ static size_t class__fprintf_cacheline_boundary(struct conf_fprintf *conf,
 						FILE *fp)
 {
 	int indent = conf->indent;
-	uint32_t cacheline = offset / conf->cacheline_size;
+	uint32_t cacheline = offset / conf_fprintf__cacheline_size(conf);
 	size_t printed = 0;
 
 	if (cacheline > *conf->cachelinep) {
-		const uint32_t cacheline_pos = offset % conf->cacheline_size;
+		const uint32_t cacheline_pos = offset % conf_fprintf__cacheline_size(conf);
 		const uint32_t cacheline_in_bytes = offset - cacheline_pos;
 
 		if (cacheline_pos == 0)
@@ -1762,7 +1782,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 		}
 		printed += fprintf(fp, " */\n");
 	}
-	cacheline = (cconf.base_offset + type->size) % conf->cacheline_size;
+	cacheline = (cconf.base_offset + type->size) % conf_fprintf__cacheline_size(conf);
 	if (cacheline != 0)
 		printed += fprintf(fp, "%.*s/* last cacheline: %u bytes */\n",
 				   cconf.indent, tabs,
-- 
2.34.1

