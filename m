Return-Path: <bpf+bounces-45693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D59DA326
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 08:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7E0284CE8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237EF153BE8;
	Wed, 27 Nov 2024 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiHwVcvK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1E14F102;
	Wed, 27 Nov 2024 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692869; cv=none; b=EmAQSPkRkYbNGFczTMxE93S14FjK6JYZg9hhwlR7fLfhlPyxDWUA6V/vvE6P33ijoaNxcWGkQ7jpBXAekkne8QYP0NaamKkVxWXApXdK/UabOHOS7ftJ5PaoUTej/aM7kmpkSAsgWEsePhF1tVM7dP388J6yOYpeEloAs657OnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692869; c=relaxed/simple;
	bh=4WO2JdXA2564p2SZr8+iXkDfVAsxsKAbuhj/98J0eJI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V+kgBlaWUz3erhan/rnlWFGSBp08eKLbY0TNna1Fu6AP68r1kqbNXjcYKfuxUBVZeCikvVYhaqn1oBJRWJwgf06yHa7un64sIykHDvNs84GDF7kh9CvYYmhe3B0O+edJNh4A3wXqoGLgkPkEBjtvsO7WEphX8R0+hDZZvDcLE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiHwVcvK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso5113099a91.0;
        Tue, 26 Nov 2024 23:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732692867; x=1733297667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLhtbTcEA7lxOzC9Mcl9ifDLK0DyGtZjy01VuSanglg=;
        b=FiHwVcvKmqOsW4y1Utvack7oWpd4u26g7v/dCMg2YTwcXpUxRlT06DrPFE3kH3m2Lw
         SoppJx8JRM53/qq9iNY7HM4G6gbSNi9t3TDJ1kUXIKKlQivVZ0cMdDaoKgCPx21qU6y+
         Xh/fFrgN65fpGSgc8ZpfZDmKIiaHREVRxLJEPReOtWaJjloTchvh6oT9VuzGeGGIU74C
         rai4CzVgNzupXGav/XLBwiXDGP+aWiIPfvSUpElywYqQ95bRwB42F3B7QCvwuojW0WJm
         RvbyE7KSkDexzDQ3COmKaheU7n0AJSd9aKh4foRT6cs6NL66yQouHHo8YghhBufyz/fc
         sXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692867; x=1733297667;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uLhtbTcEA7lxOzC9Mcl9ifDLK0DyGtZjy01VuSanglg=;
        b=Be2a0M/ccytFgM0SkmDpGFEm5gf1aqBZtq+NCEUEKhm7eNMtYy3EcG8ZolY98Apfc3
         KsvH3tu8iaftvc+8SyPaRD+ZwWYUHpp/98yEdnVVeJSgwH0xA4CYgawTNip+J98r72Sh
         5xg9cLR0nMo9pqeJOraPh5bn/X2QOFIyUO4SUiWTdPhV+PGZwYwW4RuYuf/fSOKsOUKs
         Sd9R3tvLS+eenWHoDjAKamef51pdYAtOJbRyUDbRV0vcCCJWNJ/B0MWJ/b/BiK3DtIN2
         0U1NGGYCyqWmcsh+HwBOVRSbNXZTMTzTdDBYGskt5+61/NLQWW8tYBFBECSOwhfZhgSC
         v7YA==
X-Forwarded-Encrypted: i=1; AJvYcCUAuX4ah0DDTNBwQ5HijoK7sCZHfKIWDYHoX7iIlLVgBgGV17SjDD36J6fBI3zrClK9CdfQFT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqv6HSHTYsIzu+OR4Aj3s3kNHoM4zBgFLkYkwtp6leiVux06wS
	4Z218QrdrEac8f6L5SkKmYmRh9vNUrgxG4OJX0fQOul44RnoLY4ggcg+9A==
X-Gm-Gg: ASbGncsA5noJyc05JkwJozo6OB7y4gCO6krtgV7cojiRpaH03zubtKg/GTTSoDeYSY3
	1ugYAwSt38AfBLdL2nSCDLmoyjVJF9XD1xCuuV3VR2fdsnyiBYjHN4G6vHs216sab/mjZoZa7d8
	cAVTevIOzDZ5L1+DbCVcj3hClQ+whEh/5VOxrJvFqNuiLOIkmZ4RezeSMRffT/Pdf6JO3Dj90Ns
	9OivXDBKYDA3uFxJKzJSEJBSTF0kGxpSAgO4335aHPiOJ99A3g=
X-Google-Smtp-Source: AGHT+IEsnSzmDH4Rd5E/576eqAaqH5g5sLVhF6VkNsoCtYvu9MgO+J2ldear+DY1YxIFrsHiZzWTFg==
X-Received: by 2002:a17:90b:1a8e:b0:2ea:4290:7274 with SMTP id 98e67ed59e1d1-2ee08e9fe02mr2806521a91.10.1732692867158;
        Tue, 26 Nov 2024 23:34:27 -0800 (PST)
