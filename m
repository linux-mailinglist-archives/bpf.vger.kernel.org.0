Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE86A9B47
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCCQAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 11:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCCQAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 11:00:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374218AB2
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 08:00:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i10so3101283plr.9
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 08:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1677859205;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+bKxnslbiPQTPVnArcpiYsTG2+6QaeqJUTffYVGlTU=;
        b=P3anbEoDFBnJH1UJB2DMsjlYt2nNu0UlDaiX6PV/uZNqxlUrZh/4WRapYu4nKbjbwX
         7zFVwdieEt6GxGaFjePVfvbLHMq+aGRnahyzFLvKlmh8VsyrejB21Z43HevrujKvJDZJ
         8sdrs8VD8gy10CqXabYsWnB7IOzm4zbcSCdpXozIFRcrEHvl8j5szRX6nWuUdPawxkzv
         nUTxtdUQOR+XYUj1WpQ2nYAe9FiV4OtS/maZNq3UC46FQp6YK5A+lzWbOb2FlFWaag7m
         l8DyM+ueyK81JhEFFDQSiTE7TuLht8qfXnr/PFUYwDFSf03UmZMN3ANzY07NhJrj/Z/K
         BN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677859205;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+bKxnslbiPQTPVnArcpiYsTG2+6QaeqJUTffYVGlTU=;
        b=nfk+q75r8dkpn8mqgOfumMyfAe/M5JFdj+f1jJXPpyeFjS7HJksAieSXspTiFWl7wF
         XJdDqMGJoZBzWcPbXwvzZ1Be/VimPiyQiVL2se5AUAIWCVcbVrjhfJAAbjPBhmGQEMan
         PsSjLWybqx2CluvP/+z3GM/Fukixs1eQvs65VrZPYhydva42gO1c5ZQ+rzVre6goWyLi
         8uDHzC6eqvXyf0SklYNkU05UQC5YsK+/dsEqijP5mnaihq3qx4aD2Vol/OJPEBti3sEo
         92zxm6i4AgHUNafpo+mduHMW/wWUWT+lUlMVe3GkwjOk83IugTiiKcrcDXOzj2jpT6OR
         fHCw==
X-Gm-Message-State: AO0yUKX6YY9x0hGlNwvok8VRE3zyx6NRA5DQ9VCOjOJ3CJ2fbbCRLkB1
        HqWaOsEFaZhfa837eVzXQ9xOIPEexA746N5e
X-Google-Smtp-Source: AK7set+0LIKY5V2MoHl74aBsYkueeLaMUVg1JlcuTrF5XU30Tl16EnFKH+Dg93ZcH3hnmu/JOSB24w==
X-Received: by 2002:a05:6a20:840c:b0:cd:1e80:5840 with SMTP id c12-20020a056a20840c00b000cd1e805840mr2974339pzd.34.1677859204538;
        Fri, 03 Mar 2023 08:00:04 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:1995:b629:b728:22ba? ([2601:647:4900:b6:1995:b629:b728:22ba])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7904f000000b005a9bf65b591sm1783862pfo.135.2023.03.03.08.00.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2023 08:00:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_sock_destroy
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <CAEf4BzbJ49BCBh8jwjq+kOLn=QQPxGpG2gb8+Gn3uJv9X6szhg@mail.gmail.com>
Date:   Fri, 3 Mar 2023 08:00:02 -0800
Cc:     bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2316C6FD-7DCA-4288-985D-AE9D49509280@isovalent.com>
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-4-aditi.ghag@isovalent.com>
 <CAEf4BzbJ49BCBh8jwjq+kOLn=QQPxGpG2gb8+Gn3uJv9X6szhg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 27, 2023, at 11:37 AM, Andrii Nakryiko =
<andrii.nakryiko@gmail.com> wrote:
>=20
> On Thu, Feb 23, 2023 at 2:05 PM Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>>=20
>> The test cases for TCP and UDP iterators mirror the intended usages =
of the
>> helper.
>>=20
>> The destroy helpers set `ECONNABORTED` error code that we can =
validate in the
>> test code with client sockets. But UDP sockets have an overriding =
error code
>> from the disconnect called during abort, so the error code the =
validation is
>> only done for TCP sockets.
>>=20
>> The `struct sock` is redefined as vmlinux.h forward declares the =
struct, and the
>> loader fails to load the program as it finds the BTF FWD type for the =
struct
>> incompatible with the BTF STRUCT type.
>>=20
>> Here are the snippets of the verifier error, and corresponding BTF =
output:
>>=20
>> ```
>> verifier error: extern (func ksym) ...: func_proto ... incompatible =
with kernel
>>=20
>> BTF for selftest prog binary:
>>=20
>> [104] FWD 'sock' fwd_kind=3Dstruct
>> [70] PTR '(anon)' type_id=3D104
>> [84] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>>        '(anon)' type_id=3D70
>> [85] FUNC 'bpf_sock_destroy' type_id=3D84 linkage=3Dextern
>> --
>> [96] DATASEC '.ksyms' size=3D0 vlen=3D1
>>        type_id=3D85 offset=3D0 size=3D0 (FUNC 'bpf_sock_destroy')
>>=20
>> BTF for selftest vmlinux:
>>=20
>> [74923] FUNC 'bpf_sock_destroy' type_id=3D48965 linkage=3Dstatic
>> [48965] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>>        'sk' type_id=3D1340
>> [1340] PTR '(anon)' type_id=3D2363
>> [2363] STRUCT 'sock' size=3D1280 vlen=3D93
>> ```
>>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>> .../selftests/bpf/prog_tests/sock_destroy.c   | 125 =
++++++++++++++++++
>> .../selftests/bpf/progs/sock_destroy_prog.c   | 110 +++++++++++++++
>> 2 files changed, 235 insertions(+)
>> create mode 100644 =
tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> create mode 100644 =
tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>>=20
>=20
> [...]
>=20
>> +       n =3D send(clien, "t", 1, 0);
>> +       if (CHECK(n < 0, "client_send", "client failed to send on =
socket\n"))
>> +               goto cleanup;
>> +
>> +       start_iter_sockets(skel->progs.iter_tcp6);
>> +
>> +       n =3D send(clien, "t", 1, 0);
>> +       if (CHECK(n > 0, "client_send after destroy", "succeeded on =
destroyed socket\n"))
>> +               goto cleanup;
>> +       CHECK(errno !=3D ECONNABORTED, "client_send", "unexpected =
error code on destroyed socket\n");
>> +
>=20
> please don't use CHECK() macros, prefere ASSERT_xxx() ones

Yes, this'll be handled in the next revision. Thanks!

>=20
>> +
>> +cleanup:
>> +       close(clien);
>> +cleanup_serv:
>> +       close(serv);
>> +}
>> +
>> +
>> +void test_udp(struct sock_destroy_prog *skel)
>=20
> are these meant to be subtests? If yes, model them as such?

I wasn't aware of subtests markers. I'll look into the other tests for =
reference.

>=20
> and in either case, make these funcs static

 Will do!

>=20
>> +{
>> +       int serv =3D -1, clien =3D -1, n =3D 0;
>> +
>> +       serv =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
>> +       if (CHECK(serv < 0, "start_server", "failed to start =
server\n"))
>> +               goto cleanup_serv;
>> +
>=20
> [...]

