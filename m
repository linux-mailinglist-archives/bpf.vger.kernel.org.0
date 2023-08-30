Return-Path: <bpf+bounces-9005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7732878E161
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521181C2085F
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE791882B;
	Wed, 30 Aug 2023 21:26:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3F749B;
	Wed, 30 Aug 2023 21:26:14 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED09E67;
	Wed, 30 Aug 2023 14:25:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso4578901fa.0;
        Wed, 30 Aug 2023 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693430671; x=1694035471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHG9pZCkrp6HTGnJDKRoXu+Y5Po9SCLa3aS4SGZHT7M=;
        b=Yd75t2kmjBCkqO6qYfsIrctSUxdg7r54HB3EkCoexSIvx5uPT2X69hDdr+XGoG3rhL
         Gt56PLKAb4IDxVOmkqN+dA7Wip5ATnrnpv9KALPs0L5/OVkI00kMx+wi33ntUhkYHEX+
         6C+w5zu4hwoHobYxFTlBa/Zq+RpdPXs+hw3dcKmFSf2GcGPPm0ZYcpNxgdnV05Lr12Et
         afDWd8FnH4cVxIfGHt5kXVEFA3Qfh4IxgOxluRlddAIZwSug/+lb5mQOV+0pmuFhVrcF
         YAtNbIBTgX5S2nUFpj7aU3dMyvMm+MA9NiivaU0ODYsNzLvzFbD4i39TUcZhqPVg4gL+
         iXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430671; x=1694035471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHG9pZCkrp6HTGnJDKRoXu+Y5Po9SCLa3aS4SGZHT7M=;
        b=NDIOSk6PgsQywJAOwSPGWrqaa27pkJlZMmcDJuO4d8S/6ZYVsl86D7592CK1bnV3Ic
         RVn223ioDjgZJNo6HDmvv/q2zopuJ4jhdp1kUNNDktGB9SMhgarcBCY2clJhAIRBvxyn
         5uoGYmcljWPhdeRGBArWc/30j/Lo85BAEPUdrc9zJWmnPIVaGYn7t6ejIk0OJTuhesPr
         onHotjUmGTU4k3iWTOd7LIYpu6HC9KIkLEQUKfowun2bLxoloyzL/FiTuuXWVd4PkUG4
         VJiTLLVa+D3IQnxgivXabvIN1vCZ4NNk0wILlNyqOZGIbbj7WsJ7v51I79+nzCm9d+dg
         jU5w==
X-Gm-Message-State: AOJu0YwUs58oNiufwcGsBnMe0QAJ6bUd/cfOfSXDecXBhbmfx2P2NYqf
	RYp7CV2FTL5r4DWSjOMmset8sp6PkhVAFyhFTwp17iUS/Cw=
X-Google-Smtp-Source: AGHT+IHptGTpoOL2ARmFnXEy+uwcPkQNSKH6EYjXDfjMcdkz9xFLdBxAs9k2GacT4seO0h9F9jC9RA2GvcevWcjkI58=
X-Received: by 2002:a2e:6816:0:b0:2bd:1f8d:e89d with SMTP id
 c22-20020a2e6816000000b002bd1f8de89dmr2962409lja.3.1693430670696; Wed, 30 Aug
 2023 14:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZO6O27Z9RvresmiV@google.com>
In-Reply-To: <ZO6O27Z9RvresmiV@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Aug 2023 14:24:19 -0700
Message-ID: <CAADnVQJdB-vQwEsfq1uk8VciXUxu1RQgC3xZhRCOd==wxwi6iQ@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 6.6
To: Stanislav Fomichev <sdf@google.com>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 5:35=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> See the netdev posting for more info and context:
> https://lore.kernel.org/netdev/20230829150539.6f998d1f@kernel.org/T/#u
>
> As last time, I'm presenting raw stats without any evaluation. I'm
> posting a link to the previous cycle below so people can do the
> comparison if needed. I'm also trying to present the same data as we
> have in netdev email so you can follow Jakub's comments about script
> changes/etc.
>
> Previous cycle:
> 27 Apr to 28 Jun: 4234 mailing list messages, 62 days, 68 messages per da=
y
> 664 repo commits (11 commits/day)
>
> Current cycle:
> 28 Jun to 29 Aug: 5240 mailing list messages, 62 days, 85 messages per da=
y
> 384 repo commits (6 commits/day)

