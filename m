Return-Path: <bpf+bounces-5602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B075C4D3
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF781C21675
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5EA1642A;
	Fri, 21 Jul 2023 10:41:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB083D78
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 10:41:36 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00B10FE
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 03:41:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992b66e5affso278185866b.3
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689936093; x=1690540893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e4a0cnKG/CeDFsVf5NeSWnDBoxk71F8HSwNwajIO9rg=;
        b=sG8xSJuHhEqBI83eEivKPSc2HSDyp9OSwZ0c0CRomeSERXkbd1Qc+C73C7nMRT6/3b
         sv0CRE5Adlho9fRo36J/KmAM/L2/YQw1eEI34iWBygH7ddWYHPvnHMHIlQWjDv9sYrie
         7FhL3TyDVJf1XwojLKrYls8gDmVQsgapAIXIHgF+I8jzqzLOoLcQLEMwX3POypV/yIUi
         7e47liGN0DWS6wvHLa4FWj/bLWm/SrFRNjM70+s1AMIaQwjlXLUq8KvafN9ZgDenjX9v
         7pM6ouLuWZWSU56FpBoSwQbMGUyey13XIqPl0Xqr44LmhpCtZzZGYYDlzppwSP5Nroqy
         koOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689936093; x=1690540893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4a0cnKG/CeDFsVf5NeSWnDBoxk71F8HSwNwajIO9rg=;
        b=VlY0N9GQ9fHxmMMJt6smqOxKC/7Yci32vZw+FhCyF7HYsTSfXkSPgJNW0JJsS+2sWf
         g7sH/A8p4xIpoVM0cCF+8h8ZKuc+zL7Le1XybAyXdpcgPo/cyy7eDEMN9Fv5coCT/R31
         ala7xCkUoRw6clb+EIqNi3dCVljz/jwAIlRbC8F+bctFVqx6DxTtTx8LrOrjyctB3/VL
         Rc6h7ctiaQsokYzHZur6rgi25m+nzoBSKcOOcHz4DRuvJNh9zN1jix3aPOhpEII6Nfr3
         wnvQEumyg0HUolBUrMBTD3o/puMKc+qYV/5wqCydceVMVl7TC2UE9q1ZiLty2Fo48g/8
         EDGw==
X-Gm-Message-State: ABy/qLag9dsiWBNaDYZ7EvsMVeT0xW5MbyIgS4lWItKtKAXlRfzJ8VNF
	kIEhHvO98PggMNYyStT/afs=
X-Google-Smtp-Source: APBJJlEdDMx2mT59jWxQ5kwjPEcm4YmvFuN9gnmhgmHrUM8GPJazEQLLQlChRelA2fhjhESezg3nyQ==
X-Received: by 2002:a17:906:5356:b0:991:f28c:54ea with SMTP id j22-20020a170906535600b00991f28c54eamr1208436ejo.41.1689936093132;
        Fri, 21 Jul 2023 03:41:33 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906388b00b00988dbbd1f7esm1953212ejd.213.2023.07.21.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:41:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Jul 2023 12:41:31 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
Message-ID: <ZLpg2/ayTvN9JoMF@krava>
References: <20230720113550.369257-1-jolsa@kernel.org>
 <20230720113550.369257-6-jolsa@kernel.org>
 <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
 <20230721083140.GA10521@redhat.com>
 <20230721085426.GA10987@redhat.com>
 <CALOAHbA==q_6i4t1E+zKSSgkZ3ALTcGYcwa7ghidOXDi2n8mqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbA==q_6i4t1E+zKSSgkZ3ALTcGYcwa7ghidOXDi2n8mqg@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 05:05:08PM +0800, Yafang Shao wrote:
> On Fri, Jul 21, 2023 at 4:55 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Sorry for noise, apparently I haven't woken up yet,
> >
> > On 07/21, Oleg Nesterov wrote:
> > >
> > > Or. We can simply kill uprobe_multi_link_filter(). In this case uprobe_register()
> > > can touch CLONE_VM'ed mm's we are not interested in, but everything should work
> > > correctly.
> >
> > please ignore CLONE_VM'ed above, I have no idea why did I say this...
> >
> > Yes, everything should work "correctly", but if you add a probe into (say) libc.so,
> > every task will be penalized, so I don't think this is a good option.
> >
> 
> Thanks  for your explanation.
> Currently we can filter out the tgid in bpf prog, but if we could
> filter out it earlier, the prog won't be triggered, that would take
> less overhead.
> However, it is fine by me if tgid won't be supported.

right, I'll check on this.. I think we can add this later and have it
enabled by new bit in attr->link_create.uprobe_multi.flags

jirka

