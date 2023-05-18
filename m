Return-Path: <bpf+bounces-873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D2708603
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EAD281987
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5E24124;
	Thu, 18 May 2023 16:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5E53A8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 16:22:57 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C568E61
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 09:22:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso402299266b.2
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684426941; x=1687018941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VO/GF3onzY5qj0NLNyPKjMNqp3XL4/kANnZEDq63e8=;
        b=Rz/Cp15ukdK8iJPsG/yTHjHTck/9PkBhWTk3xqNWyXHVexr5LAwBJxKQlIhGaII4SU
         fDcwlynhuT5PqxiMMkht90A6f/4C46grIxckhVoPUC1abEq+SxfyGanD1fY+mwrxwF9K
         oikszeMSooSY20RvENifys2nxRKfMixpv5b0TuX8b6szRu/QA8aPNmE5pxCw9C/bGR5W
         XxvEeXx+u2tkDc2cbPqFCszYGZNwL1tedX9JAUN78plLCtBPiOH4/FOWgaLhp/rcmRJI
         IN7vwh44t2Od6Pu8BfnYINc7tZBNu0E7WeWcnlehnfSzypLe2OYUwNLb+6EMXfzv7iGc
         8txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426941; x=1687018941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VO/GF3onzY5qj0NLNyPKjMNqp3XL4/kANnZEDq63e8=;
        b=NgZaIINVIVSsVP8UCw1fXdFCXIBxY8xYHnF11xumlWc2U1LnQzVl8Y3w/+SgHS61nJ
         RNg3gbmp/O/Ghj88WHAK8ALgYi+pdJl3EhQw9Kx7oPfCh2Rr2ps9MpQ8D90/5Tp+YBmt
         G9bvP7ftOtOc/8oeGLIWn64+BfEr285+jP0ca8LSKgSmp7wxbleQj3PhjavNwrIF9sDg
         0fCxVZaOyAZrlUZHJnrKqGGRzZRwVag//vIFcBMWbBZAvND1eWCvpXHG9d22eIsB2amy
         d9ICeFnwreK3oOIoZ4biCRSwq5iLUOlg/cDVlEYCcQVqBHVBp8kU33DwUtj8+HmUDvrQ
         oCcg==
X-Gm-Message-State: AC+VfDzcolhuJ99LWHWSBsnHi2s2M0blrstDp3vb7rukGzSZLYuXmW1/
	Iy2V2sxd+2PjLI5oblkP02M=
X-Google-Smtp-Source: ACHHUZ777+1/2dN26qH+miZk8vuRtmwJyoX8rn5QjsYcwsTOiL//lxQ5XtHobt911RR9N4LWLm/nCg==
X-Received: by 2002:a17:906:ef0e:b0:965:c2ab:7014 with SMTP id f14-20020a170906ef0e00b00965c2ab7014mr40483585ejs.35.1684426940695;
        Thu, 18 May 2023 09:22:20 -0700 (PDT)
Received: from krava (static-84-42-143-70.bb.vodafone.cz. [84.42.143.70])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b0095807ab4b57sm1168468eju.178.2023.05.18.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:22:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 May 2023 18:22:18 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org, ast@kernel.org,
	yhs@fb.com, andrii@kernel.org, daniel@iogearbox.net,
	laoar.shao@gmail.com, martin.lau@linux.dev, song@kernel.org,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function
 representations sorted by name _and_ address
Message-ID: <ZGZQuqVD7gNjia7Z@krava>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com>
 <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 02:23:34PM +0100, Alan Maguire wrote:
