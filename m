Return-Path: <bpf+bounces-862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075D707C40
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E573D28181E
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53438BEA;
	Thu, 18 May 2023 08:39:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A222A9D4
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 08:39:38 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F982102
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:39:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso1644428f8f.2
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684399162; x=1686991162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56mGsm1XHgPkxQbRb15mbR+hb+u+NHIuybwu5uaNASg=;
        b=Yqxq8ycyGFHpVWwKBVCKpDmKYNPRpglWIdSdckGQELOZwjxArzdovRIgGU9d1WM7x5
         vCo2rxwSS0Y9C/XfKrEgTEz5SscmrVJ0jrC1DXRIPedjoScmdTreZN7wkt+C8WkMIzEd
         1E4XkYgDfcSPggqRshzGHnH41pkTyJzX05f4s8ybAqITgVg5H5PQLTFA9tZ1YEOCtrNj
         w5/VriKXtLcwPiMNAdpJEqdpkyHAv7hefsKA4AgFkIaVcRtU3pX46mAZDp0X0BlT4ZZH
         lZh+RfhWl/vAzI+nG8tu3Nk0u37fCrwTtdrxrgpCYhi+9zkZHjfG3Ml+uYAdk/Y+pijz
         hrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399162; x=1686991162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56mGsm1XHgPkxQbRb15mbR+hb+u+NHIuybwu5uaNASg=;
        b=XrRY2j43Sn84OGNWE3wvwgcBpUrzqQIK3g6pJKwe3J/d/vi9Z00ubXBnnqeQDhsAIS
         i/vWvFcRYHZk/5+/1Ky7VkzopMuwSQJObjWBliPnnd9Uyp+QVL4ET16KjWS/7KbSM2aI
         2XkevY77JxKEuvjkEONMrxFYu4bHQjWo26sxJNIwC0MT1oV1jvi05svlTKd2a+RCrnKP
         pELMdzQuKtIAhGXcA+bTyxEPMozkw2z8w3nZoRZFX/b/Tfx8vBAaiJ0HqdJpzR1S4N7S
         qm2SzcEQ2jdGTO6CbkaODGPaj3JEHFAC5YI13+zerae8KEMgg6K/I7pKPBK0TWvK8Q/R
         Xj9g==
X-Gm-Message-State: AC+VfDwAer4qf3vSKDKeudWTte7JK4YUfPy7uoxk16ZlXS8QvINMXfax
	79E0UTbNsWA3uVzK0CgDq2WMyfPUt2q1uw==
X-Google-Smtp-Source: ACHHUZ7nTidVG7YDhPZxprQyNsVYrdkybPsfb8CV3NrTyniXBmdIfz3p4y6wRw1xMl9Z+uIhksOfSw==
X-Received: by 2002:a5d:4cc4:0:b0:307:a5d1:dbae with SMTP id c4-20020a5d4cc4000000b00307a5d1dbaemr950930wrt.71.1684399161852;
        Thu, 18 May 2023 01:39:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id x15-20020adfec0f000000b002cea9d931e6sm1394497wrn.78.2023.05.18.01.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 01:39:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 May 2023 10:39:19 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
	daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function
 representations sorted by name _and_ address
Message-ID: <ZGXkN2TeEJZHMSG8@krava>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517161648.17582-6-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
> By making sorting function for our ELF function list match on
> both name and function, we ensure that the set of ELF functions
> includes multiple copies for functions which have multiple instances
> across CUs.  For example, cpumask_weight has 22 instances in
> System.map/kallsyms:
> 
> ffffffff8103b530 t cpumask_weight
> ffffffff8103e300 t cpumask_weight
> ffffffff81040d30 t cpumask_weight
> ffffffff8104fa00 t cpumask_weight
> ffffffff81064300 t cpumask_weight
> ffffffff81082ba0 t cpumask_weight
> ffffffff81084f50 t cpumask_weight
> ffffffff810a4ad0 t cpumask_weight
> ffffffff810bb740 t cpumask_weight
> ffffffff8110a6c0 t cpumask_weight
> ffffffff81118ab0 t cpumask_weight
> ffffffff81129b50 t cpumask_weight
> ffffffff81137dc0 t cpumask_weight
> ffffffff811aead0 t cpumask_weight
> ffffffff811d6800 t cpumask_weight
> ffffffff811e1370 t cpumask_weight
> ffffffff812fae80 t cpumask_weight
> ffffffff81375c50 t cpumask_weight
> ffffffff81634b60 t cpumask_weight
> ffffffff817ba540 t cpumask_weight
> ffffffff819abf30 t cpumask_weight
> ffffffff81a7cb60 t cpumask_weight
> 
> With ELF representations for each address, and DWARF info about
> addresses (low_pc) we can match DWARF with ELF accurately.
> The result for the BTF representation is that we end up with
> a single de-duped function:
> 
> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
> 
> ...and 22 DECL_TAGs for each address that point at it:
> 
> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1

