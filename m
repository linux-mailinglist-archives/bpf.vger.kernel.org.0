Return-Path: <bpf+bounces-7163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D8577259E
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A71C20BE7
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C696107B6;
	Mon,  7 Aug 2023 13:27:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A44107B1
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 13:27:22 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE71991
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 06:27:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso438651cf.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691414768; x=1692019568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV86SNTrsedHb/4GViYCEi4y0WkKBp0siTYx3zahDc8=;
        b=4S7gV7c2cdcuEpB2T5mX/CpOL0kpeYdnmSvNbTa56EyndJ1AvAzRNKOCHIXMgx0KOG
         m3pW2Po9Xpwb5mBlkkTlDX7BdfoeEdLud2EtxxftfD36WTiHHe2nEeXaITwz2BDbbA0E
         mSvp6S22gXS5JjA4PzFAz3yxbfL/xwTpchOOFlQes8Q9oNXqFc9aOWbePypmk7q1dk4A
         a4vRst4pzFXh9rN/C4cxoJLZMGwpmyH5jRV3WLEwpNBiRYis7cS9NoowQ/CtsnQCP+xr
         DEBbVtZs2zdvHzsuMXpeRoX/6pa4fjpkmdII9AdqLI15u6AO9N5fAAXHrXdcgBZmZLKS
         kpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414768; x=1692019568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV86SNTrsedHb/4GViYCEi4y0WkKBp0siTYx3zahDc8=;
        b=UQxwR9QKkQfmHVlVwO5WFmRsxC7zyIl6mrDo3qax9pRHNN8JQyiaNx4Ue+GnU1zCdo
         5Psr8QhMi7Yh9HOkLI56NBsPrrEn6NVpCl0Yw9FKjUA7J74OXFIVw/os8D/18aCSkkS5
         gaOcDXj+HrL7kc9zGFWumjbsvZNGbpDs2a6/FZskUalJxDAaudNno0uwH8heo4AEqhXA
         S8zihqI67vLNeBfYumVEV5G+3jjPpsFaQoU/TnTIRs41GqT1YZ7JKwrfwcwtZnrTLq+u
         3MAflXE76joQPyLpCwVOAg9GTRQZotNFdX62m/soqWjF/2Iel5/tyoiN/vb6pQ30hfUS
         DQ1A==
X-Gm-Message-State: AOJu0YzRIjeWWECQY1BL5bZpA6nLP8RixTLlPXMBzfAi2GZQOtZRgv5Z
	gakHiFul5pPWS/0wMR9G780SgS1SMLK5+USH9CHjTQ==
X-Google-Smtp-Source: AGHT+IH7l8fz/va80d2V76Roj1BsoAMY57SE1UROxLkV3dyWOxXlttc6h2gDN6ZO1f9HDD+7BbQ8h6jdtiwhSOmFGN4=
X-Received: by 2002:a05:622a:1806:b0:403:ac17:c18a with SMTP id
 t6-20020a05622a180600b00403ac17c18amr454405qtc.14.1691414768116; Mon, 07 Aug
 2023 06:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230806075216.13378-1-me@manjusaka.me> <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
 <8d25f9e8-9653-4e9b-b88b-c5434ce8aabf@app.fastmail.com>
In-Reply-To: <8d25f9e8-9653-4e9b-b88b-c5434ce8aabf@app.fastmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Aug 2023 15:25:56 +0200
Message-ID: <CANn89iJAu5CLq1LkRLt0qJ+ytFGXWGqymMHBnMevcPS4Z2GAXQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
To: Manjusaka <me@manjusaka.me>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 2:49=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> > Do not include code before variable declarations.
> Sorry about that. I will update the code later.
>
> > I would rather add a trace in tcp_ca_event(), this would be more generi=
c ?
>
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_cong.c#L41
>
> I think maybe we already have the tcp_ca_event but named tcp_cong_state_s=
et?

I am speaking of tcp_ca_event()...

For instance, tcp_cwnd_restart() calls tcp_ca_event(sk, CA_EVENT_CWND_RESTA=
RT);

tcp_set_ca_state() can only set icsk_ca_state to one value from enum
tcp_ca_state:
TCP_CA_Open, TCP_CA_Disorder, TCP_CA_CWR, TCP_CA_Recovery, TCP_CA_Loss

enum tcp_ca_event has instead:
CA_EVENT_TX_START, CA_EVENT_CWND_RESTART, CA_EVENT_COMPLETE_CWR,
CA_EVENT_LOSS, CA_EVENT_ECN_NO_CE, CA_EVENT_ECN_IS_CE

