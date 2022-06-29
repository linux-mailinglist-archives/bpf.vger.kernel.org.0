Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BC5605B5
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiF2QWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiF2QWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:22:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3035841
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 09:22:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i205-20020a1c3bd6000000b003a03567d5e9so519867wma.1
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ijpocm3vatH5kO+ZYUOc9TTjlnVNAZIcW9a/yBu6ItE=;
        b=6QfwbhcmCIRs1J6nA6jB+X0ioyM/nOdbmTtw1TGv9YlEpSgVxTMJFnUuC4aCXZLMY0
         i6RETTRSkURH4JR8kRMXMNmiweTZChS2WBWpcR3Y8lxTvkB92MPHHoqKrOgIZFlU1zV0
         /KCG15N092mbxeDpvhzL4DT6iqrvMgkSVtOC0PvmyniK1/C8i81j46rbl5bNI2EkUmmS
         NK2KFQWX0MJWgfhnz5S6YpedRCo0vA+I6k9O5cdQbrdumW+zi6X5beT5UcXDjuoFqWl+
         WUj05AtBDaU+bX7DDU2mn6veE5xXf9L5PqeNjW1PGkW6VJPBuZBc3Fr/4mtxsmEL3GlH
         VJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ijpocm3vatH5kO+ZYUOc9TTjlnVNAZIcW9a/yBu6ItE=;
        b=CPUmW2lGFrDP8MNtml0cjRE8vIHa40Vk5B8BOB8Zz8z0bhyzSi0BQlC1V5cpodEwh4
         sy9wg3te+GQdOAoQgYfj3uZV+CbrumLn3lKd2oR44tD29l/S9EdjAg4l07V+UoUGKBlv
         A5lU+63nK43PPY81m6dxfRdb9YnY7gQV3PViG4KGFmGOLTxUyjJzcpoUNDDJqFKUU2/5
         J4tepqzJziHL/iUMIBkqrPIyS8MLlPf9aF2IQF+csfbcnqIA1bro4FYNCRcnj1ng99yA
         neZ0sE1Ue8On+s0UiVCjxUzEn3S/qSQ0/3u0SvH+5DVy+hF77+bOQCCFw+1nvh+L3O13
         sz6g==
X-Gm-Message-State: AJIora8K1oA68KjkQ/GVfWFkrDW3daEHfPNoFQiZaDK7GLewOIFBvhua
        dRTD0vLZ8CnvVzd5daVdedOVAQ==
X-Google-Smtp-Source: AGRyM1uOs8/d5+zKxZTiwBOush36fLvJcaIOeFgJWDSwKuIMeNRn3DDJU8QII8xrEdZPiBCpRwXcUw==
X-Received: by 2002:a05:600c:198e:b0:3a1:6db7:fdd0 with SMTP id t14-20020a05600c198e00b003a16db7fdd0mr3314140wmq.14.1656519728042;
        Wed, 29 Jun 2022 09:22:08 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0039c5a765388sm3744476wmc.28.2022.06.29.09.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 09:22:07 -0700 (PDT)
Message-ID: <14bdc764-a129-35f6-bacc-6f517b259a5c@isovalent.com>
Date:   Wed, 29 Jun 2022 17:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH bpf-next 4/4] bpftool: Show also the name of type
 BPF_OBJ_LINK
Content-Language: en-GB
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220629154832.56986-1-laoar.shao@gmail.com>
 <20220629154832.56986-5-laoar.shao@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220629154832.56986-5-laoar.shao@gmail.com>
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

On 29/06/2022 16:48, Yafang Shao wrote:
> For example,
> /sys/fs/bpf/maps.debug is a bpf link, when you run `bpftool map show` to
> show it,
> - before
>   $ bpftool map show pinned /sys/fs/bpf/maps.debug
>   Error: incorrect object type: unknown
> - after
>   $ bpftool map show pinned /sys/fs/bpf/maps.debug
>   Error: incorrect object type: link
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index a0d4acd7c54a..5e979269c89a 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -251,6 +251,7 @@ const char *get_fd_type_name(enum bpf_obj_type type)
>  		[BPF_OBJ_UNKNOWN]	= "unknown",
>  		[BPF_OBJ_PROG]		= "prog",
>  		[BPF_OBJ_MAP]		= "map",
> +		[BPF_OBJ_LINK]		= "link",
>  	};
>  
>  	if (type < 0 || type >= ARRAY_SIZE(names) || !names[type])

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
