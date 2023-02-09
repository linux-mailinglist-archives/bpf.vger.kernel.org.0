Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05903690C6F
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBIPIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 10:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBIPIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 10:08:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206546A1
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 07:08:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so2054453wrz.12
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mo79tZbV4VO7EeFzyq6Qk9j9V7NRSOgk4h69S5xmO0=;
        b=fUAMjiK526AHq35W3n871YknP0FiFVYs+c68pgYRMZPOrEt5DydLxAotxeer2PMg5B
         yBQTxISG6fFs7wyBLec9xg9lqxFlTmaGsg/RwafJPLLRWfs4wAV2op5JcZPyLLcafwEq
         8q4PLlRnBAiMDoxMa7Ip8Ohh5APMyDpQea+ZloFQREz5FpMWNxHIJymx4C46/PFK9ObS
         bowrM2n7q/GXrRsnxJGk8L3PRyJ51ZayjrO8q59g3a2iyCcGOkEjjYS+LsHYKOwmdLgd
         bhNLQwNz7XNnRG+8dV32zsgx2Ermvzcw6G8tkEgxH2PanGQr3UwVYB8RziFciP/q0nZq
         ItFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mo79tZbV4VO7EeFzyq6Qk9j9V7NRSOgk4h69S5xmO0=;
        b=XC1IKnI/h1HfK6YpzBLC9f5Lob2Iq/MPD7K0RhlXhoUVZonpcIa3gmS70DUWHOrhk3
         JACbAJ2kBGXQmIzrdbTduMtviUy1cBmrBzOSwGWgyXWhRF+JConcVE5t9ERXGjsHZXic
         H39pzrOui32xiIf3cqItjU54ZQh0qJAMbet/2cyzakKB67pDgrZCl6fb5fq/8e+LTXjy
         sH/4E9A1+addF33aQ2Sb9IQkec+A7i9XanXuRbUh6zEHAYF69Qalh51PYhhwBaTVsIzn
         SqOE0HgfHPaI7hRg2loAkYLy81WtPkXsyNZEViC0/O78LRFxOfNZGcfxnbUezA5YfALB
         4+oQ==
X-Gm-Message-State: AO0yUKXEeV3WIZuBw+oJZ0PKdUd8XgupS4eq8ZdOtntBmmZ6LYW+LFub
        uskgP3WUDzdTw4/suzJGT3k=
X-Google-Smtp-Source: AK7set+FL14Fg5lGEEiyyV5HNVYzPcOH3NDNaDM/l20tfbyRtrIPubGz1czIjE80c9Lv0PXyWz+1fg==
X-Received: by 2002:a5d:6843:0:b0:2bf:dcfb:b58a with SMTP id o3-20020a5d6843000000b002bfdcfbb58amr12966419wrw.68.1675955316097;
        Thu, 09 Feb 2023 07:08:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q12-20020adffecc000000b002c3ea9655easm1417436wrs.108.2023.02.09.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:08:35 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 16:08:33 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, acme@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <Y+UMcU+SvQzh89M9@krava>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 01:28:51PM +0000, Alan Maguire wrote:
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
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
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
> 
