Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7C43B4F5
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJZPAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 11:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231178AbhJZPAV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 11:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635260276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnR4c+Nt/7GVr9rRgsl6rPDDaxcJiXfn96FJFlPUEJM=;
        b=a+MAyfkq5RBZIkUCfrTa0ZTBHIiwM1QRAXYi3DkfDgU7jRvpQuHnGk+kqZJ//+k6aDdqtE
        gmzCcM3CWw7CBpE82Fu6UljEHABfyJenWxnK/O7CpAOp+wvJCJ/u0/Il1DvG3F/RYVKn5x
        yGjOxrwU8/MXva8KD594EO6FUwNDvoY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-rNXRywQCNqq7lFyi3aLr8A-1; Tue, 26 Oct 2021 10:57:55 -0400
X-MC-Unique: rNXRywQCNqq7lFyi3aLr8A-1
Received: by mail-ed1-f70.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso2445593edd.1
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 07:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bnR4c+Nt/7GVr9rRgsl6rPDDaxcJiXfn96FJFlPUEJM=;
        b=UphTcITc/R81uAAH8vTeJ2tHoEYy7wdGzWfNnUqDlBH1Ul/i/kf/pH4x0rm/ECLxxV
         GVrCU4q2FxVrSZ0+nBIWkhXKwnN987UCF6D1wmOzXv0cdcafyDhv2NETYryBGQNdyT+A
         j2ntXPu9RCbfn8rCs/GQyWaWU5izRbF/MDrVdmSgPx+z9xsIVYMw7y4KcM1ebrnEuKJE
         27n6p+PTBWX1Zh354QAQ5L4UPRNI3f2QUJscR0EtVDq/c0zMO56gUs6kGG34N1GE+k3Q
         CBa+yHBOmWm5SeBWc+qly8JxJiAAD3DSEb461p73EpOs4jtkvPB7P7uTKQDsbsogS89E
         57gA==
X-Gm-Message-State: AOAM533vr1Z3LdvaWCNyKI09b2jVoke6U4KaOXwQtL5T15e+bkMj040w
        CI4Fx/q57pEn7vXJxRwugiiXw/evxOaBPTjiBNrDoj5l73QwFwzzP6MQUDz9tFG7y1BQh7CVPa3
        Z6XqW7JGCK36W
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr31624228ejc.389.1635260273648;
        Tue, 26 Oct 2021 07:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOExiF9/7HJ/tp6AE/GzXDrNk7T7DN0dMgGEtPG2IyveEht+MKrPT9jZgljdMyypg30ByR5w==
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr31624136ejc.389.1635260272847;
        Tue, 26 Oct 2021 07:57:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id eu9sm3926816ejc.14.2021.10.26.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:57:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D2E1F180262; Tue, 26 Oct 2021 16:57:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libxsk move from libbpf to libxdp
In-Reply-To: <CAJ8uoz1GP4M71E-PNScndfeTbcCG2OUg+wcoO4ZaJF5UTBiXCQ@mail.gmail.com>
References: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
 <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com>
 <87v91lay7o.fsf@toke.dk>
 <CAEf4BzZoajVwGywDipuAk7ojY9WjL2rvuk82EtCZKGU-JSZUow@mail.gmail.com>
 <CAJ8uoz1GP4M71E-PNScndfeTbcCG2OUg+wcoO4ZaJF5UTBiXCQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Oct 2021 16:57:51 +0200
Message-ID: <87sfwnal5c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Tue, Oct 26, 2021 at 6:18 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Oct 25, 2021 at 9:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>> >
>> > > On Fri, Oct 22, 2021 at 7:49 PM Andrii Nakryiko
>> > > <andrii.nakryiko@gmail.com> wrote:
>> > >>
>> > >> Hey guys,
>> > >>
>> > >> It's been a while since we chatted about libxsk move. I believe last
>> > >> time we were already almost ready to recommend libxdp for this, but
>> > >> I'd like to double-check. Can one of you please own [0], validate t=
hat
>> > >> whatever APIs are provided by libxdp are equivalent to what libbpf
>> > >> provides, and start marking xdk.h APIs as deprecated? Thanks!
>> > >
>> > > Resending since Gmail had jumped out of plain text mode again.
>> > >
>> > > No problem, I will own this. I will verify the APIs are the same then
>> > > submit a patch marking the ones in libbpf's xsk.h as deprecated.
>> > >
>> > > One question is what to do with the samples and the selftests for xs=
k.
>> > > They currently rely on libbpf's xsk support. Two options that I see:
>> > >
>> > > 1: Require libxdp on the system. Do not try to compile the xsk sampl=
es
>> > > and selftests if libxdp is not available so the rest of the bpf
>> > > samples and selftests are not impacted.
>> > > 2: Provide a standalone mock-up file of xsk.c and xsk.h that samples
>> > > and selftests could use.
>> > >
>> > > I prefer #1 as it is better for the long-term. #2 means I would have
>> > > to maintain that mock-up file as libxdp features are added. Sounds
>> > > like double the amount of work to me. Thoughts?
>> >
>> > I agree #1 is preferable of those two. Another option is to move the
>> > samples to the xdp-tools repo instead? Doesn't work for selftests, of
>> > course; if it's acceptable to conditionally-compile the XSK tests
>> > depending on system library availability that would be fine by me...
>>
>> Seems like the only thing that uses xsk.h is xdpxceiver.c which is
>> tested through test_xsk.sh. It's not part of test_progs and so isn't
>> run regularly by BPF CI or maintainers. It makes sense to me to move
>> such test closer to the library it's supposed to be testing (i.e.,
>> libxdp)?
>
> xdpxceiver.c tests kernel functionality, not libxdp functionality,
> though it does use libxdp (and libbpf) to make the implementation
> simpler. So it should remain here and use strategy #1. libxdp tests
> are on another level and should definitely go into the libxdp repo.
> The xsk samples in samples/bpf/, we could just stop developing/retire
> (or even remove) in the Linux repo and move them to the xdp-tools
> repo. They just show how to use the xsk.h api:s and it makes more
> sense to have them together with libxdp.

SGTM :)

-Toke

