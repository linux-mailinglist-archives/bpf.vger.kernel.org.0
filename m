Return-Path: <bpf+bounces-9263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE44792421
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFE92812C4
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9719D537;
	Tue,  5 Sep 2023 15:49:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07E2571
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 15:49:56 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30691194;
	Tue,  5 Sep 2023 08:49:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9338e4695so40960401fa.2;
        Tue, 05 Sep 2023 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693928993; x=1694533793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKuAqItzoLB7eSN2HA584CUrTvSe8WsE0Ix1cOkpuC0=;
        b=MiIKl+u5e2y5X074CBYzcCe7DMC4K8kSJ1mVT/BWIvUqTSRqRrBLB8NSdkDsPUnDnL
         7nqmdnEURTQ/QKW3niKdKW8OuImXCIgVXIBu6A1OB7D210CSeT0GELWCP3LVdtGoxGou
         zjZxmMNypJQ6mx+UaBpVyOR+JSFkl95mISNeriEv7dCb07RI7/d8wEz4q0j8a0PEV42J
         Pp1fyr3AmZ5+6RF7OTm5CjdttjHOnLv7fJFcIjN0FKheA6IF5xPnxqtf7iKSh/itPmCW
         O5jnjSzz1vWxT8qOmoBnMF/PhrPEkocILhGWeSKGPiUKkisyp/x1bMUDdfoEJZbVr9ih
         ar2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693928993; x=1694533793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKuAqItzoLB7eSN2HA584CUrTvSe8WsE0Ix1cOkpuC0=;
        b=izars6n3Wek/bwD64vCOnBqAyGZxUwcAH4I6WYivHuuwJR/aOjMstuB34QEMdIDsw8
         oz1Da0k8O9RO4o3hf0V70zbQmWphtYIhOeRS917xssftJ9lTp9tv0J1GCRy45iPTgtIp
         VCsAk+YKz6Haa0p2tuhRFd7BtpJGwcwa8H8+fS/lnTtjP4kDc00DYc2bFVu0YJtGDfB3
         /DAF9p0dVd2l5RJ6YfJ6P1kylSk9sBKM26RUOEfZMgcQz69wa8JbxtSEwMndT+Z/U4NY
         QBsUsU5eipWpNA8C80s8kkT/t102pmdPw5zcKJ9F4sH3yDzKVXI3dKC2uJhXxwqeUKWo
         WMlw==
X-Gm-Message-State: AOJu0YwtC0SafvdueGqBkVmHyilX9/ieZnkgKCprhQtSeSq9dW5rVylT
	dLf+TB9NGZezSiJYKGkhp/XUFQQneciCwe7TyPI=
X-Google-Smtp-Source: AGHT+IEoSKDP8fbM5Emt0pizFg+Ydp00AsHV8dUXqPwrwiQN2FMLoyo8K+eOAAzc/eZnN+0XSMtrmcACkuWprwWD/c8=
X-Received: by 2002:a2e:96cd:0:b0:2bc:b46b:686b with SMTP id
 d13-20020a2e96cd000000b002bcb46b686bmr109315ljj.34.1693928993077; Tue, 05 Sep
 2023 08:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904102128.11476-1-00107082@163.com> <20230904104856.GE11802@breakpoint.cc>
 <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com> <5490ca67.552d.18a6508175f.Coremail.00107082@163.com>
In-Reply-To: <5490ca67.552d.18a6508175f.Coremail.00107082@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Sep 2023 08:49:41 -0700
Message-ID: <CAADnVQKK-xGL55aYyhv-bWRizi5Ymp75c=Qwhu4y4v8DQK1s+g@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
To: David Wang <00107082@163.com>
Cc: Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 4:11=E2=80=AFAM David Wang <00107082@163.com> wrote:
>
>
>
>
>
>
>
>
>
>
>
>
> At 2023-09-05 05:01:14, "Alexei Starovoitov" <alexei.starovoitov@gmail.co=
m> wrote:
> >On Mon, Sep 4, 2023 at 3:49=E2=80=AFAM Florian Westphal <fw@strlen.de> w=
rote:
> >>
> >> David Wang <00107082@163.com> wrote:
> >> > This sample code implements a simple ipv4
> >> > blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
> >> > which was introduced in 6.4.
> >> >
> >> > The bpf program drops package if destination ip address
> >> > hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
> >> >
> >> > The userspace code would load the bpf program,
> >> > attach it to netfilter's FORWARD/OUTPUT hook,
> >> > and then write ip patterns into the bpf map.
> >>
> >> Thanks, I think its good to have this.
> >
> >Yes, but only in selftests/bpf.
> >samples/bpf/ are not tested and bit rot heavily.
>
> Hi Alexei,
>
> I need to know whether samples/bpf is still a good place to put code.
> I will put the code in another open source project  for bpf samples,  men=
tioned by Toke.
> But I still want to put it in samples/bpf , since the code only compile/w=
ork with new kernel.
>
> Need your feedback on this,  could this code be kept in samples/bpf? :)

Sorry, but we don't accept new code to samples/bpf/.
Everything in there  will be moved/removed.
If you want to stay in the kernel selftests/bpf is the only place and
it's gotta be the real test and not just a sample.

