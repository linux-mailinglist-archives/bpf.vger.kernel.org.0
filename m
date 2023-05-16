Return-Path: <bpf+bounces-645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2676704EDC
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F8B1C20E2E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D427715;
	Tue, 16 May 2023 13:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7034CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 13:10:22 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C968F
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:10:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e4f839ae4so706398485a.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684242620; x=1686834620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8VvZw+SLPLmtAGgGVXTMo+lcxAsV+JqjO/0aQbmYiw=;
        b=S5v/feebuyAq2ZLzcXB6A2ze9F7P5c3N1xhu5Wr4u58q6UDMtw+94QW5HgQ82b5DKZ
         qcY87fdqDI3PVyS1FJpggweHIRehAcvojEwMdv0QO90oHc2aEFxqrAOylItuT4TNbxcc
         Gmw77p2+7AARfxL2SO6Ig2BxuEtaMOtaDIHmWv3DB89ao3k4BvZKscvtMDybo0nxR4yu
         rR8L6zE86G/7BYhLgdMFyULBIVCqrNc+atMr5cNn5Aq4FCxemjElYdgAVD0/XB8gZIxV
         oRzsLJTuueKbG0ULAyX56qz9rKoT841QwA5j0A40/OmKWTMbxQoW3qMG3xW+oTHGfZn7
         adqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242620; x=1686834620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8VvZw+SLPLmtAGgGVXTMo+lcxAsV+JqjO/0aQbmYiw=;
        b=Xv4hY4NMtNLvMpB4P2xDPMv8SeqnJ08jZZo3eiknPThXO5u7FDTZSkv5OpvxpDWPh8
         CO0Q4l7FjzuEvHrrRfZtcgJtSRFH2hpTi4Rh2NzEkkKG5rGyLGEhThM/VuvfT38d9dKm
         CMt7skHF61IaYxeFpoXYGMhFWTMnSL5MYPjAUkBW7E14ZzhmXN+Kam+y4ll2xU0p5EJ+
         Ma4bex973gE34UqHGISd0IskmHB2S+3xPcVt9jaLq/lzcRErpH2JxdjuZmj+EMjhpm5H
         /LWueo8qEIAjcL9+iyaPbyEXZMRJNJvjmYKlROzGVIRVke0NGV/jT2SO7Duh5SW0EmVp
         au2Q==
X-Gm-Message-State: AC+VfDz+1N4J9FKfJiFN7LWbx1S3rZ9edBD8EG0kxHDJrRO4pBTqnFDZ
	cuoadKGYKmLY83d1WdjOBpXyJCSQgSUedZgHprc=
X-Google-Smtp-Source: ACHHUZ7BcRqtyh+OwK1EOVo3cCRu5fEVjju4Q+D2QiNui9EuGTMb27U7Qr8burQWBuyPsYTrq3Ct9dWPoXKDjDA12PU=
X-Received: by 2002:ad4:5aaa:0:b0:61b:5ca6:b7ef with SMTP id
 u10-20020ad45aaa000000b0061b5ca6b7efmr61640797qvg.42.1684242620230; Tue, 16
 May 2023 06:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516123926.57623-1-laoar.shao@gmail.com> <20230516123926.57623-3-laoar.shao@gmail.com>
 <5c8e5c0e-02a6-f043-7c22-add9d2996eec@isovalent.com>
In-Reply-To: <5c8e5c0e-02a6-f043-7c22-add9d2996eec@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 16 May 2023 21:09:43 +0800
Message-ID: <CALOAHbD8jHVwC=oFPiEXQXO9Xzs_eF2+s=EbMxqBqVYEnQag2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Show target_{obj,btf}_id in tracing
 link info
To: Quentin Monnet <quentin@isovalent.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 9:01=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-05-16 12:39 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > The target_btf_id can help us understand which kernel function is
> > linked by a tracing prog. The target_btf_id and target_obj_id have
> > already been exposed to userspace, so we just need to show them.
> >
> > The result as follows,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 2: tracing  prog 13
> >         prog_type tracing  attach_type trace_fentry
> >         target_obj_id 1  target_btf_id 13964
> >         pids trace(10673)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_ty=
pe":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":1=
0673,"comm":"trace"}]}]
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 243b74e..cfe896f 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bpf_=
link_info *info)
> >
> >               show_link_attach_type_json(info->tracing.attach_type,
> >                                          json_wtr);
> > +             jsonw_uint_field(json_wtr, "target_obj_id", info->tracing=
.target_obj_id);
> > +             jsonw_uint_field(json_wtr, "target_btf_id", info->tracing=
.target_btf_id);
> >               break;
> >       case BPF_LINK_TYPE_CGROUP:
> >               jsonw_lluint_field(json_wtr, "cgroup_id",
> > @@ -375,6 +377,8 @@ static int show_link_close_plain(int fd, struct bpf=
_link_info *info)
> >                       printf("\n\tprog_type %u  ", prog_info.type);
> >
> >               show_link_attach_type_plain(info->tracing.attach_type);
> > +             printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
> > +                        info->tracing.target_obj_id, info->tracing.tar=
get_btf_id);
>
> Older kernels won't share this info, so maybe we can skip this printf()
> in plain output if the target object and BTF ids are 0?
>

Good suggestion. Will change it in the next version.
BTW, shouldn't we skip it in the json output as well ?

--=20
Regards
Yafang

