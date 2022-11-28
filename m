Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11608639E7A
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 01:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiK1AiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 19:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK1AiI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 19:38:08 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCA2BCB;
        Sun, 27 Nov 2022 16:38:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b29so8942650pfp.13;
        Sun, 27 Nov 2022 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjTA2wZ8+39jBSZBfYANTa96CxSOfsTr8erR7n1nNp4=;
        b=nzWcZh1kcH0EoZVPIm+hKTpKZZn/EYWKsmQU/wTSTlFk+2NpfDelj0TwVxTqsKQ7+w
         44KPtTn+/kpRuquHTs13v3KPvn6vIIF/6QNq+fRB1y/3+LzRK/1WSRpWi9nd2bVMw52+
         hhxmNTLrJoLq9maNiwR12aJQy5+TQlFmTsD2yF/QalTNv7RMqVrZCQwYFiOFdSdNGdIs
         6Wlga3nB37RISTVG5OdxJrVit4LNLI8pKEyMqXYmok0P0sJl0OmOYGdnonPIruBPZGWz
         nOTai8MuZKqAnxaFRR+kONRFwDpsItK++5zFXIThFGOhl3fhipvL93ppklSSFFiA794f
         etVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjTA2wZ8+39jBSZBfYANTa96CxSOfsTr8erR7n1nNp4=;
        b=HEKc7BuN4C0ue7AwYCF54Kc+q8r7rZOPBXueNMdmybs4rnl61uC/LgOkCT6d67MN8Y
         8UMbKlSh2N88B/WTFD/WvONI+S4fWya7X99Igbd1l9sXvCDmpGqVMPLBDuvNiQdTYHgY
         3c/JLLJY/T4y2PRcFU9tl48oQB3kWi3VnqUfyJU2xC1bu3pYNDucD4NKfnu35ipeUiPf
         dnLnx+3PuP5yY9S0NQzS2qfLgdlPmsXMZIO9WDDwMYGA6rvHxjJEX0JL8B5uT2Yvi2wg
         Vu71HeY/6MwwZ72bqg4tACH3kGS0N37kQ7QqODjYjIbaj0j7Pemenk/Uvl/DvyWAtG7b
         J0Cw==
X-Gm-Message-State: ANoB5pkDRV33UlWoxNr++CspAmeTQq4+nYDnxfumI9ib+3xCe1mjRv0L
        yHl4PnyxMRQF26h0tddlLUM=
X-Google-Smtp-Source: AA0mqf7d2UGIedZNR9/Am8EIC7pteJS2pzbdtYWj85ulqOZjDTBDwBDcCzEcO+xoVMh/ibRcW6FzVA==
X-Received: by 2002:aa7:954e:0:b0:574:36b6:f91b with SMTP id w14-20020aa7954e000000b0057436b6f91bmr25749446pfq.55.1669595885147;
        Sun, 27 Nov 2022 16:38:05 -0800 (PST)
Received: from MacBook-Pro-5.local ([2600:1010:b0bc:b0ff:414:a8c4:5bb8:5c66])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b0018968d1c6f3sm5416488pla.59.2022.11.27.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 16:38:04 -0800 (PST)
Date:   Sun, 27 Nov 2022 16:38:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Add LDX/STX/ST sanitize in jited
 BPF progs
Message-ID: <20221128003800.h2bmqcv5dfqmfbcf@MacBook-Pro-5.local>
References: <20221125122912.54709-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125122912.54709-1-sunhao.th@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 25, 2022 at 08:29:09PM +0800, Hao Sun wrote:
> The verifier sometimes makes mistakes[1][2] that may be exploited to
> achieve arbitrary read/write. Currently, syzbot is continuously testing
> bpf, and can find memory issues in bpf syscalls, but it can hardly find
> mischecking/bugs in the verifier. We need runtime checks like KASAN in
> BPF programs for this. This patch series implements address sanitize
> in jited BPF progs for testing purpose, so that tools like syzbot can
> find interesting bugs in the verifier automatically by, if possible,
> generating and executing BPF programs that bypass the verifier but have
> memory issues, then triggering this sanitizing.

The above paragraph makes it sound that it's currently impossible to
use kasan with BPF. Which is confusing and incorrect statement.
kasan adds all the necessary instrumentation to BPF interpreter already
and syzbot can perform bug discovery.
syzbot runner should just disable JIT and run all progs via interpreter.
Adding all this logic to run JITed progs in kasan kernel is
just unnecessary complexity.
