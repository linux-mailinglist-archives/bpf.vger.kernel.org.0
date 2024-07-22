Return-Path: <bpf+bounces-35210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D980938972
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906441F22A82
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54A38FA6;
	Mon, 22 Jul 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiwDNMDv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DED31A89
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631379; cv=none; b=XhV99bYVkd63FI0f/5Il6dZuvPj9DjJRtBuhyHla0/7lV/20YA7L/tcpyPyi1Mtz8kQ9Z/W18bpcNB7aWrGVgObcfMXw5oqxShVjQ6WPfBm6llWxR+/kfJUeHAzCHGMURRHWzblPpeo2edwBafRzKU7SmsoUlx7grRumoVfarO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631379; c=relaxed/simple;
	bh=G3URHSbf6FGeZ+XY0OOljWL6/6YoryVf7iMmS+suTH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4UNbA1TpoIIYuTVW7pBxcXJG6gNIaWMkYPuf7QSEI9VXbRCggHfXDken9U4k6vrTOy/eLF+zMaInW7NTrxutQ25Ae1N9P8fa/2RNANzg4Tf666C32gFjS4XJGRIESE7jnPELVNujcC5K+qIFT8B+nGO6zW59thXgwy9RTbfeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiwDNMDv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721631376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvUYsehnZayRqLIElwl0ruBmaZQ2mIx+T83BIjxhjLs=;
	b=MiwDNMDvFnQJ18Az/NRcm6utRYya+pjWoQZcnrX2GwQMGLykWc3eVUnr/QE5kBTWoNGNbB
	bV85OJiS0keDDZsMSVtfiGARVWJvzQOv6NEXzRNr5DBlpMyBG06XBHmD9yVypSGdtRmKyT
	koTu84hxuNijY6VfPAtz0NZug7iwZnY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-BZ06GVJpP8S9SeCHHvCMxg-1; Mon,
 22 Jul 2024 02:56:11 -0400
X-MC-Unique: BZ06GVJpP8S9SeCHHvCMxg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DFA1955BEE;
	Mon, 22 Jul 2024 06:56:09 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6642A1955D44;
	Mon, 22 Jul 2024 06:56:07 +0000 (UTC)
Date: Mon, 22 Jul 2024 08:56:04 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compilation failure when
 CONFIG_NET_FOU!=y
Message-ID: <20240722065604.GA2770066@alecto.usersys.redhat.com>
References: <20240718143122.2230780-1-asavkov@redhat.com>
 <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
 <CAADnVQKjgQg9Y=VxHL9jrkNdT6UKMbaFEOfjNFG_w_M=GgaRjQ@mail.gmail.com>
 <CAEf4BzbgeCo09sfrQVgBHJJ-=uZEEm287xXkjoLMrUkcLN6VMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbgeCo09sfrQVgBHJJ-=uZEEm287xXkjoLMrUkcLN6VMQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jul 19, 2024 at 11:44:34AM -0700, Andrii Nakryiko wrote:
> On Fri, Jul 19, 2024 at 10:09 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 19, 2024 at 8:45 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > Hi Artem,
> > >
> > > On 7/18/24 4:31 PM, Artem Savkov wrote:
> > > > Without CONFIG_NET_FOU bpf selftests are unable to build because of
> > > > missing definitions. Add ___local versions of struct bpf_fou_encap and
> > > > enum bpf_fou_encap_type to fix the issue.
> > > >
> > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > >
> > > This breaks BPF CI, ptal:
> > >
> > > https://github.com/kernel-patches/bpf/actions/runs/9999691294/job/27641198557
> > >
> > >    [...]
> > >      CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.bpf.o
> > >      CLNG-BPF [test_maps] verifier_bswap.bpf.o
> > >      CLNG-BPF [test_maps] test_core_reloc_existence.bpf.o
> > >      CLNG-BPF [test_maps] test_global_func8.bpf.o
> > >      CLNG-BPF [test_maps] verifier_bitfield_write.bpf.o
> > >      CLNG-BPF [test_maps] local_storage_bench.bpf.o
> > >      CLNG-BPF [test_maps] verifier_runtime_jit.bpf.o
> > >      CLNG-BPF [test_maps] test_pkt_access.bpf.o
> > >    progs/test_tunnel_kern.c:39:5: error: conflicting types for 'bpf_skb_set_fou_encap'
> > >       39 | int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
> > >          |     ^
> > >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:12: note: previous declaration is here
> > >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
> > >            |            ^
> > >    progs/test_tunnel_kern.c:41:5: error: conflicting types for 'bpf_skb_get_fou_encap'
> > >       41 | int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > >          |     ^
> > >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107715:12: note: previous declaration is here
> > >     107715 | extern int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap) __weak __ksym;
> > >            |            ^
> > >      CLNG-BPF [test_maps] verifier_typedef.bpf.o
> > >      CLNG-BPF [test_maps] user_ringbuf_fail.bpf.o
> > >      CLNG-BPF [test_maps] verifier_map_in_map.bpf.o
> > >    progs/test_tunnel_kern.c:782:35: error: incompatible pointer types passing 'struct bpf_fou_encap___local *' to parameter of type 'struct bpf_fou_encap *' [-Werror,-Wincompatible-pointer-types]
> > >      782 |         ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___local);
> > >          |                                          ^~~~~~
> > >    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:107714:83: note: passing argument to parameter 'encap' here
> > >     107714 | extern int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx, struct bpf_fou_encap *encap, int type) __weak __ksym;
> >
> > It's a good idea to introduce struct bpf_fou_encap___local
> > for !FOU builds, but kfunc signature needs to stay and
> > __local variable needs to be type casted to (struct bpf_fou_encap *)
> > when calling kfunc.
> 
> Given we specify
> 
> CONFIG_NET_FOU=y (not =m)
> 
> in selftests/bpf/config, do we really need to work around this? I bet
> we have a bunch of other missing types if we don't set all the
> settings as required by selftests/bpf/config.

We do have other missing types and a lot of them (not all) are fixed
the same way with ___local versions by interested parties.

-- 
 Artem


