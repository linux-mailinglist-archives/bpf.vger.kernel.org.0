Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A2304CCA
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbhAZWzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405696AbhAZUyO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 15:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611694368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNmYQghzyEo5Nu0f80VNhQIBJIqh9/mSmZbgpxpbU6s=;
        b=Fdb4m4AbzOV+iLluL+lCqgEo/eTLtFO+WWO7Qb5cWXwGdAXIDi81KWSnloFfTn/+fIvAJp
        DtdsVGnuJGF37JCDl6zHe1Nw4clYjNvCPDI+N1CxfyNkuGFw/qOgtoC4LFhvcoz7SVO9/N
        1h9VAPmmax2eN9MDtyYhpj/iDPK7AII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-sboSZlTcOw63awkb_eqR8Q-1; Tue, 26 Jan 2021 15:52:43 -0500
X-MC-Unique: sboSZlTcOw63awkb_eqR8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D899A393AE;
        Tue, 26 Jan 2021 20:52:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.149])
        by smtp.corp.redhat.com (Postfix) with SMTP id 248FA10013C0;
        Tue, 26 Jan 2021 20:52:36 +0000 (UTC)
Date:   Tue, 26 Jan 2021 21:52:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
Message-ID: <20210126205236.GD120879@krava>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
 <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
 <20210114200120.GF1416940@krava>
 <d90fd73f-b9a6-c436-f8ae-0833ce3926ef@fb.com>
 <20210114220234.GA1456269@krava>
 <5043cef5-eda7-4373-dcb5-546f6192e1a9@fb.com>
 <CAADnVQLkM7+1+wzg=s8+zdKwYnmBRgvVK7K-qivu_a9mvaK7Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLkM7+1+wzg=s8+zdKwYnmBRgvVK7K-qivu_a9mvaK7Yg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 07:47:20PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 14, 2021 at 3:44 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 1/14/21 2:02 PM, Jiri Olsa wrote:
> > > On Thu, Jan 14, 2021 at 01:05:33PM -0800, Yonghong Song wrote:
> > >>
> > >>
> > >> On 1/14/21 12:01 PM, Jiri Olsa wrote:
> > >>> On Thu, Jan 14, 2021 at 10:56:33AM -0800, Yonghong Song wrote:
> > >>>>
> > >>>>
> > >>>> On 1/14/21 5:40 AM, Jiri Olsa wrote:
> > >>>>> It's possible to have other build id types (other than default SHA1).
> > >>>>> Currently there's also ld support for MD5 build id.
> > >>>>
> > >>>> Currently, bpf build_id based stackmap does not returns the size of
> > >>>> the build_id. Did you see an issue here? I guess user space can check
> > >>>> the length of non-zero bits of the build id to decide what kind of
> > >>>> type it is, right?
> > >>>
> > >>> you can have zero bytes in the build id hash, so you need to get the size
> > >>>
> > >>> I never saw MD5 being used in practise just SHA1, but we added the
> > >>> size to be complete and make sure we'll fit with build id, because
> > >>> there's only limited space in mmap2 event
> > >>
> > >> I am asking to check whether we should extend uapi struct
> > >> bpf_stack_build_id to include build_id_size as well. I guess
> > >> we can delay this until a real use case.
> > >
> > > right, we can try make some MD5 build id binaries and check if it
> > > explodes with some bcc tools, but I don't expect that.. I'll try
> > > to find some time for that
> >
> > Thanks. We may have issues on bcc side. For build_id collected in
> > kernel, bcc always generates a length-20 string. But for user
> > binaries, the build_id string length is equal to actual size of
> > the build_id. They may not match (MD5 length is 16).
> > The fix is probably to append '0's (up to length 20) for user
> > binary build_id's.
> >
> > I guess MD5 is very seldom used. I will wait if you can reproduce
> > the issue and then we might fix it.
> 
> Indeed.
> Jiri, please check whether md5 is really an issue.
> Sounds like we have to do something on the kernel side.
> Hopefully zero padding will be enough.
> I would prefer to avoid extending uapi struct to cover rare case.

build_id_parse is already doing the zero padding, so we are ok

I tried several bcc tools over perf bench with md5 buildid and
the results looked ok

jirka

