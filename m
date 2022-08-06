Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C604058B7DB
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiHFTA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFTAz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 15:00:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224F1055F;
        Sat,  6 Aug 2022 12:00:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w19so10136781ejc.7;
        Sat, 06 Aug 2022 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1/dM4HS7a7aBwHPuKKyvIe9nueiJMG06ztCYduLU7Q=;
        b=iVF8V9jkIU0HdsUq7ADGgunKp4UJXXkuAydwuNxdO3LzQh18BrX9DTg6aimpbfOvDY
         A656IAU46sJEY+x81pz22oAzbClTxqCdG+xr3XvQKpsJsaT4Wr7F9jxm5ufeLHUSo2ZK
         vI18kKY8GRVuxCB/9VtA8JGi7ucbCitF55QlAi+kOzLNr/6JgZZNBhuAIK2fCT4V5M5l
         aRP6A2rEQ2dlcP66s3PtzLN/sGvmYrUuUzYMHCVJUloyf0OF7tPYLVZoQ8PHqvSHqeqs
         pX+Qvo6xz4vm0QhkXMrXwymTfHD09CuFmJkQB7+w3uH2OaVaTj5pKYPQyXBGgNVFQPnc
         f1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b1/dM4HS7a7aBwHPuKKyvIe9nueiJMG06ztCYduLU7Q=;
        b=oZbFw98SSrcZxYk1LnHvY8AtxUykpws0aZWaQOYjACeIHsdRnuGP8Z7o0vYF0gfuAw
         e4mu3ai7ZvX5//9uWdoTw+o7TBVl81kZdsWA3JQnSkHLLnjKJ/KJDX8ghTsz7OPPzKpu
         uRidjrOhGn5T952ykJnRKEqMtSKfMvkmcUj+k12Ib3qHegCIGnph3XNLRCcEkWJ0rFi7
         qNg6UAVfSNUzagP+ApbV1zOWHt6Cro50+URUsJz4AgbddE7t29DIGwJ9MbnV/ASCugCZ
         1PiA7VgjnYmcpuLHffQtVkMT2nDomnhxLwXTvcNdhti7flzxwPPyzrlNipFTrJgGG1B1
         Slcg==
X-Gm-Message-State: ACgBeo1/GHrVy/vZnlxhoki+UW4Wpuv1RnYhk1djsxUzwcUOjG4pDsw3
        1cGlpv90ABaep91J95K+Hvk=
X-Google-Smtp-Source: AA6agR5KFJntmnEbjbxvWA7jSR4+1TjQ4fFm1CTW5tqU8qCCzdekE8xaMos/mHD2uqSlSOgjCez3Rg==
X-Received: by 2002:a17:907:75e7:b0:730:9711:ad80 with SMTP id jz7-20020a17090775e700b007309711ad80mr8826974ejc.35.1659812453249;
        Sat, 06 Aug 2022 12:00:53 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709061c4200b00730538b7cf1sm2984909ejg.75.2022.08.06.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 12:00:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 21:00:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     bp@alien8.de, x86@kernel.org, peterz@infradead.org, bp@suse.de,
        bpf@vger.kernel.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com
Subject: Re: [PATCH v2] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Message-ID: <Yu66YlFzd4VRZq6/@gmail.com>
References: <Yu1Zj5mNZiAWdJgK@zn.tnic>
 <20220805215009.498407-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805215009.498407-1-kim.phillips@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Kim Phillips <kim.phillips@amd.com> wrote:

>  			Speculative Code Execution with Return Instructions)
>  			vulnerability.
>  
> +			AMD-based unret and ibpb mitigations alone do not stop
> +			sibling threads influencing the predictions of other sibling
> +			threads.  For that reason, we use STIBP on processors
> +			that support it, and mitigate SMT on processors that don't.

>  	 * retbleed_select_mitigation(); specifically the STIBP selection is
> -	 * forced for UNRET.
> +	 * forced for UNRET or IBPB.

Nit: could you please capitalize the acronyms & instruction names 
consistently? Human eyesight is case sensitive.

Ie. it should be UNRET and IBPB everywhere.

Thanks,

	Ingo
