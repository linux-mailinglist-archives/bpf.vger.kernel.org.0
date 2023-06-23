Return-Path: <bpf+bounces-3293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341773BD23
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643271C21271
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FAFD2FF;
	Fri, 23 Jun 2023 16:49:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF99A959
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:49:18 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C335A0
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:49:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-312826ffedbso934037f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687538939; x=1690130939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTBeA/FzEfP72IdxLJwhOZ/Bhgt0h3YUEwVMoMjK02w=;
        b=SO2pNAGJfPuaKlgPn0sA0mRGLQl/7VaeClw7hhQYUTDCJwjTOyH6cSo4dUPTFxuf/d
         gFeG53pZdqgu50Zf12RT46EY9u9IOfLp9QzK4fMpGe+lPXVrtPl/BBm90G/0ADq7pfKF
         yySK6i3nD+n5y5ypC5zzaPSIvFmB4IRPORrvOS3kN7gO9lj7iWsYEFZvjEwkKeh7vfZG
         sIi5OtVrGgp2vhXlnGj9eH6HQ1cEhIvrIkAjGvJBVPfH26epymDPWDfbc8q2tLbzUHCw
         nJmL67UJRNakW2JpB3zxu2YRxwt13YX+G7lpnBdx75pPZs55bdeHo6v+imyfMI0ptDlQ
         GDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538939; x=1690130939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTBeA/FzEfP72IdxLJwhOZ/Bhgt0h3YUEwVMoMjK02w=;
        b=l/FRJ/toydTocQcfMAgpGa4+E2HRfg9zA0jUyMMltbk+H2rqOkfNW+xe/rtVRVTWXh
         MZa9HZY/8D75yHNeY4UY868nK47oBQEKM9jmugmahX9HqsWxTIXUWuwTC6j1ZjpGeR7o
         +6K5vF7LYSs0obu9vXa/Vm7PaZccHo/56NAhCOB4xz1ia3GABYCJw4XcCoQbwj9rgo0f
         SHETzjiowFgg8XbY2USLZxW+DhH3Q3Rr6qT3rQcRxGgzTqzpteYTYGHE8cl+ubWa5EXV
         Tt2Lq89mt50sr2cK8livr5hsN0lXokxDAoQ5iTsQW0TswylnvfH2VtTRMp9qJVAGAguf
         qDDg==
X-Gm-Message-State: AC+VfDxj+GdA1NR+BN49tJ/B4objkpCXplqVyW3jxy7mWguPg4lbsKf1
	uL1y36kJKQxEc/jIYk/sBiuSnw==
X-Google-Smtp-Source: ACHHUZ4K1bAHgE9V5cjP+9CEZDbOywmn25/9yexaJ4UYxWzd5bSiUZc4WyfmGhoCmPP1ipbcfLhoUw==
X-Received: by 2002:a5d:6386:0:b0:2f9:c2ab:e1de with SMTP id p6-20020a5d6386000000b002f9c2abe1demr17284423wru.14.1687538939640;
        Fri, 23 Jun 2023 09:48:59 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm9915908wrv.40.2023.06.23.09.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:48:59 -0700 (PDT)
Message-ID: <3ad842a7-32cb-a06e-5e15-a13c3c80e1d5@isovalent.com>
Date: Fri, 23 Jun 2023 17:48:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 bpf-next 03/11] bpftool: Show kprobe_multi link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230623141546.3751-1-laoar.shao@gmail.com>
 <20230623141546.3751-4-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623141546.3751-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Show the already expose kprobe_multi link info in bpftool. The result a=
