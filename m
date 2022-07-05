Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A94567021
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGEOA3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiGEOAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 10:00:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59241EC69
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 06:44:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so17659703wrc.2
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f1PfXbMZFj5YoJCdkyiEEg7SP3t4fdKV7Ip7egz/rTQ=;
        b=iSX/Ai2TDI6+HmvAHkSy0kMkC+3Rw+2OZ36nyy4G0qreV7JTfv/LRRAv3Ola5hPr1I
         Wb8FIcISRVN/YEmzxetIy/yolphCmpHYxUwJLmwrCBg2mblG9lsnGp6PqZbMk+a1kAMk
         /zQR/Rmk1490+fdhtgiyXfwmoO8BPpkxtc95f6SGFJAKgP4CW/zVMhLXdhTLC7i3mXTz
         moNectp5DmN7EPmNoag4Q7/afXPyp6sIxQPg6aLsIUATbZDebOJ/xoHUhfvAFpImMeIu
         RMuw3XKF0DuifQHhkukzPPJqxZm7Cf3nNnDE8NbR+R81ZuizoOntVWT2Gz8VQg2KcCMm
         IIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f1PfXbMZFj5YoJCdkyiEEg7SP3t4fdKV7Ip7egz/rTQ=;
        b=qRzWTqpSkrbdLVPFlEK5Cu0v9xtaWSJuBhzKyo4aZagpUgTVcTO9zgGzDYG03/yecl
         wnf2oASHr6JVBsguHDGe1hYVSTxNiK9+5H/wPMY0hVIa+RiztIirx7Px7kxeAM9U/1uV
         kd70btddRTJAeZywnxve5gg7KOSvQ+QQF1h4wZRjs9ViBqOkloxmnQwX3yJXys2946wP
         27QrAXIW15iSRVwAwYkR2J1jzTf4IwkfYofHdjoZTGRNr3hgHLiskzBQsb4YwheTbemr
         5lqiAAy+W41Jde8ps56KOoXfH0B6/67m2s9r24A8gkXhZO4/Pi/8LR+HvuCE4Bqspgqt
         3muA==
X-Gm-Message-State: AJIora8w4PtELem37vVDYA7mP5pMXEoKLuYK+wD5UYUONaWtvkdKG1Up
        BbX+URJKTz7oCX2i2BmyrjKr3g==
X-Google-Smtp-Source: AGRyM1upY4jO4QXA/zHc8arUDQUJfsyMBsl3KL64Fc+k8tclm31UscLLqqI7lZ7WJfq3wrUxEHbDzA==
X-Received: by 2002:a5d:6645:0:b0:21d:17c3:e10e with SMTP id f5-20020a5d6645000000b0021d17c3e10emr32150367wrw.483.1657028649270;
        Tue, 05 Jul 2022 06:44:09 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id r23-20020a05600c321700b003a03564a005sm18014466wmp.10.2022.07.05.06.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 06:44:08 -0700 (PDT)
Message-ID: <fc1be6d4-446b-2b34-21cb-5e364742c3a2@isovalent.com>
Date:   Tue, 5 Jul 2022 14:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 2/5] tools include: add dis-asm-compat.h to handle
 version differences
Content-Language: en-GB
To:     Andres Freund <andres@anarazel.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <20220703212551.1114923-3-andres@anarazel.de>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220703212551.1114923-3-andres@anarazel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/07/2022 22:25, Andres Freund wrote:
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf}, e.g. on debian unstable.
> Relevant binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> 
> This commit introduces a wrapper for init_disassemble_info(), to avoid
> spreading #ifdef DISASM_INIT_STYLED to a bunch of places. Subsequent
> commits will use it to fix the build failures.
> 
> It likely is worth adding a wrapper for disassember(), to avoid the already
> existing DISASM_FOUR_ARGS_SIGNATURE ifdefery.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  tools/include/tools/dis-asm-compat.h | 53 ++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tools/include/tools/dis-asm-compat.h
> 
> diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
> new file mode 100644
> index 000000000000..d1d003ee3e2f
> --- /dev/null
> +++ b/tools/include/tools/dis-asm-compat.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Any chance you could contribute this wrapper as dual-licenced
(GPL-2.0-only OR BSD-2-Clause), for better compatibility with the rest
of bpftool's code?

The rest of the set looks good to me. Thanks a lot for this work!
Quentin
