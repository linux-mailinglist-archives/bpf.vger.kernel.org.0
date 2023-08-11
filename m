Return-Path: <bpf+bounces-7614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BB779AC5
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 00:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A433F1C20B31
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FC34CCA;
	Fri, 11 Aug 2023 22:40:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F942F4E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 22:40:43 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333851FED
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:40:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26b362e4141so520431a91.2
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691793641; x=1692398441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnz6CXGdI5tjATMPj8y6HhcwUMQRaGJGbDyGoMCPg4U=;
        b=2Ae+kGzmS5z/nH3/XEG20uNs8QDBmhh2LREi27N9xhaikMf+TZ6iACjg/+FCgW3Epe
         yqJb2pOWcrVu5kIDGKIllDou3tRMxFnx1mTKaLUMrDvSiN3McIhTsRd9TVfTraHE7PUI
         in/J3mIC6F6F/4T85RdPtyG35dp7Ai0pqnz6rM9uJkKc+b0hRi7PBlmP2gSPo65cgSR/
         MJige+fBmfOuHziErAjmaQ4UYjyAOAwMANfa48xm4ALsN0mhDkWKZrNRD28mdZSvw7S1
         mPOG4LR+/s+mfm2gnEn3hrnzfd90sioeAUaGfLkrs4Z4yk2g4HnjfVl7hEcIK6przox7
         PJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691793641; x=1692398441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnz6CXGdI5tjATMPj8y6HhcwUMQRaGJGbDyGoMCPg4U=;
        b=CFpHHXvjQT2VqzaBIyq/+bq1/XipxMfceGplTY06y9uJQsQYC0mVmPqP5wwQMF1TyV
         RTNl5e5AvNDHZ87Hmddmebfh2wJABT6l7AgChAfBEnmvaJ6ZEIHbidjGVdgTLiL9ysXQ
         u8TxpNIsI3DI5RtFxLjM+pe0aqFfXbY2HxR6s/8KktAl/1z3530o+APVT0cy6my3ZToj
         HqVocXEY0GNgT3I9axDVr9Cp6MDPcMHV6cDxEyExP7Nn4T1nALvfT2Mv+XwNq1TB+U/H
         9wOgBnBc4nP3IL72qFxsVVeB8aEGmuicL8Gq/7Rqf2yaSCpwaFBfdhrffu36Yb2w967M
         wSaA==
X-Gm-Message-State: AOJu0YyCwD+6vEDzG2zW+yKlDfNYE3gIQyqL+fpDlcq+d0ug2M2QKWeC
	kRDUNAYibnxpPe5xprYLebJDeiE=
X-Google-Smtp-Source: AGHT+IGiqZF+yuCc49aHwgx/JihoN5pke9u7tgs+2Too0gvZdMfPdWpNJ4dE16YWAtoyWPyGxO3yXV4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:e74b:b0:1bc:5182:1ddb with SMTP id
 p11-20020a170902e74b00b001bc51821ddbmr1221948plf.3.1691793641717; Fri, 11 Aug
 2023 15:40:41 -0700 (PDT)
Date: Fri, 11 Aug 2023 15:40:40 -0700
In-Reply-To: <20230811201346.3240403-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811201346.3240403-1-davemarchevsky@fb.com>
Message-ID: <ZNa46DsinJIj5r+/@google.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support triple-underscore flavors
 for kfunc relocation
From: Stanislav Fomichev <sdf@google.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>, 
	dvernet@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Dave Marchevsky wrote:
> The function signature of kfuncs can change at any time due to their
> intentional lack of stability guarantees. As kfuncs become more widely
> used, BPF program writers will need facilities to support calling
> different versions of a kfunc from a single BPF object. Consider this
> simplified example based on a real scenario we ran into at Meta:
> 
>   /* initial kfunc signature */
>   int some_kfunc(void *ptr)
> 
>   /* Oops, we need to add some flag to modify behavior. No problem,
>     change the kfunc. flags = 0 retains original behavior */
>   int some_kfunc(void *ptr, long flags)
> 
> If the initial version of the kfunc is deployed on some portion of the
> fleet and the new version on the rest, a fleetwide service that uses
> some_kfunc will currently need to load different BPF programs depending
> on which some_kfunc is available.
> 
> Luckily CO-RE provides a facility to solve a very similar problem,
> struct definition changes, by allowing program writers to declare
> my_struct___old and my_struct___new, with ___suffix being considered a
> 'flavor' of the non-suffixed name and being ignored by
> bpf_core_type_exists and similar calls.
> 
> This patch extends the 'flavor' facility to the kfunc extern
> relocation process. BPF program writers can now declare
> 
>   extern int some_kfunc___old(void *ptr)
>   extern int some_kfunc___new(void *ptr, int flags)
> 
> then test which version of the kfunc exists with bpf_ksym_exists.
> Relocation and verifier's dead code elimination will work in concert as
> expected, allowing this pattern:
> 
>   if (bpf_ksym_exists(some_kfunc___old))
>     some_kfunc___old(ptr);
>   else
>     some_kfunc___new(ptr, 0);
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 17883f5a44b9..8949d489a35f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -550,6 +550,7 @@ struct extern_desc {
>  	int btf_id;
>  	int sec_btf_id;
>  	const char *name;
> +	char *essent_name;
>  	bool is_set;
>  	bool is_weak;
>  	union {
> @@ -3770,6 +3771,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>  	struct extern_desc *ext;
>  	int i, n, off, dummy_var_btf_id;
>  	const char *ext_name, *sec_name;
> +	size_t ext_essent_len;
>  	Elf_Scn *scn;
>  	Elf64_Shdr *sh;
>  
> @@ -3819,6 +3821,14 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>  		ext->sym_idx = i;
>  		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
>  
> +		ext_essent_len = bpf_core_essential_name_len(ext->name);
> +		ext->essent_name = NULL;
> +		if (ext_essent_len != strlen(ext->name)) {
> +			ext->essent_name = malloc(ext_essent_len + 1);

Do we care about malloc's potential -ENOMEM here?

