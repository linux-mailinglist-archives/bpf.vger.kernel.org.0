Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAB6CACE9
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjC0SVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC0SVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEC3A8D
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679941262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QmIkpEKXa5UxgJDPzN81fUKnNNvP0DAA7O3XVhN+u0=;
        b=EQ6t3VRB5Zba27t5ZzvVizS9pm3bknvNU0d/FXKE2Z0s1413tAlAefNjv7q5E5c7SllITe
        nB8/3Qhado5pNVq2j8Qf42XFfAzYvcG0AoN8pJf/zABkmewpfBGYUlNlGku4kKoQMAq4Ke
        fcRC8Ow+4DvMCg1kYS3REW71JkraonY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-tCNcZ_oONhihQz907N6nSA-1; Mon, 27 Mar 2023 14:20:59 -0400
X-MC-Unique: tCNcZ_oONhihQz907N6nSA-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so13918960edj.20
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QmIkpEKXa5UxgJDPzN81fUKnNNvP0DAA7O3XVhN+u0=;
        b=o1aP9KeiqW28XvBkUmKgDPNkjAmRyE8r10ZqgTiD2zT6twpbAiUG0KsdNnbs0KX/so
         2GnVvB1EYHhKQ9Dt1CfGFa2quhGCJa9CrddtIR4OrMJKrFppbYMOPyBjkeizR6jWJs3L
         sF0RT2QgFbZXsW6sPVb5jVyQGZ1eKhhnNGlFGEUpN3P0SXuzuqh/9oFUkKOSAmsgnhWa
         BMEOWT8RB07SadkwO+R1sVmnAEcFxIc8+iIumhp4MycIDO0WuGAUtUD2Z9VRKaa0UDZF
         qJp6fmQQKE1Q1T+4LbDp1KedRP6q7NBO3WzoO+IGQH+KkicmMtxjmVYJULD3EZSneWF8
         Milw==
X-Gm-Message-State: AAQBX9ec9xX8/D4YWwmluyeBNinQ7ymYXcAliDg0AHIv6dx9qO3UyACl
        c1XZpcyBcHWrHLdx3mWwgiVmavj5nsYEi37xGZwdHXje1haA4D6KhwYr857WUCu/hXLboemyUuO
        En4x9XM917yQ=
X-Received: by 2002:a17:906:578c:b0:88f:a236:69e6 with SMTP id k12-20020a170906578c00b0088fa23669e6mr13411015ejq.7.1679941258630;
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyqZAVBR4sO7omGkqBh61MtackTk3PX7Mi9DzjBUxd+qSqTRoWMD57UFZPSeAY/JpJfDLw8w==
X-Received: by 2002:a17:906:578c:b0:88f:a236:69e6 with SMTP id k12-20020a170906578c00b0088fa23669e6mr13410994ejq.7.1679941258315;
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id l11-20020a1709066b8b00b00939faf4be97sm9309590ejr.215.2023.03.27.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:20:58 -0700 (PDT)
Message-ID: <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
Date:   Mon, 27 Mar 2023 20:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
References: <20230327161251.1129511-1-vmalik@redhat.com>
 <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/23 19:47, Luis Chamberlain wrote:
> On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
>> Functions for searching module kallsyms should have non-empty
>> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
>> only CONFIG_MODULES check was used for many of these, which may have
>> caused complilation errors on some configs.
>>
>> This patch moves all relevant functions under the correct configs.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
> 
> Thanks Viktor!  Does this fix something from an existing commit? If so
> which one?  The commit log should mention it.

Ah, right, I forgot about that. The commit log is missing:

Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")

I can post v2 but I'm also fine with maintainers applying the tag.

Thanks!
Viktor

> 
>    LUis
> 

