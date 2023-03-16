Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A16BDA9F
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 22:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCPVLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCPVLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 17:11:24 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3305278;
        Thu, 16 Mar 2023 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=iSjig+DEnaSPWpoK8ELyXtls/ryUNu4ysfoRKVxSSLo=; b=BZO9geS45b2YuXbqUqRkldtgLV
        fBwMK0bzN6cHlgqurFXozGd05QZPxjhasfaUYySuu2ZG93FDkDsJHDRMasmikoOAoJzilKUGKLhdg
        7K6eMc0TOzNq8+EECCBpj+ZusyNYxhDgHuJO8Gi+o1JLBzKaWjDTGLIRhP/dJ4GN2ywpHJxyK5PRd
        N1vDjCoAdKKvWApGaHzX3j1n6e2O907KEEns58yz276GkIf+Vk0RA3qswZHChcIifxCYxXxL+C9nw
        ehzW6gkTrbxl5fquVwaxwow6/rXZYTSOYW7JUZAWkG0eb2ma6eyLLNDdPiRBzLG0cuZRrJRCTNKV0
        ODV2Eb+w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pcusQ-000NWp-CO; Thu, 16 Mar 2023 22:11:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pcusP-000D8Q-A4; Thu, 16 Mar 2023 22:11:09 +0100
Subject: Re: [PATCH] tools/resolve_btfids: Add libsubcmd to .gitignore
To:     Greg Thelen <gthelen@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315054932.1639169-1-gthelen@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <075bcfa1-8b9a-3d0c-4db2-3772491225c2@iogearbox.net>
Date:   Thu, 16 Mar 2023 22:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230315054932.1639169-1-gthelen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26845/Thu Mar 16 19:16:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/15/23 6:49 AM, Greg Thelen wrote:
> After building the kernel I see:
>    $ git status -s
>    ?? tools/bpf/resolve_btfids/libbpf/
> 
> Commit af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> started copying header files into
> tools/bpf/resolve_btfids/libsubcmd/include/subcmd. These *.h files are
> not covered by higher level wildcard gitignores.
> 
> gitignore the entire libsubcmd directory. It's created as part of build
> and removed by clean.
> 
> Fixes: af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Already fixed in bpf-next by:

commit fd4cb29f2a3d54ec7b4e012300321601af10bd68
Author: Rong Tao <rongtao@cestc.cn>
Date:   Sat Mar 4 23:17:04 2023 +0800

     tools/resolve_btfids: Add /libsubcmd to .gitignore

Thanks,
Daniel
