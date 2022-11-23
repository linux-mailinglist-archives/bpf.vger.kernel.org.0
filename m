Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059B6636C56
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiKWVXf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiKWVXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:23:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168547306
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:23:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so59435ejb.9
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EBWbHMbJYZtdSNEQOZTLm0iPaHAt4aAaHH+EWiX4qe0=;
        b=R33K1gXgF9JzhQDbociXjDTSzPjICjKRwj58jFhcE1s/5LPAymkNV/tC79Mz0zC92Z
         uxiubvFkoNtNvFbLewFZz0/IxI5EbjY5dUeFFoihOAzyrqZp2zOtnJokKAEQT+6F+GDN
         9WpJwjscYFnnW/MJS1gChc6wsB8uq5iraEq/WzY8UqVk5LbzQVJhQxf3hTKk/3lbUYPJ
         z0IvgwpNUu3t47PZa8UYCfMvOZ5Y+4sY1mjBwx5+3AdySxSr+buVD9SDEDnDmAdETYpu
         +fRxQVfSD6Mae++lzf8diSEojJPR+S3FythtzOXstXiCd5lFJ6RfN4ZX0ekqEXgSiMk+
         IpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBWbHMbJYZtdSNEQOZTLm0iPaHAt4aAaHH+EWiX4qe0=;
        b=nZQyP5izKRPKktDLokOl4cS3IZS31mZDWEnUfkmPUttaApcLEDcwVXEw1loFPGHcBZ
         aW4dsgdxwbVX032ewPrgnS7aeU+ZAKlmYHn+XdObSNrA9qj8tGwe8o1f5/C3yad4irbQ
         IXNB4ERTkvdCpGbRAVcsAaCZI/7r3s6ugbrPTHZsSCuXF8H6rytLye8tZj1I/Qe1m+y7
         sD1ehMOC8j4nu/eD//A+qpnJ7fYlx+ERWEG+LgrXGcIwTjnBHQBLnNPwb4ai3cVW+g0B
         WMHLRtsnbBIAGOw6uSOHSahuMriCehBZNHdEfbh1mLfifLZ4+cipf8dE0SN/KROzFWSw
         A3IQ==
X-Gm-Message-State: ANoB5pmYaigVSCJe5zFvRx8ny+EqvAOdEsx32xeBctakBcxJuXKudPAf
        iB+YC/+EVaDGFsEBkm75Qbl4QMHiEuNJIiE/Sw0=
X-Google-Smtp-Source: AA0mqf77eoRLnAAxiNAr3EVuLE3ye1AyciR47ebRzz3K4/ENR/8of/O/SLGxoLgvqrDkCcdX20vHXyKFt5OmCE6pQto=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr11560980ejm.708.1669238610271; Wed, 23
 Nov 2022 13:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123155759.2669749-1-yhs@fb.com>
In-Reply-To: <20221123155759.2669749-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 13:23:19 -0800
Message-ID: <CAADnVQKD+pW00bJ=fNE==hLqckGMWJhvk1q082mZdROQ0-rL+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a BTF_ID_LIST bug with
 CONFIG_DEBUG_INFO_BTF not set
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 7:58 AM Yonghong Song <yhs@fb.com> wrote:
>
> With CONFIG_DEBUG_INFO_BTF not set, we hit the following compilation error,
>   /.../kernel/bpf/verifier.c:8196:23: error: array index 6 is past the end of the array
>   (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
>         if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
>                              ^                  ~~~~~~~~~~~~~~~~~~~~~~~
>   /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
>                             ^
>   /.../kernel/bpf/verifier.c:8443:19: error: array index 5 is past the end of the array
>   (that has type 'u32[5]' (aka 'unsigned int[5]')) [-Werror,-Warray-bounds]
>                  btf_id == special_kfunc_list[KF_bpf_list_pop_back];
>                            ^                  ~~~~~~~~~~~~~~~~~~~~
>   /.../kernel/bpf/verifier.c:8174:1: note: array 'special_kfunc_list' declared here
>   BTF_ID_LIST(special_kfunc_list)
>   ^
>   /.../include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>   #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
>   ...
>
> Fix the problem by increase the size of BTF_ID_LIST to 8 to avoid compilation error
> and also prevent potentially unintended issue due to out-of-bound access.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/btf_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index c9744efd202f..71d0ce707744 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
>
>  #else
>
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[8];

Changed it to 16 while applying so we don't have to bump it
again in the near future when another special kfunc is added.
