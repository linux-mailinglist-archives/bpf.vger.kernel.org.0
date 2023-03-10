Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59D6B34D4
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 04:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCJD04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 22:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCJD0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 22:26:52 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5AF9D3F
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 19:26:49 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 76so1543999iou.9
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 19:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678418809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXceP9AsMjvivVzcPWyt1cCB9rlFzG2cR5zq3gKp8kg=;
        b=QbqXgGD2gYCpt+l8sIVRhRlvqBcrj5iQuWzhZGHSgoxO+OlxFB+iSj3SmvEtVfUI7K
         hWHOOhMQ/cZTrZD17imIDty7WniaxSDwCYKg0dAWDP629YBh1aefNAjRNcWHqPA8JXL8
         B9c1H3APzBtCnVwNxKJNBeBYRgEWjgIfaDPBBNNNgwtLIDz6bIUAXgMy/ifBMEhFDBSo
         6a0P+8SAHqLjJy6yxGIrFvhiD+qoq4WzpLZEdwGwrnyMmnhMN9I6YZAbOKY8vE2p9cDR
         /wnPtgi3w1Vsq5NUaRclRtn8SZWv+TZAw+k0TaFzLuJnM412bFpIGng+ODZRq6OOLK5/
         GQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678418809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXceP9AsMjvivVzcPWyt1cCB9rlFzG2cR5zq3gKp8kg=;
        b=oAWzfXixYWWCkp5SLVa4Y7dGsu68eb0SQrGdzZq/XvDRt7+M/kmhy02WenIiXMXNGD
         QxsiE3Q9svOCBRJ751GAXepqqF8i4s3THiqjnSxpJbgijJl3Ku6Knxmd9jDuH86n44pV
         0IXF4VJ0emrdlZ7Si1udl2BCXxHS9eXUTrLKwCfeMmQc+8HYqK/SQ5Og+AOQpMeihSHM
         DD1nZjVPm1mLwNgiN9aPtYFLy6Ys50K3plBTicZtcVSAPqRuyexKaQZysuHy4WkTkCO/
         +6c1ekbjPq6Y/Xe91L9hW9WVvdtC/H1ZorR+hfig4AKZpFnw4Oiv1BeTi3zXmq+FM2pV
         bCmw==
X-Gm-Message-State: AO0yUKVsaFTG/ueOtPuGDyUlFQ/dkAaMgeUgRQKUVrNWO2y5N/gQ6N2Z
        ApVD+BcWa0hCOTTNmJyaoLN64eMtIIUP6syStIsftw==
X-Google-Smtp-Source: AK7set9LTtI/PpGuBD2uqj0AoseCwQoLA/055RWxCBWhT1XMwNyc5d9vjAfhpp7M3ioVa9HBEC0v2CDu1a8mQOPw2y4=
X-Received: by 2002:a5e:9413:0:b0:745:a722:4a15 with SMTP id
 q19-20020a5e9413000000b00745a7224a15mr11061449ioj.2.1678418808743; Thu, 09
 Mar 2023 19:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com> <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org> <Y8myfqy5EMit3Kr/@krava> <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
 <ZAmRjk1x4p4TrFb0@gentoo.org> <CAEf4BzZJvEnWdTKVSgdBDr_KEgkW5HLHc7N-HRkmb-drCbg2uw@mail.gmail.com>
In-Reply-To: <CAEf4BzZJvEnWdTKVSgdBDr_KEgkW5HLHc7N-HRkmb-drCbg2uw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 9 Mar 2023 19:26:35 -0800
Message-ID: <CAP-5=fWvMFXOaKA0bKaKdzYjqOxTCXGapJy-4x34hJyZxqD-Dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Guilherme Amadio <amadio@gentoo.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 9, 2023 at 9:25=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 8, 2023 at 11:58=E2=80=AFPM Guilherme Amadio <amadio@gentoo.o=
rg> wrote:
> >
> > On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> > > On Thu, Jan 19, 2023 at 1:13=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com>=
 wrote:
