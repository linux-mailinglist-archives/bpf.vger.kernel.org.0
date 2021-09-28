Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF66841B6F3
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 21:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhI1TLl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 15:11:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38719 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbhI1TLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 15:11:40 -0400
Received: (Authenticated sender: joe@ovn.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A956F1BF20D
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 19:09:58 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id y26so299939lfa.11
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 12:09:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Q9MypKkc8vJiJqqLxLc1LidayEGCFZ9aOxpWlFGd/L6SVxoJT
        BpaXOdp7FJTNE0LYxzdOPiBgD1xmtuVPLZmCPhs=
X-Google-Smtp-Source: ABdhPJwx3mp5/FR7gYQXtyI4+wHZf7F3n9Kb6J+UZH60HlXUU1n1oKmM9W8/fTIOfXny1Nylpo33uG9XbIQer/jp3pg=
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr6849657lfp.410.1632856197836;
 Tue, 28 Sep 2021 12:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210923000540.47344-1-luca.boccassi@gmail.com> <CA+i-1C3sjrwtskbSZzera7ANL8dTiVWMBwLRhe=+1Ft6NgfL=A@mail.gmail.com>
In-Reply-To: <CA+i-1C3sjrwtskbSZzera7ANL8dTiVWMBwLRhe=+1Ft6NgfL=A@mail.gmail.com>
From:   Joe Stringer <joe@ovn.org>
Date:   Tue, 28 Sep 2021 12:09:46 -0700
X-Gmail-Original-Message-ID: <CAPWQB7HBBrP5eQhXnhw5VRMPBRHqXNSi_zmiaE12s==Z1av9HA@mail.gmail.com>
Message-ID: <CAPWQB7HBBrP5eQhXnhw5VRMPBRHqXNSi_zmiaE12s==Z1av9HA@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
To:     Brendan Jackman <jackmanb@google.com>
Cc:     luca.boccassi@gmail.com, bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, daniel@zonque.org,
        fengc@google.com, jbacik@fb.com, Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Sept 2021 at 02:42, Brendan Jackman <jackmanb@google.com> wrote:
>
>
>
> On Thu, 23 Sept 2021 at 02:06, <luca.boccassi@gmail.com> wrote:
>>
>> From: Luca Boccassi <bluca@debian.org>
>>
>> libbpf and bpftool have been dual-licensed to facilitate inclusion in
>> software that is not compatible with GPL2-only (ie: Apache2), but the
>> samples are still GPL2-only.
>>
>> Given these files are samples, they get naturally copied around. For example
>> it is the case for samples/bpf/bpf_insn.h which was copied into the systemd
>> tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
>>
>> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
>> the same licensing used by libbpf and bpftool:
>>
>> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
>> 907b22365115 ("tools: bpftool: dual license all files")
>>
>> Signed-off-by: Luca Boccassi <bluca@debian.org>
>> ---
>> Most of systemd is (L)GPL2-or-later, which means there is no perceived
>> incompatibility with Apache2 softwares and can thus be linked with
>> OpenSSL 3.0. But given this GPL2-only header is included this is currently
>> not possible.
>> Dual-licensing this header solves this problem for us as we are scoping
>> moving to OpenSSL 3.0, see:
>>
>> https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html
>>
>> The authors of this file according to git log are:
>>
>> Alexei Starovoitov <ast@kernel.org>
>> Björn Töpel <bjorn.topel@intel.com>
>> Brendan Jackman <jackmanb@google.com>
>
>
> Acked-by:  Brendan Jackman <jackmanb@google.com>
>
>> Chenbo Feng <fengc@google.com>
>> Daniel Borkmann <daniel@iogearbox.net>
>> Daniel Mack <daniel@zonque.org>
>> Jakub Kicinski <jakub.kicinski@netronome.com>
>> Jiong Wang <jiong.wang@netronome.com>
>> Joe Stringer <joe@ovn.org>
>> Josef Bacik <jbacik@fb.com>
>>
>> (excludes a commit adding the SPDX header)
>>
>> All authors and maintainers are CC'ed. An Acked-by from everyone in the
>> above list of authors will be necessary.
>>
>> One could probably argue for relicensing all the samples/bpf/ files given both
>> libbpf and bpftool are, however the authors list would be much larger and thus
>> it would be much more difficult, so I'd really appreciate if this header could
>> be handled first by itself, as it solves a real license incompatibility issue
>> we are currently facing.
>>
>>  samples/bpf/bpf_insn.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
>> index aee04534483a..29c3bb6ad1cd 100644
>> --- a/samples/bpf/bpf_insn.h
>> +++ b/samples/bpf/bpf_insn.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>  /* eBPF instruction mini library */
>>  #ifndef __BPF_INSN_H
>>  #define __BPF_INSN_H
>> --
>> 2.33.0
>>

Acked-by: Joe Stringer <joe@ovn.org>
