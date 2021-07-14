Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0863A3C8499
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhGNMon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 08:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhGNMon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 08:44:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D417F613BE;
        Wed, 14 Jul 2021 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266512;
        bh=QmkEEw5HPjaeIwBl2KuFwiuPeDWX0r9aAoveov6ob6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF3T7ABlSNn0ySBp9984CdkyROyEHLo2b+X+zbXx5gSq1GpW0Qlv0dHAdSGEr1I7x
         HjBj3bt6jxkSHJRynGrV9a0/KILOiTR1WzuscA6BotC9qb3DOJBrIILJuzwt6txtYw
         thJTZlHXxYgrpnecQ6FU0IhCqxtItazfS+WvWNhqhEi/9HdyNm+qnQuPr57W12m/R4
         oikSIKLoNsjo12jt0wYI+MGnhv5tiAPfptOnUa+CCOblAGpk5SYfTfZ4XBoHdLWzzx
         GHccKGn6KfhQtej1/D15JDUJ4q5YMJw+U757WjVGD0sumB7SSg3DmNqeSH90mbfMDj
         89VA/b9z0XK1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF318403F2; Wed, 14 Jul 2021 09:41:48 -0300 (-03)
Date:   Wed, 14 Jul 2021 09:41:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] perf trace: Update cmd string table to decode sys_bpf
 first arg
Message-ID: <YO7bjJ6Es+Y7j0K4@kernel.org>
References: <20210714015000.2844867-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210714015000.2844867-1-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jul 14, 2021 at 09:50:00AM +0800, Wei Li escreveu:
> As 'enum bpf_cmd' has been extended a lot, update the cmd string table to
> decode sys_bpf first arg clearly in perf-trace.

I'll apply this, as it improves what we have right now, but the plan is
to use BTF for this, see how pahole can get all that from
/sys/kernel/btf/vmlinux:

⬢[acme@toolbox perf]$ pahole bpf_cmd
enum bpf_cmd {
	BPF_MAP_CREATE                  = 0,
	BPF_MAP_LOOKUP_ELEM             = 1,
	BPF_MAP_UPDATE_ELEM             = 2,
	BPF_MAP_DELETE_ELEM             = 3,
	BPF_MAP_GET_NEXT_KEY            = 4,
	BPF_PROG_LOAD                   = 5,
	BPF_OBJ_PIN                     = 6,
	BPF_OBJ_GET                     = 7,
	BPF_PROG_ATTACH                 = 8,
	BPF_PROG_DETACH                 = 9,
	BPF_PROG_TEST_RUN               = 10,
	BPF_PROG_GET_NEXT_ID            = 11,
	BPF_MAP_GET_NEXT_ID             = 12,
	BPF_PROG_GET_FD_BY_ID           = 13,
	BPF_MAP_GET_FD_BY_ID            = 14,
	BPF_OBJ_GET_INFO_BY_FD          = 15,
	BPF_PROG_QUERY                  = 16,
	BPF_RAW_TRACEPOINT_OPEN         = 17,
	BPF_BTF_LOAD                    = 18,
	BPF_BTF_GET_FD_BY_ID            = 19,
	BPF_TASK_FD_QUERY               = 20,
	BPF_MAP_LOOKUP_AND_DELETE_ELEM  = 21,
	BPF_MAP_FREEZE                  = 22,
	BPF_BTF_GET_NEXT_ID             = 23,
	BPF_MAP_LOOKUP_BATCH            = 24,
	BPF_MAP_LOOKUP_AND_DELETE_BATCH = 25,
	BPF_MAP_UPDATE_BATCH            = 26,
	BPF_MAP_DELETE_BATCH            = 27,
	BPF_LINK_CREATE                 = 28,
	BPF_LINK_UPDATE                 = 29,
	BPF_LINK_GET_FD_BY_ID           = 30,
	BPF_LINK_GET_NEXT_ID            = 31,
	BPF_ENABLE_STATS                = 32,
	BPF_ITER_CREATE                 = 33,
	BPF_LINK_DETACH                 = 34,
	BPF_PROG_BIND_MAP               = 35,
};
⬢[acme@toolbox perf]$
 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7ec18ff57fc4..17bc6284a93e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -707,7 +707,15 @@ static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct sy
>  
>  static const char *bpf_cmd[] = {
>  	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
> -	"MAP_GET_NEXT_KEY", "PROG_LOAD",
> +	"MAP_GET_NEXT_KEY", "PROG_LOAD", "OBJ_PIN", "OBJ_GET", "PROG_ATTACH",
> +	"PROG_DETACH", "PROG_TEST_RUN", "PROG_GET_NEXT_ID", "MAP_GET_NEXT_ID",
> +	"PROG_GET_FD_BY_ID", "MAP_GET_FD_BY_ID", "OBJ_GET_INFO_BY_FD",
> +	"PROG_QUERY", "RAW_TRACEPOINT_OPEN", "BTF_LOAD", "BTF_GET_FD_BY_ID",
> +	"TASK_FD_QUERY", "MAP_LOOKUP_AND_DELETE_ELEM", "MAP_FREEZE",
> +	"BTF_GET_NEXT_ID", "MAP_LOOKUP_BATCH", "MAP_LOOKUP_AND_DELETE_BATCH",
> +	"MAP_UPDATE_BATCH", "MAP_DELETE_BATCH", "LINK_CREATE", "LINK_UPDATE",
> +	"LINK_GET_FD_BY_ID", "LINK_GET_NEXT_ID", "ENABLE_STATS", "ITER_CREATE",
> +	"LINK_DETACH", "PROG_BIND_MAP",
>  };
>  static DEFINE_STRARRAY(bpf_cmd, "BPF_");
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
