Return-Path: <bpf+bounces-16282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CB7FF406
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DEB2107D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601853811;
	Thu, 30 Nov 2023 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/GBRaRv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65810D5;
	Thu, 30 Nov 2023 07:54:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso853998a12.1;
        Thu, 30 Nov 2023 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701359679; x=1701964479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SEGQMTDM9nIwkV/HUIBS14c5J5qAwdGyfYFq/Vjc8o=;
        b=N/GBRaRvH/ya7kg0T2sHwYMdBqUQ4OyfzaEPkwlFaLKPRRCeLWy9TaTcq/X5zlEt0x
         0/j4T6t/gCgPbIpY/TNyDHglAvagmBOBNrpaTMfc3DKCi18TOleIRJMZFE7qEIeL8Qu0
         /8GyWV3ZNHUvo2IZfmuyoih5hGDBnqenHQcyZpZcpxPEl8ULw4dejYp+UgPOjtGZg0fz
         1Rc5irYs2QDDI4XbU05pWduzUHXZzxuLQN+t9g4SXQBgNg7Ige1Y1viW4rkFdfKYRVFm
         lvPTcXuXFWNpiX35oEN2yCXJ/sXfOvS+Glm+R4hWBLN1tJQhy0EIknltycNKskvALiiV
         /6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701359679; x=1701964479;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SEGQMTDM9nIwkV/HUIBS14c5J5qAwdGyfYFq/Vjc8o=;
        b=lxKMRzCnCEJvxtkErx6c/q7W9yDvHItYqgLBs03cYBTDeaj4WjgX7Wi0JRE9R9cnxb
         1hPUi6uW4s8eVkQNy6Z/S7MT3j/j0yKdsTlxIWJpTbEbvurGFk8twWh5NfNJ5WlTEeRu
         lFTC3LroJE3ntRri2JjJuhRzalYE7/DUtmv0siuCkqjuyeV3F5KbomdEtX/7LsIpGV+j
         /Wz/0PcpCn4rrjBJ9mf4S7JiaI0Lpa5x1VSrrn7Wp0WBWGujYDYeKBxW4z1P5hlL2FtJ
         rp8VVsVC9y3ZNmPJeqHwSOcjR3wq1DSCxlX5cyObwQnqhYGHiK3uOKi6FIKjFO1qK/Ek
         kVSg==
X-Gm-Message-State: AOJu0YzA+8AiAyOuY+9xE7FNiNG+FQlEGAjwgolRY1eYYEladX3c/VI3
	HkEspYpBakxbjdqxRRFlDlQ=
X-Google-Smtp-Source: AGHT+IEuvjIe4wkG0SuuT+uuCcHxxohkSxvU+YD+z3xS6xwZ9Uh6MTAq9f8PID06mw39uv4zNSsETg==
X-Received: by 2002:a05:6a21:a591:b0:18c:138e:f268 with SMTP id gd17-20020a056a21a59100b0018c138ef268mr23600964pzc.21.1701359678849;
        Thu, 30 Nov 2023 07:54:38 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:1053:7b0:e3cc:7b48])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79d05000000b006cbcd08ed56sm1369884pfp.56.2023.11.30.07.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:54:37 -0800 (PST)
Date: Thu, 30 Nov 2023 07:54:36 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com
Message-ID: <6568b03cbceb7_1b8920827@john.notmuch>
In-Reply-To: <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net>
References: <20231129234916.16128-1-daniel@iogearbox.net>
 <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
 <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net>
Subject: Re: pull-request: bpf 2023-11-30
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> On 11/30/23 3:53 PM, Eric Dumazet wrote:
> > On Thu, Nov 30, 2023 at 12:49=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>
> >> Hi David, hi Jakub, hi Paolo, hi Eric,
> >>
> >> The following pull-request contains BPF updates for your *net* tree.=

> >>
> >> We've added 5 non-merge commits during the last 7 day(s) which conta=
in
> >> a total of 10 files changed, 66 insertions(+), 15 deletions(-).
> >>
> >> The main changes are:
> >>
> >> 1) Fix AF_UNIX splat from use after free in BPF sockmap, from John F=
astabend.
> > =

> > syzbot is not happy with this patch.
> > =

> > Would the following fix make sense?
> > =

> > diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> > index 7ea7c3a0d0d06224f49ad5f073bf772b9528a30a..58e89361059fbf9d5942c=
6dd268dd80ac4b57098
> > 100644
> > --- a/net/unix/unix_bpf.c
> > +++ b/net/unix/unix_bpf.c
> > @@ -168,7 +168,8 @@ int unix_stream_bpf_update_proto(struct sock *sk,=

> > struct sk_psock *psock, bool r
> >          }
> > =

> >          sk_pair =3D unix_peer(sk);
> > -       sock_hold(sk_pair);
> > +       if (sk_pair)
> > +               sock_hold(sk_pair);
> >          psock->sk_pair =3D sk_pair;
> >          unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
> >          sock_replace_proto(sk, &unix_stream_bpf_prot);
> > =

> =

> Oh well :/ Above looks reasonable to me, thanks, but I'll defer to John=
 & Jakub (both Cc'ed)
> for a final look.
> =

> Thanks,
> Daniel

Is that sk in LISTEN state by any chance? I can't think why we even allow=
 such a
thing for af_unix sockets.  Another possible fix would be to block adding=
 these
to sockmap at all.

But, above should be fine as well so I would just go with that. Eric or D=
aniel
would you like to submit a patch or I can if needed.

Thanks,
John=

