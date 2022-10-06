Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF595F5DE8
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 02:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJFAhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 20:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJFAhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 20:37:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBDC2E9F8
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 17:36:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so298346pls.4
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 17:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kao0tcwbJ3j2Fkc1hB17ULrhzYHILk3qHhJUzS+At50=;
        b=gPf5ayd0Z+kwGDCs+Pnwid5jdiXVOUKSpBvv2wk6gNmUgukBCBfaBmNskp/SWiSOGc
         8kMxK38XtlvN6Ug4XPx6nRsLKbvfgxLs7q+0C7gDAwGS5ZPZh3MHo9JI97NFgF0nqhoe
         f7vvhS6ZwVHNIA4oNvMihoI1uUCIVJ3SJreODf5wqwrqOBusXtBDg3u9Np8yPk4PCL0H
         5J/6UODR7+hb+k47HDY+qkG01boRPmH+2tKA9lkyL6v+/20vQEy5PGsvo8B0kNzpi4Qy
         QQ/9Kav8fCmurItP6wQu5RbHCbbK8CBMdk/mYbvXorRHmlV8mu4liFdyANujRfr/YEeS
         UtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kao0tcwbJ3j2Fkc1hB17ULrhzYHILk3qHhJUzS+At50=;
        b=aQl/5JJPqFkrsJmwn0eoZ0j2w1GUoSDSPviWQSFRjaHALmZJx0cIF4BojY057onmZx
         8YMmFAAXsB2TsJdPwa4c4sG+n5AWM4ro+TFDHUUpgXyP5fZPBrYCWNS1IO6pQz5fy4Ck
         HphpEZD9SFtn5GcZdacWMI5vEh011yjeeARHXUitPrBZgk5x+XEiBkScOgmsE+fG8543
         Abj1pSfgd2qgN5gRbwrSDPBzxtL6E+n5dtfL0VeGwLeJ9laAG/ItTOTo8mbJ7SRBiEcX
         RgHAVzzRD3V7cjQVnhSVd8N30yXW2xZ1dFrAZGkLp/5mpBWSQsOBpAyxx3rDzaMyPNEC
         TK7Q==
X-Gm-Message-State: ACrzQf1xmO/++bSHq+VZH2QpQnQPaMIwBY1NaXeRnldWhY2cWdBy4KgE
        CXfZXDibi4mleTHxYweiNNo=
X-Google-Smtp-Source: AMsMyM7ZIpADf6K/3tu0eCKmuLfXu86Jrfp+vhvL3jtaYNY0ttEQbjtTLy5oQ9UMMtMU5v/5jneafA==
X-Received: by 2002:a17:902:db0a:b0:178:32b9:6f51 with SMTP id m10-20020a170902db0a00b0017832b96f51mr1923990plx.145.1665016617790;
        Wed, 05 Oct 2022 17:36:57 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:d9ff])
        by smtp.gmail.com with ESMTPSA id v8-20020a63f848000000b00438834b14a1sm354610pgj.80.2022.10.05.17.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 17:36:57 -0700 (PDT)
Date:   Wed, 5 Oct 2022 17:36:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Subject: Re: [PATCH bpf-next] bpf: explicitly define BPF_FUNC_xxx integer
 values
Message-ID: <20221006003654.dgjotl7vxpvpm53i@macbook-pro-4.dhcp.thefacebook.com>
References: <20221005180932.2278505-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005180932.2278505-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 11:09:32AM -0700, Andrii Nakryiko wrote:
> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
> 
>   - with over 200 helpers now it's very hard to know what's each helper's ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.
> 
>   - when backporting and cherry-picking only some BPF helpers onto older
>     kernels it's important to be able to skip some enum values for helpers
>     that weren't backported, but preserve absolute integer IDs to keep BPF
>     helper IDs stable so that BPF programs stay portable across upstream
>     and backported kernels.

I like the macro hack, but it doesn't really address the above goal.
I tried:
-       FN(map_delete_elem, 3, ##ctx)

and got libbpf build error:
Exception: Helper bpf_map_delete_elem is missing from enum bpf_func_id

Then I tried to delete the comment describing map_delete_elem and got:
Exception: Helper bpf_probe_read comment order (#3) must be aligned with its position (#4) in enum bpf_func_id

So backporting process is a bit easier, but such uapi/bpf.h
is unasable to build libbpf against.
It's not a problem for github/libbpf, since it keeps bpf_helper_defs.h in the git,
but still.
Probably bpf_doc.py needs to get smarter.

Maybe 2nd check in bpf_doc.py can be dropped?
Meaning that the comments can now be made out-of-order?
A good thing?
I think we should probably still enforce the order in upstream kernel through code-review.

Also see cilium/ebpf/asm/func.go
The change to FN() will break that hacky script, but it's an ok trade-off.
