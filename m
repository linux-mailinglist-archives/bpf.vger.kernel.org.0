Return-Path: <bpf+bounces-3195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C573ABAE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8181C20CDE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3D22562;
	Thu, 22 Jun 2023 21:35:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFB20690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:35:54 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311901FCB
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 14:35:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso9635502a12.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687469744; x=1690061744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPZQesVDxmMmKXqVsW4tcHyZp77AxBuILZnaWb8IfNk=;
        b=DP+/28RH75MZbYOUslTJmQIL3J2QLFUak7RdjfszU64A4zJGV5Z965tgBG5iyeMBUr
         HHJq3AckhIVqysH1uP2USsPu5jkuMv0BKkfVre24xK6KZPWDPV1j3Lc8nM9/rTsOEi0E
         kt71LfDqW63GkcAd/+uSdUl1JwHZYlTvp4Uig/ujQVULIZpSclZ448TsgI+skt7A4N1K
         Egenz5HoBJecNn5MYwBIZR8duDzcZ6wOps6vI0HjaNgCXltcrcykaNSDj3cSiVO2gflZ
         bpNZbcgAQJDSQFiHHarCvIkD/aXxsn5cQM4QaZ8gq70dJhP4FnxbG7HqJvWe3Vi/xsKL
         iUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687469744; x=1690061744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPZQesVDxmMmKXqVsW4tcHyZp77AxBuILZnaWb8IfNk=;
        b=MnAHmQcxzDknXPMtm+qYIs+or/UmdCOZThpr8eKMOhCIUTszogVS40wtZ/8k6izfqY
         RS7jlw36pjHqzv7XN1r5B36Wr/Vel4q8WT1AwEIC5hTtWnIhAwd3tiKCyyDs4kZrWbSu
         OG6LT72wLF9sdzvEHefwd52NeQ2JMZ6A8pNMKwIyGFcF76xme8SlNiUL3+GSJRMAMNQq
         PX5XRM4DWr9SJyHDsyaH7aNbGIMeGXnJkn2jBb3ZvOuWHBtiiJ43WxWaYMa4NOWLcL/k
         CbWuwDJVhI+kDQa6Wu48PMSf+3Uj2yFrFXPX5M18fqA7bxSULnrfIjh0ISZCPddysCok
         QbDg==
X-Gm-Message-State: AC+VfDza8cUY5xmgcUgqb5u+UyiSsywZdl6M9qWKgZn4gU85j+REKThB
	+3Qbibh8DKtypP/B/i71BoEsBANxSHWoZZS6FOU=
X-Google-Smtp-Source: ACHHUZ71N1UQpDro9p5xUjc/LhzLcMDroT0l49BmrXTadOoM28a94FrF6fAlko1ggBDGbCB0KPiCt5gOrSeUod2mn8w=
X-Received: by 2002:a05:6402:7cd:b0:514:95b1:f0ba with SMTP id
 u13-20020a05640207cd00b0051495b1f0bamr13822660edy.34.1687469744280; Thu, 22
 Jun 2023 14:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615142520.10280-1-eddyz87@gmail.com> <CAEf4Bzb4VJ7h02QAbg77sp9jgVFJBWoXrRuWGxHkXqQdPJ6EPw@mail.gmail.com>
 <87ttv2f0pw.fsf@gnu.org>
In-Reply-To: <87ttv2f0pw.fsf@gnu.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jun 2023 14:35:32 -0700
Message-ID: <CAADnVQKH6i2D2K4VGAzbxkKifjSEq+0K02-zOKDqQVJtmrfHdw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: generate 'nomerge' for map helpers in bpf_helper_defs.h
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>, 
	David Faust <david.faust@oracle.com>, dzq.aishenghu0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 11:27=E2=80=AFAM Jose E. Marchesi <jemarch@gnu.org>=
 wrote:
