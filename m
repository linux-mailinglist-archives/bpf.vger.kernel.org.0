Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA76EB3BD
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDUVmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 17:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDUVmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 17:42:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497719AD
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:42:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-552a6357d02so25287317b3.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682113339; x=1684705339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3iXp+irGUX635A++P4SzY2dTN9GRUPMK9mJEpvLk5c=;
        b=FdmXez19XgyRtc/doiA8NbWgTlo1jpP4aJTPzhx0NajxcpjyerHsl5P1GWSVH1X2b2
         hzBnEp54qnqXIgHaNyLzO5I7olucS1q2D0bKhTAzIkEQibxdi8tTKlfNg6xuylCFICZ5
         wssg5+yKN6/VBgFCI5D9+gK6+RoqxrdKnB2Z0HAtHH0UAzMq0NE0L3YBdVBU7JKb+SDL
         mqYTXqrLDZmDHKV41RGK5DMIwY+GL4F4BLPqSAFX9MUOu8uEExt7i+txQ82FOU9Fo8RR
         44FddB67f46hprf77DgbSlHe4nbgu/+YQAOdVKR76uKjaFgUCbc8PrSrXyCw00gT0lkk
         qeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113339; x=1684705339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3iXp+irGUX635A++P4SzY2dTN9GRUPMK9mJEpvLk5c=;
        b=R8g9bKM52aXz6yBjnCO1nS+JOecTo/gmNfdIcUOjN8IB5/C2Dm7dHWC07pb7xtcWm2
         lUK2OWRdSJS8MLQv9tfTjRrKMQs3YHutgrkPzRH8gamcZRNO97stza+ArzltPGA920Jt
         EmxvaTmYm4xMV3UxsFdC6uQ4038O63w5L93ErFwbqW5oEmqT6LXECPBFmOvklcnUi1pu
         a5ChlqOP2dIIb3WhO98+geg8DqHmH1ZtOh5kGCICeCYQymsmqjUceKWbTMSbzHqDCwrh
         TRzxcBc8kR1LT4oejkgIW9eJD5ti/9y/v/ythL84yOo2UZhy05/uXxMvkVAB1BPAQFoH
         6a5Q==
X-Gm-Message-State: AAQBX9cLuNxrwaWAD1blVl2o+nGqKEHoGbBo7i7hRwOXYzqvdrA4vl4F
        lb3mG0n9b2Du0WmIwm4aCq8=
X-Google-Smtp-Source: AKy350ZwZlAvwCGzQ7FpXSUGtLY7pAGGqpbsQI5j6qPARc9gQdzfkwz7YeFjBtP0UkR6ZrwaVQXMaQ==
X-Received: by 2002:a81:4e08:0:b0:54f:b112:7680 with SMTP id c8-20020a814e08000000b0054fb1127680mr3016900ywb.41.1682113338800;
        Fri, 21 Apr 2023 14:42:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5982:695:6231:be41? ([2600:1700:6cf8:1240:5982:695:6231:be41])
        by smtp.gmail.com with ESMTPSA id h7-20020a0dde07000000b0054662f7b42dsm1181372ywe.63.2023.04.21.14.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 14:42:18 -0700 (PDT)
Message-ID: <4e7592dc-adf4-3fd6-7898-b658127339f0@gmail.com>
Date:   Fri, 21 Apr 2023 14:42:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v3] bpftool: Show map IDs along with struct_ops
 links.
Content-Language: en-US
To:     Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, yhs@meta.com,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20230421181720.182365-1-kuifeng@meta.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230421181720.182365-1-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Due to a confliction, I have rebased this patch and sent v4.

On 4/21/23 11:17, Kui-Feng Lee wrote:
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
> 
> The assumption was that every link is associated with a BPF program, but
> this does not hold true for struct_ops. It would be better to display
> map_id instead of prog_id for struct_ops links. However, some tools may
> rely on the old assumption and need a prog_id.  The discussion on the
> mailing list suggests that tools should parse JSON format. We will maintain
> the existing JSON format by adding a map_id without removing prog_id. As
> for plain text format, we will remove prog_id from the header line and add
> a map_id for struct_ops links.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---
>   tools/bpf/bpftool/link.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index f985b79cca27..c79f2e8927d6 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -195,6 +195,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>   				 info->netns.netns_ino);
>   		show_link_attach_type_json(info->netns.attach_type, json_wtr);
>   		break;
> +	case BPF_LINK_TYPE_STRUCT_OPS:
> +		jsonw_uint_field(json_wtr, "map_id",
> +				 info->struct_ops.map_id);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -227,7 +231,10 @@ static void show_link_header_plain(struct bpf_link_info *info)
>   	else
>   		printf("type %u  ", info->type);
>   
> -	printf("prog %u  ", info->prog_id);
> +	if (info->type == BPF_LINK_TYPE_STRUCT_OPS)
> +		printf("map %u  ", info->struct_ops.map_id);
> +	else
> +		printf("prog %u  ", info->prog_id);
>   }
>   
>   static void show_link_attach_type_plain(__u32 attach_type)
