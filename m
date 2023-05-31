Return-Path: <bpf+bounces-1473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A6A71726B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974A22813AD
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A146EA6;
	Wed, 31 May 2023 00:31:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830AA2D
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 00:31:22 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA78C7
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:31:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3816474b3a.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685493080; x=1688085080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyTTn6rUtm2dnC830ZZeRA8j2v1ItfzMJSBmf7oMbwU=;
        b=SoEoqxthscOYqiNdJJimUCU7JVU3s6ofSNXkk64Hq7DfGHhnJGvn1VU0ganbxDnBwJ
         YLjMjNznRohBTPy9p7WVyM2GL6M1AP2DDSNBqGGklNRwNoQV/SOIm9+xfodNC5OQ5vTU
         WZ61DpjmUNahj38tVkEMn1/JRXAFe3c18MJXH2d8UIP6Dt0i56c8iIlGiGgjT0ppRK4s
         NfDfpQvplC4bsuA5jo7Pq4K5NVzM1/wrN25yA8Rxw85DUM9mp3uFqe3aNG2Sa2gCxe20
         CAjn44WucMPjd3fhqqCn2fEoe14DCNp1rHT4U6l8pKhllXzGjA7yJQwHDRLnA9zzpBDX
         O4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493080; x=1688085080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTTn6rUtm2dnC830ZZeRA8j2v1ItfzMJSBmf7oMbwU=;
        b=GBe/KrSgHJW938vGhNCg+FcN9fPhIkpem7Qc/6cy67oEgD3MVOga56nOKzydPry8dw
         AYF5W0ObDyHZYQxX/wK97k9UwtD00rX0Aka83DoOK0YuMAlcIL8Im0KlrxTBxhkR/kkC
         FU37hlTA6rPpqDBwXVOr01FxX9S0xtueC1c/uDYvMMFrI9l8qhYhG5oJ+YAp3fLChXvc
         gzvNszKieqT6CZmvYiBl6jtxFB4DOo3g/qMgiaGXTGLqu0mzqLapa261QLV4er6NJ5C5
         Ygmw/HlJoRzrAm5KddLyIU3B2T78XLUt5Nv5hrNOlhxnYEv0dvjb3yl4DJjdZUnPqZS/
         Qj2g==
X-Gm-Message-State: AC+VfDyT67Cqpth1x0axz1lnpCVp8EQldy5oqpIDhx1eYSc1Co94ZE4/
	yUuIGmJHW97pXsgPQ3EJtWD5Vz46ed8=
X-Google-Smtp-Source: ACHHUZ50Ubp7Xplcq7flT93PLdbk+RlBal6ytHh1puYowldj068/SVi7ErabMCAaSM6KwmB3Kkfv/Q==
X-Received: by 2002:a05:6a00:2385:b0:63d:3339:e967 with SMTP id f5-20020a056a00238500b0063d3339e967mr4815762pfc.19.1685493080233;
        Tue, 30 May 2023 17:31:20 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d8f6])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7868c000000b0064d4d11b8bfsm2184244pfo.59.2023.05.30.17.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:31:19 -0700 (PDT)
Date: Tue, 30 May 2023 17:31:16 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, quentin@isovalent.com, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 3/8] bpftool: Show probed function in
 kprobe_multi link info
Message-ID: <20230531003116.vcxiogqjntrzfdhi@MacBook-Pro-8.local>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528142027.5585-4-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, May 28, 2023 at 02:20:22PM +0000, Yafang Shao wrote:
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
> 
> $ bpftool link show
> 2: kprobe_multi  prog 11
>         func_cnt 4  addrs ffffffffaad475c0 ffffffffaad47600
>                           ffffffffaad47640 ffffffffaad47680
>         pids trace(10936)
> 
> $ bpftool link show -j
> [{"id":1,"type":"perf_event","prog_id":5,"bpf_cookie":0,"pids":[{"pid":10658,"comm":"trace"}]},{"id":2,"type":"kprobe_multi","prog_id":11,"func_cnt":4,"addrs":[18446744072280634816,18446744072280634880,18446744072280634944,18446744072280635008],"pids":[{"pid":10936,"comm":"trace"}]},{"id":120,"type":"iter","prog_id":266,"target_name":"bpf_map"},{"id":121,"type":"iter","prog_id":267,"target_name":"bpf_prog"}]
> 
> $ bpftool link show  | grep -A 1 "func_cnt" | \
>   awk '{if (NR == 1) {print $4; print $5;} else {print $1; print $2} }' | \
>   awk '{"grep " $1 " /proc/kallsyms" | getline f; print f;}'

This is not human friendly.
Either make bpftool print complete info or don't do it all.

> ffffffffaad475c0 T schedule_timeout_interruptible
> ffffffffaad47600 T schedule_timeout_killable
> ffffffffaad47640 T schedule_timeout_uninterruptible
> ffffffffaad47680 T schedule_timeout_idle
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..76f1bb2 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -218,6 +218,20 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  		jsonw_uint_field(json_wtr, "map_id",
>  				 info->struct_ops.map_id);
>  		break;
> +	case BPF_LINK_TYPE_KPROBE_MULTI:
> +		const __u64 *addrs;
> +		__u32 i;
> +
> +		jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> +		if (!info->kprobe_multi.count)
> +			break;
> +		jsonw_name(json_wtr, "addrs");
> +		jsonw_start_array(json_wtr);
> +		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +		for (i = 0; i < info->kprobe_multi.count; i++)
> +			jsonw_lluint(json_wtr, addrs[i]);
> +		jsonw_end_array(json_wtr);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -396,6 +410,24 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  	case BPF_LINK_TYPE_NETFILTER:
>  		netfilter_dump_plain(info);
>  		break;
> +	case BPF_LINK_TYPE_KPROBE_MULTI:
> +		__u32 indent, cnt, i;
> +		const __u64 *addrs;
> +
> +		cnt = info->kprobe_multi.count;
> +		if (!cnt)
> +			break;
> +		printf("\n\tfunc_cnt %d  addrs", cnt);
> +		for (i = 0; cnt; i++)
> +			cnt /= 10;
> +		indent = strlen("func_cnt ") + i + strlen("  addrs");
> +		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +		for (i = 0; i < info->kprobe_multi.count; i++) {
> +			if (i && !(i & 0x1))
> +				printf("\n\t%*s", indent, "");
> +			printf(" %0*llx", 16, addrs[i]);
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -417,7 +449,9 @@ static int do_show_link(int fd)
>  {
>  	struct bpf_link_info info;
>  	__u32 len = sizeof(info);
> +	__u64 *addrs = NULL;
>  	char buf[256];
> +	int count;
>  	int err;
>  
>  	memset(&info, 0, sizeof(info));
> @@ -441,12 +475,28 @@ static int do_show_link(int fd)
>  		info.iter.target_name_len = sizeof(buf);
>  		goto again;
>  	}
> +	if (info.type == BPF_LINK_TYPE_KPROBE_MULTI &&
> +	    !info.kprobe_multi.addrs) {
> +		count = info.kprobe_multi.count;
> +		if (count) {
> +			addrs = malloc(count * sizeof(__u64));
> +			if (!addrs) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				return -1;
> +			}
> +			info.kprobe_multi.addrs = (unsigned long)addrs;
> +			goto again;
> +		}
> +	}
>  
>  	if (json_output)
>  		show_link_close_json(fd, &info);
>  	else
>  		show_link_close_plain(fd, &info);
>  
> +	if (addrs)
> +		free(addrs);
>  	close(fd);
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 

