Return-Path: <bpf+bounces-4819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC674FD64
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B873F281607
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2365A;
	Wed, 12 Jul 2023 03:04:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43138F;
	Wed, 12 Jul 2023 03:04:36 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3D1712;
	Tue, 11 Jul 2023 20:04:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso103519911fa.0;
        Tue, 11 Jul 2023 20:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689131073; x=1691723073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN0oGQ8AorTIXTWyQga8RykNuxoH3ndOd/siNCCXBTQ=;
        b=oKstHnuGaNI2uzY/Z5i5pHksvtbSHFOndi07P1Nk09ilz+R6axIcIlktSO3gPZTr66
         3bxAw8EUehjHLzqnuFaMjXMkqz85yzY/WHdxBnvBQkZCIgcKiGacHx4Piz49lm1xan5+
         Ua8zZ+/GWYFO+rptlUb2tOqjSZm6Mmmmqd6ZOq8saaH/u4KIG/daBBcYzy4mg+0LINIj
         7QN9qbi1YajLKsW3bjA8tXWO/QsAcfJCF6o9oqx1HQ3t6Miod0P9TeEkWZNDzAvKnv17
         4H6VjgiMuKes9/IfKh3nO1hfEXwTpFtsI4eyQUkfkBvRYjOMXEQ9cCh38ozocT03QCtK
         KL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689131073; x=1691723073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN0oGQ8AorTIXTWyQga8RykNuxoH3ndOd/siNCCXBTQ=;
        b=j+SuBnyuY7T0thvnmSgmPiFoeEGCSt5OYU0iDOHo7ktw6WOYimxH414e+8U7fr3/qh
         ImvxbSzD1P8Plpm8xANK2DtLfV3/mAdD9BEWpMkQNNQ9Ki80ACerMXaFNxyyf2EODwbI
         7v1XrF4qhJn1x5f7g0uQXiD9kohULviIQqhqkoZHJR4oltRZ5uoz7AdicNwqd8+NVW6V
         Pz+ijVnzYpBcrDiyovhW3ZHp5Snmkvlp20pPREwmrJTpEfjAOhI9fPz2gSb4URPujq+l
         4rQPeNs0zuEQZcRrZ/HCek69+qSEm1F1i9gJkvDgaZs3ZfUq78bpkrdTK56IeHYwYFB1
         nURw==
X-Gm-Message-State: ABy/qLZbiZoyao0W4Dwbe245m5gJ2p2rYXnlmJhssjhxH5SEgDchnP8p
	lgomg0GEXt2tmsKCbzFMjm7TRoFzpnMZCCoDufLHrpnk
X-Google-Smtp-Source: APBJJlHGCz8YsgqDiTdCsNf/0Ljja1GYMV6hcL+/1A2cIPg8A7phVwMifvH5KzPzBOrF644CgsIDnmWsmVREvRe/c4w=
X-Received: by 2002:a05:651c:120c:b0:2b6:fc80:c45f with SMTP id
 i12-20020a05651c120c00b002b6fc80c45fmr13847457lja.13.1689131072627; Tue, 11
 Jul 2023 20:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711115848.2701559-1-pulehui@huaweicloud.com> <e065f385-3baf-eacb-7ca5-6ade14491eee@huaweicloud.com>
In-Reply-To: <e065f385-3baf-eacb-7ca5-6ade14491eee@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 20:04:21 -0700
Message-ID: <CAADnVQJ=g9jpNq8YEg-NxHmwKfZ6VsPtsW6ix1=u25zoPjNOSQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
To: Hou Tao <houtao@huaweicloud.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huawei.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 7:12=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 7/11/2023 7:58 PM, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > Syzkaller reported a memory leak as follows:
> >
> > BUG: memory leak
> > unreferenced object 0xff110001198ef748 (size 192):
> >   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 4a 19 00 00 80 ad e3 e4 fe ff c0 00  ....J...........
> >     00 b2 d3 0c 01 00 11 ff 28 f5 8e 19 01 00 11 ff  ........(.......
> >   backtrace:
> >     [<ffffffffadd28087>] __cpu_map_entry_alloc+0xf7/0xb00
> >     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
> >     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
> >     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
> >     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
> >     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
> >     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > BUG: memory leak
> > unreferenced object 0xff110001198ef528 (size 192):
> >   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffffadd281f0>] __cpu_map_entry_alloc+0x260/0xb00
> >     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
> >     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
> >     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
> >     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
> >     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
> >     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > BUG: memory leak
> > unreferenced object 0xff1100010fd93d68 (size 8):
> >   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
> >   hex dump (first 8 bytes):
> >     00 00 00 00 00 00 00 00                          ........
> >   backtrace:
> >     [<ffffffffade5db3e>] kvmalloc_node+0x11e/0x170
> >     [<ffffffffadd28280>] __cpu_map_entry_alloc+0x2f0/0xb00
> >     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
> >     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
> >     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
> >     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
> >     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
> >     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > In the cpu_map_update_elem flow, when kthread_stop is called before
> > calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bi=
t
> > of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
> > will never be executed, and rcpu->refcnt will never be 0, which will
> > lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot b=
e
> > released.
> >
> > Calling kthread_stop before executing kthread's threadfn will return
> > -EINTR. We can complete the release of memory resources in this state.
> >
> > Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_=
CPUMAP")
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>
> Acked-by: Hou Tao <houtao1@huawei.com>
>

Applied. Thanks

