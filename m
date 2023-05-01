Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCF6F3830
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjEAThU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjEAThE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:37:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CA30F8
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:34:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24de9c66559so1376877a91.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682969598; x=1685561598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrRuqPA6ltNz2GlFRiANj7Vzi5ao5Ojn5kqKbUPGS+8=;
        b=2OuCLsvXB70NsqoF4bHpG1j4cYdpDCdCGt7ALwDrxc3TNkgCbGDfiJgUCuIH614pOI
         hiv+yl0jtOjiQaZ9d9oGNyOOQhXt2iQc/akAE3hFAUN/lfMDWk4EFoZ1ZEo5fbNWwhZm
         J3qP9JSTTArYZl2XFLHp53XT4csfDRQu0qoJI9jz0a48FX+8DsurBI3+RhlxuyUhFyqp
         tZExZp3El4F1CztepmUvaczpKejcATNLmgNJr02nbqhGvd/g2iWxfRqOVqbCLYhSL/52
         Dcs/1BtyL4Xpt8TgOdHI497M2jkl67fCboRCzey+tO3/SPSICK12h4a7q4WkS8uSwu1O
         khnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969598; x=1685561598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrRuqPA6ltNz2GlFRiANj7Vzi5ao5Ojn5kqKbUPGS+8=;
        b=fiHoTeFdtfQjeXQGF3MDOg1diGqqn8NDS98gxEFf5TnWctc2Be02q0S0ChGb4oJbA1
         9jMEusdSjA4LGKSG5CzI3jNr6U3nFlP2Zro5iJOAqUU6W0z/s9goPyIk4Vi45A7khFx0
         2jXbN/GZKglhXq7pvs6+GgYA/i7pA63KgggSB1X2oQ9F06qqioQljUqcAsziiEJcAHWR
         6kWcb28XTFwBSIN5wKVzGi0JWzWkoeLM3Y2nbQ8a1M4dSJNhDMZGtS+xXG4NhdA6JJNB
         ppQHJNhsTwImNGzoc0okt8GIsduN9CLqggOPG9xdjTUUgvcmuPlm7vMYNdyVLC83pMbN
         4Oxw==
X-Gm-Message-State: AC+VfDyup8jaQYsFRkSX0gXfQAs7+FE5q9X1qIVt1MAL36Y9zTsZ+gKn
        D0tfOyoy1Rj7UaG6gWxoPP+utCJIQMXv3vmJZjdyfA==
X-Google-Smtp-Source: ACHHUZ4Q8D8NaaHOSi3hAUBXK6ZoL1qoQEHv0IG/aIHRH2UL5N1UyGID5pY1dAOPecp5QZaldiwjqWaZX/m6m/gyP+0=
X-Received: by 2002:a17:90b:4a07:b0:247:8f24:eb27 with SMTP id
 kk7-20020a17090b4a0700b002478f24eb27mr15266634pjb.29.1682969597662; Mon, 01
 May 2023 12:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com> <20230427200409.1785263-2-sdf@google.com>
 <5ebd6775-2be4-76b3-d364-a4462663e32d@linux.dev> <CAKH8qBv_CdoKy07_y5Umcxq_-K7_hcLj4jxaMmezhVnLviDgCg@mail.gmail.com>
 <07b89cc9-badf-4803-2d43-cfc3e4ff883d@linux.dev>
In-Reply-To: <07b89cc9-badf-4803-2d43-cfc3e4ff883d@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 1 May 2023 12:33:06 -0700
Message-ID: <CAKH8qBu-PBf85EifnFEh-k3viFfRD5NSgg16vhuWZcYAhgQjsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 1, 2023 at 11:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/1/23 9:55 AM, Stanislav Fomichev wrote:
> > On Sun, Apr 30, 2023 at 10:52=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> >>> @@ -1881,8 +1886,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct =
sock *sk, int level,
> >>>                .optname =3D optname,
> >>>                .current_task =3D current,
> >>>        };
> >>> +     int orig_optlen;
> >>>        int ret;
> >>>
> >>> +     orig_optlen =3D max_optlen;
> >>
> >> For getsockopt, when the kernel's getsockopt finished successfully (th=
e
> >> following 'if (!retval)' case), how about also setting orig_optlen to =
the kernel
> >> returned 'optlen'. For example, the user's orig_optlen is 8096 and the=
 kernel
> >> returned optlen is 1024. If the bpf prog still sets the ctx.optlen to =
something
> >>   > PAGE_SIZE, -EFAULT will be returned.
> >
> > Wouldn't it defeat the purpose? Or am I missing something?
> >
> > ctx.optlen would still be 8096, not 1024, right (regardless of what
> > the kernel returns)?
> > So it would trigger EFAULT case which we try to avoid.
>
> My understanding is the ctx.optlen should be 1024 after the 'if (!retval)=
'
> statement.

Ah, you're right, thanks! Will add your suggestion.


> The 'int __user *optlen' arg has the kernel returned optlen (1024). The '=
int
> max_optlen' arg has the original user's optlen (8096).
>
> int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>                                        int optname, char __user *optval,
>                                        int __user *optlen /* 1024 */,
>                                        int max_optlen /* 8096 */,
>                                        int retval)
> {
>         /* ... */
>
>         orig_optlen =3D max_optlen; /* orig_optlen =3D=3D 8096 */
>         ctx.optlen =3D max_optlen;  /* ctx.optlen =3D=3D 8096 */
>
>
>         if (!retval) {
>                 /* If kernel getsockopt finished successfully,
>                  * copy whatever was returned to the user back
>                  * into our temporary buffer. Set optlen to the
>                  * one that kernel returned as well to let
>                  * BPF programs inspect the value.
>                  */
>
>                 if (get_user(ctx.optlen, optlen)) {
>                         ret =3D -EFAULT;
>                         goto out;
>                 }
>
>                 /* ctx.optlen =3D=3D 1024 */
>
>                 orig_optlen =3D ctx.optlen;
>         }
>
>         /* ... */
> }
