Return-Path: <bpf+bounces-11708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20DB7BDDA7
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D350281788
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7881946F;
	Mon,  9 Oct 2023 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIsj0s+M"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30F19463
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 13:11:59 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553B2698;
	Mon,  9 Oct 2023 06:11:37 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65d066995aeso27582716d6.2;
        Mon, 09 Oct 2023 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696857097; x=1697461897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lip9Tfr2iVUz72xzsu3YDcGeKZy4OZ3h45WW+Voive0=;
        b=RIsj0s+MXOj+c7rDAvjlug+8jbVLQ2z0NqLAFKd/TtnVE/j+eZ4Kug3eziB2+zZB3I
         fIX+KnUTPNVHFb5p8bz/h0/ZtsjUtyKxIPgVTlByemb2VxntuES5Q3FmzhMH3YKvJixI
         yJgDobACuR5vluhAeGkiKuqrhMEaG3Hfb/Hn2KFppz46y4ZGtTNjEaraPtblsJcScnyo
         dpfaAT88eD/ntqfjNNnPhoHqcXuGgrYVPH4WO1TybH7b0rEz2tZb/aN4NWbNYBw059my
         WtzTtpAqTS2NBN0Ei/0yQGUX3qNtpBDsr6IuDJI851TLMaIMjKPW/72OiExmSp5zrp4f
         bDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857097; x=1697461897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lip9Tfr2iVUz72xzsu3YDcGeKZy4OZ3h45WW+Voive0=;
        b=oKSSmiDocpp9OcjNVLM4Hmk8zrPwl0B4LfNiIeGTXaFixNL0BOAkVdfuSFcGesDnNT
         mdkAAzQQiAgABJ9+UOBy+9CnNoGOiE9/Z1278NXdyJAN8GXt5uWxiLvJH4GfFbpZl3fj
         Sm1YOjy58KPf7YySY1b9dOvP++8eQDhcaXROhH5ifZ1M6wRcwqRhDJb7OA7HLnp6by5Q
         HGZaNwi4kPeslT5riBiXH5t3gEtntpVGolo+AZ8Mg7LsnAy4xPc7YeksQnDin2oeDhUW
         US9szsPOZbTH3MvMq4DI7MtsDpy+ZGjECsy8tjzSspZtcqHp7K6lLjFpa3g+jzIO3iI6
         mUeQ==
X-Gm-Message-State: AOJu0YxMgCIP5cO3j2XJaCG0PpGQE9mddxVb3yRJb6vWSxNc+QQg8Hw/
	gGDocFpRpgvf7ilQjkmxw7vDV9IZKiTPFpeXrso=
X-Google-Smtp-Source: AGHT+IHa2iKrv157mg60JkD1EX/p8jjNPAr9Y0ACFdtD7YdD1xJ3MncuS61ZKiBOOgcl76osW3oURkSDXcUM7MuAvmw=
X-Received: by 2002:a0c:e9ce:0:b0:641:8df1:79e3 with SMTP id
 q14-20020a0ce9ce000000b006418df179e3mr15663390qvo.29.1696857096815; Mon, 09
 Oct 2023 06:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <kitlkwmcd45ng5nx442orpdwb55fajfiovupc72evx3coflssq@nomeuw22bwom>
In-Reply-To: <kitlkwmcd45ng5nx442orpdwb55fajfiovupc72evx3coflssq@nomeuw22bwom>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 9 Oct 2023 21:11:00 +0800
Message-ID: <CALOAHbA54R-wBWVC1QM6P2n8sWpg2_ZSj8vHcqk4QnPAim7fJQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add BPF support for cgroup1 hierarchy
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, sinquersw@gmail.com, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 7:46=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hi.
>
> On Sat, Oct 07, 2023 at 02:02:56PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > Given the widespread use of cgroup1 in container environments, this cha=
nge
> > would be beneficial to many users.
>
> This is an unverifiable claim (and benefit applies only to subset of
> those users who would use cgroup1 and BPF). So please don't use it in
> this form.

Sure. will remove it.

--=20
Regards
Yafang

