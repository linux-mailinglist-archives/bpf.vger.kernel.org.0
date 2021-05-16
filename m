Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A224381D96
	for <lists+bpf@lfdr.de>; Sun, 16 May 2021 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhEPJRq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 May 2021 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhEPJRp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 May 2021 05:17:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB3C061573;
        Sun, 16 May 2021 02:16:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c14so1483487wrx.3;
        Sun, 16 May 2021 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQkgxljzQQB7pnefvOdRST34zIuUrZPO5z5eBQxWx7Y=;
        b=fgXWDFJR/PFQqQ9jJDaJBuG8eMUXoO77LvGoQBITVNOPqzEn9Wom8EJyOOvhEdFoL8
         Qo0/p0zXAEH7JztUqDgEhku3RXQHS3EgU+PeNcHECop76KD6bBAD4izxo/EX7KqJKJyd
         Q7NeHmHtz5mCwtPmGqoLMENMKCIf1d2TrghDi+YxQtHlhhEBDWiKhmvC+ghrvxJ4fsHN
         qU1fuUikcAH/KJb8XPvEGNrWn/MbRoYlQR0U63VoXT6jnQlUO2nf6erDCxp5DC6cFUQf
         d4D26ILvVE/2dE98W9liud0u3gH1GxWqXjXo4t40ZDnb/UzR06ijF+Z43QRaaruUduHp
         AiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQkgxljzQQB7pnefvOdRST34zIuUrZPO5z5eBQxWx7Y=;
        b=Yqp/8JvbsWzxS2f88CcfiPv1uV51KsAt76ioNrQ2oVp5lsdWHcs/8dbErDSZNPpAYe
         o9VAtHOQ2whw5nKU5KbczNFMACrH7Rqb86GijS1iAqd6yYj92WIHQxEZ6Y+Q6hGrQn6v
         2rHgnxPkKkqE/7wLQU0wJQ8YwI9oVAh2etuT3jr7G+XKLYtlGP9xJP775QgMjdS6J2pF
         PUgOywQEvlLAGEyWCsNwRyV6Gc+8oAQTN55Hhu5sNAV9+u2s3lvxodXhIypRR+QMHqkj
         0f04+OVx8HuuDiGsJykW4vO5PW1WgLJ++wL/qSycsG6POVsmDDQaU+G/DtlIqM8RI5eu
         bbeA==
X-Gm-Message-State: AOAM530SyTHWdjrJDgLDi5sxfi+EEYKdGe+GZtZeHA2wbjUgq+OagyMw
        L7vgO14m1ED22aOQlLQlbtg=
X-Google-Smtp-Source: ABdhPJwN2T387T+WgdAnQoy6wjuwA0hW17gTIuznmwnZUI2yWtfxnqPCqeIcZStFadA0n6vfY9RSiA==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr10469982wrq.192.1621156588415;
        Sun, 16 May 2021 02:16:28 -0700 (PDT)
