Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279B25AF76
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBPCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 11:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgIBPB5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599058915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keoNDmubL3AbDRcDLPmBUvKW8SXAG0GWlQuJX+1BRJE=;
        b=ajnmI1v0wZqpaJMr0A29qvNjLUmX25XBBNhU0c4tWX0RS4OiFH0DQqkPb2ATd/E1G3Laj2
        qo03ypZcdcY8OUBk2YJqccHYN7Y3DINQRALzHTznc2DYJhH5Tlo4bffjpbTEXIPZze9qbU
        NMx4wKpgMTVFHEDZ891sCH3TTS6g8Zo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-6VmWdIuINzabPmudgp-VYA-1; Wed, 02 Sep 2020 11:01:42 -0400
X-MC-Unique: 6VmWdIuINzabPmudgp-VYA-1
Received: by mail-wm1-f69.google.com with SMTP id s24so1817913wmh.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 08:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=keoNDmubL3AbDRcDLPmBUvKW8SXAG0GWlQuJX+1BRJE=;
        b=OaKRFb3uq5+IEZjxmKE4kC4qQmmEeWNagfdpoogKYDBSPUfGwLT7xI5Kg5crXGOkKq
         vTkqWVYLAJNYvsPTnwcVscV6IXGHMOopvDwhtENKW1WFYzyAJ0Pd7QoelAVH0zVEFa0Q
         a6KsXXeK2s7KzFr++AkOyYgTzRhvnTzt5t+uCZBfSOYWBVOHHE0REIohbEdnqLOlBgLi
         bGbxoK+wKn37I6AtP5gljnRqAdTdxyae2Ms6dOD5XFbrwPQFUXeqMX8/duD/9X/Bl8Vk
         2QfRaaIrjlh7xFqCEfuc7ESSa4n0/eaakVy4uOhqAy7aFIJIxhCacc4KOdyB5mMRSsMC
         /GRQ==
X-Gm-Message-State: AOAM5319c0l3wSjfqeBjQyuGQ6KMlX7lOeTXifMcd91azvfMStfc52x6
        cp6RsUaBavyoIxpVSeotU68O48hnw4iSBiJKBDQkWNBn+hrQOSC1SL95EEDwe/I2omRnnvS0dgi
        LY3fjDod5/17k
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr4270450wrr.149.1599058900953;
        Wed, 02 Sep 2020 08:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHMs5iNzm498ahFLNHr/Oyo9N4Rvqxl6WMppGRjBEh+5rbqoUNE2hRT4heBmiWJr9wG/nw5w==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr4270424wrr.149.1599058900699;
        Wed, 02 Sep 2020 08:01:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y1sm7823547wru.87.2020.09.02.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:01:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7D923182009; Wed,  2 Sep 2020 17:01:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
In-Reply-To: <20200902142158.hp26mv7dxphzyhun@ast-mbp.dhcp.thefacebook.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
 <465da51a-793e-5ea0-85dc-56ab4f36ae34@fb.com> <87d034ikve.fsf@toke.dk>
 <20200902142158.hp26mv7dxphzyhun@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Sep 2020 17:01:39 +0200
Message-ID: <871rjki5nw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Sep 02, 2020 at 11:33:09AM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> Yonghong Song <yhs@fb.com> writes:
>>=20
>> > On 9/1/20 1:07 PM, Andrii Nakryiko wrote:
>> >> On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
>> >>>
>> >>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm =
12.
>> >>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
>> >>=20
>> >> Does this mean that some perfectly working BPF programs will now fail
>> >> to verify on older kernels, if compiled with llvm 11 or llvm 12? If
>> >
>> > Right.
>> >
>> >> yes, is there something that one can do to prevent Clang from using
>> >> xor in such situations?
>> >
>> > The xor is generated by the combination of llvm simplifyCFG and=20
>> > instrCombine phase.
>> >
>> > The following is a hack to prevent compiler from generating xor's.
>>=20
>> Wait, so this means that we can no longer tell people to just use the
>> newest LLVM version - now we have to keep track of a minimum *and*
>> maximum LLVM version for each kernel version?
>
> No. The only way is forward. Everyone has to upgrade their llvm periodica=
lly.

Right, great! But surely that implies that a regression such as that
described here, where a new LLVM version turns a previously-valid
program into one that no longer verifies is a bug, no?

>> Could we maybe try to not *keep* making it harder for people to use BPF?=
 :/
>
> Whom do you mean by "we" ?

I mean "we as a community who would like BPF to be as useful as possible
to as many people as possible". Usability is a big part of this.

>> As for the patch, sure, make the verifier smarter, but I also feel like
>> LLVM should be fixed to not suddenly emit such xor instructions...
>
> I don't think there is anything to be "fixed". It's not a bug form
> llvm developers point of view. At least I suspect that's the response
> you will get if you post the same sentence on llvm-dev mailing list.
> If you care to help, please bisect which llvm commit introduced this
> change. May be author (whoever that was) will have ideas how to
> pessimize it specifically for bpf backend. But I suspect they will
> refuse to do so. The discussion about partial disable of optimizations
> was brought up several times. tldr optimizations cannot be disabled
> effectively. Pretty much all of them may cause trouble for the
> verifier and all of them are often necessary for the verifier as well.
> Please read this thread:
> http://clang-developers.42468.n3.nabble.com/Disable-certain-llvm-optimiza=
tions-at-clang-frontend-tp4068601.html

I am not enough of a compiler person to get the nuances of that
discussion, but it seems that the last message[0] by Y Song seems to
imply that you guys do want to fix such issues in LLVM, just not by
disabling the optimisation, but at a later stage in the processing
pipeline?

-Toke

[0] http://lists.llvm.org/pipermail/cfe-dev/2020-June/066015.html

