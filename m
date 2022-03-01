Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50E4C8F4C
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiCAPlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 10:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiCAPlH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 10:41:07 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365ECAA2D0
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 07:40:24 -0800 (PST)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP4bt-0007e2-RF; Tue, 01 Mar 2022 16:40:21 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP4bt-00027D-LS; Tue, 01 Mar 2022 16:40:21 +0100
Subject: Re: [PATCH v4 bpf-next 2/3] libbpf: support custom SEC() handlers
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
References: <20220224002317.1089150-1-andrii@kernel.org>
 <20220224002317.1089150-3-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <15986c84-eefb-0ae7-f70d-0cec96062ac5@iogearbox.net>
Date:   Tue, 1 Mar 2022 16:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220224002317.1089150-3-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26468/Tue Mar  1 10:31:38 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/24/22 1:23 AM, Andrii Nakryiko wrote:
> Allow registering and unregistering custom handlers for BPF program.
> This allows user applications and libraries to plug into libbpf's
> declarative SEC() definition handling logic. This allows to offload
> complex and intricate custom logic into external libraries, but still
> provide a great user experience.
> 
> One such example is USDT handling library, which has a lot of code and
> complexity which doesn't make sense to put into libbpf directly, but it
> would be really great for users to be able to specify BPF programs with
> something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
> and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
> uprobe) and even support BPF skeleton's auto-attach logic.
> 
> In some cases, it might be even good idea to override libbpf's default
> handling, like for SEC("perf_event") programs. With custom library, it's
> possible to extend logic to support specifying perf event specification
> right there in SEC() definition without burdening libbpf with lots of
> custom logic or extra library dependecies (e.g., libpfm4). With current
> patch it's possible to override libbpf's SEC("perf_event") handling and
> specify a completely custom ones.
> 
> Further, it's possible to specify a generic fallback handling for any
> SEC() that doesn't match any other custom or standard libbpf handlers.
> This allows to accommodate whatever legacy use cases there might be, if
> necessary.
> 
> See doc comments for libbpf_register_prog_handler() and
> libbpf_unregister_prog_handler() for detailed semantics.
> 
> This patch also bumps libbpf development version to v0.8 and adds new
> APIs there.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]

Just two minor things:

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c8d8daad212e..ac8dadbf0bdc 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1328,6 +1328,93 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
>   LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>   LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>   
> +/*
> + * Custom handling of BPF program's SEC() definitions
> + */
> +
> +struct bpf_prog_load_opts; /* defined in bpf.h */
> +
> +/* Called during bpf_object__open() for each recognized BPF program. Callback
> + * can use various bpf_program__set_*() setters to adjust whatever properties
> + * are necessary.
> + */
> +typedef int (*libbpf_prog_setup_fn_t)(struct bpf_program *prog, long cookie);
> +
> +/* Called right before libbpf performs bpf_prog_load() to load BPF program
> + * into the kernel. Callback can adjust opts as necessary.
> + */
> +typedef int (*libbpf_prog_prepare_load_fn_t)(struct bpf_program *prog,
> +					     struct bpf_prog_load_opts *opts, long cookie);
> +
> +/* Called during skeleton attach or through bpf_program__attach(). If
> + * auto-attach is not supported, callback should return 0 and set link to
> + * NULL (it's not considered an error during skeleton attach, but it will be
> + * an error for bpf_program__attach() calls). On error, error should be
> + * returned directly and link set to NULL. On success, return 0 and set link
> + * to a valid struct bpf_link.
> + */
> +typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> +				       struct bpf_link **link);
> +
> +struct libbpf_prog_handler_opts {
> +	/* size of this struct, for forward/backward compatiblity */
> +	size_t sz;
> +	/* User-provided cookie passed to each callback */ > +	long cookie;

I don't think user might understand much from this, could you extend the doc in here
a bit to provide examples on when it might be needed in practice? Why long cookie over
void *private_data which might be more generic/clear? (I presume there is no intended
relation to use with bpf_cookie?)

> +	/* BPF program initialization callback (see libbpf_prog_setup_fn_t) */
> +	libbpf_prog_setup_fn_t prog_setup_fn;
> +	/* BPF program loading callback (see libbpf_prog_prepare_load_fn_t) */
> +	libbpf_prog_prepare_load_fn_t prog_prepare_load_fn;
> +	/* BPF program attach callback (see libbpf_prog_attach_fn_t) */
> +	libbpf_prog_attach_fn_t prog_attach_fn;

Should probably also mention that these callbacks are optional and can be NULL?

> +};
> +#define libbpf_prog_handler_opts__last_field prog_attach_fn
> +
> +/**
> + * @brief **libbpf_register_prog_handler()** registers a custom BPF program
> + * SEC() handler.
> + * @param sec section prefix for which custom handler is registered
> + * @param prog_type BPF program type associated with specified section
> + * @param exp_attach_type Expected BPF attach type associated with specified section
> + * @param opts optional cookie, callbacks, and other extra options
> + * @return Non-negative handler ID is returned on success. This handler ID has
> + * to be passed to *libbpf_unregister_prog_handler()* to unregister such
> + * custom handler. Negative error code is returned on error.
> + *
> + * *sec* defines which SEC() definitions are handled by this custom handler
> + * registration. *sec* can have few different forms:
> + *   - if *sec* is just a plain string (e.g., "abc"), it will match only
> + *   SEC("abc"). If BPF program specifies SEC("abc/whatever") it will result
> + *   in an error;
> + *   - if *sec* is of the form "abc/", proper SEC() form is
> + *   SEC("abc/something"), where acceptable "something" should be checked by
> + *   *prog_init_fn* callback, if there are additional restrictions;
> + *   - if *sec* is of the form "abc+", it will successfully match both
> + *   SEC("abc") and SEC("abc/whatever") forms;
> + *   - if *sec* is NULL, custom handler is registered for any BPF program that
> + *   doesn't match any of the registered (custom or libbpf's own) SEC()
> + *   handlers. There could be only one such generic custom handler registered
> + *   at any given time.
> + *
> + * All custom handlers (except the one with *sec* == NULL) are processed
> + * before libbpf's own SEC() handlers. It is allowed to "override" libbpf's
> + * SEC() handlers by registering custom ones for the same section prefix
> + * (i.e., it's possible to have custom SEC("perf_event/LLC-load-misses")
> + * handler).
> + */
> +LIBBPF_API int libbpf_register_prog_handler(const char *sec,
> +					    enum bpf_prog_type prog_type,
> +					    enum bpf_attach_type exp_attach_type,
> +					    const struct libbpf_prog_handler_opts *opts);

Lets also document that both libbpf_register_prog_handler() and libbpf_unregister_prog_handler()
are not thread safe.

> +/**
> + * @brief *libbpf_unregister_prog_handler()* unregisters previously registered
> + * custom BPF program SEC() handler.
> + * @param handler_id handler ID returned by *libbpf_register_prog_handler()*
> + * after successful registration
> + * @return 0 on success, negative error code if handler isn't found
> + */
> +LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> +

