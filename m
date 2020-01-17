Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7D14071E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAQJ6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 04:58:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgAQJ6r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jan 2020 04:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579255126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uf1keSD3DOZ8jh4mCSz+0fhQb4Z+vPKdygjWjY+hlbM=;
        b=f2CGdxgKOyVjWpy69GKk/kAVWGo9xtnyXyFTtCZoXQnmVlG2kQbkeOIa+jLC2Ozk9b8m7t
        WoWYiRQltOhNSXhKKV1fkpKft2bcDEiMSrvcA00PE1vAnakLQjM5JT0Y72qJB5x62dgCEH
        +jf+ZHI2lXsNdCN5dfMvFKaAYjSe8Qo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-bNwekWqMPD-fdrsEAFKCzA-1; Fri, 17 Jan 2020 04:58:44 -0500
X-MC-Unique: bNwekWqMPD-fdrsEAFKCzA-1
Received: by mail-lj1-f200.google.com with SMTP id r14so6023564ljc.18
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 01:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Uf1keSD3DOZ8jh4mCSz+0fhQb4Z+vPKdygjWjY+hlbM=;
        b=J160XnFnX5pJOZLxYBGQtXb+s/ze1C1i4hx9yJT8baaIl/zQ2RybwWjJ9sTzpTdL1n
         ISMzqcDSsIXvmm9kcm61FcMRDmyHjD5W87I5zr3Q9GrXFCri1bJ2FKl4o9LxXNtvx/GM
         qFQn7pL+jQ2Y1Die9FB/KbxhMSv3XJlLJLX1GmSx+Ugt2/dU6vnK+bSIOt2mpsOC+8Ad
         mzjRkFadLBhMsStB9OhZ4F5JixXdr7ZA1huHB8m2cdxaFhaP5hzcULgD3FgB1igFuA4e
         A5WIZrSKyLzmak+go4yvgpqmTr78Tl6O7U1cxlrpfEk1L6rCB2hqxi+pEKwjjvj1N3kj
         j9MA==
X-Gm-Message-State: APjAAAUGoqJBPyeuL/p+uPm2b6D1gM/r1b0N7Tl7kVzjzG/smZDOH0sQ
        rPeRucqnywPJzX8erdlI5sCX/nFS4MsXNJlAIkcr0OOHegzhiwsHost4vJW2bNZugYIPjns/Tzt
        GPuzfASoeqsuq
X-Received: by 2002:ac2:4849:: with SMTP id 9mr4975724lfy.11.1579255123123;
        Fri, 17 Jan 2020 01:58:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx3OTlP+sKcKqC8lWpUkR48Xy7KHR8XB1tnfvUp3Gadttkq8Vpe8cxhtUqaWxJHiUphB7sig==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr4975702lfy.11.1579255122857;
        Fri, 17 Jan 2020 01:58:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r21sm12164399ljn.64.2020.01.17.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:58:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 341A91804D6; Fri, 17 Jan 2020 10:58:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next v3 00/11] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <20200117095721.0030f414@carbon>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <20200117041431.h7vvc32fungenyhg@ast-mbp.dhcp.thefacebook.com> <20200117095721.0030f414@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:58:41 +0100
Message-ID: <87lfq6qu9a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Thu, 16 Jan 2020 20:14:32 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> On Thu, Jan 16, 2020 at 02:22:11PM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs=
.h are
>> > taken from selftests dir") broke compilation against libbpf if it is i=
nstalled
>> > on the system, and $INCLUDEDIR/bpf is not in the include path.
>> >=20
>> > Since having the bpf/ subdir of $INCLUDEDIR in the include path has ne=
ver been a
>> > requirement for building against libbpf before, this needs to be fixed=
. One
>> > option is to just revert the offending commit and figure out a differe=
nt way to
>> > achieve what it aims for.=20=20=20
>>=20
>> The offending commit has been in the tree for a week. So I applied Andri=
i's
>> revert of that change. It reintroduced the build dependency issue, but w=
e lived
>> with it for long time, so we can take time to fix it cleanly.
>> I suggest to focus on that build dependency first.
>>=20
>> > However, this series takes a different approach:
>> > Changing all in-tree users of libbpf to consistently use a bpf/ prefix=
 in
>> > #include directives for header files from libbpf.=20=20
>>=20
>> I'm not sure it's a good idea. It feels nice, but think of a message we'=
re
>> sending to everyone. We will get spamed with question: does bpf community
>> require all libbpf users to use bpf/ prefix ? What should be our answer?
>
> The answer should be: Yes. When libbpf install the header files the are
> installed under bpf/ prefix.  It is very confusing that samples and
> selftests can include libbpf.h without this prefix. Even worse
> including "bpf.h" pickup the libbpf version bpf/bpf.h, which have
> caused confusion.  The only reason for the direct "libbpf.h" include is
> historical, as there used-to-be a local file for that.

Agreed. Also, we are already telling people what the right include path
is in at least two ways - and currently they are incompatible:

- The pkg-config file included with libbpf has a notion of include path;
  which does *not* include the bpf/ subdirectory.

- The skeleton generator puts an '#include <libbpf.h>' line into the
  generated files.

With this series we'll at least be consistent.

>> Require or recommend? If require.. what for? It works as-is. If recommen=
d then
>> why suddenly we're changing all files in selftests and samples?
>> There is no good answer here. I think we should leave the things as-is.
>
> I strongly believe we should correct this.  It doesn't make sense that
> someone copying out a sample or selftests, into a git-submodule libbpf
> (or distro installed libbpf-devel) have to understand that they have to
> update the include path for all the libbpf header files.

Yeah, I think being clear and explicit about what is the recommended way
to include libbpf is strictly an improvement. And making it possible to
move example programs seamlessly in and out of the kernel tree will only
make things easier for people.

I'll rebase and respin this series on top of the revert (and fix
Andrii's comments).

-Toke

