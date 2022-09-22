Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB315E58E3
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 04:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIVCw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIVCwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 22:52:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC7AD9B7
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 19:52:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd10so9655326ejc.2
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=U+moG5m6mQkKBvBdfdNmc/+CxOvTv6an7ZESmnN4cIQ=;
        b=C3scT+Cgg56SHQtC0R6X9ynhrYHzGNgGirLjQpUqZ+0dF+KrWaawR5REmGov7AkTmx
         rJBYp2NLE6OVxDwRxpj1XXrWEGppsZzDeafJasNbw42NyRIxq7GpPb4hCiy7m5w2d71t
         Oy9WRb95udbVX2Cet7btg0xjapZnFWYDf3tr6GWUjkwQUm6pw66N6kpAdVKuhYTv9t6L
         rSW3Gtp8C9n1c2JW7MmB/pHaoYH5C4YZ7UCrNH9yWJceaG3Z8NwgeNsrMQBL1n0zjaFz
         jdrOgGSOM8JrVHC0Bxy2U60bXTcbyomIdLoShuD7OuNP0yL/qW7s9l9mgcnqbdqIlM3i
         we+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=U+moG5m6mQkKBvBdfdNmc/+CxOvTv6an7ZESmnN4cIQ=;
        b=mBWkdhT8d19Cs4+OOHKoRVQaAVNfbs7k625gUw0sjEIFkj9Vgh3pEZBhiBBFaDl7AZ
         HB3nmHD6TkWXfCPipNO+RC2wdRIDcweKzjTqHOVQW11xJxWHRjWn5VJJ0o7cux8+j6iR
         7961z+97H/TEQgsjcVxOLPkQskWfCOnDMJH5Y1tb5jtjXT2tkuhjYXAGyaI3K+Zn+CZO
         Cmz+bHwUB7/JPrtuy6UuL0wXjhXdeYlJPzbCOinGFCtYP4Xz40Lxbm/CmLLPM5MGNLPD
         xLWmb9v6ojql2X92PM9CVBJ9kgvexm/F3i0kwsJpXhyfuwxoE8N0eesdCedEZIsxZ+pO
         EULA==
X-Gm-Message-State: ACrzQf2AYqlCNucYSbLgvWuCaHSt62Eqt+dqD6ApJAcl/+6KJGtUqWOp
        f0uxzGnIXE4m6xWgLuGHGNgas7OYAM5prolnmw3GvIgSMf8=
X-Google-Smtp-Source: AMsMyM4S/ybN6RBsdm1fpDP257R/0aNmZa4t4CVqEWACeehqWndTj2VcocfBNk5gQ4/Vxdg483AgXTLBONLmxk9Bl4I=
X-Received: by 2002:a17:907:2d21:b0:77d:4f86:2e65 with SMTP id
 gs33-20020a1709072d2100b0077d4f862e65mr990739ejc.58.1663815139925; Wed, 21
 Sep 2022 19:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220921164254.3630690-1-andrii@kernel.org>
In-Reply-To: <20220921164254.3630690-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 21 Sep 2022 19:52:08 -0700
Message-ID: <CAADnVQ+ZDFe6brZJ4dPWnEWwxUtZnL=MuXOzoyNNfY7oxXZZ-w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] veristat: CSV output, comparison mode, filtering
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 9:43 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add three more critical features to veristat tool, which make it sufficient
> for a practical work on BPF verifier:

Nice tool!
Few requests:

1.
Please fix -v mode, since
veristat -v loop1.bpf.linked3.o
hangs forever. Maybe not forever, but I didn't have that much
time to find out whether it will finish eventually.

2.
Please add some sort of progress indicator to
veristat *.linked3.o
otherwise it's not clear when it will be done and
-v cannot be used to find out because of bug 1.

3.
could you make it ignore non bpf elf files?
So it can be used just with veristat *.o ?
