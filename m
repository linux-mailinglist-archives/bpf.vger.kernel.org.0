Return-Path: <bpf+bounces-10152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D77A237E
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005C71C209EF
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437211CBE;
	Fri, 15 Sep 2023 16:22:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6F11CB1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:22:14 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301372134
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:22:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5779055a474so1856196a12.0
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694794922; x=1695399722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0bvV0lS/2rkOpCVyMIWA7y2gWbDIjEZJpDVOU8Ykh0=;
        b=naZ8bGRn5kOtwUE3wvTswyBTJYOjtXYTFCFh5a6ZyYqsyjXCpiTEekTXqURc45gKNW
         NE8UMcobj6AHulSDAXF8rTqunyV8YG2S6gno1rKFVJRlX+T1HYEtK0s2daeXTS3EGdbB
         nJqYHORSMz5bXEj5funhuVvE1qzJSsqJzd9xhu8wXmvD/RWsyZzY4r27LBEDdP1DChQ3
         VTYr3MjRhdn50xIWC8Pf+OoW35jZkxoB4oRbqMNTxjKfC8tT7kMcHqN7r7XV1ez3b76i
         rtHb4SiyhnZjjOk9cVQi/JNctU6nQREpVUCfHmQ3hOlaR+5KKozQLvVpBUMlv1uzApm9
         h1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794922; x=1695399722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0bvV0lS/2rkOpCVyMIWA7y2gWbDIjEZJpDVOU8Ykh0=;
        b=S992HrMlB5NTwHyctVSU2DIGUl6Z8j4O1HEAlDHwep81OG/RICPg9pjCooPsdi2z+W
         OZmUc8KRXolBHcXIyc+bUQ4slxx3gtGteoXJxgO5tKtsASCy9EJFXk94GFkLXg4VcPlc
         Qzdnx2dz/lNuNHtA3oqJ/71rzg2zHdjJF1NVssJAwJLWOJ0SnGs3h7wyA3zihIPpfv9s
         +/feC2D4wYgaP5461tS0hm3CL2Vw7du/mT0mztsDaKfJJSqT5LZv0vGeRbELGr7X6J6x
         Oc4Eo8aikw9dsF5lxRrSZ0soPBDFNCUbtCqT9Id8lKKeJ/ng45iIKN5ILC1sZ3yK/TXG
         IAsg==
X-Gm-Message-State: AOJu0Yw3+/Q/H6usqyvMrcaF6aNRSC/Hy5F7iz70EXN5nZwccViX4v/y
	8DRkvKIdYh5hB3RIBxQVUwElfNBnEPwrASyOxwAdbg==
X-Google-Smtp-Source: AGHT+IGmdsjkEoyrmozqQGISPa/L6l5kiDRhunGvgCTv75BYOda1wSHPi1ysUKby0AhJp/Ks/CD/IE4Danj+623PZ74=
X-Received: by 2002:a17:90b:4398:b0:262:fb5d:147b with SMTP id
 in24-20020a17090b439800b00262fb5d147bmr1970432pjb.19.1694794922471; Fri, 15
 Sep 2023 09:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915083914.65538-1-larysa.zaremba@intel.com>
In-Reply-To: <20230915083914.65538-1-larysa.zaremba@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 15 Sep 2023 09:21:51 -0700
Message-ID: <CAKH8qBut66YcXeGypSH=MTos97Ljwv95VkzZw1uABYF8i4Rz1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags together
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 1:45=E2=80=AFAM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hin=
ts
> cannot coexist in a single program.
>
> Allow those features to be used together by modifying the flags condition
> for dev-bound-only programs, segments are still prohibited for fully
> offloaded programs, hence additional check.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=3DOKMdsxEkyML36VsAuZpcrsX=
cyqjdKXSJCBq=3DQ@mail.gmail.com/
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you!

> ---
>  kernel/bpf/offload.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index ee35f33a96d1..9d8e508c9b86 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -232,7 +232,14 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, u=
nion bpf_attr *attr)
>             attr->prog_type !=3D BPF_PROG_TYPE_XDP)
>                 return -EINVAL;
>
> -       if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +       if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS=
_FRAGS))
> +               return -EINVAL;
> +
> +       /* Frags are allowed only if program is dev-bound-only, but not
> +        * if it is requesting bpf offload.
> +        */
> +       if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> +           !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
>                 return -EINVAL;
>
>         if (attr->prog_type =3D=3D BPF_PROG_TYPE_SCHED_CLS &&
> --
> 2.41.0
>

