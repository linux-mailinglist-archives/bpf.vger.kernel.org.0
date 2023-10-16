Return-Path: <bpf+bounces-12307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FA7CAB38
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8C71C20B52
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528328DDD;
	Mon, 16 Oct 2023 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEIXTKvZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4F28DB7;
	Mon, 16 Oct 2023 14:19:21 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28169C;
	Mon, 16 Oct 2023 07:19:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7741c2e76a3so302573685a.1;
        Mon, 16 Oct 2023 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697465959; x=1698070759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaBmgQMYFXspbnRigLuICdhIec595YOy6LNlJaUfKHw=;
        b=AEIXTKvZKUfyGbg//vigVH5W2evf65curtwgq9Tg8jA2lJT9oxn8Dw24V2We8nnDDX
         mpdxpa2E8Fk01DJdn+zndIlY5JGGyTnuuglVFBJVW/NVFwydBD+xiyUbfDSjicGftesc
         R/7mnZwx6WQb8iIFf7bEhgnGBzJKBdI50+37w8Kj+LcOhR3EYv2bitZlUnd1iZBhSYUT
         egAYtAq1PwtHAY+4OsABvH8i3Ntn8xQuBkvxq4Dq/FwtCirTHkTIJ/E9jImHlpfTL9jP
         jODid2yf5KAs0SmIIHJbG8Lk5WLawnd1H5HJqzMYMQ3YfRyVIq3bFdGJzAJarwdndW2l
         v6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697465959; x=1698070759;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qaBmgQMYFXspbnRigLuICdhIec595YOy6LNlJaUfKHw=;
        b=pO43ALoSbQ9AWt9lVEylVN6mpZIm8obWGTlBbf84WrGa3HRNt3FTJxRZiZdaaCY1zH
         fG10Hn8Ki2aSjz8ekmQx/S17J7GZSj14rLj/eNs0qTGDx4ya4Gm1c6IqkApPzbbNkBCW
         tXHPIuX4DjyrDPxQxMagsFyhJOOYM6hlDksQ158Sf0O5RkJ4lpbAeNAUvsJyu3wnGS8U
         vY3K8rgYrCbjvPGdcl7NvWbZTsorjMr41zV10fYveF95s+Zi6TSHFiDK8LGz2mn1KezT
         xsSdv+MaOUah7YHkggEEZ4yF1A7AAMMyrMUmnInceKsyILWprnHifFatxuj0rImVu/0x
         XT9Q==
X-Gm-Message-State: AOJu0Yy6NEOuUo/6EWVxLwxjLBnVB7ERwiwb5uRxEadnGhnkb7ooATpY
	TF9uKWshO4LqJnZOArtuCdM=
X-Google-Smtp-Source: AGHT+IHcriAPk3GqbFsnCRYtWQR2/vWfVPmEX+K8GB7lQ4sn+u6jyMKwVhx5slRz9/cnQQJ7Py9ANA==
X-Received: by 2002:a05:620a:1da6:b0:774:26bf:efa2 with SMTP id pj38-20020a05620a1da600b0077426bfefa2mr29684342qkn.58.1697465958964;
        Mon, 16 Oct 2023 07:19:18 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a120e00b00767e2668536sm3041867qkj.17.2023.10.16.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:19:18 -0700 (PDT)
Date: Mon, 16 Oct 2023 10:19:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <652d46664a3db_1980fa29460@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuniyuki Iwashima wrote:
> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> for the connection request until a valid ACK is responded to the SYN+ACK.
> 
> The cookie contains two kinds of host-specific bits, a timestamp and
> secrets, so only can it be validated by the generator.  It means SYN
> Cookie consumes network resources between the client and the server;
> intermediate nodes must remember which nodes to route ACK for the cookie.
> 
> SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
> the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
> backend server and completes another 3WHS.  However, since the server's
> ISN differs from the cookie, the proxy must manage the ISN mappings and
> fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
> node is down, all the connections through it are also down.  Keeping a
> state at proxy is painful from that perspective.
> 
> At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
> Our SYN Proxy consists of the front proxy layer and the backend kernel
> module.  (See slides of netconf [0], p6 - p15)
> 
> The cookie that SYN Proxy generates differs from the kernel's cookie in
> that it contains a secret (called rolling salt) (i) shared by all the proxy
> nodes so that any node can validate ACK and (ii) updated periodically so
> that old cookies cannot be validated.  Also, ISN contains WScale, SACK, and
> ECN, not in TS val.  This is not to sacrifice any connection quality, where
> some customers turn off the timestamp option due to retro CVE.

If easier: I think it should be possible to make the host secret
readable and writable with CAP_NET_ADMIN, to allow synchronizing
between hosts.

For similar reasons as suggested here, a rolling salt might be
useful more broadly too.

