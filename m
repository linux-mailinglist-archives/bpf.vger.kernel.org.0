Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E996453F0
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 07:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLGGVY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 01:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGGVX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 01:21:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617123AC28
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 22:21:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso580627pjh.1
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 22:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgvTT+rWJQzHxzvAI2L3QICT1OOCxoZleoBKp4KDXls=;
        b=esLqktraLMLFAj/IQCzBbzdbpPvtiJp4Blm2ZuFZRvn6efVb/Ca9x/fVltGeUQB5Zo
         1EUMgfzN5z1hteP+P0Unbrl1n9IOmCc0pLkhv2b6xjNFz1PyAKNTd1j6MPc3eFmSUsek
         JFmWtUIcfB1iaCFoQS5D9Yl06b0tZzcpQIdDL9keK69Fw8B4+O/s4jOf8Eh0ByODqTYm
         0hwccSpGurAI2Zr95SQyh/wyaDTISErhI5k4ubnYFY+cepqHg9iQ9hZy4N9RiWGQsMUH
         Or1IhFZI1dGvPzdKZAnJ7mJby2Y/SLyEAEaJ2PgVMZ9AQ856Sy2p8dKG6pVtp5odoLMC
         QulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgvTT+rWJQzHxzvAI2L3QICT1OOCxoZleoBKp4KDXls=;
        b=jG14OHhqYoRmMuEKtRVcTmV6i9F+Wx1kO73KXH6UM/QouSaArHBWYwp8DbnsBZuXUa
         WXq4qku358a8pflOoJCJrBDYE+zIciRgYXBptBvdoYaVs0WvPg3/qE7ZbmXcRtJY5myX
         jj9I06rWnwZ8AWzQrQ635YmINan2wisk8AiHlzoDlSzKtOfvm8nntZHc5ANa2aayThoE
         8puvx/ArBm/fN5Ql78HpxAY74D44u9/lURyGyvRAUArUUZqnemQOPS48QU4FrUFKRdHP
         4yg59fFnZPmIOqTtcfIXsSCiqXq06zEn3QPXu0EEzxXyZgjpfuq2WmTZ5WE26Hy0Mnsz
         oStA==
X-Gm-Message-State: ANoB5pmkYKTY28NfR7agxkX0mouOVNgnz3GbFYiAA7zyJoMT/8mAgsqb
        3to5VPAVr1Y/krg4Oor51h0N4sscOdQ=
X-Google-Smtp-Source: AA0mqf4lgvqaag7fuYZX6GJfSajgbRn9CMBxI6k50x/orQK8sxmakdOcXx6hLGjg23Tq3dbSr44e7w==
X-Received: by 2002:a17:90b:4384:b0:219:c705:3d7d with SMTP id in4-20020a17090b438400b00219c7053d7dmr15949189pjb.104.1670394081856;
        Tue, 06 Dec 2022 22:21:21 -0800 (PST)
Received: from localhost ([98.97.38.190])
        by smtp.gmail.com with ESMTPSA id n1-20020a632701000000b0047899d0d62csm6329735pgn.52.2022.12.06.22.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:21:21 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:21:19 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <639030df9ec4e_bb36208e6@john.notmuch>
In-Reply-To: <20221206011159.1208452-1-andrii@kernel.org>
References: <20221206011159.1208452-1-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 1/2] selftests/bpf: add generic BPF program
 verification tester
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> It's become a common pattern to have a collection of small BPF programs
> in one BPF object file, each representing one test case. On user-space
> side of such tests we maintain a table of program names and expected
> failure or success, along with optional expected verifier log message.
> 
> This works, but each set of tests reimplement this mundane code over and
> over again, which is a waste of time for anyone trying to add a new set
> of tests. Furthermore, it's quite error prone as it's way too easy to miss
> some entries in these manually maintained test tables (as evidences by
> dynptr_fail tests, in which ringbuf_release_uninit_dynptr subtest was
> accidentally missed; this is fixed in next patch).
> 
> So this patch implements generic verification_tester, which accepts
> skeleton name and handles the rest of details: opens and loads BPF
> object file, making sure each program is tested in isolation. Optionally
> each test case can specify expected BPF verifier log message. In case of
> failure, tester makes sure to report verifier log, but it also reports
> verifier log in verbose mode unconditionally.
> 
> Now, the interesting deviation from existing custom implementations is
> the use of btf_decl_tag attribute to specify expected-to-fail vs
> expected-to-succeed markers and, optionally, expected log message
> directly next to BPF program source code, eliminating the need to
> manually create and update table of tests.
> 
> We define few macros wrapping btf_decl_tag with a convention that all
> values of btf_decl_tag start with "comment:" prefix, and then utilizing
> a very simple "just_some_text_tag" or "some_key_name=<value>" pattern to
> define things like expected success/failure, expected verifier message,
> extra verifier log level (if necessary). This approach is demonstrated
> by next patch in which two existing sets of failure tests are converted.
> 
> Tester supports both expected-to-fail and expected-to-succeed programs,
> though this patch set didn't convert any existing expected-to-succeed
> programs yet, as existing tests couple BPF program loading with their
> further execution through attach or test_prog_run. One way to allow
> testing scenarios like this would be ability to specify custom callback,
> executed for each successfully loaded BPF program. This is left for
> follow up patches, after some more analysis of existing test cases.
> 
> This verification_tester is, hopefully, a start of a test_verifier
> runner, which allows much better "user experience" of defining low-level
> verification types that can take advantage of all the libbpf-provided
> nicety features on BPF side: global variables, declarative maps, etc.
> All while having a choice of defining it in C or as BPF assembly
> (through __attribute__((naked)) functions and using embedded asm). This
> will be explored in follow up patches as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
