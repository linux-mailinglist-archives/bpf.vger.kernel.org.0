Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4606D3B8D
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 03:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjDCBjt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 21:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjDCBjs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 21:39:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D0E7EE8
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 18:39:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so26537504plb.5
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680485985; x=1683077985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPsb3o5OGFFWGexRlIhq7RhQGGrIyVvgWZUnZiqS5bc=;
        b=ex4KM6IwqlTrUve+dLetz3qB08AJuX1zAy1BwauaiFqO1gKLHECu62AeCJ0jGhXQzH
         3coAZNBtmxkF0CqU5NaRlOYshWolEtkgcV+StQcui7ms5zKaRRY/WVngsducnzR9r0Aa
         Bfde9PAcFKgw+Zr31W8TBxNpnMOXGCEbqFo5OqLcabmAS/NVLX81nWjyTTTfODejwkdg
         CvzCKZq+n8bfsv0/V2DtrhxC+GlB+HXu7QZ3b0iJcooJ2b8go7+L6qNDIdMLyPttHaUS
         VX0xHfdTUOLFewG6VuBUbtbCZ/I8IKfS+Esa7KReO40VwJqfAPkFLXkC/YSxiOqYRnYb
         0kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680485985; x=1683077985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPsb3o5OGFFWGexRlIhq7RhQGGrIyVvgWZUnZiqS5bc=;
        b=tj7VrqfN6snTv7iz8fEJthgtpZnUl0W0iTD0PCe3nbbG2vb0Zb9AegwGKPfO0HQDD1
         YfuI5WuzNCX2NBnuXBpbQXxiexJJUW2muqFOJq4M5wgAxMC/y2ls6onHq8inMzL+urxW
         pJcsFPP9oan/E6WNqCIT+Yp8gdBfZV+p7KyF6yQe+Y2hTCh3kximdWBq7Fvqb+t8+JS5
         BmpyzSVLh5NSAqPJJUW2/SvU+I3NHtio6KI15DHl1lpE+V7KUxpYIpZSw1Zk8RY+ENeK
         jUiISuHFNOAe4pUKLsPNXkkJLF05c3MRPFAEhLfawne85HTUwnvsTkdSqHfE84vVFuHf
         OC3A==
X-Gm-Message-State: AO0yUKVZw8W9XNGDYHBaPmN4UVU0iV6x5EyW/1x9sRtWsZJtdIt8+9go
        TPiaZAAGdNv0smwbFQcpYOs=
X-Google-Smtp-Source: AK7set8pA3AqchzSmfPjIZdyxn+Kf9v0eE949XrrnYZVr2LfqbdDOTVQPIuCT13M4ox1fKPhqp5DUQ==
X-Received: by 2002:a05:6a20:811a:b0:db:d1d5:1e00 with SMTP id g26-20020a056a20811a00b000dbd1d51e00mr29971793pza.60.1680485984896;
        Sun, 02 Apr 2023 18:39:44 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3c8])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0062dd1c55346sm5564579pfk.67.2023.04.02.18.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 18:39:44 -0700 (PDT)
Date:   Sun, 2 Apr 2023 18:39:41 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add a new test based on
 loop6.c
Message-ID: <20230403013941.35yemjpee4bh7yh3@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055636.93471-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330055636.93471-1-yhs@fb.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 10:56:36PM -0700, Yonghong Song wrote:
> With LLVM commit [1], loop6.c will fail verification without Commit 3c2611bac08a
> ("selftests/bpf: Fix trace_virtqueue_add_sgs test issue with LLVM 17.").
> Also, there is an effort to fix LLVM since LLVM17 may be used by old kernels
> for bpf development.
> 
> A new test is added by manually doing similar transformation in [1]
> so it can be used to test related verifier changes.
> 
>   [1] https://reviews.llvm.org/D143726
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../bpf/prog_tests/bpf_verif_scale.c          |   5 +
>  tools/testing/selftests/bpf/progs/loop7.c     | 102 ++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/loop7.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index 731c343897d8..cb708235e654 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> @@ -180,6 +180,11 @@ void test_verif_scale_loop6()
>  	scale_test("loop6.bpf.o", BPF_PROG_TYPE_KPROBE, false);
>  }
>  
> +void test_verif_scale_loop7()
> +{
> +	scale_test("loop7.bpf.o", BPF_PROG_TYPE_KPROBE, false);
> +}
> +
>  void test_verif_scale_strobemeta()
>  {
>  	/* partial unroll. 19k insn in a loop.
> diff --git a/tools/testing/selftests/bpf/progs/loop7.c b/tools/testing/selftests/bpf/progs/loop7.c
> new file mode 100644
> index 000000000000..b234ed6f0038
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/loop7.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ptrace.h>
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/* typically virtio scsi has max SGs of 6 */
> +#define VIRTIO_MAX_SGS	6
> +
> +/* Verifier will fail with SG_MAX = 128. The failure can be
> + * workarounded with a smaller SG_MAX, e.g. 10.
> + */
> +#define WORKAROUND
> +#ifdef WORKAROUND
> +#define SG_MAX		10
> +#else
> +/* typically virtio blk has max SEG of 128 */
> +#define SG_MAX		128
> +#endif
> +
> +#define SG_CHAIN	0x01UL
> +#define SG_END		0x02UL
> +
> +struct scatterlist {
> +	unsigned long   page_link;
> +	unsigned int    offset;
> +	unsigned int    length;
> +};
> +
> +#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
> +#define sg_is_last(sg)		((sg)->page_link & SG_END)
> +#define sg_chain_ptr(sg)	\
> +	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
> +
> +static inline struct scatterlist *__sg_next(struct scatterlist *sgp)
> +{
> +	struct scatterlist sg;
> +
> +	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
> +	if (sg_is_last(&sg))
> +		return NULL;
> +
> +	sgp++;
> +
> +	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
> +	if (sg_is_chain(&sg))
> +		sgp = sg_chain_ptr(&sg);
> +
> +	return sgp;
> +}
> +
> +static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
> +{
> +	struct scatterlist *sgp;
> +
> +	bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
> +	return sgp;
> +}
> +
> +int config = 0;
> +int result = 0;
> +
> +SEC("kprobe/virtqueue_add_sgs")
> +int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist **sgs,
> +	       unsigned int out_sgs, unsigned int in_sgs)
> +{
> +	struct scatterlist *sgp = NULL;
> +	__u64 length1 = 0, length2 = 0;
> +	unsigned int i, n, len, upper;
> +
> +	if (config != 0)
> +		return 0;
> +
> +	upper = out_sgs < VIRTIO_MAX_SGS ? out_sgs : VIRTIO_MAX_SGS;
> +	for (i = 0; i < upper; i++) {

since this test is doing manual hoistMinMax, let's keep __sink() in test 6,
so we guaranteed to have both flavors regardless of compiler choices?
