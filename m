Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985A313CFD2
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOWJ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 17:09:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49596 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgAOWJu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jan 2020 17:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=SPB3tdMtc5YmF4MxA6T6G4iFxup9RzG9mcNhluhqP4A4jfvLt8aM4muaIsMdthrpr5Jn3E
        hlIuLwtHku8qwEhAhiEOL7PnhM0/EkwkivpfUr1sSjaQSMIC9SYx32nmnDRGXuSShTTlrf
        LiZFSOMCWMjtb/53eYKhBhf9MZRp/98=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-l0l-xIpmOyGkjcJJbMtexw-1; Wed, 15 Jan 2020 17:09:48 -0500
X-MC-Unique: l0l-xIpmOyGkjcJJbMtexw-1
Received: by mail-lj1-f199.google.com with SMTP id o9so4472734ljc.6
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 14:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=KsOA5JJnrNoBv6fvW0w1nrwS9v0itECDn+Qh2Gov4gRvcTfLs5w/qIQNyg4lVOEcYk
         lMundOeZHFzVTMjKGijhNvpl8PTvCA/NHsb6qSikBJFCOjF8avUHErgyvUZ+tyLybKO1
         qKK9JxPzq2sOp0cXfnynfbmc52AqsBwRr6msRXGxCWVAB8pZvoC3W2Z2ZX3rkb5sTUZV
         Tq6MrYg1+JJeG6aTOGBO5BbKHFx6HlxyP28oJCZ1B7OBuXPVoqOkLyoN/V28cLyJnuxA
         zONE3nds9kgwHGW7wrTrlGJcag0Bh6gGOm5rIjk2v2vYVpXkknvQQLQ4NXFZJxkNd2H0
         gGUg==
X-Gm-Message-State: APjAAAVI28Gsocacn3tIQ5Uf57uNwCut3jBqE1iY/6Y0iSnBJKgv7HyX
        3Lm29SV+qwWvHKool9Zzq3JmPyToMxCSof2zW2szaAaZZJ0kpP8buoQKkUTQ81iaJR3mlfXk+5M
        7TArXeb27GXiK
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309080ljh.187.1579126186246;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl9usYNPHfWl85TIz6drR9BBM82kZH5HkqsoxTXL5G4+0RjNxZ3iAMQC2ii0NABa1NGrcMXg==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309055ljh.187.1579126186024;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r20sm9450459lfi.91.2020.01.15.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:09:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 970D01804D6; Wed, 15 Jan 2020 23:09:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
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
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v2 00/10] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:09:44 +0100
Message-ID: <87r200tlqv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jan 15, 2020 at 03:12:48PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h=
 are
>> taken from selftests dir") broke compilation against libbpf if it is ins=
talled
>> on the system, and $INCLUDEDIR/bpf is not in the include path.
>>=20
>> Since having the bpf/ subdir of $INCLUDEDIR in the include path has neve=
r been a
>> requirement for building against libbpf before, this needs to be fixed. =
One
>> option is to just revert the offending commit and figure out a different=
 way to
>> achieve what it aims for. However, this series takes a different approac=
h:
>> Changing all in-tree users of libbpf to consistently use a bpf/ prefix in
>> #include directives for header files from libbpf.
>
> I don't think such approach will work in all cases.
> Consider the user installing libbpf headers into /home/somebody/include/b=
pf/,
> passing that path to -I and trying to build bpf progs
> that do #include "bpf_helpers.h"...
> In the current shape of libbpf everything will compile fine,
> but after patch 8 of this series the compiler will not find bpf/bpf_helpe=
r_defs.h.
> So I think we have no choice, but to revert that part of Andrii's patch.
> Note that doing #include "" for additional library headers is a common pr=
actice.
> There was nothing wrong about #include "bpf_helper_defs.h" in bpf_helpers=
.h.

OK, I'll take another look at that bit and see if I can get it to work
with #include "bpf_helper_defs.h" and still function with the read-only
tree (and avoid stale headers).

-Toke

