Return-Path: <bpf+bounces-5377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CC759DEC
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922B41C2116D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC5275CE;
	Wed, 19 Jul 2023 18:45:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CD275A1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 18:45:41 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4110BB6
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 11:45:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f122ff663eso11960880e87.2
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689792338; x=1692384338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf8My1Ny6NJ7k9Fq65zlIc7AuVkK6zmSCK+TDaep2+U=;
        b=WacVEvMVTbMRdE5/KhgmHNdM/AZkv+zmychKMvi73wlv4wmK2ArEPAIpOjpnCR00ah
         dyY0E4lVqNnPp6ES+ju2RyIwVJiqFNB7dsbdWIbRYjHC/uNb9397KCirXAJdQauKYAaA
         jfxkDCpjl6SCpFsBrdT6A3Ft94XT3uIbg5z/TkGOsabG5/eIL62X2OL0FPd6PvaCIQ21
         c+u9Z2QmTaEbuzpMB4c24evtiQquhhLE8x2Rx0TduKhqUDAiiDszdsJs8VGvlmf/jEgn
         BreAHtsw97Rncx224IemIfS1Lrh1c+wwdtooJIKl4w026lWxcwkmXIBRiXkCHem13qN3
         9GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792338; x=1692384338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rf8My1Ny6NJ7k9Fq65zlIc7AuVkK6zmSCK+TDaep2+U=;
        b=dKC1czi0iucv+Y0Fy1BWzxKjOzaYIrHHI6BvR/XgdVdZQ4YtKHZaOihADHK9YwNZkk
         r/VcB2Y2sL4Wkw8RGlQZ8h9cnXK0FTSPSHP2mZCPMrTLIhJULQDS3vwM8qYSCGtBEn1H
         zr9HfU0A2BMytbT2k5V4v8HX7CMvStG/WV+NejkHN+ssjQpV7MsUKralmpcGuPzBDM2w
         xw4WtTsShDx891b3j+fkh58ovxNYAsMvSeadZKq1cbqDaVebz8CvePdDrLhjzDQ8RCYG
         aF2aSfCvdeLT30qXcvTzyefF2Tg28R5qtejCxDGJ5hO4hU8mO4blM/DnHa05KGUvA9s2
         kKaw==
X-Gm-Message-State: ABy/qLbWfF4B9QWH/k/8D5m2NMs0I3FuS6n/JfMNL61zGNleNWGyklvN
	yxTK729MtOmcOKLb5dBpcF0yIt9Z6xInM3dJY18=
X-Google-Smtp-Source: APBJJlHITjGSE7chy4/UN4ySD5IPOZNjqQ8pg7mUTxMi0MlF+BpyTGcKnb4Ss0eco84jk2R6k8O0E91G8PigOpQh6is=
X-Received: by 2002:a2e:3c18:0:b0:2b6:cf6f:159e with SMTP id
 j24-20020a2e3c18000000b002b6cf6f159emr454544lja.44.1689792338166; Wed, 19 Jul
 2023 11:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717111742.183926-1-jolsa@kernel.org> <20230717111742.183926-2-jolsa@kernel.org>
 <CAADnVQJ=h3yg0u6qEOBV+XmAWOVg7W7rsW05dK_WuYBUnZZ7zg@mail.gmail.com> <ZLfuZuBiexGqRSfl@krava>
In-Reply-To: <ZLfuZuBiexGqRSfl@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jul 2023 11:45:26 -0700
Message-ID: <CAADnVQKvkGwpa46v80L4YFfJR-9CjYcUhhS84dGJqToSjbUipQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Disable preemption in bpf_perf_event_output
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 7:08=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> now task-1 and task-2 share same bpf_trace_nest_level value and same
> 'struct perf_sample_data' buffer on top of &sds->sds[1]
>
> I did not figure out yet the actual exact scenario/cause of the crash yet=
,
> I suspect one of the tasks copies data over some boundary, but all the
> ideas I had so far did not match the instructions from the crash
>
> anyway I thought that having 2 tasks sharing the same perf_sample_data
> is bad enough to send the patch

It makes sense now. We forgot to update this part during
transition from preempt_disable to migrate_disable.

But do you have PREEMPT_RCU in your kernel?
If not then the above race shouldn't be possible.
Worth fixing anyway, of course.
Can you repro with a crafted test?
Multiple uprobes doing bpf_perf_event_output should be enough, right?
For kprobes we're "lucky" due to bpf_prog_active.

