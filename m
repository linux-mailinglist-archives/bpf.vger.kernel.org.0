Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2C5A62EE
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiH3MLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiH3MLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 08:11:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7368A2D8B
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 05:11:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m1so13918506edb.7
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=soWZCupSQYBVtPMJfvUGYIPJsNm5QO6KiW/DM1zN+9s=;
        b=OT6FXxI1CD2VxdRQ69NyT8J+hqsT1P6LrP2zv2bmjfrO8hbYVSOeWLyPMmM3EGG94Z
         vBVB5lFnOEtlWtWlR9HJzR6H1jJP2tVTmceg7cKjz77ay6TK7lazmMgU33dvhO7uMiPG
         GIsDQbvZLzq4S2pHxhuSZX4AvZBPAT9Dh7QK0/y+Oq+hRI/AutajpbccgueiTZUZGAMk
         Xzvk4ZSEq2btqumTH/4ZB/fwddfIvpjdzohRA+U11iZz79iedrNwU0tm5a+M6Nm+gz/X
         mJx4/F3mMhAKCUDAOO0ywk1aRusbwxIiCRUulhtSf6fyv60cSRcBgo9R3qrfuKvq2zCF
         myww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=soWZCupSQYBVtPMJfvUGYIPJsNm5QO6KiW/DM1zN+9s=;
        b=Raif2CM+xsuyFX5gilxZ6FyjE3ipf2jiAsacgSdfX24n3MSxBG78QqeNR7dzX4DG8Q
         ZFD8jWV20NG9sna1PD4bzkMrty3JOvlHHEDClGJIu5zVp576CpFsnrZXGVRkxyZxfkdK
         aWlGc1MJMamH6r9lqpU7X4xyike5Zzcpl/oo43+mwHgaqYGoVpoBR6zWchFcJInv2p4F
         1zby5gwTbDl74hmfOg8sqH3VKtJc+ygHubOBvs+MEC/x5fSkXDAOgjmmywN4sVEyNHym
         9j20r3oKicsti3yrPwf70jl+He7fCTWUwttP/V/fDJKHBxaYxrVtrDHpYPizSlQXbrpg
         /BUw==
X-Gm-Message-State: ACgBeo3kmYFD8thSSGMk0JTrWE9iJUUrJ/cTGW///yLVYgoNZPoG+b3v
        SdjqWPpusl4TY8NoOB9QdlpWLm8Jums=
X-Google-Smtp-Source: AA6agR7Mk0tHIC6I15jNeXqZWhXFXb1fjWHzDUBoKbf7A5TnGUtBmlXC9ZB9NQ4hIgJqohna/lKTNg==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr19735234edb.273.1661861480301;
        Tue, 30 Aug 2022 05:11:20 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id rl26-20020a170907217a00b0073db043a6f7sm5700859ejb.210.2022.08.30.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:11:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 14:11:17 +0200
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: Add struct argument tests
 with fentry/fexit programs.
Message-ID: <Yw3+ZfsbBdqo6R41@krava>
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025509.145209-1-yhs@fb.com>
 <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf3de93-ae20-3d76-20d9-67242a65408b@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 12:12:08AM +0200, Daniel Borkmann wrote:
> On 8/28/22 4:55 AM, Yonghong Song wrote:
> > Add various struct argument tests with fentry/fexit programs.
> > Also add one test with a kernel func which does not have any
> > argument to test BPF_PROG2 macro in such situation.
> > 
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
> >   .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
> >   .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
> >   3 files changed, 225 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c
> > 
> 
> For s390x these tests need to be deny-listed due to missing trampoline support..
> 
>   All error logs:
>   test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>   libbpf: prog 'test_struct_arg_1': failed to attach: ERROR: strerror_r(-524)=22
>   libbpf: prog 'test_struct_arg_1': failed to auto-attach: -524
>   test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 524)
>   #209     tracing_struct:FAIL
>   Summary: 189/972 PASSED, 27 SKIPPED, 1 FAILED
> 
> However, looks like the no_alu32 ones on x86 fail:
> 
>   [...]
>   #207     trace_printk:OK
>   #208     trace_vprintk:OK
>   test_fentry:PASS:tracing_struct__open_and_load 0 nsec
>   test_fentry:PASS:tracing_struct__attach 0 nsec
>   trigger_module_test_read:PASS:testmod_file_open 0 nsec
>   test_fentry:PASS:trigger_read 0 nsec
>   test_fentry:PASS:t1:a.a 0 nsec
>   test_fentry:PASS:t1:a.b 0 nsec
>   test_fentry:PASS:t1:b 0 nsec
>   test_fentry:PASS:t1:c 0 nsec
>   test_fentry:PASS:t1 nregs 0 nsec
>   test_fentry:PASS:t1 reg0 0 nsec
>   test_fentry:PASS:t1 reg1 0 nsec
>   test_fentry:FAIL:t1 reg2 unexpected t1 reg2: actual 7327499336969879553 != expected 1

I'm getting the same, I think it's because the argument is int (4 bytes)
while the register is 8, we need to cast to int before we check for the
argument value

jirka

>   test_fentry:PASS:t1 reg3 0 nsec
>   test_fentry:PASS:t1 ret 0 nsec
>   test_fentry:PASS:t2:a 0 nsec
>   test_fentry:PASS:t2:b.a 0 nsec
>   test_fentry:PASS:t2:b.b 0 nsec
>   test_fentry:PASS:t2:c 0 nsec
>   test_fentry:PASS:t2 ret 0 nsec
>   test_fentry:PASS:t3:a 0 nsec
>   test_fentry:PASS:t3:b 0 nsec
>   test_fentry:PASS:t3:c.a 0 nsec
>   test_fentry:PASS:t3:c.b 0 nsec
>   test_fentry:PASS:t3 ret 0 nsec
>   test_fentry:PASS:t4:a.a 0 nsec
>   test_fentry:PASS:t4:b 0 nsec
>   test_fentry:PASS:t4:c 0 nsec
>   test_fentry:PASS:t4:d 0 nsec
>   test_fentry:PASS:t4:e.a 0 nsec
>   test_fentry:PASS:t4:e.b 0 nsec
>   test_fentry:PASS:t4 ret 0 nsec
>   test_fentry:PASS:t5 ret 0 nsec
>   #209     tracing_struct:FAIL
>   #210     trampoline_count:OK
>   [...]
