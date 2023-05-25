Return-Path: <bpf+bounces-1201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1E710349
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 05:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D421C20D35
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A31FB0;
	Thu, 25 May 2023 03:23:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E21FA8
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:23:22 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25C1AC
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:23:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso810681fa.1
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684984987; x=1687576987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdFrQ3VaSR2wBGlbae2Gevwa4eoIU3CL4lCabPW35rQ=;
        b=se8b/unfRnahkJYWWRVEwF5761fWHj1C7su+2QKVtyofVtistWyFuGyflIcJczFipv
         42UjltAyQK7JY9tjMjAEdxnF75mHBfRYZnlI/OD90ynyZIdP8XFijNU/EZb6QkQ8cawQ
         xCV9kZxqB9xzNZt+8AfDN77fzWDpP/jmh6MJkU8i7eE/SbHApUh87lvNAdzkeEsv78Rs
         9WZfkDSL1AdwBqob1sP36eDoXWKzPFH7cQZqxXXr46kxushpZGRjJ3QOhSCo2IcHOKes
         CBOixZUbUEWzRhQv5/NUU0XKVHTrUaN6HSPW4xpLHGOvmFPr3QSU0YGXp5y5EzqymeMA
         BaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684984987; x=1687576987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdFrQ3VaSR2wBGlbae2Gevwa4eoIU3CL4lCabPW35rQ=;
        b=P1DUxk9G5qtQrkH1CiIezaZck7vlmhj16YU0NQtAgz0ZrwfKPQqp1NsWWy8rznKlAo
         LaopfhTI3Jq/IysCbhOruhubfzepp1/Gtuv5UuLFYWToe2RcfoZC8aUvYi9c60CyG9Ke
         yCOyvzv7Y2Rua32/IhhTiOxInt51ysklCZRheOcD9ZqWCbLrjT8nOMS8DHAKP9paQPwx
         FKym6mn2dgNel/TTjLXmirzsQp3hMNjP+Ao++fQX5+FA1Z7o+CI/dLOlwrOKMy8SEI78
         ZOKQjG3l9emDvAimzQiCZReVBIvS3s1GIlYi1hzwvlckRIbYXmwO9ZWJQvF99rV045Rc
         HoLA==
X-Gm-Message-State: AC+VfDxa+bIY8yiDu6FJ5sFGsZiPCAqbkUvODHaBHVUonjocd2XczplS
	WSaOF0vkDG4awIZdxBPa1c07+5NTZweJ9DwRZQY=
X-Google-Smtp-Source: ACHHUZ4Z0KHdbu5pRq3d1AFbdBjIbTjsdZd6b2QMzOX7b1Sz5vpjF/o7+413sdzQ6ebLGCxPBTEdD6rblv9AixPTCmw=
X-Received: by 2002:a2e:a30a:0:b0:2a8:ea22:28b5 with SMTP id
 l10-20020a2ea30a000000b002a8ea2228b5mr539416lje.4.1684984986714; Wed, 24 May
 2023 20:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524225421.1587859-1-andrii@kernel.org> <20230524225421.1587859-3-andrii@kernel.org>
In-Reply-To: <20230524225421.1587859-3-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 May 2023 20:22:55 -0700
Message-ID: <CAADnVQJ1UEDVH6L=CEjbAudgKmDbp26=-3AfU0sFA_j92Dhn7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 3:55=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Getting ID of map/prog/btf/link doesn't give any access to underlying
> BPF objects, so there is no point in requiring CAP_SYS_ADMIN for these
> commands.

I don't think it's a good idea to allow unpriv to figure out
all prog/map/btf/link IDs.
Since unpriv is typically disabled it's not a security issue,
but rather a concern over abuse of IDR logic and potential
for exploits in *get_next_id() code.
At least CAP_BPF is needed.

