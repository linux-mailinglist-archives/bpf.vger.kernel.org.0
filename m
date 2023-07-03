Return-Path: <bpf+bounces-3926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6249746525
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 23:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91332280E3F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344FF134A7;
	Mon,  3 Jul 2023 21:52:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072B125D5
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 21:52:13 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F0FA;
	Mon,  3 Jul 2023 14:52:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-553b2979fceso1872189a12.3;
        Mon, 03 Jul 2023 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688421132; x=1691013132;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4uuguBMJuINg9fUQIGTuCA7yJtjUnEHnEO3dRUqxso=;
        b=TzBPGY2/HmytqFLZ3lsMk2uiVeAnhRcWIPFS3IdBtoPRpSPjWKuO3+fc638ZPLRsrh
         MbN4wkH5diNdXkeevMuD0POAKIvEhXHJEkkH71wQlkC2Mk0+vybXZO+d1PBQDEhBybhK
         yzaE6gPvi/cnZ3ER5V0VOVCye/Kwg55eVNa9dtEGgdZwDDsIJ67KjRtrYpvicxBPBxhP
         UweLKKDf6X7SjCUooK98kDYmjcZVZibH1xkelTSbuy037E4DwzLb0o61vjRg9rxQbixi
         R7O+nBumEXAibbNwR4qtpMfQELFVpsuYvUHAL7YUTX+Ybb/SEAFc5hrRWHXLCKI29vss
         0nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688421132; x=1691013132;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4uuguBMJuINg9fUQIGTuCA7yJtjUnEHnEO3dRUqxso=;
        b=Flu67QPa7heGJcehOeFY/NBukL7RxUD7arn5X48LblgRdM6vsLjJcEB09V00M60Ghi
         6R/jO7VsnYH45J9nIdK/FN85c0eo6W5/tw6QMbU2NL8HOjFkfja2Yx60vbFKynuNDkKO
         4xwEKw5/rPaCCRlk5zyPCGYTnk5oXB93IgX78qY0TFIH9tgA6pX4kTR0AC1D87yjsgDU
         teoayaXC/i4q3NZYnqqlk3vBnQZDsqMvhO2U64/5j1MTi/VKdgZQCTJWaLEMtUPL/Jtq
         RMYKFuDtcFQVR4J61ocK6UVaZyjp1lxmcpOK6e7iScurJ6XgduHwmUiKkaqfzYFAn3Ks
         M3MA==
X-Gm-Message-State: ABy/qLY1ztJ0R6NCf6f6w4Wq35m2IVmTMDiue2uUKM+ltl6KdnqwYJ2A
	KnRolOxsd8JHKCZ5+klzjYw=
X-Google-Smtp-Source: APBJJlH2FsqRvGiCrTEApKhDEn2T6iQpBEx51K02bT6q5dAS9fkVKs9Ltil7O2wT5/4/0kCPNAb/BA==
X-Received: by 2002:a05:6a20:a5a8:b0:12d:a534:42bb with SMTP id bc40-20020a056a20a5a800b0012da53442bbmr9006357pzb.20.1688421131823;
        Mon, 03 Jul 2023 14:52:11 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b006829ef1e179sm951716pff.99.2023.07.03.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:52:11 -0700 (PDT)
Date: Mon, 03 Jul 2023 14:52:09 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, 
 bpf@vger.kernel.org, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Song Liu <song@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Yonghong Song <yhs@fb.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "Paul E . McKenney" <paulmck@kernel.org>, 
 rcu@vger.kernel.org, 
 houtao1@huawei.com
Message-ID: <64a34309e42aa_652052084f@john.notmuch>
In-Reply-To: <20230703141332.3319271-1-houtao@huaweicloud.com>
References: <20230703141332.3319271-1-houtao@huaweicloud.com>
Subject: RE: [PATCH bpf-next v8] selftests/bpf: Add benchmark for bpf memory
 allocator
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> =

> The benchmark could be used to compare the performance of hash map
> operations and the memory usage between different flavors of bpf memory=

> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also=

> could be used to check the performance improvement or the memory saving=

> provided by optimization.
> =

> The benchmark creates a non-preallocated hash map which uses bpf memory=

> allocator and shows the operation performance and the memory usage of
> the hash map under different use cases:
> (1) overwrite
> Each CPU overwrites nonoverlapping part of hash map. When each CPU
> completes overwriting of 64 elements in hash map, it increases the
> op_count.
> (2) batch_add_batch_del
> Each CPU adds then deletes nonoverlapping part of hash map in batch.
> When each CPU adds and deletes 64 elements in hash map, it increases
> the op_count twice.
> (3) add_del_on_diff_cpu
> Each two-CPUs pair adds and deletes nonoverlapping part of map
> cooperatively. When each CPU adds or deletes 64 elements in hash map,
> it will increase the op_count.
> =

> The following is the benchmark results when comparing between different=

> flavors of bpf memory allocator. These tests are conducted on a KVM gue=
st
> with 8 CPUs and 16 GB memory. The command line below is used to do all
> the following benchmarks:
> =

>   ./bench htab-mem --use-case $name ${OPTS} -w3 -d10 -a -p8
> =

> These results show that preallocated hash map has both better performan=
ce
> and smaller memory footprint.
> =

> (1) non-preallocated + no bpf memory allocator (v6.0.19)
> use kmalloc() + call_rcu
> =

> overwrite            per-prod-op: 11.24 =C2=B1 0.07k/s, avg mem: 82.64 =
=C2=B1 26.32MiB, peak mem: 119.18MiB
> batch_add_batch_del  per-prod-op: 18.45 =C2=B1 0.10k/s, avg mem: 50.47 =
=C2=B1 14.51MiB, peak mem: 94.96MiB
> add_del_on_diff_cpu  per-prod-op: 14.50 =C2=B1 0.03k/s, avg mem: 4.64 =C2=
=B1 0.73MiB, peak mem: 7.20MiB
> =

> (2) preallocated
> OPTS=3D--preallocated
> =

> overwrite            per-prod-op: 191.92 =C2=B1 0.07k/s, avg mem: 1.23 =
=C2=B1 0.00MiB, peak mem: 1.49MiB
> batch_add_batch_del  per-prod-op: 218.10 =C2=B1 0.25k/s, avg mem: 1.23 =
=C2=B1 0.00MiB, peak mem: 1.49MiB
> add_del_on_diff_cpu  per-prod-op: 39.59 =C2=B1 0.41k/s, avg mem: 1.48 =C2=
=B1 0.11MiB, peak mem: 1.74MiB
> =

> (3) normal bpf memory allocator
> =

> overwrite            per-prod-op: 134.81 =C2=B1 0.22k/s, avg mem: 1.67 =
=C2=B1 0.12MiB, peak mem: 2.74MiB
> batch_add_batch_del  per-prod-op: 90.44 =C2=B1 0.34k/s, avg mem: 2.27 =C2=
=B1 0.00MiB, peak mem: 2.74MiB
> add_del_on_diff_cpu  per-prod-op: 28.20 =C2=B1 0.15k/s, avg mem: 1.73 =C2=
=B1 0.17MiB, peak mem: 2.06MiB

Acked-by: John Fastabend <john.fastabend@gmail.com>

> +
> +static error_t htab_mem_parse_arg(int key, char *arg, struct argp_stat=
e *state)
> +{
> +	switch (key) {
> +	case ARG_VALUE_SIZE:
> +		args.value_size =3D strtoul(arg, NULL, 10);
> +		if (args.value_size > 4096) {
> +			fprintf(stderr, "too big value size %u\n", args.value_size);
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_USE_CASE:
> +		args.use_case =3D strdup(arg);

might be worth checking for null and returning an error? Only matters if =
we
run from CI or something and then this looks like a flake.

> +		break;
> +	case ARG_PREALLOCATED:
> +		args.preallocated =3D true;
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}=

