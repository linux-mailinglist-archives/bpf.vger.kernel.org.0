Return-Path: <bpf+bounces-67643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C3B46643
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288D07B2DB1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1E2F3604;
	Fri,  5 Sep 2025 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIhrS3up"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE27FB37
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109410; cv=none; b=bODMbu/5yeL+QoW2Ej7wCpo/YcLh4kkaN8eUw2iIA07wCqDZUW2brCPI25VIS0HMhaXFZAfmOu4ZuP2ilaGo9dENtZaioMb2+03EPDoQByNkCgImPb9Qjr1UJ28JaCZgZ8pMQkhus87Okm74HO82VTAexoOOz7XvKrle+NvyUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109410; c=relaxed/simple;
	bh=K4rPEUhgDOci25ECMoMn91PK5HGu+UvUImo0Jrj/eTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URwIytBI5vfwQpTKtrj2voHFxnKrDv1HflllFwYx4X+CPR8HQxi5InICqI53RkAAeNw51MQ5WqiSijue+RbfSVrTn+QWZyA8DP2M3bn5Ph296QRG6MCa5Su6JmdXZJ+G+xIxJSY2OZ253LMX7JH5mjxvlV3ojszAxcWCSqwxIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIhrS3up; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso238801a91.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757109409; x=1757714209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4rPEUhgDOci25ECMoMn91PK5HGu+UvUImo0Jrj/eTg=;
        b=rIhrS3upf8VLji/Ff6dAZ7B9GVFGK+8v7KfuQ9zBdrmSo/WROcS3MP+HlfZlRck6p5
         P/cW40O4jrNDjF6FQ7ak2vqD+rJ6sFtkj4YYuIb3p5MYVwYKDVJjDr9vaUx5GMwjZ4WS
         REmoEBCFEhFEceelpidwScH7kWxo03x6E11Y4KhNRdVBYcxQ0mn8iZxrpy1uXaqvGrAN
         jlBFBuj73yh9Mwy5//ObAmiccRUcyrm9o6heNZ24jZ46wuIbuCH8BGvI8Rcbdx0DhUDD
         q8BIdaCWogiWTPncLT/JMtt/QVHLLkvITqNfCQczXCH56rtoIDHWdwOvAAm+zyqsoXMW
         imnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757109409; x=1757714209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4rPEUhgDOci25ECMoMn91PK5HGu+UvUImo0Jrj/eTg=;
        b=Gk4Tigq7jm7woZ0d01/TyCuIPIeENCWlFr4YdUZhbXPB+uifMF+jQpXDoMddCEC2RT
         CNefJX58dfMAETBE6/PkQ9ckoihCpDujjKT68Uo+1sgDlNmBk0VoollZjrXkWIUNRUTW
         MkQ57WmySh0vIWkpCbeuSNxKvEynSaVdLcyVLXD5LVH4QreWNdBorvkDznjfPexvsnAk
         lIC31Deo3U4EdEE6HnyfT/PvszTOnv1cv20Q6ZJM36+rfEMDKkS8lBCe7DghH1qAjHy/
         PUed6YBk4bIWR56e9weQhDdNGSonS6/9aob+21ThwVmFnviRhKW42jWr6Nh2Entv7D8h
         uclQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpa//u4zm2bJoMJk0eQUsVXlySL88gq2rurTN5jfrTxQOiUcB/+WDi1ufmzq/6kBzo06M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxH8CQxiD2hH8IdRmVKgCssEhoHJdLkdkIhm2a+D6SrWdsrOB7
	pdxoNXPcVTe1FMHHAKJzdyXy+Q4cva3k2h/pdIYAEbjZJn13yeVEvmB3ayBs8ZLU46xSPVYe4tj
	cynYcWoFvuwfFRIFtX/3dFLKtL9SgqFI+1AsRAhWv
X-Gm-Gg: ASbGnct8Goz/FfONtf5wF5e1T6cTFlLRPukU3Wt4lanhKSrc+SUNdZMHPV18nvEfDef
	DPFa4vLB0x9SQumU8xB//KiGej2gdEPz/hhaefF/3CaJsgp1/Ue6qwuRWx17LQBkKhmMyOsYu1o
	dRhuN3gbKhkqEgloC6QmC2Az4fcGyS3QghgoomZwCuFWrsAfmEDQEwnF3Md3K8trEVWQn2vtHMb
	Nmis2f2s0WMFs8TERpukvTiz8hoKrI4bklHmwnjxRQrs+RTJR34JwFBV78Mf1cIQeFVj3ZUy8vy
	05DckrpUyE2feQ==
X-Google-Smtp-Source: AGHT+IHee2bfwNAMC7Lf9gLv17bkMAwutCH+4xPIrizmqEN9SW0fuoijafwHuVi6n2B6Nt9NE9ZR8AeiczyOlODnHb0=
X-Received: by 2002:a17:90b:38cb:b0:32b:df0e:928f with SMTP id
 98e67ed59e1d1-32d43f936ccmr452341a91.37.1757109408411; Fri, 05 Sep 2025
 14:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com> <20250903190238.2511885-5-kuniyu@google.com>
 <20250904063456.GB2144@cmpxchg.org> <CAAVpQUA+rVJKMXQFATfxT=uX3QaLrCtCG_wtiGF_kt-_KrMRBQ@mail.gmail.com>
 <sathtxzxvi5zz5gh37twfng7srn7nsdlrdlposompqkq646pp5@2r74fqgbalzq>
In-Reply-To: <sathtxzxvi5zz5gh37twfng7srn7nsdlrdlposompqkq646pp5@2r74fqgbalzq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 5 Sep 2025 14:56:36 -0700
X-Gm-Features: Ac12FXx_Dq7bkvb-v_DTHwN8EXWrX7E_LQJFMN4E-0VuPARl91jQFUntqLLHeXc
Message-ID: <CAAVpQUDjNfU-fqhh4nfPPo1kg0LPcBRbU3ob22k8WtPU_BouZw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Thu, Sep 04, 2025 at 01:21:47PM -0700, Kuniyuki Iwashima wrote:
> > On Wed, Sep 3, 2025 at 11:35=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> > > > If all workloads were guaranteed to be controlled under memcg, the =
issue
> > > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > > >
> > > > In reality, this assumption does not always hold, and processes not
> > > > controlled by memcg lose the seatbelt and can consume memory up to
> > > > the global limit, becoming noisy neighbour.
> > >
> > > It's been repeatedly pointed out to you that this container
> > > configuration is not, and cannot be, supported. Processes not
> > > controlled by memcg have many avenues to become noisy neighbors in a
> > > multi-tenant system.
> > >
> > > So my NAK still applies. Please carry this forward in all future patc=
h
> > > submissions even if your implementation changes.
> >
> > I see.
> >
> > I'm waiting for Shakeel's response as he agreed on decoupling
> > memcg and tcp_mem and suggested the bpf approach.
>
> Yes I agreed on decoupling memcg and tcp_mem but not for a weird
> configuration, so please stop using this motivatioan already. You can
> motivate the decoupling simply on performance. Why pay the cost
> of two orthogonal accounting mechanisms concurrently? Also you are not
> disabling memcg accounting, so we should be good from memcg side. Make
> this very clear in your commit message.
>
> I don't care how you plan to use this feature to enable your weird
> use-case but make sure this feature is beneficial to general Linux
> users.

Thank you Shakeel, I will rephrase the commit messages and
clarify the points above.

