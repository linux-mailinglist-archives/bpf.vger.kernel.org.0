Return-Path: <bpf+bounces-3447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00A73E23C
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C238B280E24
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B448C1F;
	Mon, 26 Jun 2023 14:36:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E3AD5D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:36:24 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F58194
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 07:36:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so2970452a12.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687790181; x=1690382181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32jP/w/E8q8NGaa9CK9c6U2+JFesBNUPficPFHtqoEg=;
        b=XFP3CiEF6HvupMSmKAjHhbYNHOZ2RDkhiWllnau2URTtWUrGmQ9xyqJ9+LTgrjD8BT
         Kl5YV34eKt17c4KmfjAylJ3vF5lNTv5tP9Mr2o+XNEBOLB4V1t1hiCCvWJuRBeMZ20fA
         D+mghRWJAwBSbWz1uO74U3e484SUofoUtRQx7GyysPIiHHwxI/vwfh0uXqauQVol6eC4
         w+9caeH2G0/+pWnXjlbpctbq7eNQ0SVK+R6JRZgIGkUt0axvjddWpX4prGkIbA/nuFPl
         pWwPynfnrnKDB0/dDPmc4Xd61asPox1Lbrdy6kdTYMIItuRKBu4E4CKrd8x/AKqALK2r
         IwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790181; x=1690382181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32jP/w/E8q8NGaa9CK9c6U2+JFesBNUPficPFHtqoEg=;
        b=Rsb7Tw1SA1MpF740o3T3g5cKkEFk/vZfgJX0idKDtAWj/xgMngRTBwofN4av324nlZ
         TyFXo5FS8fg7oI9Vj77qfOco3kaAiOifxk0aDjnpeH8C39n5KPE7g7J04N5qSiUdLbrQ
         N2Tv3cxbY86M6r3Yrc3+6cBM3NImWptk/Bmay0UxK59CubwMXLjyM1eHHIFfEBXQe25f
         9S7N54lCOq3lwQ9kk+tLV58wNvZLSwR8NbJNhCbdLN8zlhgzPh4I60DMBsbQi7I+K42x
         fcMc+oxvsuCsYoPOnmfj/xGo1qtQ0nTVZWTiFrUskMzJ+CqeRG8Vx9/aJXd5ju1qo0Vn
         w0FQ==
X-Gm-Message-State: AC+VfDwvCEeMpyJWD78sB+ZptiBMHYi43I6CFa0QsClDack44DKE3up8
	BWGbXPX/D7W1zC5rx799Fu3JzQ==
X-Google-Smtp-Source: ACHHUZ7++Aj8lGI92RQi/4e+N+mkaGnDUX2DYPQ48Ga0PUijoZvxznSYyMJlHmvRrKjN10PmKO6jaQ==
X-Received: by 2002:aa7:cd0a:0:b0:51b:df63:3216 with SMTP id b10-20020aa7cd0a000000b0051bdf633216mr10182000edw.41.1687790181112;
        Mon, 26 Jun 2023 07:36:21 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id q7-20020aa7d447000000b005183ce42da9sm2862406edr.18.2023.06.26.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:36:20 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:37:29 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC v2 PATCH bpf-next 4/4] selftests/bpf: test map percpu stats
Message-ID: <ZJmiqR9rS7j49SPM@zh-lab-node-5>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095814.1027286-1-aspsk@isovalent.com>
 <20230622202059.ybeta3p3qknqbor4@macbook-pro-8.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622202059.ybeta3p3qknqbor4@macbook-pro-8.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 01:20:59PM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 22, 2023 at 09:58:14AM +0000, Anton Protopopov wrote:
> > Add a new map test, map_percpu_stats.c, which is checking the correctness of
> > map's percpu elements counters.  For supported maps the test upserts a number
> > of elements, checks the correctness of the counters, then deletes all the
> > elements and checks again that the counters sum drops down to zero.
> > 
> > The following map types are tested:
> > 
> >     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
> >     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
> >     * BPF_MAP_TYPE_HASH,
> >     * BPF_MAP_TYPE_PERCPU_HASH,
> >     * BPF_MAP_TYPE_LRU_HASH
> >     * BPF_MAP_TYPE_LRU_PERCPU_HASH
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  .../bpf/map_tests/map_percpu_stats.c          | 336 ++++++++++++++++++
> >  .../selftests/bpf/progs/map_percpu_stats.c    |  24 ++
> 
> please add another patch with an extension to map_ptr_kern.c
> where it not only checks hash->count.counter, but new elem count as well.

In fact, it looks like to add this check is out of the scope of this series:
the new kfunc expects a pointer to a trusted btf object, while a pointer
which we get from a static map address is a const pointer to map ("map_ptr"),
which is AFAICS currently not supported by the core kfunc code.

I've added a check that the percpu pointer itself is initialized (not NULL).

