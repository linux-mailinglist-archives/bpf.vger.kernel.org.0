Return-Path: <bpf+bounces-2254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980E72A2DC
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5456C281A34
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DB19BDC;
	Fri,  9 Jun 2023 19:08:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440F408C0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 19:08:59 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8635B3;
	Fri,  9 Jun 2023 12:08:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9786fc23505so317496166b.2;
        Fri, 09 Jun 2023 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337736; x=1688929736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FKDXzi+6O/5nzYl6PTfgXvzi/zZ2LhOeduE0v1fE/U=;
        b=lYolvldeHQR96yeHpzz5ob7XqN9qps94IoAgM+RdCBvMy+AY3SOALGUjPe383sdeWD
         clA9Ih2w72bw8Oe3hBPjd18NrmjRiza3YW6n/vjruBxKNUXm42zkEqVH6pnmw9IjjTKY
         tepRsdmykGge36NCosxwYtixBo/ZyIKveG/MRD0Px2REE1LxCIFyBoOrwLMBtPHyG+Bx
         u0dRob3kgoD168UEHTfiWlbmFsusLREjC6vksvSXZ3/tZAAJOarjg3GErwuifB0D+LnV
         opjnxxIMqnUBYAlkYFVhMvbWyirhWxR5kmlJQsXgPSytWICipym830LiQDqxleFiFSzY
         iMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337736; x=1688929736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FKDXzi+6O/5nzYl6PTfgXvzi/zZ2LhOeduE0v1fE/U=;
        b=jeKHdcQaEvNnwIiT0JbbTkT6oJe/uxzJk2qleb/YqS2CU8nv2ek1CZov8wZHSj/tgI
         DxE5O3np4pWjlVxnN0FV7H3wAYCCC4u9nCWY/Xo06yFw0fGyKS826TzyGStwD1jfyIzw
         5QwQv2LLd94NTSdEfnmOaF1hljbuKiqqz3Pvh2ozGxy+MyuCYeG20ICzJZ2Wtg++L0nA
         +c3Fn9ybgIn2/417mBJysBZkTyz7MYnuyZxSrlNam1maBZCOkW4KsAHBynEl8vk8OlJZ
         bmY4sVailLtspIArm2LSKj0CIDvJI9gaX16MbAovlHmf8/9YwuqicOdVTYribICY+sdr
         hPNQ==
X-Gm-Message-State: AC+VfDyGSQku7oZZBha1DJTgsyMXvMWnZMT3KO7lF6HpbYBV9b7WWL8D
	IAczVpWGg1DkvDGM0VFNekZnOGxfmsxrQ33DBBoJPpm9EDg=
X-Google-Smtp-Source: ACHHUZ6qDN6wLpGr7OpnwuBk4dTYq1hr9Pp17psrkrS/VpTU6htO5RQY/Tiqdd0khx/oN++Xkcgm31ZArEw+0sXYE0M=
X-Received: by 2002:a17:907:1622:b0:96a:90bb:a2d3 with SMTP id
 hb34-20020a170907162200b0096a90bba2d3mr2729876ejc.71.1686337735790; Fri, 09
 Jun 2023 12:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
In-Reply-To: <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 12:08:43 -0700
Message-ID: <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, lennart@poettering.net, cyphar@cyphar.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 11:32=E2=80=AFAM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On Wed, Jun 7, 2023, at 4:53 PM, Andrii Nakryiko wrote:
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token.
> >
>
> I skimmed the description and the LSFMM slides.
>
> Years ago, I sent out a patch set to start down the path of making the bp=
f() API make sense when used in less-privileged contexts (regarding access =
control of BPF objects and such).  It went nowhere.
>
> Where does BPF token fit in?  Does a kernel with these patches applied ac=
tually behave sensibly if you pass a BPF token into a container?

Yes?.. In the sense that it is possible to create BPF programs and BPF
maps from inside the container (with BPF token). Right now under user
namespace it's impossible no matter what you do.

> Giving a way to enable BPF in a container is only a small part of the ove=
rall task -- making BPF behave sensibly in that container seems like it sho=
uld also be necessary.

BPF is still a privileged thing. You can't just say that any
unprivileged application should be able to use BPF. That's why BPF
token is about trusting unpriv application in a controlled environment
(production) to not do something crazy. It can be enforced further
through LSM usage, but in a lot of cases, when dealing with internal
production applications it's enough to have a proper application
design and rely on code review process to avoid any negative effects.

So privileged daemon (container manager) will be configured with the
knowledge of which services/containers are allowed to use BPF, and
will grant BPF token only to those that were explicitly allowlisted.

