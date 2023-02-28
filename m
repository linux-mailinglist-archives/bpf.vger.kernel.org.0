Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F36A6268
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 23:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1WaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 17:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1WaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 17:30:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC02ED41
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:30:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so46515618edb.1
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677623421;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YOeIWJY+ughPJT+Ebx4sFI1EXmtyMRK/yLYV469Zah4=;
        b=i9/70pTcHbCULrgk1i1pMT4he5eLS9educ5wqah1IpJLDVWuOlF/A7SQhzFTZEkrw3
         yJVvOmOXzPshVYrcRAfLB50e63yOHtaGKDvxd/BdKMXXnX2xpX/tE652eqcgvgOyQxRp
         NDGEGAngTCKPY651z8XqVpaR+LRL7qQYIODkhjpH3p/GJ7cmh5bsxMtA4kQjZThVEvCf
         KYBU+R9RRAorDJ6zHVGNoeQ7+60cFuzI2QBJZQoo9gMqUTdbneVVMyLd+V5sRsI2YmPd
         A2eCwzhCMl2N0d051329gXddSD1/jPe15UCVYN5udWQbQXzh3EEpuy30N0a6ixe6A7YJ
         CGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677623421;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOeIWJY+ughPJT+Ebx4sFI1EXmtyMRK/yLYV469Zah4=;
        b=SQXS0CleGaANqM7uDveqyLzaowfWuxtJBjyMeTS12vy2hZVzndFsofcGfPQzwE0wqK
         u9kAzl6v94DNG0poHCXWw+2UGz9lxTr/dRSALVxix4lTPKrKmLT57KQcFqMyeghQOaDp
         y7+wDlcwJ9RRjHIxXOa9pa1YC7m6nCuDaxvfaTVwgFmPwCF0bdkxzP8Y5gXTexyrmSq6
         UTPrFgpag4Hyoj2HHxjmUoB5qlvn5zH5x+TrjaB9ddmaDgTIvv3hZEI04n6w1KttaNcl
         Yz0ikI6UoU1SIHCFFKJVNynczN2PVZ4swOQoE5rnTPUK3+3i/pySlmZHZ/BxIUUlRmHg
         W0fg==
X-Gm-Message-State: AO0yUKVRpKL6P3gSH8uTYO+dYRnME9AhSWvqf7tbn5hbvtsquP0ohnJz
        QCa4v2Gj8AtZhhUBYBfG/yU=
X-Google-Smtp-Source: AK7set/IeatAbVvZs4f/m3srM0bI82US21whIL6TrzWOE/UAbRlNCKfiuBEBqjFu9p35PP6xmc/omg==
X-Received: by 2002:a17:907:988c:b0:8f8:1501:be60 with SMTP id ja12-20020a170907988c00b008f81501be60mr3916666ejc.7.1677623421511;
        Tue, 28 Feb 2023 14:30:21 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v24-20020a170906339800b008cce6c5da29sm5004812eja.70.2023.02.28.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:30:21 -0800 (PST)
Message-ID: <06e29b322d777c30fe9b163f9d13f11503a303d9.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/5] selftests/bpf: support custom per-test flags
 and multiple expected messages
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Wed, 01 Mar 2023 00:30:19 +0200
In-Reply-To: <CAEf4BzZ-9iHzotYj2K3a+USFsxmqLEA+pHm4Ot6Nr2WtZ-AHeA@mail.gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
         <20230123145148.2791939-2-eddyz87@gmail.com>
         <CAEf4BzZ-9iHzotYj2K3a+USFsxmqLEA+pHm4Ot6Nr2WtZ-AHeA@mail.gmail.com>
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

On Tue, 2023-02-28 at 10:53 -0800, Andrii Nakryiko wrote:
> On Mon, Jan 23, 2023 at 6:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > From: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > Extend __flag attribute by allowing to specify one of the following:
> >  * BPF_F_STRICT_ALIGNMENT
> >  * BPF_F_ANY_ALIGNMENT
> >  * BPF_F_TEST_RND_HI32
> >  * BPF_F_TEST_STATE_FREQ
> >  * BPF_F_SLEEPABLE
> >  * BPF_F_XDP_HAS_FRAGS
> >  * Some numeric value
> >=20
> > Extend __msg attribute by allowing to specify multiple exepcted message=
s.
> > All messages are expected to be present in the verifier log in the
> > order of application.
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > [ Eduard: added commit message, formatting ]
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> hey Eduard,
>=20
> When you get a chance, can you please send this patch separately from
> the rest of the test_verifier rework patch set (it probably makes
> sense to also add #define __flags in this patch as well, given you are
> parsing its definition in this patch).
>=20
> This would great help me with my work that uses all this
> assembly-level test facilities. Thanks!

Hi Andrii,

Rebase didn't change anything in the patch, I added __flags macro,
some some comments, and started the CI job: [1].

Feels weird to post it, tbh, because it's 100% your code w/o added
value from my side.

Thanks,
Eduard

[1] https://github.com/kernel-patches/bpf/pull/4688
>=20
>=20
>=20
> >  tools/testing/selftests/bpf/test_loader.c | 69 ++++++++++++++++++++---
> >  tools/testing/selftests/bpf/test_progs.h  |  1 +
> >  2 files changed, 61 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/=
selftests/bpf/test_loader.c
> > index 679efb3aa785..bf41390157bf 100644
> > --- a/tools/testing/selftests/bpf/test_loader.c
> > +++ b/tools/testing/selftests/bpf/test_loader.c
> > @@ -13,12 +13,15 @@
> >  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> >  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
> >  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> > +#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
> >=20
>=20
> [...]

