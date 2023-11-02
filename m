Return-Path: <bpf+bounces-13941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BF7DF081
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B304B211C6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5D125DD;
	Thu,  2 Nov 2023 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWZQYbO8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBA7496
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF3C4339A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698922093;
	bh=uVCmri5yX+MDhXil1qI8WZohlpSUqiIyU4eJ6NPgmI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cWZQYbO8OmFGWahMTDABt+z7o7qfeg2DWXg9aAgavwA2rSX3e9gIjmtjrENg6BLxN
	 /qwHMyttnsVaz+Cb3xIia/XIV9VWbB8vSk+fggPY5JM/zSKUDzWrCSR84VMdf0k5NP
	 ZsVaQOEWkwRC3RstufpniMGUs7ulr5huAtm5Qo7mEMIgyRyAd4xYeWbEWqLNUBOL4a
	 ISMB05EmQSq4ehHSwVP/pw+ozpQIWTXGcPlViswzOpazM5FICr59R4m3XrB7RdaI/X
	 45OmxpxrOyGRP5H2t25W9fXZXlkrp0dqpYW1/iPuGJSCiA06ZqEw+/ZgPPGUNF+UOm
	 uBok82M7k+Gyw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso3666305a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 03:48:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3CNt91Lq6ZPcYFxRp1NFBV06UFdeMZ1Os/OeyVMybyBiiA6n6
	gMNaMhsHqBiUrLLQl9gyNdhFDYP993t1BGZ0IkWCZw==
X-Google-Smtp-Source: AGHT+IGMHTRxE4OeDt/BYnPSn+4jdzO4zzkSmsqJKVR4kUdUDdRmYY0s70ndCiybTReZVPlE7Lt5VVNPPq7uBm3pUfg=
X-Received: by 2002:a50:cc48:0:b0:540:2a8f:806f with SMTP id
 n8-20020a50cc48000000b005402a8f806fmr4456038edi.3.1698922091993; Thu, 02 Nov
 2023 03:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
 <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com> <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
In-Reply-To: <cdd87907-e75a-46fd-884f-29fc07f62c32@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Nov 2023 11:48:01 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com>
Message-ID: <CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 11:30=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/11/02 19:01, KP Singh wrote:
> > On Thu, Nov 2, 2023 at 10:42=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-=
4ea2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
> >>
> >> Do you agree that we cannot replace LKM-based LSMs with eBPF-based acc=
ess control mechanisms,
> >> and do you admit that this series makes LKM-based LSMs more difficult =
to use?
> >
> > If you want to do a proper in-tree version of dynamic LSMs. There can
> > be an exported symbol that allocates a dynamic slot and registers LSM
> > hooks to it. This is very doable, but it's not my use case so, I am
> > not going to do it.
> >
> > No it does not make LKM based LSMs difficult to use. I am not ready to
> > have that debate again.  I suggested multiple extensions in my replies
> > which you chose to ignore.
>
> You said
>
>   I think this needs to be discussed if and when we allow LKM based LSMs.=
"
>
> as a response to
>
>   It is Casey's commitment that the LSM infrastructure will not forbid LK=
M-based LSMs.
>   We will start allowing LKM-based LSMs. But it is not clear how we can m=
ake it possible to
>   allow LKM-based LSMs.
>
> , and you suggested combination of static calls (for built-in LSMs) and
> linked list (for LKM-based LSMs).

Tetsuo, this is exactly a technical solution and it works, a very easy
API can be made to enable the LKM based use-case (if the maintainers
agree that they want to enable LKM based LSMs)

I think what you can do is send patches for an API for LKM based LSMs
and have it merged before my series, I will work with the code I have
and make LKM based LSMs work. If this work gets merged, and your
use-case is accepted (I think I can speak for at least Kees [if not
others] too here) we will help you if you get stuck with MAX_LSM_COUNT
or a dual static call and linked list based approach.

>
> So, what is your answer to
>
>   Until I hear the real limitations of using BPF, it's a NAK from me.

The burden of proof is on you. All I can say is that if you wanted to
implement the policy logic you want, you could. If you cannot, please
share specifics and the BPF / LSM community will help.

>
> ? Do you agree to allow dynamically appendable LSM modules?

Nice try, I am for dynamically loadable hook logic, that's why I
implemented the BPF LSM. What you want to ask me is am I for LKM LSMs.
Regarding the LKM based LSMs, it's my opinion that it should be done
with BPF LSM because it's actually safer and does not have the
maintenance overhead that a kernel module has.

My 0.02c, please share code, specifics and if you like your use case,
get it merged with a patch series. From here onwards, I won't be
responding to hypotheticals.

>

