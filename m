Return-Path: <bpf+bounces-26217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7289CCEA
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23B31F2347F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F1146A6D;
	Mon,  8 Apr 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="RLbFbU6n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86D146A68
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607615; cv=none; b=haXL6qmvqmiECQTQMSC1nJvgM7mo6gjk7g+Pc6GDfivcApTrK5vieW6UnjlLrUGIIyPzHAOtJBcC/JUzCyS1O8LbpzRiUwxqEJc1oAUUuzEq1Na0FyxCt/ZGFgLJLRQz6NHcG2B3de4uXDYUB+//HJwFFKn30emyEps2FKqUx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607615; c=relaxed/simple;
	bh=agVI29UqxFTp8uaOMRqu6Xn+CLXqXR5C3Ug1A5PkGHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=geALFOvsNZvbNHFAyXKC8jmYjaz2CQzi8TN2s4AQ82hVyxmYaQjliVGu10c+Opv1LunTiolyaOv+PVYwLzq43cv2OqVitJ1aUmhfjxGl8Ivi20v61D4N/LnQknvQzY8nU0rHsdpIcX9EV/t1buX8Qtf88TBRbTuCvAJzUXW8a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=RLbFbU6n; arc=none smtp.client-ip=128.178.224.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1712607209;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=agVI29UqxFTp8uaOMRqu6Xn+CLXqXR5C3Ug1A5PkGHo=;
      b=RLbFbU6nN5zDY14VNw4a++w7mOd4On41haYrSa2x0vu5w3F9tZ7FAUZc0r8cJbR6P
        4C96TztBswTkioltfd8mjPa5f7MnhoWxY8UENUE02rYIBO/wNU3Jbn1FG3hB8thpw
        GDsrg7j0xTE4jmPuM/NkhcrmRBmZXttGaLp1H0e18=
