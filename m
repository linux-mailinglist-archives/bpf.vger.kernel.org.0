Return-Path: <bpf+bounces-1197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3477101E8
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 02:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCBB281368
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805419C;
	Thu, 25 May 2023 00:13:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2F18E
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 00:13:25 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C699;
	Wed, 24 May 2023 17:13:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso18724741fa.0;
        Wed, 24 May 2023 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684973601; x=1687565601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QE7Cfa2VCFKJJcihENPedECPunVcflrVmXn8Dojkfv4=;
        b=QxPXGYDlIzpIyzo1d03zqjjmV8ghT4EzPJp2+uXHJkKT2fxI/mYFE0C6Y36fhP5r+v
         28JVyQrXUpcniUEuw6GFHfKSqLKvAR2f0/m6/hb12SpIr9neSsG9yuB91It9Szk0Hsk0
         xkFspkCjGcFxVsn2G9rYojaxOcwyiXhRiWn+GRqHEU/mmOAFnAnOT7Jbp4LQSHB8PcTt
         6/XomWD6vGTb0fnaXW7rbmv1PHrlawzInpHCNNK8cWFUK0ZhJW9anFrE//iCVfMB2KhG
         aJ0c+v3jTKeUUk5uYYcHWAcCVKojqLMCqIqPxnWP+8rk2V6iysntEPNpM/siZnHRoAfY
         BOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973601; x=1687565601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE7Cfa2VCFKJJcihENPedECPunVcflrVmXn8Dojkfv4=;
        b=RdpT+vn6EYiRaXm3lpI44qdGXzMdYGs6hdAGApjm6yWeRqd7imAD+HV567coydCmyp
         9UWKt4oRDwTGf1QA3Zor9CFKT7L/6js22OYZ4TNtcRbWHk+io0jYSbnjJkE39/+iAVJy
         p1ylDJKupWgfVFxGfBpGbswHtinFtzQGdzic0N1KC8/iaketZbtd7DxAYO5E5uZdWdG9
         ss+yLZloN1fIAsfBbEjXJyb0jk6gF3sfcXLkFm7BtqxmyyBxMa4VZr9BLsXeIbFOkmV3
         /4wWmQP5IBGclMuApSyeJytNoOJdoO0GVtHrjPxHZKzFertCvJ/8WtBkRYt0bRJucYWt
         xDlQ==
X-Gm-Message-State: AC+VfDwYSSkNQ/trn/23BIZOpg6l9nNV3vd/I/MFJ0MYTWG5PLSc43o0
	/y0jZ/9uufcGdg42GHpBSkGMlBr6dIYoyg==
X-Google-Smtp-Source: ACHHUZ5S+KcQCk5EUKNl3mIsEneNx6lFx+LoaZf4vbDwoikUDUYhdHBXUg/TNSzKt9ZuRdR7CcoTxg==
X-Received: by 2002:a05:651c:446:b0:2ac:7904:e38f with SMTP id g6-20020a05651c044600b002ac7904e38fmr495808ljg.12.1684973600927;
        Wed, 24 May 2023 17:13:20 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002ac7978f0a6sm7425ljj.100.2023.05.24.17.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 17:13:20 -0700 (PDT)
Message-ID: <85637acda6983eac1787abbb07ef18c618b4193b.camel@gmail.com>
Subject: Re: [PATCH v3 dwarves 0/6] Support for new btf_type_tag encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net,  andrii@kernel.org, yhs@fb.com, jemarch@gnu.org,
 david.faust@oracle.com,  mykolal@fb.com
Date: Thu, 25 May 2023 03:13:18 +0300
In-Reply-To: <20230524001825.2688661-1-eddyz87@gmail.com>
References: <20230524001825.2688661-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-24 at 03:18 +0300, Eduard Zingerman wrote:
[...]=20
>   - gcc       / LLVM-main / pahole-new
>     - kernel build : ok
>     - bpf tests    : ok
>     - btfdiff      : ok but dwarf dump sometimes segfaults

Regarding this segfault. I can reproduce it using pahole 'next' branch
if btfdiff is executed several times. So, the proposed patch-set is
not the cause.

Specifically, it happens when the following command is executed:

  pahole -F dwarf --flat_arrays --sort ... vmlinux

With the following stack trace:

  Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
  0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830, parent=3D0=
x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-for=
k/rbtree.c:134
  134			if (parent->rb_left =3D=3D node)
  (gdb) bt
  #0  0x00007ffff7f819ad in __rb_erase_color (node=3D0x7fffd4045830, parent=
