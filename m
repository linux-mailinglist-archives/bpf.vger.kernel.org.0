Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C355681F7A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 00:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjA3XRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 18:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjA3XRA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 18:17:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB221144A9
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:16:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so20769146ejc.2
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jRYVuxt5BkAtVJeAtIRcYH6NM40qhQseuFIP+ozVr4=;
        b=UynZsHhaYlyDx3TlDBRSLOuU/ZO10AW8TQatunleBO/QuySHwly/Hq60N6e2ST+RJq
         /iY6VLPhMCkXGYJBTbkDDh9IesleGGnRWY4Ovulw+lgh0zWXnXROaKuJ//caOnHObMST
         r324XRXpx54Hg1tIWrT1tI+mEHda9qbBNb/sUDL0Fv4WtyfE/TiS4exSMPnEuJpB2t8Y
         v8k0ZZrFOx1w3oSeqxPJV9fDzs642oKA+B4k5LhZcVN0aqEAtusB/2u5Fd5E9mJa5feq
         juHkydG/Rqm5l9ohSdDwgsWzq2d7Pgx+K6KwjHuVyqoaP6kQd2k/14G7d6769DJ2EZMT
         tdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jRYVuxt5BkAtVJeAtIRcYH6NM40qhQseuFIP+ozVr4=;
        b=LTMD+wDcrLS1Vbq3QWMm9YHgrirp3NqtgMVpb13b6X6UlB0qX6WNtpt18ONBGnScBg
         mYhDhrBnNYzhme2OfcXiwpMWPzwEiJYPUnk6Vdx5kvCSbXZzGOkV1/ib+c1SEDT4T0EF
         5WtOZRPGDIM7VoEFmhm3FNG/h33A11BEhTxMrGmvXBOobR6Rm/+6ymAB4JkOn5MflfUj
         94g2oKEytOs3n33ijVuOX3cnzjcp0cvzNyP2PGbX+GHV9KzmbSFSJNF2LYKYxcRZwZP5
         A+PpYqp4RUhpcs/jCTxCcwQJLOU1PN4PqBv7uyuO0YI5/Q1vTEyUNfcHThPUpLNg0Zx9
         AJ0w==
X-Gm-Message-State: AO0yUKWEL4MpeW2BjFa8J8CCv2IHVFdiABE6LXazDg3lb9Djewvhd5mM
        SGskAy2j34rx/X+c9KVPp2o=
X-Google-Smtp-Source: AK7set+XrDP2bGFeTcFvKHl0sdmKOJC8+7vJ3gFEonEXe4vzwfjIAQC+2AasIzAd/FXn9CZUEtY7zw==
X-Received: by 2002:a17:907:9725:b0:879:aa55:a908 with SMTP id jg37-20020a170907972500b00879aa55a908mr20349663ejc.12.1675120617184;
        Mon, 30 Jan 2023 15:16:57 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id ci22-20020a170906c35600b0087bcda2b07bsm6207197ejb.202.2023.01.30.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:16:56 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Jan 2023 00:16:54 +0100
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv2 bpf-next 2/7] selftests/bpf: Move test_progs helpers to
 testing_helpers object
Message-ID: <Y9hP5hQVcVWh3rQ8@krava>
References: <20230130085540.410638-1-jolsa@kernel.org>
 <20230130085540.410638-3-jolsa@kernel.org>
 <Y9fg5ErTG2xaYlV8@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9fg5ErTG2xaYlV8@maniforge>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 09:23:16AM -0600, David Vernet wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> > index 9695318e8132..c0eb54bf08b3 100644
> > --- a/tools/testing/selftests/bpf/testing_helpers.c
> > +++ b/tools/testing/selftests/bpf/testing_helpers.c
> > @@ -8,6 +8,7 @@
> >  #include <bpf/libbpf.h>
> >  #include "test_progs.h"
> >  #include "testing_helpers.h"
> > +#include <linux/membarrier.h>
> >  
> >  int parse_num_list(const char *s, bool **num_set, int *num_set_len)
> >  {
> > @@ -229,3 +230,65 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
> >  
> >  	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
> >  }
> > +
> > +static int finit_module(int fd, const char *param_values, int flags)
> > +{
> > +	return syscall(__NR_finit_module, fd, param_values, flags);
> > +}
> > +
> > +static int delete_module(const char *name, int flags)
> > +{
> > +	return syscall(__NR_delete_module, name, flags);
> > +}
> > +
> > +void unload_bpf_testmod(FILE *err, bool verbose)
> 
> Maybe you should pass a const struct test_env * here and in
> load_bpf_testmod() instead?  Technically it also has a FILE *stdout, so
> to be consistent we should probably also pass that to the fprintf()
> calls on the success path.

struct test_env is specific for test_progs and we want to call
un/load_bpf_testmod from test_verifier.. but yes, it looks weird
to pass just 'err' and verbose.. maybe we could pass both out/err

> 
> > +{
> > +	if (kern_sync_rcu())
> > +		fprintf(err, "Failed to trigger kernel-side RCU sync!\n");
> > +	if (delete_module("bpf_testmod", 0)) {
> > +		if (errno == ENOENT) {
> > +			if (verbose)
> > +				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> > +			return;
> > +		}
> > +		fprintf(err, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> > +		return;
> > +	}
> > +	if (verbose)
> > +		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> > +}
> > +

SNIP

> > diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> > index 6ec00bf79cb5..2f80ca5b5f54 100644
> > --- a/tools/testing/selftests/bpf/testing_helpers.h
> > +++ b/tools/testing/selftests/bpf/testing_helpers.h
> > @@ -1,5 +1,9 @@
> >  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> >  /* Copyright (C) 2020 Facebook, Inc. */
> > +
> > +#ifndef __TRACING_HELPERS_H
> > +#define __TRACING_HELPERS_H
> 
> s/__TRACING/__TESTING here and below

right, thanks

jirka