> > > > > > > libbpf 1.0 was a major change in API. Perf has partially supp=
orted
> > > > > > > older libbpf's but an implementation may be:
> > > > > > > ..
> > > > > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > > > > >        return -ENOTSUP;
> > > > > > > ..
> > > > > > >
> > > > > > > Rather than build a binary that would fail at runtime it is
> > > > > > > preferrential just to build libbpf statically and link agains=
t
> > > > > > > that. The static version is in the kernel tools tree and newe=
r than
> > > > > > > 1.0.
> > > > > > >
> > > > > > > These patches change the libbpf test to only pass when at lea=
st
> > > > > > > version 1.0 is installed, then remove the conditional build a=
nd
> > > > > > > feature logic.
> > > > > > >
> > > > > > > The issue is discussed here:
> > > > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@=
google.com/
> > > > > > > perf bpf:
> > > > > > >
> > > > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_=
DYNAMIC=3D1"
> > > > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > > > This change goes further in removing logic that is now no lon=
ger
> > > > > > > necessary.
> > > > > > >
> > > > > > > v2. Rebase now that breakage fix patch is in linus/master.
> > > > > >
> > > > > > I missed the:
> > > > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > I believe we are waiting for package maintainer input.
> > > > >
> > > > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> > > >
> > > > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to=
 move
> > > > f37 to 1.x, but I had to do bulk update of like 10 other dependent =
packages
> > > > for f38, so not sure how bad it'd be for f37
> > > >
> > > > jirka
> > >
> > > +Guilherme
> > >
> > > We were looking for maintainer input on these changes, but there is n=
o
> > > update in over a month. Here is the original lore link:
> > > https://lore.kernel.org/lkml/CAP-5=3DfVUgc8xtBzGi66YRUxZHyXvW2kiMjGz3=
9dywaLxrO4Hpg@mail.gmail.com/
> > > Should these changes land in perf-tools-next targeting Linux 6.4?
> >
> > Gentoo has libbpf-1.1 already available, so requiring >libbpf-1.0 is no=
t
> > a problem. We (Gentoo) just need to make sure to stabilize libbpf-1.x b=
efore
> > stabilizing newer versions of perf, as the stable libbpf is 0.8.1 at th=
e moment.
> >
>
> libbpf v0.8 is basically all the 1.0 APIs, except by default 1.0
> semantics is not enforced, unless libbpf_set_strict_mode() is enabled.
>
> So, if 0.8 is a restriction, perf can stay on 0.8, use all the same
> APIs that are in 1.0 (except newer one added later, but I'm not sure
> perf needs any of the newer additions), and just stick to setting
> libbpf_set_strict_mode() unconditionally.

Thanks Andrii,

The default perf build is to build against tools/lib/bpf and
statically link libbpf in. This means by default we have the latest
libbpf 1.2. If any perf code has a dependency on 0.8 (we don't support
earlier) we need to #ifdef for it. Currently we have 7 feature tests
for libbpf, but perhaps there is some cruft that's carried forward.
The features are:
 - btf__load_from_kernel_by_id
 - bpf_prog_load
 - bpf_object__next_program
 - bpf_object__next_map
 - bpf_program__set_insns
 - btf__raw_data
 - bpf_map_create

The not present implementations look like:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/bpf-loader.c?h=3Dperf-tools#n36
```
int bpf_program__set_insns(struct bpf_program *prog __maybe_unused,
  struct bpf_insn *new_insns __maybe_unused, size_t new_insn_cnt __maybe_un=
used)
{
pr_err("%s: not support, update libbpf\n", __func__);
return -ENOTSUP;
}

int libbpf_register_prog_handler(const char *sec __maybe_unused,
                                 enum bpf_prog_type prog_type __maybe_unuse=
d,
                                 enum bpf_attach_type exp_attach_type
__maybe_unused,
                                 const struct libbpf_prog_handler_opts
*opts __maybe_unused)
{
pr_err("%s: not support, update libbpf\n", __func__);
return -ENOTSUP;
}
```
This will basically mean that while you dynamically linked with libbpf
0.8 you are in all likelihood not going to get proper BPF support.
These changes up the version requirement to 1.0 and get rid entirely
of the feature tests - so no runtime failing implementations. If the
build determines at build time libbpf 1.0+ isn't present then it still
executes, switching from dynamic libbpf to the default static libbpf
that is at 1.2. As mentioned in this thread, distributions like Debian
use the default static linking of libbpf.

I'm not keen to hold on to the feature tests for the complexity that
they hold and their needlessly (as you can always statically link)
broken at runtime behavior. We could but my opinion is, let's not :-)

Thanks,
Ian

> > Best regards,
> > -Guilherme
> >
