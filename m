Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8225D653201
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 14:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLUNql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 08:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLUNqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 08:46:39 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC56442;
        Wed, 21 Dec 2022 05:46:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f9so10423182pgf.7;
        Wed, 21 Dec 2022 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBaHVyrV7POujfixNjWaFgLMTj+0e1DKLqJO9AQRCRg=;
        b=U4VPw73nDm+8U6AAipX8JQioyKF6hTYoCj0gMRyNG3znjjPdjriI2Pp2M0ja9Qjglg
         m/JoRZimd3uh2wzdU6/GvrxWZU+S2awIuTYIgMlWXJs1g1A0gKXWS6l48nOFJ9izNRv3
         +rx1JQP8lD6EDo/Rfv6vBGTMCreJxcZ1JH080qaLFZcc0nfNhKe6UwZazbCv8DBSt1su
         hQdw++o0WBhBB+pk2JmmGqxJnrI+9AykWLt6x9yAjfLGRxFNfClPvMVNp5M+zbQbtByK
         wxWrna8Evv3lvKeRduX7ub8oId+Y0NvPJahZuYOOHh1bC8D8CgRE18OihrZgo0cju/c4
         VQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBaHVyrV7POujfixNjWaFgLMTj+0e1DKLqJO9AQRCRg=;
        b=JTdkcvJJYBUFLyIuLdEInWtBKLdrav4dP8h3njbHpvfAQfe0lGlW0Uc8yKo0xKYaj4
         XX6eDML/X02tswSDqMgqgjTcTmysy/+a5Xb67lPE6coHmHZViz0wfTKKKdr2lkWn2517
         h0WjpUMznLY9U98NKRZ2E6DxWEhXRA/1h3fMd2tAez11WwD/OIEeQYvgTt2fl0oS6mQU
         q0r6xcmG2l8X+i9Kwfl99iUs/8pSbRQYJSGIr2pjWoMviALVyP/wSkcKryFYi199/av6
         ZAZGkeRGkK8t3PBx2oHXEuftKAQqUy3T2EgGV17b8Vl8k1L6UTUNFvb+tlqYhytDMnDS
         VbpQ==
X-Gm-Message-State: AFqh2kqMS93/1itDqZNU2XnFwx5pMHiVY3gJOQ6tl1QPfdbPwJMrzS8E
        jJeLgOPXSN9+LT8Lc9yCXA==
X-Google-Smtp-Source: AMrXdXtXOGY9IxoHXLDlNGv8XvQrcIqM65VPTe4A/3xBuYUmUYhKdCzylXxrZ/e1PxDg2nnIGcZETA==
X-Received: by 2002:aa7:93da:0:b0:57a:8f1e:fd35 with SMTP id y26-20020aa793da000000b0057a8f1efd35mr2512650pff.16.1671630397642;
        Wed, 21 Dec 2022 05:46:37 -0800 (PST)
Received: from smtpclient.apple (n119236129232.netvigator.com. [119.236.129.232])
        by smtp.gmail.com with ESMTPSA id v10-20020a62c30a000000b0057ef1262347sm10874010pfg.19.2022.12.21.05.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2022 05:46:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation
 only neither reg is PTR_TO_BTF_ID
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev>
Date:   Wed, 21 Dec 2022 21:46:23 +0800
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EAED688-C971-410E-BA56-9629CF9B3C91@gmail.com>
References: <20221213030436.17907-1-sunhao.th@gmail.com>
 <20221213030436.17907-2-sunhao.th@gmail.com>
 <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 20 Dec 2022, at 6:01 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 12/12/22 7:04 PM, Hao Sun wrote:
>> Verify that nullness information is not porpagated in the branches
>> of register to register JEQ and JNE operations if one of them is
>> PTR_TO_BTF_ID.
>=20
> Thanks for the fix and test.
>=20
>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>>  .../bpf/verifier/jeq_infer_not_null.c         | 22 =
+++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> diff --git =
a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c =
b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
>> index 67a1c07ead34..b2b215227d97 100644
>> --- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
>> +++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
>> @@ -172,3 +172,25 @@
>>   .prog_type =3D BPF_PROG_TYPE_XDP,
>>   .result =3D ACCEPT,
>>  },
>> +{
>> + "jne/jeq infer not null, PTR_TO_MAP_OR_NULL unchanged with =
PTR_TO_BTF_ID reg",
>> + .insns =3D {
>> + BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
>> + BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
>> + BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
>> + BPF_LD_MAP_FD(BPF_REG_1, 0),
>> + /* r6 =3D bpf_map->inner_map_meta; */
>> + BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
>=20
> This bpf_map->inner_map_meta requires CO-RE. It works now but could be =
fragile in different platform and in the future bpf_map changes. Take a =
look at the map_ptr_kern.c which uses =
"__attribute__((preserve_access_index))" at the "struct bpf_map".
>=20
> Please translate this verifer test into a proper bpf prog in C code =
such that it can use the CO-RE in libbpf.  It should run under =
test_progs instead of test_verifier. The bpf prog can include the =
"vmlinux.h" to get the "__attribute__((preserve_access_index))" for =
free.  Take a look at =
https://lore.kernel.org/all/20221207201648.2990661-2-andrii@kernel.org/ =
which has example on how to check verifier message in test_progs.
>=20

Hi,

I=E2=80=99ve tried something like the bellow, but soon realized that =
this
won=E2=80=99t work because once compiler figures out `inner_map` equals
to `val`, it can choose either reg to write into in the following
path, meaning that this program can be rejected due to writing
into read-only PTR_TO_BTF_ID reg, and this makes the test useless.

Essentially, we want two regs, one points to PTR_TO_BTD_ID, one
points to MAP_VALUR_OR_NULL, then compare them and deref map val.
It=E2=80=99s hard to implement this in C level because compilers decide
which reg to use but not us, maybe we can just drop this test.=20

thoughts?=20
 =20
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, u64);
+	__type(value, u64);
+} m_hash SEC(".maps");
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'map_value_or_null")
+int jeq_infer_not_null_ptr_to_btfid(void *ctx)
+{
+	struct bpf_map *map =3D (struct bpf_map *)&m_hash;
+	struct bpf_map *inner_map =3D map->inner_map_meta;
+	u64 key =3D 0, ret =3D 0, *val;
+
+	val =3D bpf_map_lookup_elem(map, &key);
+	/* Do not mark ptr as non-null if one of them is
+	 * PTR_TO_BTF_ID, reject because of invalid access
+	 * to map value.
+	 */
+	if (val =3D=3D inner_map)
+		ret =3D *val;
+
+	return ret;
+}


