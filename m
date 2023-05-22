Return-Path: <bpf+bounces-1031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B121170C40F
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6772811B6
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5516417;
	Mon, 22 May 2023 17:12:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7B13AC9
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 17:12:20 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24303FA
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 10:12:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52867360efcso4404831a12.2
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684775538; x=1687367538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kzg7DZdO+Fx5NTiphKDonLYUjRG7pPKdcN8BEiK0Q5Q=;
        b=liZNMPYz6Ln/UbX2RbKFz0oKNJCytFelVboUK2d9pq1Y84i8RFQpYQjlP1tpDjbwtG
         h+PuxWrI8JmIt9bLqHcjaXSoC01beyn56d7PYV6kfkcZXX+dNaDxc5MqhKqplkaFc3Ky
         Mm7GY4hQNOIhEo5YH9cviKJyc1FPDurYBFeVDxop1BiOGzacOpknf3S16eYWA5fiXBxB
         ee84pIPucMWp1WvXAXGE6I11PVbjAytgbV8Sq7gmLB7KQSWatcM/fJutZwgkaEEdZmPg
         0H8v5syw/rOVZOfK3XL5/jVXjEaM/2GcW5olGc3dDHiw6lU0FhKyNpQfTACCPr5K1yDn
         12aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684775538; x=1687367538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzg7DZdO+Fx5NTiphKDonLYUjRG7pPKdcN8BEiK0Q5Q=;
        b=GJc/Gv2tb4Z+/zo/HQrm/y2w2PdJ8ZKqwOAk2ae97Y2p0lpFADVJojjlw41S77FZwA
         76DHzVUxAQm06zhW/0vwS27fnlUxRjBJq6UgiqhJAbZLtJP2LTQywd+o9ZudZyL6p6Jc
         6cTLCofgQ5rJs03E7kzZ10pVj4zhTjVx8prpETahLxd/Je45NL+aeNrEQRX1d03RFoxO
         V0nZUNVlPJBTAt/DQtsxz6uYTz/4V6wMAq1eBnX86qcqHd1/DnEKHBFRHInaDwrpR7B5
         EMvWkguJjWI1OS1A5aILUpWZN0nwNImrYcNktl+yOzt9m4IZpRqw+vZtun3/hDtnaUKI
         WwOg==
X-Gm-Message-State: AC+VfDwVfDIpsFmYmYfvDLER/eCk9jdYw8C9U534Hu4uGi9MnhX0wRwM
	cw+QGF46kiqHs2xVTnGHR5pI6AlschmxFrGpil3Fwg==
X-Google-Smtp-Source: ACHHUZ42u+20u8Yh+qsy7h0iK2LWRoxiLcZjWSqhvAWKesEjBSGBFLI5AiStgbrXNeg38Rsxmoklpxsg6/IlOq1/Yxg=
X-Received: by 2002:a17:90a:70cf:b0:253:266a:3b00 with SMTP id
 a15-20020a17090a70cf00b00253266a3b00mr10614041pjm.37.1684775538452; Mon, 22
 May 2023 10:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517113351.308771-1-aleksandr.mikhalitsyn@canonical.com>
 <20230517113351.308771-3-aleksandr.mikhalitsyn@canonical.com> <20230519-zielbereich-inkompatibel-79e1a910e3f9@brauner>
In-Reply-To: <20230519-zielbereich-inkompatibel-79e1a910e3f9@brauner>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 22 May 2023 10:12:07 -0700
Message-ID: <CAKH8qBsYWzh0ZYOdYcYYpMeB-2hhOjLzh7EBXbQpGpC3O=R3OQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: core: add getsockopt SO_PEERPIDFD
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Kees Cook <keescook@chromium.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 19, 2023 at 4:03=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, May 17, 2023 at 01:33:50PM +0200, Alexander Mikhalitsyn wrote:
> > Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> > This thing is direct analog of SO_PEERCRED which allows to get plain PI=
D.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v5:
> >       - started using (struct proto)->bpf_bypass_getsockopt hook
>
> Looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

