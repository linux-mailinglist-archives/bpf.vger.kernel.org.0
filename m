Return-Path: <bpf+bounces-2214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09788729490
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C29C1C21040
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7FDF5E;
	Fri,  9 Jun 2023 09:16:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6EC8FA
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:16:50 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050465BF
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 02:16:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62614a2ce61so12194516d6.3
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686302169; x=1688894169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXU63qcS0o8Tx3+iF1nhJgJyaFGPlKNQ70h5T0RZL88=;
        b=WcYACPQe7X7ZA+Q6uhXy8qrAdUhUoUtcbMBFico6RgsmN8VOkDeLt9G2kSal5nUMYE
         OFfsBwXpmkTvYW8Z+Lem+mRwMxTK7LqGXh6PFSY7GNeL83+6GvA+ywyvgOr2SDKoHM1L
         LMp+2awaCvdDOB/DeA73RnUC/xQ6vyhKx+KEjnn9VSTFYXxE/HAxQOHcbtXnIrEw9EI/
         sy1iOxuzvEMv5Nk85CBS4ZOwQuoOwHoKShmxQSXX0sDOETgoY4hPT8W24JrfG97XrsPz
         hOvM7a1i11s95BL4BiIGb0g9IiQghuOTSxGzq9sqXlZOBeJhFo0kUp1PXq/nwFFXnIz2
         2FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686302169; x=1688894169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXU63qcS0o8Tx3+iF1nhJgJyaFGPlKNQ70h5T0RZL88=;
        b=UP/zik5dt37wz/bymlMfoCPbl4gUcfXBvnoNt1ziFCTZNu08l3Rgg3hEXZknwyBPMa
         NXuH2hX9ZHsr2SCTbYr0jnMCH1DdOzx533oDvOswGn9mxZ5cWm7WWgyDTeiIpxyGWg2Q
         KEq5DBGp0SWe9ntGNi5EJkueKHy5+trTLIhaQ+F8JmnrL5nnNN/1r/ix1p0AEv9R27ye
         vteM69sv8H9/sPX3PAObTZ67YhGG8nrIABJy9DAmvr/xOuMzsyoYuFhpUBLDEJiBTwp8
         GQ4mkA6XBe0bEhrT3nkH0LBFtWYZunhkpsrWdBLsltE4zfhdgT1bNY9Y44LaxgWkSABS
         vKJw==
X-Gm-Message-State: AC+VfDxSJT4nWWVYusJVmx32ReXvx0QfedEQzWTFPbzkQHFQJOpPqTAf
	TNYFIynQN5z/Ezq1Ans1pr7v/l6yZd/yD7IOl1s=
X-Google-Smtp-Source: ACHHUZ4LKeiKDbAH8ucpMqvGWRTMtrbKqTVwekinl2+4GDSLNjsB4q//TRMpQ3Y/hoVY+D0f8fv4om6YOXthryCuECY=
X-Received: by 2002:a05:6214:21eb:b0:623:9e5c:e625 with SMTP id
 p11-20020a05621421eb00b006239e5ce625mr911732qvj.29.1686302169086; Fri, 09 Jun
 2023 02:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-4-laoar.shao@gmail.com>
 <CAEf4BzZsY=wT4BQTyMK5_MQamXo-vY1bLFc9rYGoxtnC1Maj=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZsY=wT4BQTyMK5_MQamXo-vY1bLFc9rYGoxtnC1Maj=Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Jun 2023 17:15:33 +0800
Message-ID: <CALOAHbDNKybJfZzV9kRV9fFCqZFR7P9N6cZFXk_AHG+q63MS9A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/11] bpftool: Show probed function in
 kprobe_multi link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 7:08=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 4: kprobe_multi  prog 29
> >         retprobe 0  func_cnt 4
> >         addrs ffffffffb5d475b0  funcs schedule_timeout_interruptible
> >               ffffffffb5d475f0        schedule_timeout_killable
> >               ffffffffb5d47630        schedule_timeout_uninterruptible
> >               ffffffffb5d47670        schedule_timeout_idle
>
> what about module names? kallsyms has this information and it is quite
> important, in addition to function name

Thanks for your suggestion. I will add it.

--=20
Regards
Yafang

