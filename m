Return-Path: <bpf+bounces-2374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3572BBFC
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572FD281099
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B81772F;
	Mon, 12 Jun 2023 09:22:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEC101D0
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 09:22:26 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C34C05
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9a81da5d7so315381cf.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=7wUiTG0MmA7y+2lEinSm8giFjQJ6k0IDdL+is2Qw8cH14kEFKpZyKzAPPtwqLt/xBz
         eR4ss+OnelXP6bltOJo8JCbhScmYimFC53jjp2maM6atl4VhalAajHvqTz+c7vJnSkjL
         ZSvBC5coCX+q2tryUXmvGRMTvCUkcQc1xppJ7C9bof++HL2Hty/nrzozzodMtDO8MYtz
         9MBnl6xyZU4UTYrj+jDfey6Z5LMldODvWpWAlA0ArvaY0A/T1oI8EbSFV9L52cd8BjV2
         cS+pUKjhRNV2OEqhIF3UmmbjHIG1qJB1ZwbuKK0Q47sdcaOY8yiYSTWe/P0EqOoRneah
         eazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561744; x=1689153744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1dwKlQl3ch+rjWH3WakkZnRUyhMTlzScusDmgGxFrg=;
        b=dpuYblao41dsF/0WD4vNm3M/V3bjwHjTV8BdZPgKGVFKKjs4sGKsd2NNuxdb+KFZZB
         DgC841CIyrlV/u7ZYlf6Qf70X/6UW+VHQy+MnsM9nb+97Hauvr6crc5xWJVJ072HrikW
         mqYh9rmu6DgXi/7FrgXe4Vllqr6f5dkANZe3rLaK7MFD+d+D4X37niY6YCsdv+fxERqG
         gMqNYgJFQi9vKIQb4VRPSSP9NrU55Nv3DuXsvtM5iL8cG882HWrtZcyUnlRlfXtKMOp6
         JUIs5xL4ZbxM3TydWZSfcPMhe4oeQny6aD+Dd3RWtFZ2s3+WIaTYfrxJNjs4qssE7jz9
         Fjbg==
X-Gm-Message-State: AC+VfDxl2mfo+mlwL1h5kLqX1wIo9lCP0liAZu4PNbm7Y6WLP1Fub/8S
	imBhqTL70IyAFU/w1TI520UzPU4+AREqmHmf/xB6fw==
X-Google-Smtp-Source: ACHHUZ51q8jd03XKL1NPqfVUpJ4pFcDkHkIvsYbMu+HQ8MbVxEfdIQG/UU8zuNvgxNJ/w6TPxfMn2uZ9T0lxjQ4932M=
X-Received: by 2002:a05:622a:1899:b0:3f9:a770:7279 with SMTP id
 v25-20020a05622a189900b003f9a7707279mr235109qtc.9.1686561743953; Mon, 12 Jun
 2023 02:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com> <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230608202628.837772-3-aleksandr.mikhalitsyn@canonical.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jun 2023 11:22:12 +0200
Message-ID: <CANn89iLT0SFf_2BVFhODYFWmr1rPu1o-AOaOhbGeLvAwuq5XbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/4] net: core: add getsockopt SO_PEERPIDFD
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 10:26=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
> This thing is direct analog of SO_PEERCRED which allows to get plain PID.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

