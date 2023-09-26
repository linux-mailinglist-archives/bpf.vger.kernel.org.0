Return-Path: <bpf+bounces-10857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7CA7AE6CA
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 75E6B1C208F8
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A066AA5;
	Tue, 26 Sep 2023 07:27:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60EC63AB
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 07:26:59 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC343192
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:26:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1011084766b.1
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695713216; x=1696318016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL9jzjX9Dj4vINipwZ1Fop5IYAbBFu+z+Vj4h2wF/5E=;
        b=o09YdU0mmxxsksjNEi04O/LiJIVtHroN558/hfqDMu37IqW2kmIKmpqYJqj5rk9h3D
         +RU/q2AkDJTYvIPH5kxKcss9HnDthvlShxpzLIBZwwnBuHww7cSbbGPCbHMt59OHB/zq
         NCl7IiLsIGJa5uZLtk+LsowqKWhyfIkvW4IFhHJTYOg5AztA7m2iGolyUd1xzvCyYAfz
         nReqoMK4KFdySkmsrBcBqbg5HZ2SkgVK4sCaj6hLz4ziWrBO7703AH/1Pt4sn2r+aC7e
         6+s3flZx7nD0IFE/qFn51mOLd5MNX74z+yVa4GaD6Ue77mFwz/gP2xNCJyDJhqZf3wJg
         7dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695713216; x=1696318016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL9jzjX9Dj4vINipwZ1Fop5IYAbBFu+z+Vj4h2wF/5E=;
        b=TP4Q+v450WsSZeTO8nJ6S/BVh2jO5f/Nk0ZtCpbLuG62ay0YPZ9TlyVv2RHhtTTAgl
         X2tNqT3YIXlZ1XB8jpOw/AmyH/Zj8rfKhkMjaVr2Elx2W2mNFJTvk7nr6VqOdOM0uIc4
         FzE1M8FfnQ/Cuj7xG7kEmJE5zW1LJ8LjGeCS4AEVYQJzgfYFkZ29Sr/Hk0Ho/iDqQN+6
         MxdvibWu/JV+Jy4rUD1DSZVRjVDX78OTTkkVhRp31PB+NbiYMRd//9JcoYZfxG/97OVn
         HE3YDS7/0na+Hntao3JtA+tHIVSM5uulFWaMNgSe8TJtlg/AVKPx+qF7HuwpBv6XICrK
         Nfvw==
X-Gm-Message-State: AOJu0Yyjy+ldsWs3DXWFie3w1kswatxG4jtUaUQc0f7tJ2K42j0Kken7
	39iUbWn/lqI6zAAtFVM+Ysp8no1HPw57qMsMvwPYkg==
X-Google-Smtp-Source: AGHT+IFD2+LPuamDwfHmqmOw1Eb5LDk2z4fOwwV3qDU7j4eyB/9B7AGlGQS6QABciR6k3DepbtJwkJ2DH3H9480eta8=
X-Received: by 2002:a17:906:1d5:b0:9a5:da6c:6539 with SMTP id
 21-20020a17090601d500b009a5da6c6539mr8145437ejj.75.1695713216164; Tue, 26 Sep
 2023 00:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 26 Sep 2023 16:26:45 +0900
Message-ID: <CAFhGd8pEv32zp4RDsj_jeBjzP5hcsf4dP4Knueiw_UM8ZsqcKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selftests/hid: fix building for older kernels
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey all,

Gentle ping on this patch. Looking to get this patch and [1] slated
for 6.7 wherein we can start getting cleaner kselftests builds.

I do not think I am able to successfully run the hid/bpf selftests due
to my kernel version being too low (and an inability to upgrade it as
I'm on a corp rolling release). I'd appreciate some insight on how to
get the tests running or if someone could actually build+run the tests
with this patch applied.

On Sat, Sep 9, 2023 at 7:22=E2=80=AFAM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi, I am sending this series on behalf of myself and Benjamin Tissoires. =
There
> existed an initial n=3D3 patch series which was later expanded to n=3D4 a=
nd
> is now back to n=3D3 with some fixes added in and rebased against
> mainline.
>
> This patch series aims to ensure that the hid/bpf selftests can be built
> without errors.
>
> Here's Benjamin's initial cover letter for context:
> |  These fixes have been triggered by [0]:
> |  basically, if you do not recompile the kernel first, and are
> |  running on an old kernel, vmlinux.h doesn't have the required
> |  symbols and the compilation fails.
> |
> |  The tests will fail if you run them on that very same machine,
> |  of course, but the binary should compile.
> |
> |  And while I was sorting out why it was failing, I realized I
> |  could do a couple of improvements on the Makefile.
> |
> |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c1=
53dcb2@redhat.com/T/#t
>
> Changes from v1 -> v2:
> - roll Justin's fix into patch 1/3
> - add __attribute__((preserve_access_index)) (thanks Eduard)
> - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> - Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c86=
2769020a8@kernel.org/
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/6=
1
> ---
> Benjamin Tissoires (3):
>       selftests/hid: ensure we can compile the tests on kernels pre-6.3
>       selftests/hid: do not manually call headers_install
>       selftests/hid: force using our compiled libbpf headers
>
>  tools/testing/selftests/hid/Makefile               | 10 ++---
>  tools/testing/selftests/hid/progs/hid.c            |  3 --
>  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++=
++++++
>  3 files changed, 53 insertions(+), 9 deletions(-)
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-kselftest-09-08-56d7f4a8d5c4
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/all/20230912-kselftest-param_test-c-v1-1-80a6c=
ffc7374@google.com/

Thanks
Justin

