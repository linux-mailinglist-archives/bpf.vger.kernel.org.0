Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E54D1A52
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiCHOYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 09:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCHOYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 09:24:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318629836
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 06:23:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b5so28857585wrr.2
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wg0cmVlBhtIvCn2CWuyljNv8WfQik+vfSi2qSfN5hpQ=;
        b=Opb8wjzo1VHzUBt4VRrx1dKc8uuNi6VIWDeg8IWE0KKSBJLsfhgED81IsZt65wYzCE
         Sh64XlsRmht+GKWzxdckoFWc0x2YrD2g1JVkmedFGR9bIGCbeFi39v2hqB2FmsmFMdew
         p1c4tIr8yYNAO1c9eTVOEZH1sS7ycmS2Vva59RytGxb89+35UYbfWbMFz9chVL58pk0a
         bTDFs/ksIgD+v6Z0Qp+HFxTbiMba4E8IyS9zsbunqZxcwlARNnh4NSHi8ZUtwk7kXcI0
         AnYOcg3IeYL4xFCmrev3vho9i7FJ+W2/xPtAkGkhFicFVhPnXH657zALgFATbAOnu+Z1
         t5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wg0cmVlBhtIvCn2CWuyljNv8WfQik+vfSi2qSfN5hpQ=;
        b=KvAqBV8SZ2EVD8pOKLQ3wLXmI99WLTy+Q1Pp/4nDcweh8VHO+HnabkfTmRc97Uwtjh
         cqAaKY/NqFe/e7GDFMJv97fiT0EsLOkm6lhrLQqlPcQjKhX3eKSuVi+NPts6/XHYik3C
         8iLqa6dW6azqrj6THk1qxLVh93xeTIvj6X7zSAPbgk68NT8s016+GgtWlMs+q5NZQ7Gm
         Ohs7TXqYxRD4BjVgeQeyLqqdOZlCXl3v8uh4S6B87plLAYBGd2iAnFXxYug+cIm0dGUn
         jHxfZTWoQo/5yvChKHk7bDMk7hJQdW0Jt+JkycS3Nbm1K4KzL6dV372ewhg/6LY54HoN
         7X6Q==
X-Gm-Message-State: AOAM532ieItxPIzgC8YtUMpN2FDyyH7qJZQImj8QxheMU/mGHOTJMvfz
        Yvi8TnRb/djabaYQClDcIS8AgLGws9cGbzoHnrg=
X-Google-Smtp-Source: ABdhPJw9WB+9ku9o5jD0zU3/FjRSLpLnkoV9HOp3TLBlbV7yn1WR9h5LOOnOEoT3iK90peAXgmgUqQ==
X-Received: by 2002:a05:6000:154b:b0:1f0:4c09:ae5e with SMTP id 11-20020a056000154b00b001f04c09ae5emr12833333wry.610.1646749412772;
        Tue, 08 Mar 2022 06:23:32 -0800 (PST)
