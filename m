Return-Path: <bpf+bounces-7378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938A7764FE
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1CC1C212B8
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF31CA14;
	Wed,  9 Aug 2023 16:27:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919F1AA83
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:27:05 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37E10F3
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:27:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso36903a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691598423; x=1692203223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9slY7L6wCBcCqclWRszu0YEXVQ+ftiI5ObGkzjdqrg=;
        b=l34yiPQwzUm7bzfUSUWpEvPTpUP9ao2GfVObE0lvHLRnMzOppIkqBkNpnJpblmjnGC
         vjG/7MaN4Yms92toXNu0q7ix+6zAxmfeC3Fg9PUf+OzRfzyOgqqhqOikD/uTsyTD13E2
         jf0JX/D38w+dTWvwcaC5PG8f6UbX52AA86oUEB+EDmyk/3Bm+RpahVqSBArYe4Mzv7cW
         Be7GtLV9XN2CzAdV2wdD1I4ys45KmACwFFqlWyvIEeKuP3RP/m/zKoFOySJ9BRd8gEZF
         Mt/Lk3MM1cCB8gF65WVk+c5xZh6td/d5FNl+uFoHTHUDmLjaLHTbExP/RwL1RAgpMZRM
         alBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598423; x=1692203223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9slY7L6wCBcCqclWRszu0YEXVQ+ftiI5ObGkzjdqrg=;
        b=bSDSBYCymPRs3Vs/tr7r5YQrHGzpLw5msbV6bRqzxcud8daTQ9DRmt+NH1qNhouKE5
         bw3N8xphtgbsZzlKTckOJTzZt7tfJY40pgffFnA7/O2V91EnaO9AsGJVSGOZdtLrWGl4
         KyJMsItJ3bfNp9mwGXyz02yCoYLLODtCEScvviroefvo5/TiSjivusL5F75yEjV2BX+G
         XrLrMi0M/3ToWS+9SHuPFZYSUOQWef2izRJREoSZq501RvMJmwssZ+MlnD0YORdV0YUA
         8avfLCq/0TaWxGkPQORlyvJHfGpK41FwCDSSZJADos8J3uCS5uwdB1t4lDAq41rjARbn
         /9kA==
X-Gm-Message-State: AOJu0YzelKDcQAXxTSTSlzgkI9m6BYEKb+YKTl1d3n363aM/Gc0yRjWg
	/oJpggYe/nzxm6B8yBrxGl7fPEF+cYpXCyIbYTnGtg==
X-Google-Smtp-Source: AGHT+IFhn6q6rlv/JEH6wuK9BVQM7oZHGK/5GQSfYw8PZ74oldKN7sB4zN6Y5yTefszsjtKU9QPNxhz96r77733HsVs=
X-Received: by 2002:a17:90a:1196:b0:267:f8a2:300a with SMTP id
 e22-20020a17090a119600b00267f8a2300amr2440659pja.7.1691598423307; Wed, 09 Aug
 2023 09:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808134049.1407498-1-leitao@debian.org> <ZNJ8zGcYClv/VCwG@google.com>
 <ZNNfK5e+lc0tsjj/@gmail.com>
In-Reply-To: <ZNNfK5e+lc0tsjj/@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 9 Aug 2023 09:26:52 -0700
Message-ID: <CAKH8qBvw86nb50h2ha77La9WVpBE3Ln7a00YTnQST0KyROmvqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] io_uring: Initial support for {s,g}etsockopt commands
To: Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 2:41=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Tue, Aug 08, 2023 at 10:35:08AM -0700, Stanislav Fomichev wrote:
> > On 08/08, Breno Leitao wrote:
> > > This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT=
)
> > > and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> > > SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all leve=
ls
> > > nad optnames. On the other hand, SOCKET_URING_OP_GETSOCKOPT just
> > > implements level SOL_SOCKET case, which seems to be the
> > > most common level parameter for get/setsockopt(2).
> > >
> > > struct proto_ops->setsockopt() uses sockptr instead of userspace
> > > pointers, which makes it easy to bind to io_uring. Unfortunately
> > > proto_ops->getsockopt() callback uses userspace pointers, except for
> > > SOL_SOCKET, which is handled by sk_getsockopt(). Thus, this patchset
> > > leverages sk_getsockopt() to imlpement the SOCKET_URING_OP_GETSOCKOPT
> > > case.
> > >
> > > In order to support BPF hooks, I modified the hooks to use  sockptr, =
so,
> > > it is flexible enough to accept user or kernel pointers for
> > > optval/optlen.
> > >
> > > PS1: For getsockopt command, the optlen field is not a userspace
> > > pointers, but an absolute value, so this is slightly different from
> > > getsockopt(2) behaviour. The new optlen value is returned in cqe->res=
.
> > >
> > > PS2: The userspace pointers need to be alive until the operation is
> > > completed.
> > >
> > > These changes were tested with a new test[1] in liburing. On the BPF
> > > side, I tested that no regression was introduced by running "test_pro=
gs"
> > > self test using "sockopt" test case.
> > >
> > > [1] Link: https://github.com/leitao/liburing/blob/getsock/test/socket=
-getsetsock-cmd.c
> > >
> > > RFC -> V1:
> > >     * Copy user memory at io_uring subsystem, and call proto_ops
> > >       callbacks using kernel memory
> > >     * Implement all the cases for SOCKET_URING_OP_SETSOCKOPT
> >
> > I did a quick pass, will take a close look later today. So far everythi=
ng makes
> > sense to me.
> >
> > Should we properly test it as well?
> > We have tools/testing/selftests/bpf/prog_tests/sockopt.c which does
> > most of the sanity checks, but it uses regular socket/{g,s}etsockopt
> > syscalls.
>
> Right, that is what I've been using to test the changes.
>
> > Seems like it should be pretty easy to extend this with
> > io_uring path? tools/testing/selftests/net/io_uring_zerocopy_tx.c
> > already implements minimal wrappers which we can most likely borrow.
>
> Sure, I can definitely do it. Do you want to see the new tests in this
> patchset, or, in a following patches?

Let's keep it in the same series if possible?

