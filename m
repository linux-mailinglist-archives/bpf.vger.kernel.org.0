Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38E6634E35
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiKWDNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiKWDNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:13:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F87321E06;
        Tue, 22 Nov 2022 19:13:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so705586pjs.5;
        Tue, 22 Nov 2022 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/unz/lEUalHOgGim6q4OBHzs/NDaUSDSX4tIVsnogFU=;
        b=mglh6XMYlB/7Io5lVheqVqM704BdVgqJLDXTCpPrR4h7SOCCfQvbvOr57MqblW35V3
         B8sc6CsoJmBcmrkqF4SEv4/pUX5HPKqHvgZwPCl9Lu0GwWHw6JUICw/dmfnqTwGzAUP/
         oXRIg20lPnOIEpDbN/WTnRlkiV8nTVKeuDeqYsDHWqPkjUquLkE88n2QYXp9L2sRd2Fp
         jiaRhHjdq5lpE9Sk03rGhiKy8JcKS5vigt8kxpCmhJbZp0PYu5WXga8oKCbFJ8HAkyRL
         f6pbNFSWv5gizroOdP80XIXN/UpICPAYmNy7BmZyVcM8rUKC6xqMM5hOQTszKlaKLnTj
         md+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/unz/lEUalHOgGim6q4OBHzs/NDaUSDSX4tIVsnogFU=;
        b=JTJjWH92z0pxFimjCaYqT8FoLHMZyh2IoI/MbJOLmZsEan9Kkdz5Vk8VVwLp42azxP
         G/XK0RIG4jmZwPup0flNgG22dL4yB6h4Hx32RbGNFPIlX0QtvT4pjE9n+GFUbwIW3TCR
         +afKi7dPvor4U2L7McpYsp1Of5uJUyWBN2aPWeDee3nOx5FHUF97/KvCx/SZ2BfH7/FD
         IFV0q9pPmLQyYqAGY+UIrm8+JagdbHaRszelDDJ5WG6UvQebrIzKiCvDH1QHo+zlOuBL
         TO7wqC4M4T+5YbZp62d12rseB7SxUgLbPn87kJL6XoU1lbJfoFHzAc/d2oYkYNQUWCn3
         pZuA==
X-Gm-Message-State: ANoB5plmcuaGBuMr/o3DosaSOTqkFdhAU6CFhiojlASY1TGP7zWl9pUA
        vYsDL1RWyNFRrcOy7DVw2zJbsVKSYfM=
X-Google-Smtp-Source: AA0mqf62mKOkIAUrVuQvqjvr6haWtbUODQm0pRLLOlYzMpjocZpoy8GkEI6TzCl/h8rhW420uhTh8g==
X-Received: by 2002:a17:902:8503:b0:178:4f50:673e with SMTP id bj3-20020a170902850300b001784f50673emr7185252plb.126.1669173186691;
        Tue, 22 Nov 2022 19:13:06 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001873aa85e1fsm12589733pln.305.2022.11.22.19.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 19:13:06 -0800 (PST)
Message-ID: <bf664150-a544-76f8-b61f-98e6472dbebb@gmail.com>
Date:   Wed, 23 Nov 2022 12:13:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v1 0/2] docs: fix sphinx warnings for cpu+dev
 maps
Content-Language: en-US
To:     mtahhan@redhat.com
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221122103738.65980-1-mtahhan@redhat.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221122103738.65980-1-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Tue, 22 Nov 2022 10:37:36 +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Sphinx version >=3.3 warns about duplicate function delcarations in the

As far as I see, Sphinx >=3.1 complains of these duplicates.

> CPUMAP and DEVMAP documentation. This is because the function name is the
> same for Kernel and Userspace BPF progs but the parameters and return types
> they take is what differs. This patch moves from using the ``c:function::``
> directive to using the ``code-block:: c`` directive. The patches also fix
> the indentation for the text associated with the "new" code block delcarations.
I would mention that the missing support of c:namespace-push:: and
c:namespace-pop:: directives by helper scripts for kernel documentation
prevented you from using the c:function:: directive with proper namespacing.

Either way, for the series,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> 
> Maryam Tahhan (2):
>   docs: fix sphinx warnings for cpumap
>   docs: fix sphinx warnings for devmap
> 
>  Documentation/bpf/map_cpumap.rst | 41 +++++++++++++-----------
>  Documentation/bpf/map_devmap.rst | 54 +++++++++++++++++---------------
>  2 files changed, 52 insertions(+), 43 deletions(-)
> 
> --
> 2.34.1
> 
