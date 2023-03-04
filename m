Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CE6AAC35
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCDTtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 14:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDTtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 14:49:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5B1115F;
        Sat,  4 Mar 2023 11:49:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so23274226eda.7;
        Sat, 04 Mar 2023 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jg714WWj4N7aqCelTQ2hrUOqPDj8g39u2Z+tfldDIJY=;
        b=Oz/rJgKWch6WMQjuSoC6YHyAJjI2LAjTwqo66efn6Wn97Z/TlbCaxdkGzQgQiyi63L
         Xb4n7+kVexGzLO4dozBWrpc972uWV9yTWqHFysa2uOTKc7OYkLH0AwdpWRgqMQl0jWND
         DG5CXIOa0tltfdCLqTe1j4Fw5V3zaO6voAbk/zWzpXJcP2aKyxeqU1jgphy+/oI/s5rB
         1zMb5oZI3+XORRPnUfsEhPQIoc1S90vs5G9rvFK/sWh5Ej1L+OEk4LMpyNZJxCY460I9
         VVB4dudBt2/Mp8jinloGB1Z79DVWE70UVlX0uDJgOqpX4N4tYU4b98vbkLwuCD82GeQ+
         9uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg714WWj4N7aqCelTQ2hrUOqPDj8g39u2Z+tfldDIJY=;
        b=Ja3f5uRYyMltj7SYkQx40Zg7OOvbS8NLDBHGENfgFYKMy1J3/UueABuUVCtfWVjecs
         VQT+csywogHBtz81QUGM3XuL2e4MeC6Vq3cw88fQO4+MWujUbwQo9F4ICr/6dG2Lay6h
         E5jjLvmxuwzyFx6T3UnQlHHYvANeIbTfvsWyk+jmQcbrxa9XufYU7Jrc/kUUg/jculkp
         W3oOuIh8/QucLNF8WJ/6v+IQzlWQsBUZNio81WHic593NxJiT80yQV0Ma6ka36d2bA2h
         Ade5QmTlEJqTCKGcHU1MNnxcCXpD1em/9P6leTbwrbiHf3j6/k2Xunl8SiobpCxxdrpl
         5f5w==
X-Gm-Message-State: AO0yUKUcID6GWDAbgIPoGkoNDXECOxVhwaVANyKZcZtLJO24ic/Jesz0
        ncN6bjmDjyaQvTMX65SS8+0=
X-Google-Smtp-Source: AK7set+Z+HXBYNkwb7SS/s9jX8ED92HpCMKcag2fcMEmBW/+y5rEA+8KOBjrf9O+rh+Od1/045/ErQ==
X-Received: by 2002:a17:906:4a5a:b0:87b:bbdc:468 with SMTP id a26-20020a1709064a5a00b0087bbbdc0468mr5823466ejv.70.1677959349443;
        Sat, 04 Mar 2023 11:49:09 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709063bc500b008c327bef167sm2364231ejf.7.2023.03.04.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:49:09 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 4 Mar 2023 20:49:06 +0100
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Add /libsubcmd to
 .gitignore
Message-ID: <ZAOgsjNONOUQFVwe@krava>
References: <tencent_F13D670D5D7AA9C4BD868D3220921AAC090A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F13D670D5D7AA9C4BD868D3220921AAC090A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 04, 2023 at 11:17:04PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> After compiling the kernel:
> 
>     # bpf-next...bpf-next/master
>     ?? tools/bpf/resolve_btfids/libsubcmd/
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/resolve_btfids/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
> index 16913fffc985..52d5e9721d92 100644
> --- a/tools/bpf/resolve_btfids/.gitignore
> +++ b/tools/bpf/resolve_btfids/.gitignore
> @@ -1,3 +1,4 @@
>  /fixdep
>  /resolve_btfids
>  /libbpf/
> +/libsubcmd/
> -- 
> 2.39.2
> 
