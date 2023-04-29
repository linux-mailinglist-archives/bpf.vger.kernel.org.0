Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02686F2237
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347330AbjD2B6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 21:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjD2B6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 21:58:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD03A8F
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 18:57:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a68d61579bso4794125ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682733479; x=1685325479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwYEXU7Lp9XroufPN43xvmiTz9v2gxPHNeujBe94GAs=;
        b=RXfyW4VFENC5ciM0BkQroL4aTdKXdDxKRQP+lXVasRmQpe5AI9ZHyvuHYeeGYk3Qb3
         5eGB9m1chP/gFDsK+Kq3oCrQGusaWdv4ohH1vJ1AauBiusk9QlXKDJxIcIXL/ysUJiuo
         TJ8ryIERQ67DdKzkaBWura/eB3J3OP4gWII1O8nQCqHtILnjZkE20TC7iYsmfyoi2YcD
         NVYLjMQk/hAcc+H6PB0dtfjya3cxCRCqtERmwcSfhVVfyFnWklGRnJI6OQH/9Y6bZpbv
         0B8iJM+g4s5BoqriWl9kxk+QO331R/fFPpG6dylVLVil6y68Q6dXek410s1b5hZSql8w
         pDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682733479; x=1685325479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwYEXU7Lp9XroufPN43xvmiTz9v2gxPHNeujBe94GAs=;
        b=Hw1MoQNq/Eqphm4/TWTjTIO8MuUFKD1wc5cG1Lu9ssaf3Qs+c1hnPYv8qc7B727u/Z
         qR7OO1hi2L7aBwjemEqkgGB9YOWAoYzachqDzREv3HAsHdaGINaW+7iXQrNS7c+1JdZX
         /lQYXRU6qLHQuGBLofjBZJ4WXEOTwoqULLQJRbgXgKKWJZstnV//hwTd808N/7xcleOH
         g/ikY2znIIu2av0etNwjXRm2JKh3lEP3iXaqaY0wXAutcqh9qLxARcPBeKUvh9dfXPtd
         NubIiwAkDtdiNfP99Oy5UAJbxBFWtJShfw9uD7rNFYlb9/1qZOBaRQqTsbT2vwMps86n
         G1uA==
X-Gm-Message-State: AC+VfDw3CIPTlH9MtWYsNMwvGP33H/Y0W3ho0W0Ptm1EpAZGYIKugRQg
        hWDWfAWdeIW1G15gwIyuc6REBmLbsNiuetAJR8i9k9LwmjpGJVdKMfu/xIBa
X-Google-Smtp-Source: ACHHUZ6hnf26OkmiqUDWsr7DSiuPNV/BdRgyZpdsz5lR+uhorY4Vu4itliEAmdMKDWjt/ddvAknB/Tx9C46kEc/0Fy8=
X-Received: by 2002:a17:902:f78a:b0:1a9:b62f:9338 with SMTP id
 q10-20020a170902f78a00b001a9b62f9338mr6290325pln.45.1682733479236; Fri, 28
 Apr 2023 18:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-3-drosen@google.com>
 <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
In-Reply-To: <CAEf4BzakRfffU9+wLBNfhBi1dKxs03ibopJsMyEF6JAM-QJWjw@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 28 Apr 2023 18:57:48 -0700
Message-ID: <CA+PiJmQJ8m_W_SF3GPe9pqnwJX0gbkWuuOz-WXHWcA7JExgMyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

On Thu, Apr 6, 2023 at 2:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> would this work correctly if someone passes a non-null buffer with too
> small size? Can you please add a test for this use case.
>
Working on a test case for this, but the test case I wrote fails
without my patches.
I'm just declaring a buffer of size 9 on the stack, and then passing
in bpf_dynptr_slice that buffer, and size 10. That's passing the
verifier just fine. In fact, it loads successfully up to size 16. I'm
guessing that's adjusting for alignment? Still feels very strange. Is
that expected behavior?
