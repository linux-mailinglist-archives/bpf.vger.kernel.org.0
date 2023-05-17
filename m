Return-Path: <bpf+bounces-821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D9707250
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BA42816F8
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703E34CF3;
	Wed, 17 May 2023 19:37:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAC111AD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 19:37:18 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF818A255
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:36:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-966287b0f72so211876566b.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352214; x=1686944214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=JI8P++Ejpwah/9ujZLGzlcbeX6IiN9KXWwGGtrkllxq2cwtPfXM/Lg1gSDrOQCtSRF
         ItsLIL8wBg/HFszijwE0LNEONV6N8NHHqFOsEpfMKtc9ejev02a2B80w94ZQZABPUnJR
         T2qDnFjDZPfvcBMFLZ2So/CyHnCFxeyh4zMJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352214; x=1686944214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=OWi0th7dOfBwcoFMGl8DzmvqAQUopDtgXaqBigvNFwqmnAM3YBtkIPoXQlih1DYG+r
         6DRlBJL988j2Zlm6qyFIe6GOpFoavNLYcWk9o6zXx1kaB5smyDdn1w1VgazAlzztFl/7
         NzEYuuI8AaqmvMhAS8KR1A9XHRDcoaiXLbE7+CmQtSsbF3zTifAV8UUZ71I3gjeuZKz/
         ACC+BcZKr/uTXcrlLHcy6YJNu2syVZ8h5Z4R5XX/AuwDsMciGDjz/J9C5TUKecVZNPxj
         AT0zsExQIZWuZvqKuJ44ScMTXPz8dePThZjf25tKJ9w8GcEbZ+AFQvQGD/b+8I1uWgYz
         L+/A==
X-Gm-Message-State: AC+VfDwFd6YEc5yiQ2REb/2ZmWBKdc5eC6oJlKQ2hzFdSQuHLzShDIMU
	fVaJBYzGE6ArnNVA7zpwaggj2LtK7hG5Iei90OrXGeWD
X-Google-Smtp-Source: ACHHUZ5zBNK+kA8ERY2NX4PvxYLxg0Zt3hLo+2XlOd+rDq5DYzAxAldIK8GsLmKJu/GKh0Y1OR0xvQ==
X-Received: by 2002:a17:907:9454:b0:953:291a:6705 with SMTP id dl20-20020a170907945400b00953291a6705mr39003388ejc.17.1684352214170;
        Wed, 17 May 2023 12:36:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id hg8-20020a1709072cc800b00932fa67b48fsm12618795ejc.183.2023.05.17.12.36.53
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:36:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-965e4be7541so209742466b.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:36:53 -0700 (PDT)
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id
 nd12-20020a170907628c00b0094f2a134e01mr38924382ejc.74.1684352212926; Wed, 17
 May 2023 12:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
In-Reply-To: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 May 2023 12:36:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 12:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also note that this does NOT fix the incorrect RCU walks.

.. this is the patch that I think should go on top of it to fix the
misleading "safe" and the incorrect RCU walk.

NOTE! This adds that

        lockdep_assert_held(&event_mutex);

to user_event_enabler_update() too. It's already there in
user_event_enabler_write(), but I'm not actually convinced this has
gotten enough coverage checking, so I also did it in that caller.

Some callers obviously hold that mutex. Others are much less obvious,
eg that user_event_reg() -> update_enable_bit_for() chain. I *assume*
all the 'class->reg()' callers get the event mutex, but I did not in
any way check that it is true.

So that lockdep annotation should be actually *tested* with lockdep
enabled and somebody doing all these operations.

Final note: I do not know this code *AT*ALL*. I'm literally just going
by "this is the only correct coding pattern to use", not by some
deeper understanding of what the code actually wants to do.

                   Linus

