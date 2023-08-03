Return-Path: <bpf+bounces-6893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55F76F3B2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4698E1C20A82
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06EB2593D;
	Thu,  3 Aug 2023 19:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1463BC
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 19:54:00 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057D1706
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 12:53:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1520491276.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691092438; x=1691697238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gb6gHMyN5OPQnqqY54L1Nh0qaaG9raJTAN+E3yJ850s=;
        b=aSv80XnLluFZQQ2nILyf7GaT3bJxlKYAEi+tig4hVhrDxqprRKGMsyWhyiwHir+Gil
         R6rslpWa3ntDN5qSOK0w7PoyoSvnATNR+eXfabwTozp9dB8sD+OpshqFmc7iWUqSyQMm
         jFv1jcrn7qznMqUGRrjFqpoeIk3KBqFRRIGrKn3lazMqzUbApTipU4I36o6fYKkmiLRJ
         Xqbe0vB9ji5ydUab1QeQm8EwkiyQPXLVz8gf5BjckiFscrKP7oRu018C6emaa09n2NqG
         r6m1VRNB+2MG9mVtRUOCcJ3Mohlc5bIZusMzaLGVl64aq40wj3asxq9fkCn8xQ8CHtMK
         Yk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691092438; x=1691697238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb6gHMyN5OPQnqqY54L1Nh0qaaG9raJTAN+E3yJ850s=;
        b=hcv4DHUK7vg+Hds5hHXXP9q8WuyxNQKcQHi+j8dH9x28YvzcgKUNf0C89Uk7NC8TUn
         IOVBP5e6bx53dh4NTDTnat5ax2iHpS+PhK1Tloq6SIEu7lDk1f/wTqSlg9PydLyzktZG
         tq3ahCVB+toQjw2VQ4xBJEBTLOJFt4CzftRuKgu/YuoV8DOXS5DFfacd5ATFjonfgk8a
         CJRj1tQvV+gF54lIShGfOlimIenw3tz3dYhyz0ApiVyAeg4pyRJdm6vHaJyZXCxLfMTD
         CV19VypJE1U8JN0EYV1YWBedQ8qvC7PTx4AqQkxl4N5vWjkHlEi+MbovhUFbBeJrt8oI
         bd0A==
X-Gm-Message-State: ABy/qLZRWPbZZNPRW3qziVYpLVBnjiEUwWPyrBa5YmyTng24AdawHcsi
	UyYYjKYKr/mtYl92Tkbt2TU=
X-Google-Smtp-Source: APBJJlGCTKJHP7ySKUjP6MNgFOG+KNK211Wbq/oCtMoeIFc4G910SMICGAAX8oR2f0NVsUBLL+bkqg==
X-Received: by 2002:a25:d84a:0:b0:d11:c89:4256 with SMTP id p71-20020a25d84a000000b00d110c894256mr17522667ybg.31.1691092438455;
        Thu, 03 Aug 2023 12:53:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:c07f:1e98:63f3:8107? ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id v184-20020a252fc1000000b00d0aa0a97ee7sm133923ybv.32.2023.08.03.12.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 12:53:58 -0700 (PDT)
Message-ID: <ef31ecbc-d7ce-9d5f-5ace-4b3f4d8c8039@gmail.com>
Date: Thu, 3 Aug 2023 12:53:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Kui-Feng Lee <kuifeng@meta.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
 <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 13:47, Alexei Starovoitov wrote:
> On Mon, Jul 31, 2023 at 12:24 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> Hello Joanne Koong,
>>
>> The patch 66e3a13e7c2c: "bpf: Add bpf_dynptr_slice and
>> bpf_dynptr_slice_rdwr" from Mar 1, 2023 (linux-next), leads to the
>> following Smatch static checker warning:
>>
>>          tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c:403 forward_with_gre()
>>          error: 'encap_gre' dereferencing possible ERR_PTR()
>>
>> tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>>      396
>>      397         encap_gre = bpf_dynptr_slice_rdwr(dynptr, 0, encap_buffer, sizeof(encap_buffer));
>>      398         if (!encap_gre) {
>>      399                 metrics->errors_total_encap_buffer_too_small++;
>>      400                 return TC_ACT_SHOT;
>>      401         }
>>      402
>> --> 403         encap_gre->ip.protocol = IPPROTO_GRE;
>>                  ^^^^^^^^^^^
>>
>> The bpf_dynptr_slice() function accidentally propagates error pointers
>> from bpf_xdp_pointer() so it would crash here.
> 
> Good catch.
> 
> Kui-Feng, could you please send a fix?

sure!
> 
> Probably the following will be enough:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 56ce5008aedd..eb91cae0612a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct
> bpf_dynptr_kern *ptr, u32 offset
>          case BPF_DYNPTR_TYPE_XDP:
>          {
>                  void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset
> + offset, len);
> -               if (xdp_ptr)
> +               if (!IS_ERR_OR_NULL(xdp_ptr))
>                          return xdp_ptr;
> 
> Also I've noticed:
> void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
>                        void *buf, unsigned long len, bool flush);
> #else /* CONFIG_NET */
> static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
> {
>          return NULL;
> }
> 
> The latter is wrong.
> Please send a separate fix.
> 

