Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB164CDF9
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 17:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiLNQ2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 11:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiLNQ2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 11:28:14 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B963CD
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:28:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a19so7174419ljk.0
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t5N4IGKMjJxlWZiZZvOkjVIAJnSXFecRTmvlK4ztbDY=;
        b=Ml0u3hvHObfAEL9dFZClRxq/4RdqQeEY+aCDo0/ijWyCNMW+Vgi2LZCeNDue2KHscx
         VQLHsxUAcG5CZWY0zSShoCu7KI93BqjFkW3K5alePluNStjw2MgA3zGwNwcjd+8d236K
         bqrFiHCWZG+FvcRUmrmyf7VC1+suwvqpR8PrbsgF/KCS4y4pRwa5szOXKYt/wsCBy7mE
         hiWEn4Z/fsg1IT23ykR7PR+h/4H8LfUv/HZFt/qQAYkzXE7k6FTX6T2VxBlaqLc4G20s
         JDlKW6H4bcb6W0izRY6+k2x2bQoMCO8E2Y0FCb90BygMebHJI9R8ZEx82lhFrxSzz7Zn
         1Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5N4IGKMjJxlWZiZZvOkjVIAJnSXFecRTmvlK4ztbDY=;
        b=tyrOdOjVSQmis30qEZqDcupdL1uEhFystz3TojqnqpxLNi25Ad+wRqdVo0JCt8N5Ht
         k5jrU47ljB8LNWiddo5WXdBFhrBGILo0ahvit2KnnHaKRZigrhRqCq69oYekIgO2q9Tn
         ot0D0D1AOwHRi/A0sZre/r4eIr+7YdC9T5ZXm0pN0RsRcD7H6AXWtY34DEL9MF6bwcwv
         j7ZfDbjebT8/20xeWDW1ZEolOPUG4f0JcZHI8E5Dayshk/t3RCY0vXiT1j3XFao347Qg
         ncdP0IW3d154P93lRsBVhhd9D/A3BDJlmo5QkThaTAyHbfzdkBLsmhmqWCL+E0q2pJmW
         neAg==
X-Gm-Message-State: ANoB5pk7XQjP8NC786oTKSR+/axvUKB9vl5F7NDGrt7V16C4tKMl7n5u
        YpFn6ZZru6xtr7PcrYf2T1A=
X-Google-Smtp-Source: AA0mqf5XByl6Hylr96+mo2QL7pIqxvFRcsNEJmk6cJW1eQxV3oytOW/zOfKaWEssd1VgdXtdIUVL1Q==
X-Received: by 2002:a05:651c:1078:b0:27b:57da:b39b with SMTP id y24-20020a05651c107800b0027b57dab39bmr3214721ljm.23.1671035291503;
        Wed, 14 Dec 2022 08:28:11 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id z15-20020a05651c11cf00b0027cf0ecab3fsm233567ljo.138.2022.12.14.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:28:11 -0800 (PST)
Message-ID: <c5f8a5d0b87a48715aa66a3e27f4f17b8544f87a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/7] stricter register ID checking in regsafe()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Date:   Wed, 14 Dec 2022 18:28:09 +0200
In-Reply-To: <CAEf4BzbUxdxJMZ2Ln+7jD8+kq0hiea-XJU4VY5W06dJ_KWJC3Q@mail.gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
         <CAEf4BzbUxdxJMZ2Ln+7jD8+kq0hiea-XJU4VY5W06dJ_KWJC3Q@mail.gmail.com>
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

On Tue, 2022-12-13 at 16:34 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > This patch-set consists of a series of bug fixes for register ID
> > tracking in verifier.c:states_equal()/regsafe() functions:
> >  - for registers of type PTR_TO_MAP_{KEY,VALUE}, PTR_TO_PACKET[_META]
> >    the regsafe() should call check_ids() even if registers are
> >    byte-to-byte equal;
> >  - states_equal() must maintain idmap that covers all function frames
> >    in the state because functions like mark_ptr_or_null_regs() operate
> >    on all registers in the state;
> >  - regsafe() must compare spin lock ids for PTR_TO_MAP_VALUE registers.
> >=20
> > The last point covers issue reported by Kumar Kartikeya Dwivedi in [1],
> > I borrowed the test commit from there.
> > Note, that there is also an issue with register id tracking for
> > scalars described here [2], it would be addressed separately.
> >=20
>=20
> Awesome set of patches, thanks for working on this! I left a few
> comments and suggestions, please take a look, and if they do make
> sense, consider sending follow up patches.
>=20
> Let's really try to use asm() next time for selftests, though.
>=20
> It would be awesome to somehow automatically move test_verifier's
> tests to this test_progs-based embedded assembly way, but that
> probably takes some Python hackery (awesome project for some curious
> soul, for sure).
>=20
> Anyways, back to the point I wanted to make. Given you've clearly
> thought about all the ID checks a lot, consider checking refsafe()
> (not regsafe()!) as well. I think we should do check_ids() there as
> well. And you did all the preliminary work with making idmap
> persistent across all frames. Just something to improve (and looks
> straightforward, unlike many other things you've dealt with recently
> ;).

Makes sense, I'll work on it.

>=20
> Anyways, great work, thanks!

Thank you.

>=20
> > [1] https://lore.kernel.org/bpf/20221111202719.982118-1-memxor@gmail.co=
m/
> > [2] https://lore.kernel.org/bpf/20221128163442.280187-2-eddyz87@gmail.c=
om/
> >=20
> > Eduard Zingerman (6):
> >   bpf: regsafe() must not skip check_ids()
> >   selftests/bpf: test cases for regsafe() bug skipping check_id()
> >   bpf: states_equal() must build idmap for all function frames
> >   selftests/bpf: verify states_equal() maintains idmap across all frame=
s
> >   bpf: use check_ids() for active_lock comparison
> >   selftests/bpf: test case for relaxed prunning of active_lock.id
> >=20
> > Kumar Kartikeya Dwivedi (1):
> >   selftests/bpf: Add pruning test case for bpf_spin_lock
> >=20
> >  include/linux/bpf_verifier.h                  |   4 +-
> >  kernel/bpf/verifier.c                         |  48 ++++----
> >  tools/testing/selftests/bpf/verifier/calls.c  |  82 +++++++++++++
> >  .../bpf/verifier/direct_packet_access.c       |  54 +++++++++
> >  .../selftests/bpf/verifier/spin_lock.c        | 114 ++++++++++++++++++
> >  .../selftests/bpf/verifier/value_or_null.c    |  49 ++++++++
> >  6 files changed, 324 insertions(+), 27 deletions(-)
> >=20
> > --
> > 2.34.1
> >=20

