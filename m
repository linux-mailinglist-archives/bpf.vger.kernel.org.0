Return-Path: <bpf+bounces-8298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AD784B73
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E81C20B6E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE671DDE3;
	Tue, 22 Aug 2023 20:34:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1691855
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:34:09 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A8CEE
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:34:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so10124194a12.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692736446; x=1693341246;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+1hpk+zIGq7829PqmAqIamjnmavQ0nqrtYhNbK5hcI=;
        b=5iuEpC5klS8KNuSvePxVlp+wSR9n6kjssr2yYX93DakJYbpX8HVgRLjUxAeI417tra
         /YypJi8GMTIEq6S2R6spC6wbvH2yKikM1/skaPuaR5Z5MkYNzEBSnTiDQ0Ej3/a4DgYr
         4ddgW7NbExlqhcoirKmVMU5GNvlCDyQdxaXHoG9dcmFMZorcdT9l1f4haN4mwteSk65w
         mgBStSLj3xV0R4uaDsN5pg2rO6+qTmWv5GK5P2ypxOOKlx4c2vFZrLfpmd0juN4Im6p6
         l7zUkCLO915TN+GMj+Q+JlmrnBgJ5vFaKSIW3txG5HGuGzCNDUQWJBxuOlUVzQGRi/CK
         8R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736446; x=1693341246;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+1hpk+zIGq7829PqmAqIamjnmavQ0nqrtYhNbK5hcI=;
        b=MsUywLiiPKQ9YvX8Rc4kvDUA7qGeP3A9jDZB9bWsyXxK2oOJSKZ+Sf3+5FwO96agal
         TCyrICST3PzAbFka6A5g2mMHwjap4MRw09nm6AIKSouJmE428hX0kf49EpveGwFxOcrK
         rfRXzvSQilRlEAYRLutyjK8gu/iQalYel0E4YejzWaQpOh2RdlAk7ljhNLwRGrk7lRnY
         9AOu+5Vcw37TRp6qbgJUkzW+KfLVocQaBV6yFvm9Jmi0LDQjsCHIf7wiWJKkC2nGZhyg
         QzX82VUHkyunqloLjuhVOaFpnFW1XI2pV+u4/h+8k3FfppJyC43EcrqIrJcuozxpoIGo
         S/Wg==
X-Gm-Message-State: AOJu0YwgC+q2j+4a93r1WQ1vy+XbHsb/3+WvMZN4L92KBm9XsLZaxzkf
	m3c/PbU0bcAf/pSMBEQk4uF52qitLmNU90kAvFhCVg==
X-Google-Smtp-Source: AGHT+IEJnr3fnhA0KmPoQVLzh5rEqOubxjBouZBE0y/39+iYjKH02l32TcXwYRzNrUWXeYi/zstpCKqeEFJj+DTrclI=
X-Received: by 2002:a05:6402:524b:b0:522:28b9:e84c with SMTP id
 t11-20020a056402524b00b0052228b9e84cmr11816533edd.21.1692736446457; Tue, 22
 Aug 2023 13:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 22 Aug 2023 13:33:53 -0700
Message-ID: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
Subject: selftests: hid: trouble building with clang due to missing header
To: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, I'd like to get some help with building the kselftest target.

I am running into some warnings within the hid tree:
| progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
hid_bpf_ctx' will \
|       not be visible outside of this function [-Werror,-Wvisibility]
|     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
|       |                                      ^
| progs/hid.c:23:35: error: incompatible pointer types passing 'struct
hid_bpf_ctx *' \
|       to parameter of type 'struct hid_bpf_ctx *'
[-Werror,-Wincompatible-pointer-types]
|    23 |         __u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /*
offset */, 3 /* size */);

This warning, amongst others, is due to some symbol not being included.
In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
can see inside of the testing tree itself.

Instead, `struct hid_bpf_ctx` is defined and implemented at
`include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
the tools directory is a separate entity from kbuild and these tests are
meant to be built/ran without relying on kernel headers. Am I correct in
this assumption? At any rate, the include itself doesn't work. How can I
properly include this struct definition and fix the warning(s)?

Please note that we cannot just forward declare the struct as it is
being dereferenced and would then yield a completely different
error/warning for an incomplete type. We need the entire implementation
for the struct included.

Other symbols also defined in `include/linux/hid_bpf.h` that we need are
`struct hid_report_type` and `HID_BPF_FLAG...`

Here's the invocation I am running to build kselftest:
`$ make LLVM=1 ARCH=x86_64 mrproper headers && make LLVM=1 ARCH=x86_64
-j128 V=1 -C tools/testing/selftests`

If anyone is currently getting clean builds of kselftest with clang,
what invocation works for you?



Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Full-build-log:
https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
(V=1)

Thanks.
Justin

