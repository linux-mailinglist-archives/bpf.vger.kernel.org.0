Return-Path: <bpf+bounces-38005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629195DA77
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A027B215D4
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE55179AA;
	Sat, 24 Aug 2024 02:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0038F6C;
	Sat, 24 Aug 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465049; cv=none; b=TEos2uEk5SAdaVMl4EkL58vr2i7DZjc+CvwbFsvpQQjmA1B+hSR3Rj6dyYCSunqHsf2BHjI3opGns4h/WkKbF3CgwO3AQy79/J4XTbNpRXOlvaPfEjcmCYHpJkteiOiqzIaEwf96EGIHTFTSyB3dZt9a3ddQEaAQTQbcnwC1fIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465049; c=relaxed/simple;
	bh=hQUNzjSY7i3l4ldL5C3hNfqZ/vaZV6AK/8n/d+E3nsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVpUc9J1dzOMCn4A1EWLUg3vTMKm7TVw5H28/xhiL3UcTCs034P4JXi093+LJTr+N/mNGuu593v26B/IQXjHj4EuXU/P+xoqTqwuMM+FaGs1galfIjo9awdTWefkmRYqAMJqR2mM7LNPgfOGVdg8DIR+CnvW4jdvaWebALmyVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71456acebe8so212933b3a.3;
        Fri, 23 Aug 2024 19:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465046; x=1725069846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1m+RyyeVq2vKKoA8+4isEUsNBf+vWhzfSvt6LSdw9/k=;
        b=HSgmx+SZTBd4FFdLXAIhMwndSLYTvug/S5T7XZN5A++XqvGD9s78gDUPwZ+Zi8bfpn
         OdTiqVaz6IX9lZc+9bE9WI3ern3h+5NekQAJoaSOWI/thVSsg7LBXMB4bjgYlFO4dMWl
         ne/uPPpoNStsqxVrWNUcQfB2LuySvaDZ8AZaeJ1VgumBkeUXyABP8nf+DnG47KiNFcLL
         gdpOlGtWNLdlStvkwTKi1vWcRnaPIskUk8PtzTwXXJpjFEQbkdgLa0XGOT9kM7YToRug
         54UuBOB9bBRWtdz/oDnNn7nLeswX8o2uRu9pI+la10oCSbvK7StTyxR4ZSrHKslptpnl
         SVlw==
X-Forwarded-Encrypted: i=1; AJvYcCU74MvjrhFfOFm+anFHtkLzogG2PRJZ5ytYVMvU55my3AUyI1BmUfFCZR9pqg/Bj1AG4zk=@vger.kernel.org, AJvYcCUZ5u8LXP3Aihg0WWCKF4pwaSjaw9Bv1sM96VRQEDQKAmBSfTyNWiZ5RFxz8BVd6ogHG7jxFiC9@vger.kernel.org, AJvYcCXOZSnWISKJXIx0GVPT1WOwafgJXcmL+PMJvQJTEA3E4MaZrUJJs2kmU4xi+ENThkWjtsp9dn7PvT7dPvA2@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMFrYFmSc7fVjjJS+rwLaty2d8sbbBKWqCkieWIi9aiipadDD
	NLSIBOuBDBT4Be3hFhmdkX74nj5zFFzBUKZJqdYDq0gsUqOgqmIE79oMW3Y=
X-Google-Smtp-Source: AGHT+IHIZyeBM3Hl85jWwMdJX+SUb22b92N+zGjq37DFSit0JMCfEm3aWfiRw4k5sOQm4Tu/80NwxQ==
X-Received: by 2002:a05:6a00:124c:b0:706:61d5:2792 with SMTP id d2e1a72fcca58-7144579d85amr5466242b3a.8.1724465046198;
        Fri, 23 Aug 2024 19:04:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdcf7dsm3351501a12.50.2024.08.23.19.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:04:05 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:04:04 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tze-nan Wu =?utf-8?B?KOWQs+a+pOWNlyk=?= <Tze-nan.Wu@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ast@kernel.org" <ast@kernel.org>,
	Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"song@kernel.org" <song@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Yanghui Li =?utf-8?B?KOadjumYs+i+iSk=?= <Yanghui.Li@mediatek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"haoluo@google.com" <haoluo@google.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Message-ID: <Zsk_lGsZBBqbesqS@mini-arch>
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
 <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com>
 <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
 <CAADnVQLvbMRvCg2disV+_AR-154BwRpeB8Zg_8YpO=7gzL=Trg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvbMRvCg2disV+_AR-154BwRpeB8Zg_8YpO=7gzL=Trg@mail.gmail.com>

On 08/22, Alexei Starovoitov wrote:
> On Thu, Aug 22, 2024 at 12:02 AM Tze-nan Wu (吳澤南)
> <Tze-nan.Wu@mediatek.com> wrote:
> >
> >
> > BTW, If this should be handled in kernel, modification shown below
> > could fix the issue without breaking the "static_branch" usage in both
> > macros:
> >
> >
> > +++ /include/linux/bpf-cgroup.h:
> >     -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)
> >     +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, compat)
> >      ({
> >             int __ret = 0;
> >             if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))
> >                 copy_from_sockptr(&__ret, optlen, sizeof(int));
> >      +      else
> >      +          *compat = true;
> >             __ret;
> >      })
> >
> >     #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname,
> > optval, optlen, max_optlen, retval)
> >      ({
> >          int __ret = retval;
> >     -    if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&
> >     -        cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
> >     +    if (cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
> >              if (!(sock)->sk_prot->bpf_bypass_getsockopt ||
> >                ...
> >
> >   +++ /net/socket.c:
> >     int do_sock_getsockopt(struct socket *sock, bool compat, int level,
> >      {
> >         ...
> >         ...
> >     +     /* The meaning of `compat` variable could be changed here
> >     +      * to indicate if cgroup_bpf_enabled(CGROUP_SOCK_OPS) is
> > false.
> >     +      */
> >         if (!compat)
> >     -       max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> >     +       max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen,
> > &compat);
> 
> This is better, but it's still quite a hack. Let's not override it.
> We can have another bool, but the question:
> do we really need BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN  ?
> copy_from_sockptr(&__ret, optlen, sizeof(int));
> should be fast enough to do it unconditionally.
> What are we saving here?
> 
> Stan ?

Agreed, most likely nobody would notice :-)

