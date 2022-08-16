Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6E5958FA
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiHPKvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiHPKvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 06:51:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FC47EFD2;
        Tue, 16 Aug 2022 03:23:47 -0700 (PDT)
Received: from pwmachine.localnet (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08AD8210DA5E;
        Tue, 16 Aug 2022 03:23:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08AD8210DA5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660645427;
        bh=YfkkOGSQxA2OzjWDewpNMpQo+oxj7eu+1OSnrSeEK4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmrKoiJeQ8xbvJW9ziVMLBaonuTZpJk6d2MfbsVZv0S9trKuNx1i/J1TAv0fcuPTo
         C6PRgeNl7F48RhkKDnG/hStuNX33PpJcL1UnY9jIVFShckPYpDhF4TyjCNgbFokBOd
         yHHrU4m7su454KWkXbuqn2UydG56HtdOEBjcnUUI=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH v1 1/3] bpf: Make ring buffer overwritable.
Date:   Tue, 16 Aug 2022 12:23:41 +0200
Message-ID: <1735233.VLH7GnMWUR@pwmachine>
In-Reply-To: <CAEf4BzYex03T7aYjLnbkfHb8vUsCHhj_DiMU6KbK29F+DyhXyA@mail.gmail.com>
References: <20220810171702.74932-1-flaniel@linux.microsoft.com> <20220810171702.74932-2-flaniel@linux.microsoft.com> <CAEf4BzYex03T7aYjLnbkfHb8vUsCHhj_DiMU6KbK29F+DyhXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.


Le lundi 15 ao=FBt 2022, 23:52:22 CEST Andrii Nakryiko a =E9crit :
> On Wed, Aug 10, 2022 at 10:18 AM Francis Laniel
>=20
> <flaniel@linux.microsoft.com> wrote:
> > By default, BPF ring buffer are size bounded, when producers already
> > filled the buffer, they need to wait for the consumer to get those data
> > before adding new ones.
> > In terms of API, bpf_ringbuf_reserve() returns NULL if the buffer is fu=
ll.
> >=20
> > This patch permits making BPF ring buffer overwritable.
> > When producers already wrote as many data as the buffer size, they will
> > begin to over write existing data, so the oldest will be replaced.
> > As a result, bpf_ringbuf_reserve() never returns NULL.
>=20
> Part of BPF ringbuf record (first 8 bytes) stores information like
> record size and offset in pages to the beginning of ringbuf map
> metadata. This is used by consumer to know how much data belongs to
> data record, but also for making sure that
> bpf_ringbuf_reserve()/bpf_ringbuf_submit() work correctly and don't
> corrupt kernel memory.
>=20
> If we simply allow overwriting this information (and no, spinlock
> doesn't protect from that, you can have multiple producers writing to
> different parts of ringbuf data area in parallel after "reserving"
> their respective records), it completely breaks any sort of
> correctness, both for user-space consumer and kernel-side producers.

Thank you for your answer.
My current implementation is indeed wrong as I based it on the wrong=20
assumption than BPF ring buffer could only store data of the same size...
With data of different size, we can have the troubles you described.

I will rework my patches and send a new version once polished but I=20
cannot give an ETA.

> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > ---
> >=20
> >  include/uapi/linux/bpf.h |  3 +++
> >  kernel/bpf/ringbuf.c     | 51 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 43 insertions(+), 11 deletions(-)
>=20
> [...]


Best regards.