Received: from [192.168.1.8] ([149.86.69.167])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d40c5000000b001f07ab4f2d7sm10674077wrq.17.2022.03.08.06.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:23:32 -0800 (PST)
Message-ID: <25f003df-97cb-549b-e117-2eb1fa2f3cc2@isovalent.com>
Date:   Tue, 8 Mar 2022 14:23:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
Content-Language: en-GB
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com
References: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-08 12:30 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> feature probing") removed the support to probe for BPF offload features.
> This is still something that is useful for NFP NIC that can support
> offloading of BPF programs.
> 
> The reason for the dropped support was that libbpf starting with v1.0
> would drop support for passing the ifindex to the BPF prog/map/helper
> feature probing APIs. In order to keep this useful feature for NFP
> restore the functionality by moving it directly into bpftool.
> 
> The code restored is a simplified version of the code that existed in
> libbpf which supposed passing the ifindex. The simplification is that it
> only targets the cases where ifindex is given and call into libbpf for
> the cases where it's not.
> 
> Before restoring support for probing offload features:
> 
>   # bpftool feature probe dev ens4np0
>   Scanning system call availability...
>   bpf() syscall is available
> 
>   Scanning eBPF program types...
> 
>   Scanning eBPF map types...
> 
>   Scanning eBPF helper functions...
>   eBPF helpers supported for program type sched_cls:
>   eBPF helpers supported for program type xdp:
> 
>   Scanning miscellaneous eBPF features...
>   Large program size limit is NOT available
>   Bounded loop support is NOT available
>   ISA extension v2 is NOT available
>   ISA extension v3 is NOT available
> 
> With support for probing offload features restored:
> 
>   # bpftool feature probe dev ens4np0
>   Scanning system call availability...
>   bpf() syscall is available
> 
>   Scanning eBPF program types...
>   eBPF program_type sched_cls is available
>   eBPF program_type xdp is available
> 
>   Scanning eBPF map types...
>   eBPF map_type hash is available
>   eBPF map_type array is available
>   eBPF map_type prog_array is NOT available
>   eBPF map_type perf_event_array is NOT available
>   eBPF map_type percpu_hash is NOT available
>   eBPF map_type percpu_array is NOT available
>   eBPF map_type stack_trace is NOT available
>   eBPF map_type cgroup_array is NOT available
>   eBPF map_type lru_hash is NOT available
>   eBPF map_type lru_percpu_hash is NOT available
>   eBPF map_type lpm_trie is NOT available
>   eBPF map_type array_of_maps is NOT available
>   eBPF map_type hash_of_maps is NOT available
>   eBPF map_type devmap is NOT available
>   eBPF map_type sockmap is NOT available
>   eBPF map_type cpumap is NOT available
>   eBPF map_type xskmap is NOT available
>   eBPF map_type sockhash is NOT available
>   eBPF map_type cgroup_storage is NOT available
>   eBPF map_type reuseport_sockarray is NOT available
>   eBPF map_type percpu_cgroup_storage is NOT available
>   eBPF map_type queue is NOT available
>   eBPF map_type stack is NOT available
>   eBPF map_type sk_storage is NOT available
>   eBPF map_type devmap_hash is NOT available
>   eBPF map_type struct_ops is NOT available
>   eBPF map_type ringbuf is NOT available
>   eBPF map_type inode_storage is NOT available
>   eBPF map_type task_storage is NOT available
>   eBPF map_type bloom_filter is NOT available
> 
>   Scanning eBPF helper functions...
>   eBPF helpers supported for program type sched_cls:
>   	- bpf_map_lookup_elem
>   	- bpf_get_prandom_u32
>   	- bpf_perf_event_output
>   eBPF helpers supported for program type xdp:
>   	- bpf_map_lookup_elem
>   	- bpf_get_prandom_u32
>   	- bpf_perf_event_output
>   	- bpf_xdp_adjust_head
>   	- bpf_xdp_adjust_tail
> 
>   Scanning miscellaneous eBPF features...
>   Large program size limit is NOT available
>   Bounded loop support is NOT available
>   ISA extension v2 is NOT available
>   ISA extension v3 is NOT available
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> Signed-off-by: Simon Horman <simon.horman@corigine.com>
> ---
>  tools/bpf/bpftool/feature.c | 185 +++++++++++++++++++++++++++++++++---
>  1 file changed, 170 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 9c894b1447de8cf0..4943beb1823111c8 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -3,6 +3,7 @@
>  
>  #include <ctype.h>
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include <net/if.h>
> @@ -45,6 +46,11 @@ static bool run_as_unprivileged;
>  
>  /* Miscellaneous utility functions */
>  
> +static bool grep(const char *buffer, const char *pattern)
> +{
> +	return !!strstr(buffer, pattern);
> +}
> +
>  static bool check_procfs(void)
>  {
>  	struct statfs st_fs;
> @@ -135,6 +141,32 @@ static void print_end_section(void)
>  
>  /* Probing functions */
>  
> +static int get_vendor_id(int ifindex)
> +{
> +	char ifname[IF_NAMESIZE], path[64], buf[8];
> +	ssize_t len;
> +	int fd;
> +
> +	if (!if_indextoname(ifindex, ifname))
> +		return -1;
> +
> +	snprintf(path, sizeof(path), "/sys/class/net/%s/device/vendor", ifname);
> +
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = read(fd, buf, sizeof(buf));
> +	close(fd);
> +	if (len < 0)
> +		return -1;
> +	if (len >= (ssize_t)sizeof(buf))
> +		return -1;
> +	buf[len] = '\0';
> +
> +	return strtol(buf, NULL, 0);
> +}
> +
>  static int read_procfs(const char *path)
>  {
>  	char *endptr, *line = NULL;
> @@ -478,6 +510,69 @@ static bool probe_bpf_syscall(const char *define_prefix)
>  	return res;
>  }
>  
> +static int
> +probe_prog_load_ifindex(enum bpf_prog_type prog_type,
> +			const struct bpf_insn *insns, size_t insns_cnt,
> +			char *log_buf, size_t log_buf_sz,
> +			__u32 ifindex)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		    .log_buf = log_buf,
> +		    .log_size = log_buf_sz,
> +		    .log_level = log_buf ? 1 : 0,
> +		    .prog_ifindex = ifindex,
> +		   );
> +	const char *exp_msg = NULL;
> +	int fd, err, exp_err = 0;
> +	char buf[4096];
> +
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_SCHED_CLS:
> +	case BPF_PROG_TYPE_XDP:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;

