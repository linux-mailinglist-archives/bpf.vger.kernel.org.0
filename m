Return-Path: <bpf+bounces-8886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C378BFC6
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355E2280F9B
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E46AA2;
	Tue, 29 Aug 2023 08:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260223D2
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:00:35 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C50191
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:00:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso395355566b.2
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296031; x=1693900831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+BfArbdHp4Bskz8cAKoWC+JX15qnvPWub5ioqmbKXOI=;
        b=ooWUkuDMZKKUeP9MKrMcikJ8gDtskFTC6ezRABZo+5oPbR4iHOn7zEMcjhcr+5p0rY
         ClblXmVnTnNmJGFkPN79VmHeVabF145Wt+1223eW/RvQEqLb/TNUa6tyIyj0+CFUsyy0
         SDGlsx/xhBo+F6TUnjBovHGvA1CDOMm0OAPN+IH6LDZXbiHePt/sXT1xvZC826YZdzDW
         J/SSa+ulgem4yc6c9hGWZyD5hvVZ8BSqDLeP5A8XyjB8ZJ92NpupqOBeUpsvNcUNHy+N
         6otjwMFCP1iWV+1NB6AVQKtRdGW7lIBaG/K89ks4Er0sDJGh4T6L4384GoGXCPfUvlFf
         P2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296031; x=1693900831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BfArbdHp4Bskz8cAKoWC+JX15qnvPWub5ioqmbKXOI=;
        b=KmSh7+vGYq7PJFaIdQGnaCcQaPSXyWHwNdC/NkH2agI92qKrnM6LZbglnxAIG9Xldh
         Lr5I/2zlNWfFxvVDugVUP1UW4C/PVOUhzgU7LEsI4j7SOwzZSdYmKeQbKFf6oxBfUbJn
         PhVFWRJmsY4/7NEzZEbOt0LjWYfhtKjNUcKl2g2aUHYBe9EiHOS0jU3xV9i8ykXwfPdQ
         NFrDZvdZSEsMpBL4gVCUv1bMe1iBjtE39IG7huY4B9kVKz9p5QBIrxNgTjYzepM0RbFc
         nxz5VE4J2gfroI8gaFCEiTBF83PwiUMuJLzEB1yFZTq/VPJhJeD5B32kv4Z1glaucmz2
         KKeA==
X-Gm-Message-State: AOJu0Yw36NjrdhBv2PyLaw4CpR6Lzup9YXa620rUcPBif90fAFG0BIoD
	WAOSd0ZEZJfiRzFSG/wlpcU=
X-Google-Smtp-Source: AGHT+IHEg6uEjB/V4iPepEn6VVOvjit2UNWDo364yyjd+Z9uDrFvfSY1gNQXwZuDNqoSDA1rOas6yg==
X-Received: by 2002:a17:906:535d:b0:9a2:1df2:8e08 with SMTP id j29-20020a170906535d00b009a21df28e08mr8680391ejo.45.1693296030421;
        Tue, 29 Aug 2023 01:00:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090655c700b00992f309cfe8sm5697742ejp.178.2023.08.29.01.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:00:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 29 Aug 2023 10:00:27 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH bpf-next 01/12] bpf: Move update_prog_stats to syscall
 object
Message-ID: <ZO2lmzfblrGOmzxS@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-2-jolsa@kernel.org>
 <CAADnVQLMZRn9E=czkHUxwTiW+9=y=qVYGo1_eOOni59HafemSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLMZRn9E=czkHUxwTiW+9=y=qVYGo1_eOOni59HafemSw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 10:25:38AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 28, 2023 at 12:55 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> >  static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
> >                                           struct bpf_tramp_run_ctx *run_ctx)
> >         __releases(RCU)
> >  {
> >         bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> >
> > -       update_prog_stats(prog, start);
> > +       bpf_prog_update_prog_stats(prog, start);
> 
> I bet this adds a noticeable performance regression.
> The function was inlined before and the static key made it a nop.
> Above makes it into a function call.
> Please use always_inline and move it to a header.

right.. will change

thanks,
jirka

