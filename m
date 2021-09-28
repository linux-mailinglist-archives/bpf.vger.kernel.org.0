Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C697241B741
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 21:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbhI1TOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhI1TOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 15:14:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E8C06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 12:12:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r1so20899845qta.12
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+dWFzbHnwyX5eGiYt47CpTk7uWm5IFzM8c0Z/Pzt5xg=;
        b=duXYaU8wIoQ5qHgEUtfmW0NMewp7QtVkB98z3JR2kXFs64XtAfbH9QtsuxsRmUJ+up
         srGZh7JNYSNN2tfzAPT4rzSnth7VfCy5wBfeCTS0ErfPlEwoBcBhE4WU15sFdYR1NVmq
         lsCCixUGzHHktl1grATEn+7o7d6qZ6z4Dq2bW5tfXEsEI/V5O+T1Nb2tSRDO8hQ+8PuS
         nTqqeBTYAvliQfuQpp4Nt1qqiyzWYPo/HvbtnxlNLr8psj4g+NVqYhAVJdup5O0faGOn
         Ji2SzRG/R/MmhxXmFC5CNX8qGSh9vLg5Yjha8sbENDR44Fm60D88/fjCz6rACFvXCNej
         oZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+dWFzbHnwyX5eGiYt47CpTk7uWm5IFzM8c0Z/Pzt5xg=;
        b=BYUpiUiw+J2cd2mwdr6R+wGec9dnvrwUtQKsP+XisYWiQyyUlLWuH1jHJ+rmUHhBQm
         zAOPbSHQVXBpXOMV1L9S41eF8iECEYT5B90M1sqNHWtk8tqE7tdENsBTt2oOJEyy6C5V
         ab9L8XLePco4Wig93JUI7Mm5xqlQIS/OAWgvI2LUir0iobany3HG0wAxxQ1rrrn2Gcfe
         pWRcTlRw5y7ytOt3SIbHmBs67rtZhTY2Z85OSqgBt9pBjhR9B1dQ3bqRjATenVvrriI7
         jTmZGr52r5KZBs1PRX9CV3b2vjzmt0Dp1IInQLXIYy9dcDiMzJgPlAOsROjU9ZCGPWf3
         J03g==
X-Gm-Message-State: AOAM533tbcEzbHqaqn3QAnIF4+qayed/DccTZMHELg7hr2NeIzDk8nM0
        D3R+UNFEocsu/215JoygJBDU34x6VdnrvCBrs5yAkRLDn4FmuF5X
X-Google-Smtp-Source: ABdhPJwwYgBSzfVOlL/Jr6xdkO+OwynN3Tw8hCmH36HPYOpv7HS1lT/fgufh6L4I1s2sZr7d9EPA76f1TNuK6/LVs1s=
X-Received: by 2002:a05:622a:178b:: with SMTP id s11mr7884538qtk.13.1632856378816;
 Tue, 28 Sep 2021 12:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <CA+i-1C3sjrwtskbSZzera7ANL8dTiVWMBwLRhe=+1Ft6NgfL=A@mail.gmail.com>
 <CAPWQB7HBBrP5eQhXnhw5VRMPBRHqXNSi_zmiaE12s==Z1av9HA@mail.gmail.com> <CAMOXUJ=gLLCDv0ZuEz77Qvepx9r0uTfy3J3phWuGPMQXsM1FGA@mail.gmail.com>
In-Reply-To: <CAMOXUJ=gLLCDv0ZuEz77Qvepx9r0uTfy3J3phWuGPMQXsM1FGA@mail.gmail.com>
From:   Chenbo Feng <fengc@google.com>
Date:   Tue, 28 Sep 2021 12:12:47 -0700
Message-ID: <CAMOXUJknkwbjfZR1vwwJRqoufp7651rjMgKuXyCjGYi6gNZ8JA@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
To:     Joe Stringer <joe@ovn.org>
Cc:     Brendan Jackman <jackmanb@google.com>, luca.boccassi@gmail.com,
        bpf <bpf@vger.kernel.org>,
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
        jbacik@fb.com, Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by:  Chenbo Feng <fengc@google.com>