=3D0x0, root=3D0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves=
-fork/rbtree.c:134
  #1  0x00007ffff7f82014 in rb_erase (node=3D0x7fff21ae5b80, root=3D0x55555=
55672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:275
  #2  0x0000555555559c3d in __structures__delete () at /home/eddy/work/dwar=
ves-fork/pahole.c:440
  #3  0x0000555555559c70 in structures__delete () at /home/eddy/work/dwarve=
s-fork/pahole.c:448
  #4  0x0000555555560bb6 in main (argc=3D13, argv=3D0x7fffffffdcd8) at /hom=
e/eddy/work/dwarves-fork/pahole.c:3584

I tried random testing the rb_tree implementation and can reliably
reproduce the error using the diff at the end of the email.
E.g. it happens for test sequence (using add/delete functions adapted
to work on int values instead of 'struct structure'):

  60 4 24 34 15 2 80 26 82 67 92 77 9.

Will figure out a fix for rb_erase code tomorrow.

--- testing code for rb_erase ---

diff --git a/pahole.c b/pahole.c
index 6fc4ed6..6c60c9e 100644
--- a/pahole.c
+++ b/pahole.c
@@ -8,6 +8,7 @@
=20
 #include <argp.h>
 #include <assert.h>
+#include <signal.h>
 #include <stdio.h>
 #include <dwarf.h>
 #include <elfutils/version.h>
@@ -3408,10 +3409,97 @@ out_free:
 	return ret;
 }
=20
+struct test_struct {
+	struct rb_node rb_node;
+	int val;
+};
+
+static struct rb_root test_tree =3D RB_ROOT;
+static struct test_struct structs[100] =3D {};
+static int free_struct_idx =3D 0;
+static int num_tries =3D 0;
+
+static void test_add(int val)
+{
+        struct rb_node **p =3D &test_tree.rb_node;
+        struct rb_node *parent =3D NULL;
+	struct test_struct *str;
+
+        while (*p !=3D NULL) {
+		int rc;
+
+                parent =3D *p;
+                str =3D rb_entry(parent, struct test_struct, rb_node);
+		rc =3D str->val - val;
+
+		if (rc > 0)
+                        p =3D &(*p)->rb_left;
+                else if (rc < 0)
+                        p =3D &(*p)->rb_right;
+		else {
+			return;
+		}
+        }
+
+	str =3D &structs[free_struct_idx++];
+	str->val =3D val;
+
+	rb_link_node(&str->rb_node, parent, p);
+        rb_insert_color(&str->rb_node, &test_tree);
+
+	return;
+}
+
+static void test_delete()
+{
+	struct rb_node *next =3D rb_first(&test_tree);
+
+	while (next) {
+		struct test_struct *pos =3D rb_entry(next, struct test_struct, rb_node);
+		next =3D rb_next(&pos->rb_node);
+		rb_erase(&pos->rb_node, &structures__tree);
+	}
+}
+
+void test_erase_once()
+{
+	test_tree =3D RB_ROOT;
+	free_struct_idx =3D 0;
+	bzero(structs, sizeof(structs));
+	int size =3D rand() % 16;
+	for (int i =3D 0; i < size; ++i) {
+		int val =3D rand() % 100;
+		test_add(val);
+	}
+	test_delete();
+	++num_tries;
+}
+
+static void sigsegv_handler(int nSignum, siginfo_t* si, void* vcontext) {
+	fprintf(stderr, "SIGSEGV after %d iters: [%d]", num_tries, free_struct_id=
x);
+	for (int i =3D 0; i < free_struct_idx; ++i)
+		fprintf(stderr, " %d", structs[i].val);
+	fprintf(stderr, "\n");
+	exit(1);
+}
+
 int main(int argc, char *argv[])
 {
 	int err, remaining, rc =3D EXIT_FAILURE;
=20
+	int seed =3D clock();
+	fprintf(stderr, "seed =3D %d\n", seed);
+	srand(seed);
+	struct sigaction action =3D {};
+	action.sa_flags =3D SA_SIGINFO;
+	action.sa_sigaction =3D sigsegv_handler;
+	sigaction(SIGSEGV, &action, NULL);
+	for (int i =3D 0; i < 1000 * 1000; ++i) {
+		test_erase_once();
+	}
+	fprintf(stderr, "done\n");
+	return 0;
+
 	if (argp_parse(&pahole__argp, argc, argv, 0, &remaining, NULL)) {
 		argp_help(&pahole__argp, stderr, ARGP_HELP_SEE, argv[0]);
 		goto out;

