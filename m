Return-Path: <bpf+bounces-1476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5471743A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236261C20DE8
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825381865;
	Wed, 31 May 2023 03:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514AEA6
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:15:26 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34DE5;
	Tue, 30 May 2023 20:14:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39a50fcc719so56365b6e.2;
        Tue, 30 May 2023 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685502898; x=1688094898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeKYPmPRckVNs2LGFnOl81Sx5GSbaj0lxU0+PhchNX0=;
        b=RrVsT6N8Z8QHaViGcDQczLcUMM0ZDVuStvy7rPLIGXV+vz++jG6nmhjxRjPA8ZYIvz
         roD2D10dmapfNbZc3mPb7E9KXLW3yYHakxJUi7aL9HL9pGHyS6oaYFlUaQ1uxq2GZZZe
         Y5gKE2g5DnJcEUBPTSK77ITeLbztdW2J/Fzz+5ZDNXltV2V320cYqEGge/Zrix0h/7ov
         leEfdR6xXFCDrmqyc6sE4Bfa01Z24kp0jQaPAIVcuh+VZ5zwpddgR0Z6q/jHsyXLecRL
         hvd0rglGCAaTDJtuYjuGTt189X9OmC60tsFR2baoLHDg+MMqNnZDh++pxjApGn8DJtgD
         1bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685502898; x=1688094898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeKYPmPRckVNs2LGFnOl81Sx5GSbaj0lxU0+PhchNX0=;
        b=AW7VhzhX9dGIfo6vtZdxzs0ez8BmBDbbhEug6QxEz0x1DIkABLb1uw62c9gt7IVe3U
         1bm8IMCDXU5IL6hv2hYMJPHgsQ3A/bs1Iw7D/YmFwFKAIEC/K/UoOIOsuMM0P5z2GXGT
         sbgbivNBILV2ZuM7ylDT7iJFOOzrWHnNjG+MA8ybhhonYu/8T//6nXdM8K5EP6mSo7qE
         b1+H5ide8hwl3eWS1Na1PQZhvRLXdxrbMmeqmgtpOVcxGhK+VDBFHjYLo6Z9KHtgfuWm
         3Ehs9OR5xVODGqIkzZFh43Xp1dB2ky/2lIAAR4GlZ0czhWu1Q21ZNN6maP9MWp7RD4jM
         mvxw==
X-Gm-Message-State: AC+VfDyPbj+ljn3TuJjNwC1+Ib5o52bPw9poiPPUkfiZE7SSgvxmvCJe
	8/BiXNEc0TW1IuA7+a7uVV1LvVwjpJzgjm0TLyJX/XpqmJI9jJBh
X-Google-Smtp-Source: ACHHUZ4YQOCTq61HZ8noO58uFxPtFVTfuuQPy0/szydANu9+frvjhvHvM3Bz46r2IV5i3a7twdxqSJd0KHRU2FS5Mkk=
X-Received: by 2002:a05:6808:306:b0:398:4601:4d06 with SMTP id
 i6-20020a056808030600b0039846014d06mr2204035oie.59.1685502898604; Tue, 30 May
 2023 20:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
 <073cf884-e191-e323-1445-b79c86759557@linux.dev>
In-Reply-To: <073cf884-e191-e323-1445-b79c86759557@linux.dev>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Wed, 31 May 2023 11:14:47 +0800
Message-ID: <CAABZP2zvK8_AxuZB0Smsa+L8eJf-_pnNkYF9mAsoHpSO2JZk-A@mail.gmail.com>
Subject: Re: a small question about bpftool struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

On Sat, May 20, 2023 at 3:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> > Dear developers:
> > I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> > but when I invoke:
> > bpftool struct_ops register bpf_cubic.bpf.o
> >
> > the command line fail with:
> > libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> > found in struct bpf_struct_ops_tcp_congestion_ops
>
> At the machine trying to register the bpf_cubic, please dump the vmlinux =
btf and
> search for bpf_struct_ops_tcp_congestion_ops and paste it here:
>
> For example:
> #> bpftool btf dump file /sys/kernel/btf/vmlinux
>
> ...
>
> [74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
>          'refcnt' type_id=3D145 bits_offset=3D0
>          'state' type_id=3D74569 bits_offset=3D32
>          'data' type_id=3D6241 bits_offset=3D512
>
Exciting news:
when I construct the kernel package, I found lots of following warnings:
WARN: multiple IDs found for 'task_struct': 241, 21719 - using 241
WARN: multiple IDs found for 'vm_area_struct': 360, 21750 - using 360
WARN: multiple IDs found for 'file': 805, 21789 - using 805
WARN: multiple IDs found for 'cgroup': 666, 21819 - using 666
WARN: multiple IDs found for 'inode': 928, 21936 - using 928
WARN: multiple IDs found for 'path': 960, 21965 - using 960

These warnings lead me to:
Link: https://lore.kernel.org/lkml/ZBovCrMXJk7NPISp@aurel32.net/T/

So, I upgraded my pahole from [1], and construct the kernel package
again, now I can successfully invoke
bpftool struct_ops register bpf_cubic.bpf.o

[1] https://github.com/acmel/dwarves.git

Sorry for the previous noise

and

Thanks again
Best Regards
Zhouyi

