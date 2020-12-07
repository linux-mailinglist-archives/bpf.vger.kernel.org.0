Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E12D16DA
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLGQxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgLGQxF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 11:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607359898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2+iW4RaCunmJadgGixc7tSG+nCepKzvprLYvqLbaDo=;
        b=TG5p+UjSWsf0QrXyV7JCHCxeTJcE1D/iK676h28pKU1KGyeY9i2fq3zj74FRSsb6t/RHR0
        AmeWA7hYFxSeQicLvmh8qFKx2QEfblAr0S4xYZyZp8KbXy9zFnWJ4tp71KAee4F/63FcUM
        w68U05VvGD48cYzlmXg6h4djrzfQZNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-M-VrwJplOAKX4biVNqaWow-1; Mon, 07 Dec 2020 11:51:37 -0500
X-MC-Unique: M-VrwJplOAKX4biVNqaWow-1
Received: by mail-wm1-f69.google.com with SMTP id r1so5545237wmn.8
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=C2+iW4RaCunmJadgGixc7tSG+nCepKzvprLYvqLbaDo=;
        b=NLRg8/VEMYzjleztoM6wOIjORBcSiDxgXU67Yqz1mOcPqR2vcosG2IF3udWBqcMaLp
         2W/tlq9n+OIZM50YxNKItOHM1t6EBeHADpsSPvHAPQQxsYmiu+WZmnxv6Juh8lnRzYqE
         Z5x/44O9I4d7TscuU81A4G2sijDhjIr0alRIdr416yyhmigZqQphZ0IShO8ylf3Xkz4z
         ddN0EXuq099TgOi2WrUgR/DSvasF9L5/ndzDC7zHnkmzxRa47KeJXUP3AdfdDDBIMQsr
         nPOKPuoRxRlPHaywzUGI6/bEsoSzahS1hdYtjJ/Tdh0vcm0t7G8pNfPGcaUmNXfMYz6y
         zieA==
X-Gm-Message-State: AOAM531t9ozAKuxRBbaP7YJL0tAxqQWRQP4YER5GGu8rFBAEVJ4dhkp7
        DNuqlKMDxqyCd5hc1Z9KbfewtFGPgx+KT03Wf0H0PP3efG1wTQYxUj0ODNKnxIYL9Mc2n4vCA7U
        yRltoas9ddGi7
X-Received: by 2002:adf:e512:: with SMTP id j18mr5561872wrm.52.1607359895968;
        Mon, 07 Dec 2020 08:51:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJhgXm8i68ygvuAI76n1Ld07e+zzasG8fkWlsMfzy6eEkdxe/YZqHM35kHtQ7YFWmnEnnGew==
X-Received: by 2002:adf:e512:: with SMTP id j18mr5561854wrm.52.1607359895796;
        Mon, 07 Dec 2020 08:51:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b12sm477869wmj.2.2020.12.07.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:51:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B59471843F5; Mon,  7 Dec 2020 17:51:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk>
 <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 17:51:34 +0100
Message-ID: <874kkx5zl5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 7, 2020 at 8:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Wait, what? This is a regression that *breaks people's programs* on
>> >> compiler versions that are still very much in the wild! I mean, fine =
if
>> >> you don't want to support new features on such files, but then surely=
 we
>> >> can at least revert back to the old behaviour?
>> >
>> > Those folks that care about compiling with old llvm would have to stick
>> > to whatever loader they have instead of using libbpf.
>> > It's not a backward compatibility breakage.
>>
>> What? It's a change in libbpf that breaks loading of existing BPF object
>> files that were working (with libbpf) before. If that's not a backward
>> compatibility break then that term has lost all meaning.
>
> The user space library is not a kernel.
> The library will change its interface. It will remove functions, features=
, etc.
> That's what .map is for.

Right, OK, so how do I use .map to get the old behaviour here? That's
all I'm asking for, really...

-Toke