s
> follows,
>=20
> $ tools/bpf/bpftool/bpftool link show
> 4: kprobe_multi  prog 22
>         kprobe.multi  func_cnt 7
>         addr             func [module]
>         ffffffffbbc44f20 schedule_timeout_interruptible
>         ffffffffbbc44f60 schedule_timeout_killable
>         ffffffffbbc44fa0 schedule_timeout_uninterruptible
>         ffffffffbbc44fe0 schedule_timeout_idle
>         ffffffffc08028d0 xfs_trans_get_efd [xfs]
>         ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
>         ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
>         pids kprobe_multi(1434978)
> 5: kprobe_multi  prog 22
>         kretprobe.multi  func_cnt 7
>         addr             func [module]
>         ffffffffbbc44f20 schedule_timeout_interruptible
>         ffffffffbbc44f60 schedule_timeout_killable
>         ffffffffbbc44fa0 schedule_timeout_uninterruptible
>         ffffffffbbc44fe0 schedule_timeout_idle
>         ffffffffc08028d0 xfs_trans_get_efd [xfs]
>         ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
>         ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
>         pids kprobe_multi(1434978)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":4,"type":"kprobe_multi","prog_id":22,"retprobe":false,"func_cnt"=
:7,"funcs":[{"addr":18446744072564789024,"func":"schedule_timeout_interru=
ptible","module":""},{"addr":18446744072564789088,"func":"schedule_timeou=
t_killable","module":""},{"addr":18446744072564789152,"func":"schedule_ti=
meout_uninterruptible","module":""},{"addr":18446744072564789216,"func":"=
schedule_timeout_idle","module":""},{"addr":18446744072644208848,"func":"=
xfs_trans_get_efd","module":"xfs"},{"addr":18446744072644262416,"func":"x=
fs_trans_get_buf_map","module":"xfs"},{"addr":18446744072644277024,"func"=
:"xfs_trans_get_dqtrx","module":"xfs"}],"pids":[{"pid":1434978,"comm":"kp=
robe_multi"}]},{"id":5,"type":"kprobe_multi","prog_id":22,"retprobe":true=
,"func_cnt":7,"funcs":[{"addr":18446744072564789024,"func":"schedule_time=
out_interruptible","module":""},{"addr":18446744072564789088,"func":"sche=
dule_timeout_killable","module":""},{"addr":18446744072564789152,"func":"=
schedule_timeout_uninterruptible","module":""},{"addr":184467440725647892=
16,"func":"schedule_timeout_idle","module":""},{"addr":184467440726442088=
48,"func":"xfs_trans_get_efd","module":"xfs"},{"addr":1844674407264426241=
6,"func":"xfs_trans_get_buf_map","module":"xfs"},{"addr":1844674407264427=
7024,"func":"xfs_trans_get_dqtrx","module":"xfs"}],"pids":[{"pid":1434978=
,"comm":"kprobe_multi"}]}]
>=20
> When kptr_restrict is 2, the result is,
>=20
> $ tools/bpf/bpftool/bpftool link show
> 4: kprobe_multi  prog 22
>         kprobe.multi  func_cnt 7
> 5: kprobe_multi  prog 22
>         kretprobe.multi  func_cnt 7
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..8461e6d 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -14,8 +14,10 @@
> =20
>  #include "json_writer.h"
>  #include "main.h"
> +#include "xlated_dumper.h"
> =20
>  static struct hashmap *link_table;
> +static struct dump_data dd =3D {};
> =20
>  static int link_parse_fd(int *argc, char ***argv)
>  {
> @@ -166,6 +168,45 @@ static int get_prog_info(int prog_id, struct bpf_p=
rog_info *info)
>  	return err;
>  }
> =20
> +static int cmp_u64(const void *A, const void *B)
> +{
> +	const __u64 *a =3D A, *b =3D B;
> +
> +	return *a - *b;
> +}
> +
> +static void
> +show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)=

> +{
> +	__u32 i, j =3D 0;
> +	__u64 *addrs;
> +
> +	jsonw_bool_field(json_wtr, "retprobe",
> +			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
> +	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> +	jsonw_name(json_wtr, "funcs");
> +	jsonw_start_array(json_wtr);
> +	addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +	qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64=
);
> +
> +	/* Load it once for all. */
> +	if (!dd.sym_count)
> +		kernel_syms_load(&dd);
> +	for (i =3D 0; i < dd.sym_count; i++) {
> +		if (dd.sym_mapping[i].address !=3D addrs[j])
> +			continue;
> +		jsonw_start_object(json_wtr);
> +		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
> +		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
> +		/* Print none if it is vmlinux */
> +		jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].module);

We could maybe print null ("jsonw_null(json_wtr);") instead of an empty
string here when we have no module name. Although I'm not sure it
matters too much. Let's see whether the series needs another respin.

Anyway:

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