Received: from [10.8.0.106] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id j7sm10311876wmi.21.2021.05.16.02.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 02:16:27 -0700 (PDT)
Subject: Re: [PATCH v3] bpf.2: Use standard types and attributes
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <20210515190116.188362-1-alx.manpages@gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <9df36138-f622-49a6-8310-85ff0470ccd6@gmail.com>
Date:   Sun, 16 May 2021 11:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210515190116.188362-1-alx.manpages@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/15/21 9:01 PM, Alejandro Colomar wrote:
> Some manual pages are already using C99 syntax for integral
> types 'uint32_t', but some aren't.  There are some using kernel
> syntax '__u32'.  Fix those.
> 
> Both the kernel and the standard types are 100% binary compatible,
> and the source code differences between them are very small, and
> not important in a manual page:
> 
> - Some of them are implemented with different underlying types
>    (e.g., s64 is always long long, while int64_t may be long long
>    or long, depending on the arch).  This causes the following
>    differences.
> 
> - length modifiers required by printf are different, resulting in
>    a warning ('-Wformat=').
> 
> - pointer assignment causes a warning:
>    ('-Wincompatible-pointer-types'), but there aren't any pointers
>    in this page.
> 
> But, AFAIK, all of those warnings can be safely ignored, due to
> the binary compatibility between the types.
> 
> ...
> 
> Some pages also document attributes, using GNU syntax
> '__attribute__((xxx))'.  Update those to use the shorter and more
> portable C11 keywords such as 'alignas()' when possible, and C2x
> syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
> yet, but is already implemented in GCC, and available through
> either --std=c2x or any of the --std=gnu... options.
> 
> The standard isn't very clear on how to use alignas() or
> [[]]-style attributes, and the GNU documentation isn't better, so
> the following link is a useful experiment about the different
> alignment syntaxes:
> __attribute__((aligned())), alignas(), and [[gnu::aligned()]]:
> <https://stackoverflow.com/q/67271825/6872717>
> 
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Discussion: 
<https://lore.kernel.org/linux-man/6740a229-842e-b368-86eb-defc786b3658@gmail.com/T/>
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Zack Weinberg <zackw@panix.com>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: glibc <libc-alpha@sourceware.org>
> Cc: GCC <gcc-patches@gcc.gnu.org>
> Cc: bpf <bpf@vger.kernel.org>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Joseph Myers <joseph@codesourcery.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/man2/bpf.2 b/man2/bpf.2
> index 6e1ffa198..04b8fbcef 100644
> --- a/man2/bpf.2
> +++ b/man2/bpf.2
> @@ -186,41 +186,40 @@ commands:
>   .PP
>   .in +4n
>   .EX
> -union bpf_attr {
> +union [[gnu::aligned(8)]] bpf_attr {
>       struct {    /* Used by BPF_MAP_CREATE */
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
>       };
>   
> -    struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY
> -                   commands */
> -        __u32         map_fd;
> -        __aligned_u64 key;
> +    struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY commands */
> +        uint32_t            map_fd;
> +        uint64_t alignas(8) key;
>           union {
> -            __aligned_u64 value;
> -            __aligned_u64 next_key;
> +            uint64_t alignas(8) value;
> +            uint64_t alignas(8) next_key;
>           };
> -        __u64         flags;
> +        uint64_t            flags;
>       };
>   
>       struct {    /* Used by BPF_PROG_LOAD */
> -        __u32         prog_type;
> -        __u32         insn_cnt;
> -        __aligned_u64 insns;      /* \(aqconst struct bpf_insn *\(aq */
> -        __aligned_u64 license;    /* \(aqconst char *\(aq */
> -        __u32         log_level;  /* verbosity level of verifier */
> -        __u32         log_size;   /* size of user buffer */
> -        __aligned_u64 log_buf;    /* user supplied \(aqchar *\(aq
> -                                     buffer */
> -        __u32         kern_version;
> -                                  /* checked when prog_type=kprobe
> -                                     (since Linux 4.1) */
> +        uint32_t            prog_type;
> +        uint32_t            insn_cnt;
> +        uint64_t alignas(8) insns;     /* \(aqconst struct bpf_insn *\(aq */
> +        uint64_t alignas(8) license;   /* \(aqconst char *\(aq */
> +        uint32_t            log_level; /* verbosity level of verifier */
> +        uint32_t            log_size;  /* size of user buffer */
> +        uint64_t alignas(8) log_buf;   /* user supplied \(aqchar *\(aq
> +                                          buffer */
> +        uint32_t            kern_version;
> +                                       /* checked when prog_type=kprobe
> +                                          (since Linux 4.1) */
>   .\"                 commit 2541517c32be2531e0da59dfd7efc1ce844644f5
>       };
> -} __attribute__((aligned(8)));
> +};
>   .EE
>   .in
>   .\"
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
