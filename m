Return-Path: <bpf+bounces-1713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC27720785
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C471C21184
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA191D2AC;
	Fri,  2 Jun 2023 16:25:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817219BA0
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:25:49 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D41BC;
	Fri,  2 Jun 2023 09:25:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso8488621fa.1;
        Fri, 02 Jun 2023 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685723146; x=1688315146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COBcCF+iqFLg2ELZjta/++J+eLYWdmq7Z9BVQrIYE4o=;
        b=D7Lt4N312/TcGxi+DsfkgPg2xTpBlvD/Cr7ORXYKo9MsA3eNR+4wTwWXhcjxvP0amD
         I4c9/I6U7BrpHxJvKkiHvN8L1awEAHXqV5wZ86PP4Z+FM+o11vVeNUvJ9GhvTThudWfv
         pBAtoeoMnBY0Txwwol9bPd5iLchVN5y1JK0r44WqENbJfiV1nyfEMeo686JRKPabbXjs
         5PrqYAeTEy/o5s3A+3QmfcqsHCQK+HxsCIOuD9cU0mKswxdB2TMvRrWL8i+A12sc8ubk
         hqCtcAIv6lYgiozN5oq6AhqJXoTFBfbd0fZXuDQfJYIYZ6Z5Zg781PCJKPFs4ZkZjClq
         5ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723146; x=1688315146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COBcCF+iqFLg2ELZjta/++J+eLYWdmq7Z9BVQrIYE4o=;
        b=et0Z2Pgop8r3NCr79vcGho/tL8m79lX+7qwKUoP+m/srXUwbcmR2qKccud2uWHQEes
         nMnr6l1Zoy1i+QOV2gUuaekUCoLEY/cwiX9MAQXt/Xn8o7W13kPqOK33Rows3NgkBIzl
         0RugPp0euVaUnoeEQOcoEFsfQI3BK41YBGUh8NVVxCIZ65NF9Pq5NV/oC8NTvOz2CGx/
         Voadx9FhHwhRzqUcradWKQHFidGhdtYu513KxnGsp5i9r5QNXAYqKySggy1GHFV55qAk
         OWFHNKYPfHrX7NuIoYz/+7ivWvQFKtSEZqXficIvvoIrz7gMk9qepyOo7uV2iMDTyBsU
         SxlA==
X-Gm-Message-State: AC+VfDwIrR+79IyeFwPefrFoLqQkOCVPOUcWoGH0YF0fXwzACv7mroCA
	DANzNPSa/BcTfQP6VBAf4oYt9su5eNTrzPDGM/auXQ90
X-Google-Smtp-Source: ACHHUZ5r/bT7KN+XOUb8Wor8y3IRxoWnVJd1hO5DC29K7adR9PhcU6suO2pETn4esvEsBoLpxSzcHbnwD/+o35d6jds=
X-Received: by 2002:a2e:7407:0:b0:2af:2441:f709 with SMTP id
 p7-20020a2e7407000000b002af2441f709mr318465ljc.29.1685723146010; Fri, 02 Jun
 2023 09:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com> <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com> <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <d3169329-1453-e87a-fbb0-e1435f0741dc@huaweicloud.com> <CAADnVQ+yK700YFHBQx5-UpxkqhgK-SyL=b=vCXJb448WvSHkEQ@mail.gmail.com>
 <1b64fc4e-d92e-de2f-4895-2e0c36427425@huaweicloud.com>
In-Reply-To: <1b64fc4e-d92e-de2f-4895-2e0c36427425@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jun 2023 09:25:34 -0700
Message-ID: <CAADnVQJ8N=LScYNDqKCYbFdq4R_YSVkrrvUG1nqGhaqYy+mdMg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 7:40=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 6/2/2023 1:36 AM, Alexei Starovoitov wrote:
> > On Wed, May 3, 2023 at 7:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >>> Construct the patch series as:
> >>> - prep patches
> >>> - benchmark
> >>> - unconditional convert of bpf_ma to REUSE_AFTER_rcu_GP_and_free_afte=
r_rcu_tasks_trace
> >>>   with numbers from bench(s) before and after this patch.
> >> Thanks again for the suggestion. Will do in v4.
> >
> > It's been a month. Any update?
> >
> > Should we take over this work if you're busy?
> Sorry for the delay. I should post some progress information about the
> patch set early. The patch set is simpler compared with v3, I had
> implemented v4 about two weeks ago. The problem is v4 don't work as
> expected: its memory usage is huge compared with v3. The following is
> the output from htab-mem benchmark:
>
> overwrite:
> Summary: loop   11.07 =C2=B1    1.25k/s, memory usage  995.08 =C2=B1  680=
.87MiB,
> peak memory usage 2183.38MiB
> batch_add_batch_del:
> Summary: loop   11.48 =C2=B1    1.24k/s, memory usage 1393.36 =C2=B1  780=
.41MiB,
> peak memory usage 2836.68MiB
> add_del_on_diff_cpu:
> Summary: loop    6.07 =C2=B1    0.69k/s, memory usage   14.44 =C2=B1    2=
.34MiB,
> peak memory usage   20.30MiB
>
> The direct reason for the huge memory usage is slower RCU grace period.
> The RCU grace period used for reuse is much longer compared with v3 and
> it is about 100ms or more (e.g, 2.6s). I am still trying to find out the
> root cause of the slow RCU grace period. The first guest is the running
> time of bpf program attached to getpgid() is longer, so the context
> switch in bench is slowed down. The hist-diagram of getpgid() latency in
> v4 indeed manifests a lot of abnormal tail latencies compared with v3 as
> shown below.
>
> v3 getpid() latency during overwrite benchmark:
> @hist_ms:
> [0]               193451
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]                  767
> |                                                    |
> [2, 4)                75
> |                                                    |
> [4, 8)                 1
> |                                                    |
>
> v4 getpid() latency during overwrite benchmark:
> @hist_ms:
> [0]                86270
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]                31252
> |@@@@@@@@@@@@@@@@@@                                  |
> [2, 4)                 1
> |                                                    |
> [4, 8)                 0
> |                                                    |
> [8, 16)                0
> |                                                    |
> [16, 32)               0
> |                                                    |
> [32, 64)               0
> |                                                    |
> [64, 128)              0
> |                                                    |
> [128, 256)             3
> |                                                    |
> [256, 512)             2
> |                                                    |
> [512, 1K)              1
> |                                                    |
> [1K, 2K)               2
> |                                                    |
> [2K, 4K)               1
> |                                                    |
>
> I think the newly-added global spin-lock in memory allocator and
> irq-work running under the context of free procedure may lead to
> abnormal tail latency and I am trying to demonstrate that by using
> fine-grain locks and kworker (just temporarily). But on the other side,
> considering the number of abnormal tail latency is much smaller compared
> with the total number of getpgid() syscall, so I think maybe there is
> still other causes for the slow RCU GP.
>
> Because the progress of v4 is delayed, so how about I post v4 as soon as
> possible for discussion (maybe I did it wrong) and at the same time I
> continue to investigate the slow RCU grace period problem (I will try to
> get some help from RCU community) ?

Yes. Please send v4. Let's investigate huge memory consumption together.

