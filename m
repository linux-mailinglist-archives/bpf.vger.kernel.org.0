Return-Path: <bpf+bounces-742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C6D70637C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 11:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E161C20E71
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBF79D5;
	Wed, 17 May 2023 09:01:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B93D62
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:01:42 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C325FD0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:01:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so4664405a12.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684314081; x=1686906081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BFnzpFnEWHgBCYzwUlEu4io3XMBxiABg4u5t/U4XNM=;
        b=aQ35lN37DYUOGChsdqb0kqQN4HJT38nERHgvEjALuQ7BO+TAECKaybq6G/dAuMj6yq
         4hpn6i6zz4t1w2OsZKeN0ula9iZBr4x1Ai+ZD6WDHES5gfFjtfcFLmG40IkB903jVn7t
         IH8FOPBAudvgqXWRUc76iovKokS1OWF2iFFXtg+BOjLEFFBS9aWUj19ovGyM/Qc+QyFG
         mwAhDMpHLxDfuOE7s57Ph1ANVdGyBIU4yUABXC6NXn7mKmClX/e9egc0J3R8/uVZo5X3
         J/CJMZiyuVFxOEItgq4jUIvxnxFxHuNstZmOLGwz6bb1f73MqJCo4tNCGQGD7Gb7BRJl
         iU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314081; x=1686906081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BFnzpFnEWHgBCYzwUlEu4io3XMBxiABg4u5t/U4XNM=;
        b=Picm1qB3pxUueHfJk+35z0VxXZWbPlfroKaQVI/Z75eYf0pjewzmcT/oiZcxBbsm1n
         teLf+B+WmPmNR23f6QLRyacFwQnHFD1k2n+pm5o79jLJAEp2RSgTUYKHgNiFPN6RjFRX
         iH3YGrHRcQYdxm/D5SxBdtvu1VVwrAZXdlY6mf8x5EQJc4A8YW7pk3KMFhnQ+ozjxGor
         hIomc+SS/xT/K8ksJN/G7GryAsUcQMpXHhi90i8lnTFH+jiSiwSu70jnaOIBIMqSCzVn
         9pF6kRQ5BmamQh6GcxjKHNo+bHEOuX5kT3X0+PkoefBi3rGn+URkZChARkeTJaCZnGcw
         hBCQ==
X-Gm-Message-State: AC+VfDyp6pM1egXIoPimr24YBnm+xwNA6EsmthNgABpmSH5OG90SHLy4
	WmrL5fA4KPHpefarhK3RayV3Y+XRMd1gKp6S8TNAbg==
X-Google-Smtp-Source: ACHHUZ5P75xcx+CWtz+lJaC31PQ4IxYJSQC9FYvo3svbCkpxO/YbHVL4pxqH9BUbLvt4AL2mmI+w2gTcjJsFJ28Ci9I=
X-Received: by 2002:a17:907:a407:b0:965:6a32:451f with SMTP id
 sg7-20020a170907a40700b009656a32451fmr1326875ejc.6.1684314080855; Wed, 17 May
 2023 02:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
In-Reply-To: <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 17 May 2023 10:01:09 +0100
Message-ID: <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/15/23 5:15 AM, Lorenz Bauer wrote:
> > In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, S=
TRUCT, UNION, PTR")
> > I fixed a bug that occurred during resolving of a DATASEC by strategica=
lly resetting
> > resolve_mode. This fixes the immediate bug but leaves us open to future=
 bugs where
> > nested types have to be resolved.
>
> hmm... future bugs like when adding new BTF_KIND in the future?

It could just be refactoring of the codebase? What is the downside of
restoring the mode when popping the item? It also makes push and pop
symmetrical. Feel free to NACK if you don't want this change, not
going to push for it.

