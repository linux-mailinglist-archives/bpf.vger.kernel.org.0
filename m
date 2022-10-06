Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE95F63C2
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiJFJk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJFJk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 05:40:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EF65805
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 02:40:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so1772315wrb.13
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrKKg30ur+pHhsawcohQ29k6vdSRe/ZC1YCBiet54zs=;
        b=1NdJvER4FgWqYRzMMQhzWbBbQbk2jaImBOHOdlxun/pL35rdrW1JvEVloJgSss0ltj
         ifY+bOZXDrSbte7EIDo2db1yu0MENZA7H4cxADlBGTjOogtMrv0CWQgOY2wzKx6pjUGs
         W0J2I2pzZxC9GgnVwUtB4uSZdxLbmmuUGcl6fJUoGX9mf1yQU55KsScMaTCDtZ6TkJm1
         5R/bmLLdPCklTN+y7W9p7cB+qSn2BVYpx/XeICnUqoIcndTz0fzLVCqC3ZHbjCbK48Ou
         kFiZrr4k2HE7zJE3OA42tiz/daViZ/rCd47rVxMXluEPmIBDC+4Lp8axiVOoSeQpdJtE
         fCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrKKg30ur+pHhsawcohQ29k6vdSRe/ZC1YCBiet54zs=;
        b=fbnT0tRJA3bkZlm9QyTWneTpjY3gb11f3Ow7ojbKFRV+ldzblSWc75n5CETtS7gzYL
         UIZ4MWZZyrWlAGJOecPDHnU8UDioZsLz6ikxP3wZ9FRgk+XGSQDIcIjKOfEfgzQuS851
         EfSQbDZOQQunHnjSAJzVkolCC8cBg4fC+FrzKOH7sfRctyRGFkwVQ0ylkwF9MlCc6+d3
         IdngiJk/PGrdICi7/x0mhLKEUxG1UsOG50zx6VMVCJnnODalgWDZDWGFVpREcwia38Z6
         Jf6hoRyw+B2zetb1c7FEzORwfd3Xwnbu+GoSxtBnSvk6qoRpLax0Yz7nYaY0WcYN+qH2
         I/CA==
X-Gm-Message-State: ACrzQf0NixyVZYRAaL36oiYoROyOz+6ve/Nehx51icoecQBfQeXtDfQ2
        dz93tXpkcmvw7wHmPKJAAgxH+GORa7xYpbjU
X-Google-Smtp-Source: AMsMyM5WGlHN+cWw1gmHEZ4/X8cohlYFAReDTBRY9F15hjXdeKuKDzMmSskJFbbwC4l26EI4ZOfrGw==
X-Received: by 2002:a5d:620c:0:b0:22b:e59:8d3a with SMTP id y12-20020a5d620c000000b0022b0e598d3amr2450331wru.28.1665049223297;
        Thu, 06 Oct 2022 02:40:23 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id x16-20020adfec10000000b0022a2dbc80fdsm17395530wrn.10.2022.10.06.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:40:22 -0700 (PDT)
Message-ID: <86af3de7-aecc-c630-a617-6db7c1b6a8c0@isovalent.com>
Date:   Thu, 6 Oct 2022 10:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 bpf-next 2/2] scripts/bpf_doc.py: update logic to not
 assume sequential enum values
Content-Language: en-GB
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Andrea Terzolo <andrea.terzolo@polito.it>
References: <20221006042452.2089843-1-andrii@kernel.org>
 <20221006042452.2089843-2-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221006042452.2089843-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-06 05:24:52 GMT+0100 ~ Andrii Nakryiko <andrii@kernel.org>
> Relax bpf_doc.py's expectation of all BPF_FUNC_xxx enumerators having
> sequential values increasing by one. Instead, only make sure that
> relative order of BPF helper descriptions in comments matches
> enumerators definitions order.
> 
> Also additionally make sure that helper IDs are not duplicated.
> 
> And also make sure that for cases when we have multiple descriptions for
> the same BPF helper (e.g., for bpf_get_socket_cookie()), all such
> descriptions are grouped together.
> 
> Such checks should capture all the same (and more) issues in upstream
> UAPI headers, but also handle backported kernels correctly.
> 
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

The changes look good to me, all checks seem to work as described on my
setup. Nice to validate that multiple descriptions for a helper come
together. Thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

