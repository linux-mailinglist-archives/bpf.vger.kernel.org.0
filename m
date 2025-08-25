Return-Path: <bpf+bounces-66431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48036B349E9
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F261884F41
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5830AAA9;
	Mon, 25 Aug 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjRDqp1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4825949A
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145675; cv=none; b=nkp/nJgQg4nlRR579GbnFJR34/h6huP4mvxkvh0PT32qYFYj0UUx+hsQ6QS5Rp6zFlO3EA8PuNFkIRtFIN9ZsU3+FLNZJlPqlE/uqwAdKrFnqJasXjhWmDKFxIVu/81QMs6InoSDPnLrRzlJSl/Hpd1HY7K/UYjfagD/+5gdEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145675; c=relaxed/simple;
	bh=lo/FzvNSsqs5NLDyLyXIwLyuV/L8gWBXyOglEgdIKPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohEy50n6tcyqqtKakt029plwt+yufs8YHx2qcvLL+Vi78+ePIkgUgZzyqVdr42zgoCM9poJhouxCDFPDq2ZdUrJYvZpSnm57Qbg0z1OCWzi+OhWAT14W0seUvFQABaaqjQJRwJ2M/SFBvpznpDajkpVQnz5hXxJE6RamESUz9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjRDqp1F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246648f833aso17022105ad.3
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756145674; x=1756750474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAFoHyVgq2HUAD7RWWp9UDhVcM4xKJ5zbmqMMLeA/pQ=;
        b=wjRDqp1FwNFID2xLwNP1x4+4W1P8fb2eUq7Ge6dJQbQH7eSKdEbDWXBuBLY9wa4Ssn
         4urfBr9GvTjvWvpoaMeTcmw5ud79sVHXpdV+gXdAUfCGoqGv6iHDg8DGyRtnfe3u6K9E
         0E5TvvCdpTgFUrbeCxGGIL6LmuzxNRSV3no1Q1a+lH2kIUV3VBrBZJg/OdjeldjUxklt
         YXKuBa3khzNMWxdUXgRLwWzPvOlLZe0kOovjRq5JgdNFOYP8UAIyAwJrNbXiANYKch7G
         79sq/63qkwgmOk83Hy9uS+UXjJZBHVVqzhaXK/UW7y0+n70ToA5Qp0H+YR58Uhv/c/fj
         bx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145674; x=1756750474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAFoHyVgq2HUAD7RWWp9UDhVcM4xKJ5zbmqMMLeA/pQ=;
        b=c0wokngPqVm0syDcZb3Fpd1M1iAYT3IanZgTMiz0Fkqv0r3Gsmj01+EsrDPBXarYzx
         n/Mn7KIS3QtKZA7ntUFRCVl0pgNSLl3LZsao0aCu+h1yWlKVlw6WMRrCM7YF5YuIFjTb
         LucDjd4GmJTFgKZ/BOSicP0Sc52WLqmPpL7rgiGt8CxEqkMZjcpHGMFMpFFb7hQowNC8
         4uHuzqrGACe2f2B6Bp43oG2ZFFI7bxrGjkbVW/bx1bLRbwWbCk6bhLFBXJ+nbN/QzOrA
         0wxPA/s/4S1FXZetBCzcOqiyu1VihNKKmeFYfhEQSeboKjP9t7OW2LLc/rNcE7QKB+gt
         cydg==
X-Forwarded-Encrypted: i=1; AJvYcCVTFmPe8Li6PU6H0MP1QIqNREZ9qVQxueFRe7TsVS8bLF6OVluedplZFSES6YfbYEMZg0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCdSJaxhlhW/8zeVrnAAR2ThzoNX/MWqGHEngSQ6aaAj24qiH
	wS2/LCccm16sugETzM7fzSl3RKhPKEFqrn9m2K9IFSI23GDwnnivA/l/MgdfxN55ZFrxfs4cPyJ
	61TPfZqiSEYisK8O67D/7X6210jl0Q68l5+wAuZ5d
X-Gm-Gg: ASbGncstbNmoaZMMK9XF/EGW7kQGCNB4Rp7vjyL5E1aXXZuMHf5VRmZgA8PKBOf8gFc
	uJ3fwxc8ktDLf2t0y7kGkUyxfZ6ZV67DUIzVo78cSaldN9ncvytsB/MOCTtSpyADLsQ62xTV54B
	r7ymsi6gG4E/oGdAuKsB2MfMEefEAYiIE7RumGIXRJjh8DONwGnUmCbbgmo1W73kR0V86WmxZh+
	LwQNCYXA4Hl527sk8+5yjBp68SRyRww24mD59DjvnwQXwOibeVEZw7Hct7Xt2wVJL8GRNc846Uq
	MqZdQ8nJZg==
X-Google-Smtp-Source: AGHT+IHPu68CwRCjZ41894GQEu6BBpcEd8YLYguot9ikozfDjHlSNI8+epIUq6PnyLRDG8S4OWQKVU/inq6FDLD3d5o=
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id
 d9443c01a7336-2462ee02b9bmr163107475ad.15.1756145673571; Mon, 25 Aug 2025
 11:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com> <20250822221846.744252-3-kuniyu@google.com>
 <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
In-Reply-To: <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 11:14:22 -0700
X-Gm-Features: Ac12FXya6QTDIvmjcvPKpIwhAGAC-AYrfstj6UjLLP9c1VkVfILW5kwD5Dbn1VQ
Message-ID: <CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_SQ7d28xXSvA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index ae83ecda3983..ab613abdfaa4 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct sock=
et *newsock, struct sock *new
> >               kmem_cache_charge(newsk, gfp);
> >       }
> >
> > +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
> > +
> >       if (mem_cgroup_sk_enabled(newsk)) {
> >               int amt;
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 233de8677382..80df246d4741 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
> >       BPF_NETKIT_PEER,
> >       BPF_TRACE_KPROBE_SESSION,
> >       BPF_TRACE_UPROBE_SESSION,
> > +     BPF_CGROUP_INET_SOCK_ACCEPT,
>
> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit be
> inherited from the listener?

Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
accept() because the child socket could be created during irq context with
unrelated cgroup.  This had another reason; if the listener was created in =
the
root cgroup and passed to a process under cgroup, child sockets would never
have sk_memcg if sk_memcg was inherited.

So, the child's memcg is not always the same one with the listener's, and
we cannot rely on the listener's sk_memcg.

