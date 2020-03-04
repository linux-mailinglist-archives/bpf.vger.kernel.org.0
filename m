Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31494178D91
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDJhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 04:37:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbgCDJhf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583314654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IrcE3YXDvxtZ3La+d/Q/pPChnMHlDDNnxDU+QIM4DE=;
        b=bvW/ALnLqZ6L/ZC8dnsnz/X7zrddzNKfeOshJvjoz8xKSrtFaqR6SJqYOhyEVmZc0JTyw4
        NxuLhBiAyf9bdNEg1lzk5XUSZwNioetgGDRRp6bDVQs+FxWUzYg8QrtLZvCbia2DIbqc5P
        oS2XnnMUY3nLlyHDtc+/pUyqWwr3AJo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-4aJ4KC-hOMKtSTpEzjio8g-1; Wed, 04 Mar 2020 04:37:31 -0500
X-MC-Unique: 4aJ4KC-hOMKtSTpEzjio8g-1
Received: by mail-wr1-f72.google.com with SMTP id q18so615963wrw.5
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 01:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0IrcE3YXDvxtZ3La+d/Q/pPChnMHlDDNnxDU+QIM4DE=;
        b=JmDrhZ1kd8JJAcYAV+2vQ8K+FkaKULSjHqhtmYtBnjtXxpYkX6GgBV2if4bt2Upelr
         Qwfq5/u/w4DdGTxiJNbFhvLwEJHmg8iNNJcwfCCGie8tKVz3ANiO0mLBGqa1v+ZHOziA
         HHkYLEVjZKdxEI2GLOgPVUxtkopjV/+oPM3zEXuyUmcGdKVTwO2kout3IoU+f2K7IX9q
         BFb0j0pDzV18wydfiqSP9L8ZEBJPbCEHWpDCY8nZZ+kyjCSlSf8N1a7D/TXxDU7kK/NI
         GAxMA/PLJmi/Q5FK5SwFjPPaLMDpVgTuZOvFl75H5N5WRMkOO291HAGWEk9kTjgCnRCj
         plsA==
X-Gm-Message-State: ANhLgQ3tJ7xg3tXSx4ZUvLRJGUlAlLPnltWAB6IbSkIp01aKKnFLFVXQ
        r7hvaYRSrew6k76auGeD4rvDs0kN3+zMSk11TFU5e/oWTRRp06hUfLoQhbPp2pXUOrX5g21z9fs
        HjkksOCDzSRsR
X-Received: by 2002:adf:f588:: with SMTP id f8mr3343990wro.188.1583314650338;
        Wed, 04 Mar 2020 01:37:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuCeDL3/OPOWGkyWWV5EFXJuUOMBPOiO8AVCfBsPGnKuTu2rCdFgvUy0flCNFO0RIrzVHkoNA==
X-Received: by 2002:adf:f588:: with SMTP id f8mr3343974wro.188.1583314650144;
        Wed, 04 Mar 2020 01:37:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k66sm644113wmf.0.2020.03.04.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:37:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C635A180331; Wed,  4 Mar 2020 10:37:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: switch BPF UAPI #define constants used from BPF program side to enums
In-Reply-To: <CAEf4BzZWXRX_TrFSPb=ORcfun8B+GdGOAF6C29B-3xB=NaJO7A@mail.gmail.com>
References: <20200303003233.3496043-1-andriin@fb.com> <20200303003233.3496043-2-andriin@fb.com> <fb80ddac-d104-d0b7-8bed-694d20b62d61@iogearbox.net> <CAEf4BzZWXRX_TrFSPb=ORcfun8B+GdGOAF6C29B-3xB=NaJO7A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 Mar 2020 10:37:27 +0100
Message-ID: <87blpc4g14.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Mar 3, 2020 at 3:01 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 3/3/20 1:32 AM, Andrii Nakryiko wrote:
>> > Switch BPF UAPI constants, previously defined as #define macro, to anonymous
>> > enum values. This preserves constants values and behavior in expressions, but
>> > has added advantaged of being captured as part of DWARF and, subsequently, BTF
>> > type info. Which, in turn, greatly improves usefulness of generated vmlinux.h
>> > for BPF applications, as it will not require BPF users to copy/paste various
>> > flags and constants, which are frequently used with BPF helpers. Only those
>> > constants that are used/useful from BPF program side are converted.
>> >
>> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>
>> Just thinking out loud, is there some way this could be resolved generically
>> either from compiler side or via additional tooling where this ends up as BTF
>> data and thus inside vmlinux.h as anon enum eventually? bpf.h is one single
>> header and worst case libbpf could also ship a copy of it (?), but what about
>> all the other things one would need to redefine e.g. for tracing? Small example
>> that comes to mind are all these TASK_* defines in sched.h etc, and there's
>> probably dozens of other similar stuff needed too depending on the particular
>> case; would be nice to have some generic catch-all, hmm.
>
> Enum convertion seems to be the simplest and cleanest way,
> unfortunately (as far as I know). DWARF has some extensions capturing
> #defines, but values are strings (and need to be parsed, which is pain
> already for "1 << 1ULL"), and it's some obscure extension, not a
> standard thing. I agree would be nice not to have and change all UAPI
> headers for this, but I'm not aware of the solution like that.

Since this is a UAPI header, are we sure that no userspace programs are
using these defines in #ifdefs or something like that?

-Toke

