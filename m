Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEF27D970
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgI2U7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgI2U7g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 16:59:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601413175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Wsr2RQxUuXWhhfJs2L8dgou8zQRNmM6F/a7J1jxRyk=;
        b=NebFs0uWKB9YqEnmY9nBAirYJ2utanBCRXHVZHEZTiQvX1fwxeCyuviFUNpG6G1B00Em+7
        RQHKOjOqs8FcshM3po5ms70/Q3z43OYdCi1XArkGUk/GgYM5hVL5Vt2H8ewecqHRQ7dj12
        fjI0Qs+MpfHdTzTRqKrm5doOKJIgzos=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571--ffz-IxpMa-4WwUvR2QSFw-1; Tue, 29 Sep 2020 16:59:33 -0400
X-MC-Unique: -ffz-IxpMa-4WwUvR2QSFw-1
Received: by mail-oi1-f197.google.com with SMTP id l77so2156621oig.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 13:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Wsr2RQxUuXWhhfJs2L8dgou8zQRNmM6F/a7J1jxRyk=;
        b=W7NNsrHN/9Kwj+JqJYGGX92JwrBNeMjKeea7zfsI3DfQM4qwfhLIwtsHowpxARLdgz
         j0Z+GFBcdeaii/D77RhVNbmEIJoYJvyrqUmEBtAZr9gqa8mBxqik0MAt3jsq0Baw7jj9
         bNYFUWmPQ1hf62mgmMopL6Rn6zGepYaOxUD4CXyuT6Q7t2K5vZADRC4WMSpYV9y4ijJ9
         WiE/t1fSal5VaS4ds/va2biV+VxQGHf6i41jWMT5DhFEnAeDFr+cSSRjGSWENajlmn/r
         2YjFFJvizK69Ub9lVBoL+OdU9GLYYTkY7JN4v4RaLwV6j0c75SCpwWd1JtYqWwg6105j
         FpAQ==
X-Gm-Message-State: AOAM532JpICUwNkKksum8WPGzOgHCSa5Pi1YXRkZvu6CyMEHx/n0kPvB
        fwIuK+yMVX7KI5edamnJ5avMeZGYLTVzja4uKXgME9oy7ORC1MQJD6t7ps5YDG38BfhfXmcyNSi
        38hGvs8/8jYn8
X-Received: by 2002:a9d:7e83:: with SMTP id m3mr4124202otp.259.1601413172120;
        Tue, 29 Sep 2020 13:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwA67O2tiIlP/0BKMmMhFvE3zLJM3Etpl8ojMx5X66IBs+ZNgpSE2l4rX25wkC8Jz88YfAcg==
X-Received: by 2002:a9d:7e83:: with SMTP id m3mr4124143otp.259.1601413170653;
        Tue, 29 Sep 2020 13:59:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z63sm1264317oiz.37.2020.09.29.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:59:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6E5C183C5B; Tue, 29 Sep 2020 22:59:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next] selftests: Make sure all 'skel' variables are
 declared static
In-Reply-To: <CAADnVQJt=Sj86-r9y_KvzCuLQU_r=kw4b+=fFx5-EYSA6SAeKQ@mail.gmail.com>
References: <20200929123026.46751-1-toke@redhat.com>
 <CAADnVQJt=Sj86-r9y_KvzCuLQU_r=kw4b+=fFx5-EYSA6SAeKQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Sep 2020 22:59:27 +0200
Message-ID: <87h7rg1eq8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Sep 29, 2020 at 5:32 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> If programs in prog_tests using skeletons declare the 'skel' variable as
>> global but not static, that will lead to linker errors on the final link=
 of
>> the prog_tests binary due to duplicate symbols. Fix a few instances of t=
his.
>>
>> Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel =
and global variables")
>> Fixes: 9a856cae2217 ("bpf: selftest: Add test_btf_skc_cls_ingress")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks for the fix. Applied.

You're welcome! And thanks :)

> I wonder why we don't see it with different gcc and clang versions.

Yeah, I was wondering about that as well, actually...

> What linker do you use?
> And what kind of error do you see?

  BINARY   test_progs
/usr/bin/ld: /home/build/linux/tools/testing/selftests/bpf/sock_fields.test=
.o:/home/build/linux/tools/testing/selftests/bpf/prog_tests/sock_fields.c:3=
9: multiple definition of `skel'; /home/build/linux/tools/testing/selftests=
/bpf/btf_skc_cls_ingress.test.o:/home/build/linux/tools/testing/selftests/b=
pf/prog_tests/btf_skc_cls_ingress.c:19: first defined here
collect2: error: ld returned 1 exit status
make: *** [Makefile:397: /home/build/linux/tools/testing/selftests/bpf/test=
_progs] Error 1

$  ld --version
GNU ld (GNU Binutils) 2.35

$ gcc --version
gcc (GCC) 10.2.0

-Toke

