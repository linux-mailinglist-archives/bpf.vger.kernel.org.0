Return-Path: <bpf+bounces-8212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E62783875
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F13280F75
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57715C4;
	Tue, 22 Aug 2023 03:25:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F87F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 03:25:29 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43562185
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:25:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so68456811fa.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692674724; x=1693279524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVnAZBDWdWFP22N5nsXIH2bXcVshiKpW44bRKotCSdQ=;
        b=T7YfRfHlI1JQh1HV5MhnTeuE2AN/eeos7oh/pWmLTbxFYZJpboHU5Dj9YiTDYfHjlr
         9ySzKXyoyl5cLu1X7Yl4qAoi+u5aj723gefhHh8KVJ2yqHzQWVZ/89+gTgU14/jqb4kO
         t09b3hQ5Eb4C0ts5ZMkjB3T0eqOAuA3/oLNhq5Y+gJ2FGugf9F44Ztv+VQ1mEjjbGZu3
         WS9uQ4dH1XLxe65IvChInORM6Zy2z1Vx1TtaAhI3d8jECjjJCTKn6Co/cMFylinJxeww
         ZkaVAwCbbVb9RWiC6cofX+XmI285vYzPqpSKh2P9qMhmjmHGkIABb8x+SzX8Z8ioUlgI
         1ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692674724; x=1693279524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVnAZBDWdWFP22N5nsXIH2bXcVshiKpW44bRKotCSdQ=;
        b=TehbPuXDB/7UOrEVKTQmIqTqt1tyZfA9DQbHhq+F9n2KNkAuBjqf3dz/V921HPJP+b
         ukFPewdC7IF5C0/cNx5mtHkxrTzjo6uquPJRGICKA4MJLVq/147hs7F/SNABNagb+iY7
         lGzWN90AaWP3nl349WWW0BfJfT5IWIbn/iU/zIMmxKMIqoZJ7XpbWyzpx3XxNeTI5+kL
         SQcfGz+V9mQ4BsCcnljdHo8xLzSbXDavC5p6sBLnfnE4YPGnV/reNk04OSCLedbNLRt+
         b4DQaiWaTGkN6hsETO9aQmi7aZs0PYmQxdITkp0lNlaNPth9MPaKdd96BkcwqJxhSPe4
         Cf5Q==
X-Gm-Message-State: AOJu0YyGpUfY+UHLVNssPdLesmHe3/gxhiaSg1+Qb888YiVQMDr7vgKy
	IwlAtwbC403f3opwpQ0AY06KjgWv9PWvXODQXmB/o1GfSLY=
X-Google-Smtp-Source: AGHT+IFx7RwA40HFqONXTm8NOzn55WPuiVDWoWNXPVDUtxqs5XynOWdSaj3vW4t7VYRK5jRyf6Tx8ao0+Git3KbE9hk=
X-Received: by 2002:a2e:9690:0:b0:2bb:9fcf:6f56 with SMTP id
 q16-20020a2e9690000000b002bb9fcf6f56mr6867623lji.22.1692674724181; Mon, 21
 Aug 2023 20:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com>
In-Reply-To: <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 20:25:12 -0700
Message-ID: <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 6:46=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/22/2023 8:58 AM, Alexei Starovoitov wrote:
> > On Mon, Aug 21, 2023 at 5:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/22/2023 7:49 AM, Alexei Starovoitov wrote:
> >>> On Sat, Aug 19, 2023 at 3:39=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> Hi,
> >>>>
> >>>> On 8/18/2023 7:00 AM, Alexei Starovoitov wrote:
> >>>>> On Wed, Aug 16, 2023 at 11:35=E2=80=AFPM Hou Tao <houtao@huaweiclou=
d.com> wrote:
> >>>>>
> SNIP
> >>>>> If the existing bpf_map_lookup_elem() helper doesn't fit qp-tree we=
 can
> >>>>> use new kfuncs from bpf prog and LPM-like map accessors from syscal=
l.
> >>>> It is a feasible solution, but it will make qp-trie be different wit=
h
> >>>> other map types. I will try to extend the APIs in bpf_map_ops first =
to
> >>>> see how much churns it may introduce.
> >>> you mean you want to try to dynamically adapt bpf_map_lookup_elem()
> >>> to consider 'void *key' as a pointer to dynptr for bpf prog and
> >>> lpm-like tuple for syscall?
> >>> I'm afraid the verifier changes will be messy, since PTR_TO_MAP_KEY i=
s
> >>> quite special.
> >> No. I didn't plan to do that. I am trying to add three new APIs in
> >> bpf_map_ops to handle lookup/update/delete operation from bpf syscall
> >> (e.g, map_lookup_elem_syscall). So bpf program and bpf syscall can use
> >> different API to operate on qp-trie.
> > How does bpf prog side api look like?
> > I thought we wanted to use dynptr as a key?
>
> Yes. bpf prog will use dynptr as the map key. The bpf program will use
> the same map helpers as hash map to operate on qp-trie and the verifier
> will be updated to allow using dynptr as map key for qp-trie.

And that's the problem I just mentioned.
PTR_TO_MAP_KEY is special. I don't think we should hack it to also
mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).

