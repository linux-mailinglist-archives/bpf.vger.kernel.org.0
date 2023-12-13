Return-Path: <bpf+bounces-17726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D4812209
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CC91C21326
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A4581856;
	Wed, 13 Dec 2023 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVj4xVTD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9DDC
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:48:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50be3611794so8812891e87.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507737; x=1703112537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQr29YZZ51KQ1t+eZTxCeGRB8QI/s5D+k5OzaA8loWE=;
        b=gVj4xVTDGw7VlcVxy1IjFde2KgUr9xxIj0PySU08gOkjGidSPmMK/pAbMVKdVlRUkL
         doo8vH6+Srw99DPs2jSirXYr0pHLugZt01jCCAAF6bku86MTNn7GXY9n1ePwV3tOwKVA
         3zXZ5Z4tpsmakvLwB5yS8u3hzqQYYpF9C/kP67OqD5Eus/4ZgFB8sMdgoCEE7ky/o/4v
         XT3Othg3zI7TXA9i3DZcKlK483KaadZ3ZB6o3od2TCndOos5l9TwpdVPdnpuDxQh37Bn
         ULd0cWiMjLTpfRZNLgp50IiuF8z6YsuP5H7rrORaq+ryjr4nGUTkQfVHjb91g6766bUH
         aIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507737; x=1703112537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQr29YZZ51KQ1t+eZTxCeGRB8QI/s5D+k5OzaA8loWE=;
        b=gnoKMUYyfX2hY6JtN0NaY7MNSLYI1GYrU/mD9VzHFV11RfhFWJOgkwlKR1ITWAuNXX
         myF5IvkrkAx2g/9VUoWu1wXr3fdPebAptj2m9P4EXgpAFR9Duskf46EoT7j/7a87XGa/
         PuycZGySWHApMYCLRJpBU6p6tnhXiKq4l/8JyVqD8+tf8rASqdI3qiMTTlUcjMypXTjB
         jazBuQjfC/EGB5Oaw9AerBrHQp3UYVUdrV11jDr7vy55rWHAZ0Uvff6iENqU6eAA+ZY2
         2upeEqLD5UiTblLOZvLXziWjHxMwgGcfEC8b9NSEIqEO32NUVSy+aZpJ0N9f8oPdJvLh
         2qmA==
X-Gm-Message-State: AOJu0YwVXHDi4hoAg3Tf0++qgo6qwQa6euGjC5FqxZdW5h1TjCGfDgkR
	buoswf3BvCDy6djkjwlkiRR8BEJZ7NfZMJiHp3w=
X-Google-Smtp-Source: AGHT+IGk81P7bauFbjl2ypclBbwXy1TbCn5tAHwxCe/qTx/hqqAvNY5aZBqaPjGBHgbRUD8qsJmJf5ODNxBoJ6rKH2Q=
X-Received: by 2002:a05:6512:b0d:b0:50c:bd0:870f with SMTP id
 w13-20020a0565120b0d00b0050c0bd0870fmr5173847lfu.73.1702507736945; Wed, 13
 Dec 2023 14:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212232535.1875938-1-andrii@kernel.org> <20231212232535.1875938-11-andrii@kernel.org>
 <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
 <CAEf4BzaeEhfFB=ZSQO=i8hT6OP1bkT4b2pzHoViFA4Q_Vju1tA@mail.gmail.com> <795bfa3fef7bb0252d5e1d7fd721880ddfae0ecc.camel@gmail.com>
In-Reply-To: <795bfa3fef7bb0252d5e1d7fd721880ddfae0ecc.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 14:48:44 -0800
Message-ID: <CAEf4BzZz2cMf787nu9Ldz2YwuZRSF9w9fCmJT=E=+=t99BiZMA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of
 BTF-unreliable main prog test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2023-12-13 at 11:25 -0800, Andrii Nakryiko wrote:
> [...]
> > Yes, if we add a bunch of extra log grabbing and matching logic to
> > fexit_bpf2bpf test. Which, honestly, I just didn't want to touch more
> > than I absolutely needed to. So I'll use your permission to ignore
> > this.
>
> Still think it's useful and diff is not that big:
> https://gist.github.com/eddyz87/5f518b96eb4188dd1afd436e811bbef9

Ok, Eduard, ok, I'll add it in this patch in the next revision. It can
be done a bit simpler than in your example, though.

$ git diff
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 39ce45337e7d..f29fc789c14b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -348,7 +348,8 @@ static void test_func_sockmap_update(void)
 }

 static void test_obj_load_failure_common(const char *obj_file,
-                                        const char *target_obj_file)
+                                        const char *target_obj_file,
+                                        const char *exp_msg)
 {
        /*
         * standalone test that asserts failure to load freplace prog
@@ -356,6 +357,7 @@ static void test_obj_load_failure_common(const
char *obj_file,
         */
        struct bpf_object *obj =3D NULL, *pkt_obj;
        struct bpf_program *prog;
+       char log_buf[64 * 1024];
        int err, pkt_fd;
        __u32 duration =3D 0;

@@ -374,14 +376,21 @@ static void test_obj_load_failure_common(const
char *obj_file,
        err =3D bpf_program__set_attach_target(prog, pkt_fd, NULL);
        ASSERT_OK(err, "set_attach_target");

+       log_buf[0] =3D '\0';
+       if (exp_msg)
+               bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
        if (env.verbosity > VERBOSE_NONE)
                bpf_program__set_log_level(prog, 2);

        /* It should fail to load the program */
        err =3D bpf_object__load(obj);
+       if (env.verbosity > VERBOSE_NONE && exp_msg) /* we overtook log */
+               printf("VERIFIER
LOG:\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n%s\n=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n", log_buf);
        if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
                goto close_prog;

+       if (exp_msg)
+               ASSERT_HAS_SUBSTR(log_buf, exp_msg, "fail_msg");
 close_prog:
        bpf_object__close(obj);
        bpf_object__close(pkt_obj);
@@ -391,14 +400,14 @@ static void test_func_replace_return_code(void)
 {
        /* test invalid return code in the replaced program */
        test_obj_load_failure_common("./freplace_connect_v4_prog.bpf.o",
-                                    "./connect4_prog.bpf.o");
+                                    "./connect4_prog.bpf.o", NULL);
 }

 static void test_func_map_prog_compatibility(void)
 {
        /* test with spin lock map value in the replaced program */
        test_obj_load_failure_common("./freplace_attach_probe.bpf.o",
-                                    "./test_attach_probe.bpf.o");
+                                    "./test_attach_probe.bpf.o", NULL);
 }

 static void test_func_replace_unreliable(void)
@@ -407,7 +416,8 @@ static void test_func_replace_unreliable(void)
         * "Cannot replace static functions"
         */
        test_obj_load_failure_common("freplace_unreliable_prog.bpf.o",
-                                    "./verifier_btf_unreliable_prog.bpf.o"=
);
+                                    "./verifier_btf_unreliable_prog.bpf.o"=
,
+                                    "Cannot replace static functions");
 }

 static void test_func_replace_global_func(void)

>
> > > Also, maybe kernel should be tweaked to be a bit more informative,
> > > as message about static function is confusing, wdyt?
> > >
> >
> > Currently the verifier doesn't distinguish between reasons for
> > "unreliable". Not sure if it's worth tracking more information just
> > for this. Certainly that feels like an orthogonal to this series
> > improvement.
>
> Fair enough.

