Return-Path: <bpf+bounces-7672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDAF77A4D6
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 05:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD2C280F60
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513481386;
	Sun, 13 Aug 2023 03:16:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5E110A
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 03:16:11 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA6E5B
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 20:16:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63fbfc0b817so20973146d6.1
        for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691896569; x=1692501369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z9AAQ+9BVc/Z61AuG3SqQDrL+Ngfwm9m6IZNuH4f6M=;
        b=Bfo5gluqK8qrZgopktneeuKJ/H03F6sD0EJCrKcMjZHWk5zyEpfe04Tp4v8Vwr8RLl
         BWmocIB8FbgtqoTdEsnLUlAQU7EYid9pN34gtMrovqXA4YZRKGhoA9/sHEpSREpg80Es
         hZN4kuvZswt22diAuLeCN7GfGwhvTHDptEVhtNVHWFo73VN+elzBxg+Yj4+3D2cmstWy
         /sy1RvNMBzF9mY2blCIxmrUl7lWeHweVofPhxIiRUoRUwgjLJ0gU1Ouo3D0zauVowXR4
         C3f+oPW+NY5fEMS03+6JscQ39UVEsonFSxxJcdHnrPSE6VKEQUnXchKSL9ru6GVCpYhr
         FHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896569; x=1692501369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z9AAQ+9BVc/Z61AuG3SqQDrL+Ngfwm9m6IZNuH4f6M=;
        b=I134I4QyLZToFSsXsM17NJh6FnAgVfC1AMJDchWFV4lHa2yZDiQNgQyIQBMzcZ/2jq
         maLIJ116iFZ41x6m3ttDFgNrtr8FacL29xt20ZanOB8NjpPLBUdyUw5N9D3K/sejMvL7
         dvtK9OhI0GRGDCnqVi9aOBRPDKRHaHzavdSQ0rx/H+8Ha/JR9HHvVyWQZfJsg5RfR5ty
         LrAFRnLpKgg3bkHZR5fwSvvP3k92M3q6Wi7MQz+rmMRryps4qebesBTqiGtrn5zbX3U4
         MLF49tKfL0BVJR7St5HFjUE68NIZqF6GC96UaJ8joBXafAYotwwmD1kwqIkjfr9/8soW
         T7xg==
X-Gm-Message-State: AOJu0YxLojPQcYuKjLaJZzP9drREQh4s7W9UDAGxn1/K9Tod4jf7c6sT
	G+1/H27kqlrH/vv1VlWJNZhDkQ5kHozGKwQ4peE=
X-Google-Smtp-Source: AGHT+IFwYwZmBtogpZoonq+D8izTBf+nU9XBrtkrukcJ+IrpKku/KWdCXG+AmH2+FNyHgAjpUrbXV6l14vtu5prafxQ=
X-Received: by 2002:a0c:da81:0:b0:630:198c:3c60 with SMTP id
 z1-20020a0cda81000000b00630198c3c60mr7598111qvj.23.1691896569190; Sat, 12 Aug
 2023 20:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811023647.3711-1-laoar.shao@gmail.com> <20230811023647.3711-3-laoar.shao@gmail.com>
 <9c386f0f-ff12-2994-42ab-d3796d57a03a@linux.dev>
In-Reply-To: <9c386f0f-ff12-2994-42ab-d3796d57a03a@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 13 Aug 2023 11:15:33 +0800
Message-ID: <CALOAHbCumF81_fo8RN7D6YB_9x5_t8=gj2zFMCHoJDey0fLTgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for fill_link_info
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 11:29=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/10/23 7:36 PM, Yafang Shao wrote:
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 3b61e8b..b2f46b6 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # li=
bbpf: failed to load BPF sk
> >   module_attach                                    # prog 'kprobe_multi=
': failed to auto-attach: -95
> >   fentry_test/fentry_many_args                     # fentry_many_args:F=
AIL:fentry_many_args_attach unexpected error: -524
> >   fexit_test/fexit_many_args                       # fexit_many_args:FA=
IL:fexit_many_args_attach unexpected error: -524
> > +fill_link_info/kprobe_multi_link_info            # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
>
> The bpf CI is failing:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230811023647.3711-=
3-laoar.shao@gmail.com/
>
> The patch author is responsible to monitor the result from patchwork.

Thanks for your reminder. Should rename
fill_link_info/kprobe_multi_ubuff to
fill_link_info/kprobe_multi_invalid_ubuff


--=20
Regards
Yafang

