Return-Path: <bpf+bounces-4064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11C7486C7
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6B828029F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A65111A2;
	Wed,  5 Jul 2023 14:47:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A73233
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:47:42 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406D1703
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 07:47:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-55adfa61199so4950394a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568459; x=1691160459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywWTDPgqX+gcaxTU4Vy20tWYfZrGK1sN7BEbBloop7I=;
        b=YNZNDv9ef3UmQHQ2bOts1WEQQOCqsxTnZcc0f/AgCEihIULNs6i8zvd+4UOQ2BgVT6
         Av+oARkEpzkaeH0L4ZSBJ+ISDPlQghz5oVsytSW/dOEZxsV/gn5TAL0TdhNbAwJiMOhP
         TWCHiWFZyvp3vu4ZAkab7P3XRLf2AzkwUfZ3/bqLY6bnoQpTtqwTMo8CEJs/HEKhZ/uc
         6RJ2m7gCSahpBqY5jd7WMdXBi6L7NmtaV/hIZfuLoWUsYkxO0zxjA/mArZZhDWsBIfls
         AJ2qU9wHzew/LRklnFkonbus1V5jG1xjIn5GHlGERagMSnJQtae7++LiyLXaHJDRo1fI
         raiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568459; x=1691160459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywWTDPgqX+gcaxTU4Vy20tWYfZrGK1sN7BEbBloop7I=;
        b=lx/n5ZuPBnUP3VU3npZhfT2dfc7NJDb3d7KEaP70cLyHi5xYF2zVOahDwCxafopH79
         3ycQRi64OG+m0SsOmX05qhfB1WzRUuZILVaExwfKXvBNjosJWUIvy9B+p0+bQvBYkA7J
         G4ydGVkdjimts4oxpJpMleRPocecHOGGPRRXX08Jsbc6O+QFD+k2AmJLcmK7C54hY8gF
         naXGahM19dugzliAarE+5lQQrjfDeiC2gY79OlOuH+aRSCjfJQKDH9XhcSf3Jjufee5+
         BlFlAzL4ZtRLHb29QVSO4mLiW1PQ0ol1T5MDGGpAC4j3VkqxcwnrcI01sCBDLz168PuQ
         bJNg==
X-Gm-Message-State: AC+VfDyqyE87aTSm+2W7ZBjC5v4Hl9+HK/76IVYcGMZL4V6nkE1xk3c5
	PusP91Tg2x7IVgjGt0Pa7eC5oeqTa451th6f
X-Google-Smtp-Source: ACHHUZ4N4PIB+B03DgBXmVNh1URSI70AcasxMEYEV/6gQVVBOXb2IEbr9uKRtj7Dr92OCdJFMP+d0Q==
X-Received: by 2002:a05:6a20:320e:b0:122:4a16:dfa4 with SMTP id hl14-20020a056a20320e00b001224a16dfa4mr17233698pzc.10.1688568458947;
        Wed, 05 Jul 2023 07:47:38 -0700 (PDT)
Received: from localhost ([49.36.209.255])
        by smtp.gmail.com with ESMTPSA id y195-20020a6264cc000000b006826df9e286sm7857406pfb.143.2023.07.05.07.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:47:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 0/2] Fix for check_max_stack_depth
Date: Wed,  5 Jul 2023 20:17:28 +0530
Message-Id: <20230705144730.235802-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=memxor@gmail.com; h=from:subject; bh=rgwv+U+ziVqL3JT1eAXU6iAkmxT0+KyVt8jMynGE1uQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkpYFnL8JoQcwRYLl4Ov38c283cIAJgV7uBEDtT qzZUibBZrqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZKWBZwAKCRBM4MiGSL8R yuB4D/0V9VU3JJfH2HVGftZtJy8EQolJzeorEjsH6ZjD4haLOX9/vKrRdOvHupx7jozo4uABqjO z2UsZVKTaTbugqf9KSAWWKK2QTfFdx2lVmG5fq0uT7bXo3eQ6w/IPA/kZMEQukrrchRm/lNPSiA 99zY5Re/jC4fuHRVVd2xHtx5Y4/vniUK+fM2i91QtQA2ESs7V35N2+oE3cdg3ejjNT1TNr6dNG/ GbXj+C91nfmF5C9CW0sF1uZkq6vr2a5Vbq0u5gOPcWOF5sRiIM1t3Uoqsx9fNqg0rexyJ38iheO YS3GVilV+MudDa8wAUCbSRjI5JGwKai2V8KqQON2fKPWhyfq4As7iLyt4k4lO6zAmLYb0tfh7jR /e+aBHWEjVxr5YyA9ywrZVoraUEL0x4iseAnNOaUoSZmSJtL7l56f7OggjHimuQvC/lg4yNqcDw 4tsaGW64Xpusrr/qG2NU2Yz+EPz2+cpRHzjHCeLg/4bbNSnoiiSDli5pOzc8pHRk5sCRKBAzMxe 0gxJqfk9j/jc7YLqfsJQFxSZQeqdjh11FP7zHRrWEuPEg+DbT3zchfvnQa3kHBzYlRM9qBPns9u mXbeqLcBBh4CEOsIPU86PxodS2e2ZicUdhNCLvJVNFYk6BEp7um4WRdadMhX2iRA8itnLieyq0H BlMNVcNCYtOjdJw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix for a bug in check_max_stack_depth which allows bypassing the
512-byte stack limit.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix max stack depth check for async callbacks
  selftests/bpf: Add selftest for check_stack_max_depth bug

 kernel/bpf/verifier.c                         |  5 ++-
 .../bpf/prog_tests/async_stack_depth.c        |  9 +++++
 .../selftests/bpf/progs/async_stack_depth.c   | 40 +++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/async_stack_depth.c


base-commit: f7306acec9aae9893d15e745c8791124d42ab10a
-- 
2.40.1


