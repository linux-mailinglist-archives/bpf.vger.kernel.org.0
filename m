Return-Path: <bpf+bounces-1772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E372147C
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 05:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065DC2816A2
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 03:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BB1FB0;
	Sun,  4 Jun 2023 03:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D717F6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 03:29:18 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DE1A7
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 20:29:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62613b2c8b7so38819516d6.1
        for <bpf@vger.kernel.org>; Sat, 03 Jun 2023 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685849356; x=1688441356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNz7MNnwNTi43VImjxLbil5qyoGeCQeE69/kAej5TMg=;
        b=S/KlnpFwSLjs9idRBy3e9100S+PKDx59CGKyUQGf7fDWj2IML4hcewGQ/6GPlDYgV4
         7h/VEDQzVDp1hahXlEl1TSsrJtC6YvoBtaJwkUOevtb0LQPSWHwRvxtoUUB7qhvaCdTq
         eqQynwJ4EB4PI3xagrqZY041QP5BFd6OWrMSTunOAf2ghI6Az88MyHvpklm6ibCvVRdE
         gqKKX3Q5ZTaFvbePuBdcrijRLsEgAgH55rk4wVpzzUkLSQEMywQGW0DNuPyPl+lgyX2h
         U053wQUcj+qo3gLZLCFa+BbsyaZhELbVOu4zhuntib7YqptH02OFvZbmzBoNsfQIrKpt
         xFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685849356; x=1688441356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNz7MNnwNTi43VImjxLbil5qyoGeCQeE69/kAej5TMg=;
        b=PlXek11Fcn+oa6H5Ll8ExRPJIBaWiyX8edQDyny7nFRr0ztoZFwG9JsD/KI/GSTxwp
         8jEdhLcG0BVM6crGpM4aigXT+B0GuhCzTI2NlF+Pz9fcQkEUKGGQ1CyDd2lnGwqETpQH
         IHOqRA8T5OVFA3eMB3CcFb/zV1FUJV/ZIEPs4xTt842qPslTdPour9gLIoxiHHkTL5nf
         fHZOEb4X1vMBnYR3QeCf5NJCgo1ugoo9CZRDQOkYNxUb0KSHP9si8f1JpbzN0+eE2MCM
         EQw2ePOIHMQFkRdGYVDKF3/8BFWprE4l++6jXErQ/DrzWDQb4g/80buD3PV/rlTxjye8
         KS7w==
X-Gm-Message-State: AC+VfDzVD6jLRhhKgIBTPArTsUSdkUUQLpmg6cVCCZVpuSXemXz/BN6n
	XH0nHoPAba6Nbh+QAkFKjvgMlWOwZVmykeN+wLA=
X-Google-Smtp-Source: ACHHUZ4Jc46e3GDezJzcyDHW6PfuDMbQEmQ/4TKz9G56sjPFK77s6ofVbCAPHoU7FI5WvjIoU+NzqHig95/H//ce5U4=
X-Received: by 2002:a05:6214:21a8:b0:621:38a8:83b with SMTP id
 t8-20020a05621421a800b0062138a8083bmr4343376qvc.31.1685849355951; Sat, 03 Jun
 2023 20:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-6-laoar.shao@gmail.com>
 <CAEf4Bzb1A-SSkr5UrXrccMsT99AbmtwOS0WRXzUvYUGCYLX68g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb1A-SSkr5UrXrccMsT99AbmtwOS0WRXzUvYUGCYLX68g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Jun 2023 11:28:40 +0800
Message-ID: <CALOAHbC5vxaqon1SnpiPSX6C7Nf7vXEyfasuVWXi5rTx8fv5xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Support ->fill_link_info for perf_event
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

On Sat, Jun 3, 2023 at 6:20=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 2, 2023 at 1:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > By adding support for ->fill_link_info to the perf_event link, users wi=
ll
> > be able to inspect it using `bpftool link show`. While users can curren=
tly
> > access this information via `bpftool perf show`, consolidating the link
> > information for all link types in one place would be more convenient.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       |  6 ++++++
> >  kernel/bpf/syscall.c           | 45 ++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/include/uapi/linux/bpf.h |  6 ++++++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 22c8168..87ecf8b 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6442,6 +6442,12 @@ struct bpf_link_info {
> >                         __u64 addrs;
> >                         __u32 count;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __aligned_u64 name; /* in/out: symbol name buff=
er ptr */
> > +                       __u64 addr;
> > +                       __u32 name_len;
> > +                       __u32 offset;
> > +               } perf_event;
>
> perf_event link could be:
>
> a) uprobe
> b) kprobe
> c) tracepoint
> d) generic perf_event (e.g., cpu_cycles)
>
> This interface doesn't make it very clear which one it is. And what's
> "name" for cpu_cycles event? What is the name for uprobe? Let's
> actually document this, otherwise it's hard to understand how this
> information can be interpreted...

Agreed. It would be better to have a document on it. I will do it.

--=20
Regards
Yafang

