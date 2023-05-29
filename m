Return-Path: <bpf+bounces-1383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AB714CDB
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED641C20A1A
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1CE8C16;
	Mon, 29 May 2023 15:18:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB23FD4
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 15:17:59 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08BC9
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 08:17:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3610728e87.2
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685373476; x=1687965476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OcJ10Ol9YzJ3MPpTcuK2Z7/RH+Sb1+08bnP+P/MjD0A=;
        b=fnDCIfdx1fbTwjYCng/jnaUBzL0Sjzvd8v4mxEw5TbvQDIeM8+Me6aEvG2Caps5a6W
         D0l51GkspsKvWVrkjJM1aIcZLYvH7dJIIgeIdowt3bHKamyQDSc2wQ9y2TWipmKz81rt
         oCj4wOW0g0px3Q8dCwrYVMV/YiGX8E9baABHoPoGJfabtPxCMJMS/eeppTF2o+QjRYeI
         afz9i9UAvRkrxN93W8ojRUlOaSIXKb4pXg1hnvfq0ip1QYd8q7gb9uZxwRYqZM8pjuxE
         N7XBASDXGebxVDA6/dDzsH1RKRZ2ezJUUN22hn0IutITkKCNkUpA8H1uMZ5S/ySILL/d
         qPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373476; x=1687965476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcJ10Ol9YzJ3MPpTcuK2Z7/RH+Sb1+08bnP+P/MjD0A=;
        b=QwUMEmHX/8r9HivevagcSumtpa6bBqUZJdrJRE0Z4mJfoO7UnW/yMMeYe6LCRrO8w6
         gR4bvB/xvE3EounnxsgURSG/ExqAqDQY+cgVkuhnE8FJPYYJEmsMj0o6jtdc+RhYLnWl
         6HghevpRv8X5N/2mPKR8hJ+loGA6/iYt8wLNLrynC08PJTzUM0AFRjzx61pQUPEJFqx9
         f+/l/RJRusljAaqJy8xCMaSzPUB64IzifRYxkFONyx5FA7efjkxh8WxZKVfKvDG4eJKd
         JDJWcCYPjRQKepdLsHHEeTsuilLip4s7AwzF7OZyhZs7WTZJTE0qWgKrj2OSab78bT9o
         UjAw==
X-Gm-Message-State: AC+VfDxGczg2lTHEfTGi/Oj4caEN8c0VpAQpbsAP908c0Crw0jgHAGsO
	TI6XCrqRL/8ttciM9ZzWhTvOZwMtqPs=
X-Google-Smtp-Source: ACHHUZ6UmGut6VU0kD6wFryM+NOGpvh2hMP3bNzAGuV1VNsZveb+cwyEC4UlrO/YNV1p2HOdwWU3yQ==
X-Received: by 2002:ac2:4425:0:b0:4f3:b61a:a94b with SMTP id w5-20020ac24425000000b004f3b61aa94bmr3595389lfl.53.1685373476315;
        Mon, 29 May 2023 08:17:56 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l3-20020ac24a83000000b004db3900da02sm27768lfp.73.2023.05.29.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:17:55 -0700 (PDT)
Message-ID: <607940d5dd7515f65d24cd631e3946f50c573645.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test where map
 key_type_id with decl_tag type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 29 May 2023 18:17:53 +0300
In-Reply-To: <20230527223137.1580717-1-yhs@fb.com>
References: <20230527223132.1580338-1-yhs@fb.com>
	 <20230527223137.1580717-1-yhs@fb.com>
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

On Sat, 2023-05-27 at 15:31 -0700, Yonghong Song wrote:
> Add a selftest where map creation key type_id is a decl_tag
> pointing to a struct. Without previous patch, a kernel warning will
> appear similar to the one in the previous patch. With the previous
> patch, the kernel warning is silenced.

Looks good to me with a nitpick:
commit message says "map creation key type_id is a decl_tag",
but test case uses ".key_type_id =3D 1" which is INT
and ".value_type_id =3D 3" which is DECL_TAG.

syscall.c:map_check_btf.c applies the same check both for key and value,
maybe make two tests?

>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 210d643fda6c..69521e1dc330 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3990,6 +3990,26 @@ static struct btf_raw_test raw_tests[] =3D {
>  	.btf_load_err =3D true,
>  	.err_str =3D "Invalid arg#1",
>  },
> +{
> +	.descr =3D "decl_tag test #18, struct member, decl_tag as the value typ=
e",
> +	.raw_types =3D {
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
> +		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
> +		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),		/* [3] */
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0m1\0m2\0tag"),
> +	.map_type =3D BPF_MAP_TYPE_ARRAY,
> +	.map_name =3D "tag_type_check_btf",
> +	.key_size =3D sizeof(int),
> +	.value_size =3D 8,
> +	.key_type_id =3D 1,
> +	.value_type_id =3D 3,
> +	.max_entries =3D 1,
> +	.map_create_err =3D true,
> +},
>  {
>  	.descr =3D "type_tag test #1",
>  	.raw_types =3D {


