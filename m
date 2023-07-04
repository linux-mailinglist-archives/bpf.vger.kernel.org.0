Return-Path: <bpf+bounces-3989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E98747538
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8718A1C20976
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D366AA4;
	Tue,  4 Jul 2023 15:22:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C683567B
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 15:22:36 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42710DC
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 08:22:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3143b88faebso1839964f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688484152; x=1691076152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zSNoIYS1wRZL0jZ+ht6kxCDMl9DYFwYFjKzRCajx/A=;
        b=CaOiwttbtPTnKstpsg8GFJhWQnCkvz+UjlALkSux7C2Y2QrXG52Bx9Gve2Jvch6WVR
         gQD/NXzJdCaTpgaLnwR+7jcfJGDkuX46p0OHrRsaUNu+/X+7MCEn00qEd5hV5iPEMCz/
         lJy7aMEbMCVLuahkcoOks/PzB08u2cUYORqipy8iDx7815y57989GkO55eFps4Z3pWGm
         egMqQcenI7kBCNtj/uoqIq41JRSq5ymnzflaYVN0cSbcg+LdroxuUr966TKKsWHDKpgM
         nFRpPsw9iFfJAMssj8vbqmCppd6sOJF/9Mt29w5wZkW8qeQm2Qq4otVL1oqOuy0XDkSf
         1UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688484152; x=1691076152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zSNoIYS1wRZL0jZ+ht6kxCDMl9DYFwYFjKzRCajx/A=;
        b=eQ5OeGdQxgC/JcI6uOUIiD21iFL/TDrF3ugFpCZq+iqlo8fYDKWfjejtEMe55bUUhQ
         Yhuw+5Nrv58zcHtrDTW8nix8mYKmG5E4DYDs2nAtwqqPbPekaLhammk1rddHqwKrqJ5r
         6n2DmfF2LZq4S0s63+5mRGl9z1rdaFDDCt5fre5dBFRUlqrFeP0ZQ5hKmGjZLV3TpNjF
         CLS/R7bX7X+/T3BQ4pfubgruj6a2dkfPIvyGVYdwBEHYeobBIWz0dt/yvueIxH8jqyLd
         cA4xB0X/8EAjSLZDioyRAFHynoKQIXPRnk7NWRuTkpmAqritay413BoUuUntPwXDlhIk
         0a0A==
X-Gm-Message-State: ABy/qLaqbp1Wxo+2syw/MY2LG3Sk7byZ7K6lkUGB8pc4WzjTA2eSBaKR
	tKtGHFL0F3GvHqZTP6eZgoxY19pXG/WW+DutUAOfPQ==
X-Google-Smtp-Source: APBJJlHB8Ov5OBKvf7kPl0C8yFPzndOkM6Ia+hS9w+mUD0GHoVcRQViZ188PVJi/LjnAZROkJIDiDw==
X-Received: by 2002:a5d:4ac2:0:b0:313:e161:d013 with SMTP id y2-20020a5d4ac2000000b00313e161d013mr12551788wrs.15.1688484152268;
        Tue, 04 Jul 2023 08:22:32 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe303000000b0030fd03e3d25sm28688887wrj.75.2023.07.04.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:22:31 -0700 (PDT)
Date: Tue, 4 Jul 2023 15:23:30 +0000
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
Message-ID: <ZKQ5chXIwe0ItMbT@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
 <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
 <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKQ0iF+8fMND5Qmg@zh-lab-node-5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 03:02:32PM +0000, Anton Protopopov wrote:
> On Tue, Jul 04, 2023 at 10:41:10PM +0800, Hou Tao wrote:
> > Hi,
> > 
> > On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> > [...]
> > > +}
> > > +
> > > +void test_map_percpu_stats(void)
> > > +{
> > > +	map_percpu_stats_hash();
> > > +	map_percpu_stats_percpu_hash();
> > > +	map_percpu_stats_hash_prealloc();
> > > +	map_percpu_stats_percpu_hash_prealloc();
> > > +	map_percpu_stats_lru_hash();
> > > +	map_percpu_stats_percpu_lru_hash();
> > > +}
> > 
> > Please use test__start_subtest() to create multiple subtests.

After looking at code, I think that I will leave the individual functions here,
as the test__start_subtest() function is only implemented in test_progs (not
test_maps), and adding it here looks like out of scope for this patch.

