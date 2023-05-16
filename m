Return-Path: <bpf+bounces-671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F402705635
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA1728118F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65D290EA;
	Tue, 16 May 2023 18:43:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D5290E6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:43:09 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE88699;
	Tue, 16 May 2023 11:43:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965f7bdab6bso2591916466b.3;
        Tue, 16 May 2023 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684262579; x=1686854579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVglkrRn4KtUXyMZNafVQZU+oIXi6ViD3yp4abRe5us=;
        b=IA/OenOHU9PgFrxQAXYsdghkYdGIy43feL3FTATpObUDFEYrj6xlyIBNW00RSu6ldZ
         +D5KHsBd4VD1hVbTKtkn8IwHQVpbpKQ/9KyavuDYuG+fQQ2jELHR8LaPPLTMtug717ta
         T/yQP6GUgym3x7/Y5OAbHwew6bo/Q7suLGQ1aCAu01aRI0+duy8aGAAl5g6vCt8mY6NS
         WSkf392GY+b+2IVFOGKjXQjtH++pbzaksICihue4V911EBtbbHIUxb4lYLROXpOMPMtx
         ngdZ//qR17N1Id7PxPd9TfdJ45elklIEc3OJkVl8/fge/fJDO3LcYh/xpuuchVEe7yTh
         Aj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262579; x=1686854579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVglkrRn4KtUXyMZNafVQZU+oIXi6ViD3yp4abRe5us=;
        b=F1MhrkrpJE4iYgA+xBwf0jYzMp4kv13xAfjOyhCORE7P5yp7f4HZmXisAMqwAv3QN9
         5WWeYMUwoIPZNPkQN/j6XudfJfZixb08FqaF/dywp9X89ADIPBnygnQ5FdNM6jCFxfun
         89uZ0NzM6kWUtMM7c+Zld0VtvsW+kwzQ6+pMPedAUXG7V/aOqgxWOiSBHm4EBFkOCELf
         hHgGIlU/cRyWWAFPrV/dCBGCe/kfNn6PQdpSxgyLX9r0AZOqWBAEd/J5uCRBwsxqfcRy
         X/jY7sv0Gu6dIc+8zS4Yr19UllOwGIdzWYhyZIbOyOUcxIt5rm9GViyu90+1Myuu8bBA
         xApA==
X-Gm-Message-State: AC+VfDyRk1bKAy5+hJl4a+PSvi/uYi9qt9JKseWD0iLtgPNKxIFKPrct
	JKw1AR8jYsedtWsbbE8h0QY9QJnAyBCR/09A50k=
X-Google-Smtp-Source: ACHHUZ7DQoLVJ0vKmRsE9LB84jy1OteAEcWOk3C+hTAT+8orW2PcZyhZmqQFbx1mnEZjp37ySMq8vFPj3Fxp71KOilg=
X-Received: by 2002:a17:907:701:b0:96a:26d2:53db with SMTP id
 xb1-20020a170907070100b0096a26d253dbmr19418703ejb.15.1684262579111; Tue, 16
 May 2023 11:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511142535.732324-1-cgzones@googlemail.com> <20230511142535.732324-8-cgzones@googlemail.com>
In-Reply-To: <20230511142535.732324-8-cgzones@googlemail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 11:42:47 -0700
Message-ID: <CAEf4BzbykOarEf9DWJLks-=bYdOAUvkLKrYvVt1GvJUs=08ojw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] bpf: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 7:26=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>    rename to capable_any()
> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573e..1bd50da05a22 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2539,7 +2539,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>             !bpf_capable())
>                 return -EPERM;
>
> -       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !c=
apable(CAP_SYS_ADMIN))
> +       if (is_net_admin_prog_type(type) && !capable_any(CAP_NET_ADMIN, C=
AP_SYS_ADMIN))
>                 return -EPERM;
>         if (is_perfmon_prog_type(type) && !perfmon_capable())
>                 return -EPERM;
> --
> 2.40.1
>

