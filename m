Return-Path: <bpf+bounces-2175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355A728B9D
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDED28181D
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8734D87;
	Thu,  8 Jun 2023 23:14:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3C2A9CA
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:14:18 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82EEB
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:14:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso1790275a12.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686266055; x=1688858055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x/qMN6xHwTWxV4fhl9Y3r0X9or8rzZOmAiOprPM4Cg=;
        b=bDlwKUl6RKv/bpGboE2jPlclcE7lhlH62KQIP0j4P9a6GCpGzBOXNwqVNopJyp4tMu
         hvSPUZRo8hGcjuxAJSbVskYqbuZursk7brbSlWEw1/KymcJGJMsbd38PKjHnjZe+eb7/
         xLU7RowERL7XO0tF6/hivzFFwTUxi8kqjwGIDPRvUVg66KnFjZ1KSL94f2zkgg0+Ddvo
         pxQ82YSX3iavjlqeIIUsjcjWbukSH5wlQNrlBA2jcTAVtx9NFioit1MXXOUJybK3Gk7W
         PjL4RVfVUc0hP9wAtxWL2QYio9uy6euSYphZh7m01nMYf3RbPAKEzQt99H3Zt7m7Wkxs
         8K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266055; x=1688858055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x/qMN6xHwTWxV4fhl9Y3r0X9or8rzZOmAiOprPM4Cg=;
        b=RPGc0NHipUQ7XDRloO/VrKvMtVztp2K+NfWCBWDUxMC2e3PFq18XqQrw9Rfwii8HBH
         WatvYjt3IMg4PgN1yZCO4qN3n9akAV4JbMluqOV/i31UGhf84mTj9qI8ooPpKAojZf8V
         Vevxk2LfCnLceVRVlk8clGjA+fMbf0xA4kziLb3U36n6lZsHlVs2tCqy+TmBoUq5iOG/
         VNo2fajLGKMNvesIqUHClUtYrWftimGEh5KdJS2oY49+NefMzO6r0fpfbiJh4HnY01CA
         n6f6OJu3qKnd9Ga7OS39NhE3tEPqQMLKJhUo/TfmOOFtIgPsgnElbB0lXKnn2sNZFCkL
         8krg==
X-Gm-Message-State: AC+VfDyTPopk2hOayc3Ys7R5Z0bhgUbGeAOYh064zsKc+xOzYwunEjFp
	5kRXy1/FVPvOl1WYscbP7zXrOx+hr/JrvJAhlQM=
X-Google-Smtp-Source: ACHHUZ6mVVjxd0JnUI3VLNMse+ajg3WC6m+Gl3wVgBcUHXk+nZrY8NAvxM53Y/fgKViKoNyZMj9unkP9fCsZIGPLCm4=
X-Received: by 2002:a17:907:7e88:b0:977:d020:53d6 with SMTP id
 qb8-20020a1709077e8800b00977d02053d6mr482959ejc.44.1686266054757; Thu, 08 Jun
 2023 16:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
In-Reply-To: <20230608103523.102267-10-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:14:03 -0700
Message-ID: <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Add libbpf API to get generic perf event name.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

I don't think this belongs in libbpf and shouldn't be exposed as
public API. Please move it into bpftool and make it internal (if
Quentin is fine with this in the first place).


