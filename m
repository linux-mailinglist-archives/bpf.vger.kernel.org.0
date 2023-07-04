Return-Path: <bpf+bounces-3993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE05747597
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E0F1C20A4D
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942936ABA;
	Tue,  4 Jul 2023 15:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FC63C1
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:49:01 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D61E76
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 08:48:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso33152265e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688485738; x=1691077738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwPc9aOKLj7qgrvA9OjoIbeeFSlRHe0a0hndkfpekXM=;
        b=cv7EuuyUzh3kNPJGJj0G1Jst57LMw5Os1Xm22aE0gIrply+RWbCveGJ714x4abp+tg
         DwmuTV1VS5mUaMB+feb2+4HTkPNS8dJetWrTvjX0QrvgcYXi9c7OLeZCUwKCiK6m/Mf7
         Is+zro7gO8rehhoGcoROv+jSFZDGZTuGxx5vxz9e8wpatf1efJkJ+GP7seJ20Hg5cyOY
         XP4j6+86YtTCvb7R+Ipa3QFSTSpW46NrjF1r4bSlbkypYx78HTSTRRPUSjnaUfed8kDe
         izOan29DOniCj7qpT1Svzmynp31Q8n64Rs7iZT2wjKiWceXDaaR6CBV9zn2J1okVCg5H
         IpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485738; x=1691077738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwPc9aOKLj7qgrvA9OjoIbeeFSlRHe0a0hndkfpekXM=;
        b=c4ZZHnOs8sFZlLlaY+kysjX4DIOQVYSkP3gn/G9CvY4TuVejaYMmcUOq4c+8V392hb
         u/sR6qJXCYq2H3Qp927ue3woSwL/zW0fuWE2z19eA2L2dQ4bI5nPzsm4yk0XcZoJcmB/
         /PnAWpt+Pw+rXFBxhNU0KGbmpxybnzhYTQJXo6tIYwhfH7BC+3Dt4Tl8VWhWs1wqRj4C
         8SiMKUBzYCX6jdtXOQjrJLyO05MmPkGYNTxsQSBs3qS7WZmsuSjkNWZip0EVuQ8fquQU
         X0fDilq+A+/i2eqvR6Cu6CU6CH9mZupxfILfg2S2XuGJ1zEP47WSaOGTNJCsDT7nFX+E
         xH3A==
X-Gm-Message-State: AC+VfDypXn56w3jksGWxrzZSRMbN2sQsOZNir2RMoX71zstbJ92SgBwF
	dga4vSHT+lV9vD5yzT4OQ+3B8Q==
X-Google-Smtp-Source: ACHHUZ7J72kmK68s76FIQpdz2+4UVBn44LhPgnbErwssTJKQgXGZazhrJKLg4ZTQhcuUzJAEbyN/LQ==
X-Received: by 2002:a7b:c445:0:b0:3f9:b7cc:731 with SMTP id l5-20020a7bc445000000b003f9b7cc0731mr10676957wmi.15.1688485738400;
        Tue, 04 Jul 2023 08:48:58 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003fbd1a78697sm9806351wmi.5.2023.07.04.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:48:57 -0700 (PDT)
Date: Tue, 4 Jul 2023 15:49:56 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Hou Tao <houtao1@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
Message-ID: <ZKQ/pHpSvX9Lq2lV@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
 <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 03:23:30PM +0000, Anton Protopopov wrote:
> On Tue, Jul 04, 2023 at 03:02:32PM +0000, Anton Protopopov wrote:
> > On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
> > > Hi,
> > > 
> > > On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> > > [...]
> > > > +}
> > > > +
> > > > +void test_map_percpu_stats(void)
> > > > +{
> > > > +	map_percpu_stats_hash();
> > > > +	map_percpu_stats_percpu_hash();
> > > > +	map_percpu_stats_hash_prealloc();
> > > > +	map_percpu_stats_percpu_hash_prealloc();
> > > > +	map_percpu_stats_lru_hash();
> > > > +	map_percpu_stats_percpu_lru_hash();
> > > > +}
> > > 
> > > Please use test__start_subtest() to create multiple subtests.
> 
> After looking at code, I think that I will leave the individual functions here,
> as the test__start_subtest() function is only implemented in test_progs (not
> test_maps), and adding it here looks like out of scope for this patch.

Ah, sorry, looks like the same stands for ASSERT* macros as well, as they are
only used in test_progs. (I will still fix the checks where you commented on
specific values, like n <= cur_elems for LRUs.)