On Tue, Sep 28, 2021 at 12:12 PM Chenbo Feng <fengc@google.com> wrote:
>
> Acked-by:  Chenbo Feng <fengc@google.com>
>
> On Tue, Sep 28, 2021 at 12:10 PM Joe Stringer <joe@ovn.org> wrote:
>>
>> On Thu, 23 Sept 2021 at 02:42, Brendan Jackman <jackmanb@google.com> wro=
te:
>> >
>> >
>> >
>> > On Thu, 23 Sept 2021 at 02:06, <luca.boccassi@gmail.com> wrote:
>> >>
>> >> From: Luca Boccassi <bluca@debian.org>
>> >>
>> >> libbpf and bpftool have been dual-licensed to facilitate inclusion in
>> >> software that is not compatible with GPL2-only (ie: Apache2), but the
>> >> samples are still GPL2-only.
>> >>
>> >> Given these files are samples, they get naturally copied around. For =
example
>> >> it is the case for samples/bpf/bpf_insn.h which was copied into the s=
ystemd
>> >> tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/b=
pf_insn.h
>> >>
>> >> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
>> >> the same licensing used by libbpf and bpftool:
>> >>
>> >> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
>> >> 907b22365115 ("tools: bpftool: dual license all files")
>> >>
>> >> Signed-off-by: Luca Boccassi <bluca@debian.org>
>> >> ---
>> >> Most of systemd is (L)GPL2-or-later, which means there is no perceive=
d
>> >> incompatibility with Apache2 softwares and can thus be linked with
>> >> OpenSSL 3.0. But given this GPL2-only header is included this is curr=
ently
>> >> not possible.
>> >> Dual-licensing this header solves this problem for us as we are scopi=
ng
>> >> moving to OpenSSL 3.0, see:
>> >>
>> >> https://lists.freedesktop.org/archives/systemd-devel/2021-September/0=
46882.html
>> >>
>> >> The authors of this file according to git log are:
>> >>
>> >> Alexei Starovoitov <ast@kernel.org>
>> >> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>> >> Brendan Jackman <jackmanb@google.com>
>> >
>> >
>> > Acked-by:  Brendan Jackman <jackmanb@google.com>
>> >
>> >> Chenbo Feng <fengc@google.com>
>> >> Daniel Borkmann <daniel@iogearbox.net>
>> >> Daniel Mack <daniel@zonque.org>
>> >> Jakub Kicinski <jakub.kicinski@netronome.com>
>> >> Jiong Wang <jiong.wang@netronome.com>
>> >> Joe Stringer <joe@ovn.org>
>> >> Josef Bacik <jbacik@fb.com>
>> >>
>> >> (excludes a commit adding the SPDX header)
>> >>
>> >> All authors and maintainers are CC'ed. An Acked-by from everyone in t=
he
>> >> above list of authors will be necessary.
>> >>
>> >> One could probably argue for relicensing all the samples/bpf/ files g=
iven both
>> >> libbpf and bpftool are, however the authors list would be much larger=
 and thus
>> >> it would be much more difficult, so I'd really appreciate if this hea=
der could
>> >> be handled first by itself, as it solves a real license incompatibili=
ty issue
>> >> we are currently facing.
>> >>
>> >>  samples/bpf/bpf_insn.h | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
>> >> index aee04534483a..29c3bb6ad1cd 100644
>> >> --- a/samples/bpf/bpf_insn.h
>> >> +++ b/samples/bpf/bpf_insn.h
>> >> @@ -1,4 +1,4 @@
>> >> -/* SPDX-License-Identifier: GPL-2.0 */
>> >> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> >>  /* eBPF instruction mini library */
>> >>  #ifndef __BPF_INSN_H
>> >>  #define __BPF_INSN_H
>> >> --
>> >> 2.33.0
>> >>
>>
>> Acked-by: Joe Stringer <joe@ovn.org>
