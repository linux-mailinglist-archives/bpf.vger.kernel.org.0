Return-Path: <bpf+bounces-53739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D3A59A5A
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22FC16CDD6
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EB22CBF3;
	Mon, 10 Mar 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="movTzyNj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED411B3934;
	Mon, 10 Mar 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621759; cv=none; b=PldWuWKZXZJbWH6T1uRrABAPMBDO2bZnqir+dBl5qWIxxok3mekq5kcU8Pb3WW3n87MFm4GVNb6oSsnRxbwTpHqwD4M07MwSZaHoE8JALNA9xGJmxHXdGBC6Nquowm8tiZAfgotH1wvwlSgoy7vOhV2P6bANz8rc5TaZnnjR7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621759; c=relaxed/simple;
	bh=+IX+LJ7MTGdyqtBe4vRp7+Qs5oOEKhGq8+t84yoE8Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxcOb/vW7ewI3kgeg2o5bpjhKZaPw+2oFgS8QHh1AF78cNjq0NFqVtHMxTvNTpZPPos/cqYs1IvP8XZCmvZkjpnQqatiwF1JUuBBO5Zourm13DlQXFuEKTkd138YkM8Q04uwBhttFiCRMnuIBpR64qMQB/7xNd5XqeNgyRDpAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=movTzyNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B8C4CEEE;
	Mon, 10 Mar 2025 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741621759;
	bh=+IX+LJ7MTGdyqtBe4vRp7+Qs5oOEKhGq8+t84yoE8Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=movTzyNj4mfwJfalcPJ2qe15KhtO2brnQytr19sKL3SqEwA9dmTHt8WdM3TPwpqbi
	 CYP0RU72FiSumIOmjp9PmaZVwqvrM3myYP54iW9nodMrwOVLttTMf5EEuQq1FJ5mHI
	 8bKMbbMdiwGcosYdrxXz96ZEXH2ZkX+RSeVXesl2JbI/iIssJykAR/STSvvtOLAiTv
	 QqODVDDWMgrHO2ACq8X8mx/j4Mh1knicg1Jf4fA79as2KWRu2BH5oT/GUd3hhQhlZV
	 zHRdDH0P+KXNkOMHZDzmfUus6Il5rt4vPGpVeujXIIT6TId+2tT1SZPKMDcPSeoMLb
	 hdV/LQXn0gHBg==
Message-ID: <4b9fbfe7-294c-4b07-b986-6e378fecc5be@kernel.org>
Date: Mon, 10 Mar 2025 15:49:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] bpftool: Using the right format
 specifiers
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, linux-kernel@vger.kernel.org, ast@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mrpre@163.com
References: <20250310142037.45932-1-jiayuan.chen@linux.dev>
 <20250310142037.45932-3-jiayuan.chen@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250310142037.45932-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-10 22:20 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixed some formatting specifiers errors, such as using %d for int and %u
