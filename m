Return-Path: <bpf+bounces-63041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D0B01A36
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19CF18970FE
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCB28A1C2;
	Fri, 11 Jul 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgdkm2i0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49803146585
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231469; cv=none; b=DhshGWeGophlpLZ85n9Xx2j7BDHwOyzGW6anGt7PUQbI+T8od9rzDQdillgeTs4um42lyww7SANDF1KE64B8pVMeUYlz4oEn8+pOdhx9zsHhY/tue+iZDwYH/uGDUjFL19BhveRChe958XX/B5o1hb4G1+3ASVcWSPuzX0ZST+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231469; c=relaxed/simple;
	bh=ywNictxKi62TJU8f5tFEq1MfRO6HjYg4Tt90uOYAqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT/zQtypk6Br9iZYD54RbGxOByoZ2bKecl2j8n6sEN0c+N2eDFLCVjImrhxGUwC0PkI+6gd+HDKozMCRs2bg5yZjwLi6tnB+yQM+iX7mJh4gMcdTfEIPPzH0XDK0pfPrdvzLNQHHw9jWx689Etuz6S1gSxSNUuEWxTYPgupghYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgdkm2i0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso20388495e9.3
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752231465; x=1752836265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kza3lbB0YTcalJYFxIfwh1FwdXyYLoSglQE6w0vuj6w=;
        b=Jgdkm2i09P/UkPWdV5nfHmHo8lfGpw7MPDVTKIvzIoRnLL+VYrfL9wmK2+IDjpBUjS
         kpaIwSo+ATOuVjuPCYiP8463c0U+stByHkcsuyKJx7UkrvLzXqIrrJnP8Et4s4Qu/4lN
         rEc9DmsflTumkBHLE4/lNFLWKL6Da5zdpVuEuR4BDh18YUqVbq+Ynl0YFNmAWkdkC6o0
         XqpvVi0CzVhSOg5RpkKg8/W+TMNsEgB135BwLgiN/ilcalHGoKVGDCxdmkfEZoQ0pEOR
         fF2HHtyCAa3U7D2BXWJXevDeuUHvR/cXGEJxMEHOUUb9iPEoDh6O8gHfncrzgqwJPE0J
         5Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231465; x=1752836265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kza3lbB0YTcalJYFxIfwh1FwdXyYLoSglQE6w0vuj6w=;
        b=Uoaaf9ldVWrAO43H3mZuGF/OVPnU6rWacNjj1+6RlQ9BX9fqEl/lS6WwqgaZNqCS+9
         1BTTyeRP2gQp5wjUMn0fs+GHlToDAovuSZHrNt7tnuMR8OJKdOYmmBGqciyDvk+iAZkx
         SfgrK2v+4fgUslP+nRhZT+2H4sZ8LNLDCbwNpMC1U7vQmolnpGrAWpWt9ChSonn2fKMS
         whwvuW7ieWFGFUArBwAiAiFjr8tBCEhJZS545JkqwFnGbY+pV7OwGEfpDi01K4t89fe0
         gjqnq2Tqmn/EWTLGoy25EGu56FTfOtMt6nnTapjMCqgdjXh2iNkmrpxkhT52xgQ8o5df
         CCFg==
X-Gm-Message-State: AOJu0YwqaUlJH98DKAju/Aaaht59gpoJCqAWAHc542iOmhdiEv3I78qL
	RDiuyvE7l4gsvOwKpY8+aq+DtgnJvIb0ZfhNQY7hYQlIWFVevnDKeO5dqIpF53o9Rgk=
X-Gm-Gg: ASbGncsp4tONDd2FhL5F04Ey1s4beUBOVkT3cY7nnTUXpVlQpITEZLDK5n39CnaOrEf
	sBaPXiVMPThcGTXv2c0uef5gMhFrfi8tAL46Nj/LHYxIlsrufp/xKTlXzwHuFOoBgzuP6NueWAN
	gn+o4AxHK9sFXR7NrcFuijiM1KtVf1pemUYFfhjPqE78BzHehRDhqlNgwF8eUEDjs+uT3ll0MZN
	EM1q6vmLJG/nVAorD7KF2WouWKRd2Kzrx24XDNzI8w1IPmRj+tpWZG+V11PD2eKzCk9muYg2AZ8
	qCFtHQ0V+QNaHBGE6F+qjy9e13w+URPNo0xUfXN9/7QmuI0jCLvk3rvbruZ/RKd0PAeyTp6zkeH
	g+NzxvhcXiynCzzpfzqjtM+t5ySBkmtviak1fl2Vxfkq0mJcjgtqh/wo=
X-Google-Smtp-Source: AGHT+IGNRJ53DqNdDXYK7hcJGMtb1LMGQQZDqA5D8m98w4KPaF56dXFmV5g+anlP4y+lQXATvQJi0A==
X-Received: by 2002:a05:600c:8b35:b0:442:ff8e:11ac with SMTP id 5b1f17b1804b1-454ec165297mr26119845e9.12.1752231465291;
        Fri, 11 Jul 2025 03:57:45 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50511dfsm84213835e9.12.2025.07.11.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:57:44 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:57:43 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: add bpf_icmp_send_unreach
 cgroup_skb kfunc
