Return-Path: <bpf+bounces-1477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5D71743C
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3216B1C20A09
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2431866;
	Wed, 31 May 2023 03:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA21373
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:15:26 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC1129
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:15:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61cd6191a62so27891186d6.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685502899; x=1688094899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGRk3qew8qHUsSqiWWEi20++QGES4qVMs5nHSf1XQ9E=;
        b=ZsNm80w9WfUKXZE2jwp02dInzf/FspkG6evMsobhzuiV4aXVZq3pG7yEixtDwAmanI
         M7bnJqt+QVsgRYUo+TPhYxD9g2OwYBWHVQP7nUnvUaY0nI/jFHcU7yu65odc8udgDA5z
         ZZvWU7wFXEQiakaes7KH2HCJFSYqymlnygIi7TqmL0i5Kqv235pc7dQuu3mEnX3WXK0i
         rUrCKKzq9yCCJAQd/LhRBDE2EFYvZ3273H5MFEiFgIKdN2FfDXfWoI3sCFX8FWLZnAhj
         dgnAjJEnOoIeUGePukT3JBAgfjSVyhm/sQPm+I906WNt20n5ddnhU8CnP7tI9w7xUDoZ
         tKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685502899; x=1688094899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGRk3qew8qHUsSqiWWEi20++QGES4qVMs5nHSf1XQ9E=;
        b=RWw0+ufm5VaQPb6+muAnTSiIPFpaHpHjfRadiJ9R7Vl6jzGgx92m3qCDoAxvl0pYbp
         KFjx3It3Ph5c57v01p9i9QEOoSDBshKVmgB7B8hKg9XDSth1UUvRE18SIQshrZme6WTZ
         Gz4unHdYBLEFpR/b3qL8GbNbNUSaFdJyyGPlE4QrCL5dNgqOoWuhZ4onpIsRvIiJG0B0
         ePl86vFAUlBmWYJ83PWMD6OVb3UkjDCnCjG7DOi/6+Vuxf1pO1kD7fY+7HF640DzBMlq
         uGzAE8DJF0qGG7s3sbf81fr/kDSktj6ok1ilNvhnXdfNP1lQoSPZAlTzGAmBfNMnUdwy
         uELg==
X-Gm-Message-State: AC+VfDyG8Dbe17Fq56z/6UQPQ2SW5lNLqVPJRoSTayiy1DTT4KI/Twe4
	UMIX1L0QyMSEGkAQka8tHViO2FKmxnq31xoT1hE=
X-Google-Smtp-Source: ACHHUZ6cHNoXUm+gLin944jeufXAM7A/c2lBHRByeZnYDs/CS+dFvuXQkTiuv6kJJW3QwrwLY9upGuMKZzoDxPzJogA=
X-Received: by 2002:a05:6214:765:b0:626:ece:5cee with SMTP id
 f5-20020a056214076500b006260ece5ceemr4635905qvz.22.1685502899475; Tue, 30 May
 2023 20:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-2-laoar.shao@gmail.com>
 <ZHSVSWph86bmJyvY@krava> <CALOAHbDTiPvawvS5xegiLVERzjh2MgmusDQFhCcfLY=wzw=oTA@mail.gmail.com>
 <20230531002858.aiyahbvwpenjsr27@MacBook-Pro-8.local>
In-Reply-To: <20230531002858.aiyahbvwpenjsr27@MacBook-Pro-8.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 May 2023 11:14:23 +0800
Message-ID: <CALOAHbBTFnme2hU-JkrRw-nuOnN3OWPWOMCZhnsuoKRw5aNedA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/8] bpf: Support ->show_fdinfo for kprobe_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 8:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 30, 2023 at 09:39:01AM +0800, Yafang Shao wrote:
> > On Mon, May 29, 2023 at 8:06=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Sun, May 28, 2023 at 02:20:20PM +0000, Yafang Shao wrote:
> > > > Currently, there is no way to check which functions are attached to=
 a
> > > > kprobe_multi link, causing confusion for users. It is important tha=
t we
> > > > provide a means to expose these functions. The expected result is a=
s follows,
> > > >
> > > > $ cat /proc/10936/fdinfo/9
> > > > pos:    0
> > > > flags:  02000000
> > > > mnt_id: 15
> > > > ino:    2094
> > > > link_type:      kprobe_multi
> > > > link_id:        2
> > > > prog_tag:       a04f5eef06a7f555
> > > > prog_id:        11
> > > > func_count:     4
> > > > func_addrs:     ffffffffaad475c0
> > > >                 ffffffffaad47600
> > > >                 ffffffffaad47640
> > > >                 ffffffffaad47680
> > >
> > > I like the idea of exposing this through the link_info syscall,
> > > but I'm bit concerned of potentially dumping thousands of addresses
> > > through fdinfo file, because I always thought of fdinfo as brief
> > > file info, but that might be just my problem ;-)
> >
> > In most cases, there are only a few addresses, and it is uncommon to
>
> I doubt you have data to prove that kprobe_multi is "few addresses in mos=
t cases",
> so please don't throw such arguments without proof.
>
> > have thousands of addresses. To handle this, what about displaying a
> > maximum of 16 addresses? For cases where the number of addresses
> > exceeds 16, we can use '...' to represent the remaining addresses.
>
> at this point the kernel can pick random 16 kernel funcs and it won't be
> much worse.
>
> Asking users to do
> $ cat /proc/10936/fdinfo/9 | grep "func_addrs" -A 4 | \
>   awk '{ if (NR =3D=3D1) {print $2} else {print $1}}' | \
>   awk '{"grep " $1 " /proc/kallsyms"| getline f; print f}'
> ffffffffaad475c0 T schedule_timeout_interruptible
> ffffffffaad47600 T schedule_timeout_killable
>
> isn't a great interface either.
>
> The proper interface through fill_link_info and bpftool is good to have,
> but fdinfo shouldn't partially duplicate it. So drop this patch and other=
s.

Sure, I will drop the ->show_fdinfo patches.

--=20
Regards
Yafang

