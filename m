Return-Path: <bpf+bounces-1479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2ED71744B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 05:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7941C20A8F
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F111865;
	Wed, 31 May 2023 03:18:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEF1852
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 03:18:18 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC75E41
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:18:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6260a2522d9so26758256d6.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685503096; x=1688095096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XgDCTdNyXD8FQGybJBMQrXFx/o3sPFpK8e5gc2qGKM=;
        b=SOdq6bYhthD0r1b/SNzN4M3PnfZBxi1PeJpD7SPzhrtQ6YGZTRLpg8bAx2owNu40Qi
         8Z3k8BnDe8+CgfrH5P/locDxAFAfM4ziw2reKsyAYihGdFdFoTJZB9d5DjTyZSi4uKUY
         8bHyAp1PrD6RL2ZjTqOxO5kXEuDBDx+LBtOu4L3p+cp9TGUMMDqZpmNikQiGeqiO+A4b
         hCPHv10ylm0egS6vYG2ir2VV3UEj773AjcygwC5YiacqrLG21fJJ7rfuBT0A7IAgDlaE
         qWy73v3ynBXAsd7kdhdyg6JsumDxq1W5+CC7Zo5/U61DsFeoUcr+KEV8K78rWpiJn+c8
         xSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503096; x=1688095096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XgDCTdNyXD8FQGybJBMQrXFx/o3sPFpK8e5gc2qGKM=;
        b=Pd2AkSzjRGBdXDxQsSFfjwN7TMRGZ1zCTnWxn2lpyugJvUI3Ojrq2XeNsDDkkDk+Dp
         tFNWuKZ67thp/Ov6r0NVR+Roq9eSDhSTamd88503xWLe+Yhv78sBqnkZ8rw3PBMDphIk
         b1oijw+H1oxOkaf4pCSB9+qRwYevTmshMoJGlPqPtKnEWC7GNqUcuGeK8+zK6Z6wik7R
         NJI7fWEFdfZzwEK6srlR6Ep88dclTuzYaYEmjkQtQtiqCqedn8M8D44NVBVzdPLUd+Hy
         BSnW7qwFUaJJvamlehbG5/fTC/114V1IkG0v093erywNYtciBV84eKbCTobSAbKO+3yY
         vz3Q==
X-Gm-Message-State: AC+VfDzMDD+rO4993djjpnjDGYg5r1iyZUVkm9gQetoV2Iu27FKqP1wb
	AIZqZDCElCwyTx6+ZlJv43wm2VwVkRZjm9gpz4Y=
X-Google-Smtp-Source: ACHHUZ6MdkR+r78DkrWTOB5VAmlOyvypRrltJ06bb166KTpoM7HXt4w+iaNKmguSbafRV00dSpZ0EJfuMdVDJdi9T7Q=
X-Received: by 2002:ad4:5947:0:b0:61b:5e9b:a15d with SMTP id
 eo7-20020ad45947000000b0061b5e9ba15dmr5024505qvb.36.1685503096251; Tue, 30
 May 2023 20:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230528142027.5585-1-laoar.shao@gmail.com> <20230528142027.5585-4-laoar.shao@gmail.com>
 <20230531003116.vcxiogqjntrzfdhi@MacBook-Pro-8.local>
In-Reply-To: <20230531003116.vcxiogqjntrzfdhi@MacBook-Pro-8.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 May 2023 11:17:40 +0800
Message-ID: <CALOAHbAEcsFvPva5Mh64ntokpcF-J6kkoB5SktX=rBx+Qs-A4Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/8] bpftool: Show probed function in
 kprobe_multi link info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 8:31=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, May 28, 2023 at 02:20:22PM +0000, Yafang Shao wrote:
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > $ bpftool link show
> > 2: kprobe_multi  prog 11
> >         func_cnt 4  addrs ffffffffaad475c0 ffffffffaad47600
> >                           ffffffffaad47640 ffffffffaad47680
> >         pids trace(10936)
> >
> > $ bpftool link show -j
> > [{"id":1,"type":"perf_event","prog_id":5,"bpf_cookie":0,"pids":[{"pid":=
10658,"comm":"trace"}]},{"id":2,"type":"kprobe_multi","prog_id":11,"func_cn=
t":4,"addrs":[18446744072280634816,18446744072280634880,1844674407228063494=
4,18446744072280635008],"pids":[{"pid":10936,"comm":"trace"}]},{"id":120,"t=
ype":"iter","prog_id":266,"target_name":"bpf_map"},{"id":121,"type":"iter",=
"prog_id":267,"target_name":"bpf_prog"}]
> >
> > $ bpftool link show  | grep -A 1 "func_cnt" | \
> >   awk '{if (NR =3D=3D 1) {print $4; print $5;} else {print $1; print $2=
} }' | \
> >   awk '{"grep " $1 " /proc/kallsyms" | getline f; print f;}'
>
> This is not human friendly.
> Either make bpftool print complete info or don't do it all.
>

I will make bpftool print complete info in the next version.

--=20
Regards
Yafang

