Return-Path: <bpf+bounces-7274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05857774EF0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 01:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283821C20EF4
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9C1BB43;
	Tue,  8 Aug 2023 23:04:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431629AB
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 23:04:46 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882DD101
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:04:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so10305132e87.1
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691535883; x=1692140683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v3vACgqNsLpvvl37L7PxYOPEh5n5RSQjMkd3YqTUErE=;
        b=LtKndjS4/JlsFnc78aR/zjMHqkcb5RGQdAJ/zlGmE+ciGyx2S3DbmXDGHLX94tw15u
         kAWXIVFH4PYcI1TfeAgii7IVJzHpxDJ7AdB8ZYYoZ6/1WTU06sLf/KUSk2NJFpf+pauE
         ONWT6zph8e1DexVGEtYRbAA2gwmUF0+pI2qW/pze92b99J6VvRIPjGQSElh41nZ0dX/F
         IQbUfK4ZMrfI6DJVbckt0b79EbQWCgH2pRIqMjiBAISY8QftdGLJFCTmrgY4E5ZE3euZ
         fE7rtMdSVx0GZZ3nDS+qoyBTmbElir3TKt5iNERDAFUdg1yBOHss9YhZ8bAglQQcgzqO
         XOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691535883; x=1692140683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3vACgqNsLpvvl37L7PxYOPEh5n5RSQjMkd3YqTUErE=;
        b=YXJaI+kJn6qBubjFpG6GXHRkwdcbdQsqo87Ynwe+0/zJEko146yEXOwdmbYJsBU1I+
         m5m9qzf4i7ZS/Alm91OrNQ4q1RYhLw4cUazdTysDKFfMumxhH5qMHyhbP8c+jlP8CvFe
         V7EDAS7OrqtBnGcy9HmcThKSgkqW7o+Imj2FVDwaNvLnXENzhFlFwjN4nu/lSv34Jt9G
         ykuARsvJihNP9dzjjcCBfnOxP7SglphH9apL1cp9LNEJLOiBg8q+7Xtd1gg/yGxJppu6
         HtrY0MrRebf9F1WVOEqItIychW2+8oG2Fpa1qJbHl6q2H0+toh1vkcEcu2aSgAMZLnnW
         euKA==
X-Gm-Message-State: AOJu0YwDQaVxj04yKxPF2jKpNNn30PNIKKs9kaEZMzdBF9l17FTt7asg
	5gsU8baEqiVrZSSDtS437j1VJQI64a0=
X-Google-Smtp-Source: AGHT+IGsywiaV718gvMw6RkoMWcWMLnl0nrATDjcmxx0g4H8ckm3+iy4EllyrFZXpfUF3MAN5JgWlw==
X-Received: by 2002:a19:e050:0:b0:4f8:8be4:8a82 with SMTP id g16-20020a19e050000000b004f88be48a82mr535362lfj.22.1691535882426;
        Tue, 08 Aug 2023 16:04:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090612c700b009937dbabbdasm7118236ejb.217.2023.08.08.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 16:04:42 -0700 (PDT)
Message-ID: <bf8af3bf700a9781b187e3f0457d264b93931325.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: relax expected log messages to
 allow emitting BPF_ST
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com
Date: Wed, 09 Aug 2023 02:04:40 +0300
In-Reply-To: <cb227598-650b-28c1-1d58-b4d1eefb6492@linux.dev>
References: <20230808162755.392606-1-eddyz87@gmail.com>
	 <cb227598-650b-28c1-1d58-b4d1eefb6492@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-08 at 15:51 -0700, Yonghong Song wrote:
