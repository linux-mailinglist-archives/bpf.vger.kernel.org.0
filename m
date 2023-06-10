Return-Path: <bpf+bounces-2341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D572AF8D
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 00:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6DC1C20A1B
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492E209A2;
	Sat, 10 Jun 2023 22:37:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BC290B
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 22:37:40 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D181E5
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 15:37:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f735bfcbbbso21600125e9.2
        for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686436657; x=1689028657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMzpCs1VaCxZAW04a2qQ/lIleLCRPIln5bNLmxxyT1w=;
        b=aWARcSO/pVz6xdgfKazzh0pc8MDkJT2KhUTmDj53ALJ629L6hPV01Dp09EyrWouLL3
         GjGwEir1CbPKo5TzM+pf5gEMiSJZQWzmnE1gprZQ7Xk3hHJ8249dhjIPEewDmXxRtEL+
         8tLQTsfCJbk/xWxZyBiHeiNK+t73DfDl86933vUgpt0RsX9KaaOaADGIv6ck6apCVqSH
         YwsKFFXM0V2/csTDIE+cf8lwqLxGJY1PWxa8KdhLiFxJABDp0t/bY2vzrdGl8tBa3O39
         8gzo+n1anc7mb6Kg+x0zZRaZkPXSdinVehMjomAP1GlFWbfu5LawM/YkxTG62hVTM41Y
         zGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686436657; x=1689028657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMzpCs1VaCxZAW04a2qQ/lIleLCRPIln5bNLmxxyT1w=;
        b=fyculGGf56U+knzgowZ7YktTKupD67YB8j3nxyxfGa6X0+eYW1VKTx5MmAGlJQBW8N
         RjzjwNXWj2hL3+O5f8KIpNKYHeaf9wgcWRRUGhPzqhopisDqY4nSA99uuOhWvLBY4K9E
         xzaL8eEq242+1PqBRFFRUQ/zp7VZfqD9ZUTDMar8JF0/HLDLbUE38G/mooUfhRvBahc4
         l86279PZPqLPNfH1Pxno52uFD9xsTbDEtZJeCSp7gCCjecQqXuThOhoBfU7Y1bA0sMaO
         GtvbqN1fRPDcVhLnTeMs2yutjbRBgU5vXg5TDewaOt73v0mmz9mzfdCSDAat1kAJyZ3C
         4wvQ==
X-Gm-Message-State: AC+VfDxKsHZ3XdDQKbnv1JzlQe/uRZESpp2qycTl5/KLcng+77uETsqL
	Cz6dNUTqyIqZG71YAg4YsUU=
X-Google-Smtp-Source: ACHHUZ4VFkT0idDF0LJyTPY16Rb70yl6GukbIuVlOuoV0beNq1Hlu5yN+2oOG4l2rMmkN067omLIRA==
X-Received: by 2002:a7b:c84c:0:b0:3f7:2d7d:c673 with SMTP id c12-20020a7bc84c000000b003f72d7dc673mr3517507wml.14.1686436656743;
        Sat, 10 Jun 2023 15:37:36 -0700 (PDT)
Received: from krava ([213.235.133.42])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm6770508wmj.27.2023.06.10.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:37:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Jun 2023 00:37:32 +0200
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, quentin@isovalent.com,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
Message-ID: <ZIT7LFg5P1PevfC/@krava>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
 <20230608103523.102267-10-laoar.shao@gmail.com>
 <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
 <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 09:36:39PM -0700, Song Liu wrote:
> On Thu, Jun 8, 2023 at 4:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 8, 2023 at 3:35 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > Add libbpf API to get generic perf event name.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> >
> > I don't think this belongs in libbpf and shouldn't be exposed as
> > public API. Please move it into bpftool and make it internal (if
> > Quentin is fine with this in the first place).
> 
> Or maybe it belongs to libperf?

we have several lookup arrays like that in perf and we keep
also 'alias' names.. it'd be good idea to have that only in
libperf, but that would require perf perf's parse-events
cleanup as well and bpftool starting to link libperf

I'd keep it in bpftool for now and have that cleanup later

cc-ing Arnaldo

jirka

> 
> Thanks,
> Song

