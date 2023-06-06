Return-Path: <bpf+bounces-1943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06277249BC
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BA21C20BB7
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D661ED43;
	Tue,  6 Jun 2023 17:04:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BF1ED2C
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 17:04:47 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3C10C2
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 10:04:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so2158300a34.1
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071085; x=1688663085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNlN5GtDgKPNlWQWYPrqc7sZzQ5di7/0ZMJCpdEzxF4=;
        b=OQib3uJJapjTVAKDiAYUg0Us2w1EOIiueE8Es8TRMEsjK8ojjcQLx/ux6YNlQyWt+0
         miCbnvINWBaxLLVw3F8dNa5zY2xKoDToktA1FAnF5EWcH98zClhxoKYDS480LaRA6jPZ
         d0/59SNOiS9sQ4FS88bkSAcpX/c5fnXJLarzuWip7Pj5lR5qxh2ahNXJSW8uathcCmP9
         Kt185dRhkzXV+XiaOZtW2iQetAIpKdqpdbH0zmM4hy6LH0f6q8cuflLXbbDojPNqOrlI
         EwOENfaIGxdmfx+kSRx1NDSurfXiNnUapB+yEj3J8wGg2vX5015H+U+C8JtBTg1WKiWy
         gQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071085; x=1688663085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNlN5GtDgKPNlWQWYPrqc7sZzQ5di7/0ZMJCpdEzxF4=;
        b=CAW9ET4jTXG0Y6nSwWV+9rglzp6VWumbItwviTu4xsiPWatvWPpN8AB5ysXLii6hpv
         nqjPEdfeGJuC4AkaxJlXXkj50RIpIwxbhrOFPIL4wvicId1p6p1KIPaqKQ1DFjFPr/tW
         xeXklgg2cyU/vTCsFY9x4dlkesGTiCKVcaynNdpmaxe5U8pGoq6h7edXHQc/cKURrXTa
         ++qbi6DEX8bLQN+5VzBp/ANnVz38dm45ZXfxGRxEGTiuHOz3S364gvW3pWDqF2J9mohX
         kWYFTYBi8nxNryn8kuXTFat9mERgZ5Oe0R5iMXjKiGOFDrXNuh1Lk2PAGp57yuGFuEQG
         6aFA==
X-Gm-Message-State: AC+VfDza4aybJx7cPBU+ucBBGNyCsGTJ3XJnT4r3rFMzytM7Dz9/pMcH
	8HVylvpwWiu8tnIQbX5qP057QrMsqd4RIThIDLjwGA==
X-Google-Smtp-Source: ACHHUZ6eSbBSq31Pj92QtB9+CuuoSz1DZ0/pX0OX+xNECugxvdKmm2rwO+JwvnYaWPHSu4qZgjij+Xe/6GdeLzb2jXo=
X-Received: by 2002:a05:6359:692:b0:125:83a6:caa5 with SMTP id
 ei18-20020a056359069200b0012583a6caa5mr432294rwb.3.1686071084761; Tue, 06 Jun
 2023 10:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
 <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev> <20881602-9afc-96b7-3d58-51c31e3f50b7@bytedance.com>
 <d7be9d22-c6aa-da2a-77fc-9638ad1e0f15@linux.dev> <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
