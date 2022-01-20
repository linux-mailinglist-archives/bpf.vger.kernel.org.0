Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83349559E
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377693AbiATUqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 15:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiATUqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 15:46:24 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2DFC061574;
        Thu, 20 Jan 2022 12:46:24 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w188so10612973oiw.13;
        Thu, 20 Jan 2022 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=NrsIi2PyN+qoea+RqSEc0H4K9wn/y6qauCQdo3wKht8=;
        b=UClqo9sjZQV48BcVu9Jy9TbMtqe8jFYvfbOPQ9njrn9aRsy2hlaPYtqUwFkJKna6de
         TmeZwcU/cKNqYvOINTAT5sOZIeVY0O0PEssdjjQtp+3cM3JusyzVHmd5y666/w3v0mWs
         4g/EPZTKd7LulVwrXyEBM9xSnpQs0m3L2x0VSfaI+kHD4eaZP2dRjfs2xNrmv5AmnzoW
         BMQl9Pg2qlfken8axV8Rro1acW/AsNlA28ywKik3I66BXPu+gwn2c/UYq/Qn0OpGeVuM
         1oJ9Rb1OYbS9U+JjhPMHoFvjojjowTU2n94jFC42OGQHYY+OsyQ6Vk0CYpM9eAMyyfZk
         VWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=NrsIi2PyN+qoea+RqSEc0H4K9wn/y6qauCQdo3wKht8=;
        b=LVLd9jRJDMC/IDu81cYJ1jN1sPsW2RhXuf9zZlnumVos1MRPuAN2B87cbZhA1Y6QRM
         N32MrTFW8pOIm1WbImAVZvwql+ET0I461ZoqHdFB0+aGFeWuhKvvd18eKV0Gqy/x5qbT
         wSK158ndN648qSyEbX7eeoEw1emr+J6n3k0prXWHO6LAqA37hiQNlJ9uS3V/5T1/mLY2
         oVvTzrh2LkDYyzPQ1Ei80gLjiJnry4jEHelwYyihbiZZD9WQj9e7f81+/AdmQpfzYRBv
         c7pQtlEcAZzMxyEb6bRPIhPUYm9Hte3/1TaImPdAUoCVvSvHcr6hKbj/DvRc4uqRBJuw
         Leiw==
X-Gm-Message-State: AOAM533SdUQWKO2O1b1DlLjdStFTJWcjOxfqwevvb0PSjU5YfmztJJ8v
        jPKXrSDLzTcBw/uKsJTYQTmZV6ck9/A=
X-Google-Smtp-Source: ABdhPJwfZaBxE4H1/n0bKmeOPlCXduU+EN4iBCX/9pv3p9PnLxF7u0Kz9hlDaji3jpjF0NlwLQW4sw==
X-Received: by 2002:aca:241a:: with SMTP id n26mr617016oic.24.1642711583977;
        Thu, 20 Jan 2022 12:46:23 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w13sm177094oik.52.2022.01.20.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 12:46:23 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:46:17 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>
CC:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves_0/2=5D_Parallelize?= =?US-ASCII?Q?_BTF_type_info_generating_of_pahole?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzYtzB6=bphN+RXVrkb3yT4SWp6Xi48KjZhUVLYsQLjO=A@mail.gmail.com>
References: <20220120010817.2803482-1-kuifeng@fb.com> <CAEf4BzYtzB6=bphN+RXVrkb3yT4SWp6Xi48KjZhUVLYsQLjO=A@mail.gmail.com>
Message-ID: <3124A294-670E-4E5E-9C7F-FEF6C8247551@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On January 20, 2022 4:59:08 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakryi=
ko@gmail=2Ecom> wrote:
>+cc bpf@vger=2Ekernel=2Eorg
>
>On Wed, Jan 19, 2022 at 5:08 PM Kui-Feng Lee <kuifeng@fb=2Ecom> wrote:
>>
>> Creating an instance of btf for each worker thread allows
>> steal-function provided by pahole to add type info on multiple threads
>> without a lock=2E  The main thread merges the results of worker threads
>> to the primary instance=2E
>>
>> Copying data from per-thread btf instances to the primary instance is
>> expensive now=2E  However, there is a patch landed at the bpf-next
>> repository=2E [1] With the patch for bpf-next and this patch, they drop
>> total runtime to 5=2E4s from 6=2E0s with "-j4" on my device to generate
>> BTF for Linux=2E
>
>Just a few more data points=2E I've tried this locally with 40 cores,
>both with and without the libbpf's btf__add_btf() optimization=2E
>
>BASELINE NON-PARALLEL
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>$ time =2E/pahole -J ~/linux-build/default/vmlinux
>=2E/pahole -J ~/linux-build/default/vmlinux  11=2E17s user 0=2E66s system
>99% cpu 11=2E832 total
>
>BASELINE PARALLEL
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>$ time =2E/pahole -j40 -J ~/linux-build/default/vmlinux
>=2E/pahole -j40 -J ~/linux-build/default/vmlinux  13=2E85s user 0=2E75s
>system 290% cpu 5=2E023 total
>
>THESE PATCHES WITHOUT LIBBPF SPEED-UP
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>$ time =2E/pahole -j40 -J ~/linux-build/default/vmlinux
>=2E/pahole -j40 -J ~/linux-build/default/vmlinux  25=2E94s user 1=2E15s
>system 685% cpu 3=2E954 total
>
>THESE PATCHES WITH LATEST LIBBPF SPEED-UP
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>$ time =2E/pahole -j40 -J ~/linux-build/default/vmlinux
>=2E/pahole -j40 -J ~/linux-build/default/vmlinux  27=2E49s user 1=2E08s
>system 858% cpu 3=2E328 total
>
>
>So on 40 cores, it's a speed up from 11=2E8 seconds non-parallel, to 5s
>parallel without Kui-Feng's changes, to 4s with Kui-Feng's changes, to
>3=2E3s after libbpf update (I did it locally, will sync this to Github
>today)=2E
>
>4x speed up, not bad!

That's indeed excellent! From the limited review I've made so far it looks=
 good, takes advantage of the leg work I did, I'll just break down the patc=
hes a bit more, look at the review comments from you and repost, I'll not c=
hange the patches, just split them a bit more, tomorrow morning=2E

- Arnaldo
>
>But parallel mode is not currently enabled in kernel build, let's
>enable parallel mode and save those seconds during the kernel build!



>
>>
>> [1] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/bpf/bpf-next=2E=
git/commit/?id=3Dd81283d27266
>>
>> Kui-Feng Lee (2):
>>   dwarf_loader: Prepare and pass per-thread data to worker threads=2E
>>   pahole: Use per-thread btf instances to avoid mutex locking=2E
>>
>>  btf_encoder=2Ec  |   5 +++
>>  btf_encoder=2Eh  |   2 +
>>  btf_loader=2Ec   |   2 +-
>>  ctf_loader=2Ec   |   2 +-
>>  dwarf_loader=2Ec |  58 ++++++++++++++++++------
>>  dwarves=2Eh      |   9 +++-
>>  pahole=2Ec       | 120 ++++++++++++++++++++++++++++++++++++++++++++++-=
--
>>  pdwtags=2Ec      |   3 +-
>>  pfunct=2Ec       |   4 +-
>>  9 files changed, 180 insertions(+), 25 deletions(-)
>>
>> --
>> 2=2E30=2E2
>>
