Return-Path: <bpf+bounces-1238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C612711267
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDDD1C20E28
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855251DDDE;
	Thu, 25 May 2023 17:30:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E521D2CC
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:30:32 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F29B6
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:30:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso2558413a12.1
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685035829; x=1687627829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrg0wGoQXSEREgEuXDwK4/LYkxuMAr2Z8R53O2RnVFM=;
        b=gGgi2kSKPfqM7A3gV045neI/ERxl+JRbvAhacIiYgq1zIgZ9gDgHFklR4K55L9LxDS
         DuUvrnZUu3cEt5WJrmAIxZ3wNLyDQ+zAkPyXVF3/97W08L4sQTutXuuaQqd7rZwijhSq
         ee5sqyQi1e2A18wD+4BKDWYovpHKnpG4FvoUlqFXe8vysnIK98sr1TpR5paAaFAcid9W
         dffcbGMtUrRcW5BiiXgvfGAem7BxVy5oHqodASE1R1otJdpYMV6t12P+Fe87jYjxQsWX
         QqaM0EJwj6t7ovBHWIBRrWDZRFh2mA1+WXPvH50Sd/qpeA6TrrzLvfTVvDJWpLvuDKNh
         SWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035829; x=1687627829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrg0wGoQXSEREgEuXDwK4/LYkxuMAr2Z8R53O2RnVFM=;
        b=CUxMLVyO2S0MPBgzyi6lxEQBBKClItdjZgZYID10uFzxWoK9FINvq5ELJSGkbtS40G
         rzyARBL7JYzdKYnIrk4Dl0qN7Hr7ooU3TQbAJHBG0EZuDi3niio/Mgwr58usOqwi5XoT
         V3JfSE5uj0ia00V1lFBFHVq2LOWp+9hc7xlGTA6wSTEuRr8HpvXX/mHbQYCdCzmKCb3W
         +KA1G3GPJ9cLXhbfCRYYYHtaGif0vN/ux6RzX00uH6i3+armhUQfm8VtS1aYFlhyTkl8
         UAzxuRsc37SDXPdEJvfqLlJOaDaujKiYx7P5EmbhUpxNn40OCuog0S8B9pRPr9ua+QG2
         24CQ==
X-Gm-Message-State: AC+VfDxjOPhusSlpXFXfJwg2UNTV/3wCHN+M5WTRgIkJzzRKYWNZpMu8
	u3Pei7K5JptsnybkxWRgwohIukM1Nye3vyyJh0AMZqS+JFg=
X-Google-Smtp-Source: ACHHUZ5ZKeNkQ4A77o0GC+1HfS6qFxP7Pz1C0IgrF6728WBsztDWTpNfj5ytjmBfUfGyrqWlqmfveGyVywt/6NrBcjM=
X-Received: by 2002:a17:907:9715:b0:96a:3f3b:46db with SMTP id
 jg21-20020a170907971500b0096a3f3b46dbmr2080314ejc.2.1685035828876; Thu, 25
 May 2023 10:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524225421.1587859-1-andrii@kernel.org> <20230524225421.1587859-3-andrii@kernel.org>
 <CAADnVQJ1UEDVH6L=CEjbAudgKmDbp26=-3AfU0sFA_j92Dhn7Q@mail.gmail.com>
 <CAEf4BzZNfj1M5NcmUEQLudH0DjiexaR9UZPQ_U+xvbtviXGtAA@mail.gmail.com> <CAADnVQK1cmkc3a287KT0-708wL150CO0V0MLtH6CJeF8HEbnhA@mail.gmail.com>
In-Reply-To: <CAADnVQK1cmkc3a287KT0-708wL150CO0V0MLtH6CJeF8HEbnhA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:30:16 -0700
Message-ID: <CAEf4Bzbf7FFSOsTqtkwcp-k+9jHn7D7Z2R+exyjKv_+oWjq8Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 10:11=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 25, 2023 at 10:05=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 24, 2023 at 8:23=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, May 24, 2023 at 3:55=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > > Getting ID of map/prog/btf/link doesn't give any access to underlyi=
ng
> > > > BPF objects, so there is no point in requiring CAP_SYS_ADMIN for th=
ese
> > > > commands.
> > >
> > > I don't think it's a good idea to allow unpriv to figure out
> > > all prog/map/btf/link IDs.
> > > Since unpriv is typically disabled it's not a security issue,
> > > but rather a concern over abuse of IDR logic and potential
> > > for exploits in *get_next_id() code.
> > > At least CAP_BPF is needed.
> >
> > Ok, sounds good. I was just trying to minimize the number of commands
> > that would need token_fd.
> >
> > BPF_MAP_FREEZE is the one I care about the most, if that one looks
> > good, should we land that single patch?
>
> Sure. Applied.

Great, thank you!

