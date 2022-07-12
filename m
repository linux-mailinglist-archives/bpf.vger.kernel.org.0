Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF38571C0A
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGLOPf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiGLOPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 10:15:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6A6069E;
        Tue, 12 Jul 2022 07:15:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so14581199ejb.4;
        Tue, 12 Jul 2022 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWItqk3wKGTm6WgbY9A7GkDr3k6MBq4Cfj9YjBA7C+A=;
        b=dbDeGGjHPxkW99VXoRzj5pHkeKOMsNh7lfKZKM3DFGIfpr+vvXKCLLf0AnJk1dp4wu
         /wQwYCpnEHa5TuLdisWFS0zLKO8nugzb6nVe/zFViKm+xAjGh3/EnA/X5UaNb4VqAFU3
         KZlJHxBhvpQBVox2oHobDA+xsH5Givu2CYxItL3uhYI3Bm1Gat31QSWOxO9Al9vweRWX
         hyDp/vDDClC7IQlupNNp4fLoiGRR/n7bKFb20cPzcqKQJP1pT24CoGBXmGra5swP22Oz
         T80hG3KFYnsVsM5jyBfK6JsBgLMsshR+Ir2oBI/OVj5dTv1eb7oYAd6rN1DzLAOfSCrA
         V+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWItqk3wKGTm6WgbY9A7GkDr3k6MBq4Cfj9YjBA7C+A=;
        b=vjeLVM84JHQqgzJm70/2zImbP8wGFldMJLnMKbH5KP843LTBeVODqmlJddSiqJ5xLJ
         SRYoNpSqrBfxALTZjxrtKx0SzRCmNRMBlNppP2iAo72Aga7h6Jllx6v809HzmsL+rOl9
         GVzlajx+0EPX5DGPl6LZN8Z9X6OY+kal04OHPV6qEyuZH7qNITZE3apfFr8TK6Mc5nvh
         wfemCoy12EyjpbtQ9nbf46dj/2T2vZe01uumRfsdDJpmbgDMFNICqJyP4bD7I/d+sYiV
         LXdlQchp2F8mDTYXW+l9BJcKk59zzW6LrTF+vspHilXHes7mGBznDMrZmpbo0RM+jpiQ
         eQuQ==
X-Gm-Message-State: AJIora+kqHa0N5WOu3cylwojMyg0lQbRHry4Yq51KD1cSEjdJa984HdU
        WP2S5STnBhuLQlrzQIt7XSY=
X-Google-Smtp-Source: AGRyM1tfPkl8g9DLNiM7KMvFfqFOrLfXPnQoDPKx4C1S+6KswdSZCSXUX1tGhOtCyVIK3P+DCvI5Sg==
X-Received: by 2002:a17:907:1c12:b0:72b:4a03:2290 with SMTP id nc18-20020a1709071c1200b0072b4a032290mr14031693ejc.163.1657635315637;
        Tue, 12 Jul 2022 07:15:15 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b00704fa2748ffsm3888352ejh.99.2022.07.12.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:15:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 16:15:11 +0200
To:     xiaolinkui <xiaolinkui@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] samples: bpf: Replace sizeof(arr)/sizeof(arr[0]) with
 ARRAY_SIZE
