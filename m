Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75378546D23
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbiFJTUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiFJTUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:20:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E72E9C0
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:20:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id be31so44303656lfb.10
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4RC71XsahFqJwGDGL2tuKVxdOCc6F94NcpzxmpFZm5o=;
        b=QLufzmpZIsn7Cil2950l1OLgDaxpHtavGgAhM97GDBH2hU+D41ofbEbtH+4bAnhmel
         NRwYC6PAelofZoWSiFEFkpAayEV734PX0QEwKKKEpbNy1iCgzcGsi42pBiujo7lVuBYW
         lRD4fmJ/o5Na+QkvbNk6Tifc2apRMe+MgrUdAmr6qYAqAt+Gc8DfwccTsWGQ8x9AhuS2
         x2PC4BeRRFWcuwMF8XUNVcsb+Nax9WQMfLoDtns6q9OHSVa292sUdZ3dBPYs8DhXJgZR
         k3oBJB/x8+ew4U44JvZw3FmzR14KF+061+r8P5pFEbqd340Ia/hs4Md9GCNDcJ73qn1k
         IkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4RC71XsahFqJwGDGL2tuKVxdOCc6F94NcpzxmpFZm5o=;
        b=ga4O1jUjx8Tghww6qQJcGa+mh7YGIFaMwz15TzxzsnWDen6AWjqrZNU+ZBSJYZkJfG
         GB1s77TwPQaA8gEK4qVwjp8sXe0uWM9zTJG7ho1CfmWf6uunkmnfo7uMHyOvMxRLHCw+
         I7NQJFp42Oy7ezQtqmbH6X5sVTzgv6CmdoxZwAfVo1khZ60pfkmPc/XfPe3TGf8NRaXI
         23imhaOL4mEvw9vYECzpLKPUZuVgC4rCpDj9liRXLwwopdVIvIUR6qimuPzfRi5s6wj1
         9uyCyc7dGXZjpZyrz2DgBu30n4q1drqx8/LYQVQmoUa82k/LRqyO+dGdm0o6qp+cAyYm
         hjBg==
X-Gm-Message-State: AOAM5311TwUWzFxBwDTPQxLQcPTV3tPuYJ9ZJuqhWmoao1qmC8xsvW95
        gsvtbCdsIMWzkIJr5zfr/yB3B7aCTlqitQ==
X-Google-Smtp-Source: ABdhPJyEuk1cJHH0dnE+JbetbC3wUCJKVXz/4d88wXGBGwLnQkDx41g7MElGpoUZVskhn06nnIIb6w==
X-Received: by 2002:a05:6512:3b28:b0:479:43f9:8556 with SMTP id f40-20020a0565123b2800b0047943f98556mr16728720lfv.107.1654888808996;
        Fri, 10 Jun 2022 12:20:08 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g14-20020a2e390e000000b0025550801586sm30319lja.132.2022.06.10.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:20:08 -0700 (PDT)
Message-ID: <a99bc1ffd716ee5ba4f84043e75fdd5a45e11977.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] selftests/bpf: BPF test_verifier
 selftests for bpf_loop inlining
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Date:   Fri, 10 Jun 2022 22:20:07 +0300
In-Reply-To: <CAPhsuW5OX43wjLqVppe8_NGEEkJWMpmX9QXGMQ0gMCVHNKLf_g@mail.gmail.com>
References: <20220608192630.3710333-1-eddyz87@gmail.com>
         <20220608192630.3710333-5-eddyz87@gmail.com>
         <CAPhsuW5OX43wjLqVppe8_NGEEkJWMpmX9QXGMQ0gMCVHNKLf_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, 2022-06-10 at 11:14 -0700, Song Liu wrote:
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> PS: I already acked v3, so you can include it in v4.

Sorry, my first patch, wasn't sure what to do with the ack. Should I
put it in the changelog or in the commit message?

Thanks,
Eduard

