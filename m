Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0415A68D4
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiH3QxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiH3Qwo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:52:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7196448
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:52:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so10300798wmk.3
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fQYbCHWbiVFfVd/aiH1NG/dZPz6KpzTWHjFvZzux7k0=;
        b=H82mw0Zn1UBhbpRvBWyhIPTW2LOfTZ0SVfWdzf9Gq0m59qtc3iPUeUQ6hlfxhjN1aA
         hbezNJUffRE9YNRehSv5z7asJ/ZLZY2QCNDElv7w23rli+UnkVg60oADVm+P6IyaOS7H
         owc76Kh5c4CzsSJgD3Ya4Sw2PSiA9GVvnw7EmL42V2N3BxEseDPEmtWmJXJo9Yra3OSX
         rI1F1TqxGtfV1smA9f+bzKa5AmhzdpeJPO1gdKgTNcLbke1UEu3gImmeYZNiieilln9u
         0bhHe+y3WGg9St4jtNKDT9YF2XnhRcTqvkiiyQc9l8krurz/eOgmOPyL8q5y3dFnRdiW
         MNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fQYbCHWbiVFfVd/aiH1NG/dZPz6KpzTWHjFvZzux7k0=;
        b=YWLpR9ka7Xk3TLo/S/MZrdAW6IszaoLFXaeqjt/httxjNEOtCf0GTBzrHXwLy+QfUz
         6c1nDCIgYBXOtz0FmceJ2XCnOtURuMXxZW/HmDi1ZhQRh5clyt+CiH5/gcGNreYTqGcP
         VXCrtZypcTJsh3kcpaB8H8szvMzsqI+pQK+0Hu6YduP9lr/cdUgKpb5mVHD+TpAG/fD3
         jqYyPT85gl3EKq23w3Nm9veIPVIu2jEgaefXQ80UtP5Hyhsrt1t8cEUdiXzvQ4bva0GD
         mBEQ2EGTxiEMWLxh0nDeYim79eSyvz7CJdmztgQkiLi6tMxwW7FZOCY0mXKdAPimIE7S
         2iRQ==
X-Gm-Message-State: ACgBeo1M+rDSUnYJKQuJiSaT4y0vOcFytahhLGmgRe9zL077PYGsRHvz
        B7f2oablyf/8k/gpJZUfh5/s/w==
X-Google-Smtp-Source: AA6agR6yU0dwUJcsfZdvCkuyZWuktifd+/weY46Lfa4p8i7neGtOCZp+/ld52fy+WJU8NeH3k/V7aw==
X-Received: by 2002:a05:600c:3551:b0:3a5:dcf3:1001 with SMTP id i17-20020a05600c355100b003a5dcf31001mr10140735wmq.58.1661878334589;
        Tue, 30 Aug 2022 09:52:14 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d4b45000000b00226db764fb5sm5923136wrs.47.2022.08.30.09.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:52:13 -0700 (PDT)
Message-ID: <1b14efc0-a292-30f4-c94b-207b40818e86@isovalent.com>
Date:   Tue, 30 Aug 2022 17:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Content-Language: en-GB
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        yhs@fb.com, Hao Luo <haoluo@google.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-6-kuifeng@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220829192317.486946-6-kuifeng@fb.com>
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

On 29/08/2022 20:23, Kui-Feng Lee wrote:
> Show tid or pid of iterators if giving an argument of tid or pid
> 
> For example, the command `bpftool link list` may list following
> lines.
> 
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 33: iter  prog 225  target_name task_file  tid 1644
>         pids test_progs(1644)
> 
> Link 33 is a task_file iterator with tid 1644.  For now, only targets
> of task, task_file and task_vma may be with tid or pid to filter out
> tasks other than those belonging to a process (pid) or a thread (tid).
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/bpf/bpftool/link.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 7a20931c3250..88937036fae0 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -83,6 +83,13 @@ static bool is_iter_map_target(const char *target_name)
>  	       strcmp(target_name, "bpf_sk_storage_map") == 0;
>  }
>  
> +static bool is_iter_task_target(const char *target_name)
> +{
> +	return strcmp(target_name, "task") == 0 ||
> +		strcmp(target_name, "task_file") == 0 ||
> +		strcmp(target_name, "task_vma") == 0;
> +}
> +
>  static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
>  	const char *target_name = u64_to_ptr(info->iter.target_name);
> @@ -91,6 +98,12 @@ static void show_iter_json(struct bpf_link_info *info, json_writer_t *wtr)
>  
>  	if (is_iter_map_target(target_name))
>  		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
> +	else if (is_iter_task_target(target_name)) {
> +		if (info->iter.task.tid)
> +			jsonw_uint_field(wtr, "tid", info->iter.task.tid);
> +		else if (info->iter.task.pid)
> +			jsonw_uint_field(wtr, "pid", info->iter.task.pid);
> +	}
>  }
>  
>  static int get_prog_info(int prog_id, struct bpf_prog_info *info)
> @@ -208,6 +221,12 @@ static void show_iter_plain(struct bpf_link_info *info)
>  
>  	if (is_iter_map_target(target_name))
>  		printf("map_id %u  ", info->iter.map.map_id);
> +	else if (is_iter_task_target(target_name)) {
> +		if (info->iter.task.tid)
> +			printf("tid %u ", info->iter.task.tid);
> +		else if (info->iter.task.pid)
> +			printf("pid %u ", info->iter.task.pid);
> +	}
>  }
>  
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)

Acked-by: Quentin Monnet <quentin@isovalent.com>

Looks good to me, although this patch may conflict with
https://lore.kernel.org/bpf/20220829231828.1016835-1-haoluo@google.com/t/#u
