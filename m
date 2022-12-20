Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6010D6518EB
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 03:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLTCnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 21:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTCnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 21:43:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFD12770;
        Mon, 19 Dec 2022 18:43:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d7so10880970pll.9;
        Mon, 19 Dec 2022 18:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avEvZKXH+0yFRR6A8JhHejaHRG1ppfym+XG7z6AlFWM=;
        b=qdz9CxFrNYb+DXjGHV27he87odiXtX6SUFEzCpeL2V8u6+4T7gjqf+qPtZ9/f21/G5
         44vtPsgtn+JLPA/jCvlW09WHAR5LnvaFD/Ch8shfO7fvMbpslao+5cYboB5qax6T6Buc
         uTIFPU82BUvSMN84cPyYRdkyLSo6APd0zkFFqjDk/e49/X0Q2V1vLbzNsrAmnUDdGj4u
         s+6k5MQeAcWc9q10pq8iFFqMlGQtDKYrOG+IPkrNi1hAeUfbp7RSHiWHxmSIMx9XgqNU
         2BCeRYLNG87GxOz/x8yfesAi3imwlaew5RdYvetENCzCZ9sGLmZb6K/yCbRRoex1tyO1
         v38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avEvZKXH+0yFRR6A8JhHejaHRG1ppfym+XG7z6AlFWM=;
        b=eWIXEvlRFsHqg3Pbv/tAUOwxwFOgKrR29xvMg3er/J9XpykzBnUCht1ggk+K5aA8TQ
         yIkn2QaPko/a5LVbFRWS5Nwa2ZefhV56IG9/MNuUzbLACjAcbDORDogWoDls1XMHyJJ7
         +XecxFIxUrUUF5jYKxmZ89Yu1ApM/kbUUx96L/S8y017Quo0/guucdvkPzvIDXTQt+Fy
         S5coK2U8EgpbdIcJfBPXCPVG2bI4kzEHuoEbk+b3EpON89tJ1ckSVi5nZ0tKDlToqmbo
         +IMDFdLz4znvgFX3QKaPOBEK9lpu8m1ETxu8vZGaa8uQ/9Ki2XoovIE9MAV/VeZSL72p
         8aHQ==
X-Gm-Message-State: AFqh2kr1Hk5dNTnNJVL4PZUZnWxaVm+lbtuMY5Nm+TeYMHS3BLuUNCzk
        qoVqTrtFlmDP6AoLuOkZYw==
X-Google-Smtp-Source: AMrXdXtnv7uBeJGnRdm31kbuFE3gQPZiO5dP3bMRbpG7nGyyySqfRI5JAYO8hDIaKpWOp8lxpVBEbQ==
X-Received: by 2002:a05:6a20:9f98:b0:b2:2719:8f12 with SMTP id mm24-20020a056a209f9800b000b227198f12mr2063132pzb.16.1671504201705;
        Mon, 19 Dec 2022 18:43:21 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id i192-20020a6287c9000000b00575cdd7c0adsm7328477pfe.80.2022.12.19.18.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2022 18:43:21 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation
 only neither reg is PTR_TO_BTF_ID
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <7cfaaafa-0eda-a314-5b22-7e22c029f4ad@linux.dev>
Date:   Tue, 20 Dec 2022 10:43:08 +0800
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
Message-Id: <AAD9953F-1A63-49E9-8AD0-EC6503165BD5@gmail.com>
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

Sure, thanks for the hint, will send patch v3 soon.

Thanks
Hao=
