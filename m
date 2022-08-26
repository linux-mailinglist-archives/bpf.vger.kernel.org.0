Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B05A26CA
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHZLXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHZLXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 07:23:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14CEDB04B
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:23:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i66-20020a1c3b45000000b003a7b6ae4eb2so483512wma.4
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iiW9HHKH60rE3fHqkXbBSRRKa5pYXc8/QjvFHxqB/KQ=;
        b=OqfP4Qy4Z6vFBj9CtbpVjoPdOiU1T82CyLHxghkdBR+COz80kQmVr/jfvChqzEzuS3
         3Vki7tkIf41H9AZglSSjKa+anvUKx5Hfe0aZHnWePZwNF6U1kGqjRPXvhTI7BxAb1c/k
         i9DwHpc4DLUCuPoviMYoVaRPz7faDXPMRctWWZ06dCI09Ke7qrStPj3SU9+ohpt8dYS/
         xDX6Bovd2D9DgSDIm6uvlu8NebQijBbk6rRpH9r5RfEYwydfEb/e3abdjr9OmzW8/wl9
         q5Lbzu4gD3PgrM2fw4ye3th8Q0pBf3zic9drvz6CudxhopDYw3PVMdjuhLWDG/yeltkQ
         UuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iiW9HHKH60rE3fHqkXbBSRRKa5pYXc8/QjvFHxqB/KQ=;
        b=h+E+C7a6L0WkenjYGVGRb82OZpMCfQwTqcUVm3+nBWspOQ+BRxnnAzPwHThFv6gIh7
         VLdQqRjNcKaBnQ1Z6Hnk9R51GLLRypqpktmhQoqYoi8qMR3DC+VBNicgudPuabX1SuJf
         KGnAq0/sjcj5rMIVz3yADjyK/FplYnWVP8QMlbdHH2/le8ITeR9u04ump0HTydqfF9FJ
         KBCe+bBbDRyZpJf+1s2KAThjyyx+3LB61UYDibF2OikGh9+r5q18eHOZzhTcGQEE1V4a
         EtZcQyiQXGrf/7EBZ0YzP0tIsp/lJo/o8a+5hvXm2+RLgaZdhKtbll920eM6sIWd9jB+
         kXAw==
X-Gm-Message-State: ACgBeo1uldZlciZNN6JRyP8mvKlKOdDizH5IxQf/6vn4mfAhGipRzrxK
        79qeu1nhPTDSSwpbICkIS2Vb3g==
X-Google-Smtp-Source: AA6agR7SQOcHZ1EAo4gy1QijCfXQ+aJSXPOEcAlB0bk9n1rDeRQ0umDVD2kFVymqU80D+Z4rkxL48Q==
X-Received: by 2002:a05:600c:1c9a:b0:3a6:1c85:7a0c with SMTP id k26-20020a05600c1c9a00b003a61c857a0cmr4811654wms.155.1661512997244;
        Fri, 26 Aug 2022 04:23:17 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003a5dadcf1a8sm2507348wms.19.2022.08.26.04.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 04:23:16 -0700 (PDT)
Message-ID: <c2de50b3-4928-4a7d-6028-fd04a1aeff00@isovalent.com>
Date:   Fri, 26 Aug 2022 12:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v7 5/5] bpftool: Show parameters of BPF task
 iterators.
Content-Language: en-GB
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        yhs@fb.com
References: <20220826003712.2810158-1-kuifeng@fb.com>
 <20220826003712.2810158-6-kuifeng@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220826003712.2810158-6-kuifeng@fb.com>
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

On 26/08/2022 01:37, Kui-Feng Lee wrote:
> Show tid or pid of iterators if giving an argument of tid or pid
> 
> For exampole, the commaned `bpftool link list` may list following

s/exampole/example/, s/commaned/command/

> lines.
> 
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 33: iter  prog 225  target_name task_file  tid 1644
>         pids test_progs(1644)
> 
> Link 33 is a task_file iterator with tid 1644.  For now, only targets
> of task, task_file and task_vma may be with tid or pid to filter out
> tasks other than that belong to a process (pid) or a thread (tid).

s/that belong/those belonging/?

> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/bpf/bpftool/link.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 7a20931c3250..f96c18bb7a42 100644
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
> +		if (info->iter.task.pid)
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

Looks good, thanks! I note that you have an "if ... else ..." here, vs.
two "if"s above for the JSON output. Could you please make this consistent?

Thanks,
Quentin
