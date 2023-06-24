Return-Path: <bpf+bounces-3374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526FC73CCAA
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842571C20934
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011389473;
	Sat, 24 Jun 2023 20:21:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB46AD7
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 20:21:23 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADBD11A
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 13:21:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso1110753a12.0
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687638080; x=1690230080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+KYB/v1IW2vEd+Hh08pSmhiHIhoyBR+i3Vo+okpu+k=;
        b=jE9n2zeWa5yE+boa0aSmM1PCu+d/6nbdD4vG42b3HdApjiQJKejUBe68XnpAkbDoIM
         pnweqnF+hrCW9Sl33+grBCEEi/a1wbYDVOZdujC58cK3ODRb6wznGWbsb/AF+3tqlVql
         R8TkkJY0QTbV9RfxXrYGYstvhZThvapj53hbjRM8gNLDrhSjaFFN15phyXqe4xrRk1Dl
         3TFbQwIW3xnitb1O8PuCvj07YQ60O4CE24dleZSvHzQrVarmR9YhqpbFHeD6cYRXiXOM
         upx4QoAC8CAdYfpQRVJrAFBFo/wGN4oSYq6N9lnAVLsRs7S0XCQ/+dd22NPF0s6TmLum
         7eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687638080; x=1690230080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+KYB/v1IW2vEd+Hh08pSmhiHIhoyBR+i3Vo+okpu+k=;
        b=OSJVGx7XLgxfgJIawVuvd2nGzJqipA+1/OSuUyUJLjnSeUagmsksE1EUzdiGlTdj0w
         ftBbbgmQB3YC9F8UPd6wU1xxZay/yXyxg8BrxQz5I5hqCuRoQNYgNJy7AFPFeONV58QC
         NF+nymXYXTTiczeXhs2j1Kv1uAPgZa5oepIczq0PoACa/obX/tuda8OdzR+SfEu73BGg
         HCtUES691HJR90aBSpUzLBHFLF1llJr+zZzs7/8+FdcPzzqVOGH1or6gqA+Wz4X0fkQH
         tySeLL0GLVjHuc8s97LPR7grIg+P9em8OH1jKml4ODTGEwsVk1c9r3JsILkssmvpgU3F
         xfLA==
X-Gm-Message-State: AC+VfDxSt4yE6iqlnD+K1TjJML3QJl5//dlbdwQoNKPrQEYDp2GgpJFf
	W6m/ShWwY99O6hBwz1HBeIByfnJjmRBXRZGfVTk=
X-Google-Smtp-Source: ACHHUZ6TOj7kTxTmyGgBdNvIW9MskuagYUOu5/nueQD2QSsmgNnQzIQ4ZPv7DjblocmdQ7wgt1uk+OO4+CHJqhkZwiM=
X-Received: by 2002:a05:6402:31e7:b0:51d:8a68:ed33 with SMTP id
 dy7-20020a05640231e700b0051d8a68ed33mr894078edb.30.1687638080050; Sat, 24 Jun
 2023 13:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com>
 <CAEf4BzZWWjhrpGpbkU+qy5+ZoPVDHnhp9grQcFoxf11B9Lq1Ow@mail.gmail.com>
In-Reply-To: <CAEf4BzZWWjhrpGpbkU+qy5+ZoPVDHnhp9grQcFoxf11B9Lq1Ow@mail.gmail.com>
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Sat, 24 Jun 2023 22:21:08 +0200
Message-ID: <CAGQdkDuoUp6QCztoF72uS+5OjB2PDLJ0y+aJC0Dou4iOK6MWuA@mail.gmail.com>
Subject: Re: [QUESTION] Check weird behavior with CO-RE relocations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 23 Jun 2023 at 22:54, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Jun 21, 2023 at 3:51=E2=80=AFAM andrea terzolo <andreaterzolo3@gm=
ail.com> wrote:
> >
> > Hi all!
> >
> > Recently I faced a strange issue with CO-RE relocations and the
> > required privileged to run our eBPF probe. In Falco, we try to support
> > a vast range of kernel versions and distros, so to support COS systems
>
> what's COS?
>

