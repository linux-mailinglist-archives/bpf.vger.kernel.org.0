Return-Path: <bpf+bounces-4441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCD74B52F
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719401C21021
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FA1079A;
	Fri,  7 Jul 2023 16:44:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3A23C5
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:44:55 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC27210B
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:44:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso34086551fa.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688748292; x=1691340292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt1SQYDcUbjE7Qdf5fX/Q0NCVbpk0sTfua7RiKS/VUQ=;
        b=PVOYYkyVl9XFrf1W9JAnyVpMSoDMykDF2oiwaQhFg3BqSfpHrBBKByKG6sVwMA9cuz
         /TpWoB+4WWipn62fVYNpsa8TSSwGSPi1I7QXl+ddluUiHSs4DjJv8qzF8kCUiExTTa3Z
         ZjtFRxaTk67JJOzW/st7IW3Hsdc50Phq85fK96w9NYR7xIAf6Jtl24WAWfRKg/xSF9bS
         MPSefYt+5zON1m/J3neTfZn8EOTyifY6xlGJ+37UsG6Xg1eJgUm5PQVox41MSSw2sS2a
         qv4LGnPiG46D67s4Vj5KEjrsFT3I9JFwoVjZuRg3YsYKCHqKbSpcvONYpDkNyBWjrQNL
         asrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748292; x=1691340292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt1SQYDcUbjE7Qdf5fX/Q0NCVbpk0sTfua7RiKS/VUQ=;
        b=OXdFGS4iqth7WBUOJH18WoEiUsF36q50S1zywCLsUXdmW2CidhO0zBqY2qdXZMacCx
         LYVQEhIzLItzfDg/WUUAHhC4gZXZTiYqsgPJxs0drUdPrfuJhs6S7MVALtXNT1S3dNoF
         PBUDn4WQG11/WSk+/1bWvHsk2Y2yrCc2HiAGnMfjw2yJRvW347+/vpwV84A7C+OYYaay
         zCYRawHsg/2rQ6tx0QZawRy3JjQVPRjP1sfmeG7hYSLG1zI7d6q04mwccwnOJXfDSelc
         rm+kQ4IgT+HmcM2Xh2zquaGF70kW/L7foXklVF3VYs5uCKqQR2poqf3gbL8zfI7qfGDW
         t/zA==
X-Gm-Message-State: ABy/qLYVGFlVRjeXsAC+g6iKXDtHSuHvqC1TyVTq4erZAxbAjGZwHSZW
	W5kvZ8e+IOySctNd8BZH/wxfKmKn8mfDOMQuJa4=
X-Google-Smtp-Source: APBJJlHJbJUnOMHJWpXT0pek8qhBhwMvLvkF0CHAh2Q4iLsygr0yRrPngyloIpZhHxrHJUBL0QFv4HlYyNxdnk6HCqM=
X-Received: by 2002:a2e:9208:0:b0:2b6:f009:921a with SMTP id
 k8-20020a2e9208000000b002b6f009921amr3995986ljg.13.1688748292207; Fri, 07 Jul
 2023 09:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
In-Reply-To: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jul 2023 09:44:40 -0700
Message-ID: <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail.com> =
wrote:
>
> When it comes to fixing the problem, I don't quite know where to start.
> Perhaps these iteration callbacks ought to be treated more like global fu=
nctions
> -- you can't always make assumptions about the state of the data in the c=
ontext
> pointer. Treating the context pointer as totally opaque seems bad from
> a usability
> perspective. Maybe there's a way to attempt to verify the function
> body of the function
> by treating all or part of the context as read-only, and then if that
> fails, go back and
> assume nothing about that part of the context structure. What is the
> right way to
> think about plugging this hole?

'treat as global' might be a way to fix it, but it will likely break
some setups, since people passing pointers in a context and current
global func verification doesn't support that.
I think the simplest fix would be to disallow writes into any pointers
within a ctx. Writes to scalars should still be allowed.
Much more complex fix would be to verify callbacks as
process_iter_next_call(). See giant comment next to it.
But since we need a fix for stable I'd try the simple approach first.
Could you try to implement that?