>=20
> On 8/8/23 9:27 AM, Eduard Zingerman wrote:
> > Update [1] to LLVM BPF backend seeks to enable generation of BPF_ST
> > instruction when CPUv4 is selected. This affects expected log messages
> > for the following selftests:
> > - log_fixup/missing_map
> > - spin_lock/lock_id_mapval_preserve
> > - spin_lock/lock_id_innermapval_preserve
> >=20
> > Expected messages in these tests hard-code instruction numbers for BPF
> > programs compiled from C. These instruction numbers change when
> > BPF_ST is allowed because single BPF_ST instruction replaces a pair of
> > BPF_MOV/BPF_STX instructions, e.g.:
> >=20
> >      r1 =3D 42;
> >      *(u32 *)(r10 - 8) =3D r1;  --->  *(u32 *)(r10 - 8) =3D 42;
> >=20
> > This commit updates expected log messages to avoid matching specific
> > instruction numbers (program position still could be uniquely
> > identified).
> >=20
> > [1] https://reviews.llvm.org/D140804
> >      "[BPF] support for BPF_ST instruction in codegen"
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   .../selftests/bpf/prog_tests/log_fixup.c      |  2 +-
> >   .../selftests/bpf/prog_tests/spin_lock.c      | 37 ++++++++++++++++--=
-
> >   2 files changed, 33 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools=
/testing/selftests/bpf/prog_tests/log_fixup.c
> > index dba71d98a227..effd78b2a657 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
> > @@ -124,7 +124,7 @@ static void missing_map(void)
> >   	ASSERT_FALSE(bpf_map__autocreate(skel->maps.missing_map), "missing_m=
ap_autocreate");
> >  =20
> >   	ASSERT_HAS_SUBSTR(log_buf,
> > -			  "8: <invalid BPF map reference>\n"
> > +			  ": <invalid BPF map reference>\n"
> >   			  "BPF map 'missing_map' is referenced but wasn't created\n",
> >   			  "log_buf");
> >  =20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools=
/testing/selftests/bpf/prog_tests/spin_lock.c
> > index d9270bd3d920..f29c08d93beb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> > @@ -1,4 +1,5 @@
> >   // SPDX-License-Identifier: GPL-2.0
> > +#include <regex.h>
> >   #include <test_progs.h>
> >   #include <network_helpers.h>
> >  =20
> > @@ -19,12 +20,16 @@ static struct {
> >   	  "; R1_w=3Dmap_value(off=3D0,ks=3D4,vs=3D4,imm=3D0)\n2: (85) call b=
pf_this_cpu_ptr#154\n"
> >   	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
> >   	{ "lock_id_mapval_preserve",
> > -	  "8: (bf) r1 =3D r0                       ; R0_w=3Dmap_value(id=3D1,=
off=3D0,ks=3D4,vs=3D8,imm=3D0) "
> > -	  "R1_w=3Dmap_value(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n9: (85) ca=
ll bpf_this_cpu_ptr#154\n"
> > +	  "[0-9]\\+: (bf) r1 =3D r0                       ;"
> > +	  " R0_w=3Dmap_value(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)"
> > +	  " R1_w=3Dmap_value(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n"
> > +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
> >   	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
> >   	{ "lock_id_innermapval_preserve",
> > -	  "13: (bf) r1 =3D r0                      ; R0=3Dmap_value(id=3D2,of=
f=3D0,ks=3D4,vs=3D8,imm=3D0) "
> > -	  "R1_w=3Dmap_value(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n14: (85) c=
all bpf_this_cpu_ptr#154\n"
> > +	  "[0-9]\\+: (bf) r1 =3D r0                      ;"
> > +	  " R0=3Dmap_value(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)"
> > +	  " R1_w=3Dmap_value(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)\n"
> > +	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
> >   	  "R1 type=3Dmap_value expected=3Dpercpu_ptr_" },
> >   	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" =
},
> >   	{ "lock_id_mismatch_kptr_global", "bpf_spin_unlock of different lock=
" },
> > @@ -45,6 +50,24 @@ static struct {
> >   	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of differe=
nt lock" },
> >   };
> >  =20
> > +static int match_regex(const char *pattern, const char *string)
> > +{
> > +	int err, rc;
> > +	regex_t re;
> > +
> > +	err =3D regcomp(&re, pattern, REG_NOSUB);
> > +	if (err) {
> > +		char errbuf[512];
> > +
> > +		regerror(err, &re, errbuf, sizeof(errbuf));
> > +		PRINT_FAIL("Can't compile regex: %s\n", errbuf);
> > +		return -1;
> > +	}
> > +	rc =3D regexec(&re, string, 0, NULL, 0);
> > +	regfree(&re);
> > +	return rc =3D=3D 0 ? 1 : 0;
> > +}
> > +
> >   static void test_spin_lock_fail_prog(const char *prog_name, const cha=
r *err_msg)
> >   {
> >   	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf =3D log_buf,
> > @@ -74,7 +97,11 @@ static void test_spin_lock_fail_prog(const char *pro=
g_name, const char *err_msg)
> >   		goto end;
> >   	}
> >  =20
> > -	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message"=
)) {
> > +	ret =3D match_regex(err_msg, log_buf);
> > +	if (!ASSERT_GE(ret, 0, "match_regex"))
>=20
> Should this be ASSERT_GT(ret, 0) or ASSERT_EQ(ret, 1)?
> If IIUC, regexec return 0 means a successful match.
> So in 'match_regex', a successful match will return 1, right?

Right `match_regex` has three possible return values:
. -1 if regex could not be compiled
.  0 if regex is ok but match fails
.  1 if regex is ok and match is found

I check for -1 in this ASSERT_GE, and for 1 in the ASSERT_TRUE right
below in order to have two separate error messages.

But maybe that is not necessary as I already have PRINT_FAIL in the
match_regex for -1 exit. So it would be possible to figure out what
failed: regcomp or regexec even if I replace ASSERT_GE/ASSERT_TRUE
with a single ASSERT_TRUE (or ASSERT_EQ(ret, 1)) as you suggest.

>=20
> > +		goto end;
> > +
> > +	if (!ASSERT_TRUE(ret, "no match for expected error message")) {
> >   		fprintf(stderr, "Expected: %s\n", err_msg);
> >   		fprintf(stderr, "Verifier: %s\n", log_buf);
> >   	}


