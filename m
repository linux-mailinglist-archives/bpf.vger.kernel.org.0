Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26923526C60
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353981AbiEMVhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEMVhv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:37:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524834A91B
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:37:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x8so5213169pgr.4
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qu47h7zREAfemvwculnWduEowXo5JEccOKAE9qdNbXE=;
        b=IhKR2nv9IAul0e0AWYx5gKx+ghXQYZrIZgNReYgFdSSPuqvkOHnfFrRGe3uWRRPgPa
         g+0xm2nbVIW8YXtUn2KbkUy8c891oR0r/8CWkemYugJ46IdWX9asVpI4OhGXoPdMQpq1
         2jmw0sJKRtElP6PU2Og4uUpdS+8DL8/+a/sgFAO+oJRJ4aa9YWLNKJqhL69Pz09zqHrX
         OxYC8yVNP+tgc8lqH4IBeid2PZbe3XJtEZ5dmoSpZ0SzYXtHKryaqV0J/idvnWirRpBu
         jqf09VIKmLOMr5xnIk0fG6T/jMqRXZCgaHQPVc3Dk7TT0BI9Qd4zInln7mCExMYMVrSY
         ocuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qu47h7zREAfemvwculnWduEowXo5JEccOKAE9qdNbXE=;
        b=lFluB5T+OumRfpysZn6eoSU0LzgxJ87J/sKLdXLaI6cRkYRh23KUEH+OqOHYm7ei92
         O1leztce4VxJEY809g13mVRTijr7gyrCbCRryluuZZJ4qVRPTI7Q/fjcZ2Eqf0tnGHXW
         +vtMq0t3+VWzs/fDx3PvbKwZi9zgHZFmPnpGTcapM4c4BVNy19U62GcXgBEptu2VKGjn
         +6KOwK4ceD79c5YsxzZl0iicqM/ZpNBz/jfWt8gDrtDXvdirVTldyzVjMigWKYew3BF0
         Thu0WM1UJn8EJooQjtodzGSanJudQyigKJCPGDiYYj/NpY4NnPdyAvGeFRGJmzdkN5h9
         6Ckw==
X-Gm-Message-State: AOAM533tgn+KvgV9OmaNjunVvrfNu01HBShOUkLiPxyfZzaBYzHDkjHO
        4mD2W80kL76ongMmDdmvV9c=
X-Google-Smtp-Source: ABdhPJwq7LXYEmpfrlLwtjlkZZJE1azGnEK3I9Ddb8LX4bOmpnHLrvo+qVhOtT9BcrOZGbPcgebcEA==
X-Received: by 2002:a62:64d8:0:b0:50d:c2f6:9983 with SMTP id y207-20020a6264d8000000b0050dc2f69983mr6271198pfb.34.1652477869651;
        Fri, 13 May 2022 14:37:49 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id x186-20020a6386c3000000b003c14af50634sm2103980pgd.76.2022.05.13.14.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 14:37:49 -0700 (PDT)
Date:   Fri, 13 May 2022 14:37:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Add dynptr data slices
Message-ID: <20220513213747.j3tj2qtbnjszy64n@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-6-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509224257.3222614-6-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:42:56PM -0700, Joanne Koong wrote:
>  	} else if (is_acquire_function(func_id, meta.map_ptr)) {
> -		int id = acquire_reference_state(env, insn_idx);
> +		int id = 0;
> +
> +		if (is_dynptr_ref_function(func_id)) {
> +			int i;
> +
> +			/* Find the id of the dynptr we're acquiring a reference to */
> +			for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +				if (arg_type_is_dynptr(fn->arg_type[i])) {
> +					if (id) {
> +						verbose(env, "verifier internal error: more than one dynptr arg in a dynptr ref func\n");
> +						return -EFAULT;
> +					}
> +					id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);

I'm afraid this approach doesn't work.
Consider:
  struct bpf_dynptr ptr;
  u32 *data1, *data2;

  bpf_dynptr_alloc(8, 0, &ptr);
  data1 = bpf_dynptr_data(&ptr, 0, 8);
  data2 = bpf_dynptr_data(&ptr, 8, 8);
  if (data1)
     *data2 = 0; /* this will succeed, but shouldn't */

The same 'id' is being reused for data1 and data2 to make sure
that bpf_dynptr_put(&ptr); will clear data1/data2,
but data1 and data2 will look the same in mark_ptr_or_null_reg().

> +				}
> +			}
> +			if (!id) {
> +				verbose(env, "verifier internal error: no dynptr args to a dynptr ref func\n");
> +				return -EFAULT;
> +			}
> +		} else {
> +			id = acquire_reference_state(env, insn_idx);
> +			if (id < 0)
> +				return id;
> +		}
>  
> -		if (id < 0)
> -			return id;
>  		/* For mark_ptr_or_null_reg() */
>  		regs[BPF_REG_0].id = id;
>  		/* For release_reference() */
> @@ -9810,7 +9864,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
>  	u32 id = regs[regno].id;
>  	int i;
>  
> -	if (ref_obj_id && ref_obj_id == id && is_null)
> +	if (ref_obj_id && ref_obj_id == id && is_null &&
> +	    !is_ref_obj_id_dynptr(state, id))

This bit is avoiding doing release of dynptr's id,
because id is shared between dynptr and slice's id.

In this patch I'm not sure what is the purpose of bpf_dynptr_data()
being an acquire function. data1 and data2 are not acquiring.
They're not incrementing refcnt of dynptr.

I think normal logic of check_helper_call() that does:
        if (type_may_be_null(regs[BPF_REG_0].type))
                regs[BPF_REG_0].id = ++env->id_gen;

should be preserved.
It will give different id-s to data1 and data2 and the problem
described earlier will not exist.

The transfer of ref_obj_id from dynptr into data1 and data2 needs to happen,
but this part:
        u32 ref_obj_id = regs[regno].ref_obj_id;
        u32 id = regs[regno].id;
        int i;

        if (ref_obj_id && ref_obj_id == id && is_null)
                /* regs[regno] is in the " == NULL" branch.
                 * No one could have freed the reference state before
                 * doing the NULL check.
                 */
                WARN_ON_ONCE(release_reference_state(state, id));

should be left alone.
bpf_dynptr_put(&ptr); will release dynptr and will clear data1 and data2.
if (!data1)
   will not release dynptr, because data1->id != data1->ref_obj_id.

In other words bpf_dynptr_data() should behave like is_ptr_cast_function().
It should trasnfer ref_obj_id to R0, but should give new R0->id.
See big comment in bpf_verifier.h next to ref_obj_id.