In-Reply-To: <2d138e12-9273-46e6-c219-96c665f38f0f@bytedance.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 6 Jun 2023 10:04:33 -0700
Message-ID: <CAKH8qBtxNuwvawZ3v1-eK0RovPHu5AtYpays29TjxE2s-2RHpQ@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 8:20=E2=80=AFPM Feng Zhou <zhoufeng.zf@bytedance.com=
> wrote:
>
> =E5=9C=A8 2023/6/1 23:50, Martin KaFai Lau =E5=86=99=E9=81=93:
> > On 5/31/23 11:05 PM, Feng Zhou wrote:
> >> =E5=9C=A8 2023/6/1 13:37, Martin KaFai Lau =E5=86=99=E9=81=93:
> >>> On 5/31/23 7:49 PM, Feng zhou wrote:
> >>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> >>>>
> >>>> Remove the judgment on retval and pass bpf ctx by default. The
> >>>> advantage of this is that it is more flexible. Bpf getsockopt can
> >>>> support the new optname without using the module to call the
> >>>> nf_register_sockopt to register.
> >>>>
> >>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> >>>> ---
> >>>>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
> >>>>   1 file changed, 13 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >>>> index 5b2741aa0d9b..ebad5442d8bb 100644
> >>>> --- a/kernel/bpf/cgroup.c
> >>>> +++ b/kernel/bpf/cgroup.c
> >>>> @@ -1896,30 +1896,21 @@ int
> >>>> __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
> >>>>       if (max_optlen < 0)
> >>>>           return max_optlen;
> >>>> -    if (!retval) {
> >>>> -        /* If kernel getsockopt finished successfully,
> >>>> -         * copy whatever was returned to the user back
> >>>> -         * into our temporary buffer. Set optlen to the
> >>>> -         * one that kernel returned as well to let
> >>>> -         * BPF programs inspect the value.
> >>>> -         */
> >>>> -
> >>>> -        if (get_user(ctx.optlen, optlen)) {
> >>>> -            ret =3D -EFAULT;
> >>>> -            goto out;
> >>>> -        }
> >>>> +    if (get_user(ctx.optlen, optlen)) {
> >>>> +        ret =3D -EFAULT;
> >>>> +        goto out;
> >>>> +    }
> >>>> -        if (ctx.optlen < 0) {
> >>>> -            ret =3D -EFAULT;
> >>>> -            goto out;
> >>>> -        }
> >>>> -        orig_optlen =3D ctx.optlen;
> >>>> +    if (ctx.optlen < 0) {
> >>>> +        ret =3D -EFAULT;
> >>>> +        goto out;
> >>>> +    }
> >>>> +    orig_optlen =3D ctx.optlen;
> >>>> -        if (copy_from_user(ctx.optval, optval,
> >>>> -                   min(ctx.optlen, max_optlen)) !=3D 0) {
> >>>> -            ret =3D -EFAULT;
> >>>> -            goto out;
> >>>> -        }
> >>>> +    if (copy_from_user(ctx.optval, optval,
> >>>> +                min(ctx.optlen, max_optlen)) !=3D 0) {
> >>> What is in optval that is useful to copy from if the kernel didn't
> >>> handle the optname?
> >>
> >> For example, if the user customizes a new optname, it will not be
> >> processed if the kernel does not support it. Then the data stored in
> >> optval is the data put
> >
> >
> >
> >> by the user. If this part can be seen by bpf prog, the user can
> >> implement processing logic of the custom optname through bpf prog.
> >
> > This part does not make sense. It is a (get)sockopt. Why the bpf prog
> > should expect anything useful in the original __user optval? Other than
> > unnecessary copy for other common cases, it looks like a bad api, so
> > consider it a NAK.
> >
> >>
> >>>
> >>> and there is no selftest also.
> >>>
> >>
> >> Yes, if remove this restriction, everyone thinks it's ok, I'll add it
> >> in the next version.
> >>
> >>>> +        ret =3D -EFAULT;
> >>>> +        goto out;
> >>>>       }
> >>>>       lock_sock(sk);
> >>>
> >>
> >
>
> According to my understanding, users will have such requirements,
> customize an optname, which is not available in the kernel. All logic is
> completed in bpf prog, and bpf prog needs to obtain the user data passed
> in by the system call, and then return the data required by the user
> according to this data.
>
> For optname not in the kernel, the error code is
> #define ENOPROTOOPT 92/* Protocol not available */
> Whether to consider the way of judging with error codes,
> If (! retval | | retval =3D=3D -ENOPROTOOPT)

I'm also failing to see what you're trying to do here. You can already
implement custom optnames via getsockopt, so what's missing?
If you need to pass some data from the userspace to the hook, then
setsockopt hook will serve you better.
getsockopt is about reading something from the kernel/bpf; ignoring
initial user buffer value is somewhat implied here.

