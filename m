Return-Path: <bpf+bounces-395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187C700887
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FCC281B25
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F81DDEA;
	Fri, 12 May 2023 12:59:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556139466
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 12:59:42 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E1903E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 05:59:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965d2749e2eso1461245966b.1
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683896379; x=1686488379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fJfX3wMs+ZqTFEmZfslfQ5/jnm5TTN8+xt0Vl048PA=;
        b=EYSe27EcAcpT7jnMEwmz0DSPFo+7OvhSFRwgUAGaInFbx8XUkoe49W+LROKkGcNNqD
         AlOG+qKruYX/B/8UvVJWEOCgRLbVdLcnFAIAe345ShY4dsMaBqz9mEnkjACFKuKkCNvJ
         sNM3uUNxV9+LKUTiLY5219hv4V12YXAmHC5A+ZJoLxoqiUqvCCR7YU9k9OvJPuGuY/XK
         vwLTdTXW6n76LAXUfb1rnp74NIUckH/gAY6bhDUSc0W17TMw/85yCAeS0CqAOeWXxZ6P
         DkUFZ5+OjyjLRxtLFMY469c5OeARKKYub6V0M5huXGRwtj1hkZn/azJFZZxlW9080mhR
         uaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896379; x=1686488379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fJfX3wMs+ZqTFEmZfslfQ5/jnm5TTN8+xt0Vl048PA=;
        b=GGjA55voacGjpFrbYfdieusG/ic9BRTzFeWrH4BDjtnXk/hqD20RQThBpYjgac4fx7
         ZhWV2uKuW4GgkixwasKkcvQ1MdM5vRxX4BtNg7RfcZHmUZtYGTnp5t4oR+BCPIofWjOV
         pHe57ukTXJVLGBVYWSjO7HOBPpLs86fohAQ/rTU0V38sVHm9fR6wY2VbMB4E2tuLYhNL
         uZhyF4vEgHPk6gmTFvJBrwaU5zlxtS/UMnmR5g5hRQS275TjBbMdddz9j/1sM7S81DlP
         r7Wf7k+Uc8zMYyj2XUzdihVri2VoywIGaxCK1VASJ7NOJuoTzw2JVbX9S28sdACI4ebK
         GcNg==
X-Gm-Message-State: AC+VfDxWCqCp5io1RxHsHghErtq5nFEFAw0KNBI/67cwPWrpi/KFjJNx
	eTm4odzwWppias60YmjoZv8=
X-Google-Smtp-Source: ACHHUZ7Si/7Aplbmd51IMQ0abCSInx2C577EZH/hkdp40pRzi8Y+UXGMY36vt3iABfVJWnnnwvAscw==
X-Received: by 2002:a17:906:ee8e:b0:95e:c549:9ace with SMTP id wt14-20020a170906ee8e00b0095ec5499acemr21200125ejb.62.1683896378482;
        Fri, 12 May 2023 05:59:38 -0700 (PDT)
Received: from krava (213-240-85-134.hdsl.highway.telekom.at. [213.240.85.134])
        by smtp.gmail.com with ESMTPSA id ia2-20020a170907a06200b00959c07bdbc8sm5408354ejc.100.2023.05.12.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:59:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 May 2023 14:59:35 +0200
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value
 to fix accessing its fields
Message-ID: <ZF44Nzzw09x2n88o@krava>
References: <20230512103354.48374-1-quentin@isovalent.com>
 <20230512103354.48374-5-quentin@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512103354.48374-5-quentin@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 11:33:54AM +0100, Quentin Monnet wrote:
> From: Alexander Lobakin <alobakin@pm.me>
> 
> Fix the following error when building bpftool:
> 
>   CLANG   profiler.bpf.o
>   CLANG   pid_iter.bpf.o
> skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
>         __uint(value_size, sizeof(struct bpf_perf_event_value));
>                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
> struct bpf_perf_event_value;
>        ^
> 
> struct bpf_perf_event_value is being used in the kernel only when
> CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.

