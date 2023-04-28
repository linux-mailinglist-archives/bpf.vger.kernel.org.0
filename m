Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD626F0FC8
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 02:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbjD1As0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbjD1AsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 20:48:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB672711
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:48:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24762b39b0dso6581083a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642903; x=1685234903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYJ9Gq0jRLdthT3KT6+pUq4WeVXKnPD2vRhwxoOwfLM=;
        b=VAXP1WEMBqFyWeIoabfqwWglRbZ4HdOWER+eOB5RWEer/jpI0svg/f4iWi3c8Cg+Pt
         by2DSZbfQZ5DKECFJtxEVAvZP00YYuj8SzpYP5frO7HeB/evzIiSXJiYt3uP1AgW6Z/o
         t4C/VnCsfpRqyoXAvRlPeT9bKt0XI3Ilupw3Lpt0+ypUfNvaXw70RtwacEi3QW5bC93A
         LD8UutIlcg+pO1Nr1Edae+tN1Cff+2S7B+/D+zIIHdM0zzUfcdgfJeIwzJVmI36PVyU/
         HkzP2LpUvgBQhHOexE8LxayxI4ASWaOUCXe+UEfkHJxLKREaLYRvtUXxfqKXe00TIYH9
         TjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642903; x=1685234903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYJ9Gq0jRLdthT3KT6+pUq4WeVXKnPD2vRhwxoOwfLM=;
        b=cNyMuj/yqEd5KbwHIo6hzt71ejhU1/7HlYxfctx20NjhCpEkrVDSXInm7RCEWoIw7S
         VSqzuDSItJMaTF1FEul7E+JuG4Uzq7UoLb6j3jlBTI+W5OJRe566Cyly7sqOQg6Me0yk
         0GH9c+hJOgvBovWkIwQ7KD/wj9OpS/0XzrGobyLOZ8yD5GKCNANIaD6Cvsb2Z/yyhdCU
         qxaRKf5B1a/Hib5FHST3eOC++vpAjiuGUO2DhY2n+B5zdTtqYV0ffwswDPsCV1dWNCqq
         ZgH9mrxzoLO+z75x0WgR59D7HQRTcKTerVJmjSxaUv/0AJTuz5cOq74ccjFxlXyYglYZ
         mZrQ==
X-Gm-Message-State: AC+VfDwfBfEe0KYSsZd87FjUwQti7zFkPuRsUCc/8Vl4OTndclbJWmLt
        hywxARhliFL7VEIob2nj/nNeIyP9XR9vOAv/T87IUA==
X-Google-Smtp-Source: ACHHUZ5+QBvCC7Me3S+WJPhYrRFCfX62qwqHhmjQ8Bf88BjxgWf2Db/JCe7VvvvRDD68Vv7dGvnWJGtUagXHQXv5kDQ=
X-Received: by 2002:a17:90a:fc82:b0:247:25d6:b849 with SMTP id
 ci2-20020a17090afc8200b0024725d6b849mr3639718pjb.8.1682642903149; Thu, 27 Apr
 2023 17:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-36-drosen@google.com>
 <CAEf4BzYD9P+1aP+q77i7RJPJW=iSS6-iTw+rfPuCz=FFB2MiZw@mail.gmail.com>
In-Reply-To: <CAEf4BzYD9P+1aP+q77i7RJPJW=iSS6-iTw+rfPuCz=FFB2MiZw@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 27 Apr 2023 17:48:11 -0700
Message-ID: <CA+PiJmQ6_P7WcgKHaFrpb8hyWA549+JMB0Wa25-m0G2FLfw+gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 35/37] tools: Add FUSE, update bpf includes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 9:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 6:42=E2=80=AFPM Daniel Rosenberg <drosen@google.c=
om> wrote:
> >
> > +/* Return Codes for Fuse BPF struct_op programs */
> > +#define BPF_FUSE_CONTINUE              0
> > +#define BPF_FUSE_USER                  1
> > +#define BPF_FUSE_USER_PREFILTER                2
> > +#define BPF_FUSE_POSTFILTER            3
> > +#define BPF_FUSE_USER_POSTFILTER       4
>
> nit: can this be an enum instead? It would be more self-documenting,
> IMO. At given it's FUSE BPF-specific, why is it not in
> uapi/linux/fuse.h?
>

An enum would be nicer. And I'm sure there are plenty of things that
are probably in the wrong place right now. I'll be moving most of the
changes in bpf specific areas over to fuse specific areas when
struct_ops can handle modules. This particular one can move now
though.
