Return-Path: <bpf+bounces-257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D346FCC87
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8F28107B
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5817AA7;
	Tue,  9 May 2023 17:18:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946D17FE0
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:18:51 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52A26AD
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 10:18:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so7123030e87.3
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683652727; x=1686244727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAdFIUqWrEWPP5bcpz3FGsivU7ADHp8tiRVMfC/5zAU=;
        b=ewKsIpnw1HNhXCZHzCgwBW3aaqTS5ScyELQg58zgMMwEwciErg0g6xn8sTCRAACkmh
         umivrpeXgfv10xrwPzAsR58k8JA9lDF5s2aEomaRUtgW9tCcmt9vWVELj0YI/G68wqyr
         pwTiKCIklkrNO2NBCGGqKmguBQTXuxbHbdBZk6bNXwgz3qcalOw6FLQzD8OWezAqPvmK
         hM6D2zHBdZu+RpwjAwd4MGGTGuA5lkgEwgzpC/HSo4zsUTg9wlGKvO5V+w1J2TEyNFct
         ylHEONGNvCEBlDK+/XMyAc/ShoeQdj+IG4QP4EyvU3erQ6udPfH5xqfZs/IqTuND3pfl
         PW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652727; x=1686244727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAdFIUqWrEWPP5bcpz3FGsivU7ADHp8tiRVMfC/5zAU=;
        b=CqL9aeVDx92aYmgpsIA6uyc4YGsmx8MVvYGpK93nUKfVZz+Aq2PmloQky48baKHF4V
         vYkp/yXwLNTUz1bw9Sp9Bf3y0c0y6kIL3gxXlPLT8WhJK25yWySoTSQuftwj1za539LN
         j/Gy93ALhPUSnsRFIC0UXkvrY7OwL9fzt+Feapbea53vh8SuK6iIOPzj3BTDZMrmPQNP
         Qx/DfnrM/OimhOMCYsLvMqUUg41IEVTiCojQlajr1Zl/9fOHf68oS3IPuz88bSo0E7UT
         /Kgd+smHOMpKaw/eb3Zhkw8KoqvlgbREOX+MsR4LtehqSov/1dVECJThT4KxLZ0e7zST
         sycw==
X-Gm-Message-State: AC+VfDxeY8nZBpkjHvOXmZ1G6wiwaOXIju9QmRynvSf2LoMCEBESw7Kc
	9KI4wkmjWUsNM9Rn3p+RS3gHbJzSy1f2iUBS578=
X-Google-Smtp-Source: ACHHUZ4O2nQSudnflLOXsacVCxZsDhC7qLiQaIN58ctAG86pATDq0zyBA5yiaXHR90JS/sj7tkaPwPvOA4+AQRQ9Sag=
X-Received: by 2002:ac2:4104:0:b0:4f1:4040:8143 with SMTP id
 b4-20020ac24104000000b004f140408143mr997060lfi.60.1683652726955; Tue, 09 May
 2023 10:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com> <CALOAHbAnGLYV9H2t=4rHxdmXwUhXbsUEvK5-MLPq38JkUR8jGw@mail.gmail.com>
In-Reply-To: <CALOAHbAnGLYV9H2t=4rHxdmXwUhXbsUEvK5-MLPq38JkUR8jGw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 May 2023 10:18:35 -0700
Message-ID: <CAADnVQKuaKwfwPvt3ffi3Gkzsq=9Oj=tnb6Ya1O0EX5uApQg7w@mail.gmail.com>
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
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

On Tue, May 9, 2023 at 8:36=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Tue, May 2, 2023 at 11:40=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Alan,
> >
> > wdyt on below?
> >
>
> Hi Alexei,
>
> Per my understanding, not only does pahole have issues, but also there
> are issues in the kernel.
> This panic is caused by the inconsistency between BTF and kallsyms as suc=
h:
>    bpf_check_attach_target
>        tname =3D btf_name_by_offset(btf, t->name_off); // btf
>        addr =3D kallsyms_lookup_name(tname); // kallsyms
>
> So if the function displayed in /proc/sys/btf/vmlinux is not the same
> with the function displayed in /proc/kallsyms, we will get a wrong
> addr.  I think it is not proper to rely wholly on the userspace tools
> to make them the same. The kernel should also imrpve the verifier to
> make sure they are really the same function.  WDYT?

Are you saying it's not proper to rely on compilers
and linkers to build the kernel?
pahole, resolved_btfid, kallsym gen, objtool are part of the
compilation process.
The bugs in them are discovered from time to time and
have to be fixed. Just like compiler and linker bugs.

