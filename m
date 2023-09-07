Return-Path: <bpf+bounces-9450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54D797C7A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83029281782
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B851400A;
	Thu,  7 Sep 2023 19:01:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242213AC2
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 19:01:31 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89F92
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 12:01:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6543d62e9a4so12127106d6.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694113289; x=1694718089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UaLNjN3ZJ7PyVOlkdkv0QrmrabX8B4mPti5Xlo/jWYU=;
        b=CZ7qcrTUr8Y81zg0m9lrRuw1OPoadXpWm///GRVsFA0RZSufleSlHNf3JKlsIV0jkP
         wnxZ/SLWNZWvoDZ3rL1Yjc7rU9nGWxvUNgoyqf3/NHIBS1lZ34cfpUxfc3GnsjELdQkM
         z69Y6Z0f4SCNWlMuqV0mDwTGlTPV1drOO5g2kzcqEFOqusjG3/spqFIrONVZQ6x2YNMb
         YLVcEOrvzace9Swy5XU1mjxDUPMoraXeOoYxC+yW9hFgG5Go5NVXMoof6alj376wSfNM
         DifMeBJhP062oRdzn9xZgY32j6a9aLCI8NHuzUtaYhCEW6WYD16zTHYYbjA3C1KcD2wA
         dw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113289; x=1694718089;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaLNjN3ZJ7PyVOlkdkv0QrmrabX8B4mPti5Xlo/jWYU=;
        b=pCh7slTBxyR10LpqZIAMKa14D6qjxr7MbNUDUk4A932QGo764u38U8oXZqvOv7gBYn
         FYqt33APXd2fWj/Oc4hAMKsdfLck7xmh4jQc5Yu11B2U0b9L4mOgE/ybDW7ya82DBqUM
         tTTzLEQU6UyumXujabNKCTD+QdmUq+XfSk8ZPqeLM7ddbmU0fALnGbUUj8XpjNJ0RpXB
         44PcakbAp/yHC7TebwA+R9NB2xZDogcnFqTVcZKm4Ogq2HWmzs5afUarwI+IQrOUG6by
         0Q3RLIRDHrCz+mqk5OIfuFSxcbgJ+HHAN/xMTNJpZdFU735n5K01zIQ/UUPgAoxpYFR8
         E2JQ==
X-Gm-Message-State: AOJu0YwO2RTL3V5H9hkdv6URHppWxk2VBtzzyd0imyuICguat2uNN2AR
	cIEbzVFBihPcpi2c5nWYbRCQ5QqBxyvU6X63aOtROOaVvDy29ooO+JWzDA==
X-Google-Smtp-Source: AGHT+IHXzTMMD4Rl71NhyoDZ0xSQVibyb32ap43DMerFHyxkAyTKG1EhA6m83AXV+G9mbNxFiKQB8OTbxV/k4hrgonw=
X-Received: by 2002:a0c:e14e:0:b0:64f:53a8:5d0f with SMTP id
 c14-20020a0ce14e000000b0064f53a85d0fmr462867qvl.20.1694113289437; Thu, 07 Sep
 2023 12:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Sep 2023 12:01:18 -0700
Message-ID: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
Subject: duplicate BTF_IDs leading to symbol redefinition errors?
To: bpf <bpf@vger.kernel.org>
Cc: clang-built-linux <llvm@lists.linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

So we've got a curious report recently:
https://github.com/ClangBuiltLinux/linux/issues/1913

ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
'__BTF_ID__struct__cgroup__624' is already defined
__BTF_ID__struct__cgroup__624:
^

It's been hard to pin down a SHA and .config to reproduce this, but
looking at the definition of BTF_ID's usage of __ID's usage of
__COUNTER__, and the two statements:

kernel/bpf/helpers.c:2460:BTF_ID(struct, cgroup)
kernel/bpf/verifier.c:5075:BTF_ID(struct, cgroup)

Is it possible that __COUNTER__ could evaluate to the same value
across 2 different translation units, leading to a name collision like
the above?

looking at another usage of BTF_ID other than struct
cgroup;kernel/bpf/helpers.c:2461:BTF_ID(func, bpf_cgroup_release)
is only defined in one translation unit

Should one of those two `BTF_ID(struct, cgroup)` be removed? Is there
some other way we can avoid these collisions in the future?

Was this a previously observed/fixed issue?

-- 
Thanks,
~Nick Desaulniers