> On 18/05/2023 09:39, Jiri Olsa wrote:
> > On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
> >> By making sorting function for our ELF function list match on
> >> both name and function, we ensure that the set of ELF functions
> >> includes multiple copies for functions which have multiple instances
> >> across CUs.  For example, cpumask_weight has 22 instances in
> >> System.map/kallsyms:
> >>
> >> ffffffff8103b530 t cpumask_weight
> >> ffffffff8103e300 t cpumask_weight
> >> ffffffff81040d30 t cpumask_weight
> >> ffffffff8104fa00 t cpumask_weight
> >> ffffffff81064300 t cpumask_weight
> >> ffffffff81082ba0 t cpumask_weight
> >> ffffffff81084f50 t cpumask_weight
> >> ffffffff810a4ad0 t cpumask_weight
> >> ffffffff810bb740 t cpumask_weight
> >> ffffffff8110a6c0 t cpumask_weight
> >> ffffffff81118ab0 t cpumask_weight
> >> ffffffff81129b50 t cpumask_weight
> >> ffffffff81137dc0 t cpumask_weight
> >> ffffffff811aead0 t cpumask_weight
> >> ffffffff811d6800 t cpumask_weight
> >> ffffffff811e1370 t cpumask_weight
> >> ffffffff812fae80 t cpumask_weight
> >> ffffffff81375c50 t cpumask_weight
> >> ffffffff81634b60 t cpumask_weight
> >> ffffffff817ba540 t cpumask_weight
> >> ffffffff819abf30 t cpumask_weight
> >> ffffffff81a7cb60 t cpumask_weight
> >>
> >> With ELF representations for each address, and DWARF info about
> >> addresses (low_pc) we can match DWARF with ELF accurately.
> >> The result for the BTF representation is that we end up with
> >> a single de-duped function:
> >>
> >> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
> >>
> >> ...and 22 DECL_TAGs for each address that point at it:
> >>
> >> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
> >> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
> >> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
> >> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
> >> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
> >> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
> >> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
> >> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
> >> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
> >> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
> >> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
> >> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
> >> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
> >> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
> >> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
> >> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
> >> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
> >> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
> >> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
> >> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
> >> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
> >> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1
> > 
> > right, Yonghong pointed this out in:
> >   https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/
> > 
> > it's problem, because we pass btf id as attach id during bpf program load,
> > and kernel does not have a way to figure out which address from the associated
> > DECL_TAGs to use
> > 
> > if we could change dedup algo to take the function address into account and
> > make it not de-duplicate equal functions with different addresses, then we
> > could:
> > 
> >   - find btf id that properly and uniquely identifies the function we
> >     want to trace
> > 
> 
> So maybe a more natural approach would be to extend BTF_KIND_FUNC
> (I think Alexei suggested something this earlier but I could be
> misremembering) as follows:
> 
> 
> 2.2.12 BTF_KIND_FUNC
> ~~~~~~~~~~~~~~~~~~~~
> 
> ``struct btf_type`` encoding requirement:
>   * ``name_off``: offset to a valid C identifier
> -  * ``info.kind_flag``: 0
> +  * ``info.kind_flag``: 0 or 1 if additional ``struct btf_func`` follows
>   * ``info.kind``: BTF_KIND_FUNC
>   * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
>                    or BTF_FUNC_EXTERN)
>   * ``type``: a BTF_KIND_FUNC_PROTO type
> 
> - No additional type data follow ``btf_type``.
> + If ``info.kind_flag`` is specified, a ``struct btf_func`` follows.::
> +
> +	struct btf_func {
> +		__u64 addr;
> +	};
> + Otherwise no additional type data follows ``btf_type``.
> 
> 
> With the above, dedup could be made to fail when functions have non-
> identical associated addresses. Judging by the number of DECL_TAGs in
> the RFC, we'd end up with ~1000 extra BTF_KIND_FUNCs, and the extra
> space for struct btf_funcs would require roughly 400k. We'd still get
> dedup of FUNC_PROTOs, so I suspect the extra size would be < 1MB.

nice, I think it's better solution

> 
> 
> 
> >   - store the vmlinux base address and treat stored function addresses as
> >     offsets, so the verifier can get proper address even if the kernel
> >     is relocated
> >
> 
> yep; when we read kernel/module BTF in we could hopefully carry out
> this recalculation and update the vmlinux/module BTF addresses
> accordingly.

I wonder now when the address will be stored as number (not string) we
could somehow generate relocation records and have the module loader
do the relocation automatically

not sure how that works for vmlinux when it's loaded/relocated on boot

jirka