>  tools/lib/bpf/libbpf.c   | 107 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   |  56 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |   6 +++
>  3 files changed, 169 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 47632606..27d396f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -119,6 +119,64 @@
>         [BPF_STRUCT_OPS]                =3D "struct_ops",
>  };
>
> +static const char * const perf_type_name[] =3D {
> +       [PERF_TYPE_HARDWARE]            =3D "hardware",
> +       [PERF_TYPE_SOFTWARE]            =3D "software",
> +       [PERF_TYPE_TRACEPOINT]          =3D "tracepoint",
> +       [PERF_TYPE_HW_CACHE]            =3D "hw_cache",
> +       [PERF_TYPE_RAW]                 =3D "raw",
> +       [PERF_TYPE_BREAKPOINT]          =3D "breakpoint",
> +};
> +
> +static const char * const perf_hw_name[] =3D {
> +       [PERF_COUNT_HW_CPU_CYCLES]              =3D "cpu_cycles",
> +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D "instructions",
> +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D "cache_references",
> +       [PERF_COUNT_HW_CACHE_MISSES]            =3D "cache_misses",
> +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D "branch_instructions"=
,
> +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D "branch_misses",
> +       [PERF_COUNT_HW_BUS_CYCLES]              =3D "bus_cycles",
> +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D "stalled_cycles_front=
end",
> +       [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  =3D "stalled_cycles_backe=
nd",
> +       [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D "ref_cpu_cycles",
> +};
> +
> +static const char * const perf_hw_cache_name[] =3D {
> +       [PERF_COUNT_HW_CACHE_L1D]               =3D "l1d",
> +       [PERF_COUNT_HW_CACHE_L1I]               =3D "l1i",
> +       [PERF_COUNT_HW_CACHE_LL]                =3D "ll",
> +       [PERF_COUNT_HW_CACHE_DTLB]              =3D "dtlb",
> +       [PERF_COUNT_HW_CACHE_ITLB]              =3D "itlb",
> +       [PERF_COUNT_HW_CACHE_BPU]               =3D "bpu",
> +       [PERF_COUNT_HW_CACHE_NODE]              =3D "node",
> +};
> +
> +static const char * const perf_hw_cache_op_name[] =3D {
> +       [PERF_COUNT_HW_CACHE_OP_READ]           =3D "read",
> +       [PERF_COUNT_HW_CACHE_OP_WRITE]          =3D "write",
> +       [PERF_COUNT_HW_CACHE_OP_PREFETCH]       =3D "prefetch",
> +};
> +
> +static const char * const perf_hw_cache_op_result_name[] =3D {
> +       [PERF_COUNT_HW_CACHE_RESULT_ACCESS]     =3D "access",
> +       [PERF_COUNT_HW_CACHE_RESULT_MISS]       =3D "miss",
> +};
> +
> +static const char * const perf_sw_name[] =3D {
> +       [PERF_COUNT_SW_CPU_CLOCK]               =3D "cpu_clock",
> +       [PERF_COUNT_SW_TASK_CLOCK]              =3D "task_clock",
> +       [PERF_COUNT_SW_PAGE_FAULTS]             =3D "page_faults",
> +       [PERF_COUNT_SW_CONTEXT_SWITCHES]        =3D "context_switches",
> +       [PERF_COUNT_SW_CPU_MIGRATIONS]          =3D "cpu_migrations",
> +       [PERF_COUNT_SW_PAGE_FAULTS_MIN]         =3D "page_faults_min",
> +       [PERF_COUNT_SW_PAGE_FAULTS_MAJ]         =3D "page_faults_maj",
> +       [PERF_COUNT_SW_ALIGNMENT_FAULTS]        =3D "alignment_faults",
> +       [PERF_COUNT_SW_EMULATION_FAULTS]        =3D "emulation_faults",
> +       [PERF_COUNT_SW_DUMMY]                   =3D "dummy",
> +       [PERF_COUNT_SW_BPF_OUTPUT]              =3D "bpf_output",
> +       [PERF_COUNT_SW_CGROUP_SWITCHES]         =3D "cgroup_switches",
> +};
> +
>  static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_UNSPEC]                  =3D "unspec",
>         [BPF_LINK_TYPE_RAW_TRACEPOINT]          =3D "raw_tracepoint",
> @@ -8953,6 +9011,55 @@ const char *libbpf_bpf_attach_type_str(enum bpf_at=
tach_type t)
>         return attach_type_name[t];
>  }
>
> +const char *libbpf_perf_type_str(enum perf_type_id t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_type_name))
> +               return NULL;
> +
> +       return perf_type_name[t];
> +}
> +
> +const char *libbpf_perf_hw_str(enum perf_hw_id t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_hw_name))
> +               return NULL;
> +
> +       return perf_hw_name[t];
> +}
> +
> +const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_hw_cache_name))
> +               return NULL;
> +
> +       return perf_hw_cache_name[t];
> +}
> +
> +const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_hw_cache_op_name))
> +               return NULL;
> +
> +       return perf_hw_cache_op_name[t];
> +}
> +
> +const char *
> +libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_hw_cache_op_result_name))
> +               return NULL;
> +
> +       return perf_hw_cache_op_result_name[t];
> +}
> +
> +const char *libbpf_perf_sw_str(enum perf_sw_ids t)
> +{
> +       if (t < 0 || t >=3D ARRAY_SIZE(perf_sw_name))
> +               return NULL;
> +
> +       return perf_sw_name[t];
> +}
> +
>  const char *libbpf_bpf_link_type_str(enum bpf_link_type t)
>  {
>         if (t < 0 || t >=3D ARRAY_SIZE(link_type_name))
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 754da73..4123e4c 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -16,6 +16,7 @@
>  #include <stdbool.h>
>  #include <sys/types.h>  // for size_t
>  #include <linux/bpf.h>
> +#include <linux/perf_event.h>
>
>  #include "libbpf_common.h"
>  #include "libbpf_legacy.h"
> @@ -61,6 +62,61 @@ enum libbpf_errno {
>  LIBBPF_API const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t=
);
>
>  /**
> + * @brief **libbpf_perf_type_str()** converts the provided perf type val=
ue
> + * into a textual representation.
> + * @param t The perf type.
> + * @return Pointer to a static string identifying the perf type. NULL is
> + * returned for unknown **perf_type_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_type_str(enum perf_type_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_str()** converts the provided perf hw id
> + * into a textual representation.
> + * @param t The perf hw id.
> + * @return Pointer to a static string identifying the perf hw id. NULL i=
s
> + * returned for unknown **perf_hw_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_str(enum perf_hw_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_str()** converts the provided perf hw c=
ache
> + * id into a textual representation.
> + * @param t The perf hw cache id.
> + * @return Pointer to a static string identifying the perf hw cache id.
> + * NULL is returned for unknown **perf_hw_cache_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t)=
;
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_op_str()** converts the provided perf h=
w
> + * cache op id into a textual representation.
> + * @param t The perf hw cache op id.
> + * @return Pointer to a static string identifying the perf hw cache op i=
d.
> + * NULL is returned for unknown **perf_hw_cache_op_id** values.
> + */
> +LIBBPF_API const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op=
_id t);
> +
> +/**
> + * @brief **libbpf_perf_hw_cache_op_result_str()** converts the provided
> + * perf hw cache op result id into a textual representation.
> + * @param t The perf hw cache op result id.
> + * @return Pointer to a static string identifying the perf hw cache op r=
esult
> + * id. NULL is returned for unknown **perf_hw_cache_op_result_id** value=
s.
> + */
> +LIBBPF_API const char *
> +libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t);
> +
> +/**
> + * @brief **libbpf_perf_sw_str()** converts the provided perf sw id
> + * into a textual representation.
> + * @param t The perf sw id.
> + * @return Pointer to a static string identifying the perf sw id. NULL i=
s
> + * returned for unknown **perf_sw_ids** values.
> + */
> +LIBBPF_API const char *libbpf_perf_sw_str(enum perf_sw_ids t);
> +
> +/**
>   * @brief **libbpf_bpf_link_type_str()** converts the provided link type=
 value
>   * into a textual representation.
>   * @param t The link type.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2f..6ae0a36 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,10 @@ LIBBPF_1.2.0 {
>  LIBBPF_1.3.0 {
>         global:
>                 bpf_obj_pin_opts;
> +               libbpf_perf_hw_cache_op_result_str;
> +               libbpf_perf_hw_cache_op_str;
> +               libbpf_perf_hw_cache_str;
> +               libbpf_perf_hw_str;
> +               libbpf_perf_sw_str;
> +               libbpf_perf_type_str;
>  } LIBBPF_1.2.0;
> --
> 1.8.3.1
>

