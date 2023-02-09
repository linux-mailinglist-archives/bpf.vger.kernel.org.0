Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EBB69098A
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 14:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBINJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 08:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBINJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 08:09:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D45EA28;
        Thu,  9 Feb 2023 05:09:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4224AB82127;
        Thu,  9 Feb 2023 13:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A7BC433D2;
        Thu,  9 Feb 2023 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675948164;
        bh=fRkg4DLe+EKVVu/qynoeCc8KbWGF0veU+2MQmBMbWOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbHeJ1O/LlHBmaDwl/NyeXkfwVgPUiRDB9qwqAs5g4LsRiPdimD7O8a9tHdKfQIMY
         TJAjTPf5uKGtZOd1Pwa4FCs3e7kziUEE4/k10RGuQT9dNkVC0Z+JegV7et3efzNd3R
         rAk5ALcDV4RNT6pQfRy91pB8X5chPlTHH/l4Wlav/5wx9Ty12VpVGe+WMUqoy80gf8
         4G0C435mkq9Ci7HFQ5QeOFfo9LvX9qu44mn3R9R46zXDziAdGjJCBXQgwoEqROWuA1
         LvaOmeA2oKF9o8ZTEoQ5B88N6s6K/dKSSnAX1+vgtC+n35P38hUxu/SOvbr1eDWW3G
         415ux217FkeyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72825405BE; Thu,  9 Feb 2023 10:09:22 -0300 (-03)
Date:   Thu, 9 Feb 2023 10:09:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <Y+Twgi+Y1ZfOgsJT@kernel.org>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <Y+PL18hvJ7WwncGR@kernel.org>
 <Y+PS01eC1i75nBM0@kernel.org>
 <3c021d56-8818-2464-f7e0-889e769c0311@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c021d56-8818-2464-f7e0-889e769c0311@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 08, 2023 at 05:17:02PM +0000, Alan Maguire escreveu:
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Thu, 2 Feb 2023 12:26:20 +0000
> Subject: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto,
>  --btf_gen_optimized to pahole flags for v1.25
> 
> v1.25 of pahole supports filtering out functions with multiple
> inconsistent function prototypes or optimized-out parameters
> from the BTF representation.  These present problems because
> there is no additional info in BTF saying which inconsistent
> prototype matches which function instance to help guide
> attachment, and functions with optimized-out parameters can
> lead to incorrect assumptions about register contents.
> 
> So for now, filter out such functions while adding BTF
> representations for functions that have "."-suffixes
> (foo.isra.0) but not optimized-out parameters.
> 
> This patch assumes changes in [1] land and pahole is bumped
> to v1.25.
> 
> [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 1f1f1d3..728d551 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>  	# see PAHOLE_HAS_LANG_EXCLUDE
>  	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>  fi
> +if [ "${pahole_ver}" -ge "125" ]; then
> +	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> +fi
>  
>  echo ${extra_paholeopt}
> -- 
> 1.8.3.1


I applied the patch and it works as advertised using what is in pahole's
'next' branch, that should go to 'master' later today.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
