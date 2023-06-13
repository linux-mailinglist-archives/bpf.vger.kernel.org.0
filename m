Return-Path: <bpf+bounces-2504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F6272E460
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF71228125B
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A234CE2;
	Tue, 13 Jun 2023 13:42:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE8522B
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 13:42:02 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35510E9
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:41:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8ca80e889so6038885e9.3
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686663716; x=1689255716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hM6Zp60xHtV8WJfxvNaVuXQ8hoHkbQnWIEtWapSJ0jE=;
        b=cQ7WHnwNwahj2Qc0U2caqZleW2RaipA206vvPmXf4qxCxEZfiMj2Sg9bL/TilmwVXy
         Poyap1dyS4j9WMDr9gxmIsYCvEMkpfOxjLknG6wAhdI8nKNTPFxF+gIDAoUmRbGuYtqH
         xxEtXFRelh/6MbKfsPisqo+b0LGRnAaJee59HBzYnzcPj5mhw4xGKZgsJJvSlVvoAAax
         mUFUlib/IJQEWrly4vcgNEtWg1qQHfe1SDjOBwcIbxRKuU5L3l7JpYxVdVBUkGuwV4WN
         ITnpJU6+/crHnzRpXmg/vrFogX7p/H3vLsi2EgM1OY3DYWQEsxTFzFRCp/jrLiFC8JDi
         njDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663716; x=1689255716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM6Zp60xHtV8WJfxvNaVuXQ8hoHkbQnWIEtWapSJ0jE=;
        b=dlbYRbzJC/cNA4Xe537+12mMcVXPt55byrgxGPlYvuxgisbrILRyTWxx5IZc6x/yDt
         YOC6FVqCr0M55rq4BK1aYee1DYm2DfYNRjzKHOtSNoMw520FFDt2vZlatjbaJcvhuTWA
         z40M2x9wa9zRBYlABgcFF+TU/CFMYsV2E8Q3mMdxcMCS/8TEKpJtv154xojPYMChOlZM
         SLGr3ToHI858051FEd+2YvjGqlI2kuD5apc4Uu53ouSvHmnG627ebs/Y2dXTPnV1oWuv
         r5JmMTTzsSEOX/D88Y1EunmKz6fL4VAKMec1QHTfBv1b1DM1/OhXdzEog4AF5MvFT7oU
         nW/A==
X-Gm-Message-State: AC+VfDzkcU3CwB0yRCJ9XsAmpG4nfoe3W7Cyye3QnfEVJRwTbWhlYmGL
	cQfTATMFsQZWdQJjaciHF3ZjKA==
X-Google-Smtp-Source: ACHHUZ7A3M75HU6ouv3C3JlCIOwyIif14KwOSSCKlgu/CGcwby4htbMT7EoC5ooF1O0fUFJXwVpIjA==
X-Received: by 2002:a5d:5088:0:b0:30e:3d53:7e5b with SMTP id a8-20020a5d5088000000b0030e3d537e5bmr6913006wrt.57.1686663716245;
        Tue, 13 Jun 2023 06:41:56 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a03e:3034:b6bf:fd8e? ([2a02:8011:e80c:0:a03e:3034:b6bf:fd8e])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b0030abe7c36b1sm15303462wrr.93.2023.06.13.06.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:41:55 -0700 (PDT)
Message-ID: <0e64ecd5-cba4-0963-ec74-47ceb9e867ab@isovalent.com>
Date: Tue, 13 Jun 2023 14:41:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-4-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230612151608.99661-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Show the already expose kprobe_multi link info in bpftool. The result a=
s
> follows,
>=20
> 52: kprobe_multi  prog 381
>         retprobe 0  func_cnt 7
>         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
>               ffffffff9ec44f60        schedule_timeout_killable
>               ffffffff9ec44fa0        schedule_timeout_uninterruptible
>               ffffffff9ec44fe0        schedule_timeout_idle
>               ffffffffc09468d0        xfs_trans_get_efd [xfs]
>               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>         pids kprobe_multi(559862)
> 53: kprobe_multi  prog 381
>         retprobe 1  func_cnt 7
>         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
>               ffffffff9ec44f60        schedule_timeout_killable
>               ffffffff9ec44fa0        schedule_timeout_uninterruptible
>               ffffffff9ec44fe0        schedule_timeout_idle
>               ffffffffc09468d0        xfs_trans_get_efd [xfs]
>               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>         pids kprobe_multi(559862)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":52,"type":"kprobe_multi","prog_id":381,"retprobe":0,"func_cnt":7=
,"funcs":[{"addr":18446744072078249760,"func":"schedule_timeout_interrupt=
ible","module":""},{"addr":18446744072078249824,"func":"schedule_timeout_=
killable","module":""},{"addr":18446744072078249888,"func":"schedule_time=
out_uninterruptible","module":""},{"addr":18446744072078249952,"func":"sc=
hedule_timeout_idle","module":""},{"addr":18446744072645535952,"func":"xf=
s_trans_get_efd","module":"[xfs]"},{"addr":18446744072645589520,"func":"x=
fs_trans_get_buf_map","module":"[xfs]"},{"addr":18446744072645604128,"fun=
c":"xfs_trans_get_dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":=
"kprobe_multi"}]},{"id":53,"type":"kprobe_multi","prog_id":381,"retprobe"=
:1,"func_cnt":7,"funcs":[{"addr":18446744072078249760,"func":"schedule_ti=
meout_interruptible","module":""},{"addr":18446744072078249824,"func":"sc=
hedule_timeout_killable","module":""},{"addr":18446744072078249888,"func"=
:"schedule_timeout_uninterruptible","module":""},{"addr":1844674407207824=
9952,"func":"schedule_timeout_idle","module":""},{"addr":1844674407264553=
5952,"func":"xfs_trans_get_efd","module":"[xfs]"},{"addr":184467440726455=
89520,"func":"xfs_trans_get_buf_map","module":"[xfs]"},{"addr":1844674407=
2645604128,"func":"xfs_trans_get_dqtrx","module":"[xfs]"}],"pids":[{"pid"=
:559862,"comm":"kprobe_multi"}]}]
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..0015582 100644
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
> +	jsonw_uint_field(json_wtr, "retprobe",
> +			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);

The "retprobe" field could maybe be a boolean rather than an int.

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

Can we trim the square brackets around module names for the JSON output,
please? They make entries look like arrays; but mostly, if we keep them,
we're forcing every consumer to trim them on their side before being
able to reuse the value.

