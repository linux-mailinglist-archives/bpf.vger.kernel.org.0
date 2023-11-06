Return-Path: <bpf+bounces-14293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9367E297D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276741C20C66
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0928E3C;
	Mon,  6 Nov 2023 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVy9MOCk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223D29400
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 16:13:15 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F423D57;
	Mon,  6 Nov 2023 08:13:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3660024b3a.1;
        Mon, 06 Nov 2023 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699287193; x=1699891993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwloH4lIsaKOBcUH+ktpM/tPuqiiEi1+sP4h2yghMLE=;
        b=OVy9MOCkf1m0/wt1Gigzkd/h/81LP0BMl7RIm0spTSwMqVngmfJCZyAoiSzTlUrf3J
         MOxjz7GVMkdH41Te0Bg8gbCI3EBg7OsU7s0V+8xx148dDdXLQ8MHkRAJN5r8bdkxePd3
         oARfp2h3OtVTUXuG37dyYNh4AeM/m/bY3Vk10JmH0UUHLLOvuWqz+YL7PVPVom9xiOfF
         ycVdaLqcm24w6EBKG1/S6lZxVgcB4vp0sLdogfp3Trkf8fKX6qXrGxBGxyLghgjgeykq
         C5bXNTmYbGqNdHjJP/sEmAiVP1VjKaVV62846mp34KlUE3Cky9TWPtKBj60xPslj1JeP
         QcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287193; x=1699891993;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwloH4lIsaKOBcUH+ktpM/tPuqiiEi1+sP4h2yghMLE=;
        b=lFeJ4q5yk8JUK0QgQbMwWYsyDbrhpCPu0AO3wfu+XSWKPMuJjmMf6PHGFo6pzIxIZS
         7rSUCV+8jRWTqd3SeLs2Yb9sT26VX/G3aEuGUdcLCID/wp+uBHMPbkw6ZlGsmbtC21Lx
         p+FHKyY6FcHZU1EiZ+nkMp0R+ysjnRl+fzPbbk4EvTPW1tcyU8DzEtQeTcGxCHsfLRZB
         pb//shjtC+6p1jKnbVpD8fkVb/gNod7h/UYNUD5O2Iqs9MiYDZetRCXzcMVVXwTicyUk
         JJ+3YJ+nZn9moDB+Oo6eHNdztz/MJds6mqLqOstiOmpD7QK5L0smiymwcagu1MW1URVZ
         dlpw==
X-Gm-Message-State: AOJu0Yy318ahXP/KVtc8FYrAw3Mb5siVS9oE1UsmKog2BCcj0wMe+zxX
	qPNlPnaLe33/6yVfSXasN7I=
X-Google-Smtp-Source: AGHT+IEKAggblLoWq1aCM5CRiM0ajmV9IssT41pHY1U7hoDv/Yag3Hu7evt62z9utMKTaqCR1DKNrw==
X-Received: by 2002:a05:6a20:244f:b0:15e:4084:6480 with SMTP id t15-20020a056a20244f00b0015e40846480mr14969189pzc.27.1699287193441;
        Mon, 06 Nov 2023 08:13:13 -0800 (PST)
Received: from [192.168.0.100] ([183.247.1.75])
        by smtp.gmail.com with ESMTPSA id a10-20020a634d0a000000b005b8ea15c338sm5611879pgb.62.2023.11.06.08.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:13:13 -0800 (PST)
Message-ID: <21a93447-6830-4884-b488-cbac38df1b96@gmail.com>
Date: Tue, 7 Nov 2023 00:13:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Use E2BIG instead of ENOENT
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20231104024444.385484-1-chen.dylane@gmail.com>
 <CAADnVQ+1pNzLRwNNzL-0ai0P281hG=eNO2COrCxuCv2VF3KGUA@mail.gmail.com>
 <CA+92Ff+ZW5wu3mZFs--nxcyJyc7YxEhP-yuL-BEsWzVChR9Jdg@mail.gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CA+92Ff+ZW5wu3mZFs--nxcyJyc7YxEhP-yuL-BEsWzVChR9Jdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi, Alexei, the delete element api of stackmap return E2BIG when the key 
size beyond the buckets size, so i try to keep the same approach. Maybe 
it's not necessary, anyway, thanks for your reply.

在 2023/11/6 下午11:59, Tao Chen 写道:
> 
> 
> ---------- Forwarded message ---------
> 发件人： *Alexei Starovoitov* <alexei.starovoitov@gmail.com 
> <mailto:alexei.starovoitov@gmail.com>>
> Date: 2023年11月5日周日 04:54
> Subject: Re: [PATCH] bpf: Use E2BIG instead of ENOENT
> To: Tao Chen <chen.dylane@gmail.com <mailto:chen.dylane@gmail.com>>
> Cc: Song Liu <song@kernel.org <mailto:song@kernel.org>>, Jiri Olsa 
> <jolsa@kernel.org <mailto:jolsa@kernel.org>>, Alexei Starovoitov 
> <ast@kernel.org <mailto:ast@kernel.org>>, Daniel Borkmann 
> <daniel@iogearbox.net <mailto:daniel@iogearbox.net>>, Andrii Nakryiko 
> <andrii@kernel.org <mailto:andrii@kernel.org>>, Yonghong Song 
> <yonghong.song@linux.dev <mailto:yonghong.song@linux.dev>>, Martin KaFai 
> Lau <martin.lau@linux.dev <mailto:martin.lau@linux.dev>>, John Fastabend 
> <john.fastabend@gmail.com <mailto:john.fastabend@gmail.com>>, Hao Luo 
> <haoluo@google.com <mailto:haoluo@google.com>>, bpf <bpf@vger.kernel.org 
> <mailto:bpf@vger.kernel.org>>, LKML <linux-kernel@vger.kernel.org 
> <mailto:linux-kernel@vger.kernel.org>>
> 
> 
> On Fri, Nov 3, 2023 at 7:44 PM Tao Chen <chen.dylane@gmail.com 
> <mailto:chen.dylane@gmail.com>> wrote:
>  >
>  > Use E2BIG instead of ENOENT when the key size beyond the buckets size,
>  > it seems more meaningful.
> 
> seems more meaningful?
> Sorry. That's hardly a reason to break someone's code.