That is a big jump in activity.
Every bpf developer needs to internalize what "85 messages per day"
really means.
Put yourself in maintainer's shoes.
Patches will be applied only after they're reviewed.
When developers only send patches they slow down themselves and
all other developers. Every active developer needs to code review as well.

We all want patches to move swiftly, so please help maintainers and
yourself: review as many patches as you can.
This will speed up the patch queue and every developer will benefit.
win/win for both developers and maintainers.

>
> 6.5 stats: https://lore.kernel.org/netdev/20230829150539.6f998d1f@kernel.=
org/T/#u
>
> Rankings
> --------
>
> Top reviewers (thr):                 Top reviewers (msg):
>    1 ( +1) [11] Alexei Starovoitov      1 ( +1) [23] Alexei Starovoitov
>    2 ( -1) [ 7] Yonghong Song           2 ( +1) [15] Yonghong Song
>    3 ( +5) [ 4] Martin KaFai Lau        3 ( +4) [ 9] Stanislav Fomichev
>    4 ( +3) [ 4] Stanislav Fomichev      4 ( -3) [ 7] Andrii Nakryiko
>    5 ( -1) [ 4] Daniel Borkmann         5 ( +5) [ 7] Martin KaFai Lau
>    6 ( +3) [ 3] Jakub Kicinski          6 (+15) [ 5] Hou Tao
>    7 ( -2) [ 3] Jiri Olsa               7 ( +7) [ 5] Jakub Kicinski
>    8 ( -5) [ 2] Andrii Nakryiko         8 ( -2) [ 4] Daniel Borkmann
>    9 (***) [ 2] Hou Tao                 9 (+13) [ 4] Jesper Dangaard Brou=
er
>   10 (+16) [ 2] Jesper Dangaard Brouer   10 (+17) [ 4] Eduard Zingerman
>   11 ( +7) [ 2] John Fastabend         11 ( -2) [ 4] Steven Rostedt
>   12 ( +3) [ 2] Eduard Zingerman       12 (***) [ 4] Alan Maguire

BIG thank you to all reviewers.
You're doing an excellent job.

>
> Top authors (thr):                   Top authors (msg):
>    1 ( +9) [3] Yonghong Song            1 ( +5) [20] Jiri Olsa
>    2 (   ) [2] Yafang Shao              2 (+30) [17] Yonghong Song
>    3 (***) [2] Geliang Tang             3 ( +8) [10] Larysa Zaremba
>    4 ( +5) [1] Daniel Borkmann          4 (   ) [10] Masami Hiramatsu (Go=
ogle)
>    5 ( +2) [1] Masami Hiramatsu (Google)    5 (***) [ 8] Geliang Tang
>    6 ( -2) [1] Jiri Olsa                6 ( -3) [ 8] Maciej Fijalkowski
>    7 (+19) [1] Kui-Feng Lee             7 ( -5) [ 6] Yafang Shao
>    8 (+40) [1] Dave Marchevsky          8 (+12) [ 6] Dave Marchevsky
>    9 (***) [1] Rong Tao                 9 (+15) [ 5] Daniel Borkmann
>   10 (***) [1] Daniel Xu               10 (***) [ 5] Hao Xu
>
> Company rankings
> ----------------
>
> Top reviewers (thr):                 Top reviewers (msg):
>    1 (   ) [20] Meta                    1 (   ) [50] Meta
>    2 (   ) [ 8] Isovalent               2 (   ) [16] RedHat
>    3 (   ) [ 7] Google                  3 ( +1) [15] Google
>    4 (   ) [ 6] RedHat                  4 ( -1) [12] Isovalent
>    5 (   ) [ 3] Intel                   5 (   ) [ 7] Intel
>    6 ( +3) [ 3] Huawei                  6 ( +2) [ 7] Huawei
>    7 (+24) [ 2] Oracle                  7 (+41) [ 4] Oracle
>    8 ( -2) [ 2] Corigine                8 (+49) [ 3] Rivos
>    9 ( -1) [ 1] nVidia                  9 ( -3) [ 3] Corigine
>   10 (+34) [ 1] Rivos                  10 ( -3) [ 2] nVidia
>
> Top authors (thr):                   Top authors (msg):
>    1 (   ) [9] Meta                     1 (   ) [40] Meta
>    2 ( +3) [6] Huawei                   2 ( +1) [31] Isovalent
>    3 ( -1) [4] Isovalent                3 ( +1) [24] Intel
>    4 ( -1) [3] Google                   4 ( +2) [19] Huawei
>    5 ( +1) [3] Intel                    5 ( -3) [17] Google
>    6 ( -2) [2] RedHat                   6 ( +2) [ 9] RedHat
>    7 (***) [2] Juniper Networks         7 (***) [ 8] SUSE
>    8 (***) [2] SUSE                     8 ( +5) [ 7] Bytedance
>    9 ( +8) [1] Oracle                   9 (***) [ 6] Juniper Networks
>   10 (+42) [1] Linaro                  10 (***) [ 5] Hao Xu
>
> Development vs reviewing scores
> -------------------------------
>
> Top scores (positive):               Top scores (negative):
>    1 ( +1) [144] Alexei Starovoitov     1 (***) [46] Jiri Olsa
>    2 ( +4) [ 50] Martin KaFai Lau       2 ( +4) [39] Larysa Zaremba
>    3 (+15) [ 40] Stanislav Fomichev     3 (   ) [37] Masami Hiramatsu (Go=
ogle)
>    4 ( -3) [ 38] Yonghong Song          4 (***) [34] Geliang Tang
>    5 ( +4) [ 37] Jakub Kicinski         5 ( +7) [22] Dave Marchevsky
>    6 ( -1) [ 34] Andrii Nakryiko        6 ( -4) [22] Maciej Fijalkowski
>    7 (***) [ 30] Jesper Dangaard Brouer    7 (***) [19] Hao Xu
>    8 (***) [ 25] John Fastabend         8 (+26) [18] Roberto Sassu
>    9 (***) [ 24] Hou Tao                9 (***) [16] Valentin Schneider
>   10 ( -7) [ 23] Daniel Borkmann       10 (***) [16] Tejun Heo

