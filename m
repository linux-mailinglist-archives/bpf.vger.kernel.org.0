Return-Path: <bpf+bounces-1620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37E71F1B7
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAFB2817BB
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32D4825F;
	Thu,  1 Jun 2023 18:24:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5747017
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 18:24:35 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EE97
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 11:24:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af1c884b08so16102781fa.1
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685643871; x=1688235871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw3tRvPDviTdajF1F9XTNueWeJzXALpsHKgUAVuY/84=;
        b=FSLuf4FQ1jdLZG2gdm3l1UQENhjz68x/CrhI+W60Hl9pcQ9wwCxK17m86OxfM+4Vc3
         r0mDCTyDW+dyUem1ANItxdhsyD1kujE84ILNojPGQ/fyztL1nIRK3bIxyGM5TYa0A/Mg
         qa4tKSYsvUE80QiLlGrSTh5CRnS16Ws1pgcYuDkaj02B1iLmkwPZsnDiCu9gZ11Y8Mm0
         oB69g+ywatZgQpJspnEcOkb4LZ2puYx9A+D3ugEfEITWYfMKtQBhHMnrMm8R55M+OoCB
         +ra9iC+JBEn3sLlPZUWxH4UmuA4g02mrIrOfQEtIPNY5huB/15gY3v+bJaFHwSL5cDaJ
         PwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643871; x=1688235871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw3tRvPDviTdajF1F9XTNueWeJzXALpsHKgUAVuY/84=;
        b=Eyzfnqo3bNx3rJzcWVFuKTgDpRkpmvKPs0vmHZVM892yWqtgy42QYyxE2RzxxOcrX7
         X+Dx7wrHoYhQAb1M0r+VQLtG9ixDUFnU7iyWEkm4et6ptmVUiYBH8/MDWQRurImSgjCB
         v6pXAON2PQ9lhPrDQwiLbFOl01X/CsY+haOnZX29+hDAY83PuIs/f6ogscutDlh7lbXZ
         QNqzdDs4KHot0Y2mpxEH0IaFoBVqHJBm2oEEsKxhiR14BxSUf2d1COCjqUWNSBvchwUx
         uihe3XllIBp6O/CwoVvLvObiD8K7PS/PKGH7w6zCZsoVJ6Wij5Vj8WOqMhb4+7YG2h0W
         SfyA==
X-Gm-Message-State: AC+VfDxSSfqdamwY722Ott/7KUj/KZdPt9ojxvZtybF5/uAByi5wE2NC
	mUOv1xrBIyqOqtlqEahhahyN2F0DwZc3BUU2R5I=
X-Google-Smtp-Source: ACHHUZ5H5K95Kpk87TRkjWo9WIpc6Adgwd3yWRrHTf5xZs1SG7TlATjyOQcw/4vg3MeewhisURNxtHpexbwus+MDKnI=
X-Received: by 2002:a2e:aa26:0:b0:2af:1d0f:4957 with SMTP id
 bf38-20020a2eaa26000000b002af1d0f4957mr34844ljb.5.1685643871289; Thu, 01 Jun
 2023 11:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531110511.64612-1-aspsk@isovalent.com> <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local> <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com> <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
In-Reply-To: <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 11:24:20 -0700
Message-ID: <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
To: Anton Protopopov <aspsk@isovalent.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Joe Stringer <joe@isovalent.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 11:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
> >
> > LRU logic doesn't kick in until the map is full.
>
> In fact, it can: a reproducable example is in the self-test from this pat=
ch
> series. In the test N threads try to insert random values for keys 1..300=
0
> simultaneously. As the result, the map may contain any number of elements=
,
> typically 100 to 1000 (never full 3000, which is also less than the map s=
ize).
> So a user can't really even closely estimate the number of elements in th=
e LRU
> map based on the number of updates (with unique keys). A per-cpu counter
> inc/dec'ed from the kernel side would solve this.

That's odd and unexpected.
Definitely something to investigate and fix in the LRU map.

Pls cc Martin in the future.

> > If your LRU map is not full you shouldn't be using LRU in the first pla=
ce.
>
> This makes sense, yes, especially that LRU evictions may happen randomly,
> without a map being full. I will step back with this patch until we inves=
tigate
> if we can replace LRUs with hashes.
>
> Thanks for the comments!