hi,
when I switch off CONFIG_BPF_EVENTS the bpftool build fails for me
with missing BTF error:

  GEN     vmlinux.h
libbpf: failed to find '.BTF' ELF section in /home/jolsa/kernel/linux-qemu/vmlinux
Error: failed to load BTF from /home/jolsa/kernel/linux-qemu/vmlinux: No data available
make: *** [Makefile:208: vmlinux.h] Error 195
make: *** Deleting file 'vmlinux.h'

so I wonder you need to care about bpf_perf_event_value
in that case

jirka

> Define struct bpf_perf_event_value___local with the
> `preserve_access_index` attribute inside the pid_iter BPF prog to
> allow compiling on any configs. It is a full mirror of a UAPI
> structure, so is compatible both with and w/o CO-RE.
> bpf_perf_event_read_value() requires a pointer of the original type,
> so a cast is needed.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 27 ++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> index ce5b65e07ab1..2f80edc682f1 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> @@ -4,6 +4,12 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> +struct bpf_perf_event_value___local {
> +	__u64 counter;
> +	__u64 enabled;
> +	__u64 running;
> +} __attribute__((preserve_access_index));
> +
>  /* map of perf event fds, num_cpu * num_metric entries */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> @@ -15,14 +21,14 @@ struct {
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>  	__uint(key_size, sizeof(u32));
> -	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
>  } fentry_readings SEC(".maps");
>  
>  /* accumulated readings */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>  	__uint(key_size, sizeof(u32));
> -	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
>  } accum_readings SEC(".maps");
>  
>  /* sample counts, one per cpu */
> @@ -39,7 +45,7 @@ const volatile __u32 num_metric = 1;
>  SEC("fentry/XXX")
>  int BPF_PROG(fentry_XXX)
>  {
> -	struct bpf_perf_event_value *ptrs[MAX_NUM_MATRICS];
> +	struct bpf_perf_event_value___local *ptrs[MAX_NUM_MATRICS];
>  	u32 key = bpf_get_smp_processor_id();
>  	u32 i;
>  
> @@ -53,10 +59,10 @@ int BPF_PROG(fentry_XXX)
>  	}
>  
>  	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
> -		struct bpf_perf_event_value reading;
> +		struct bpf_perf_event_value___local reading;
>  		int err;
>  
> -		err = bpf_perf_event_read_value(&events, key, &reading,
> +		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
>  						sizeof(reading));
>  		if (err)
>  			return 0;
> @@ -68,14 +74,14 @@ int BPF_PROG(fentry_XXX)
>  }
>  
>  static inline void
> -fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
> +fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>  {
> -	struct bpf_perf_event_value *before, diff;
> +	struct bpf_perf_event_value___local *before, diff;
>  
>  	before = bpf_map_lookup_elem(&fentry_readings, &id);
>  	/* only account samples with a valid fentry_reading */
>  	if (before && before->counter) {
> -		struct bpf_perf_event_value *accum;
> +		struct bpf_perf_event_value___local *accum;
>  
>  		diff.counter = after->counter - before->counter;
>  		diff.enabled = after->enabled - before->enabled;
> @@ -93,7 +99,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
>  SEC("fexit/XXX")
>  int BPF_PROG(fexit_XXX)
>  {
> -	struct bpf_perf_event_value readings[MAX_NUM_MATRICS];
> +	struct bpf_perf_event_value___local readings[MAX_NUM_MATRICS];
>  	u32 cpu = bpf_get_smp_processor_id();
>  	u32 i, zero = 0;
>  	int err;
> @@ -102,7 +108,8 @@ int BPF_PROG(fexit_XXX)
>  	/* read all events before updating the maps, to reduce error */
>  	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
>  		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
> -						readings + i, sizeof(*readings));
> +						(void *)(readings + i),
> +						sizeof(*readings));
>  		if (err)
>  			return 0;
>  	}
> -- 
> 2.34.1
> 

