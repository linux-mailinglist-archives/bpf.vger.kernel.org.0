Return-Path: <bpf+bounces-9379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E447946C5
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECF7281481
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 23:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEBB125CE;
	Wed,  6 Sep 2023 23:01:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB9125BD
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 23:01:47 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30F19B5
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 16:01:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcc331f942so3650211fa.0
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694041299; x=1694646099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mA3lzhBOrOTvB/v6h6SwSIRHHbImw9MktqIg61oW+o=;
        b=h2S9s61v0uaI6IrSIG3KQb41H9VQNOafXk1+EGuANeyOSaNNmlTvRugrtuFCVhnvs+
         EgNDEkxq0SruUp2HPl0nsgDwgtOrQzyFm0+jgGfXX6QoOk/guhBkCPvr4/WvCACOphcL
         IVLJAcGClURmPQd3BSG9r4iV4Gqng4Uvh70nnuJfytyjRPIs9PlU300W2LVgeQmPLxDI
         SYnriIacd6t2ULALHBCa7kBiw4QjpOKffIzMEKA9DWUhEQz0yGoyG9gZ6+oP06bnWQse
         xoW/a1Q83Whc1Ez2BEVObfdiuGlv2IqOX4w2Nw4BCfhp8MRkx71HY3i/x1uH4Ah7dqGo
         WmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694041299; x=1694646099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mA3lzhBOrOTvB/v6h6SwSIRHHbImw9MktqIg61oW+o=;
        b=lqtUfTVzYqVftVSVNWqFukJ35dl69SaGCvSch//gziZIEuYo4DTkwtJE2vPCp9ZHAa
         oHK1pCnjGS3CMX3JK0IPgJO8nVEtzBtoSvGp80wspOpfLlB/2/Qbl/S+1c8Kk22iwQQ1
         EZuU3wmP1KBEJmudZvEKc2XXT9tfT5Yw0wpVKSJ9rzUe/QzW7beOmGl6NfnSINmLCIdL
         2suUJBrKuPFTgH/UPTjIln0ejWd3NTQAmzrgFKJy9Le5cVr+7bhw6M1TUY9ua+cFX8fk
         i4TTQgTTFMMVqofBMGknDtzKwK6b5q+7AjcnTbBHd8ZjwPphvmgQ1SUaSpDNZ7Df8qLN
         GsaA==
X-Gm-Message-State: AOJu0YyyxFHAZEjXaRwUAE+iiLsVA5YBSGwhLdBV2CEFGKDRASJGXXmo
	RNE3efrYvaUZsmhZbzvbo3nwZtfGtrGOpAigI6BIY/UO
X-Google-Smtp-Source: AGHT+IH/1vHPmUWBRG0QJZz6HQIjpzcrr5CG5Y4C096W6aKu/8jHLhkOeEjt21pYB2zYeh/27CaCyQivT2DIvYK2I8k=
X-Received: by 2002:a05:651c:128d:b0:2bc:dcbe:f566 with SMTP id
 13-20020a05651c128d00b002bcdcbef566mr310225ljc.11.1694041299053; Wed, 06 Sep
 2023 16:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906154256.95461-1-hffilwlqm@gmail.com> <ZPjl5is9OKK7Anjs@boxer>
In-Reply-To: <ZPjl5is9OKK7Anjs@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Sep 2023 16:01:27 -0700
Message-ID: <CAADnVQLwrrTpwMN+0Q3=HkArn6YL5j7j5YQQew5rq0k1xPP-=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Correct map_fd to data_fd in tailcalls
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki <jakub@cloudflare.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 1:50=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 06, 2023 at 11:42:56PM +0800, Leon Hwang wrote:
> > Get and check data_fd. It should not check map_fd again.
> >
> > Meanwhile, correct some 'return' to 'goto out'.
> >
> > Thank the suggestion from Maciej in "bpf, x64: Fix tailcall infinite
> > loop"[0] discussions.
> >
> > [0] https://lore.kernel.org/bpf/e496aef8-1f80-0f8e-dcdd-25a8c300319a@gm=
ail.com/T/#m7d3b601066ba66400d436b7e7579b2df4a101033
>
> in the subject of the patch you should have 'bpf', not 'bpf-next'.
>
> Fix this and send v2 please. You can also include my:

No need to resend just to tweak the subject.

Also this is not a fix that is worth sending to bpf tree.
Selftests are typically bpf-next.

> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks

