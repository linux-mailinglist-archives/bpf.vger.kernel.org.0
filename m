Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917C544EEAF
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhKLVhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhKLVhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 16:37:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED677C061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 13:34:13 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 136so4458075pgc.0
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKihG9dhLVrR3j8LqT6pIgYxp3DXDcFgJpy65gWmXRI=;
        b=k1J5hg2ZKPcy72ddWhR0R3r+lm6MpuOsSW/+FoIj6HqH0H3pcQrnX+B6QQy+Jc1+vZ
         eZxI2RYxCI30NHOzE4rf/YOZF9VoU12Y0EKGXSPZ7Ho3Ud8UnjJIJjEoCCjfBfy8+D/+
         DX9NSatqaPufPVW/ZRBZv7wH1KGuszrif+79WTKSN7VCo8LanHwgb3sZV5XBQILbacmm
         qJy8z7Ltt5i5gvEGfk9Wd2VkDwDLfRD/o98/RC6rzrKl5G4VeW11OCfLbMNq8VZ4aj+X
         qBaZyrYOjIQo18ZfvmHbFXaR5uLNHs5aRbaUBnQs/QwvJnw9S/tIu67yZrfSe0DQ1+Dh
         yiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKihG9dhLVrR3j8LqT6pIgYxp3DXDcFgJpy65gWmXRI=;
        b=TbT16J6w5iTsSMrWgf7D51bcs+0cJXRGZYbNN+ha5BfJCvHb7EVL1OjNK69/yo8RoM
         7a2Fu6+5jHWKpPtUi2Grzk8GQ9600xE4YqDqH6fF3nwmZsd+J3bcUzLgHmWSN34SYOy5
         Pd2CmdA1xDONTG9sF3NHoHqhx45IiQqsaq+VHQymS9bdCKE3vZiQNHGfAKzlc+eJseWr
         oQHiE33l3H7oT+W2ND2XQ6hpL0sKzcm2xWV6q/vHPrtB7CptfT49XLgQfGdq/opVlBFK
         hwjY7ySpWIFwEWvmtUV5UHC4BrEGrzhkYf1x9Yejh/mUOH/vc7snA13AeC+212fyApQM
         3/Zw==
X-Gm-Message-State: AOAM533ijoclTRqWf+hB7hwzu9GeXvjuJiI0vABKzPNCReY7t2J3qWba
        CimDb5PteP4WLBk/B+eJoyY=
X-Google-Smtp-Source: ABdhPJwzhom2x+Csz3DLF4vvBn107uYJzZt3ga0CP+MMiPGZty7m4TtU7nS0hHsXIcbwPpTmvQGRCg==
X-Received: by 2002:a05:6a00:1993:b0:49f:d53f:ec1f with SMTP id d19-20020a056a00199300b0049fd53fec1fmr16608168pfl.49.1636752853355;
        Fri, 12 Nov 2021 13:34:13 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8382])
        by smtp.gmail.com with ESMTPSA id d24sm6996864pfn.62.2021.11.12.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:34:12 -0800 (PST)
Date:   Fri, 12 Nov 2021 13:34:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Perform map fd cleanup for gen_loader in
 case of error
Message-ID: <20211112213411.m3uxisnzkzkyf2os@ast-mbp.dhcp.thefacebook.com>
References: <20211112202421.720179-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112202421.720179-1-memxor@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 13, 2021 at 01:54:21AM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 7b73f97b1fa1..558479c13c77 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -18,7 +18,7 @@
>  #define MAX_USED_MAPS	64
>  #define MAX_USED_PROGS	32
>  #define MAX_KFUNC_DESCS 256
> -#define MAX_FD_ARRAY_SZ (MAX_USED_PROGS + MAX_KFUNC_DESCS)
> +#define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)

Lol. Not sure how I missed it during code review :)

>  void bpf_gen__init(struct bpf_gen *gen, int log_level)
>  {
>  	size_t stack_sz = sizeof(struct loader_stack);
> @@ -120,8 +146,12 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
>  
>  	/* jump over cleanup code */
>  	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> -			      /* size of cleanup code below */
> -			      (stack_sz / 4) * 3 + 2));
> +			      /* size of cleanup code below (including map fd cleanup) */
> +			      (stack_sz / 4) * 3 + 2 + (MAX_USED_MAPS *
> +			      /* 6 insns for emit_sys_close_blob,
> +			       * 6 insns for debug_regs in emit_sys_close_blob
> +			       */
> +			      (6 + (gen->log_level ? 6 : 0)))));
>  
>  	/* remember the label where all error branches will jump to */
>  	gen->cleanup_label = gen->insn_cur - gen->insn_start;
> @@ -131,37 +161,19 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
>  		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
>  		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
>  	}
> +	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));

could you move this line to be the first thing in bpf_gen__init() ?
Otherwise it looks like that fd_array is only used in cleanup part while
it's actually needed everywhere.

> +	for (i = 0; i < MAX_USED_MAPS; i++)
> +		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));

I confess that commit 30f51aedabda ("libbpf: Cleanup temp FDs when intermediate sys_bpf fails.")
wasn't great in terms of redundant code gen for closing all 32 + 64 FDs.
But can we make it better while we're at it?
Most bpf files don't have 32 progs and 64 maps while gen_loader emits
(32 + 64) * 6 = 576 instructions (without debug).
While debugging/developing gen_loader this large cleanup code is just noise.

I tested the following:

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 75ca9fb857b2..cc486a77db65 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -47,8 +47,8 @@ struct bpf_gen {
        int nr_fd_array;
 };

-void bpf_gen__init(struct bpf_gen *gen, int log_level);
-int bpf_gen__finish(struct bpf_gen *gen);
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
+int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
 void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_params *map_attr, int map_idx);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..f7b78478a9d3 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -102,7 +102,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
        emit(gen, insn2);
 }

-void bpf_gen__init(struct bpf_gen *gen, int log_level)
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
        size_t stack_sz = sizeof(struct loader_stack);
        int i;
@@ -359,10 +359,15 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
        __emit_sys_close(gen);
 }

-int bpf_gen__finish(struct bpf_gen *gen)
+int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 {
        int i;

+       if (nr_progs != gen->nr_progs || nr_maps != gen->nr_maps) {
+               pr_warn("progs/maps mismatch\n");
+               gen->error = -EFAULT;
+               return gen->error;
+       }
        emit_sys_close_stack(gen, stack_off(btf_fd));
        for (i = 0; i < gen->nr_progs; i++)
                move_stack2ctx(gen,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..f6faa33c80fa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7263,7 +7263,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
        }

        if (obj->gen_loader)
-               bpf_gen__init(obj->gen_loader, attr->log_level);
+               bpf_gen__init(obj->gen_loader, attr->log_level, obj->nr_programs, obj->nr_maps);

        err = bpf_object__probe_loading(obj);
        err = err ? : bpf_object__load_vmlinux_btf(obj, false);
@@ -7282,7 +7282,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
                for (i = 0; i < obj->nr_maps; i++)
                        obj->maps[i].fd = -1;
                if (!err)
-                       err = bpf_gen__finish(obj->gen_loader);
+                       err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
        }

        /* clean up fd_array */

and it seems to work.

So cleanup code can close only nr_progs + nr_maps FDs.
gen_loader prog will be much shorter and will be processed by the verifier faster.
MAX_FD_ARRAY_SZ can stay fixed. Reducing data size is not worth it.
wdyt?
