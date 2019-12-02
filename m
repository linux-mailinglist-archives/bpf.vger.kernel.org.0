Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C254E10EEEA
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 19:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfLBSJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 13:09:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727420AbfLBSJB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Dec 2019 13:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575310141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4ecEttM3yApxyxrsr44NMQb+oeialaWZ1R4NWHga6Y=;
        b=WZhxTDuDjU0wiZug6+8AoXZKGF5uYFMkTOeBHxYfqKTp+utizSJzN9MTVRKIilfeTyR0BN
        8FVkgqdgRSkh+UEocQII3nu6K52HJ3t5qVLKCZxYzL32zc+8VRHh2FgTvUF340N/JoMB/l
        fTu2YeRuVK6uwZQwRLOZqNTEIf1CpmE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-XXmrEeeEMnKNhHKRBDCiHg-1; Mon, 02 Dec 2019 13:08:57 -0500
Received: by mail-lj1-f197.google.com with SMTP id h10so54223ljl.18
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 10:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R3A1rQuYRQ18AFn43+yCBqk/Ud+1TsgtYotLFNawFuU=;
        b=iFzo7wx7oO00I9YHH8vrDKOW5bHaQKkWrp4NTOnrgvT7l/k9MVQLqzOCLQ0IKrXh8k
         GomwIhyH4lyH6GuKD1t5b2Eo7xUkoNufw2xcPHFYE6WU8okpKEWQk3ShD2gf1T3hE6Kv
         O0VusubwqVO9+FzVRNZ1HkCWzy7AX7fqBlHOQs1nLLxY03CloTJNRPensFIxqh/Wplvd
         d6phBxlNtWrrT3Yg/z3IJ0eP7pGCSOV2baSy054xZJOaynFkR7WCMoRvT0/vvOt/YbmN
         HBbWPXQY4s7LE5SFKMrVUuJoxxCrDxrI4UdXT2pLbIZrMpuV937d2adJYQnS2lxBgLfE
         42mg==
X-Gm-Message-State: APjAAAW4XKnMjUZNOkKzaOf2bjYLlxWBfht20li0Z5hhWv2Kr3oGozH5
        dzpa3fWSdIi8e3TO0J4Nsk6CNaabgnNUfPYUk9pZpkzhezA1kbSLRlA5NgSDwHGNrG9HJgsgXRW
        OcFu2DJPRH7qg
X-Received: by 2002:ac2:5931:: with SMTP id v17mr202405lfi.166.1575310135583;
        Mon, 02 Dec 2019 10:08:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+ErVGcirRgq/taxG0hc0PK3IZELxdIQ1H+CTFmxm/d8vQkPE9sNJgKnUenWoxN34oySG/8A==
X-Received: by 2002:ac2:5931:: with SMTP id v17mr202380lfi.166.1575310135338;
        Mon, 02 Dec 2019 10:08:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v2sm148047ljv.70.2019.12.02.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:08:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE3941804D1; Mon,  2 Dec 2019 19:08:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/3] perf/bpftool: Allow to link libbpf dynamically
In-Reply-To: <CAEf4BzbUK98tsYH1mSNoTjuVB4dstRsL5rpkA+9nRCcqrdn6-Q@mail.gmail.com>
References: <20191127094837.4045-1-jolsa@kernel.org> <CAEf4BzbUK98tsYH1mSNoTjuVB4dstRsL5rpkA+9nRCcqrdn6-Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Dec 2019 19:08:52 +0100
Message-ID: <87zhgappl7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: XXmrEeeEMnKNhHKRBDCiHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 27, 2019 at 1:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> adding support to link bpftool with libbpf dynamically,
>> and config change for perf.
>>
>> It's now possible to use:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1
>
> I wonder what's the motivation behind these changes, though? Why is
> linking bpftool dynamically with libbpf is necessary and important?
> They are both developed tightly within kernel repo, so I fail to see
> what are the huge advantages one can get from linking them
> dynamically.

Well, all the regular reasons for using dynamic linking (memory usage,
binary size, etc). But in particular, the ability to update the libbpf
package if there's a serious bug, and have that be picked up by all
utilities making use of it. No reason why bpftool should be special in
that respect.

-Toke

