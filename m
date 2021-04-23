Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348E4369D3A
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 01:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhDWXVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 19:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDWXVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 19:21:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6DCC061574;
        Fri, 23 Apr 2021 16:20:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j18so79852545lfg.5;
        Fri, 23 Apr 2021 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UN8lYvlKUzpGJek5kJqkHzoy2ZYGZ4aTnHDgEtVTayM=;
        b=rXLBPSZRXvl9Kk1/3AHQhPGnzostRWdh7HABhjmDlzUjX5udG44hCk4MbfdqX6uPo2
         PYscHCDO/+sKSfGbM3avr5mRCZ8WFBtc0Z0ATCPn8G5TEh4064n8BMNFA0jqdzRh13ZW
         MSrd2sQqufJEjs+TDdMZp0JEmf22YhON4qfyM1bdBERhMfSG2nohLxSfiA/FhRGoGgpI
         Y2gNuaoWFKlfrN2qWez9hVRTkkq6VSvAJsTC/CClt5C5RJ5oBZLrpzVhQHI+C5Du3zFy
         OjlmKnvvorzJxwvCQPL3NMzAHCr3Zwn9qBRtpQ0x23aIZpGutKqDVO6Mj2LNl12cTc6P
         aF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UN8lYvlKUzpGJek5kJqkHzoy2ZYGZ4aTnHDgEtVTayM=;
        b=dbfrpZREn/OmbB1PknOVapvU8938Ec+if4H54e/FOmkJflhDPw+tQfTAwvfoylCcLK
         wXOVcNbAOHrlJiGNFG6W0GnV7J+JMU5NGwgR/X9DBwp8xclDgkXGGBK/YhikTWxs0QqC
         TshrBJteas81/uwDNoTe6/vtqzHIcPMkLqgMga2sGasTSS5dQMvQtpSHAbTW0QfRHbpO
         EHjdkkEIcbROJD5MJWbESw5rsoero+0Sj9pwJsPvTW6j6yY6lhUiF3BcyrY2CynjqCLE
         U3loZg9K3drksgwDorjzRYg9EYZOq7mcQFp3wlUBHOXxcwJucoTMuajr4InUnJsf+E/2
         fhHg==
X-Gm-Message-State: AOAM530XTSLAe3qqL/Z5NOU6aFfgdJr4JStspTI7mAZZQAUZqwPz6rpw
        guKxBlN2qYCEiijQAANHYZAOulrT9XK/di6GnUtdH/YX
X-Google-Smtp-Source: ABdhPJy+70NSFI9yiV1Zf3vRjNCfAKy81SYuXmcSHJyyJH0sQcP51VADEaYyP+gGwB2TgfrCZaEodsB6Qo91uike2qI=
X-Received: by 2002:a19:f615:: with SMTP id x21mr4550232lfe.540.1619220037606;
 Fri, 23 Apr 2021 16:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
In-Reply-To: <20210423230609.13519-1-alx.manpages@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Apr 2021 16:20:26 -0700
Message-ID: <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
Subject: Re: [RFC] bpf.2: Use standard types and attributes
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, libc-alpha@sourceware.org,
        gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 23, 2021 at 4:15 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Some manual pages are already using C99 syntax for integral
> types 'uint32_t', but some aren't.  There are some using kernel
> syntax '__u32'.  Fix those.
>
> Some pages also document attributes, using GNU syntax
> '__attribute__((xxx))'.  Update those to use the shorter and more
> portable C2x syntax, which hasn't been standardized yet, but is
> already implemented in GCC, and available through either --std=c2x
> or any of the --std=gnu... options.
>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>  man2/bpf.2 | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/man2/bpf.2 b/man2/bpf.2
> index 6e1ffa198..204f01bfc 100644
> --- a/man2/bpf.2
> +++ b/man2/bpf.2
> @@ -188,39 +188,38 @@ commands:
>  .EX
>  union bpf_attr {
>      struct {    /* Used by BPF_MAP_CREATE */
> -        __u32         map_type;
> -        __u32         key_size;    /* size of key in bytes */
> -        __u32         value_size;  /* size of value in bytes */
> -        __u32         max_entries; /* maximum number of entries
> -                                      in a map */
> +        uint32_t    map_type;
> +        uint32_t    key_size;    /* size of key in bytes */
> +        uint32_t    value_size;  /* size of value in bytes */
> +        uint32_t    max_entries; /* maximum number of entries
> +                                    in a map */

Nack.
The man page should describe the kernel api the way it is in .h file.
