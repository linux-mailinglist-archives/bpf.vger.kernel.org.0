Return-Path: <bpf+bounces-3499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA9B73EE32
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B21C209CB
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC715AC6;
	Mon, 26 Jun 2023 22:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7114282;
	Mon, 26 Jun 2023 22:01:17 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB959EA;
	Mon, 26 Jun 2023 15:00:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-57012b2973eso42613107b3.2;
        Mon, 26 Jun 2023 15:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816786; x=1690408786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJh7dtMVo5GmIYekWj93QB7xbo0tvUawqR/reVR61tY=;
        b=XsjYSrgT1VsNqIRY9LLlyaApcbKablXLI49JWzVRYF8c0NXu0/Gzht630Mh9bhwZgs
         DZQgbzV6C4pxQvO4dC5hl0GuzWyilVp5/hiic9W+GXYd8jixMsvDHQEEKcgX+cqpA8e0
         /5QQiEr8fugYNODSfx33WfGWOzNfF05xFpiPjcSAKa35cmy560Xc4UH8pUDOjxyU5IQT
         5pIaKKi6kAw97Z8UhFE0+wE3Fr8gUk9WHTBpQFtn4BTtAh9Nh/M9srcWOQJGHZXd/Mkh
         I/UrbG8WFB1nzgausc33B7FDynX/nsXOzRFdIX0AA8Xsmc3BcvJA7WlrituHL1cwTHIE
         w1yg==
X-Gm-Message-State: AC+VfDyfLjs8F8H9ZphkRF/8NhjJNAcvK152+XrIMGZcwry+3+1kGgTI
	VmEo6eBUK58khBqUeu7P09t1BWe29MQifjBbPHk=
X-Google-Smtp-Source: ACHHUZ7p86TnmzYHzaw4N4qOWVlt1G9RX1l5uZUc2pRkQrjc4lCw1OAQudRrrW4FYsy58Q16Y9mWk3P4nNc4ufRfOI4=
X-Received: by 2002:a05:6902:18b:b0:bc6:c22f:581a with SMTP id
 t11-20020a056902018b00b00bc6c22f581amr24823925ybh.38.1687816786531; Mon, 26
 Jun 2023 14:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
 <3065880.1687785614@warthog.procyon.org.uk> <3067876.1687787456@warthog.procyon.org.uk>
 <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net> <CAM9d7ch_mWUQGW8G221bZmCPn3wB2mjZm=ZdmhDkczhich9xZA@mail.gmail.com>
 <20230626145353.468fd133@kernel.org>
In-Reply-To: <20230626145353.468fd133@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 26 Jun 2023 14:59:35 -0700
Message-ID: <CAM9d7cgaXHU0=K-T80Vv6vh1pFyF=Jo-hgTrHXbOq5gpf5ux8w@mail.gmail.com>
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace tools
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, David Howells <dhowells@redhat.com>, 
	netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 2:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Jun 2023 14:31:39 -0700 Namhyung Kim wrote:
> > Right, we want to keep the headers files in the tools in sync with
> > the kernel ones.  And they are used to generate some tables.
> > Full explanation from Arnaldo below.
> >
> > So I'm ok for the msg_flags.c changes, but please refrain from
> > changing the header directly.  We will update it later.
> >
> > With that,
> >   Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Ah, missed this email, sounds like this is preferred to Matthieu's
> fix, we'll take this one.

Hmm.. I believe they are the same when it comes to the
changes in the .c file.

>
> > Also I wonder if the tool needs to keep the original flag
> > (SENDPAGE_NOTLAST) for the older kernels.
>
> That's a bit unclear, because it's just a kernel-internal flag.
> Future kernels may well use that bit for something else.

Ah, ok then.  I thought it's a user-visible flag.

>
> Better long term solution would be to use an enum so that the values
> are included in debuginfo and perf can read them at runtime :(

Right, we also consider BTF to read the values and hopefully
get rid of the business of copying kernel headers.

Thanks,
Namhyung

