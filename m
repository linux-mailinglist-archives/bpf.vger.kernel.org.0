Return-Path: <bpf+bounces-2813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9192D73463A
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D491C20A08
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778D1C10;
	Sun, 18 Jun 2023 13:07:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20839184C
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 13:07:58 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F5B2
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 06:07:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso2682415e9.3
        for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093675; x=1689685675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK3LBjvilWw0AqPXsXk5HVM7EtqTfxLkPHLLU8xSkuo=;
        b=kB2hwK9qtkWvFpq265uIyIbiYcnmSmeoLlRba40ZTI9jZlupUnosMPzTa47/Umd7Xy
         33dlpqhctM1B0XanDgVMj36kDMeyZvExsXnafNMpRnrjaQZlGS2uB4tdq9OpZb8vz9k4
         pmc4gxiXBDyxY2PP6By+wcomWAo0tjZlcnBTb5tK4tqey2csXcnMM0J+OqIQPvosWCla
         0qGVl+tk9JfnaEDp02jtFEfTRLRW2hNwkAU8ms7WqER3E1kQMccsiE2TWlZhd5HQ1F2B
         pNo3adqQ9GIB8Ss/vA8FoORgTGiIMmd7wA2VSdb7RwdQ4jFPj2CYRiZA+cw0yTnu3iWs
         zl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093675; x=1689685675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK3LBjvilWw0AqPXsXk5HVM7EtqTfxLkPHLLU8xSkuo=;
        b=T7xdZV+WWecU/lRdPg3MmlGRmhPECYlcPaFZ5jn3U+JXkrlwIfQmgCqJTH0/yvOYWt
         GnxeWb5/ejOXnLGr7vZePhybLcefW/jID41d+8asnFhYuEKZwxNZZ79VraRMS5ZPW/XP
         WoA4Nv6YrryWvhspmCk5XNMBUGwyOcG4OY9bvsyi0T3XrOuG0xi23TmDgoYqtMSCHxJe
         +UuQ3z+xstxe4BKJzKG3FCztuZsHmLp+JVRTZB1cLgopGzt3XTIclJw2EdirC3vicpQ+
         oUo+JtkfaU6jDTkRWNGnks6eAXn3wJGn7o4NE+ajSdZWeGSpnbF++A5PXvvzq+DlPVNA
         Y6XA==
X-Gm-Message-State: AC+VfDw/1cy596PB2hvUM2D8slDX0E1kXLQ9ItpR2AZ5kmQ+ov+R56QD
	QOtDDssobtiqlBDmwiZXePo=
X-Google-Smtp-Source: ACHHUZ66fl6V5G1rXMPL/dBErpDQuflH8Et5Np3woMFBnmNuGBIs+gAPOTVD+lDzL/hhjSv0i50lzA==
X-Received: by 2002:a7b:c84f:0:b0:3f8:fed0:1c5c with SMTP id c15-20020a7bc84f000000b003f8fed01c5cmr3752493wml.8.1687093675375;
        Sun, 18 Jun 2023 06:07:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f908ee3091sm3050722wmi.3.2023.06.18.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:07:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 18 Jun 2023 15:07:51 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, quentin@isovalent.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 6/9] btf: generate BTF kind layout for
 vmlinux/module BTF
Message-ID: <ZI8Bpy0XPedXTJY1@krava>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-7-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616171728.530116-7-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 06:17:24PM +0100, Alan Maguire wrote:
> Generate BTF kind layout information, crcs for kernel and module BTF
> if support is available in pahole.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/pahole-flags.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 728d55190d97..cb304e0a4434 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -25,6 +25,13 @@ if [ "${pahole_ver}" -ge "124" ]; then
>  fi
>  if [ "${pahole_ver}" -ge "125" ]; then
>  	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> +	pahole_help="$(${PAHOLE} --help)"

nice ;-)

> +	if [[ "$pahole_help" =~ "btf_gen_kind_layout" ]]; then
> +		extra_paholeopt="${extra_paholeopt} --btf_gen_kind_layout"
> +	fi
> +	if [[ "$pahole_help" =~ "btf_gen_crc" ]]; then
> +		extra_paholeopt="${extra_paholeopt} --btf_gen_crc"
> +	fi

do we need to have an option to enable crc? could it be by default?

it's sort of related to the layout changes and I wonder we will want
'not to have it' if there's support for it in BTF

jirka

>  fi
>  
>  echo ${extra_paholeopt}
> -- 
> 2.39.3
> 

