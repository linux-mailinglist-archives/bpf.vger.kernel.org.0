Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF40526F40
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiENCqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 22:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiENCp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 22:45:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1679833457F
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:47:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 137so8927260pgb.5
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4AaDHcfwNGWtIecKUdtT1K8sir+gsaoCyjEbK32tmuI=;
        b=Oaq5CT4OdMAZMwCNX4enugiAYVVJtO6/v73JmyXYnnEnz3jyi2Qh9AKUrSwA2+tLkf
         Pa2UukIZqgnwEn3wGYzJfDR3ur/cDmUEXlCxd0UgoyY6JT1yMQJn7tCPNpgEQcVMgJEt
         6rnHNhcXB2Nq8QZRhJRBdlRAEVYvhwtbUtRRo5CsEf0a6VSOoOwIJtsihqUHzye+mCfY
         H3o5uYjr0LuWwT8HnFCgSKnVxImaSJZNXuNoJmKkXQGtRvRMBI5sScEW05ScsQZoUdid
         ySdMnnzfDOajJtWCzG2lndvW1chpNr9J0HTIpiVoANsQ2ag7FokdkNGRLoLlMlcwmL9t
         WOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AaDHcfwNGWtIecKUdtT1K8sir+gsaoCyjEbK32tmuI=;
        b=ptwaozaJOK/5mVKlKYDxSOBeqKAWPH0qWEdg2LDCk7SRCZALQslyhzc5MmsE+jtoAM
         BiXNzNVIjRcDDNqBD+254N4veuO79Q8v1Xbdv+6Su6HboDqOBtK9IVUXN5/Sn526FF8y
         GBYItiHIRJNcLB6Ri1UFqRPjbt1h41cp4s1TcIxvcwiVjZRO7gb88A+qQ51h3JIZ8qyY
         a+vtcl7NFqtwdQdZ0M5BRuO0u0cMhZKn+dY9LXNAzsfkm5USJrCE/eATEdCt10joRSNC
         sr93PKlW92nbbEYn+4NJv6haXg5a5naEmWh3h2y/D5kfst3uIw3dozZQBY5d+gHUkKjn
         jkIA==
X-Gm-Message-State: AOAM530rkh8sYMZntkX9tsc2qffEJ6BuLuDI7LLp5ERHkOZbkJgxxOGj
        vSEcZ5QOtVWzBo8mmWqZMJk=
X-Google-Smtp-Source: ABdhPJzAtyWI6wC31xLTonGGwmZNMT40Ud5Cq9UpfNJadpsrsA5Tzb2ZlPwdcY/V4Z0QQhO/bBDZbw==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr6754230pfb.59.1652488988130;
        Fri, 13 May 2022 17:43:08 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id n5-20020a634d45000000b003db88f80c4asm2166137pgl.71.2022.05.13.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 17:43:07 -0700 (PDT)
Date:   Fri, 13 May 2022 17:43:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 3/5] libbpf: usdt lib wiring of xmm reads
Message-ID: <20220514004305.nvgu72qza5xztya3@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-4-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512074321.2090073-4-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 12:43:19AM -0700, Dave Marchevsky wrote:
> +		err = bpf_get_reg_val(&val, sizeof(val),
> +				     ((u64)arg_spec->reg_off + BPF_GETREG_X86_XMM0) << 32,
> +				     btf_regs, btf_task);

That illustrated the point from patch 2.
The above is probably the typical usage.
Just BPF_GETREG_X86_XMM in uapi enum would have been enough.
