Return-Path: <bpf+bounces-7460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA327778AB
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A6928220E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E61E1C4;
	Thu, 10 Aug 2023 12:37:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A81E1A9;
	Thu, 10 Aug 2023 12:37:05 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E1212F;
	Thu, 10 Aug 2023 05:37:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d4f1cb5a9so1800686d6.1;
        Thu, 10 Aug 2023 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691671023; x=1692275823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9ys6Jeef8G09yaoEvIqMEbXdjIdPXjqR7+fqH762U0=;
        b=CaVo1zRpTkQf4EkOfaX2qP34cFKGQ7UtuVh5U+WS+gnIS9E5UYsOZ4yNpqAGOTQhJy
         wDYrYFhkktPT+IML+ywMilvdN/RqRPAtidfRvGnZqU5pXEhq26liRwz17Mz59gSw8cdH
         ZKfLtUuiG3lNyjs6nCUC2JJTpoSd43SX10kxt3bhdcLvwVy/0+dwpByEYWw7WIkLR0GU
         9Xov1PCwhqq3X00qbJehqVqIDezXkuCjY639ibgwuuCguGxziA3L/WK13wSvC33ZGilv
         h4Rdc5CPCxxYCtFat9XdxuvphsOsLvA9gmWxICsPqvZq0csUSY8tkLWhU702ILoW8cZC
         XHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691671023; x=1692275823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9ys6Jeef8G09yaoEvIqMEbXdjIdPXjqR7+fqH762U0=;
        b=XTJJEy5GS5Y5kNis6u3FDYkRE+p6nTh6UeQf7Toh/wKoy29lwZkbcNsWrcWpXmvgKV
         FFiS7oLOtI5Wncrj8qMlJsBCoy5Q6dc50YL9pOCqriA1x7SkjjhNUfNbkURv4LfC88SK
         EFWOj4zoW8MrgMqqj5UnR6M+849sMW8J4mB0iwadcqp08J596oq+DKgVMFBTshmMyoBT
         HvDZqLSZTJcb+t+L2zWC5cHkOsJFKgdwB5/hhGMqniTSG5iHO+wxRel56HGOS2Ad0hg8
         c0u7qcHZOPc6p3hdvGRabXKy4f9ZCZgpAA4NmKhUNKXTVickDUeElllUfqnCTThsIAX1
         UwGQ==
X-Gm-Message-State: AOJu0Yxt+ll8Hn4bw49sovirrFTeZssO+w+YCFXiAfIgHcYy1gcFVaH+
	XBsy7k+FZu/7jfN9uw1o3sAxgVVpr6EP8v93n/o=
X-Google-Smtp-Source: AGHT+IHHGynzxYbsxXFicPkE/GLx5oxU/LYkv3kZhE1Z/+ttmUs8dgD97ei1texcDXIhLJ5xCbPHBMJ3Z2VPr1/ZNxY=
X-Received: by 2002:a05:6214:5012:b0:63d:1861:29d2 with SMTP id
 jo18-20020a056214501200b0063d186129d2mr2794327qvb.4.1691671023451; Thu, 10
 Aug 2023 05:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-6-magnus.karlsson@gmail.com> <59631f92-c206-0f90-3eea-58d883147784@intel.com>
In-Reply-To: <59631f92-c206-0f90-3eea-58d883147784@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 10 Aug 2023 14:36:52 +0200
Message-ID: <CAJ8uoz046aFr4p5hLSFjZi8E0PuzBLqHTDBLqtyrpFYZwPpdsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/10] selftests/xsk: declare test names in struct
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"yhs@fb.com" <yhs@fb.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 at 14:16, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/9/23 14:43, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Declare the test names statically in a struct so that we can refer to
> > them when adding the support to execute a single test in the next
> > commit. Before this pathc, the names of them was not declared in a
>
> patch

Thanks for catching. Will fix it in the next revision.

> > single place which made it not possible to refer to them.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >   tools/testing/selftests/bpf/xskxceiver.c | 191 +++++++----------------
> >   tools/testing/selftests/bpf/xskxceiver.h |  37 +----
> >   2 files changed, 57 insertions(+), 171 deletions(-)
>
> [...]

