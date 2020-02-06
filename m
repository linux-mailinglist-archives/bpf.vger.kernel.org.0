Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959EE154A8E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2020 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFRw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Feb 2020 12:52:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33182 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Feb 2020 12:52:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so1395845wmc.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EZIy1nOA8K0L0vhQAmHHSgkRpVJtZhSYMUdCC/VZJVs=;
        b=kEScl9tCaKP/qVM+f5zKY1C/+RK0uYkAV66JWpIm/Tx0jw5PNuQZj+9v9yI7C49kpa
         mx9SJ0Znwi4YX7uO6wD14S6o9RAVctMYQxtYGNL2Wb6BOn3TOnGdHyA9y+wd5b6gcHoH
         rea6SrnBtg4ySUvtoh3zipt/oa1RldCjH9FSCcBD+KGtocVXDpJ7lmhvZhR3/PDD07PK
         zukU0aslfdso76t7wsl6Bp/URmI2++hofBFUbRNBAJNtRpIOiDM9uxpTk1r7/vnLJwyr
         hdwKb/5WZfXP4brfZm5q4hqORp+YKhzPV2RKGZIlT3oWbevpYeLiB43Ie0lIOYvQYc65
         xN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZIy1nOA8K0L0vhQAmHHSgkRpVJtZhSYMUdCC/VZJVs=;
        b=URsJmDAPbm5ts5zBR2uSDlZDqN+3L9X1cDlJSyoYJpZvpUQ4VQmUWUhGqtnpsY4lhm
         Pm/BylcFQ6hEnDuDPlnF9jKaXIkh20uC3KghMjQRswvtjV2hNPH8qiVsqjOZ5sneIBsM
         4RdTLIpdLR5O7IAnuZaPatpO+SENw7ux3C7IUxnqALmS4t74spbeQo1/VQbBu5BFRhJy
         Ps7PtgElbNXc1zgamsh5y4n9ib0J7nNmG27qFn5eEBVQ+6m9HipybDQd33zkSAxiUqXC
         V/7LzXLsM1C7CwkdBOad5gKQV4q0kwt6VNHLhF+vJwlKh1hDKTqS/URpJl2cufRnat3v
         wrAw==
X-Gm-Message-State: APjAAAWYi/0zMnFgbdhmKHo/BG3voPPj8P4gOsES60aGvkJhBh2pZH+A
        vbBhZOVxXYKb5W5dTcMaGbY22CR679hYfA==
X-Google-Smtp-Source: APXvYqytj9rLYPKVH0l2w6piVLQDo4vowmiLUacwx2yMvQYZmW9cHjJpjuB5WxY76qyo7jabccEqgA==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr5668007wmb.38.1581011542708;
        Thu, 06 Feb 2020 09:52:22 -0800 (PST)
Received: from ?IPv6:2001:1620:665:0:d4b6:f719:ed17:25fe? ([2001:1620:665:0:d4b6:f719:ed17:25fe])
        by smtp.gmail.com with ESMTPSA id o4sm47088wrw.15.2020.02.06.09.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 09:52:22 -0800 (PST)
Subject: Re: [PATCH bpf] bpftool: Don't crash on missing xlated program
 instructions
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        daniel@iogearbox.net, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20200206102906.112551-1-toke@redhat.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <3faff584-3139-9ff1-c083-c0c4569fa81c@isovalent.com>
Date:   Thu, 6 Feb 2020 17:52:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206102906.112551-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-06 11:29 UTC+0100 ~ Toke Høiland-Jørgensen <toke@redhat.com>
> Turns out the xlated program instructions can also be missing if
> kptr_restrict sysctl is set. This means that the previous fix to check the
> jited_prog_insns pointer was insufficient; add another check of the
> xlated_prog_insns pointer as well.
> 
> Fixes: 5b79bcdf0362 ("bpftool: Don't crash on missing jited insns or ksyms")
> Fixes: cae73f233923 ("bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   tools/bpf/bpftool/prog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a3521deca869..b352ab041160 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -536,7 +536,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>   		buf = (unsigned char *)(info->jited_prog_insns);
>   		member_len = info->jited_prog_len;
>   	} else {	/* DUMP_XLATED */
> -		if (info->xlated_prog_len == 0) {
> +		if (info->xlated_prog_len == 0 || !info->xlated_prog_insns) {
>   			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
>   			return -1;
>   		}
> 

The fix looks good, thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