Received: from localhost ([98.97.45.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa30fcesm806046a91.8.2024.11.26.23.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:34:26 -0800 (PST)
Date: Tue, 26 Nov 2024 23:34:25 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6746cb81870d7_f422208e@john.notmuch>
In-Reply-To: <67a0fb14-f791-4499-8751-01bbbd1cafcb@bytedance.com>
References: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
 <20241107034141.250815-2-xiyou.wangcong@gmail.com>
 <67a0fb14-f791-4499-8751-01bbbd1cafcb@bytedance.com>
Subject: Re: [External] [Patch bpf 2/2] selftests/bpf: Add a BPF selftest for
 bpf_skb_change_tail()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zijian Zhang wrote:
> On 11/6/24 7:41 PM, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > As requested by Daniel, we need to add a selftest to cover
> > bpf_skb_change_tail() cases in skb_verdict. Here we test trimming,
> > growing and error cases, and validate its expected return values.
> > 
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Zijian Zhang <zijianzhang@bytedance.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
> >   .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 +++++++++++++++++++
> >   .../bpf/progs/test_sockmap_change_tail.c      | 40 +++++++++++++++
> >   2 files changed, 91 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > index 82bfb266741c..fe735fced836 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > @@ -12,6 +12,7 @@
> >   #include "test_sockmap_progs_query.skel.h"
> >   #include "test_sockmap_pass_prog.skel.h"
> >   #include "test_sockmap_drop_prog.skel.h"
> > +#include "test_sockmap_change_tail.skel.h"
> >   #include "bpf_iter_sockmap.skel.h"
> >   
> >   #include "sockmap_helpers.h"
> > @@ -562,6 +563,54 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
> >   		test_sockmap_drop_prog__destroy(drop);
> >   }
> >   
> > +static void test_sockmap_skb_verdict_change_tail(void)
> > +{
> > +	struct test_sockmap_change_tail *skel;
> > +	int err, map, verdict;
> > +	int c1, p1, sent, recvd;
> > +	int zero = 0;
> > +	char b[3];
> > +
> > +	skel = test_sockmap_change_tail__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +		return;
> > +	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
> > +	map = bpf_map__fd(skel->maps.sock_map_rx);
> > +
> > +	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
> > +	if (!ASSERT_OK(err, "bpf_prog_attach"))
> > +		goto out;
> > +	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
> > +	if (!ASSERT_OK(err, "create_pair()"))
> > +		goto out;
> > +	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> > +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> > +		goto out_close;
> > +	sent = xsend(p1, "Tr", 2, 0);
> > +	ASSERT_EQ(sent, 2, "xsend(p1)");
> > +	recvd = recv(c1, b, 2, 0);
> > +	ASSERT_EQ(recvd, 1, "recv(c1)");
> > +	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
> > +
> > +	sent = xsend(p1, "G", 1, 0);
> > +	ASSERT_EQ(sent, 1, "xsend(p1)");
> > +	recvd = recv(c1, b, 2, 0);
> > +	ASSERT_EQ(recvd, 2, "recv(c1)");
> > +	ASSERT_EQ(skel->data->change_tail_ret, 0, "change_tail_ret");
> > +
> > +	sent = xsend(p1, "E", 1, 0);
> > +	ASSERT_EQ(sent, 1, "xsend(p1)");
> > +	recvd = recv(c1, b, 1, 0);
> > +	ASSERT_EQ(recvd, 1, "recv(c1)");
> > +	ASSERT_EQ(skel->data->change_tail_ret, -EINVAL, "change_tail_ret");
> > +
> > +out_close:
> > +	close(c1);
> > +	close(p1);
> > +out:
> > +	test_sockmap_change_tail__destroy(skel);
> > +}
> > +
> >   static void test_sockmap_skb_verdict_peek_helper(int map)
> >   {
> >   	int err, c1, p1, zero = 0, sent, recvd, avail;
> > @@ -927,6 +976,8 @@ void test_sockmap_basic(void)
> >   		test_sockmap_skb_verdict_fionread(true);
> >   	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
> >   		test_sockmap_skb_verdict_fionread(false);
> > +	if (test__start_subtest("sockmap skb_verdict change tail"))
> > +		test_sockmap_skb_verdict_change_tail();
> >   	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
> >   		test_sockmap_skb_verdict_peek();
> >   	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
> > diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> > new file mode 100644
> > index 000000000000..2796dd8545eb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 ByteDance */
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> > +	__uint(max_entries, 1);
> > +	__type(key, int);
> > +	__type(value, int);
> > +} sock_map_rx SEC(".maps");
> > +
> > +long change_tail_ret = 1;
> > +
> > +SEC("sk_skb")
> > +int prog_skb_verdict(struct __sk_buff *skb)
> > +{
> > +	char *data, *data_end;
> > +
> > +	bpf_skb_pull_data(skb, 1);
> > +	data = (char *)(unsigned long)skb->data;
> > +	data_end = (char *)(unsigned long)skb->data_end;
> > +
> > +	if (data + 1 > data_end)
> > +		return SK_PASS;
> > +
> > +	if (data[0] == 'T') { /* Trim the packet */
> > +		change_tail_ret = bpf_skb_change_tail(skb, skb->len - 1, 0);
> > +		return SK_PASS;
> > +	} else if (data[0] == 'G') { /* Grow the packet */
> > +		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
> > +		return SK_PASS;
> > +	} else if (data[0] == 'E') { /* Error */
> > +		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
> > +		return SK_PASS;
> > +	}
> > +	return SK_PASS;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> LGTM!
> 
> I think it will be better if the test could also cover the case you
> indicated in the first patch, where skb_transport_offset is a negative
> value.
> 
> Thanks,
> Zijian
> 

Hi Cong,

I agree it would be great to see the skb_transport_offset is
negative pattern. Could we add it?

Thanks,
John

