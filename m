Return-Path: <bpf+bounces-13466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F037DA0C3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67D41C210F7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1E3B789;
	Fri, 27 Oct 2023 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IduO2ii"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A393D3A5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:42:57 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6D10CF
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:42:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1754a12.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698432172; x=1699036972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiX1mvDmdjbIOKkoqmLyxPD5EPhJJZK+tQtNffyzoJs=;
        b=1IduO2ii2ITrpdEtqiqs0u/eJtbV3fikzuLnR6iGr6ZADB/3yeGDqJhgIB5e4uvvvg
         XwZelsGB84qx2AiWrL1eQhRu5EQPo82NI8ySgEHuADdbT8sAqs0Z7V1lOHTNnQ7orocS
         zX76OEbIM5gTw/Ni9a83LabwbkgQf0vH/TPqQ/7gl/r81G3hAhNUu/gyrEPYwA5/NW9p
         P7mlhBeOXTo4l8ehp5p9r9bnA3sTNeIMqbIU+1TKvBOlHEbQx1SMLSmrfBy0BjoJRnl/
         i5DKNqTT/G4Xv7+SDRdRs1IuoC7uDBoUV0Tg1KvhiseV9ndMlwsS+cxj/3jsfXOxMv2N
         AYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698432172; x=1699036972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiX1mvDmdjbIOKkoqmLyxPD5EPhJJZK+tQtNffyzoJs=;
        b=d8xyrjBKshWfq7mIYQ+mETDqGeva8XSLjqT6AGTdvPRpvZZxGSzTnuesIW9KA4wFR5
         tc5qxKOcd9jLRenPlRrvMhdOjXJjjRtUiZq90u9yYLWMNaeUYLKJXUIpXVPY1OhGpgUz
         YMZU5Rms/3i+y9NCPKtCazmJc1uWyOiiCwtdBnk6O3IEEG+KFzw9cvX91whCUeBQJ3ys
         fK9Mfli4r9MWBeRiqHYx1h10i5elMn+oYG9RXNvny+ejxHJF/NomA7h8nsJFhuGjtyUy
         8CxEPDaJ5zbugBPphbCCqNosFG2xPDZ4Q4FXQm+fmZ1AHc3eC16v0mupTcb25fXxP5OU
         zEIQ==
X-Gm-Message-State: AOJu0YzTLeBC4LqnDu4xoSPC+66yTLxlpegSJthrYZDsQ/4368Y4arOa
	Llz0y1d79hoiA/8zvasmW5gBVty+LMlzP4zv9011rA==
X-Google-Smtp-Source: AGHT+IGMo/XIqeIFVMM4jafJk2nrpR95w/qocLna2bqsZOsYKAvMB+gt1oewr0j9qnzS4PS0DlwbPQu3FfnLgmFp+XU=
X-Received: by 2002:a50:950b:0:b0:53f:91cb:6904 with SMTP id
 u11-20020a50950b000000b0053f91cb6904mr12740eda.4.1698432172238; Fri, 27 Oct
 2023 11:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027182424.1444845-1-yonghong.song@linux.dev>
In-Reply-To: <20231027182424.1444845-1-yonghong.song@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Oct 2023 20:42:38 +0200
Message-ID: <CANn89iJa4gp4MJMVyfR+gqD+RNcYP21YgtP8b0iu0zSQKomHQg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bpf: Use sockopt_lock_sock() in ip_sock_set_tos()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 8:24=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With latest sync from net-next tree, bpf-next has a bpf selftest failure:
>   [root@arch-fb-vm1 bpf]# ./test_progs -t setget_sockopt
>   ...
>   [   76.194349] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>   ...
>
> Both ip_sock_set_tos() and inet_listen() calls lock_sock(sk) which
> caused a dead lock.
>
> To fix the issue, use sockopt_lock_sock() in ip_sock_set_tos()
> instead. sockopt_lock_sock() will avoid lock_sock() if it is in bpf
> context.
>
> Fixes: 878d951c6712 ("inet: lock the socket in ip_sock_set_tos()")
> Cc: Eric Dumazet <edumazet@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