Message-ID: <aHDuJ5rNeMTnUSju@gmail.com>
References: <20250710102607.12413-1-mahe.tardy@gmail.com>
 <20250710102607.12413-4-mahe.tardy@gmail.com>
 <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>

On Thu, Jul 10, 2025 at 09:07:59AM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 3:26 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > This is needed in the context of Tetragon to provide improved feedback
> > (in contrast to just dropping packets) to east-west traffic when blocked
> > by policies using cgroup_skb programs.
> >
> > This reuse concepts from netfilter reject target codepath with the
> > differences that:
> > * Packets are cloned since the BPF user can still return SK_PASS from
> >   the cgroup_skb progs and the current skb need to stay untouched
> >   (cgroup_skb hooks only allow read-only skb payload).
> > * Since cgroup_skb programs are called late in the stack, checksums do
> >   not need to be computed or verified, and IPv4 fragmentation does not
> >   need to be checked (ip_local_deliver should take care of that
> >   earlier).
> >
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  net/core/filter.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index ab456bf1056e..9215f79e7690 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -85,6 +85,8 @@
> >  #include <linux/un.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/inet_dscp.h>
> > +#include <linux/icmp.h>
> > +#include <net/icmp.h>
> >
> >  #include "dev.h"
> >
> > @@ -12140,6 +12142,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
> >         return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
> > +{
> > +       struct sk_buff *skb = (struct sk_buff *)__skb;
> > +       struct sk_buff *nskb;
> > +
> > +       switch (skb->protocol) {
> > +       case htons(ETH_P_IP):
> > +               if (code < 0 || code > NR_ICMP_UNREACH)
> > +                       return -EINVAL;
> > +
> > +               nskb = skb_clone(skb, GFP_ATOMIC);
> > +               if (!nskb)
> > +                       return -ENOMEM;
> > +
> > +               if (ip_route_reply_fetch_dst(nskb) < 0) {
> > +                       kfree_skb(nskb);
> > +                       return -EHOSTUNREACH;
> > +               }
> > +
> > +               icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
> > +               kfree_skb(nskb);
> > +               break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +       case htons(ETH_P_IPV6):
> > +               if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +                       return -EINVAL;
> > +
> > +               nskb = skb_clone(skb, GFP_ATOMIC);
> > +               if (!nskb)
> > +                       return -ENOMEM;
> > +
> > +               if (ip6_route_reply_fetch_dst(nskb) < 0) {
> > +                       kfree_skb(nskb);
> > +                       return -EHOSTUNREACH;
> > +               }
> > +
> > +               icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
> > +               kfree_skb(nskb);
> > +               break;
> > +#endif
> > +       default:
> > +               return -EPROTONOSUPPORT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > @@ -12177,6 +12226,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> >  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> >  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> >
> > +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send_unreach)
> > +BTF_ID_FLAGS(func, bpf_icmp_send_unreach, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send_unreach)
> > +
> >  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
> >         .owner = THIS_MODULE,
> >         .set = &bpf_kfunc_check_set_skb,
> > @@ -12202,6 +12255,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
> >         .set = &bpf_kfunc_check_set_sock_ops,
> >  };
> >
> > +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send_unreach = {
> > +       .owner = THIS_MODULE,
> > +       .set = &bpf_kfunc_check_set_icmp_send_unreach,
> > +};
> > +
> >  static int __init bpf_kfunc_init(void)
> >  {
> >         int ret;
> > @@ -12221,7 +12279,8 @@ static int __init bpf_kfunc_init(void)
> >         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> >                                                &bpf_kfunc_set_sock_addr);
> >         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > -       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
> > +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
> > +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send_unreach);
> 
> Does it have to be restricted to BPF_PROG_TYPE_CGROUP_SKB ?
> Can it be a part of bpf_kfunc_set_skb[] and used more generally ?

From the assumptions that have been made to write the kfunc in this
state yes, it has to be restricted to cgroup_skb. We would need
additional checks for hooks that are earlier in the stack I think.

Keeping in mind that this kfunc is not a necessity for other prog types
which can already overwrite packets, like TC.
 
> If restriction is necessary then I guess we can live with extra
> bpf_kfunc_set_icmp_send_unreach, though it's odd to create a set
> just for one kfunc.
> Either way don't change the last 'return ...' line in this file.
> Add 'ret = ret ?: register...' instead to reduce churn.
> 
> Also cc netdev and netfilter maintainers in v2.

Yes to both.

Aside, could I have your opinion on this part of the cover letter before
I proceed to fix these patches:

> Other design ideas (to prevent above issues) could be:
> * Extend the return codes for the cgroup_skb program to trigger the
>  reject after completion (SK_REJECT).
> * Adding a kfunc to set the kernel to send an ICMP_HOST_UNREACH control
>  message with appropriate code when the cgroup_skb program eventually
>  terminates with SK_DROP.
> 
> We should bear in mind that we want to extend this with TCP reset next.
> Please tell me what's your opinion on above ideas: if adding new return
> codes could be considered and/or the other alternatives would be better
> than this patch series and thus proposed instead.

These two ideas would make it more natural for cgroup_skb progs but
would prevent someone to extend it to more prog types in the future.


