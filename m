Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2906B4B1F
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjCJPba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjCJPbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:31:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648FA144BC8
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 07:19:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10AC0CE2946
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15763C433D2;
        Fri, 10 Mar 2023 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678461538;
        bh=sFhhpJtFUKqp8QWpoGWJ5AsjPE7DwQ3TyV3bWeQWKIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6syCki4hwdYxNVPlWJPit9te7ZIM35qSVSrgCUNpu8F6wpwlPRu5RcuMOWRhFrxe
         wkXzYRHjioFUMjrTPBcJk204HjsL9QQpzDT+PINBI2p5KVL98ysUTdb3tovvKdT58i
         hqeTFdInrlM5W9+/c2ZOcmPL+23zS00pD11cuf9f6uJz1eI+qCMrp1sfCppVgMlmtr
         dZBl1+E0p/8ia462Noi1/7my6U7Qac9GTvRKCX4OVyo7U2XMzZLv/FGlQKp9EgCka7
         4S0a3AA4FXELaLB3VTrKLErElbQTACUT6oMbKTtO+0eV8O9DjdPUEEbMqDz/C8p2xj
         MlBYDmWgOzBaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 990BB4049F; Fri, 10 Mar 2023 12:18:55 -0300 (-03)
Date:   Fri, 10 Mar 2023 12:18:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/3] dwarves: improve BTF encoder comparison
 method
Message-ID: <ZAtKX6+KU8g7Tet5@kernel.org>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 10, 2023 at 02:50:47PM +0000, Alan Maguire escreveu:
> Currently when looking for function prototype mismatches with a view
> to excluding inconsistent functions, we fall back to a comparison
> between parameter names when the name and number of parameters match.
> This is brittle, as it is sometimes the case that a function has
> multiple type-identical definitions which use different parameters.
> 
> Here the existing dwarves_fprintf functionality is re-used to instead
> create a string representation of the function prototype - minus the
> parameter names - to support a less brittle comparison method.
> 
> To support this, patch 1 generalizes function prototype print to
> take a conf_fprintf parameter; this allows us to customize the
> parameters we use in prototype string generation.
> 
> Patch 2 supports generating prototypes without modifiers such
> as const as they can lead to false positive prototype mismatches;
> see the patch for details.
> 
> Finally patch 3 replaces the logic used to compare parameter
> names with the prototype string comparison instead.
> 
> Using verbose pahole output we can see some of the rejected
> comparisons.  73 comparisons are rejected via prototype
> comparison, 63 of which are non "."-suffixed functions.  For
> example:
> 
> function mismatch for 'name_show'('name_show'): 'ssize_t ()(struct kobject *, struct kobj_attribute *, char *)' != 'ssize_t ()(struct device *, struct device_attribute *, char *)'
> 
> With these changes, the syscalls defined in sys_ni.c
> that Jiri mentioned were missing [1] are present in BTF:
> 
> [43071] FUNC '__ia32_compat_sys_io_setup' type_id=42335 linkage=static
> [43295] FUNC '__ia32_sys_io_setup' type_id=42335 linkage=static
> [47536] FUNC '__x64_sys_io_setup' type_id=42335 linkage=static
> 
> [43290] FUNC '__ia32_sys_io_destroy' type_id=42335 linkage=static
> [47531] FUNC '__x64_sys_io_destroy' type_id=42335 linkage=static
> 
> [43072] FUNC '__ia32_compat_sys_io_submit' type_id=42335 linkage=static
> [43296] FUNC '__ia32_sys_io_submit' type_id=42335 linkage=static
> [47537] FUNC '__x64_sys_io_submit' type_id=42335 linkage=static
> 
> [1] https://lore.kernel.org/bpf/ZAsBYpsBV0wvkhh0@krava/

I'll test this now, but b4 isn't liking the way you sent it:

⬢[acme@toolbox pahole]$ b4 am -ctsl --cc-trailers 1678459850-16140-2-git-send-email-alan.maguire@oracle.com
Grabbing thread from lore.kernel.org/all/1678459850-16140-2-git-send-email-alan.maguire%40oracle.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH 1/3] dwarves_fprintf: generalize function prototype print to support passing conf
    ✓ Signed: DKIM/oracle.com
    + Link: https://lore.kernel.org/r/1678459850-16140-2-git-send-email-alan.maguire@oracle.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ERROR: missing [2/3]!
  ERROR: missing [3/3]!
---
Total patches: 1
---
WARNING: Thread incomplete!
Cover: ./20230310_alan_maguire_dwarves_improve_btf_encoder_comparison_method.cover
 Link: https://lore.kernel.org/r/1678459850-16140-1-git-send-email-alan.maguire@oracle.com
 Base: applies clean to current tree
       git checkout -b 20230310_alan_maguire_oracle_com HEAD
       git am ./20230310_alan_maguire_dwarves_improve_btf_encoder_comparison_method.mbx
⬢[acme@toolbox pahole]$

I'll apply one by one
 
> Alan Maguire (3):
>   dwarves_fprintf: generalize function prototype print to support
>     passing conf
>   dwarves_fprintf: support skipping modifier
>   btf_encoder: compare functions via prototypes not parameter names
> 
>  btf_encoder.c     | 67 +++++++++++++++++++++++++------------------------------
>  dwarves.h         |  6 +++++
>  dwarves_fprintf.c | 48 ++++++++++++++++++++++++++-------------
>  3 files changed, 70 insertions(+), 51 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
