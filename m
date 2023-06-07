Return-Path: <bpf+bounces-1971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C272516C
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 03:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0781C20A2C
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE06632;
	Wed,  7 Jun 2023 01:16:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689777C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 01:16:16 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C161984
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 18:16:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1b06af50eso61010821fa.1
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686100572; x=1688692572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX2M4Gjc6bP98JKIfbiuj+vA/YsrjDXWkwSwi4DS4co=;
        b=RolWz4b9aipocweGXolSj3eM5GC+wnXjitn+210TY9ohfQUoKXmBw2gJFZUeu1qeG9
         /dG+0qU4Mv7kbCu0K0cwUzUx7rbjaodi1nxlxMvtnZWfIcAsjE4HMwLhuT8bVsfo6Bgk
         si5uHM6D2wQvc1k6PtEqd5uJXa1yl5/Xk8dqR12mqqxqusAohT8YOUv30zGJ1tWi06ug
         cNvRrCzvF43g8+PDMI9gjU8DXsqZHkG88R9UAnMq04RoPWUpjENFeZPEi+hin1o3w4eR
         219hnGG16HoNGqX9JAUKYOmR8wMUrw0e84BWTcmDEtQH5FopJO/cupyodlFJdpycugEh
         Zv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686100572; x=1688692572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX2M4Gjc6bP98JKIfbiuj+vA/YsrjDXWkwSwi4DS4co=;
        b=Vq1MO2U1WD4PcNCSNRJcupvvgO4cx36BVIyiCf+ESFA0AjaQKxst7uFF/QSI6sBpAd
         CAv3DbLCZIc+kZ/YfIDFda58uj4rtWyWy3BjRHor5ss/cLLFUAdoE0LIxC8yk6u9z7pf
         WI4XdoiRfzHBmPAmWbF10cGOqVMbw1oCwAenN0u1YYS0AZY9d+EwMdERSFbIHCru90dH
         9v1xs3gLv2Bu9Ly9a2HSwPDmiJzckph9JkYsArGYZhisXa8rv61ZdKVi+bxUYDrwDk7o
         ZBlx7o3JB0fdkBkY5OZeuWlq2QbMkDLTHaqdst2CgdiMS1R4ouxGleqM/GFuP4+KaX3Z
         USTA==
X-Gm-Message-State: AC+VfDz2ISRGjrGViZtY6YoJxsUppyDOalobLs2GfDmyEZeijIVev3NI
	N0LBFwhaMP3fSB3lygz7sUR5XXvmHpLzYNUJ0Zg=
X-Google-Smtp-Source: ACHHUZ63IOM0HN3thZfelRvNQktT1kau2zmnBhiIe1mr9EQesTIyQdib4ju2pUciAhqoo0bS1WXSWnHcYEm+AYRrV5s=
X-Received: by 2002:a2e:97d3:0:b0:2b1:cb17:b445 with SMTP id
 m19-20020a2e97d3000000b002b1cb17b445mr1652849ljj.48.1686100571961; Tue, 06
 Jun 2023 18:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com> <CAEf4BzYG2FFcM_0mkiARzKnYinQYHpWE8ct35Z==-Fsefv9oQw@mail.gmail.com>
In-Reply-To: <CAEf4BzYG2FFcM_0mkiARzKnYinQYHpWE8ct35Z==-Fsefv9oQw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jun 2023 18:16:00 -0700
Message-ID: <CAADnVQJ712O0FeKQwUAG1+WvFTkX1FBNTb1v+frA7vNAkXLgqg@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 9:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Agreed, I don't think we can ever make BTF dedup work reliably with
> KINDs it doesn't understand. I wouldn't even try. I'd also say that
> kernel should keep being strict about this (even if we add
> "is-it-optional" field, kernel can't trust it). Libbpf and other
> libraries will have to keep sanitizing BTF anyways.

Good point. "it-is-optional" flag should be for user space only.

> > If we go this simple route I'm fine with hard coded crc and base_crc
> > fields. They probably should go to btf_header though.
>
> Yep, on btf_header fields. But I'd not hardcode "crc" name. If we are
> doing them as strings (which I think we should instead of dooming them
> to 32-bit integer crc32 value only), then can we just say generically
> that it's either "id" or "checksum"?
>
> But I guess crc32 would be fine in practice as well. So not something
> I strongly feel about.

I still fail to see how generic string "id" helps.
We have to standardize on a way to checksum BTF-s.
Say, we pick crc32.
pahole/clang would have to use the same algorithm.
Then kernel during BTF_LOAD should check that crc32 matches
to make sure btf data didn't get corrupted between its creation
and loading into the kernel.
Just like btrfs uses crc32 to make sure data doesn't get corrupted by disk.
libbpf doing sanitization would need to tweak crc32 too.
So it's going to be hard coded semantics at every level.
id and especially string id would be cumbersome for all these layers
to deal with.


> > We don't need "struct btf_metadata" as well.
> > It's making things sound beyond what it actually is.
> > btf_header can point to an array of struct btf_kind_description.
> > As simple as it can get.
>
> Agreed. Still, it's a third section, and we should at least have a
> count of those btf_kind_layout items somewhere.

of course.
In btf_header we have
        __u32   type_off;       /* offset of type section       */
        __u32   type_len;       /* length of type section       */
I meant we add:
        __u32   kind_layouts_off;
        __u32   kind_layouts_len;

