Return-Path: <bpf+bounces-8999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606B78DEA9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B6E1C208C4
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD879D1;
	Wed, 30 Aug 2023 19:48:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65580747B
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 19:48:58 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D82E229DC
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 12:48:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso7606923a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693424825; x=1694029625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iuVLnfO7bxZajTLfD46/+14CR0lAF40fyU/hQcolvIk=;
        b=Nj5pHGMPC812jaH4sCnyQMFqDOIgFhcdBdQNSfS+Kuf9ncul8oRQfPECqxjE3qpRJI
         g5LiReMRLSTq4HtTrso6A/MVjvrnCa8ow0xIAf8nxdc9MaIRKGMdcuvNeXffeQZKqHIe
         KXjDachV/M3FDeIs3Gphs8BAuHUb0E+vDEXLvHXMdOCUytNpQF3qXsM3B/ROl3bY+P1S
         R6azO1TNtwt+DPA5tw/amkKujJkEyJR1kwMtITMCmWE8HiqhwcA6oWrUwExlYUiV3XNB
         3+JLmWbo5g6m5xDeddqknL8JuHs8kgVq+InAR6SjR0YllOvaNto+MNOckCVy67mcamDT
         zRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424825; x=1694029625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuVLnfO7bxZajTLfD46/+14CR0lAF40fyU/hQcolvIk=;
        b=mGlOP94E5QIGcDEGqvUnvotVxVpZKaV3c1p76X8Q7Hzu1btVeP1RpfI/quN3W/jBuM
         yBe21Rp0qLdoi29l4lKagepd/zP8sxpZjmFQUD9HXK/4jMF44jBq/VCH1lRRj1uji6at
         cNtCnqPJgJ5vr/S8amOzacHL/IeLgO3VB6k/+0sp5KgUj62Zv+YUEp8GdZZprWlPOc/O
         AMMNfBmL1w60KhXekSYCjy/XA0rXFk3pTHRyd9PNo8wzRsX3fwNNthy6z74q0//B9fws
         z/rIuwGZ/rd0urIS2pzszuvU9LviieuLUFWJXgBnDOoscyIMZYqYOWP2lJIohsWGBzWj
         uNVg==
X-Gm-Message-State: AOJu0YyF83j//pCbuyK4RreHKTucf+ErkFDceqhloM/FF4wS5lkEzxwH
	XhIG73N3WdUuOCqkzYMd6CpzJt2wyJI=
X-Google-Smtp-Source: AGHT+IFvLYGgs7MHYjTm28v5DdNr67RUI7M26aYgbd2Kt13y1XiIwZbybCeg+FC6G23vKWrPPql7dA==
X-Received: by 2002:a5d:6988:0:b0:317:69d2:35c2 with SMTP id g8-20020a5d6988000000b0031769d235c2mr2358601wru.2.1693422252314;
        Wed, 30 Aug 2023 12:04:12 -0700 (PDT)
Received: from krava ([83.240.61.136])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7d146000000b0051dd19d6d6esm7156426edo.73.2023.08.30.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:04:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Aug 2023 21:04:10 +0200
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZO+Sqomnp5BkH+m6@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <ZO9DvsaOImg4Dt5r@krava>
 <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW56Bc_Ynd=uduJ1OwHLZD40GqzrD89W8-AjGKN=bmgzng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 02:35:49PM -0400, Song Liu wrote:
> On Wed, Aug 30, 2023 at 9:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > > Recent commit [1] broken d_path test, because now filp_close is not
> > > called directly from sys_close, but eventually later when the file
> > > is finally released.
> > >
> > > I can't see any other solution than to hook filp_flush function and
> > > that also means we need to add it to btf_allowlist_d_path list, so
> > > it can use the d_path helper.
> > >
> > > But it's probably not very stable because filp_flush is static so it
> > > could be potentially inlined.
> >
> > looks like llvm makes it inlined (from CI)
> >
> >   Error: #68/1 d_path/basic
> >   libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3
> >
> > jirka
> 
> I played with it for a bit, but haven't got a good solution. Maybe we should
> just remove the test for close()?

I was thinking the same.. also we have some example with filp_close in bpftrace
docs, I think we'll need to add some note with explanation in there 

jirka

> 
> Thanks,
> Song
> >
> > >
> > > Also if we'd keep the current filp_close hook and find a way how to 'wait'
> > > for it to be called so user space can go with checks, then it looks
> > > like d_path might not work properly when the task is no longer around.
> 
> [...]

