Return-Path: <bpf+bounces-3306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D473BEA2
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE7281CCF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F93101EC;
	Fri, 23 Jun 2023 18:57:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8FA93B;
	Fri, 23 Jun 2023 18:57:38 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9781FDF;
	Fri, 23 Jun 2023 11:57:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-763d415bd94so51748785a.0;
        Fri, 23 Jun 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687546656; x=1690138656;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTEzk8KxQBuNuPAdkmA38KyChYKwlVchD92bIetqW9E=;
        b=NQsaSi3XMkHD6aGKyo1ptQIcYKA8MXPS0/41xdAmoTFoHc8Lyg2HzqNradKRLfdtTt
         e66LEWk7sCtJ4lYVlQCqTiIDaOqpISZjeb+zp9DBdJ1ege3pA2sm5VThSyOKtm2LtH3Z
         UlXl+JsgvEItSGJLLhwB7pVVPNDZKQSlWDrHAgCSqSc72WMrwzCSMcthxqY6halIu0ol
         mOK7ZtZshEhON9bvwz46Zr6KlYa9p6i7W0KWcquqES+MJB440MkXfFMFBi5KzYrH+kTI
         EyRXuxRa1bk8hVRQW91bLcrm6b2RNVNbYKVYaxGrFWy2gTgWY9QTwWVodnUjOA8kHFnb
         hXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546656; x=1690138656;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTEzk8KxQBuNuPAdkmA38KyChYKwlVchD92bIetqW9E=;
        b=HavtD1Mis9BCNfb3y2aBeOPBN0PcWpvAMbjCMKrBLwxJ61eUvGriraC6Ocg+iXzSmQ
         ONcyysv1Nl188b9Hzm87RQB7cUACYBr6q+RGHdHGSW4BUyGhhuvYkYmBME1UN95U0Hws
         iNtO+G2ugDY+1pik1dC3yvRygsF1onrvERAApCQKnGZ8QEDZM8tuy46dWTFDC0/O2WUK
         sHWgZmE73WlDHrmltR6Y3nJjqIzdhvK54fNI/YIJ5sFQdlrNjGmHFABamHQpP3r9FYz9
         G3ataFMu49jSeH+RoOyZ8wLI5H0oJHg6xVH6PZ1FqKjz4wN7e/i0PTOhCoLgrTc07L5U
         tprA==
X-Gm-Message-State: AC+VfDzCxZ9lrl3weeX2LC4capz+/MCEZWqcItOdvRUjoO/SLA2ffm0a
	Pfm0vex22aFd4xA5fFtTxChvZeTETndmrw==
X-Google-Smtp-Source: ACHHUZ4UD06DJmMOwYIAQbqX9y2MUiorDlwklwdOIkJqInFS/5DIt3f8xxmq3Z9ZFS2U2bPmOkBGxw==
X-Received: by 2002:a05:620a:21ce:b0:763:d145:b03c with SMTP id h14-20020a05620a21ce00b00763d145b03cmr7230902qka.3.1687546655832;
        Fri, 23 Jun 2023 11:57:35 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a10aa00b0074411b03972sm1121255qkk.51.2023.06.23.11.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 11:57:35 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>,  bpf <bpf@vger.kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yhs@fb.com>,  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Network Development <netdev@vger.kernel.org> 
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
In-Reply-To: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 22 Jun 2023 19:35:51 -0700")
Date: Fri, 23 Jun 2023 19:57:10 +0100
Message-ID: <m2bkh69fcp.fsf@gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
	<20230621170244.1283336-12-sdf@google.com>
	<20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
	<CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
	<CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
	<CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
	<CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Jun 22, 2023 at 3:13=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
>>
>> We want to provide common sane interfaces/abstractions via kfuncs.
>> That will make most BPF programs portable from mlx to brcm (for
>> example) without doing a rewrite.
>> We're also exposing raw (readonly) descriptors (via that get_ctx
>> helper) to the users who know what to do with them.
>> Most users don't know what to do with raw descriptors;
>
> Why do you think so?
> Who are those users?
> I see your proposal and thumbs up from onlookers.
> afaict there are zero users for rx side hw hints too.

We have customers in various sectors that want to use rx hw timestamps.

There are several use cases especially in Telco where they use DPDK
today and want to move to AF_XDP but they need to be able to benefit
from the hw capabilities of the NICs they purchase. Not having access to
hw offloads on rx and tx is a barrier to AF_XDP adoption.

The most notable gaps in AF_XDP are checksum offloads and multi buffer
support.

>> the specs are
>> not public; things can change depending on fw version/etc/etc.
>> So the progs that touch raw descriptors are not the primary use-case.
>> (that was the tl;dr for rx part, seems like it applies here?)
>>
>> Let's maybe discuss that mlx5 example? Are you proposing to do
>> something along these lines?
>>
>> void mlx5e_devtx_submit(struct mlx5e_tx_wqe *wqe);
>> void mlx5e_devtx_complete(struct mlx5_cqe64 *cqe);
>>
>> If yes, I'm missing how we define the common kfuncs in this case. The
>> kfuncs need to have some common context. We're defining them with:
>> bpf_devtx_<kfunc>(const struct devtx_frame *ctx);
>
> I'm looking at xdp_metadata and wondering who's using it.
> I haven't seen a single bug report.
> No bugs means no one is using it. There is zero chance that we managed
> to implement it bug-free on the first try.

Nobody is using xdp_metadata today, not because they don't want to, but
because there was no consensus for how to use it. We have internal POCs
that use xdp_metadata and are still trying to build the foundations
needed to support it consistently across different hardware. Jesper
Brouer proposed a way to describe xdp_metadata with BTF and it was
rejected. The current plan to use kfuncs for xdp hints is the most
recent attempt to find a solution.

> So new tx side things look like a feature creep to me.
> rx side is far from proven to be useful for anything.
> Yet you want to add new things.

We have telcos and large enterprises that either use DPDK or use
proprietary solutions for getting traffic to user space. They want to
move to AF_XDP but without at least RX and TX checksum offloads they are
paying a CPU tax for using AF_XDP. One customer is also waiting for
multi-buffer support to land before they can adopt AF_XDP.

So, no it's not feature creep, it's a set of required features to reach
minimum viable product to be able to move out of a lab and replace
legacy in production.

