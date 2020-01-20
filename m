Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3129142B5D
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2020 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgATM5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jan 2020 07:57:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726738AbgATM5F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jan 2020 07:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEDkrujKlTJc5+7hmDpzcA7gq/UPeEUXrVOs87I/0F4=;
        b=eN2L3cmfLKfsG/QQRItX2c6DQoAd3GIEMgALAiocvUlJz5mvKpOmgVUpdqRMXiG8EZCzFY
        0H1ZbhCMKHhaIHRgBhDxm/CGFfUXhCDwVcMKsoS8gfCm1qZoT1ngsPEbmNPbQNA0hfHOm5
        63kZFdxl4T/UTVJPqo7ZLDI3hnBUgA4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-KPtqYLPQNEu3UXmXEKJOxw-1; Mon, 20 Jan 2020 07:57:02 -0500
X-MC-Unique: KPtqYLPQNEu3UXmXEKJOxw-1
Received: by mail-lj1-f198.google.com with SMTP id r14so7499587ljc.18
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 04:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FEDkrujKlTJc5+7hmDpzcA7gq/UPeEUXrVOs87I/0F4=;
        b=Wr4s1iCtsxyruqj83lVHYhGmpFpzcQjVQAv3Z65YswE/kP8gZdO+n9aJUTdav1Eg/b
         ajk7e/zl0YYEHx1ueAWkw/vddtXZfK8Zcu8T+UoV0ULw1w0X5uKLdF6/uS1duiq3sjMQ
         sC6kYJEWmN1C4jhwdBTk2TZb5pjYn1rfD8x1xjcICbnHq/GPT/8wJWfBmeZaaI437NW3
         gicLluB8hpUcFKlS9BKewDuKhxd6qf1o5dLtKKrItH7aTD9qUnrnCqbxZ4bmUSSu6cfU
         Ui7PbfZt3Kssyl3xEKPuKJP2jd4jxn2YYr9DcMPhlNfgpNuD8jdelWCE6Nv2Zk58l6ih
         Wstg==
X-Gm-Message-State: APjAAAWxc584CgEVV1k4tomSD3C7FdSMyBOE1Q8FLh3P6ByPXBfa2+Lv
        GFOMZSwZ1Ml2mhUkls2WgIJfOR/IYunZKxYJbaUe1dDwc/dNpQsfhRN+CCFUbSQ0gznu6xvd792
        X56NkSBiHc5Fu
X-Received: by 2002:a2e:721a:: with SMTP id n26mr13678527ljc.128.1579525021237;
        Mon, 20 Jan 2020 04:57:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqylZwrQxfS+zP3D15CF1fcweaXgkNnfdqeyFKArvqvKbNKna0d4DC4s5krAr4PrBm9NHLxAlw==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr13678516ljc.128.1579525020966;
        Mon, 20 Jan 2020 04:57:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2sm16813782ljq.38.2020.01.20.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:57:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5785F1804D6; Mon, 20 Jan 2020 13:56:59 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v4 04/10] tools/runqslower: Use consistent include paths for libbpf
In-Reply-To: <CAEf4BzbAV0TmEUL=62jz+RD6SPmu927z-dhGL9JHepcAOGMSJA@mail.gmail.com>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk> <157926820131.1555735.1177228853838027248.stgit@toke.dk> <CAEf4BzbAV0TmEUL=62jz+RD6SPmu927z-dhGL9JHepcAOGMSJA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 20 Jan 2020 13:56:59 +0100
Message-ID: <875zh6p9pg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jan 17, 2020 at 5:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Fix the runqslower tool to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>
>> To not break the build, keep the old include path until everything has b=
een
>> changed to the new one; a subsequent patch will remove that.
>>
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile         |    5 +++--
>>  tools/bpf/runqslower/runqslower.bpf.c |    2 +-
>>  tools/bpf/runqslower/runqslower.c     |    4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index b62fc9646c39..9f022f7f2593 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -5,6 +5,7 @@ LLC :=3D llc
>>  LLVM_STRIP :=3D llvm-strip
>>  DEFAULT_BPFTOOL :=3D $(OUTPUT)/sbin/bpftool
>>  BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>> +INCLUDES :=3D -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/=
bpf)
>>  LIBBPF_SRC :=3D $(abspath ../../lib/bpf)
>
> drop LIBBPF_SRC, it's not used anymore

It is: in the rule for building libbpf there's a '-C $(LIBBPF_SRC)'

-Toke

