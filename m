Return-Path: <bpf+bounces-3249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E3473B512
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E5C281AD0
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E246119;
	Fri, 23 Jun 2023 10:18:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACD5694
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:18:33 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421E30EF
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:18:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62fe1e6dc65so5057926d6.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687515490; x=1690107490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDX+kxQEjfyXTZmXo0xDii4nPFmJ96+bGAPPfs+GgPM=;
        b=nPFzHCp1EWA4XoME4rBmOrls2MC1hien4FqQfPSn3MvTDBGwHPRYVdi4nNQfuKY2EF
         zEC0Z1lPgeD0lXqcqbLbMgTrE4XJRTy5It3FmWKYrmiAjQPeIiV/KkD0bvc2UU3TLY/1
         rVn9+ZSCfm75NoEPGcuc7hlvIjdKILhkhvPO9z6dXPaAOTg0EGBAA8IDaSnSlM4hhDML
         d+TUYGZQrtdmw9kacHITVRSFVFgJDJOt4NfA25F7v099LBCJcANHGkoqgPl8eTB6xG9i
         Op7KXZg7lFEpratds9gKhEuu7hRWTLTWm/069dPtp4j1jGv1TG5NmgvYSFxjJqXxLqTu
         Z+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515490; x=1690107490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDX+kxQEjfyXTZmXo0xDii4nPFmJ96+bGAPPfs+GgPM=;
        b=a0a5SdDSFtcnG5Ic4StExNzmRzg9dk5BM4oRFLWrcVrxwn/JK6N6KIoEN+CTqCXwz7
         PPhLkk7Dao5c05Q9Hg0GhNprxCn/OU8Jb38mn2YcB4ovqSonvlcfsNq0UrkozO0Ucptl
         XgYu6gVO8y9sAVW6dytexijQf2BpqedQFDIFtz7BiLxYTO4ALO/wauf21qDiaxgHaDCE
         RXI320KfHR6bshc/yzToSVgzlLnaXFipqNGPc0ojeGFMaBViXkEWgbr/UBnQH4HMsZJm
         IL9i7bhrUw8/fsjRKEkZ2dMmObP0REVX7kc8E7fFWsRgMZhFknxu75JXUPh/e8GRaVQQ
         2WwQ==
X-Gm-Message-State: AC+VfDzCAFH53vDiKwcrZQzhpbCgxOzdCVLdTTSV5e4PERCY5EgcXask
	dbCnLHitIjTYpudH02fgy8QpglScT3+QZ5H5pcE=
X-Google-Smtp-Source: ACHHUZ4YCVtPelFBpKVsZfmBN4NZ9yhEOD6sAtrl1804TWQAajHY52C7pvJRLnRmzJoOOayf/0zz3vh3u23x7IAcHVc=
X-Received: by 2002:a05:6214:500f:b0:625:aa49:c345 with SMTP id
 jo15-20020a056214500f00b00625aa49c345mr26326354qvb.57.1687515489712; Fri, 23
 Jun 2023 03:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120042.3903-1-laoar.shao@gmail.com> <20230621120042.3903-3-laoar.shao@gmail.com>
 <CAADnVQKSqc5LQi2x7nkoVK3JHbqZDKc1E14ODy6HQSEdup6TFQ@mail.gmail.com>
In-Reply-To: <CAADnVQKSqc5LQi2x7nkoVK3JHbqZDKc1E14ODy6HQSEdup6TFQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 23 Jun 2023 18:17:33 +0800
Message-ID: <CALOAHbDeY+D+C52AE-MvpigB3cc6tdZOfhYtFkp2pcurdhJKaA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Add two new bpf helpers bpf_perf_type_[uk]probe()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 7:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 5:01=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > We are utilizing BPF LSM to monitor BPF operations within our container
> > environment. Our goal is to examine the program type and perform the
> > respective audits in our LSM program.
> >
> > When it comes to the perf_event BPF program, there are no specific
> > definitions for the perf types of kprobe or uprobe. In other words, the=
re
> > is no PERF_TYPE_[UK]PROBE. It appears that defining them as UAPI at thi=
s
> > stage would be impractical.
>
> and yet that's what your patch does.
> New helpers are uapi too.
> So no-go.
>
> Just do in your filtering bpf prog:
>         is_kprobe =3D event->tp_event->flags & TRACE_EVENT_FL_KPROBE;
>         is_uprobe =3D event->tp_event->flags & TRACE_EVENT_FL_UPROBE;
> when it's checking perf_ioctl.

Right. We can hook security_perf_event_write.
Thanks for your suggestion.

--=20
Regards
Yafang

