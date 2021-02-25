Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC33259CF
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhBYWtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBYWtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:49:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD77C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:48:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x19so7091780ybe.0
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhnhqaoWr6h3ccPg3N1M+RLU3wfziP8GoxYqpBJN56k=;
        b=oSnlVK6m++aL4jRIiHz2h+T9tDFjl/QTZwiKjvt47RxiTqYLEPVCRDV6aCZedT5ujD
         jeKW6VmZlDCpfeawlIXH+c1U/Cshg2oiqZVmPWq3huuMR0cF67SqGj9tsxTEP0xN/sBR
         6d0JqO8CK1G6AMxOSiPYAerRt4UlwMTTFbi2/WYVmUBFS1D+BN2bp6W2OJqWM3huRLwl
         CtLa0X4ZgkdrZv/LeQBNfWm2gbJnBpmuTxt1Iv7GwXmlZEdel8cmEaNBpODeEz5qaxF8
         lsC340dO3NNjYh/4NQrYvePbkh9jEdopJv7uud9o3rVub1LnNgpkIoeeEOgHwajGgXvJ
         HAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhnhqaoWr6h3ccPg3N1M+RLU3wfziP8GoxYqpBJN56k=;
        b=h+15ep3lMLUu0KKHFe6vjxJHr3HLa8PnG3D9kkd01Yhg5V3XC849cKufAE7rBssGN2
         9cAmH1uMY/8EGVYfUnhGCVsw7p7DcDL/LPU+7hn6XyVbNifHfE1Wz6PRYgrbdSspwC2K
         mGMdM77A4NB7WfirAahMZ8hDX51X9MKu/82hB7/9NF983vEsoOSsSl8DFGQFKDrUlMr8
         HHJ3i/lUHZeMqyJKvqPzjf0Yi6VoreqCaIQ6oQyjanW/6PxYSy+Ak8fe+TWQZZAtGZWC
         pVPbPS+k8mKtlJjBJcUInk4XEXXjZ2cHSJAEaEZOIl3lHYi4qBylyB9evXH4Ymf+JvCU
         6wKg==
X-Gm-Message-State: AOAM533yxK8obAqUIxb84fZByhoMcG+EBk9MaE69xgbl+5UatDml29ld
        7nD7vlzyIXl/wQGjBMrKufvtP0h2s2TUnyORX+k=
X-Google-Smtp-Source: ABdhPJyHW0aGno5l0xIRGNt+8mn5xPHdouGmtMw+gTfT1UttvyHXlvw6ynLtlEtqgK+lqAXdNL1k+z8h1hrxXOlhhus=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr261144ybd.230.1614293312046;
 Thu, 25 Feb 2021 14:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073315.4121184-1-yhs@fb.com>
In-Reply-To: <20210225073315.4121184-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 14:48:21 -0800
Message-ID: <CAEf4Bzab1_49y_qjDEYKpjQ58Qj-tucZNt6hW=hpn+1itWmVDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/11] bpf: add arraymap support for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> This patch added support for arraymap and percpu arraymap.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

index_mask is overcautious in this case, but otherwise lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/arraymap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1f8453343bf2..4077a8ae7089 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -625,6 +625,42 @@ static const struct bpf_iter_seq_info iter_seq_info = {
>         .seq_priv_size          = sizeof(struct bpf_iter_seq_array_map_info),
>  };
>
> +static int bpf_for_each_array_elem(struct bpf_map *map, void *callback_fn,
> +                                  void *callback_ctx, u64 flags)
> +{
> +       u32 i, index, num_elems = 0;
> +       struct bpf_array *array;
> +       bool is_percpu;
> +       u64 ret = 0;
> +       void *val;
> +
> +       if (flags != 0)
> +               return -EINVAL;
> +
> +       is_percpu = map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
> +       array = container_of(map, struct bpf_array, map);
> +       if (is_percpu)
> +               migrate_disable();
> +       for (i = 0; i < map->max_entries; i++) {
> +               index = i & array->index_mask;

I don't think you need to use index_mask here, given you control i and
know that it will always be < map->max_entries.

> +               if (is_percpu)
> +                       val = this_cpu_ptr(array->pptrs[i]);
> +               else
> +                       val = array->value + array->elem_size * i;
> +               num_elems++;
> +               ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
> +                                       (u64)(long)&index, (u64)(long)val,
> +                                       (u64)(long)callback_ctx, 0);
> +               /* return value: 0 - continue, 1 - stop and return */
> +               if (ret)
> +                       break;
> +       }
> +
> +       if (is_percpu)
> +               migrate_enable();
> +       return num_elems;
> +}
> +
>  static int array_map_btf_id;
>  const struct bpf_map_ops array_map_ops = {
>         .map_meta_equal = array_map_meta_equal,
> @@ -643,6 +679,8 @@ const struct bpf_map_ops array_map_ops = {
>         .map_check_btf = array_map_check_btf,
>         .map_lookup_batch = generic_map_lookup_batch,
>         .map_update_batch = generic_map_update_batch,
> +       .map_set_for_each_callback_args = map_set_for_each_callback_args,
> +       .map_for_each_callback = bpf_for_each_array_elem,
>         .map_btf_name = "bpf_array",
>         .map_btf_id = &array_map_btf_id,
>         .iter_seq_info = &iter_seq_info,
> @@ -660,6 +698,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>         .map_delete_elem = array_map_delete_elem,
>         .map_seq_show_elem = percpu_array_map_seq_show_elem,
>         .map_check_btf = array_map_check_btf,
> +       .map_set_for_each_callback_args = map_set_for_each_callback_args,
> +       .map_for_each_callback = bpf_for_each_array_elem,
>         .map_btf_name = "bpf_array",
>         .map_btf_id = &percpu_array_map_btf_id,
>         .iter_seq_info = &iter_seq_info,
> --
> 2.24.1
>
