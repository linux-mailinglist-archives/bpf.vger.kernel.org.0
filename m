Return-Path: <bpf+bounces-9225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA6791EC7
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 23:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283902810C5
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA0CA49;
	Mon,  4 Sep 2023 21:01:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED5BE6A
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 21:01:29 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E87B8;
	Mon,  4 Sep 2023 14:01:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso30105171fa.3;
        Mon, 04 Sep 2023 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693861286; x=1694466086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIz9vm6wpSo3biA+gqZu+fO4idwWlDyCEQPTkRCjcQQ=;
        b=hS+rzdHWeS3E5iwfQB7+md4sUHWFwitIZ6R9vFNXdXELJfPRye7wKcmT3V5Vhp60Cj
         sy2OH5SXvLIUxMX/iXQCuDBz4pKJJ95mUtFMNUBGBkvMX3a+HC79gCOc+KP7oFi/P2DD
         t8WzNq75/wuog8njTWzkm+RCPyoGxgBZAnG3vtPMTDhr2Dm6aooWBj3KNoZ635/+NekW
         KMMGzi72S+lM96eGB8ss4q9ChiGW5IZ1IgJq6H7qvads8rkHknvBLBQ+dqxAzgDHZ24T
         s3oJU1eJA3+HomncMeCyRthVnZl0PgoQBQlFrCQ22COjqgpINhxJYUwlEjqChTzlkyPn
         H1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861286; x=1694466086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIz9vm6wpSo3biA+gqZu+fO4idwWlDyCEQPTkRCjcQQ=;
        b=NIYm+jfvkcGKguEYeF/1yKsQW60pLnDuxg72GLbKYj1NSX0GDoPT+Wdfqc+AncbOPq
         kSd/4uRdlNLJ/Ex0hejBQu12oLKWPD2fVUcDN5f/aNa9+Nk1IwU2qCSOMYn8rq3QiO6n
         kDJwvEAEupDbKFwx5W7neBVkFBefwiee4RGDZJ1Mw4PR64jLyRtT0XxKOlNknZWC9rDk
         GFqfdPBfDXWQ1asSTw7I3cfy57cXfzOdSEDbMh0AsyOk+gsvzSr32p5CLMekq1Ejzrjg
         YKmsF9Cb+QWjOAcdf+XOT4wAG5i0zW5/OK5VITbN1Oz6cjpEyusT37ql8+z5UycEVTOO
         V/+g==
X-Gm-Message-State: AOJu0Yy/vhkiXf+kU8+4unT5D7jZWj5yeJwqnsFmdo9xj9GetRlUIlUA
	ozU0a8MxrSK0/KNTSg9D4yJVVumwno7he1udJ1Y=
X-Google-Smtp-Source: AGHT+IEqGRwcsGuuEx+HonvLn29baZ6cCZhXpaHfXU2YlTzAllL2N+EhU0yhBOL85QRQ7EazAruGlcVUDNEjRlOfC1U=
X-Received: by 2002:a2e:a176:0:b0:2bc:c466:60e9 with SMTP id
 u22-20020a2ea176000000b002bcc46660e9mr7536698ljl.49.1693861285984; Mon, 04
 Sep 2023 14:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904102128.11476-1-00107082@163.com> <20230904104856.GE11802@breakpoint.cc>
In-Reply-To: <20230904104856.GE11802@breakpoint.cc>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Sep 2023 14:01:14 -0700
Message-ID: <CAADnVQJVyQQ5geDuUgoDYygN9R1gJr-21XmQOR8gY5UkZsosCQ@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
To: Florian Westphal <fw@strlen.de>
Cc: David Wang <00107082@163.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 4, 2023 at 3:49=E2=80=AFAM Florian Westphal <fw@strlen.de> wrot=
e:
>
> David Wang <00107082@163.com> wrote:
> > This sample code implements a simple ipv4
> > blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
> > which was introduced in 6.4.
> >
> > The bpf program drops package if destination ip address
> > hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
> >
> > The userspace code would load the bpf program,
> > attach it to netfilter's FORWARD/OUTPUT hook,
> > and then write ip patterns into the bpf map.
>
> Thanks, I think its good to have this.

Yes, but only in selftests/bpf.
samples/bpf/ are not tested and bit rot heavily.