oh sorry for that! COS stands for "Container-Optimized OS" and is one
of the most used OS on GKE(Google Kubernetes Engine) nodes

> > we added this custom patch [0]. More in detail:
> >
> > if(...)
> > {
> > }
> > else
> > {
> >     struct task_struct___cos *task_cos =3D (void *)task;
> >
> >     if(bpf_core_field_exists(task_cos->audit->loginuid))
>
> unrelated to your issue, but I think you are misusing
> bpf_core_field_exists() here. You should only have one arrow in the
> field expression (i.e., no extra pointer dereferences except). Or
> better use the form bpf_core_field_exists(struct task_struct___cos,
> audit). As you wrote it, it might be checking only existence of
> loginuid inside typeof(task_cos->audit), but it doesn't check that
> task_struct has audit field.
>

thank you very much for the suggestion!

> >     {
> >         BPF_CORE_READ_INTO(loginuid, task_cos, audit, loginuid.val);
> >     }
> > }
> >
> > The issue is that now when running on not-COS systems we face this
> > error when using only `CAP_BPF` and `CAP_PERFMON` capabilities:
> >
> > libbpf: failed to iterate BTF objects: -1
> > libbpf: prog 't1_execve_x': relo #791: target candidate search failed
> > for [1238] struct audit_task_info: -1
> > libbpf: prog 't1_execve_x': relo #791: failed to relocate: -1
> > libbpf: failed to perform CO-RE relocations: -1
> > libbpf: failed to load object 'bpf_probe'
> > libbpf: failed to load BPF skeleton 'bpf_probe': -1
> >
> > If we use CAP_SYS_ADMIN all seems to work fine. The issue seems
> > related to the fact that during the relocation libbpf is not able
> > to find `audit_task_info` in the running kernel BTF, since we are not
> > running on COS system, and for this reason, it searches for it in
> > modules BTF, but in order to do that we need CAP_SYS_ADMIN[1].
> > Is this the intended behavior?
>
> Not really, though it is unfortunate that we need CAP_SYS_ADMIN just
> to find kernel module's BTF. cc Alexei, maybe we can relax some rules
> at least for BTFs?
>
> > If we want to support specific kernel structs like `audit_task_info`
> > do we need to run with CAP_SYS_ADMIN always enabled?
> > Is there a way to disable BTF module search with libbpf?
>
> We should probably just say that if CAP_SYS_ADMIN is not granted, we
> can't relocate against kernel module BTFs.
>
> In load_module_btfs(), just add an extra check after
> bpf_btf_get_next_id() for -EPERM. Would you like to submit a fix?
>

Sure! I will submit it!

> >
> > Side point:
> > Not sure this is the right place to report it but it seems that some
> > COS versions ([2]) backported something wrong: they backported the
> > `BPF_FUNC_ktime_get_coarse_ns` bpf helper but not the memcg-based
> > memory accounting. For this reason, libbpf doesn't bump the
> > RLIMIT_MEMLOCK supposing that the system uses a  memcg-based memory
> > accounting and so we face the same error reported here [3]
>
> this feature detection gap is a known issue, unfortunately. There is
> no nice way to detect the need for memcg-based accounting,
> unfortunately. You'll have to bump RLIMI_MEMLOCK yourself, sorry.
>

Sounds good, thank you!

>
> >
> > [0]: https://github.com/falcosecurity/libs/pull/1062
> > [1]: https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6=
f970171dc9d01/kernel/bpf/syscall.c#L3704
> > [2]: https://github.com/falcosecurity/falco/issues/2626
> > [3]: https://lore.kernel.org/netdev/20220610112648.29695-1-quentin@isov=
alent.com/T/
> >

