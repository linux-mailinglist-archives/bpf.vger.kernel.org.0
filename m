Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06F6DDFF3
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDKPvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKPvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 11:51:02 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2282723;
        Tue, 11 Apr 2023 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qSaxyYQdKwgFEK0nqBsLj18c+ve44So2muQ8Wi6MeVs=; b=KsZCRkuppWJIR/T1aGry0SdCYQ
        huSZJ0IZlIW2D26QHXeB7IdNI/RcbQ8qX+G+DnpjsL+Ahza1CHVxwK4y+myeWHSvRBhPRu2y1X0pc
        uC264dEqBx/DV9bZ5EhA4nPsmvWK2+HlxeyCojKRL+wtGJvYtmsZVmYZI7F7aeHVxSXGW4s9Qb1Ye
        lfSdCd4ShpTU7GdL+f7kHECRH947Lye0/lLJ/RvI2M2mLQySsD1NndfvzAyqPM1BS+6b0vPSZZzU6
        45NX1w3Jjwk2VvLzhLV3SCeEhMtZNq1ssiGK2vL8W26p9kRP5/az0g3oiO5w5TaCOZXFnoz9Jcoxv
        EMdu+Q/Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pmGGZ-00054z-Dk; Tue, 11 Apr 2023 17:50:43 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pmGGY-000HnH-Tk; Tue, 11 Apr 2023 17:50:42 +0200
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Ignore libsubcmd
To:     Rong Tao <rtoax@foxmail.com>, ast@kernel.org
Cc:     rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <tencent_D5422A55AFF3A307880D06AD42D559739708@qq.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <211a783e-bd22-9e83-3622-0a83b0dd0002@iogearbox.net>
Date:   Tue, 11 Apr 2023 17:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <tencent_D5422A55AFF3A307880D06AD42D559739708@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26872/Tue Apr 11 09:26:30 2023)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/11/23 11:17 AM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit af03299d8536("tools/resolve_btfids: Install subcmd headers")
> introduce subcmd headers directory, we should ignore it.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   tools/bpf/resolve_btfids/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
> index 16913fffc985..52d5e9721d92 100644
> --- a/tools/bpf/resolve_btfids/.gitignore
> +++ b/tools/bpf/resolve_btfids/.gitignore
> @@ -1,3 +1,4 @@
>   /fixdep
>   /resolve_btfids
>   /libbpf/
> +/libsubcmd/
> 

Please rebase, this has already been fixed in bpf-next:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=fd4cb29f2a3d54ec7b4e012300321601af10bd68

Thanks,
Daniel
