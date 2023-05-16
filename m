Return-Path: <bpf+bounces-647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F20704F1F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8288928159D
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0842771C;
	Tue, 16 May 2023 13:21:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351C34CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 13:21:37 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A541BCA
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:21:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62381fe42b3so1224586d6.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684243295; x=1686835295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5MRVuNhjrTFM/Vn11DKj7v8DjEacpDvNiY1lWriP3s=;
        b=VedwXgVZ77sATDzMr0OPuWWCb175n2aYWN8A31KsQatDCPFqxehGSd0LbZ9woZ7vfi
         nIA/5I7Ngu12fOieta1kzJlN/0YrsJOW479J9b1o5q9npFXge80M0nRq4VY5dMkg675j
         q/H6a6xghLt+7sI8XDodTPNbtIdpYFbzK5ueoxMZwbI8i+sMLuPf/wRzGxOz1gO4mg1j
         ZFOlHX8FJ41dr/8AiqMI59SzBIgsbtnSBYEGQlPyae1JLdgf7YehTge5JI+oVzSO2KYS
         Pmae834SS8YHXvP75/j0lfFyAJQy0oBTufZLmZWLp83h+UxlBn4/9M/4XRfZmRPRf2S5
         p93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684243295; x=1686835295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5MRVuNhjrTFM/Vn11DKj7v8DjEacpDvNiY1lWriP3s=;
        b=IvwhHJK0vH+Gh+FYOzsNLEpbDX7z480sn5ruyZP23WslAQrOLjzDmICeovs+Nqc2lb
         7+QXLyqa25zA284qZYoIv4hSUv8uCqfF0RYkOIg93NZ5TzTDDCa+qeluRSJmU/Ug3HU7
         kZo1a+9DHCM9pbZSbzp1o1d0Ktk8yh0n3ys4MAk+1p8UK+N/bxnvBOjHvXli3vnG+YGa
         p4vvZLJlYngH6khKwZhe1/lArO6G6i2vHRkQISAZgdRNbcdYfKBX13s580SkIh+gSlA2
         m/RvYu8sXfD/FUYzSlVog5jFhcjnqHif1dBZf+/Pclorwcke5mdkapdaFu1K4yqUV3Mo
         c/JQ==
X-Gm-Message-State: AC+VfDydgufCbO5GsbQ2OflXxUo9l7nQgw6JEU6uR76HVHqHW4etRGRM
	T9hoTFqyzXB77EZvWtiZ0rJuBQz+mzqbjGy+Sb745cfJDDnBPNvE
X-Google-Smtp-Source: ACHHUZ7jWXVu6VtFgpHbBuK+5xOBXGopEigcdlu41GXRZhSrrdXyLOKv/mAmMYYlJ4aVzHYr3EmAu7G4s4/oXVp07kY=
X-Received: by 2002:ad4:5aa5:0:b0:616:4c4b:c9b9 with SMTP id
 u5-20020ad45aa5000000b006164c4bc9b9mr65423733qvg.37.1684243294954; Tue, 16
 May 2023 06:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516123926.57623-1-laoar.shao@gmail.com> <20230516123926.57623-3-laoar.shao@gmail.com>
 <5c8e5c0e-02a6-f043-7c22-add9d2996eec@isovalent.com> <CALOAHbD8jHVwC=oFPiEXQXO9Xzs_eF2+s=EbMxqBqVYEnQag2w@mail.gmail.com>
 <d3b7480c-9d0f-04d1-85ad-d22fa064f259@isovalent.com>
In-Reply-To: <d3b7480c-9d0f-04d1-85ad-d22fa064f259@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 16 May 2023 21:20:58 +0800
Message-ID: <CALOAHbBK9vbMNDXoWFgm-+3B3_YOMBPXZqa24EpaUsd9=k9-Qg@mail.gmail.com>
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

On Tue, May 16, 2023 at 9:19=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-05-16 21:09 UTC+0800 ~ Yafang Shao <laoar.shao@gmail.com>
> > On Tue, May 16, 2023 at 9:01=E2=80=AFPM Quentin Monnet <quentin@isovale=
nt.com> wrote:
> >>
> >> 2023-05-16 12:39 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> >>> The target_btf_id can help us understand which kernel function is
> >>> linked by a tracing prog. The target_btf_id and target_obj_id have
> >>> already been exposed to userspace, so we just need to show them.
> >>>
> >>> The result as follows,
> >>>
> >>> $ tools/bpf/bpftool/bpftool link show
> >>> 2: tracing  prog 13
> >>>         prog_type tracing  attach_type trace_fentry
> >>>         target_obj_id 1  target_btf_id 13964
> >>>         pids trace(10673)
> >>>
> >>> $ tools/bpf/bpftool/bpftool link show -j
> >>> [{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_=
type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid"=
:10673,"comm":"trace"}]}]
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> Acked-by: Song Liu <song@kernel.org>
> >>> ---
> >>>  tools/bpf/bpftool/link.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> >>> index 243b74e..cfe896f 100644
> >>> --- a/tools/bpf/bpftool/link.c
> >>> +++ b/tools/bpf/bpftool/link.c
> >>> @@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bp=
f_link_info *info)
> >>>
> >>>               show_link_attach_type_json(info->tracing.attach_type,
> >>>                                          json_wtr);
> >>> +             jsonw_uint_field(json_wtr, "target_obj_id", info->traci=
ng.target_obj_id);
> >>> +             jsonw_uint_field(json_wtr, "target_btf_id", info->traci=
ng.target_btf_id);
> >>>               break;
> >>>       case BPF_LINK_TYPE_CGROUP:
> >>>               jsonw_lluint_field(json_wtr, "cgroup_id",
> >>> @@ -375,6 +377,8 @@ static int show_link_close_plain(int fd, struct b=
pf_link_info *info)
> >>>                       printf("\n\tprog_type %u  ", prog_info.type);
> >>>
> >>>               show_link_attach_type_plain(info->tracing.attach_type);
> >>> +             printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
> >>> +                        info->tracing.target_obj_id, info->tracing.t=
arget_btf_id);
> >>
> >> Older kernels won't share this info, so maybe we can skip this printf(=
)
> >> in plain output if the target object and BTF ids are 0?
> >>
> >
> > Good suggestion. Will change it in the next version.
> > BTW, shouldn't we skip it in the json output as well ?
>
> I'd keep it in JSON. Plain output is for reading in the console, we want
> to make it easy for users to find the relevant info. JSON is for machine
> consumption, it's OK to be more exhaustive and to leave it to the
> consuming program to decide what's relevant and what's not.
>

Got it. Thanks for the explanation.


--=20
Regards
Yafang

