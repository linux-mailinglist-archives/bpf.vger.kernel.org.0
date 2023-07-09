Return-Path: <bpf+bounces-4526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7474C0B7
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 05:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A2E281203
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E591864;
	Sun,  9 Jul 2023 03:44:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB517E1;
	Sun,  9 Jul 2023 03:44:52 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC7E48;
	Sat,  8 Jul 2023 20:44:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so2289133a12.1;
        Sat, 08 Jul 2023 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688874288; x=1691466288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iFlYWKemOtEJ+o4zoGBP/4XhvOtPNzNtMX13qsZ7Ho=;
        b=TGv3R7UtpYdZ6ud7sapSX90OE9/4o3FPVIEObxwH4M1A1vlt/xSncGLOcybLjuA7Ii
         cP5VetquJsqdd6pRPl3kLt2Qr3rdvUyxoeIsIsKKj96V+BKfceRKAlos8X9eLn5FOK9E
         0/VbW+GXg4/jLM8WUISQUhJigdZCPIytJYlyZnTRaHlgic+KxNVH+ee9sAxxS690+3pl
         VCwp21kehVycj7gyPF7Mw571Qhvpqa0baNbfNrovSRaTewhWyh1L7K1ibCzHkUTf84DI
         8rzx4PV1six9aKqvHCJLYz5sdgUsrPjO89vOGNaAHoo5fJO10G9V6lnJ8DObJNXqyM/T
         Mb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688874288; x=1691466288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iFlYWKemOtEJ+o4zoGBP/4XhvOtPNzNtMX13qsZ7Ho=;
        b=H8eMYrz8fteY2M+Jgz7Evh8k2DrJ4tcWKO0hcWMTO+5tzI0BqrJ/YWvjyb5lpcnmtX
         Wxlckuf9Skf+wZtPORKwcKVU3cBQ20pKw9Bh/3YhJIeYjSoMqRoX+0ZkyMldLEfDKwsG
         obmZwNaLRGQJlwtPtFdRfdfucRjpAUQwOZ7g5z+I+DC/7oDanxOyRbEkz5gSCyK2k/xo
         EsCJGH9jxiNvFWngAKVu52tZTRoZ0l8UZGOAblVwcj7HTXzkE8BStP0npZdRiWrVwYW+
         vpdkvPKIR52tTqBp2XhxctLavpzp2xD5e1qLI4PDpdDj/c09Mq3zMnRvl20xVjolk6pH
         RbpA==
X-Gm-Message-State: ABy/qLYkR0BFqQ6tdCi0l+WFQVx3ALthPpwFp7OH+PuAciErNDnEznJP
	EA58eJMa/2IUzT+yEkqCwQw=
X-Google-Smtp-Source: APBJJlE7WNYmqWCVTIsQ7r0BsyzBvmwL/T0a2gEbtZ5mB1GpwGtwx+BS/maHiyJjaOCMFpm7t1q/0Q==
X-Received: by 2002:a17:90b:ecd:b0:263:a6a:49b8 with SMTP id gz13-20020a17090b0ecd00b002630a6a49b8mr6667141pjb.3.1688874288056;
        Sat, 08 Jul 2023 20:44:48 -0700 (PDT)
Received: from [192.168.1.12] (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090a590e00b0025e7f7b46c3sm3649566pji.25.2023.07.08.20.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 20:44:47 -0700 (PDT)
Message-ID: <b40831db-1a64-6fa6-ddcb-d33068882e90@gmail.com>
Date: Sun, 9 Jul 2023 11:44:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Introduce user log
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hawk@kernel.org, tangyeechou@gmail.com,
 kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230708040750.72570-1-hffilwlqm@gmail.com>
 <v76ytdfdf2sqhdufkqxzsuznandia3x4l4iyghpirxkzytngxq@uttzaebbmdjb>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <v76ytdfdf2sqhdufkqxzsuznandia3x4l4iyghpirxkzytngxq@uttzaebbmdjb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/9 06:02, Daniel Xu wrote:
> Hi Leon,
> 
> On Sat, Jul 08, 2023 at 12:07:48PM +0800, Leon Hwang wrote:
>> This series introduces bpf user log to transfer error message from
>> kernel space to user space when users provide buffer to receive the
>> error message.
>>
>> Especially, when to attach XDP to device, it can transfer the error
>> message along with errno from dev_xdp_attach() to user space, if error
>> happens in dev_xdp_attach().
> 
> Have you considered adding a tracepoint instead? With some TP_printk()
> stuff I think you can achieve a similar result without having to do
> go through changing uapi.

If just for dev_xdp_attach(), I think netlink approach is better than
tracepoint approach.

As for BPF syscall, error message along with errno through uapi is a
good UX, like "create link: invalid argument (Invalid XDP flags for BPF
link attachment)" when failed to attach XDP to a device. Hence, users
are able to know the error details instead of -EINVAL or "invalid
argument" only.

Furthermore, as for other BPF syscall subcommands, we are able to
provide error message along with errno by bpf_ulog_once(&attr->xxx.ulog,
"An error").


