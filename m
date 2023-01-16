Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282966D210
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjAPWxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjAPWxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:53:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCC32685C;
        Mon, 16 Jan 2023 14:53:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx13so12917660ejb.13;
        Mon, 16 Jan 2023 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=USWxWFA5v5RQ4g1w5jR/fk1KNbzmnZEodvDSAMOXB6k=;
        b=Qb2K25jq7TjzdjPoE45+9PpWEFdxqtknTJ+dBxc5pQDklQF1KLGezYs4BsfXwjyUTV
         +HzuBHNziCQjipYRUfyIWUTkPvMqWz+OsRVrmNkGJPO8wok6y3kvPWcmLKmyx0r+S8hX
         5zAZRcaZYvx0VhxKrg7HamovnitHMcNJ1g/TSpsN0M05wgXHqud/Tq+ERPvcUsUB1bD+
         Mok0a8jOs9aylRNICEaSt4le+5/DuAIr2f5g3VYk4wYlfnR3Xil5vD+ercvMtqQ+rCdY
         l6YGNdTo1DmXyw+jdyOvDAYvnMYh+NvAEk730ca3lerPQekM8s3/Z0maOc0cysCv3Xfr
         qppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USWxWFA5v5RQ4g1w5jR/fk1KNbzmnZEodvDSAMOXB6k=;
        b=jVnsM7t5fq8HnjJBphO3DGxl9pJgrS8X+qwA6u2zmYJxfJjHfNrpfXaUSiKWQmt2vT
         tBTIZJze0xx/cmRjGP+PFVSQGGv7Quy85JAfxLa9od8cHvO9aFR4123zPelolj7dJXGq
         uBCKVCO6Be84PEdSnh81ZX2FQf3oa7xpXuWLyA5C96y+gsIRR+aeB190RlaZsVrIFZd8
         naWsQjvhZ9ff2lqvuo2SX5dAhMXcb0OXZE7kK8VWO8cv7xP7fX2T2IMUJZrzkaI6ye0b
         cCnsLR/gfgbzkep/ZMbWHNPJeR98zoCjqhdYizQJOM/xNGDZB4FRUhjqO3uGqO3/C4Ix
         E42A==
X-Gm-Message-State: AFqh2koL9guCkO6/bLmN/kgNG+g+4alrWsmGARDM73UwiWFvsn3noDBC
        Y5ygQtrVTy0tYlGsH9CsuGw=
X-Google-Smtp-Source: AMrXdXsrxKuyx8GSa5FEU6+25Vl8kCkbrM1Z1NApYTd+DqFQnBlP0WjMLK6l8JQLcYQmj+K6AvY3yw==
X-Received: by 2002:a17:906:a146:b0:86b:1ccc:d42f with SMTP id bu6-20020a170906a14600b0086b1cccd42fmr584511ejb.61.1673909603251;
        Mon, 16 Jan 2023 14:53:23 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090631c100b007aea1dc1840sm12322454ejf.111.2023.01.16.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:53:22 -0800 (PST)
Message-ID: <fa3c22057e798f0a2946661ac73dc4c2f923d317.camel@gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Tue, 17 Jan 2023 00:53:21 +0200
In-Reply-To: <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
         <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
         <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
         <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 14:49 -0800, Peter Foley wrote:
> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > A bit tangential, but since BPF LLVM backend does not support the
> > stack protector (should it?) there is also an option to adjust LLVM
> > to avoid this instrumentation, WDYT?
> >=20
>=20
> That would probably be worth doing, yes.

Ok, thanks for the input, I'll see what can be done.

> But given that won't help already released versions of clang, it
> should probably happen in addition to this patch.

Yes, of-course.