This will not be caught in probe_prog_type_ifindex(), where you only
check for the errno value, will it? You should also check the return
code from probe_prog_load_ifindex()? (Same thing in probe_helper_ifindex()).

You could also get rid of this switch entirely, because the function is
never called with a program type other than TC or XDP (given that you
already check in probe_prog_type(), and helper probes are only run
against supported program tyeps).

> +	}
> +
> +	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
> +	err = -errno;
> +	if (fd >= 0)
> +		close(fd);
> +	if (exp_err) {

exp_err is always 0, you don't need this part. I think this is a
leftover of the previous libbpf probes.

> +		if (fd >= 0 || err != exp_err)
> +			return 0;
> +		if (exp_msg && !strstr(buf, exp_msg))
> +			return 0;
> +		return 1;
> +	}
> +	return fd >= 0 ? 1 : 0;
> +}
> +
> +static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
> +{
> +	struct bpf_insn insns[2] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN()
> +	};
> +
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_SCHED_CLS:
> +		/* nfp returns -EINVAL on exit(0) with TC offload */
> +		insns[0].imm = 2;
> +		break;
> +	case BPF_PROG_TYPE_XDP:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	errno = 0;
> +	probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), NULL, 0,
> +				ifindex);
> +
> +	return errno != EINVAL && errno != EOPNOTSUPP;
> +}
> +
>  static void
>  probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  		const char *define_prefix, __u32 ifindex)
> @@ -488,11 +583,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  	bool res;
>  
>  	if (ifindex) {
> -		p_info("BPF offload feature probing is not supported");
> -		return;
> +		switch (prog_type) {
> +		case BPF_PROG_TYPE_SCHED_CLS:
> +		case BPF_PROG_TYPE_XDP:
> +			break;
> +		default:
> +			return;
> +		}

Here we skip the probe entirely (we don't print a result, even negative)
for types that are not supported by the SmartNICs today. But for map
types, the equivalent switch is in probe_map_type_ifindex(), and it
skips the actual bpf() syscall but it doesn't skip the part where we
print a result.

This means that the output for program types shows the result for just
TC/XDP, while the output for map types shows the result for all maps
known to bpftool, even if we “know” they are not supported for offload.
This shows in your commit description. Could we harmonise between maps
and programs? I don't mind much either way you choose, printing all or
printing few.

Thanks,
Quentin
