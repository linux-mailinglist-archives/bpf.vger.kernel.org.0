Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96A6EB2BA
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjDUUBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 16:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjDUUA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 16:00:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE62717
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:00:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so7263365e9.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682107254; x=1684699254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZoeUkOHhpsfdK8AtYewcZbj21Xgte6VgjQ3yPQ1QiOE=;
        b=mD8qK2kU9EiXwmOU5l16MYLaSSW6iDRyGXB1fWuzxD1nao3TD6Ugh/9Jey7VXiBfAt
         OVMBgO0kBsW7tO2ZC2v+2WJFD/Ygo3K+WwyL2IMRFX95WOR7hOnAE7x4igXxe2TPvg3E
         lHRRdjLvDCF72128WuR5BCcUqVH/idLN4aEj1P8DdWdm9AV7ctV7vTfqjQlzWoddpJp0
         yrROiGVhpvQHr/8Idec3aAS3CpwfUB+XJbrn4mLUbt568KKRk+nF4n/oXB9peGDdf1DK
         j5QiqlOXFSck/jJfsa50Je9Ob39gdFaMVjkJDjXGYCNQP0xX+eLFCyPbqEIfBeGTvkNe
         Z16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107254; x=1684699254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoeUkOHhpsfdK8AtYewcZbj21Xgte6VgjQ3yPQ1QiOE=;
        b=FZViXJRMyvWT2jdEBfWmwGISf338LMz/H+Q1VGripbbAnMoONsTUMrBnW1DUqTfvzg
         GdcDX0d3meOCN/agjhLfs37RmgyGLLPTsAWnfyIk3the9B6ASixLFSEx9rukEBNYc6Sy
         IQ4CKDxXhW7VVfOKQ1tt9cSoKcg2zGYnFFMyeLxov2OeqJkiUFUh+G45WiGYt/2cy0zs
         z3bGEUedsRAt4J/jzCZRYgq7krfNCYMmIsL/v5y6qLjKfWheQtCsw/NwqGFyO2FCwT4g
         mW2jBTukeUNtOgwpvzxm7RiHR2lM2xuTqFKTi6kNTMpqVYWm3/AtrQ8WQr8LXjgTg6HW
         amgg==
X-Gm-Message-State: AAQBX9d5uqwF9vKSLS7T87Z7tkXZlDKOV/U40yeE97/846hHdDafhc4f
        CEH7D2YDHmsUCecGr4Zq7r4=
X-Google-Smtp-Source: AKy350bE7Iydoe3fV5aNzVCB+WjRoT+69SIC8RSCJTv980ijEDLEotb31I3UFEW1q8C2Cuak+okuzw==
X-Received: by 2002:a7b:c8c1:0:b0:3f1:6cdf:93ac with SMTP id f1-20020a7bc8c1000000b003f16cdf93acmr2687081wml.17.1682107254336;
        Fri, 21 Apr 2023 13:00:54 -0700 (PDT)
Received: from [192.168.1.95] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc009000000b003ede3e54ed7sm5664328wmb.6.2023.04.21.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:00:54 -0700 (PDT)
Message-ID: <f25edb347a0142debbd0cb5a225a169cda320c91.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date:   Fri, 21 Apr 2023 23:00:52 +0300
In-Reply-To: <CAADnVQKQOX6H5W0RB1wyTAMzqMabWJp9M+pi82_BYdHWQNx3AQ@mail.gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
         <CAADnVQKQOX6H5W0RB1wyTAMzqMabWJp9M+pi82_BYdHWQNx3AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-04-21 at 12:48 -0700, Alexei Starovoitov wrote:
> On Fri, Apr 21, 2023 at 10:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > This is a follow up for RFC [1]. It migrates a second batch of 23
> > verifier/*.c tests to inline assembly and use of ./test_progs for
> > actual execution. Link to the first batch is [2].
> >=20
> > The migration is done by a python script (see [3]) with minimal manual
> > adjustments.
>=20
> All makes sense to me.
> Took 22 out of 24 patches.
> The 13 and 14 had conflicts.
> Also there is a precision fix in bpf tree.
> So we're going to wait for bpf/bpf-next to converge during
> the merge window next week, then add another precision test as asm
> and then regenerate conversion of the precision tests.
> Not sure why 14 was conflicting.

Oh, understood, thank you.
The #14 does not apply because it also starts from 'p',
so the hunk below does not match:

--- tools/testing/selftests/bpf/prog_tests/verifier.c
+++ tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -41,6 +41,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_precise.skel.h"
+#include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"

I will resend it shortly.
