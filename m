Return-Path: <bpf+bounces-2463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E870A72D50B
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 01:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6FA1C20BC7
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADE101F1;
	Mon, 12 Jun 2023 23:38:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F7BE66
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 23:38:23 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48910124;
	Mon, 12 Jun 2023 16:38:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so60021251fa.3;
        Mon, 12 Jun 2023 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686613100; x=1689205100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPTS7iTAIXVDzw9598jXe5gEaF4jIlKcW67yEWziHVM=;
        b=amQwBxQOTZMUyEq4FX6DoCUWFB46p0Ok6vT+1jlYmgYXgPrnrVON2Pg4QpcqQPfpSN
         za2sEurK8oHEZfK1lpv0P1drAbEXSp1M5g/c9ulS89NBtVfX+ZfDvkGLOUbILD2x9ECk
         /SOwB9GIE5l8iLdbK9fMbZXsNbuCmWNtyw8fiY6e5NGBHLEh0eUJmLF3tHIg5dOnhgg0
         6aqo1wmuMeLwtCcQh9GateQgvMnaBPx8J8BL0zJr2TCEKGaO5IsmKL+qPwnpehAuC3+N
         661d3HR4hSjzGSWefTsXsfUBGoJiFA7cTIpu2Yp0yYQQAUUXOvb/xi71nRgF0h6Jqz+Y
         j1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613100; x=1689205100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPTS7iTAIXVDzw9598jXe5gEaF4jIlKcW67yEWziHVM=;
        b=Sv2G76ALEiBu5DVRA1HW6uA+IWByh6vgFT5uaQStQz2TToLIE7Cu2PX3QLeDO2x2eP
         QOlfWuQMypo2gSS0JRpDA7+Z7lBXas3yCrEu/nWUelDnmsxIcMu24H9vawwx8AZl1HEY
         AOyY7jrzA+HHzBW9SwekQ1s/zGHKZuRr/LBoEXxzmd1VmdWM/V/0ExTEwkFWaI1TPgyG
         FgxJfyG/d4rDNbHzAi4FQ+RaY7BrS1jHFM3Kuw9PI998+crSiTOrfAEeGvCCDxP9zeMN
         DS5w/dlGE/7xumOHFquPFXfwcPoFstbXqK5PAhAJQB/Fnl2fj3KCFIYqeYfsIe/yiqEE
         ++Pw==
X-Gm-Message-State: AC+VfDyCZ/eXvrK+SPMzDdUsTVH8Cc5wLaZ0xNVVR7eE6PRKDSovUuYk
	BbtAMeHDynv5K9OwKuUMXyYFA/S5LP0cNUv7Hb8=
X-Google-Smtp-Source: ACHHUZ5OjA6GXNAFiCWxgJF5vZukvUfmyOPHrFDBhWB6BfgBx/wqv7xsl4fSCWw1fau7gtOJyPi8sG9EyOa8q/qGBrg=
X-Received: by 2002:a2e:990d:0:b0:2af:bf0d:e1c8 with SMTP id
 v13-20020a2e990d000000b002afbf0de1c8mr3910847lji.12.1686613100127; Mon, 12
 Jun 2023 16:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local> <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
 <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com> <CAEf4BzY7+mcADa1SUDMpVNbdo2aakSkHv4HU3ENgFfrg+7BNPQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY7+mcADa1SUDMpVNbdo2aakSkHv4HU3ENgFfrg+7BNPQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Jun 2023 16:38:08 -0700
Message-ID: <CAADnVQKBm7cYAwYtimPaPf_m7TAhf4SXajfuCcLo7DJ+6EXjGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory allocator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
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

On Mon, Jun 12, 2023 at 4:17=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 9:12=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 8, 2023 at 11:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> > >
> > > >
> > > >> +                    --producers=3D8 --prod-affinity=3D0-7 "$@")"
> > > > -a -p 8 should just work.
> > > > No need to pick specific cpus.
> > > No. For VM with only 8 CPUs, the affinity of the first producer will =
be
> > > CPU 1 and the affinity of the last producer will be CPU 8, so the
> > > benchmark will fail to run. But I think I can fix it, so the affinity=
 of
> > > the last producer will be 0 instead.
> >
> > Right. Noticed that too.
> > That should probably be a separate patch to fix this cpu assignment
> > issue in bench for all benchs.
> >
> > Andrii,
> > when you wrote it did you really mean to start assigning cpus from 1
> > or that was just an oversight?
>
>   616 =E2=96=B8       /* unless explicit producer CPU list is specified, =
continue after=C2=AC
>   617 =E2=96=B8        * last consumer CPU=C2=AC
>   618 =E2=96=B8        */=C2=AC
>
>
> It's been a while, but it seems like each consumer gets its CPU first,
> then each producer. So yeah, seems intentional.
>
> For context, this was done for BPF ringbuf benchmarking, so by default
> I wanted to separate a single consumer from multiple producers.

I see. In this cas Hou's bench has empty consumer:
+static void *htab_mem_consumer(void *arg)
+{
+       return NULL;
+}

but setup_benchmark() still creates an instant 'return NULL' thread
and pins it to cpu 0.

I guess the fix is for htab-mem bench to set env.consumer_cnt =3D 0
at init time and don't supply empty consumer at all.

May be consumer_cnt=3D0 can a default and ringbuf bench will just the
default to 1?

