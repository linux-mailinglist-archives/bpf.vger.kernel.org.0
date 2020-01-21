Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA39143E96
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2020 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUNuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 08:50:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56950 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729081AbgAUNuS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jan 2020 08:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579614617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSA9nedBLY+hJJ/U902gs3UmyLK6X1rNeQVNhq9BcRk=;
        b=DpBjrrCfpL3ADMet6GmkzlxC3y2FWkxNkrspbkdvVlHQl/kSKsosELnCk/gXcj64Iczrfx
        8rsqbiGkLjrsLFOcMcEX4l0MXjhBJgzCMmhaHibVEGF+K3Kwb/F7Ywj5yxfTOepQotLMVI
        eVwEOjNHo280x9GWw9J754ygDx/X/Y8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-Y71-dM3jMsqycW_Ou9d84A-1; Tue, 21 Jan 2020 08:50:16 -0500
X-MC-Unique: Y71-dM3jMsqycW_Ou9d84A-1
Received: by mail-lf1-f71.google.com with SMTP id w72so885633lff.20
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 05:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QSA9nedBLY+hJJ/U902gs3UmyLK6X1rNeQVNhq9BcRk=;
        b=rHpY6Y6gPltCzTZlxP72ikpsGwNYC/Fr3jfgqD9uqX4Pr40TCMSeEGZzsSoWOzwOX7
         GMrhRCGnS5gYk3gTz99CMnSk/QUxBdYYckxGxNYgH75yH1zlczeFltF2bf5sm5UnkPzk
         +NOJAe3Cygf9wkgTh4tw/wUNhmmqaF6rfnixgWB0spAdjbCQiWH6XfOPoqXSasSvl7kr
         UNKo48Sg3lDctp2gwTUCJP1M1y6M9Xz6r9eu0I5TuT/z1ex+cIq4XKIQdD32cFSwP6Pd
         +Zo8cNnFsbzrYm4b3AzpeELevEAQ5+KKvwU8rLx8PuxQNf43skDIEX1kzU/AHBRjb6lv
         kUdg==
X-Gm-Message-State: APjAAAUfZIL8wopwGyYcJnqmNB9+uzRO3qfqn9WRHQSmVJxrQjs6+eXD
        8Z4mXCcjKG4nxR3Xl0ybrpbTvpiReUdtD4O0RD5qGBKqJ3q3fWYuQCa4xuOknkdFZsx+nj3jHzw
        MEBE/lnPJER0A
X-Received: by 2002:a19:48c5:: with SMTP id v188mr2838254lfa.100.1579614614304;
        Tue, 21 Jan 2020 05:50:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn5xqRhHmPpySMcmkFZmX06i6ruLvGvbAL8D8ASe1wRGX+vhBALjz8OzpwILxiqeG3ZXt2kA==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr2838216lfa.100.1579614613963;
        Tue, 21 Jan 2020 05:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r2sm18840207lfn.13.2020.01.21.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:50:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B9471804D6; Tue, 21 Jan 2020 14:33:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v5 00/11] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <CAEf4BzYNp81_bOFSEZR=AcruC2ms76fCWQGit+=2QZrFAXpGqg@mail.gmail.com>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk> <CAEf4BzYNp81_bOFSEZR=AcruC2ms76fCWQGit+=2QZrFAXpGqg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 21 Jan 2020 14:33:46 +0100
Message-ID: <874kwpndc5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Jan 20, 2020 at 5:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> We are currently being somewhat inconsistent with the libbpf include pat=
hs,
>> which makes it difficult to move files from the kernel into an external
>> libbpf-using project without adjusting include paths.
>>
>> Having the bpf/ subdir of $INCLUDEDIR in the include path has never been=
 a
>> requirement for building against libbpf before, and indeed the libbpf pk=
g-config
>> file doesn't include it. So let's make all libbpf includes across the ke=
rnel
>> tree use the bpf/ prefix in their includes. Since bpftool skeleton gener=
ation
>> emits code with a libbpf include, this also ensures that those can be us=
ed in
>> existing external projects using the regular pkg-config include path.
>>
>> This turns out to be a somewhat invasive change in the number of files t=
ouched;
>> however, the actual changes to files are fairly trivial (most of them ar=
e simply
>> made with 'sed'). The series is split to make the change for one tool su=
bdir at
>> a time, while trying not to break the build along the way. It is structu=
red like
>> this:
>>
>> - Patch 1-3: Trivial fixes to Makefiles for issues I discovered while ch=
anging
>>   the include paths.
>>
>> - Patch 4-8: Change the include directives to use the bpf/ prefix, and u=
pdates
>>   Makefiles to make sure tools/lib/ is part of the include path, but wit=
hout
>>   removing tools/lib/bpf
>>
>> - Patch 9-11: Remove tools/lib/bpf from include paths to make sure we do=
n't
>>   inadvertently re-introduce includes without the bpf/ prefix.
>>
>> Changelog:
>>
>> v5:
>>   - Combine the libbpf build rules in selftests Makefile (using Andrii's
>>     suggestion for a make rule).
>>   - Re-use self-tests libbpf build for runqslower (new patch 10)
>>   - Formatting fixes
>>
>> v4:
>>   - Move runqslower error on missing BTF into make rule
>>   - Make sure we don't always force a rebuild selftests
>>   - Rebase on latest bpf-next (dropping patch 11)
>>
>> v3:
>>   - Don't add the kernel build dir to the runqslower Makefile, pass it i=
n from
>>     selftests instead.
>>   - Use libbpf's 'make install_headers' in selftests instead of trying to
>>     generate bpf_helper_defs.h in-place (to also work on read-only files=
ystems).
>>   - Use a scratch builddir for both libbpf and bpftool when building in =
selftests.
>>   - Revert bpf_helpers.h to quoted include instead of angled include wit=
h a bpf/
>>     prefix.
>>   - Fix a few style nits from Andrii
>>
>> v2:
>>   - Do a full cleanup of libbpf includes instead of just changing the
>>     bpf_helper_defs.h include.
>>
>> ---
>>
>
> Looks good, it's a clear improvement on what we had before, thanks!
>
> It doesn't re-build bpftool when bpftool sources changes, but I think
> it was like that even before, so no need to block on that. Would be
> nice to have a follow up fixing that, though. $(wildcard
> $(BPFTOOL_DIR)/*.[ch] $(BPFTOOL_DIR)/Makefile) should do it, same as
> for libbpf.

Yeah, I did realise there was some potential for improvement for bpftool
as well, but I got enough of Makefiles for now :)

I'll see if I can't circle back to this at some point...

> So, for the series:
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Tested-by: Andrii Nakryiko <andriin@fb.com>

Thanks!

-Toke

