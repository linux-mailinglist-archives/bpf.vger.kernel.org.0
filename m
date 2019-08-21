Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A298625
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 23:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfHUVAa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Aug 2019 17:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfHUVA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 17:00:28 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 680C890C99
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 21:00:27 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id z2so2093889ede.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 14:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ruFXw9bzrxHGUHChucOB+CKkubs4QvC48DEyCDsjc3U=;
        b=r9V5TsWGt9/p+1cMNTiq7CfNe5MeFuc6Mc5jU1bq3qDYvBNLw5FioyNNDGqO+wrU9q
         HWPuTFBeHmVk8t+nxjcmx0iU/FU2u7+vsx3biPxSXV6u75PiS3HyILZIwqVAZhrBWk9b
         zAYi46RoDkismW6zSod6SJmeiJvBDlSTmaJ6D5Cqe5tiwnKVqFkNZSYoi8BlEgfsBGl2
         ul6+coGMLg1kNL9xk7XzmfZ7c7clHkZKn12uohqPGkJB2/dTXbNxlEDX91I9gefXHGiP
         rqHAYywhZyaT70ACwx/iow+dXWnig1dUqyvtYOlbdsk8YsT3CkcnCwCuFhAIBeffYVNT
         lZSA==
X-Gm-Message-State: APjAAAX+1V0mICkQY3n9LMew/iBM1wNUjj2SlaoSk0IiWL9k7X3Meimx
        DBRJ89F6wjfwDId9oWOYxwPfaUuoO33uyhO34xUShNn2PRS3sz80Ddn1Oq7o99wJVuRI+M9Rp84
        b1B/f2bfV1b7d
X-Received: by 2002:a50:ccd9:: with SMTP id b25mr38169345edj.114.1566421226202;
        Wed, 21 Aug 2019 14:00:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4Vd95rZsajzsZH/kXeb8Ecz4sVxKWF+Y5ZvEWDtGLTuq82UBCEJjUola5Mgs8PVgJZkJ7bQ==
X-Received: by 2002:a50:ccd9:: with SMTP id b25mr38169303edj.114.1566421225863;
        Wed, 21 Aug 2019 14:00:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h13sm3241367edw.78.2019.08.21.14.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:00:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2C3E6181CEF; Wed, 21 Aug 2019 23:00:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 0/5] Convert iproute2 to use libbpf (WIP)
In-Reply-To: <20190821192611.xmciiiqjpkujjup7@ast-mbp.dhcp.thefacebook.com>
References: <20190820114706.18546-1-toke@redhat.com> <20190821192611.xmciiiqjpkujjup7@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Aug 2019 23:00:24 +0200
Message-ID: <87ef1eqlnb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Aug 20, 2019 at 01:47:01PM +0200, Toke Høiland-Jørgensen wrote:
>> iproute2 uses its own bpf loader to load eBPF programs, which has
>> evolved separately from libbpf. Since we are now standardising on
>> libbpf, this becomes a problem as iproute2 is slowly accumulating
>> feature incompatibilities with libbpf-based loaders. In particular,
>> iproute2 has its own (expanded) version of the map definition struct,
>> which makes it difficult to write programs that can be loaded with both
>> custom loaders and iproute2.
>> 
>> This series seeks to address this by converting iproute2 to using libbpf
>> for all its bpf needs. This version is an early proof-of-concept RFC, to
>> get some feedback on whether people think this is the right direction.
>> 
>> What this series does is the following:
>> 
>> - Updates the libbpf map definition struct to match that of iproute2
>>   (patch 1).
>> - Adds functionality to libbpf to support automatic pinning of maps when
>>   loading an eBPF program, while re-using pinned maps if they already
>>   exist (patches 2-3).
>> - Modifies iproute2 to make it possible to compile it against libbpf
>>   without affecting any existing functionality (patch 4).
>> - Changes the iproute2 eBPF loader to use libbpf for loading XDP
>>   programs (patch 5).
>> 
>> 
>> As this is an early PoC, there are still a few missing pieces before
>> this can be merged. Including (but probably not limited to):
>> 
>> - Consolidate the map definition struct in the bpf_helpers.h file in the
>>   kernel tree. This contains a different, and incompatible, update to
>>   the struct. Since the iproute2 version has actually been released for
>>   use outside the kernel tree (and thus is subject to API stability
>>   constraints), I think it makes the most sense to keep that, and port
>>   the selftests to use it.
>
> It sounds like you're implying that existing libbpf format is not
> uapi.

No, that's not what I meant... See below.

> It is and we cannot break it.
> If patch 1 means breakage for existing pre-compiled .o that won't load
> with new libbpf then we cannot use this method.
> Recompiling .o with new libbpf definition of bpf_map_def isn't an option.
> libbpf has to be smart before/after and recognize both old and iproute2 format.

The libbpf.h definition of struct bpf_map_def is compatible with the one
used in iproute2. In libbpf.h, the struct only contains five fields
(type, key_size, value_size, max_entries and flags), and iproute2 adds
another 4 (id, pinning, inner_id and inner_idx; these are the ones in
patch 1 in this series).

The issue I was alluding to above is that the bpf_helpers.h file in the
kernel selftests directory *also* extends the bpf_map_def struct, and
adds two *different* fields (inner_map_idx and numa_mode). The former is
used to implement the same map-in-map definition functionality that
iproute2 has, but with different semantics. The latter is additional to
that, and I'm planning to add that to this series.

Since bpf_helpers.h is *not* part of libbpf (yet), this will make it
possible to keep API (and ABI) compatibility with both iproute2 and
libbpf. As in, old .o files will still load with libbpf after this
series, they just won't be able to use the new automatic pinning
feature.

-Toke
