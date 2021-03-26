Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D2B34A4CE
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZJnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 05:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhCZJnj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 05:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616751819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaPxAtTlYxw0i9BFM/qU8qS7O6tnfcWIERywcqe7zaM=;
        b=GNIVnXQjsxMexLnOcNiXeDYfp8Hs2gs1AKhIf0hEd2SEhD88esesBmIXhN8yok0vxWHuAl
        vzWCWQaTGsWjB+kVYthXY9XOm2AR249IRHh+z0ip9CUT0rYDd81movWowgLI4VKNSM2Sh2
        nEF9eE/OH60yM+NlFMBxKQ4QsIktOX4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-IpfnaaM0MGegTXyAxinu1A-1; Fri, 26 Mar 2021 05:43:36 -0400
X-MC-Unique: IpfnaaM0MGegTXyAxinu1A-1
Received: by mail-ed1-f70.google.com with SMTP id v27so4113950edx.1
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 02:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yaPxAtTlYxw0i9BFM/qU8qS7O6tnfcWIERywcqe7zaM=;
        b=qHA9CDtsE7JMU/lLT667eI93GnPqMiPIHgBgcu+fVQ6kbpwcfKdWLYPTa+7n92jSz3
         21coLlch2nLZZP4BSBYP91rZO/g3cAgiHDMB7j4swaAQwqs4usPxl+AGQQSAbZYOkNTy
         FLMEWCweyHslb7Zblo8cT+tC0jeLQgEDMU/E5dRAd+/aIZjV2Qx89GfgbqK54rx9/vZy
         fTlqsdgyc/9g5JazKGUG0gztUKA446vUaMfzm8E/J5SpQgLWpfxgnQimO5HQb4kZKEzc
         5FynHjctgoSqih6kX+JBoCMkhGKnS1YFqmgA4QN5IfdxpB09koG/SaDUVyN6J5jj9Lt3
         19LQ==
X-Gm-Message-State: AOAM5323e3Z/zHQpoUM6ZBmxb8fc1dMyYP1jNj9D5TAvC0gUDkkxhRGT
        /dWISDcQBOOMRCqwYBksjCuvsJZGlB0mT62RKGXz8z82EDyF84W/z9Dqj6+/a41WDNKC+b+dqXm
        +O0ZSKnwBAB6r
X-Received: by 2002:aa7:c941:: with SMTP id h1mr13739175edt.85.1616751815563;
        Fri, 26 Mar 2021 02:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW0egnm8sR6kaqK8lS5WUkeH6ar+nWajJS0DKxKFG/qcb37iNSYyisVn6OH1H2dwMXIserfQ==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr13739140edt.85.1616751815208;
        Fri, 26 Mar 2021 02:43:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j1sm3600230ejt.18.2021.03.26.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:43:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1C1521801A3; Fri, 26 Mar 2021 10:43:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf/selftests: test that kernel rejects a
 TCP CC with an invalid license
In-Reply-To: <CAEf4BzaxmrWFBJ1mzzWzu0yb_iFX528cAFVbXrncPEaJBXrd2A@mail.gmail.com>
References: <20210325211122.98620-1-toke@redhat.com>
 <20210325211122.98620-2-toke@redhat.com>
 <CAEf4BzaxmrWFBJ1mzzWzu0yb_iFX528cAFVbXrncPEaJBXrd2A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 10:43:34 +0100
Message-ID: <87lfaacks9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Mar 25, 2021 at 2:11 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> This adds a selftest to check that the verifier rejects a TCP CC struct_=
ops
>> with a non-GPL license.
>>
>> v2:
>> - Use a minimal struct_ops BPF program instead of rewriting bpf_dctcp's
>>   license in memory.
>> - Check for the verifier reject message instead of just the return code.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 44 +++++++++++++++++++
>>  .../selftests/bpf/progs/bpf_nogpltcp.c        | 19 ++++++++
>>  2 files changed, 63 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_nogpltcp.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> index 37c5494a0381..a09c716528e1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> @@ -6,6 +6,7 @@
>>  #include <test_progs.h>
>>  #include "bpf_dctcp.skel.h"
>>  #include "bpf_cubic.skel.h"
>> +#include "bpf_nogpltcp.skel.h"
>
> total nit, but my eyes can't read "nogpltcp"... wouldn't
> "bpf_tcp_nogpl" be a bit easier?

Haha, yeah, good point - my eyes also just lump it into a blob...

>>
>>  #define min(a, b) ((a) < (b) ? (a) : (b))
>>
>> @@ -227,10 +228,53 @@ static void test_dctcp(void)
>>         bpf_dctcp__destroy(dctcp_skel);
>>  }
>>
>> +static char *err_str =3D NULL;
>> +static bool found =3D false;
>> +
>> +static int libbpf_debug_print(enum libbpf_print_level level,
>> +                             const char *format, va_list args)
>> +{
>> +       char *log_buf;
>> +
>> +       if (level !=3D LIBBPF_WARN ||
>> +           strcmp(format, "libbpf: \n%s\n")) {
>> +               vprintf(format, args);
>> +               return 0;
>> +       }
>> +
>> +       log_buf =3D va_arg(args, char *);
>> +       if (!log_buf)
>> +               goto out;
>> +       if (err_str && strstr(log_buf, err_str) !=3D NULL)
>> +               found =3D true;
>> +out:
>> +       printf(format, log_buf);
>> +       return 0;
>> +}
>> +
>> +static void test_invalid_license(void)
>> +{
>> +       libbpf_print_fn_t old_print_fn =3D NULL;
>> +       struct bpf_nogpltcp *skel;
>> +
>> +       err_str =3D "struct ops programs must have a GPL compatible lice=
nse";
>> +       old_print_fn =3D libbpf_set_print(libbpf_debug_print);
>> +
>> +       skel =3D bpf_nogpltcp__open_and_load();
>> +       if (CHECK(skel, "bpf_nogplgtcp__open_and_load()", "didn't fail\n=
"))
>
> ASSERT_OK_PTR()
>
>> +               bpf_nogpltcp__destroy(skel);
>
> you should destroy unconditionally
>
>> +
>> +       CHECK(!found, "errmsg check", "expected string '%s'", err_str);
>
> ASSERT_EQ(found, true, "expected_err_msg");
>
> I can never be sure which way CHECK() is checking

Ah, thanks! I always get confused about CHECK() as well! Maybe it should
be renamed to ASSERT()? But that would require flipping all the if()
statements around them as well :/

-Toke

