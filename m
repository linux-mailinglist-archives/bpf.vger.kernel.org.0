Return-Path: <bpf+bounces-13760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0302B7DD80B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B057528188C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627427440;
	Tue, 31 Oct 2023 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0QDPRfm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48444417
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 22:06:59 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99230ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:06:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f70391608so2915741f8f.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698790017; x=1699394817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuVs8AUPbw2A2dQzYVCm0TFZBN0dF9WzXtZ/0bHCsOM=;
        b=T0QDPRfm3PVDYcjdcpBpebFpBZV42h62wfCCYy032XId6skXFDh6/oE3dlBXqT7paf
         6gcaiYl3ZixOni4fnAunwCL9teQ39gjurp4UQcf+0MBLouVhBklkqmFsBJApihWsDLPo
         9DwYf6efy0nGDTI7UoMhGnUGC2wd2EqEc0bbf/fFx/XCIpOABxkaVsD1khDc5cxklVWv
         ItzLLTtcw1XFbyWV7DJ7lDYVJ4+zb/M/Za074AoSwUbGuukix91F7qf3P2vK+5TX5nSW
         H34Jx3WSR8hqyuQ3H3vdDQVKZEHct7kM7cSHPF2TA8qv45hyZ8WLmJHill6T5wJNhsg4
         uzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698790017; x=1699394817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuVs8AUPbw2A2dQzYVCm0TFZBN0dF9WzXtZ/0bHCsOM=;
        b=c09rLQyWPXL7I+YBEdIOipel/pYJY4RzDyS+zF3JI6tdVoKuBqBHIgYl4qAJ83M4y3
         u4Q/kiWnlGXZygRwPRp2Heu747LnUV2gic6z4OBt7w2AIfI4ZweX37HjT+KcAVW/+jnD
         if2vMTKGeRfkKGKRyfMHlwUMkCX/bg0fXCATa/mzkdXbSplZQedEqYBa5z0mzEbY9iBy
         ErneSZNalxZlHzt2UmNESeC0F7L+oHnQboS/DcOraiT3Mbdct4tvizIZF6+DjRpRpEsH
         NapLjw1K4sCHP5qfQ3t4jDTzdJ533xKS3Mm0EcujJzKbR+CQgdG8L1QYRyhBhioRzH0K
         svxQ==
X-Gm-Message-State: AOJu0Yw3QYIVX0woMyyxEuz5FGIhlryxUUrKTcEL3R/dmmYclqqmW0zH
	u3ltFZqs8iDuKcLIW+cRv4PPp5G0iMw0zrHdQEE=
X-Google-Smtp-Source: AGHT+IHN/raB2+R9A/34JvklH/kxHhrK0gPTFIdcA6bSR4mlLXWBQctkGKfHJ8QU7pNuG15XijIyGwre/0d6h1Is6u8=
X-Received: by 2002:adf:fd45:0:b0:32d:9e48:c2ef with SMTP id
 h5-20020adffd45000000b0032d9e48c2efmr10039325wrs.44.1698790016815; Tue, 31
 Oct 2023 15:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com> <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com> <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
 <350dd3e5-3a34-42ba-85b9-ddb1a217c95e@bytedance.com> <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
In-Reply-To: <bcdce26b-b5cf-4eb7-bf04-7507f5e0ac85@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 15:06:45 -0700
Message-ID: <CAADnVQ+xaNK5vbGwrB25VvVTQhfQcCNHxqXCxBodrwpOvdkFWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 4:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
>
> So, maybe another possible solution is:
>
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 209e5135f9fb..72a6778e3fba 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -282,7 +282,7 @@ static struct bpf_iter_reg bpf_cgroup_reg_info =3D {
>          .ctx_arg_info_size      =3D 1,
>          .ctx_arg_info           =3D {
>                  { offsetof(struct bpf_iter__cgroup, cgroup),
> -                 PTR_TO_BTF_ID_OR_NULL },
> +                 PTR_TO_BTF_ID_OR_NULL | MEM_RCU },
>          },
>          .seq_info               =3D &cgroup_iter_seq_info,
>   };
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 59e747938bdb..4fd3f734dffd 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -706,7 +706,7 @@ static struct bpf_iter_reg task_reg_info =3D {
>          .ctx_arg_info_size      =3D 1,
>          .ctx_arg_info           =3D {
>                  { offsetof(struct bpf_iter__task, task),
> -                 PTR_TO_BTF_ID_OR_NULL },
> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },

Yep. That looks good.
bpf_cgroup_reg_info -> cgroup is probably PTR_TRUSTED too.
Not sure... why did you go with MEM_RCU there ?

