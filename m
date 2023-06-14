Return-Path: <bpf+bounces-2593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072B7303C7
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE71F1C20D6B
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40862107A3;
	Wed, 14 Jun 2023 15:25:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C31078C
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:25:19 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027EE6C
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:25:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so11569185a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686756316; x=1689348316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPI4+FdP6c+pbHdmF1mgRUm1mjT/+SOyoMeudGxAt0=;
        b=C/LX4RTvuGO41N3P772wjntFEQtptNI11H8QkvAgareBqx433nUAWW/9h9+8eK+VwI
         CHjCgX6oHwLFVXRRUOvoLz0ET2SRS19iZuIi1rPMNUP3bfglYu1tgZ3weK2GYwSFgNbz
         Xwout/nlIcbg0jDLGypHc+W2YNH8BGl+m46HndMvolJdGQ/4XHtK2vNO4DBINYjNcLiC
         0ouXYlmRdhv8xyJPM2r3CEslnJMQxdpGfFI1hWz7sIfMXV9PNm+wtd9HYgxztCZCYj7a
         9xVQASMgzgd8HNqFNAeKnB691QpFsRKDj19i6hLt0RG28jZH7WeKyodn57GWVPx58Mis
         J52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756316; x=1689348316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPI4+FdP6c+pbHdmF1mgRUm1mjT/+SOyoMeudGxAt0=;
        b=IlAOab0k9Yn6vRCnOKN+aOkAnXqhNyUvP70zmb85uH3kJpBvBh4wSYUabnDoxs3lgf
         Mh0f7qcHO25i0Eq/cWvjOsH6BnzNdfSsH1PaCM9QBuNalCYQxhF23zz6QLHk+xUuAP0o
         zyxihCxdA0VkBxpFcQ0Qb/PUm5Ikx1dl7ZJAJeyBa0AYmzXDtbTxLoRnQ8bTAoWe3tkp
         1XDmmye0DZJzTZV7Pf9Lc8vvBfhu6zNUr6ZLEDX3xsi/4aA12C5VkfJt4ZpQHDJlHYCZ
         VHZogGhsp8Gx2INfqgAYVk0n5Gd7Z+HyaWdBsHqv/8KBvsHEvJOxRO8lWdug74Z+yfoi
         NqWw==
X-Gm-Message-State: AC+VfDwXvoNDyjUXnYgWFgYAYFl/2J3gYSwyMyy/Cuo3CyCxUg3sSusf
	v9Bv/tPBWauKaHDFpiExngBF2K9xjDUrOrzorgDGPQ==
X-Google-Smtp-Source: ACHHUZ7ajRf6auHav1YRoKpK8kR0w+ASMylABKUZwDbhh/NRogyZVfFdUSWP70YmRJeyYXuhJ0UtfmmQcjL//Ktv9x8=
X-Received: by 2002:a17:907:1c1f:b0:982:21a1:c4e0 with SMTP id
 nc31-20020a1709071c1f00b0098221a1c4e0mr8460578ejc.56.1686756316270; Wed, 14
 Jun 2023 08:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com> <20230613185647.64531-1-kuniyu@amazon.com>
In-Reply-To: <20230613185647.64531-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 14 Jun 2023 16:25:05 +0100
Message-ID: <CAN+4W8ijtoew8ouaN3i1NXtg0_G_HHmZyAtf5LsCBb6shCAx2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 7:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
>                         else {
>                                 result =3D sk;
>                         }
>
> The assignment to result below is buggy.  Let's say SO_REUSEPROT group
> have TCP_CLOSE and TCP_ESTABLISHED sockets.

I'm not very familiar with SO_REUSEPORT, I assumed (incorrectly
probably) that such a group would only ever have TCP_CLOSE in UDP case
and TCP_LISTENING in TCP case. Can you explain how I could end up in
this situation?