> for unsigned int, as well as other byte-length types.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/disasm.c                |  4 ++--
>  tools/bpf/bpftool/btf.c            | 14 +++++++-------
>  tools/bpf/bpftool/btf_dumper.c     |  2 +-
>  tools/bpf/bpftool/cgroup.c         |  2 +-
>  tools/bpf/bpftool/common.c         |  4 ++--
>  tools/bpf/bpftool/jit_disasm.c     |  3 ++-
>  tools/bpf/bpftool/map_perf_ring.c  |  6 +++---
>  tools/bpf/bpftool/net.c            |  4 ++--
>  tools/bpf/bpftool/netlink_dumper.c |  5 ++---
>  tools/bpf/bpftool/prog.c           | 12 ++++++------
>  tools/bpf/bpftool/tracelog.c       |  2 +-
>  tools/bpf/bpftool/xlated_dumper.c  |  6 +++---
>  12 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 974d172d6735..20883c6b1546 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -202,7 +202,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
>  				insn->dst_reg);
>  		} else if (is_addr_space_cast(insn)) {
> -			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %d, %d)\n",
> +			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)\n",
>  				insn->code, insn->dst_reg,
>  				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
>  		} else if (is_mov_percpu_addr(insn)) {
> @@ -381,7 +381,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  				insn->code, class == BPF_JMP32 ? 'w' : 'r',
>  				insn->dst_reg,
>  				bpf_jmp_string[BPF_OP(insn->code) >> 4],
> -				insn->imm, insn->off);
> +				(u32)insn->imm, insn->off);
>  		}
>  	} else {
>  		verbose(cbs->private_data, "(%02x) %s\n",
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 2636655ac180..4dc0ffdaf8ce 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -253,7 +253,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>  				if (btf_kflag(t))
>  					printf("\n\t'%s' val=%d", name, v->val);
>  				else
> -					printf("\n\t'%s' val=%u", name, v->val);
> +					printf("\n\t'%s' val=%d", name, v->val);


This one looks suspicious, it makes the two branches of the if/else the
same. See the JSON case right above, the "else" is meant to be printed
as an unsigned. You likely want a cast, instead.


>  			}
>  		}
>  		if (json_output)
> @@ -1022,7 +1022,7 @@ static int do_dump(int argc, char **argv)
>  			for (i = 0; i < root_type_cnt; i++) {
>  				if (root_type_ids[i] == root_id) {
>  					err = -EINVAL;
> -					p_err("duplicate root_id %d supplied", root_id);
> +					p_err("duplicate root_id %u supplied", root_id);
>  					goto done;
>  				}
>  			}
> @@ -1132,7 +1132,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>  			break;
>  		default:
>  			err = -1;
> -			p_err("unexpected object type: %d", type);
> +			p_err("unexpected object type: %u", type);
>  			goto err_free;
>  		}
>  		if (err) {
> @@ -1155,7 +1155,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>  			break;
>  		default:
>  			err = -1;
> -			p_err("unexpected object type: %d", type);
> +			p_err("unexpected object type: %u", type);
>  			goto err_free;
>  		}
>  		if (fd < 0) {
> @@ -1188,7 +1188,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>  			break;
>  		default:
>  			err = -1;
> -			p_err("unexpected object type: %d", type);
> +			p_err("unexpected object type: %u", type);
>  			goto err_free;
>  		}
>  		if (!btf_id)
> @@ -1254,12 +1254,12 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
>  
>  	n = 0;
>  	hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
> -		printf("%s%lu", n++ == 0 ? "  prog_ids " : ",", entry->value);
> +		printf("%s%ld", n++ == 0 ? "  prog_ids " : ",", entry->value);
>  	}
>  
>  	n = 0;
>  	hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
> -		printf("%s%lu", n++ == 0 ? "  map_ids " : ",", entry->value);
> +		printf("%s%ld", n++ == 0 ? "  map_ids " : ",", entry->value);
>  	}


Program and map IDs should likely be printed as unsigned. The values
stored in the hashmap come from unsigned IDs by the way, let's re-cast
entry->value instead.