Received: (qmail 47423 invoked by uid 107); 8 Apr 2024 20:13:29 -0000
Received: from ax-snat-224-174.epfl.ch (HELO ewa05.intranet.epfl.ch) (192.168.224.174) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Mon, 08 Apr 2024 22:13:29 +0200
X-EPFL-Auth: gKrF8yTAvcs+DSuJ47JdN1peBjsRlFmdDi+io6EVkWjucB/kcZA=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa05.intranet.epfl.ch (128.178.224.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 22:13:29 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.035; Mon, 8 Apr 2024 22:13:29 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: "eddyz87@gmail.com" <eddyz87@gmail.com>, Andrii Nakryiko
	<andrii.nakryiko@gmail.com>
CC: "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"mathias.payer@nebelwelt.net" <mathias.payer@nebelwelt.net>,
	"meng.xu.cs@uwaterloo.ca" <meng.xu.cs@uwaterloo.ca>, Sanidhya Kashyap
	<sanidhya.kashyap@epfl.ch>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
Thread-Topic: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
Thread-Index: AQHahgTpqMaxaiN15UGvqF33zxHGXbFW8YMAgAABloCAAw5QgIAAAgOAgADdTYCAA/MyvA==
Date: Mon, 8 Apr 2024 20:13:29 +0000
Message-ID: <c52b7c81936b466e9414fc4122667819@epfl.ch>
References: <CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
	 <20240405202607.4146642-1-tao.lyu@epfl.ch>
	 <CAEf4BzbpZQtiM-ruX-oO-6jth9ZhX5Sr5bTvRx8pNj+VEH3NfA@mail.gmail.com>,<a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com>
In-Reply-To: <a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> [...]
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 63749ad5ac6b..da575e295d53 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct b=
pf_verifier_env *env,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > >=A0=A0=A0=A0=A0=A0=A0=A0 if (!env->allow_ptr_leaks &&
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is_spilled_reg(&state->stack[spi]=
) &&
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !is_spilled_scalar_reg(&state->stack[=
spi]) &&
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size !=3D BPF_REG_SIZE) {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 verbose(env, "attempt=
 to corrupt spilled pointer on stack\n");
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EACCES;
> >=20
> > ack for this part:
> >=20
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > but I'm not sure if we need all the *_caps logic for selftests just to
> > test this, tbh. I'll let other decide, though.
>=20
> Hi Tao, Andrii,
>=20
> I agree with Andrii that *_caps logic is a bit heavy-handed.
> It works on top of the test_loader.c:drop_capabilities() used for
> unpriv testing, so I suggest that we add only one macro: __caps_unpriv(<s=
et-of-caps>),
> that would enable specified capabilities when testing unpriv.
> E.g. as in the patch at the end of this email (based on Tao's work).
>=20
> A few additional notes:
> - changes to the verifier.c, to the test_loader.c and actual feature
> =A0 test should be split in separate commits;
> - __caps_unpriv as in Tao's or my patches allows to set arbitrary
> =A0 capabilities, however restore_capabilities() uses
> =A0 cap_enable_effective(requested_caps), which does logical OR
> =A0 of current_caps and requested_caps.
> =A0 For the purpose of restore_capabilities(), I think
> =A0 cap_enable_effective() should be updated with a flag to overwrite
> =A0 current_caps with requested_caps. Otherwise it might not undo
> =A0 __caps_unpriv() effects in some cases.
> - I changed the test case to avoid BPF_ST assembly instructions
> =A0 ('*(u64*)(r10 - 8) =3D 1') in order to allow compilation by LLVM 16.
> =A0=20
> Thanks,
> Eduard

Hi Andrii and Eduard,

Thanks for the comments.

Eduard's proposal looks good to me.

If we all agree on it, I can send three separate commits for the bug fix,
the extension on test_loader.c, and the test case for this issue.

Best,
Tao

>=20
> ---
>=20
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index fb2f5513e29e..14a79bc76b45 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -2,6 +2,10 @@
> =A0#ifndef __BPF_MISC_H__
> =A0#define __BPF_MISC_H__
> =A0
> +/* Expand a macro and then stringize the expansion */
> +#define QUOTE(str) #str
> +#define EXPAND_QUOTE(str) QUOTE(str)
> +
> =A0/* This set of attributes controls behavior of the
> =A0 * test_loader.c:test_loader__run_subtests().
> =A0 *
> @@ -72,6 +76,7 @@
> =A0#define __auxiliary=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __attribute__(=
(btf_decl_tag("comment:test_auxiliary")))
> =A0#define __auxiliary_unpriv=A0=A0=A0=A0=A0 __attribute__((btf_decl_tag(=
"comment:test_auxiliary_unpriv")))
> =A0#define __btf_path(path)=A0=A0=A0=A0=A0=A0=A0 __attribute__((btf_decl_=
tag("comment:test_btf_path=3D" path)))
> +#define __caps_unpriv(caps)=A0=A0=A0 __attribute__((btf_decl_tag("commen=
t:test_caps_unpriv=3D"EXPAND_QUOTE(caps))))
> =A0
> =A0/* Convenience macro for use with 'asm volatile' blocks */
> =A0#define __naked __attribute__((naked))
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 85e48069c9e6..a043514da4f0 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -5,6 +5,7 @@
> =A0#include <bpf/bpf_helpers.h>
> =A0#include "bpf_misc.h"
> =A0#include <../../../tools/include/linux/filter.h>
> +#include "../cap_helpers.h"
> =A0
> =A0struct {
> =A0=A0=A0=A0=A0=A0=A0=A0 __uint(type, BPF_MAP_TYPE_RINGBUF);
> @@ -1244,4 +1245,19 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
> =A0=A0=A0=A0=A0=A0=A0=A0 : __clobber_all);
> =A0}
> =A0
> +/* 32-bit scalars should be able to overwrite 64-bit scalar spilled slot=
s */
> +SEC("socket")
> +__log_level(2) __success __caps_unpriv(CAP_BPF)
> +__naked void spill_32bit_onto_64bit_slot(void)
> +{
> +=A0=A0=A0=A0=A0=A0 asm volatile("=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0=A0=A0 r0 =3D 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \
> +=A0=A0=A0=A0=A0=A0 *(u64*)(r10 - 8) =3D r0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0=A0=A0 *(u32*)(r10 - 8) =3D r0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0=A0=A0 exit;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \
> +"=A0=A0=A0=A0=A0 :
> +=A0=A0=A0=A0=A0=A0 :
> +=A0=A0=A0=A0=A0=A0 : __clobber_all);
> +}
> +
> =A0char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 524c38e9cde4..ad79b5948440 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -27,6 +27,7 @@
> =A0#define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv=3D"
> =A0#define TEST_TAG_AUXILIARY "comment:test_auxiliary"
> =A0#define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
> +#define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv=3D"
> =A0#define TEST_BTF_PATH "comment:test_btf_path=3D"
> =A0
> =A0/* Warning: duplicated in bpf_misc.h */
> @@ -53,6 +54,7 @@ struct test_subspec {
> =A0=A0=A0=A0=A0=A0=A0=A0 size_t expect_msg_cnt;
> =A0=A0=A0=A0=A0=A0=A0=A0 int retval;
> =A0=A0=A0=A0=A0=A0=A0=A0 bool execute;
> +=A0=A0=A0=A0=A0=A0 __u64 caps;
> =A0};
> =A0
> =A0struct test_spec {
> @@ -133,6 +135,33 @@ static int parse_int(const char *str, int *val, cons=
t char *name)
> =A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> =A0}
> =A0
> +static int parse_caps(const char *str, __u64 *val, const char *name)
> +{
> +=A0=A0=A0=A0=A0=A0 int cap_flag =3D 0;
> +=A0=A0=A0=A0=A0=A0 char *token =3D NULL, *saveptr =3D NULL;
> +
> +=A0=A0=A0=A0=A0=A0 char *str_cpy =3D strdup(str);
> +=A0=A0=A0=A0=A0=A0 if (str_cpy =3D=3D NULL) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PRINT_FAIL("Memory allocation=
 failed\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 token =3D strtok_r(str_cpy, "|", &saveptr);
> +=A0=A0=A0=A0=A0=A0 while (token !=3D NULL) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 errno =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cap_flag =3D strtol(token, NU=
LL, 10);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (errno) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PRINT=
_FAIL("failed to parse caps %s\n", name);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retur=
n -EINVAL;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val |=3D (1ULL << cap_flag);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 token =3D strtok_r(NULL, "|",=
 &saveptr);
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 free(str_cpy);
> +=A0=A0=A0=A0=A0=A0 return 0;
> +}
> +
> =A0static int parse_retval(const char *str, int *val, const char *name)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0 struct {
> @@ -258,6 +287,12 @@ static int parse_test_spec(struct test_loader *teste=
r,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
spec->mode_mask |=3D UNPRIV;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
spec->unpriv.execute =3D true;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
has_unpriv_retval =3D true;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (str_has_pfx(s, =
TEST_TAG_CAPS_UNPRIV)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =
=3D s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =
=3D parse_caps(val, &spec->unpriv.caps, "test caps");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (e=
rr)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 goto cleanup;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spec-=
>mode_mask |=3D UNPRIV;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (str_has_pfx(s=
, TEST_TAG_LOG_LEVEL_PFX)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
val =3D s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
err =3D parse_int(val, &spec->log_level, "test log level");
> @@ -575,6 +610,7 @@ void run_subtest(struct test_loader *tester,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 if (unpriv) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, "can_execute_=
unpriv: %d\n", can_execute_unpriv(tester, spec));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!can_execute_unpriv(=
tester, spec)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
test__skip();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
test__end_subtest();
> @@ -584,6 +620,13 @@ void run_subtest(struct test_loader *tester,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
test__end_subtest();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (subspec->caps) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =
=3D cap_enable_effective(subspec->caps, NULL);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (e=
rr) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 PRINT_FAIL("failed to set capabilities: %i, %s\n", err, =
strerror(err));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 goto subtest_cleanup;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 /* Implicitly reset to NULL if next test case do=
esn't specify */=

