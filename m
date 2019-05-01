Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D856108A6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2019 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEAOCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 May 2019 10:02:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEAOCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 May 2019 10:02:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so4965484wrr.13
        for <bpf@vger.kernel.org>; Wed, 01 May 2019 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwsO2wFjZO2vvYlbEHyzdno1Dpggj2I7OM8g4T68ZR8=;
        b=wnTExwJyZzK+XA1MJcx4Vm1SICd5aDt9tZg/ErnfQ4XbXW+xQcSGAaVaVCNWa0QTcC
         aKohWqX3FEKfuNzJkNyiPDzrPyZfVe/EjCkN03lnOGzVgpzMo/tbUMvWXJHMUvN7fOmo
         85cy8+7hkbSADq61UFQxm3y5t6BQeFJ2MgFjZVryYxb18sIHhJoWDg9ir/W9ga6EpWa3
         1ftnI/dhzftaVhAOA1Wx7sGjNiRgD+2CxARoF2zEragj1DHq+xZF21kBFwiWB911YrVt
         wUbgkZKEo3/PFzDe4+0rplTs9GHLimUWiAlatA8d0FhLwMwRZXlQvua+GPcbk4CJA3X4
         WLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TwsO2wFjZO2vvYlbEHyzdno1Dpggj2I7OM8g4T68ZR8=;
        b=tfkMWjHQ/GYTydjP/82nUMzhBVhkDAR6nmEsPLpeu4dgwL2/Q8BTEKEprwi1B7uLNQ
         5moipYhXXeAyx9CHa9dWGFajAmtnm4u7vFrsDv2i5Bn1aRO4ks/pv32ubluLFay1o1J2
         UVZ8fq59jqho2iFEDGv40MwKjvUb+9UD9A8qBC/VIKRXiS+6KAOXICQoK1B3vaAofiVw
         6Vj8rL+3t68HE4dRamTMksfp9Sje3VimFNiWkNHgh+/T1QguJgBS+QbA4BaaBYWqyxZG
         y1FMCnSpeDmiHC7bwZV+yyxtHOXUejNGGmKTVqI5TWAzRzsecQFthecpiJGm/dVhHeVf
         uZVQ==
X-Gm-Message-State: APjAAAX0zq9N0zOo3Q08o0bC+bCH43u2WrTAq/sDH288h3KGwqTvI0v7
        hS5NOxs38yYSs0aMkRz/sQb5DJY+c44=
X-Google-Smtp-Source: APXvYqzjwuQ0bO4MsykfOZ//x/l/XUt08HE+WQ7h8mp0msWbAvZrrvU072ThfM4+YRD53yNX62wYYQ==
X-Received: by 2002:adf:92e2:: with SMTP id 89mr15436366wrn.53.1556719348220;
        Wed, 01 May 2019 07:02:28 -0700 (PDT)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p18sm32119901wrp.38.2019.05.01.07.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:02:27 -0700 (PDT)
Subject: Re: [PATCH v2] bpftool: exclude bash-completion/bpftool from
 .gitignore pattern
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Sirio Balmelli <sirio@b-ad.ch>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
References: <1556718359-1598-1-git-send-email-yamada.masahiro@socionext.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <b550f762-5324-0bdb-7097-6bcf354b6d67@netronome.com>
Date:   Wed, 1 May 2019 15:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556718359-1598-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-01 22:45 UTC+0900 ~ Masahiro Yamada <yamada.masahiro@socionext.com>
> tools/bpf/bpftool/.gitignore has the "bpftool" pattern, which is
> intended to ignore the following build artifact:
> 
>   tools/bpf/bpftool/bpftool
> 
> However, the .gitignore entry is effective not only for the current
> directory, but also for any sub-directories.
> 
> So, from the point of .gitignore grammar, the following check-in file
> is also considered to be ignored:
> 
>   tools/bpf/bpftool/bash-completion/bpftool
> 
> As the manual gitignore(5) says "Files already tracked by Git are not
> affected", this is not a problem as far as Git is concerned.
> 
> However, Git is not the only program that parses .gitignore because
> .gitignore is useful to distinguish build artifacts from source files.
> 
> For example, tar(1) supports the --exclude-vcs-ignore option. As of
> writing, this option does not work perfectly, but it intends to create
> a tarball excluding files specified by .gitignore.
> 
> So, I believe it is better to fix this issue.
> 
> You can fix it by prefixing the pattern with a slash; the leading slash
> means the specified pattern is relative to the current directory.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add more information to the commit log to clarify my main motivation
>   - Touch "bpftool" pattern only
> 
>  tools/bpf/bpftool/.gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
> index 67167e4..8248b8d 100644
> --- a/tools/bpf/bpftool/.gitignore
> +++ b/tools/bpf/bpftool/.gitignore
> @@ -1,5 +1,5 @@
>  *.d
> -bpftool
> +/bpftool
>  bpftool*.8
>  bpf-helpers.*
>  FEATURE-DUMP.bpftool
> 

Thanks a lot for the changes!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
