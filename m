Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F46A7270
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAR6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAR6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 12:58:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3335A0
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 09:58:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d30so57323556eda.4
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677693517;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjJaW16l80Nxbn+qz34LIyoP2QZxNe58YVPiMeUpd9Y=;
        b=FnWx6QvLNI8oYnLLSLq7TGoV3ulLmfO5ZhnlZPUqYT4a5U7RRbx+LJIYk34DG9mDdN
         l0cQlt/Rzubn0YHljWo9NFeZeEZXgZ4TZ0RK3RSOEvS+E9omdGjEckwqXUkWySiCrD6c
         VVldJckxh6MRU8gx5lBr877eAiSPWs5QWoCLJIGh+sxDUEbZLTIw0rvmsIC1bXW+uIyK
         ud89LTSesIo5Bub+2ZdbxYyVp8IlaANZUK7rXl9+d6ZxCIkQVPw6fSPc22l3XosxDoiI
         mgKqmWZJ/1fOwy4BOMOmCXrYRFI7o5X+H8vuUb1tQikaX1hcPrI/o3NN/kvKkqTwJxsE
         zd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693517;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjJaW16l80Nxbn+qz34LIyoP2QZxNe58YVPiMeUpd9Y=;
        b=M5ELkK84br5VsJn9UrMtfTa8hV2A93E/hp2IN+elDOamuk4M0aA8nbInhdsUTWvdRQ
         Zp9zLg3WI+zNzhwu77Bj1+VALfc2J+miSzlNEmvm/vtfaXy5QBEj/raCjB3j1AdnPIcG
         KVXzlL7JHmJcf2GWhegN65QgaR0fhMxzxnd01D5Q9+NQV+dSttefZ9OxV0P7wRBFDBb3
         +JdTj9ecUfJm/K5Tc9d3ybTU+G70Ab/NnV0Es9lKoE8Ecyi8RE16o23MfyQJaSpCYeeU
         PBqSxk7+eT8zQMCRqhEpVWVhEyr1WROX3/ujuvVN135SL7VBxY7iYsmLXEc7GKyFeCPL
         nd2Q==
X-Gm-Message-State: AO0yUKUNULyjhosTGhgfxM2C1bjjmm+pjGjZjIj0sQ0oLbCkQ4XjhLwY
        iCIAQ84kr8V1+9SG13q6uL/HKFoshcJLLw==
X-Google-Smtp-Source: AK7set/K3sLZ/v9L2IHeH9gidPuCp/RCoNYmAPo8xC8/8NgGDL7nttIGWXQwLcD9WG9VlA1HESMmOQ==
X-Received: by 2002:a17:906:b110:b0:8b1:77bf:5b9f with SMTP id u16-20020a170906b11000b008b177bf5b9fmr7250290ejy.13.1677693517013;
        Wed, 01 Mar 2023 09:58:37 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id qk25-20020a170906d9d900b008b23e619960sm6097877ejb.139.2023.03.01.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:58:36 -0800 (PST)
Message-ID: <cb45b6f9dea106c80c70396c48a74577d823541a.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/5] selftests/bpf: support custom per-test flags
 and multiple expected messages
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Wed, 01 Mar 2023 19:58:35 +0200
In-Reply-To: <CAEf4BzbiA48Q5ODREyHXKKKO7oms_LnE6q77=T9sroZkCefVgQ@mail.gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
         <20230123145148.2791939-2-eddyz87@gmail.com>
         <CAEf4BzZ-9iHzotYj2K3a+USFsxmqLEA+pHm4Ot6Nr2WtZ-AHeA@mail.gmail.com>
         <06e29b322d777c30fe9b163f9d13f11503a303d9.camel@gmail.com>
         <CAEf4BzbiA48Q5ODREyHXKKKO7oms_LnE6q77=T9sroZkCefVgQ@mail.gmail.com>
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

On Wed, 2023-03-01 at 09:12 -0800, Andrii Nakryiko wrote:
[...]
> > Rebase didn't change anything in the patch, I added __flags macro,
> > some some comments, and started the CI job: [1].
> >=20
> > Feels weird to post it, tbh, because it's 100% your code w/o added
> > value from my side.
>=20
> you took the effort to prepare it for submission, testing, and
> integrating into your work, so feels well deserved
>=20
>=20
> >=20
> > Thanks,
> > Eduard
> >=20
> > [1] https://github.com/kernel-patches/bpf/pull/4688
>=20
> apart from test flakiness, looks good, please send a patch "officially"

Done.
Local test run does not show any issues.

>=20
> > >=20
> > >=20
> > >=20
> > > >  tools/testing/selftests/bpf/test_loader.c | 69 +++++++++++++++++++=
+---
> > > >  tools/testing/selftests/bpf/test_progs.h  |  1 +
> > > >  2 files changed, 61 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/test=
ing/selftests/bpf/test_loader.c
> > > > index 679efb3aa785..bf41390157bf 100644
> > > > --- a/tools/testing/selftests/bpf/test_loader.c
> > > > +++ b/tools/testing/selftests/bpf/test_loader.c
> > > > @@ -13,12 +13,15 @@
> > > >  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> > > >  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
> > > >  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> > > > +#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
> > > >=20
> > >=20
> > > [...]
> >=20

