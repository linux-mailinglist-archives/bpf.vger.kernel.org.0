Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A96487CD
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLIRci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLIRch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:32:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB7B3E
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 09:32:33 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n21so13084088ejb.9
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qJ/mU13e0XC+DD+qXr8OxjAS4R9j2gNGBCyoigsYWIk=;
        b=So3nU2m49pcOqN8dARZC7/VIfUO12UNEyKAh/CL9ZJB+qT1jVXBtPjNym8rcDehfCO
         0FHeShXABoL1atB9Ez4N9XXNi09zy43oVNoGlMl+PmYzTDEJ9KCoa3w9Frwu6b6sjeVI
         v5+W5O3JttKSZx85ls6/JkWQWPbAqApZ/wxkYqI0b0Rze/QW7VMN805roBDzTDHcQm88
         QreiZfWBuf2BScocljVG9DkxcBQgQli0kpoeZALrxkhzBs9Opx9Aao3SNRku91j5AI9L
         bcnLmBnbXh9IilXZ8j5Z6Zh1MRmVnStfV5OINxp2+R/lC9ftp/3SC/3CrZ/NZUPMb5rP
         0jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ/mU13e0XC+DD+qXr8OxjAS4R9j2gNGBCyoigsYWIk=;
        b=13NG7POngI+VOJFmwFfXYGtUQ4ZDp2wSoowTB+/V0b+UeW7URmdYAXE0wAhtaKMoV8
         weS4qX4c0aunnvosRm0jgfp81x+RLM7uzLKuu+4nZudlbvOSfR5039fEnw7Ensx+2qkr
         PatL01wQHsKZZdaihZrlMeZlKem8llXK8aIdQ6ivVVv9MAtF4+BuM4NvLpc+QGq1yaqk
         giuWSMIXUyBqaEICqk+iU6JS7+0pwluW9yj76suhTIg6sYGd1ScMeowbKnyPAhD4286O
         XRPesehWqjGN69zrwFzV4aAl/0NcnRYCi/Gnnkj8LaUscXw9eGuZxhEqZEhWOM13A/xN
         E/fQ==
X-Gm-Message-State: ANoB5pmecdyhDWoNrHlGjjdG6VOEFoTWjtBzNAtUvBulG2IMnSlTV48m
        cnXszhI9I7Z/iClqZ0VFL0k=
X-Google-Smtp-Source: AA0mqf5D7o2/8NoAUgVvv9ErTOKhsfzcyTrILMNI3HhtzqSuXJGTsQrweabWIOegwVXKXk8s7KDkSA==
X-Received: by 2002:a17:906:6c7:b0:78d:f455:b5dc with SMTP id v7-20020a17090606c700b0078df455b5dcmr5279880ejb.28.1670607152167;
        Fri, 09 Dec 2022 09:32:32 -0800 (PST)
Received: from [192.168.43.226] (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id e22-20020a056402089600b0046c64b0efdbsm882805edy.33.2022.12.09.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:32:31 -0800 (PST)
Message-ID: <5452514a9cf33315d5c179b8494ddd3e7eac2228.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: add non-standardly sized
 enum tests for btf_dump
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Date:   Fri, 09 Dec 2022 19:32:27 +0200
In-Reply-To: <20221208185703.2681797-4-andrii@kernel.org>
References: <20221208185703.2681797-1-andrii@kernel.org>
         <20221208185703.2681797-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
> Add few custom enum definitions testing mode(byte) and mode(word)
> attributes.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/progs/btf_dump_test_case_syntax.c     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.=
c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> index 4ee4748133fe..26fffb02ed10 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> @@ -25,6 +25,39 @@ typedef enum {
>  	H =3D 2,
>  } e3_t;
> =20
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +/*
> + *enum e_byte {
> + *	EBYTE_1 =3D 0,
> + *	EBYTE_2 =3D 1,
> + *} __attribute__((mode(byte)));
> + *
> + */
> +/* ----- END-EXPECTED-OUTPUT ----- */
> +enum e_byte {
> +	EBYTE_1,
> +	EBYTE_2,
> +} __attribute__((mode(byte)));
> +
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +/*
> + *enum e_word {
> + *	EWORD_1 =3D 0LL,
> + *	EWORD_2 =3D 1LL,
> + *} __attribute__((mode(word)));
> + *
> + */
> +/* ----- END-EXPECTED-OUTPUT ----- */
> +enum e_word {
> +	EWORD_1,
> +	EWORD_2,
> +} __attribute__((mode(word))); /* force to use 8-byte backing for this e=
num */
> +
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +enum e_big {
> +	EBIG_1 =3D 1000000000000ULL,
> +};
> +
>  typedef int int_t;
> =20

Something is off with this test, when executed on my little-endian
machine the output looks as follows:

# ./test_progs -n 23/1
--- -	2022-12-09 17:22:03.412602033 +0000
+++ /tmp/btf_dump_test_case_syntax.output.Z28uhX	2022-12-09 17:22:03.403945=
082 +0000
@@ -23,13 +23,13 @@
 } __attribute__((mode(byte)));
=20
 enum e_word {
-	EWORD_1 =3D 0LL,
-	EWORD_2 =3D 1LL,
+	EWORD_1 =3D 0,
+	EWORD_2 =3D 1,
 } __attribute__((mode(word)));
=20
 enum e_big {
-	EBIG_1 =3D 1000000000000ULL,
-};
+	EBIG_1 =3D 3567587328,
+} __attribute__((mode(word)));

But this is not related to your changes, here is a raw dump:

$ bpftool btf dump file ./btf_dump_test_case_syntax.bpf.o=20

[10] ENUM 'e_big' encoding=3DUNSIGNED size=3D8 vlen=3D1
        'EBIG_1' val=3D3567587328

>  typedef volatile const int * volatile const crazy_ptr_t;
> @@ -224,6 +257,9 @@ struct root_struct {
>  	enum e2 _2;
>  	e2_t _2_1;
>  	e3_t _2_2;
> +	enum e_byte _100;
> +	enum e_word _101;
> +	enum e_big _102;
>  	struct struct_w_typedefs _3;
>  	anon_struct_t _7;
>  	struct struct_fwd *_8;

