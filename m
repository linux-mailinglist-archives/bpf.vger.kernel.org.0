Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B60220D7F
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGOM4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 08:56:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731313AbgGOM4l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 08:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594817800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyd1Oecq7g1QXX9O1jumuiUNfYulTKddz2EK0Kq40kI=;
        b=SwpvpRFvIwRIsMvushWBhBISWoIzunz5DnpHKPeYMX2sBawCqQbn4dx1ObiYH0ynMn5Uz6
        MihlfF4Rgclp+tP4OPIc4i+9akzFfdKnES1y/8vRtHu8gfgCCF7EyOpF8exyDhVNu+x2rr
        kU75TbSUos5q7sQZZ8oD9HRCYNLG+N8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-oB025uuZPRC6tnCUPcGrow-1; Wed, 15 Jul 2020 08:56:39 -0400
X-MC-Unique: oB025uuZPRC6tnCUPcGrow-1
Received: by mail-qk1-f199.google.com with SMTP id i6so1382946qkn.22
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 05:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Tyd1Oecq7g1QXX9O1jumuiUNfYulTKddz2EK0Kq40kI=;
        b=lgWv/T6AF3d8/a3u8WOoQeoVxMUDyakUhQNADxWk40sKFvz9d71M/kTUMG4cipjTyR
         7cGKjroRdCAYR68KREonxh1ofNk+42EBA2J3nbcZIdLDrgl4aXHuJy7RZwf3tluPFCiu
         u+66E714yOi/0OviP02thTX9M1K6j3tsMlHUFgI2HF6Rnsmv7jfM/HvkEO4YFvqeKPYz
         eAcw35tZiemA3fXUvuVsMp7ZrKMjlDSEdXUDeHapv34jTP6BSTOM4XlOO/Uqmmy4VNxW
         tFSFPWLNnobZDfRVDTkr9k7jQKk/4G2vwhCp3DYQLe/wH4oPIOMKn0qhGYGXracrXimi
         mbOA==
X-Gm-Message-State: AOAM530/KDMfRBgLZHC5GhFwcLQLc6OOY/1R5rlg3OMN/lcZsYzOK2e7
        tyonPs9ZRWaie2MiiB+UFcV09Yiw+pIGfuni79pi7rqNJPraGUwQW+s69lj8z8hNwcpgTBHjcve
        1foFxaHEKSwDW
X-Received: by 2002:a05:620a:50:: with SMTP id t16mr9959755qkt.82.1594817798858;
        Wed, 15 Jul 2020 05:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+A3C8RwmR0b6EoC8M456I6cc7OaR/Q+zLW6AypTd3nNdtFt5RUnmdON6og7oyAeS3BHZRoQ==
X-Received: by 2002:a05:620a:50:: with SMTP id t16mr9959728qkt.82.1594817798605;
        Wed, 15 Jul 2020 05:56:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b10sm2070996qkh.124.2020.07.15.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:56:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 16E3C1804F0; Wed, 15 Jul 2020 14:56:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF logging infrastructure. Was: [PATCH bpf-next 4/6] tools: add new members to bpf_attr.raw_tracepoint in bpf.h
In-Reply-To: <20200714231133.ap5qnalf6moptvfk@ast-mbp.dhcp.thefacebook.com>
References: <159467113970.370286.17656404860101110795.stgit@toke.dk> <159467114405.370286.1690821122507970067.stgit@toke.dk> <CAEf4BzZ_-vXP_3hSEjuceW10VX_H+EeuXMiV=_meBPZn7izK8A@mail.gmail.com> <87r1tegusj.fsf@toke.dk> <CAEf4Bzbu1wnwWFOWYA3e6KFeSmfg8oANPWD9LsUMRy2E_zrQ0w@mail.gmail.com> <87pn8xg6x7.fsf@toke.dk> <CAEf4BzYAoetyfyofTX45RQjtz3M-c9=YNeH1uRDbYgK4Ae0TwA@mail.gmail.com> <87d04xg2p4.fsf@toke.dk> <20200714231133.ap5qnalf6moptvfk@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jul 2020 14:56:36 +0200
Message-ID: <874kq9ey2j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jul 15, 2020 at 12:19:03AM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>> >> However, assuming it *is* possible, my larger point was that we
>> >> shouldn't add just a 'logging struct', but rather a 'common options
>> >> struct' which can be extended further as needed. And if it is *not*
>> >> possible to add new arguments to a syscall like you're proposing, my
>> >> suggestion above would be a different way to achieve basically the sa=
me
>> >> (at the cost of having to specify the maximum reserved space in advan=
ce).
>> >>
>> >
>> > yeah-yeah, I agree, it's less a "logging attr", more of "common attr
>> > across all commands".
>>=20
>> Right, great. I think we are broadly in agreement with where we want to
>> go with this, actually :)
>
> I really don't like 'common attr across all commands'.
> Both of you are talking as libbpf developers who occasionally need to
> add printk-s to the kernel. That is not an excuse to bloat api that will =
be
> useful to two people.

What? No, this is about making error messages comprehensible to people
who *can't* just go around adding printks. "Guess the source of the
EINVAL" is a really bad user experience!

> The only reason log_buf sort-of make sense in raw_tp_open is because
> btf comparison is moved from prog_load into raw_tp_open.
> Miscompare of (prog_fd1, btf_id1) vs (prog_fd2, btf_id2) can be easily so=
lved
> by libbpf with as nice and as human friendly message libbpf can do.

So userspace is supposed to replicate all the checks done by the kernel
because we can't be bothered to add proper error messages? Really?

> I'm not convinced yet that it's a kernel job to print it nicely. It certa=
inly can,
> but it's quite a bit different from two existing bpf commands where log_b=
uf is used:
> PROG_LOAD and BTF_LOAD. In these two cases the kernel verifies the program
> and the BTF. raw_tp_open is different, since the kernel needs to compare
> that function signatures (prog_fd1, btf_id1) and (prog_fd2, btf_id2) are
> exactly the same. The kernel can indicate that with single specific errno=
 and
> libbpf can print human friendly function signatures via btf_dump infra for
> humans to see.
> So I really don't see why log_buf is such a necessity for raw_tp_open.

I'll drop them from raw_tp_open for this series, but I still think they
should be added globally (or something like it). Returning a
user-friendly error message should be the absolute minimum we do. Just
like extack does for netlink.

-Toke

