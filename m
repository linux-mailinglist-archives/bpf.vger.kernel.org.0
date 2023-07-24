Return-Path: <bpf+bounces-5705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B075ED07
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AAD1C20A95
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC781C39;
	Mon, 24 Jul 2023 08:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608501868
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 08:01:59 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CDFA
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so6097444a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=L8ohUoQwhRgvUZKLkgt2VAsrzphG3+p7mgJ/gQ+hDxT+HVl0t3pJLoFEdQrx/EQwy8
         xN1jUdg4iR/MYSLHSdB0o3Yg4cMoEfFfJyuO4WEkhPBIWYOyMlTGIrl4OG209ohSxtQD
         DQ/4D3OMZFqg3Mf/skvNwVLRIbKNFakNb+F8IzAU2JEIS0I+8iyUqV3ouJTt/iLoqnbv
         TkD15YOuPNF7Z6yAakkJUlScTQgfZQXvscA83nD8qR63JT1c/g6Q1+T4UwOETkE86fMg
         1NAHj9FRSpcvm/jIUFC37I2Hwi1EHaTDTYdpKW4AXtemRlwTju6DmY0fzVkMBXE4QIIT
         SiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=f3gK+73YNmbajIV/hI74UW62S1hzVpUGpcmqpzhii3Cpwqh/W7Fg1aKjgFI7paEofe
         ynnvYANJJjkKWLU81ji0RBGsjM02NnceNNC0BglsR8D1ljSXBUnFWo0DBVP4uWc+bapU
         FP2LPmCVcUJTYij4b0XgI0b2c3ZEH31emgx9GB1I/KvnbNtKvMG/5oRsy2HUD3ASfBKf
         9Y3iY/AYsxEpZjafSCuITWKqar7UF6/oyXY6wR7nmvU7UaY0xgjyk8eIFDGqN9S+6hsz
         9FpLr2A+b+9y2aXrL9/q5BLY4H8srM9RjJpDDd3N6C5h1VY93NSl5qwbhuJkeM7Z/DbS
         4U9A==
X-Gm-Message-State: ABy/qLbdvSkSwpcvZJ0JXf9T2xRT1x77SqP3uXshVvVMfyUD+2ziC7H0
	Jk44RpjijuXBjyvzsbb8mSa7ePggF1lMg0ebToNwqQ==
X-Google-Smtp-Source: APBJJlHC5rMQrIx5ImZ99gmyXHNXpIqWWNKYgsVWHrLadDUIN+FGDrHLMI+w2SLqw3PTowpbtiuavEOWH40HooYc2NA=
X-Received: by 2002:a17:907:7846:b0:994:8e9:67fe with SMTP id
 lb6-20020a170907784600b0099408e967femr8119394ejc.35.1690185715296; Mon, 24
 Jul 2023 01:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com> <20230720211646.34782-1-kuniyu@amazon.com>
In-Reply-To: <20230720211646.34782-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 24 Jul 2023 10:01:44 +0200
Message-ID: <CAN+4W8h=dSqF-TV1pRueP1mGSpUpkkZGgMScL_=GR7PphTZRkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: reject unhashed sockets in bpf_sk_assign
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, joe@cilium.io, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:

> > Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> > This matches the behaviour of __inet_lookup_skb which is ultimately
> > the goal of bpf_sk_assign().
> >
> > Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
>
> Should this be 0c48eefae712 then ?

I think it makes sense to target it at the original helper add, since
we really should've done the unhashed check back then. Relying on
unhashed not being available is too subtle.