right, Yonghong pointed this out in:
  https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/

it's problem, because we pass btf id as attach id during bpf program load,
and kernel does not have a way to figure out which address from the associated
DECL_TAGs to use

if we could change dedup algo to take the function address into account and
make it not de-duplicate equal functions with different addresses, then we
could:

  - find btf id that properly and uniquely identifies the function we
    want to trace

  - store the vmlinux base address and treat stored function addresses as
    offsets, so the verifier can get proper address even if the kernel
    is relocated

    or

  - add support for kernel's kallsyms to return address for given btf id,
    I plan to check on this one

jirka

> 
> Consider another case where the same name - wakeup_show() - is
> used for two different function signatures:
> 
> From kernel/irq/irqdesc.c
> 
> static ssize_t wakeup_show(struct kobject *kobj,
>  			   struct kobj_attribute *attr, char *buf)
> 
> ...and from drivers/base/power/sysfs.c
> 
> static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
>                            char *buf);
> 
> We see both defined in BTF, along with the addresses that
> tell us which is which:
> 
> [28472] FUNC 'wakeup_show' type_id=11214 linkage=static
> 
> specifies
> 
> [11214] FUNC_PROTO '(anon)' ret_type_id=76 vlen=3
>         'kobj' type_id=877
>         'attr' type_id=11200
>         'buf' type_id=56
> 
> ...and has declaration tag
> 
> [28473] DECL_TAG 'address=0xffffffff8115eab0' type_id=28472 component_idx=-1
> 
> which identifies
> 
> ffffffff8115eab0 t wakeup_show
> 
> ...as the function with the first signature.
> 
> Similarly,
> 
> [114375] FUNC 'wakeup_show' type_id=4750 linkage=static
> 
> [4750] FUNC_PROTO '(anon)' ret_type_id=76 vlen=3
>         'dev' type_id=1488
>         'attr' type_id=3909
>         'buf' type_id=56
> ...and
> 
> [114376] DECL_TAG 'address=0xffffffff8181eac0' type_id=114375 component_idx=-1
> 
> ...tell us that
> 
> ffffffff8181eac0 t wakeup_show
> 
> ...has the second signature.  So we can accommodate multiple
> functions with conflicting signatures in BTF, since we have
> added extra info to map from function description in BTF
> to address.
> 
> In total for vmlinux 52006 DECL_TAGs are added, and these add
> 2MB to the BTF representation.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3bd0fe0..315053d 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -988,13 +988,25 @@ static int functions_cmp(const void *_a, const void *_b)
>  {
>  	const struct elf_function *a = _a;
>  	const struct elf_function *b = _b;
> +	int ret;
>  
>  	/* if search key allows prefix match, verify target has matching
>  	 * prefix len and prefix matches.
>  	 */
>  	if (a->prefixlen && a->prefixlen == b->prefixlen)
> -		return strncmp(a->name, b->name, b->prefixlen);
> -	return strcmp(a->name, b->name);
> +		ret = strncmp(a->name, b->name, b->prefixlen);
> +	else
> +		ret = strcmp(a->name, b->name);
> +
> +	if (ret || !b->addr)
> +		return ret;
> +
> +	/* secondarily sort/search by address. */
> +	if (a->addr < b->addr)
> +		return -1;
> +	if (a->addr > b->addr)
> +		return 1;
> +	return 0;
>  }
>  
>  #ifndef max
> @@ -1044,9 +1056,11 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>  }
>  
>  static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> -						       const char *name, size_t prefixlen)
> +						       struct function *fn, size_t prefixlen)
>  {
> -	struct elf_function key = { .name = name, .prefixlen = prefixlen };
> +	struct elf_function key = { .name = function__name(fn),
> +				    .addr = fn->low_pc,
> +				    .prefixlen = prefixlen };
>  
>  	return bsearch(&key, encoder->functions.entries, encoder->functions.cnt, sizeof(key), functions_cmp);
>  }
> @@ -1846,7 +1860,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  				continue;
>  
>  			/* prefer exact function name match... */
> -			func = btf_encoder__find_function(encoder, name, 0);
> +			func = btf_encoder__find_function(encoder, fn, 0);
>  			if (func) {
>  				if (func->generated)
>  					continue;
> @@ -1863,7 +1877,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  				 * it does not have optimized-out parameters
>  				 * in any cu.
>  				 */
> -				func = btf_encoder__find_function(encoder, name,
> +				func = btf_encoder__find_function(encoder, fn,
>  								  strlen(name));
>  				if (func) {
>  					save = true;
> -- 
> 2.31.1
> 

