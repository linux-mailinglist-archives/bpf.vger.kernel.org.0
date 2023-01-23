Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321BB678944
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjAWVLi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjAWVLh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:11:37 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F083C22;
        Mon, 23 Jan 2023 13:11:35 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK3Z6-000H7X-2M; Mon, 23 Jan 2023 21:37:16 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK3Z5-000Tjt-Gf; Mon, 23 Jan 2023 21:37:15 +0100
Subject: Re: [PATCH v3 1/2] tools/resolve_btfids: Install subcmd headers
To:     Ian Rogers <irogers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119183118.126387-1-irogers@google.com>
 <20230119183118.126387-2-irogers@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c022261e-bff4-8aea-0d71-f8683b6ad449@iogearbox.net>
Date:   Mon, 23 Jan 2023 21:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230119183118.126387-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26790/Mon Jan 23 09:31:32 2023)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/23 7:31 PM, Ian Rogers wrote:
> Previously tools/lib/subcmd was added to the include path, switch to
> installing the headers and then including from that directory. This
> avoids dependencies on headers internal to tools/lib/subcmd. Add the
> missing subcmd directory to the affected #include.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
>   tools/bpf/resolve_btfids/main.c   |  2 +-
>   2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 19a3112e271a..76b737b2560d 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
>   BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
>   LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
>   SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
>   
>   LIBBPF_DESTDIR := $(LIBBPF_OUT)
>   LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
>   
> +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> +
>   BINARY     := $(OUTPUT)/resolve_btfids
>   BINARY_IN  := $(BINARY)-in.o
>   
>   all: $(BINARY)
>   
> +prepare: $(BPFOBJ) $(SUBCMDOBJ)
> +
>   $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>   	$(call msg,MKDIR,,$@)
>   	$(Q)mkdir -p $(@)
>   
>   $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> -	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
> +	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> +		    DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> +		    $(abspath $@) install_headers
>   
>   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>   	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> @@ -60,14 +68,14 @@ CFLAGS += -g \
>             -I$(srctree)/tools/include \
>             -I$(srctree)/tools/include/uapi \
>             -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_SRC)
> +          -I$(SUBCMD_INCLUDE)
>   
>   LIBS = -lelf -lz
>   

This series needs a rebase against bpf-next, given it results in merge conflict
e.g. see commit 0e43662e61f2 ("tools/resolve_btfids: Use pkg-config to locate
libelf") from Dec 15th.

Thanks,
Daniel