>  
>  	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 527fe867a8fb..4e896d8a2416 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -653,7 +653,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
>  	case BTF_KIND_ARRAY:
>  		array = (struct btf_array *)(t + 1);
>  		BTF_PRINT_TYPE(array->type);
> -		BTF_PRINT_ARG("[%d]", array->nelems);
> +		BTF_PRINT_ARG("[%u]", array->nelems);
>  		break;
>  	case BTF_KIND_PTR:
>  		BTF_PRINT_TYPE(t->type);
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 9af426d43299..93b139bfb988 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -191,7 +191,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
>  		if (attach_btf_name)
>  			printf(" %-15s", attach_btf_name);
>  		else if (info.attach_btf_id)
> -			printf(" attach_btf_obj_id=%d attach_btf_id=%d",
> +			printf(" attach_btf_obj_id=%u attach_btf_id=%u",
>  			       info.attach_btf_obj_id, info.attach_btf_id);
>  		printf("\n");
>  	}
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 0a764426d935..ecfa790adc13 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -714,7 +714,7 @@ ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt)
>  	int vendor_id;
>  
>  	if (!ifindex_to_name_ns(ifindex, ns_dev, ns_ino, devname)) {
> -		p_err("Can't get net device name for ifindex %d: %s", ifindex,
> +		p_err("Can't get net device name for ifindex %u: %s", ifindex,
>  		      strerror(errno));
>  		return NULL;
>  	}
> @@ -739,7 +739,7 @@ ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt)
>  	/* No NFP support in LLVM, we have no valid triple to return. */
>  	default:
>  		p_err("Can't get arch name for device vendor id 0x%04x",
> -		      vendor_id);
> +		      (unsigned int)vendor_id);
>  		return NULL;
>  	}
>  }
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index c032d2c6ab6d..8895b4e1f690 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -343,7 +343,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
>  {
>  	const struct bpf_line_info *linfo = NULL;
>  	unsigned int nr_skip = 0;
> -	int count, i, pc = 0;
> +	int count, i;
> +	unsigned int pc = 0;
>  	disasm_ctx_t ctx;
>  
>  	if (!len)
> diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
> index 21d7d447e1f3..552b4ca40c27 100644
> --- a/tools/bpf/bpftool/map_perf_ring.c
> +++ b/tools/bpf/bpftool/map_perf_ring.c
> @@ -91,15 +91,15 @@ print_bpf_output(void *private_data, int cpu, struct perf_event_header *event)
>  		jsonw_end_object(json_wtr);
>  	} else {
>  		if (e->header.type == PERF_RECORD_SAMPLE) {
> -			printf("== @%lld.%09lld CPU: %d index: %d =====\n",
> +			printf("== @%llu.%09llu CPU: %d index: %d =====\n",
>  			       e->time / 1000000000ULL, e->time % 1000000000ULL,
>  			       cpu, idx);
>  			fprint_hex(stdout, e->data, e->size, " ");
>  			printf("\n");
>  		} else if (e->header.type == PERF_RECORD_LOST) {
> -			printf("lost %lld events\n", lost->lost);
> +			printf("lost %llu events\n", lost->lost);
>  		} else {
> -			printf("unknown event type=%d size=%d\n",
> +			printf("unknown event type=%u size=%u\n",
>  			       e->header.type, e->header.size);
>  		}
>  	}
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index d2242d9f8441..811150873125 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -476,7 +476,7 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
>  	for (i = 0; i < optq.count; i++) {
>  		NET_START_OBJECT;
>  		NET_DUMP_STR("devname", "%s", dev->devname);
> -		NET_DUMP_UINT("ifindex", "(%u)", dev->ifindex);
> +		NET_DUMP_UINT("ifindex", "(%d)", dev->ifindex);


Macro NET_DUMP_UINT() clearly denotes the intent to have an insigned; if
you change the plain-output format specifier only, you risk introducing
differences between the plain and JSON forms. Either use NET_DUMP_INT()
as well, or cast the ifindex. I'd probably go with the cast.


>  		NET_DUMP_STR("kind", " %s", attach_loc_strings[loc]);
>  		ret = __show_dev_tc_bpf_name(prog_ids[i], prog_name,
>  					     sizeof(prog_name));
> @@ -831,7 +831,7 @@ static void show_link_netfilter(void)
>  		if (err) {
>  			if (errno == ENOENT)
>  				break;
> -			p_err("can't get next link: %s (id %d)", strerror(errno), id);
> +			p_err("can't get next link: %s (id %u)", strerror(errno), id);
>  			break;
>  		}
>  
> diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
> index 5f65140b003b..00741d51e7de 100644
> --- a/tools/bpf/bpftool/netlink_dumper.c
> +++ b/tools/bpf/bpftool/netlink_dumper.c
> @@ -26,8 +26,7 @@ static void xdp_dump_prog_id(struct nlattr **tb, int attr,
>  		NET_END_OBJECT
>  }
>  
> -static int do_xdp_dump_one(struct nlattr *attr, unsigned int ifindex,
> -			   const char *name)
> +static int do_xdp_dump_one(struct nlattr *attr, int ifindex, const char *name)
>  {
>  	struct nlattr *tb[IFLA_XDP_MAX + 1];
>  	unsigned char mode;
> @@ -168,7 +167,7 @@ int do_filter_dump(struct tcmsg *info, struct nlattr **tb, const char *kind,
>  		NET_START_OBJECT;
>  		if (devname[0] != '\0')
>  			NET_DUMP_STR("devname", "%s", devname);
> -		NET_DUMP_UINT("ifindex", "(%u)", ifindex);
> +		NET_DUMP_UINT("ifindex", "(%d)", ifindex);


Same here regarding NET_DUMP_UINT().


>  		NET_DUMP_STR("kind", " %s", kind);
>  		ret = do_bpf_filter_dump(tb[TCA_OPTIONS]);
>  		NET_END_OBJECT_FINAL;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index e71be67f1d86..58791542515a 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -521,10 +521,10 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
>  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
>  	printf("%s", info->gpl_compatible ? "  gpl" : "");
>  	if (info->run_time_ns)
> -		printf(" run_time_ns %lld run_cnt %lld",
> +		printf(" run_time_ns %llu run_cnt %llu",
>  		       info->run_time_ns, info->run_cnt);
>  	if (info->recursion_misses)
> -		printf(" recursion_misses %lld", info->recursion_misses);
> +		printf(" recursion_misses %llu", info->recursion_misses);
>  	printf("\n");
>  }
>  
> @@ -569,7 +569,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd, bool orphaned)
>  	}
>  
>  	if (info->btf_id)
> -		printf("\n\tbtf_id %d", info->btf_id);
> +		printf("\n\tbtf_id %u", info->btf_id);
>  
>  	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
>  
> @@ -1164,7 +1164,7 @@ static int get_run_data(const char *fname, void **data_ptr, unsigned int *size)
>  		}
>  		if (nb_read > buf_size - block_size) {
>  			if (buf_size == UINT32_MAX) {
> -				p_err("data_in/ctx_in is too long (max: %d)",
> +				p_err("data_in/ctx_in is too long (max: %u)",
>  				      UINT32_MAX);
>  				goto err_free;
>  			}
> @@ -2251,7 +2251,7 @@ static char *profile_target_name(int tgt_fd)
>  
>  	t = btf__type_by_id(btf, func_info.type_id);
>  	if (!t) {
> -		p_err("btf %d doesn't have type %d",
> +		p_err("btf %u doesn't have type %u",
>  		      info.btf_id, func_info.type_id);
>  		goto out;
>  	}
> @@ -2329,7 +2329,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>  			continue;
>  		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
>  			if (profile_open_perf_event(m, cpu, map_fd)) {
> -				p_err("failed to create event %s on cpu %d",
> +				p_err("failed to create event %s on cpu %u",
>  				      metrics[m].name, cpu);
>  				return -1;
>  			}
> diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
> index bf1f02212797..31d806e3bdaa 100644
> --- a/tools/bpf/bpftool/tracelog.c
> +++ b/tools/bpf/bpftool/tracelog.c
> @@ -78,7 +78,7 @@ static bool get_tracefs_pipe(char *mnt)
>  		return false;
>  
>  	/* Allow room for NULL terminating byte and pipe file name */
> -	snprintf(format, sizeof(format), "%%*s %%%zds %%99s %%*s %%*d %%*d\\n",
> +	snprintf(format, sizeof(format), "%%*s %%%zus %%99s %%*s %%*d %%*d\\n",
>  		 PATH_MAX - strlen(pipe_name) - 1);
>  	while (fscanf(fp, format, mnt, type) == 2)
>  		if (strcmp(type, fstype) == 0) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index d0094345fb2b..5e7cb8b36fef 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -199,13 +199,13 @@ static const char *print_imm(void *private_data,
>  
>  	if (insn->src_reg == BPF_PSEUDO_MAP_FD)
>  		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			 "map[id:%u]", insn->imm);
> +			 "map[id:%d]", insn->imm);
>  	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>  		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			 "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
> +			 "map[id:%d][0]+%d", insn->imm, (insn + 1)->imm);
>  	else if (insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)
>  		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			 "map[idx:%u]+%u", insn->imm, (insn + 1)->imm);
> +			 "map[idx:%d]+%d", insn->imm, (insn + 1)->imm);
>  	else if (insn->src_reg == BPF_PSEUDO_FUNC)
>  		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>  			 "subprog[%+d]", insn->imm);


pw-bot: cr

Thanks!
Quentin

