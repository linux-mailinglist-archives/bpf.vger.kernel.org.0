Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33B1F92A0
	for <lists+bpf@lfdr.de>; Mon, 15 Jun 2020 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFOJEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jun 2020 05:04:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53046 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728411AbgFOJEm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Jun 2020 05:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592211881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqCxKohGvLbDOAcYvRzfZ70rZCgIvTAgDpyXvxo9QZw=;
        b=Qlk2SwuYJP++GBzymzqRPg6oV/vIwnCSPsTpT2RzsbKO/qx80ZlxXrMAeMdSMY3ga3S96Z
        tIAlSB1aEihqCFtrF9BvLaUzVkqaOE2YhSWhpIu6blcnyyfbetIB3rwb2OxZqeVsJljT9X
        Tk+f0kybCccmgHkpEqekbOnJ4uL+z4c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-m0Iv62gKNQKbCAeY85jZ2w-1; Mon, 15 Jun 2020 05:04:39 -0400
X-MC-Unique: m0Iv62gKNQKbCAeY85jZ2w-1
Received: by mail-ed1-f69.google.com with SMTP id dn27so4685724edb.15
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2020 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eqCxKohGvLbDOAcYvRzfZ70rZCgIvTAgDpyXvxo9QZw=;
        b=jllMJ40Y44bxLbCpNipjQMpYguxACVFmldBQ9snT0Mf/XiKcGl51gvZlg2MaPUKcvG
         YS0WrL0eXWpAITTun5hD/MXYTvaIjm6vFOk5Q+Ai+eBzgPm5isXZBy1fUVdCVsEqsOCp
         o7VRyx+kwxcMLwCgKJnAmcFdKanZ1vNzKwSHDP3tZd1pjAfkgSrpsmugFcQWIW2sxPpt
         PRVc8sEVpg/NvfWZHtQxI0gNZHV8yOqPyyvSnZLI7UhdxK6C+ThG9S57qrZx1dUi9DZF
         iD1v09pR1irA4ZkFXT+I16ozY9QUJyMFd0G1UoEnMFZbGiaqFTcmYANNgkLJQBL/o+YD
         Z9LA==
X-Gm-Message-State: AOAM531wakFsF4B2qKCDvoNhVahc1U+WFJNHg2fcc/8vjmCADWYO/qf9
        W8wb5k9+QW/OXfIS72Gw2XUWHFIkqt3xBktnB3Jo80FYNLa+kPMHY+u752l6OQmkJEK77abIcRP
        OULhQALahMkz/
X-Received: by 2002:a50:f094:: with SMTP id v20mr22603475edl.77.1592211878375;
        Mon, 15 Jun 2020 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQV9d8O1teV5U813ms9N4ToB2nzLDvlhioQHU+f4HBdn9vWHWBNEJsAmukYldRqTxWeB+HPA==
X-Received: by 2002:a50:f094:: with SMTP id v20mr22603450edl.77.1592211878095;
        Mon, 15 Jun 2020 02:04:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z10sm8653487ejb.9.2020.06.15.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:04:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9883D1814F7; Mon, 15 Jun 2020 11:04:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [RFC PATCH bpf-next 8/8] tools/bpftool: show PIDs with FDs open against BPF map/prog/link/btf
In-Reply-To: <20200613221419.GB7488@kernel.org>
References: <20200612223150.1177182-1-andriin@fb.com> <20200612223150.1177182-9-andriin@fb.com> <20200613034507.wjhd4z6dsda3pz7c@ast-mbp> <CAEf4BzaHVRxkiDbTGashiuakXFBRYvDsQmJ0O08xFijKXiAwSg@mail.gmail.com> <20200613221419.GB7488@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Jun 2020 11:04:34 +0200
Message-ID: <87pna01yzh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Fri, Jun 12, 2020 at 10:57:59PM -0700, Andrii Nakryiko escreveu:
>> On Fri, Jun 12, 2020 at 8:45 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Fri, Jun 12, 2020 at 03:31:50PM -0700, Andrii Nakryiko wrote:
>> > > Add bpf_iter-based way to find all the processes that hold open FDs against
>> > > BPF object (map, prog, link, btf). Add new flag (-o, for "ownership", given
>> > > -p is already taken) to trigger collection and output of these PIDs.
>> > >
>> > > Sample output for each of 4 BPF objects:
>> > >
>> > > $ sudo ./bpftool -o prog show
>> > > 1992: cgroup_skb  name egress_alt  tag 9ad187367cf2b9e8  gpl
>> > >         loaded_at 2020-06-12T14:18:10-0700  uid 0
>> > >         xlated 48B  jited 59B  memlock 4096B  map_ids 2074
>> > >         btf_id 460
>> > >         pids: 913709,913732,913733,913734
>> > > 2062: cgroup_device  tag 8c42dee26e8cd4c2  gpl
>> > >         loaded_at 2020-06-12T14:37:52-0700  uid 0
>> > >         xlated 648B  jited 409B  memlock 4096B
>> > >         pids: 1
>> > >
>> > > $ sudo ./bpftool -o map show
>> > > 2074: array  name test_cgr.bss  flags 0x400
>> > >         key 4B  value 8B  max_entries 1  memlock 8192B
>> > >         btf_id 460
>> > >         pids: 913709,913732,913733,913734
>> > >
>> > > $ sudo ./bpftool -o link show
>> > > 82: cgroup  prog 1992
>> > >         cgroup_id 0  attach_type egress
>> > >         pids: 913709,913732,913733,913734
>> > > 86: cgroup  prog 1992
>> > >         cgroup_id 0  attach_type egress
>> > >         pids: 913709,913732,913733,913734
>> >
>> > This is awesome.
>
> Indeed.
>  
>> Thanks.
>> 
>> >
>> > Why extra flag though? I think it's so useful that everyone would want to see
>
> Agreed.
>  
>> No good reason apart from "being safe by default". If turned on by
>> default, bpftool would need to probe for bpf_iter support first. I can
>> add probing and do this by default.
>
> I think this is the way to go.

+1

And also +1 on the awesomeness of this feature! :)

-Toke