>
>
> > On Thu, Jun 15, 2023 at 7:25=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >>
> >> Update code generation for bpf_helper_defs.h by adding
> >> __attribute__((nomerge)) for a set of helper functions to prevent some
> >> verifier unfriendly compiler optimizations.
> >>
> >> This addresses a recent mailing list thread [1].
> >> There Zhongqiu Duan and Yonghong Song discussed a C program as below:
> >>
> >>      if (data_end - data > 1024) {
> >>          bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
> >>      } else {
> >>          bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
> >>      }
> >>
> >> Which was converted by clang to something like this:
> >>
> >>      if (data_end - data > 1024)
> >>        tmp =3D &map1;
> >>      else
> >>        tmp =3D &map2;
> >>      bpf_for_each_map_elem(tmp, cb, &cb_data, 0);
> >>
> >> Which in turn triggered verification error, because
> >> verifier.c:record_func_map() requires a single map address for each
> >> bpf_for_each_map_elem() call.
> >>
> >> In fact, this is a requirement for the following helpers:
> >> - bpf_tail_call
> >> - bpf_map_lookup_elem
> >> - bpf_map_update_elem
> >> - bpf_map_delete_elem
> >> - bpf_map_push_elem
> >> - bpf_map_pop_elem
> >> - bpf_map_peek_elem
> >> - bpf_for_each_map_elem
> >> - bpf_redirect_map
> >> - bpf_map_lookup_percpu_elem
> >>
> >> I had an off-list discussion with Yonghong where we agreed that clang
> >> attribute 'nomerge' (see [2]) could be used to prevent the
> >> optimization hitting in [1]. However, currently 'nomerge' applies only
> >> to functions and statements, hence I submitted change requests [3],
> >> [4] to allow specifying 'nomerge' for function pointers as well.
> >>
> >> The patch below updates bpf_helper_defs.h generation by adding a
> >> definition of __nomerge macro, and using this macro in definitions of
> >> relevant helpers.
> >>
> >> The generated code looks as follows:
> >>
> >>     /* This is auto-generated file. See bpf_doc.py for details. */
> >>
> >>     #if __has_attribute(nomerge)
> >>     #define __nomerge __attribute__((nomerge))
> >>     #else
> >>     #define __nomerge
> >>     #endif
> >>
> >>     /* Forward declarations of BPF structs */
> >>     ...
> >>     static long (*bpf_for_each_map_elem)(void *map, ...) __nomerge =3D=
 (void *) 164;
> >>     ...
> >>
> >> (In non-RFC version the macro definition would have to be updated to
> >>  check for supported clang version).
> >>
> >> Does community agree with such approach?
> >
> > Makes sense to me. Let's just be very careful to do proper detection
> > of __nomerge "applicability" to ensure we don't cause compilation
> > errors for unsupported Clang (which I'm sure you are well aware of)
> > *and* make it compatible with GCC, so we don't fix it later.
>
> GCC doesn't support the "nomerge" attribute at this point.  We will look
> into adding it or find some other equivalent mechanism that can be
> abstracted in the __nomerge macro.
>
> >>
> >> [1] https://lore.kernel.org/bpf/03bdf90f-f374-1e67-69d6-76dd9c8318a4@m=
eta.com/
> >> [2] https://clang.llvm.org/docs/AttributeReference.html#nomerge
> >> [3] https://reviews.llvm.org/D152986
> >> [4] https://reviews.llvm.org/D152987
> >> ---
> >>  scripts/bpf_doc.py | 37 ++++++++++++++++++++++++++++++-------
> >>  1 file changed, 30 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >> index eaae2ce78381..dbd4893c793e 100755
> >> --- a/scripts/bpf_doc.py
> >> +++ b/scripts/bpf_doc.py
> >> @@ -777,14 +777,33 @@ class PrinterHelpers(Printer):
> >>          'bpf_get_socket_cookie',
> >>          'bpf_sk_assign',
> >>      ]
> >> +    # Helpers that need __nomerge attribute
> >> +    nomerge_helpers =3D set([
> >> +       "bpf_tail_call",
> >> +       "bpf_map_lookup_elem",
> >> +       "bpf_map_update_elem",
> >> +       "bpf_map_delete_elem",
> >> +       "bpf_map_push_elem",
> >> +       "bpf_map_pop_elem",
> >> +       "bpf_map_peek_elem",
> >> +       "bpf_for_each_map_elem",
> >> +       "bpf_redirect_map",
> >> +       "bpf_map_lookup_percpu_elem"
> >> +    ])
> >> +
> >> +    macros =3D '''\
> >> +#if __has_attribute(nomerge)
> >> +#define __nomerge __attribute__((nomerge))
> >> +#else
> >> +#define __nomerge
> >> +#endif'''

Let's add an extensive comment here,
so that people looking at bpf_helper_defs.h don't need
to search clang documentation on what this attr is doing.
I bet even compiler experts won't be able to explain 'why'
after reading the doc:
https://clang.llvm.org/docs/AttributeReference.html#nomerge
The example from the commit log should probably be in the comment too.
Other than that the approach makes sense to me.

