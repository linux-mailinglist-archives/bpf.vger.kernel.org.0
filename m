Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA34E7E73
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 02:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiCZBkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 21:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZBkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 21:40:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430512DC0
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 18:38:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa43so18465505ejc.12
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QdR8xs1BXss5liXClX/zpGEpc9aCfA/Xn/lpmQm3R90=;
        b=JqKN2K4SfjXCV8Q1qEoRAtvzKwrnV8NmgQM2L41ZzLcs2oXG1VuMZvDKwVmWBzvQhv
         cBL3h8dy0zPJ/fTAL0V9WK1U3cKUPpP5P78f8AaTzYmoGVq+TpnZ8tJWFJQ/I/nA5MGN
         JQ7peVfloXcUu//0fuarsG+GO+bsKGTT7Z83Rd98ZgNOWat2k3Zc1pir0mm5t1bpHc+G
         5kjbYtzmtNeiOWAObck+tU2Za9VXfesBoq6zk5iGwLpu6RJ/RTCXQlsBU8oeAjLQeegn
         mRCZZ8NI7L38pX7OZYHht4Exg6S7kSksiStOZ+dbgwi0XIHo2We/tq7uEYVVftSJMJZE
         NAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QdR8xs1BXss5liXClX/zpGEpc9aCfA/Xn/lpmQm3R90=;
        b=sqzpWB7sFwtV4NbDlTmF2xn2sdeHti9Vl5hpCfD6rYAV0TH2oAtyjzjsq1/yDtNZFI
         fpkyj2CmVBnV8a04IhbJkcy6a8IOs8L7f1r/6eIumZCyrK9kYBEbqa+ZT0PvFkzUK9Gm
         tqqYugvwCG11Gvvx19jgca9chHLWjak5p6ulW9N8QFyfbz7yb+g1aww54FD3cVFI+oMB
         zQy+G9AD5qDn9G6tjuTwU3hxaeXsgOPSl2Al+bOpgTSRjkNN/sz8RHt+ZKvH+nJkBdud
         XzfYbm0fouoMGI+xRWPqJBF/ksRXJoeFG62hTCRe1Hjv/Z51IhHo0qGT76e1J0QOF8Mj
         EZ9g==
X-Gm-Message-State: AOAM531pR5QrCoOSbIpFzkbZlc4inRJkkf4Q43kYmgbGOujH4QvRJrHf
        6BXU/Q+ZwqDgViMIUOriKNrfNw==
X-Google-Smtp-Source: ABdhPJypIdG2yfG653pOHEv3gUXA41pmDz5IhQHNY6jWa6qiDplul0zKjPSpAAhCOzIsnLPxUmdJ6A==
X-Received: by 2002:a17:907:2cc6:b0:6e0:1ae5:d762 with SMTP id hg6-20020a1709072cc600b006e01ae5d762mr15359085ejc.291.1648258717815;
        Fri, 25 Mar 2022 18:38:37 -0700 (PDT)
Received: from [192.168.100.212] (212-147-51-13.fix.access.vtx.ch. [212.147.51.13])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709060f5400b006d6d54b9203sm2963282ejj.38.2022.03.25.18.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 18:38:37 -0700 (PDT)
Message-ID: <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
Date:   Sat, 26 Mar 2022 01:38:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
Content-Language: en-GB
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
References: <20220309163112.24141-1-9erthalion6@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220309163112.24141-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-09 17:31 UTC+0100 ~ Dmitrii Dolgov <9erthalion6@gmail.com>
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
> 
> Implemented using the pid iterator BPF program to actually fetch
> bpf_cookies, which allows constraining code changes only to bpftool.
> 
> $ bpftool link
> 1: type 7  prog 5
>         bpf_cookie 123
>         pids bootstrap(81)
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> Changes in v6:
>     - Remove unnecessary initialization of fields in pid_iter_entry
>     - Changing bpf_cookie_set to has_bpf_cookie
>     - Small code cleanup (casting bpf_cookie when needed, removing
>       __always_inline, etc.)
> 
> Changes in v5:
>     - Remove unneeded cookie assigns
> 
> Changes in v4:
>     - Fetch cookies only for bpf_perf_link
>     - Signal about bpf_cookie via the flag, instead of deducing it from
>       the object and link type
>     - Reset pid_iter_entry to avoid invalid indirect read from stack
> 
> Changes in v3:
>     - Use pid iterator to fetch bpf_cookie
> 
> Changes in v2:
>     - Display bpf_cookie in bpftool link command instead perf
> 
> Previous discussion: https://lore.kernel.org/bpf/20220225152802.20957-1-9erthalion6@gmail.com/
> 
>  tools/bpf/bpftool/main.h                  |  2 ++
>  tools/bpf/bpftool/pids.c                  |  8 ++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 22 ++++++++++++++++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0c3840596b5a..3574bef7d4ce 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -114,6 +114,8 @@ struct obj_ref {
>  struct obj_refs {
>  	int ref_cnt;
>  	struct obj_ref *refs;
> +	bool has_bpf_cookie;
> +	__u64 bpf_cookie;
>  };
>  
>  struct btf;
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 7c384d10e95f..bb6c969a114a 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>  	ref->pid = e->pid;
>  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
>  	refs->ref_cnt = 1;
> +	refs->has_bpf_cookie = e->has_bpf_cookie;
> +	refs->bpf_cookie = e->bpf_cookie;
>  
>  	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>  	if (err)
> @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>  		if (refs->ref_cnt == 0)
>  			break;
>  
> +		if (refs->has_bpf_cookie)
> +			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
> +

Thinking again about this patch, shouldn't the JSON output for the
cookie(s) be an array if we expect to have several cookies for
multi-attach links in the future?

Quentin
