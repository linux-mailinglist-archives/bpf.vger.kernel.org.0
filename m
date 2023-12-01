Return-Path: <bpf+bounces-16402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF3801033
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ED51C20FF3
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC14A9B2;
	Fri,  1 Dec 2023 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuhgSf96"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35964A6;
	Fri,  1 Dec 2023 08:35:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0521554ddso6214335ad.2;
        Fri, 01 Dec 2023 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701448503; x=1702053303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16gobxTKJQRnr3kFLCWrvthBGV4OGNlumO56+/lV0JY=;
        b=iuhgSf96e0lBm3livOvD5ZLz2LeXbImxf8jpTJ78HNw0WDxT/PlK9WJIotmwosjeg6
         nayf3CxjrON/fLTyhPozZYMO4F+Qubresxpoucb27jTLXgIk4EN+/UVaEMjoUSK3UBkX
         iheRWhl4BH4FETThcVTFm18gEetv0JPE8ucEP4knJ73yVsAGGK0G1ZNWUO1tkjn2cN13
         4VRwDB5qmKPWLQBzo2zGNUKpfwqK40ZcMQK/PvhHhp6jO+NDZ7hNR70Eo1UFUGOvpPUo
         HJWQeRfJKw0/NpFm1U5VNYLArWbER+itz/g4kgS7pLtchRmLOuWmOrzWXpAL00uqvN6y
         ZLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448503; x=1702053303;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=16gobxTKJQRnr3kFLCWrvthBGV4OGNlumO56+/lV0JY=;
        b=tRlHrpY+KgiyErpzQ1/Pez0etvCSDRMrGmXA1lHZSlfvjEsZ0Scy/QjFZTrEqT5Nj7
         SRgeU72u0E4/VTPNNMU2y4paTrmLs49I6duJyZkxc7taRCPjmqOluTnJXg0K3oY2neLD
         k+y8TdhW3rQkOc0DGzbdWWqqoBopzPhMp2ZTEG3ch14WFGtr5sSj6ty2FLO1YbZPzmwu
         GtxamgTZVLPXRrS3wLhh88F4uCnDdEMX9NI/ImqZn/+wtlT3Q9njPhvneYKuDxcTnzaW
         bcTAWJLXyD0FCmUQ3G2RpghtfWCTWkklCdrceWfOGymakn1ASkx4UqNQQZvA/eTTTcj/
         O7rw==
X-Gm-Message-State: AOJu0YyviJjrThXknXvhl/+cawCiFgGK2JU36fhf018Nl8vL2t7pJ4F3
	1rWctx2lcSXy6+KavJpADmkxfa6pf2mJIQ==
X-Google-Smtp-Source: AGHT+IGTyBUTdQa4P3cSS6QpLZJ/RBSARBVRImC9NIqnEIGnFinIYKSGGOWsm7PviAZ2HfUZuFsV8Q==
X-Received: by 2002:a17:902:8bc2:b0:1cf:cc23:eff with SMTP id r2-20020a1709028bc200b001cfcc230effmr7109840plo.52.1701448503591;
        Fri, 01 Dec 2023 08:35:03 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:7a9a:8993:d50f:aaa4])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001cfca674329sm3534106plg.90.2023.12.01.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:35:03 -0800 (PST)
Date: Fri, 01 Dec 2023 08:35:01 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: kuniyu@amazon.com, 
 edumazet@google.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <656a0b35cd1eb_444022086c@john.notmuch>
In-Reply-To: <87edg62rcc.fsf@cloudflare.com>
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-3-john.fastabend@gmail.com>
 <87edg62rcc.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 2/2] bpf: sockmap, test for unconnected af_unix sock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Thu, Nov 30, 2023 at 07:23 PM -08, John Fastabend wrote:
> > Add test to sockmap_basic to ensure af_unix sockets that are not connected
> > can not be added to the map. Ensure we keep DGRAM sockets working however
> > as these will not be connected typically.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > index f75f84d0b3d7..ad96f4422def 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > @@ -524,6 +524,37 @@ static void test_sockmap_skb_verdict_peek(void)
> >  	test_sockmap_pass_prog__destroy(pass);
> >  }
> >  
> > +static void test_sockmap_unconnected_unix(void)
> > +{
> > +	int err, map, stream = 0, dgram = 0, zero = 0;
> > +	struct test_sockmap_pass_prog *skel;
> > +
> > +	skel = test_sockmap_pass_prog__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +		return;
> > +
> > +	map = bpf_map__fd(skel->maps.sock_map_rx);
> > +
> > +	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
> > +	if (!ASSERT_GT(stream, -1, "socket(AF_UNIX, SOCK_STREAM)"))
> > +		return;
> 
> Isn't it redudant to use both the xsocket wrapper and ASSERT_* macro?
> Or is there some debugging value that comes from that, which I missed?

It looks like xsocket does an error_at_liine() so guess not you
will have the line number if it fails so will know if it was stream
or dgram that failed. Probably can just drop the if altogether and
let the thing fall through and fail.

> 
> > +
> > +	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
> > +	if (!ASSERT_GT(dgram, -1, "socket(AF_UNIX, SOCK_DGRAM)")) {
> > +		close(stream);
> > +		return;
> > +	}
> > +
> > +	err = bpf_map_update_elem(map, &zero, &stream, BPF_ANY);
> > +	ASSERT_ERR(err, "bpf_map_update_elem(stream)");
> > +
> > +	err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
> > +	ASSERT_OK(err, "bpf_map_update_elem(dgram)");
> > +
> > +	close(stream);
> > +	close(dgram);
> > +}
> > +
> >  void test_sockmap_basic(void)
> >  {
> >  	if (test__start_subtest("sockmap create_update_free"))
> > @@ -566,4 +597,7 @@ void test_sockmap_basic(void)
> >  		test_sockmap_skb_verdict_fionread(false);
> >  	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
> >  		test_sockmap_skb_verdict_peek();
> > +
> > +	if (test__start_subtest("sockmap unconnected af_unix"))
> > +		test_sockmap_unconnected_unix();
> >  }
> 



