Return-Path: <bpf+bounces-11468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2E7BA891
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C0A25281E6F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C743CCF7;
	Thu,  5 Oct 2023 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22QnwidH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95B38F97
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:00:29 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8D93
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 11:00:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so2172795a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696528826; x=1697133626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soC/hI6qoVGb1EBSelNwhFg1ZrYnyxzAE+/e29uwgT4=;
        b=22QnwidH5T8m0rE1qmnLt5HKBH53ChSY2UjyhuUrECXA4zPkPQVv66mhNptLztf2sk
         mMguaiogQpVZBMqEtWvp4bSymATUAvvaORmfKpH4Rg270CNBuijTKfAJzrB629kKaLOO
         pSbxbzk73QSNvp/0JsBkmC//eW+EaqR3H8Ic7EgZ5dQCMmg9wGIb8+uDckMgjFMJlQ4g
         ggme4kxJDhLdpTLffXxy8v41oI9XzaviNKmJIigD1jnZcPSfhIMbpawzbMRDQuBniWlE
         JmULgWkkDicR7UcNxdhjVDjcLl+IoAushx00kkqcQMc2rdzuje+wWqKpPTUTa9ipOjdU
         bjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528826; x=1697133626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soC/hI6qoVGb1EBSelNwhFg1ZrYnyxzAE+/e29uwgT4=;
        b=uAP3Dns+ByiLI+jBZLi0qTDtWSShNJqzxIsSWiUIGbReKWEpHSQeF3xH9RAUV3CJhb
         6aQP8EhXE0HWMS9rbJnJ75uPnDkyasLS2Fm/XOHlEvuu4ruvaXm0RsNjwDq6Xfo6+Cf9
         y6JzxI3I8makQeLoyKad1Dnx5oWwzYFKnHQbi2GXcvcNjvKLwgzyXyqMLHjq/DGT+eqF
         gqGyp8xGBGELtvObNs0gWMerfqtl9i5qB4h1kLHzeng+wgIQhNNCnyFjMY5O4+qWtFo4
         Gh/CFwwCOR0rznDDTDb4s1Pq3eSyAVF16dnM63PPw4AT7NWnjNfXzopasiXjPQdzyd5m
         PhUw==
X-Gm-Message-State: AOJu0YyEorWgD+7B2+fSE0ujw4lHu4o40X4cJ/AgJzUQtHyYnku4CgfE
	SGJacXUHnX0LxXYKR6jG43j0CialXPUp6nN3l6hBsw==
X-Google-Smtp-Source: AGHT+IGxbmrYGV4xHeUYWGp7FnCMXrpxOrueGBjqdlU6Zozm6OO34o5rxIoT+s90O/UZXNHJlVnMazAF5XJouq7eXCU=
X-Received: by 2002:aa7:dd0e:0:b0:533:1832:f2b4 with SMTP id
 i14-20020aa7dd0e000000b005331832f2b4mr5295009edv.13.1696528826582; Thu, 05
 Oct 2023 11:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 5 Oct 2023 11:00:12 -0700
Message-ID: <CAFhGd8pKbznU5Atj6vEhjTQc0e3G8wKEBPa5gMteyFAvua=nZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] selftests/hid: assorted fixes
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 8:55=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> And this is the last(?) revision of this series which should now compile
> with or without CONFIG_HID_BPF set.
>
> I had to do changes because [1] was failing
>
> Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
> free to shout if you don't want me to keep it.
>
> Eduard, You helped us a lot in the review of v1 but never sent your
> Reviewed-by or Acked-by. Do you want me to add one?
>
> Cheers,
> Benjamin
>
> [1] https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306
>
> For reference, the v2 cover letter:
>
> | Hi, I am sending this series on behalf of myself and Benjamin Tissoires=
. There
> | existed an initial n=3D3 patch series which was later expanded to n=3D4=
 and
> | is now back to n=3D3 with some fixes added in and rebased against
> | mainline.
> |
> | This patch series aims to ensure that the hid/bpf selftests can be buil=
t
> | without errors.
> |
> | Here's Benjamin's initial cover letter for context:
> | |  These fixes have been triggered by [0]:
> | |  basically, if you do not recompile the kernel first, and are
> | |  running on an old kernel, vmlinux.h doesn't have the required
> | |  symbols and the compilation fails.
> | |
> | |  The tests will fail if you run them on that very same machine,
> | |  of course, but the binary should compile.
> | |
> | |  And while I was sorting out why it was failing, I realized I
> | |  could do a couple of improvements on the Makefile.
> | |
> | |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1=
c153dcb2@redhat.com/T/#t
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - Also overwrite all of the enum symbols in patch 1/3
> - Link to v2: https://lore.kernel.org/r/20230908-kselftest-09-08-v2-0-0de=
f978a4c1b@google.com
>
> Changes in v2:
> - roll Justin's fix into patch 1/3
> - add __attribute__((preserve_access_index)) (thanks Eduard)
> - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> - Link to v1: https://lore.kernel.org/r/20230825-wip-selftests-v1-0-c8627=
69020a8@kernel.org
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/6=
1
>
> ---
> Benjamin Tissoires (3):
>       selftests/hid: ensure we can compile the tests on kernels pre-6.3
>       selftests/hid: do not manually call headers_install
>       selftests/hid: force using our compiled libbpf headers
>
>  tools/testing/selftests/hid/Makefile               | 10 ++-
>  tools/testing/selftests/hid/progs/hid.c            |  3 -
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 77 ++++++++++++++++=
++++++
>  3 files changed, 81 insertions(+), 9 deletions(-)
> ---
> base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
> change-id: 20230825-wip-selftests-9a7502b56542
>
> Best regards,
> --
> Benjamin Tissoires <bentiss@kernel.org>
>

Tested entire series.

 I can now build the tests using this command:

$ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 -j128
ARCH=3Dx86_64 -C tools/testing/selftests TARGETS=3Dhid


Tested-by:  Justin Stitt <justinstitt@google.com>

