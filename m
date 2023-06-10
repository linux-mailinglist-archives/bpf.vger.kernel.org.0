Return-Path: <bpf+bounces-2291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1E72A84D
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2A1C211D6
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9023CA;
	Sat, 10 Jun 2023 02:20:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D515A1
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 02:20:30 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D03ABB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 19:20:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6261616efd2so17871846d6.2
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686363627; x=1688955627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IKBByl+DH7bFcpPrjF1claW3g39rzr61ocGOyH+J1M=;
        b=V0BPLVTc8r88S4HfdhMnclR1tjUzzk16efZSKGL5PsPXPJ5nSo5HXi6f7aFCFWjhUC
         95PqXrbIwZA4XtnruqqDXbnEJHmLVS3ACOIcCFFNGunHrw6csa1IbD5ELmw1QuAnDKbF
         dGh30Ynw5uajbZpxdjLcA+UhCsu9VD58MQO4zyzJP1197Le+aZSF4CZZhshuTRlYykK8
         LQKURgxzefhtFlWC+p9pJV1RVmRBtLSx9o9dwfxEauBOQpHhrQITas/OGmEoUREDUKtw
         oq8RJGMBhv1Pkfctau1HHTkIyatyDmsl8SHqgjvpB6aV30IzKFcR2OCH86x5IB/vTSpt
         IA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686363627; x=1688955627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IKBByl+DH7bFcpPrjF1claW3g39rzr61ocGOyH+J1M=;
        b=lwcsdUyZu3667z6rezFSG/H0hlPMiMhGm8CCgruoH7BD12UBJRhVzqSlpRO504WXL9
         7/JuqS1NxXbFSm0eeqKfwBAxHFSgFaQqYzbXUyIM2jg1HWoUGRzfZyOMHsFMOquY+Pxb
         5pgOLUsRjXWiEodHFOsBZlM5dHbx8F16rP3weXjW7J7Wg7uwzXtoWjTw52YQYeJPuXek
         Z/8vt68vWQvRubF9XwL5vJZyQNYXHLYiJH+QuUfgavdg8IoLUdLDq8019FdOR75Ki4fC
         vFJ7VxklIBneUCuA6IoqwRQRrDgS17wCJWyqY7NwsisHm6OHA0k7dJHqoMaszxPBrXw+
         8zuw==
X-Gm-Message-State: AC+VfDyFt2kZkZGNH8QYv1qvIDK9rKSLZLwmtLN7pBp6KNZYDM5gUs/G
	0iLIHVd7i6LY/rTIIsl/ZK+UYR5rx9tIMSx8y/w=
X-Google-Smtp-Source: ACHHUZ7M7+Q/JkjB+T++8EJ1D5a92IXhrDvOQSC510OJWmvwhZkbviugdTBmPC5FkUfK3/0rETRaAh6VXDgyblsD0nM=
X-Received: by 2002:ad4:5c4a:0:b0:5f8:f168:e0e7 with SMTP id
 a10-20020ad45c4a000000b005f8f168e0e7mr3856734qva.29.1686363627216; Fri, 09
 Jun 2023 19:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-2-laoar.shao@gmail.com>
 <CAEf4BzY8Vi4Y6kf7hOmhWQkKOV=R7tBzb4dgCuicni3bBFWb9A@mail.gmail.com>
 <CALOAHbAfiJ7BWzxBWD3vD9vaAkUa8o_95r8x-A_o5jjAyBFpqA@mail.gmail.com> <CAEf4BzaNnJ4AWTnC4Fpf557zMMYK42ffxYCtcPewaXj4OLQFNg@mail.gmail.com>
In-Reply-To: <CAEf4BzaNnJ4AWTnC4Fpf557zMMYK42ffxYCtcPewaXj4OLQFNg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 10 Jun 2023 10:19:50 +0800
Message-ID: <CALOAHbBg4=jBE5qZ=sr5b27zxkQORai1rvv5rK5k9BYChUaczA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
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

On Sat, Jun 10, 2023 at 2:25=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 2:14=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Fri, Jun 9, 2023 at 7:05=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > With the addition of support for fill_link_info to the kprobe_multi=
 link,
> > > > users will gain the ability to inspect it conveniently using the
> > > > `bpftool link show` command. This enhancement provides valuable inf=
ormation
> > > > to the user, including the count of probed functions and their resp=
ective
> > > > addresses. It's important to note that if the kptr_restrict setting=
 is set
> > > > to 2, the probed addresses will not be exposed, ensuring security.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       |  5 +++++
> > > >  kernel/trace/bpf_trace.c       | 30 ++++++++++++++++++++++++++++++
> > > >  tools/include/uapi/linux/bpf.h |  5 +++++
> > > >  3 files changed, 40 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index a7b5e91..d99cc16 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6438,6 +6438,11 @@ struct bpf_link_info {
> > > >                         __s32 priority;
> > > >                         __u32 flags;
> > > >                 } netfilter;
> > > > +               struct {
> > > > +                       __aligned_u64 addrs; /* in/out: addresses b=
uffer ptr */
> > > > +                       __u32 count;
> > > > +                       __u8  retprobe;
> > >
> > > from kernel API side it's probably better to just expose flags?
> >
> > Agreed. The flags will be extensible.
> >
> > > retprobe is determined by BPF_F_KPROBE_MULTI_RETURN flag
> >
> > Should we print 'flags' in `bpftool link show` directly? As we print
> > it in `bpftool map show`.
>
> specifically for kprobe vs kretprobe (and similarly uprobe vs
> uretprobe), if bpftool can make it human-readable it would be best. We
> can also additionally print flags, but I don't know how useful it
> would be.

Got it. Thanks. Will print 'retprobe' only.

--=20
Regards
Yafang

