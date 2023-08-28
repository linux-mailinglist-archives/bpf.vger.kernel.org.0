Return-Path: <bpf+bounces-8863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D678B6B5
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA34280E89
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247EE13AFE;
	Mon, 28 Aug 2023 17:48:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDB125DE
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:48:10 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92271129
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:48:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so4720166a12.3
        for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693244886; x=1693849686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qyIITZmt6yIxcf2AHhToVSoBW9CwGLT+eBWC1sVHAU=;
        b=odR1gCkyLODs1etSs5WhGACv3cH24ciJWMHclQ8UrrQaRT6tp7Lbt47muVULy3Meim
         8wuqYAWxhVce2vZ7/dfTM7BZS4Oo3i/RYoVWgFHgFZ2ZjPmKjmncyidLczu0yTTiFgll
         PDD+lw45/CTMK1++RScIQI/jhRnm+BwqwkdXs/QDWzlRXgjhLzeGavE/LTHXKfCAOrEo
         MgAP1SJcFvGysfQFYXfu8HgRykHJF9vFOpgWurKmLBAkuhQDQ8dLCgvnUhZqO5XqEptl
         4z0K1QMbiwW3pM5x+gBfYM2ij7UlC+hu21m4mnXexyzPqfZNAv2b5D7ENphu8fUOLN0C
         H8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693244886; x=1693849686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qyIITZmt6yIxcf2AHhToVSoBW9CwGLT+eBWC1sVHAU=;
        b=A9RX3cIDY3FlG5ZcQrakq+GCroQDvdrEKYRLVWyWQMO4wG+cG3rvhiJM4uH6J7gmi+
         eYZXtHHmBVf2WLDGpcz1SYCgJHqkwggX2YFdrZOEV/xCMBemmbCrg6YGCjyWsBcui12t
         5EdQtB0pZd4sXrj8jLNtOHM43mKaQzCik/O6FWmxInsvd2H140XZ9vYAAMUh+C9tG6jA
         Ot29T+vzxcvVQek5KSuu6qgJGPt3/LMSNQS3n7zCAgmNLrNwsxs99lzH+u8fxvTBNY3h
         RlnqjBjUgdi0r/NFpDq+NAX8oGesezVgp051qOPVIhcZhsQwVcTkXOJEk4VH0NVmyijF
         TCxA==
X-Gm-Message-State: AOJu0YxAS+KfeHgPcG/0CtD60alh0Ztjvccui80j3JUNBJhGRm6zIXJk
	70ZI+0e8B+0jWtNS8W0T+Hxm1J/qWUvn2iDEdVehJw==
X-Google-Smtp-Source: AGHT+IG5s5Adb1+6Jj4dIei4PAmaE17im1X0zrZxagxFiTM+4t42Iq+COd07+PtZk1fzQuinZ/VGGkYh9+gBNhC9H6A=
X-Received: by 2002:a05:6402:510:b0:523:2c05:7d24 with SMTP id
 m16-20020a056402051000b005232c057d24mr23565515edv.24.1693244886029; Mon, 28
 Aug 2023 10:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
 <20230825182316.m2ksjoxe4s7dsapn@google.com> <65800771171dcaff9901dae47de960ec66602f7e.camel@gmail.com>
In-Reply-To: <65800771171dcaff9901dae47de960ec66602f7e.camel@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 28 Aug 2023 10:47:52 -0700
Message-ID: <CAFhGd8rNtEWpfJKFs+nKj_cLya0q6JSFyuzqqMCYmoi9xxBL6Q@mail.gmail.com>
Subject: Re: [PATCH 4/3] selftests/hid: more fixes to build with older kernel
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eduard,

