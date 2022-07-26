Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5975813C5
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiGZNFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiGZNFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:05:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE524F03
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:05:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso8114058wmm.5
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=8/BiVXzWw7DpdJvQ3ifqPkp2Fd1CHJsYwkKZxnwLJCQ=;
        b=Sia3X1hrOrgKtdpcyEUXpfY4qcaD0EZzYTsPrrSVe14POCJ41jlAhFg3FRJ5PWPVRx
         0qIeP75usb3fnl42o+5t1Mon+r7a2ox5Te36jXSHgyiAMGWJGt801eHFRbm43rVPyKTV
         jsdpCsO48cpNyRshZ3s+TofvitY8wUpaqGmF2Im3GhfBhdGE0cPBdGIdspEiAi+1NguN
         dRrVrFEq7xukABLSiLzEY3RaaytyBBAVVT8y49mfwY+H4qvpWZb3Qol9FXH3uRX60IKv
         bCE/8yEIwAZ9IRYj+eL1TLx+/bNQ97gYZ799fPFEPlt8zggJS1h2DzgUFOqouaX8HxpY
         xhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=8/BiVXzWw7DpdJvQ3ifqPkp2Fd1CHJsYwkKZxnwLJCQ=;
        b=IKlNp3L9ucUMfPyC8V20Rq22yBUD2/TgHGOmfb1LYm2XBjT7rwTX5Bg9qGtFwHVeEL
         Mlky+Zo9x/ro3zyDnELbmNYnc2oO+HPS2yQhoTxJn7XnMWAp/yy2QD6GG/CoogsReTGH
         yu26uTHzWf5YEbibImM8xE0RlqWEwnQlsqmV9CJhWSDilNrY5GHU+X1SBgQbknCfApND
         UGrvTQ2qJHznjdlUVZjIQbS0+AKr17uZPBIZAKJRHPR7h6OVl2WGHxelF6BVv1TaWa0K
         +qBpKi/vCSaX+MI/Z0TSm/UbYe6itNu/wD9wwrrURZjLTprMf3f6IgjPst00f8f7cVOB
         HZqQ==
X-Gm-Message-State: AJIora+IHxJTKp3+chrvbBOrSyUgcQ2BMi5Sz1VekTWJwpa7or+o/yPt
        Z2Qdpm9f7PJhSW+5QtjpAf0=
X-Google-Smtp-Source: AGRyM1sjDQ9iK+CTn/17qqct8OGx//jlCsbG24Z8kn/NuweSvWYp/5x8Ke4VFIefcqT1d3xntjC3Eg==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr25250575wmq.88.1658840704288;
        Tue, 26 Jul 2022 06:05:04 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b0021e297d6850sm14220211wrr.110.2022.07.26.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:05:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 15:05:01 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Attach to socketcall() in
 test_probe_user
Message-ID: <Yt/mffzaGiJfmu5j@krava>
References: <20220723020344.21699-1-iii@linux.ibm.com>
 <20220723020344.21699-3-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723020344.21699-3-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 23, 2022 at 04:03:44AM +0200, Ilya Leoshkevich wrote:
> test_probe_user fails on architectures where libc uses
> socketcall(SYS_CONNECT) instead of connect(). Fix by attaching to
> socketcall as well.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../selftests/bpf/prog_tests/probe_user.c     | 35 +++++++++++++------
>  .../selftests/bpf/progs/test_probe_user.c     | 28 +++++++++++++--
>  2 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> index abf890d066eb..76c8e06b0357 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> @@ -4,25 +4,35 @@
>  /* TODO: corrupts other tests uses connect() */
>  void serial_test_probe_user(void)
>  {
> -	const char *prog_name = "handle_sys_connect";
> +	const char *prog_names[] = {
> +		"handle_sys_connect",
> +#if defined(__s390x__)
> +		"handle_sys_socketcall",
> +#endif
> +	};
> +	const size_t prog_count = ARRAY_SIZE(prog_names);
>  	const char *obj_file = "./test_probe_user.o";
>  	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
>  	int err, results_map_fd, sock_fd, duration = 0;
>  	struct sockaddr curr, orig, tmp;
>  	struct sockaddr_in *in = (struct sockaddr_in *)&curr;
> -	struct bpf_link *kprobe_link = NULL;
> -	struct bpf_program *kprobe_prog;
> +	struct bpf_link *kprobe_links[ARRAY_SIZE(prog_names)] = {};
> +	struct bpf_program *kprobe_progs[ARRAY_SIZE(prog_names)];
>  	struct bpf_object *obj;
>  	static const int zero = 0;
> +	size_t i;
>  
>  	obj = bpf_object__open_file(obj_file, &opts);
>  	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
>  		return;
>  
> -	kprobe_prog = bpf_object__find_program_by_name(obj, prog_name);
> -	if (CHECK(!kprobe_prog, "find_probe",
> -		  "prog '%s' not found\n", prog_name))
> -		goto cleanup;
> +	for (i = 0; i < prog_count; i++) {
> +		kprobe_progs[i] =
> +			bpf_object__find_program_by_name(obj, prog_names[i]);
> +		if (CHECK(!kprobe_progs[i], "find_probe",
> +			  "prog '%s' not found\n", prog_names[i]))
> +			goto cleanup;
> +	}
>  
>  	err = bpf_object__load(obj);
>  	if (CHECK(err, "obj_load", "err %d\n", err))
> @@ -33,9 +43,11 @@ void serial_test_probe_user(void)
>  		  "err %d\n", results_map_fd))
>  		goto cleanup;
>  
> -	kprobe_link = bpf_program__attach(kprobe_prog);
> -	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
> -		goto cleanup;
> +	for (i = 0; i < prog_count; i++) {
> +		kprobe_links[i] = bpf_program__attach(kprobe_progs[i]);
> +		if (!ASSERT_OK_PTR(kprobe_links[i], "attach_kprobe"))
> +			goto cleanup;
> +	}
>  
>  	memset(&curr, 0, sizeof(curr));
>  	in->sin_family = AF_INET;
> @@ -69,6 +81,7 @@ void serial_test_probe_user(void)
>  		  inet_ntoa(in->sin_addr), ntohs(in->sin_port)))
>  		goto cleanup;
>  cleanup:
> -	bpf_link__destroy(kprobe_link);
> +	for (i = 0; i < ARRAY_SIZE(prog_names); i++)

nit, you used prog_count in all places, could be also here

> +		bpf_link__destroy(kprobe_links[i]);
>  	bpf_object__close(obj);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
> index 8e1495008e4d..78e50c37fa21 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -5,10 +5,13 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>  
> +#ifndef SYS_CONNECT
> +#define SYS_CONNECT 3
> +#endif
> +
>  static struct sockaddr_in old;
>  
> -SEC("ksyscall/connect")
> -int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int addrlen)
> +static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
>  {
>  	struct sockaddr_in new;
>  
> @@ -19,4 +22,25 @@ int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int
>  	return 0;
>  }
>  
> +SEC("ksyscall/connect")
> +int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr,
> +		 int addrlen)
> +{
> +	return handle_sys_connect_common(uservaddr);
> +}
> +
> +SEC("ksyscall/socketcall")
> +int BPF_KSYSCALL(handle_sys_socketcall, int call, unsigned long *args)
> +{
> +	if (call == SYS_CONNECT) {
> +		struct sockaddr_in *uservaddr;
> +
> +		bpf_probe_read_user(&uservaddr, sizeof(uservaddr), &args[1]);
> +
> +		return handle_sys_connect_common(uservaddr);
> +	}
> +
> +	return 0;
> +}

should this function be under __s390x__ ifdef same as in the user side?

jirka
