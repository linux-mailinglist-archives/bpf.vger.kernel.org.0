Return-Path: <bpf+bounces-2235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC9729FC3
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419361C210C7
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE231DDE4;
	Fri,  9 Jun 2023 16:12:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F71952B
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:12:46 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590D35AA;
	Fri,  9 Jun 2023 09:12:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so21817901fa.2;
        Fri, 09 Jun 2023 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686327163; x=1688919163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJJun3ofhrf29b915bUyEBHrQ/RmgnCQK6ElUKyKGe8=;
        b=rax7FrpbvJgbxzoAvdXckmRWbD9VyBmS1BmXDJqMiSfdxGbI/2Afeorjd/J7SpZH3Q
         i2zuVP19GL/CSQR/T2F4LHrvXtdOudfffA8wEsdQINK30i221tu4Bi2IG0m2BY+Pu045
         xLSXLCW2Px9LU97vIz33bIIXYcx2gUZ4ucQx9jR71C8FphbxWhc8wtyEQk8UyH+sntRc
         6J8uGU9SuFhpp4N95w67K4LTOV6QRty8F7oe8AP5XdAwaEiaNfibT8Vnl/XbwaT++XW+
         82DU8QiaGdWtSJp5H2VmcwLrUYKyvdsl5TJAepsV71ldm3tx1n35/eVSftGuYCnk4Tf9
         IkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327163; x=1688919163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJJun3ofhrf29b915bUyEBHrQ/RmgnCQK6ElUKyKGe8=;
        b=NXlDwWuE1+lm3HQWyr2UBYm7/RFZdJLFsuxQxDtM0/a4VsXdCKe9dDSDag8xXHliCV
         hflw4XvooB8Y//Fof+/1Xik9pB6WxxU7PS86eRjgg2mUSGdGz4nWlOWVCptjhRgETUaJ
         uR88AQSW5NK7IPzscxtGgXiRacTzvJYh3WzpRjrSm6EdbEa2/00qzGt18sd2OMBYK5D1
         Hq9hj+cSYUy2D0sOVYooD/dMOLng1ogxRmFE59mxvXMaZ5NVac1ykMEakppDNB3Pw2fT
         GkBeuX9jB/CBsHiDy7I5VDHLGF+8jzkpK3Vt1svdHpSg53OimxahD9ZsgzV2UJiuG7O7
         gSCg==
X-Gm-Message-State: AC+VfDxMTmdm4zEu8wDDUGjJwPVWjQFWIeHWyEwtjBfyX7TSWUuN4SpQ
	q2Hq/Fm3+qDVeYdg2R068+l5Q70XCzkZ7R1LJtw=
X-Google-Smtp-Source: ACHHUZ7Cr5gO2FVVAmfwHzV8FGPuEFuYgeotTBRiZielencUCayoO5BTRLWFavCvW/aZd5CLGWebG3vSse94ED/Jqjg=
X-Received: by 2002:a2e:9c08:0:b0:2a8:e44e:c75a with SMTP id
 s8-20020a2e9c08000000b002a8e44ec75amr1446225lji.32.1686327162897; Fri, 09 Jun
 2023 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local> <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
In-Reply-To: <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jun 2023 09:12:31 -0700
Message-ID: <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory allocator
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

On Thu, Jun 8, 2023 at 11:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> >
> >> +                    --producers=3D8 --prod-affinity=3D0-7 "$@")"
> > -a -p 8 should just work.
> > No need to pick specific cpus.
> No. For VM with only 8 CPUs, the affinity of the first producer will be
> CPU 1 and the affinity of the last producer will be CPU 8, so the
> benchmark will fail to run. But I think I can fix it, so the affinity of
> the last producer will be 0 instead.

Right. Noticed that too.
That should probably be a separate patch to fix this cpu assignment
issue in bench for all benchs.

Andrii,
when you wrote it did you really mean to start assigning cpus from 1
or that was just an oversight?