Jiri,
you've managed to be in the top reviewers and top negative :)
I guess that means that we need to tweak the positive/negative formula
to more accurately represent the value each person brings
to the community.

>
> Top scores (positive):               Top scores (negative):
>    1 (   ) [142] Meta                   1 ( +1) [49] Intel
>    2 (   ) [ 52] RedHat                 2 (+11) [38] Huawei
>    3 (***) [ 28] Google                 3 ( +5) [28] Bytedance
>    4 ( -1) [ 22] Corigine               4 (***) [22] SUSE
>    5 (***) [ 18] Oracle                 5 (***) [19] Isovalent
>    6 (+37) [  8] Rivos                  6 (***) [19] Hao Xu
>    7 ( -2) [  8] Microsoft              7 ( -3) [13] Alibaba
>    8 (***) [  7] Markus Elfring         8 (***) [12] Aviatrix
>    9 (   ) [  6] Amazon                 9 (***) [12] Juniper Networks
>   10 (***) [  5] Huacai Chen           10 (***) [11] Leon Hwang
>   11 (+28) [  5] Dave Thaler           11 (***) [10] IBM
>
> More raw stats
> --------------
>
> Prev: start: Thu, 27 Apr 2023 08:55:55 +0200
>         end: Wed, 28 Jun 2023 17:27:38 +0200
> Prev: messages: 4234 days: 62 (68 msg/day)
> Prev: direct commits: 664 (11 commits/day)
> Prev: people/aliases: 241  {'author': 89, 'commenter': 103, 'both': 49}
> Prev: review pct: 12.95%  x-corp pct: 12.05%
>
> Curr: start: Wed, 28 Jun 2023 22:18:25 -0700
>         end: Tue, 29 Aug 2023 15:24:18 -0700
> Curr: messages: 5240 days: 62 (85 msg/day)
> Curr: direct commits: 384 (6 commits/day)
> Curr: people/aliases: 279  {'author': 112, 'commenter': 120, 'both': 47}
> Curr: review pct: 24.22%  x-corp pct: 23.44%
>
> Diff: +23.8% msg/day
> Diff: -42.2% commits/day
> Diff: +15.8% people/day
> Diff: review pct: +11.3%
>       x-corp pct: +11.4%
>