Message-ID: <Ys2B77DB7Fq33VA3@krava>
References: <20220712072302.13761-1-xiaolinkui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712072302.13761-1-xiaolinkui@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 03:23:02PM +0800, xiaolinkui wrote:
> From: Linkui Xiao<xiaolinkui@kylinos.cn>
> 
> The ARRAY_SIZE macro is more compact and more formal in linux source.
> 
> Signed-off-by: Linkui Xiao<xiaolinkui@kylinos.cn>

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  samples/bpf/fds_example.c          | 3 ++-
>  samples/bpf/sock_example.c         | 3 ++-
>  samples/bpf/test_cgrp2_attach.c    | 3 ++-
>  samples/bpf/test_lru_dist.c        | 2 +-
>  samples/bpf/test_map_in_map_user.c | 4 +++-
>  samples/bpf/tracex5_user.c         | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
> index 16dbf49e0f19..88a26f3ce201 100644
> --- a/samples/bpf/fds_example.c
> +++ b/samples/bpf/fds_example.c
> @@ -17,6 +17,7 @@
>  #include <bpf/libbpf.h>
>  #include "bpf_insn.h"
>  #include "sock_example.h"
> +#include "bpf_util.h"
>  
>  #define BPF_F_PIN	(1 << 0)
>  #define BPF_F_GET	(1 << 1)
> @@ -52,7 +53,7 @@ static int bpf_prog_create(const char *object)
>  		BPF_MOV64_IMM(BPF_REG_0, 1),
>  		BPF_EXIT_INSN(),
>  	};
> -	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
> +	size_t insns_cnt = ARRAY_SIZE(insns);
>  	struct bpf_object *obj;
>  	int err;
>  
> diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
> index a88f69504c08..5b66f2401b96 100644
> --- a/samples/bpf/sock_example.c
> +++ b/samples/bpf/sock_example.c
> @@ -29,6 +29,7 @@
>  #include <bpf/bpf.h>
>  #include "bpf_insn.h"
>  #include "sock_example.h"
> +#include "bpf_util.h"
>  
>  char bpf_log_buf[BPF_LOG_BUF_SIZE];
>  
> @@ -58,7 +59,7 @@ static int test_sock(void)
>  		BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
>  		BPF_EXIT_INSN(),
>  	};
> -	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> +	size_t insns_cnt = ARRAY_SIZE(prog);
>  	LIBBPF_OPTS(bpf_prog_load_opts, opts,
>  		.log_buf = bpf_log_buf,
>  		.log_size = BPF_LOG_BUF_SIZE,
> diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
> index 6d90874b09c3..68ce69457afe 100644
> --- a/samples/bpf/test_cgrp2_attach.c
> +++ b/samples/bpf/test_cgrp2_attach.c
> @@ -31,6 +31,7 @@
>  #include <bpf/bpf.h>
>  
>  #include "bpf_insn.h"
> +#include "bpf_util.h"
>  
>  enum {
>  	MAP_KEY_PACKETS,
> @@ -70,7 +71,7 @@ static int prog_load(int map_fd, int verdict)
>  		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
>  		BPF_EXIT_INSN(),
>  	};
> -	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> +	size_t insns_cnt = ARRAY_SIZE(prog);
>  	LIBBPF_OPTS(bpf_prog_load_opts, opts,
>  		.log_buf = bpf_log_buf,
>  		.log_size = BPF_LOG_BUF_SIZE,
> diff --git a/samples/bpf/test_lru_dist.c b/samples/bpf/test_lru_dist.c
> index be98ccb4952f..5efb91763d65 100644
> --- a/samples/bpf/test_lru_dist.c
> +++ b/samples/bpf/test_lru_dist.c
> @@ -523,7 +523,7 @@ int main(int argc, char **argv)
>  		return -1;
>  	}
>  
> -	for (f = 0; f < sizeof(map_flags) / sizeof(*map_flags); f++) {
> +	for (f = 0; f < ARRAY_SIZE(map_flags); f++) {
>  		test_lru_loss0(BPF_MAP_TYPE_LRU_HASH, map_flags[f]);
>  		test_lru_loss1(BPF_MAP_TYPE_LRU_HASH, map_flags[f]);
>  		test_parallel_lru_loss(BPF_MAP_TYPE_LRU_HASH, map_flags[f],
> diff --git a/samples/bpf/test_map_in_map_user.c b/samples/bpf/test_map_in_map_user.c
> index e8b4cc184ac9..652ec720533d 100644
> --- a/samples/bpf/test_map_in_map_user.c
> +++ b/samples/bpf/test_map_in_map_user.c
> @@ -12,6 +12,8 @@
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
>  
> +#include "bpf_util.h"
> +
>  static int map_fd[7];
>  
>  #define PORT_A		(map_fd[0])
> @@ -28,7 +30,7 @@ static const char * const test_names[] = {
>  	"Hash of Hash",
>  };
>  
> -#define NR_TESTS (sizeof(test_names) / sizeof(*test_names))
> +#define NR_TESTS ARRAY_SIZE(test_names)
>  
>  static void check_map_id(int inner_map_fd, int map_in_map_fd, uint32_t key)
>  {
> diff --git a/samples/bpf/tracex5_user.c b/samples/bpf/tracex5_user.c
> index e910dc265c31..9d7d79f0d47d 100644
> --- a/samples/bpf/tracex5_user.c
> +++ b/samples/bpf/tracex5_user.c
> @@ -8,6 +8,7 @@
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
>  #include "trace_helpers.h"
> +#include "bpf_util.h"
>  
>  #ifdef __mips__
>  #define	MAX_ENTRIES  6000 /* MIPS n64 syscalls start at 5000 */
> @@ -24,7 +25,7 @@ static void install_accept_all_seccomp(void)
>  		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
>  	};
>  	struct sock_fprog prog = {
> -		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
> +		.len = (unsigned short)ARRAY_SIZE(filter),
>  		.filter = filter,
>  	};
>  	if (prctl(PR_SET_SECCOMP, 2, &prog))
> -- 
> 2.17.1
> 
