Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAE2C1C71
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 05:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKXECY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 23:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKXECY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 23:02:24 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A7C0613CF;
        Mon, 23 Nov 2020 20:02:23 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t21so16283336pgl.3;
        Mon, 23 Nov 2020 20:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7j9kpyzYVbFqBTp8yoRooFvKTkwE619SUxdNJVGQRQ=;
        b=vTkVb7PFtRqYIZ5Zv1Jf5dMl/oOBJmbGzi0fYInd/MsVy7sJKhpuagB6ipZMP6PdEV
         W77wWWisCl7TH/zAfAvEgjkQH/sLXhr9Pp/8lRLkanw9gAs+BYfg1S+iPYEa/Fjvdulo
         7A4EL1yQBT6S/EoZ/qD5vGya7bmY1OfpDf0wB8oFTmlJv1yZqYXQ9GuaCTSiY/LAoKul
         o5uo+0ROQOXSZlxaoudePfSlVJP3LVgkdqE8O4tCGhZOQkcL3dvkSQ7I4kGnbHTmUIRy
         Pv4CBLYTwv+q6Smyb4kYYfrSkWzi6FfLZpPv9jH/7JalJESOeSrHSvGEC6goXB72RHDN
         EZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7j9kpyzYVbFqBTp8yoRooFvKTkwE619SUxdNJVGQRQ=;
        b=eZIWyIYvdZn6GrlJRXibpdBQhwO/bsr0OWHIuAp9fWdyi88Wt0kD19pTHnhZRoHY5Q
         aHDvHKPOVlh5g47N/bott8dgpZgLKHAv2ifdlay+KYKBFZFftaefq2FDOrv6rqq5qruw
         x3kaBgKgq5YvAUVoDBX/WL8eLEH2n5gS1T8tcED+0RInfK3J+TCWFMXv9Ml9AuZK/dTF
         LOdM5yfGWLlpfC3DYy5dO7PeeR25wPekJVFZ/zHGQEf8DXPUY59ar+K1/M45Q8BvHucC
         cMnzxjMsgHRLZPVDjpSvpCKr1lHW+DsZMMUhHDvESd+OSqw2r7NnlmvFm5i1pTmG8oXW
         h1Kg==
X-Gm-Message-State: AOAM532/l5PSRANFPXj7ym2XntL4Rd011lpo+ftj/QGgLfFb4uX57gdc
        7O8GENyj+BtQczYhlE7tGebGIhzmuyQ=
X-Google-Smtp-Source: ABdhPJwU//FvSXnxJzPFDRZODQvETrlbeP3Nqhga/Z6onTA2FrA5loO2hULeH9AJv5mYO1LDt0679A==
X-Received: by 2002:a62:cd0d:0:b029:18b:a1cc:a5be with SMTP id o13-20020a62cd0d0000b029018ba1cca5bemr2348242pfg.67.1606190543378;
        Mon, 23 Nov 2020 20:02:23 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:2397])
        by smtp.gmail.com with ESMTPSA id 145sm11942774pga.11.2020.11.23.20.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:02:22 -0800 (PST)
Date:   Mon, 23 Nov 2020 20:02:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
Message-ID: <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120131708.3237864-2-kpsingh@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 01:17:07PM +0000, KP Singh wrote:
> +
> +static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
> +{
> +	return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
> +
> +const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
> +	.func		= bpf_ima_inode_hash,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
> +	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
> +	.allowed	= bpf_ima_inode_hash_allowed,
> +};
> +
>  static const struct bpf_func_proto *
>  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_task_storage_delete_proto;
>  	case BPF_FUNC_bprm_opts_set:
>  		return &bpf_bprm_opts_set_proto;
> +	case BPF_FUNC_ima_inode_hash:
> +		return &bpf_ima_inode_hash_proto;

That's not enough for correctness.
Not only hook has to sleepable, but the program has to be sleepable too.
The patch 3 should be causing all sort of kernel warnings
for calling mutex from preempt disabled.
There it calls bpf_ima_inode_hash() from SEC("lsm/file_mprotect") program.
"lsm/" is non-sleepable. "lsm.s/" is.
please enable CONFIG_DEBUG_ATOMIC_SLEEP=y in your config.