On Fri, Aug 25, 2023 at 11:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2023-08-25 at 18:23 +0000, Justin Stitt wrote:
> > On Fri, Aug 25, 2023 at 10:36:30AM +0200, Benjamin Tissoires wrote:
> > > These fixes have been triggered by [0]:
> > > basically, if you do not recompile the kernel first, and are
> > > running on an old kernel, vmlinux.h doesn't have the required
> > > symbols and the compilation fails.
> > >
> > > The tests will fail if you run them on that very same machine,
> > > of course, but the binary should compile.
> > >
> > > And while I was sorting out why it was failing, I realized I
> > > could do a couple of improvements on the Makefile.
> > >
> > > [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c=
153dcb2@redhat.com/T/#t
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > > Benjamin Tissoires (3):
> > >       selftests/hid: ensure we can compile the tests on kernels pre-6=
.3
> > >       selftests/hid: do not manually call headers_install
> > >       selftests/hid: force using our compiled libbpf headers
> > >
> > >  tools/testing/selftests/hid/Makefile                | 10 ++++------
> > >  tools/testing/selftests/hid/progs/hid.c             |  3 ---
> > >  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 +++++++++++=
+++++++++
> > >  3 files changed, 24 insertions(+), 9 deletions(-)
> > > ---
> > > base-commit: 1d7546042f8fdc4bc39ab91ec966203e2d64f8bd
> > > change-id: 20230825-wip-selftests-9a7502b56542
> > >
> > > Best regards,
> > > --
> > > Benjamin Tissoires <bentiss@kernel.org>
> > >
> >
> > Benjamin, thanks for the work here. Your series fixed up _some_ of the
> > errors I had while building on my 6.3.11 kernel. I'm proposing a single
> > patch that should be applied on top of your series that fully fixes
> > _all_ of the build errors I'm experiencing.
> >
> > Can you let me know if it works and potentially formulate a new series
> > so that `b4 shazam` applies it cleanly?
> >
> > PATCH BELOW
> > ---
> > From 5378d70e1b3f7f75656332f9bff65a37122bb288 Mon Sep 17 00:00:00 2001
> > From: Justin Stitt <justinstitt@google.com>
> > Date: Fri, 25 Aug 2023 18:10:33 +0000
> > Subject: [PATCH 4/3] selftests/hid: more fixes to build with older kern=
el
> >
> > I had to use the clever trick [1] on some other symbols to get my build=
s
> > working.
> >
> > Apply this patch on top of Benjamin's series [2].
> >
> > This is now a n=3D4 patch series which has fixed my builds when running=
:
> > > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers
> > > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 -C tools/testing/selftests TARGET=
S=3Dhid
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/tools/testing/selftests/bpf/progs/bpf_iter.h#n3
> > [2]: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020=
a8@kernel.org/
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  .../selftests/hid/progs/hid_bpf_helpers.h     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tool=
s/testing/selftests/hid/progs/hid_bpf_helpers.h
> > index 749097f8f4d9..e2eace2c0029 100644
> > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > @@ -7,12 +7,26 @@
> >
> >  /* "undefine" structs in vmlinux.h, because we "override" them below *=
/
> >  #define hid_bpf_ctx hid_bpf_ctx___not_used
> > +#define hid_report_type hid_report_type___not_used
> > +#define hid_class_request hid_class_request___not_used
> > +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> >  #include "vmlinux.h"
> >  #undef hid_bpf_ctx
> > +#undef hid_report_type
> > +#undef hid_class_request
> > +#undef hid_bpf_attach_flags
> >
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > +#include <linux/const.h>
> >
> > +enum hid_report_type {
> > +     HID_INPUT_REPORT                =3D 0,
> > +     HID_OUTPUT_REPORT               =3D 1,
> > +     HID_FEATURE_REPORT              =3D 2,
> > +
> > +     HID_REPORT_TYPES,
> > +};
> >
> >  struct hid_bpf_ctx {
> >       __u32 index;
> > @@ -25,6 +39,21 @@ struct hid_bpf_ctx {
> >       };
> >  };
>
> Note, vmlinux.h has the following preamble/postamble:
>
>     #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>     #pragma clang attribute push (__attribute__((preserve_access_index)),=
 apply_to =3D record)
>     #endif
>     ...
>     #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>     #pragma clang attribute pop
>     #endif
>
> You might want to use it or add __attribute__((preserve_access_index))
> to structure definitions, depending on whether or not you need CO-RE
> functionality for these tests.

I have no idea whether or not CO-RE is needed for these tests or not.
My main motivation is getting these selftests building with LLVM=3D1
[1].

Perhaps Benjamin could provide some more insight on whether this is
needed or not and roll out a v2 containing my patch on top + any CO-RE
semantics  -- if deemed necessary.

>
> >
> > +enum hid_class_request {
> > +     HID_REQ_GET_REPORT              =3D 0x01,
> > +     HID_REQ_GET_IDLE                =3D 0x02,
> > +     HID_REQ_GET_PROTOCOL            =3D 0x03,
> > +     HID_REQ_SET_REPORT              =3D 0x09,
> > +     HID_REQ_SET_IDLE                =3D 0x0A,
> > +     HID_REQ_SET_PROTOCOL            =3D 0x0B,
> > +};
> > +
> > +enum hid_bpf_attach_flags {
> > +     HID_BPF_FLAG_NONE =3D 0,
> > +     HID_BPF_FLAG_INSERT_HEAD =3D _BITUL(0),
> > +     HID_BPF_FLAG_MAX,
> > +};
> > +
> >  /* following are kfuncs exported by HID for HID-BPF */
> >  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> >                             unsigned int offset,
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
>

[1]: https://github.com/ClangBuiltLinux/linux/issues/1698

Thanks
Justin

