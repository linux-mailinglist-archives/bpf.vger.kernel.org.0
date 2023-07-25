Return-Path: <bpf+bounces-5835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E4761C06
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B3D1C20EC0
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729A21D46;
	Tue, 25 Jul 2023 14:41:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710881F17C
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 14:41:21 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9A2D47
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:40:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so3839926a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690296051; x=1690900851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IThHZKgOu2CI5lLaW4+dohujcbudp1VuPGinJk5/sjg=;
        b=YycOgFH4zQyYEHbalkot5ZX4yBrIJRW7H0IyiNBqCjc4D8OlAEz+b4bIO59iZ49fRx
         zXsyax8B84PncxwgOuAD/wa5ujUzvNlDDELrEwV0QP2mM/De2ayWTLG3zzwXIzsbf26B
         t7ubBySeNUCXq+H8Dmcw5oqpgp3RwpGP1rIOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296051; x=1690900851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IThHZKgOu2CI5lLaW4+dohujcbudp1VuPGinJk5/sjg=;
        b=codylYm8MedO9Occ7jB3Mjy0dDxxbl7AUT+Wx8/Z63tH0irkodCwvfwImh+TM6udVD
         R5E9S+KkKprHHa8B6hG+PEWitWIYATWVRPDw/MFdCPqTHhgMsjEXqR7gE1qdClfzRhRf
         deAk6ZyFBU2Od6jnjzm2gTywkN9qPpd6GnGZ0uibfw6Jaf8FOL3jLctVRlVGNs0QByO5
         c84JIr2j6gkwhclAvSB4SduZXJsJDxWDkGJyjfr9BZBkqMr4xGNqQGxJrZngUES04KRN
         jFBOEXPtTRjdS0yKTWDAVMnJzpLvdUatIiQJUBqgsnK/tMBk3IZPc3KpDAqyBPtlD6/M
         UTCg==
X-Gm-Message-State: ABy/qLZUYgkyU7lh/ZpDMJ6dO5yQLQehpqtCFkWVSr0BAiF9CfjxJLwS
	ZsImVASDy5T2MIAupZt788M9CgBGqNkxyd2JVA8DDSOqmzk6y+MvJbY=
X-Google-Smtp-Source: APBJJlF68pzIjDwAzPGMKcrhOEyk9TWf/oRIMQEj1J4deHdSxGb7fnpo7ceaea8lfJeFMZmiLVLVP2G2Gj0o1TJx2JU=
X-Received: by 2002:a05:6402:10cb:b0:521:7ab6:b95d with SMTP id
 p11-20020a05640210cb00b005217ab6b95dmr11439677edu.29.1690296051014; Tue, 25
 Jul 2023 07:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
 <9a5c27e4-a1a3-1fe5-a179-bfd0072e7c59@web.de>
In-Reply-To: <9a5c27e4-a1a3-1fe5-a179-bfd0072e7c59@web.de>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 25 Jul 2023 09:40:39 -0500
Message-ID: <CAO3-PbokoLz8S8YhV_nNjq+Oq3P_SXqbj-TNJmrC56DV8KLb7Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-team@cloudflare.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	LKML <linux-kernel@vger.kernel.org>, Jordan Griege <jgriege@cloudflare.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 12:11=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >                                      =E2=80=A6 unexpected problems. Thi=
s change
> > converts the positive status code to proper error code.
>
> Please choose a corresponding imperative change suggestion.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94
>
>
> Did you provide sufficient justification for a possible addition of the t=
ag =E2=80=9CFixes=E2=80=9D?
>
>
> =E2=80=A6
> > v2: code style change suggested by Stanislav Fomichev
> > ---
> >  net/core/filter.c | 12 +++++++++++-
> =E2=80=A6
>
> How do you think about to replace this marker by a line break?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n711
>
> Regards,
> Markus

Hi Markus,

   Thanks for the suggestions, those are what I could use more help with.
   Will address these in the next version.

Yan

