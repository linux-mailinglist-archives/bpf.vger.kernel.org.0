Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6556903F3
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBIJg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 04:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBIJg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 04:36:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624916321
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 01:36:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so1107142wrs.10
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 01:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDl8VkI8XUtN4bcXzAGjP9vTXc8Wru6VajIxbBU9opI=;
        b=l6Hf8JRwvyiX1jhpY/IU66ALvzBg6tbusaXLW2KqQ0ZfeemJwWkc+9PT5w5nZ+KT50
         5rogTTGYdwqUeDOLBu2EjhT6b0Gcpp3mqOgEihyYRaC5uRhqC7S1XoegjCX/J32jw01h
         nzaoE9Rsa+TCAhGZeXj0tqeLqwfXFT5KuhU8j4IIAOyD0mIBqxeAFA25SjX0UiHIVzME
         Fut29nUfqaXWRl97mlIt8+jnuccoEwdJ0D2OAprODDLRalqDnrKNzLtA/9G4xpuTMpEF
         xryhTZrkBm7R/ZoEpqi7F7KUMJy6qAcPBVNpWMok51dEerzDNKHUffGboolLlNA88A/f
         BZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDl8VkI8XUtN4bcXzAGjP9vTXc8Wru6VajIxbBU9opI=;
        b=hhrAoffEFPV7HUouD4H6vHwnk4T9118+TWyW2+XXC/AIFYAJuZbH9zRTE/mZW74Doa
         XDMxHar2wxQzlx3sPeqbKTSKW89k2640Rvkv4SArD47AzFXNoPh32t6bbmqVu9/lGkxZ
         AJ1oEHjUrh6aRDs34hfKdhVGa9qNW0stw/yV1XUeASV2MZ2STekHHPdUcIXcL14sk2nz
         JtijwB7bNwkF1wcgkc/UJ7ejJYQHByuDG28vaWYBUJG6h8zUnLdm0pJVK2xr03RmQ0lG
         su5HFAfIN879gnTWAHU+94Jd1ubv6+1MB2f5JfsPAq/qaKNVydNg9pL9MgjAT/z0NyOS
         kRvw==
X-Gm-Message-State: AO0yUKX+ecVTbctkvmspbhTlIljXMrQupejPJl6Lok6W3L7w9YS81gPU
        vfTinV9YGRaOuP3Yx5Gwzoc=
X-Google-Smtp-Source: AK7set+rHhkVh/+12MFKZRDJZoul6KS2cFy92jfXmN+9UzUSUM3lP1rQjDYRPuwQOXvBOjLObwDLaw==
X-Received: by 2002:a5d:50cf:0:b0:2c3:e5fa:d5d2 with SMTP id f15-20020a5d50cf000000b002c3e5fad5d2mr12325217wrt.50.1675935413765;
        Thu, 09 Feb 2023 01:36:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002c53cc7504csm514425wri.78.2023.02.09.01.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:36:53 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 10:36:51 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 0/8] dwarves: support encoding of
 optimized-out parameters, removal of inconsistent static functions
Message-ID: <Y+S+s0a8ym6/f+Z1@krava>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <Y+PL18hvJ7WwncGR@kernel.org>
 <Y+PS01eC1i75nBM0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+PS01eC1i75nBM0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 01:50:27PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 08, 2023 at 01:20:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Feb 07, 2023 at 05:14:54PM +0000, Alan Maguire escreveu:
> > > At optimization level -O2 or higher in gcc, static functions may be
> > > optimized such that they have suffixes like .isra.0, .constprop.0 etc.
> > > These represent 
> > >     
> > > - constant propagation (.constprop.0);
> > > - interprocedural scalar replacement of aggregates, removal of
> > >   unused parameters and replacement of parameters passed by
> > >   reference by parameters passed by value (.isra.0)
> > 
> > Initial test, without using the new options:
> > 
> > [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | tail
> >       3 start_show
> >       3 timeout_show
> >       3 uuid_show
> >       4 m_next
> >       4 parse_options
> >       4 sk_diag_fill
> >       4 state_show
> >       4 state_store
> >       5 status_show
> >       6 type_show
> > [acme@pumpkin ~]$
> > 
> > Now I'll use --skip_encoding_btf_inconsistent_proto and --btf_gen_optimized
> 
> With:
> 
> ⬢[acme@toolbox linux]$ git diff
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 1f1f1d397c399afe..9dd185fb1ff1fc3b 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -21,7 +21,7 @@ if [ "${pahole_ver}" -ge "122" ]; then
>  fi
>  if [ "${pahole_ver}" -ge "124" ]; then
>         # see PAHOLE_HAS_LANG_EXCLUDE
> -       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust --btf_gen_optimized --skip_encoding_btf_inconsistent_proto"
>  fi
> 
>  echo ${extra_paholeopt}
> ⬢[acme@toolbox linux]$
> 
> I get:
> 
> [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | tail
>       1 zswap_writeback_entry
>       1 zswap_zpool_param_set
>       1 zs_zpool_create
>       1 zs_zpool_destroy
>       1 zs_zpool_free
>       1 zs_zpool_malloc
>       1 zs_zpool_map
>       1 zs_zpool_shrink
>       1 zs_zpool_total_size
>       1 zs_zpool_unmap
> [acme@pumpkin ~]$
> 
> No functions with more than one entry:
> 
> [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep -v ' 1 '
> [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep ' 1 ' | wc -l
> 54558
> [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | wc -l
> 54558
> [acme@pumpkin ~]$
> 
> So I'll bump the release as we did in the past when testing features
> that we need to test against a release on the pahole-flags.sh script so
> that we can do further tests.

I did similar test and ran bpf selftests built with new pahole,
all looks good

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
