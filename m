Return-Path: <bpf+bounces-2814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A873463D
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 15:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38C628115A
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3C1C32;
	Sun, 18 Jun 2023 13:08:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428721C03
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 13:08:07 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9853B0
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 06:08:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso25907695e9.2
        for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093684; x=1689685684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=be6mH5D3WUOzfd4VPw/Czm4PyfaexkDAfvVSP+CBVaE=;
        b=LzNoojt79D1e3fvfq0+AudQ5fvxhpIpZm84YOhXaS1wqiOrJQcNqDjyZGByb79g6Qs
         3+X+SjuxRCQHTftDVH+v/LoxHhQX6T4aIZCMabRQvLgB1oGDyTxMPuxz6+hEuSxVDAao
         8GTZD1MnO8hIMHXUTfndVxlSN6bPzuoWhDE5BC55MbApWmVBKaBuM7UD5nEL9+D2qJqq
         yv46Q9yxVxXzCwzSofeNLyLbD8lKBLGnP6EGoGZy8NepivS9GWmcjWYjMSul+/n2eZ2Y
         kST6H8K/1yE4Vcp+QGRB4mm+Lxym7DDmo0+STorLsQhIREKYr/sT1sBYwW3W0OWud3x+
         4IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093684; x=1689685684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be6mH5D3WUOzfd4VPw/Czm4PyfaexkDAfvVSP+CBVaE=;
        b=BYMMAuaMgnhixIulKbhHcFglxGg1CUrIkFvxX5GauKDs8ugOjjH53zqbZb/ir6NvYe
         Hz8VNkV6fiuUDXdbBfxYKQd4eA5toy+f/ndMmFRrXQG0Xio6slDlUiZHVQDvfWWWXbFM
         ENOlEHGLdbmYku469U1xUcBQ4gylxh02FRykfkVUOGa7d7LKPpXGdRtm+N7PZZQ0sJEX
         RBvRRXevLezZ2M5lpPtPNUnmMJoFBqCp66nhQ4M7NZNBO2dnUzC6vt5iKRzLu2Lhbz1l
         F5miI/SEWHWIXm1g5jT4szOuly2Hbinu024QwTlge1OVL5Rf5BGccwtQRb8q+7DJi+Sg
         qSLA==
X-Gm-Message-State: AC+VfDyXhtTOyxCoyG5lj9wRp2aPRK2PjOhIS0Nz7tPTQQUuMyUPyGoa
	h2Cyw0+iVuI07lV7mTYAEbE=
X-Google-Smtp-Source: ACHHUZ6ZYGdrrMpyV2tUsCn20QmeNigp+ua0WI6SQ7So3OG+o73y2MDmnS5drDT8FKj+yGPOg0ZSTQ==
X-Received: by 2002:a7b:c045:0:b0:3f8:d0e7:dad8 with SMTP id u5-20020a7bc045000000b003f8d0e7dad8mr6414716wmc.3.1687093684264;
        Sun, 18 Jun 2023 06:08:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b003f7f2a1484csm7792866wmc.5.2023.06.18.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:08:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 18 Jun 2023 15:08:02 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, quentin@isovalent.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 4/9] btf: support kernel parsing of BTF with
 kind layout
Message-ID: <ZI8BsoyLkCPLaRG3@krava>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-5-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616171728.530116-5-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 06:17:22PM +0100, Alan Maguire wrote:

SNIP

>  static int btf_sec_info_cmp(const void *a, const void *b)
> @@ -5193,32 +5246,37 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
>  			      u32 btf_data_size)
>  {
>  	struct btf_sec_info secs[ARRAY_SIZE(btf_sec_info_offset)];
> -	u32 total, expected_total, i;
> +	u32 nr_secs = ARRAY_SIZE(btf_sec_info_offset);
> +	u32 total, expected_total, gap, i;
>  	const struct btf_header *hdr;
>  	const struct btf *btf;
>  
>  	btf = env->btf;
>  	hdr = &btf->hdr;
>  
> +	if (hdr->hdr_len < sizeof(struct btf_header))
> +		nr_secs--;
> +
>  	/* Populate the secs from hdr */
> -	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++)
> +	for (i = 0; i < nr_secs; i++)
>  		secs[i] = *(struct btf_sec_info *)((void *)hdr +
>  						   btf_sec_info_offset[i]);
>  
> -	sort(secs, ARRAY_SIZE(btf_sec_info_offset),
> +	sort(secs, nr_secs,
>  	     sizeof(struct btf_sec_info), btf_sec_info_cmp, NULL);
>  
>  	/* Check for gaps and overlap among sections */
>  	total = 0;
>  	expected_total = btf_data_size - hdr->hdr_len;
> -	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++) {
> +	for (i = 0; i < nr_secs; i++) {
>  		if (expected_total < secs[i].off) {
>  			btf_verifier_log(env, "Invalid section offset");
>  			return -EINVAL;
>  		}
> -		if (total < secs[i].off) {
> -			/* gap */
> -			btf_verifier_log(env, "Unsupported section found");
> +		gap = secs[i].off - total;
> +		if (gap >= 4) {
> +			/* gap larger than alignment gap */
> +			btf_verifier_log(env, "Unsupported section gap found");
>  			return -EINVAL;

this sems to break several btf header tests with:

	do_test_raw:PASS:check 0 nsec
	do_test_raw:FAIL:check expected err_str:Unsupported section found

	magic: 0xeb9f
	version: 1
	flags: 0x0
	hdr_len: 40
	type_off: 4
	type_len: 16
	str_off: 16
	str_len: 5
	btf_total_size: 61
	Unsupported section gap found
	#23/48   btf/btf_header test. Gap between hdr and type:FAIL


jirka

>  		}
>  		if (total > secs[i].off) {
> @@ -5230,7 +5288,7 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
>  					 "Total section length too long");
>  			return -EINVAL;
>  		}
> -		total += secs[i].len;
> +		total += secs[i].len + gap;
>  	}
>  
>  	/* There is data other than hdr and known sections */
> @@ -5293,7 +5351,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
>  		return -ENOTSUPP;
>  	}
>  
> -	if (hdr->flags) {
> +	if (hdr->flags & ~(BTF_FLAG_CRC_SET | BTF_FLAG_BASE_CRC_SET)) {
>  		btf_verifier_log(env, "Unsupported flags");
>  		return -ENOTSUPP;
>  	}
> @@ -5530,6 +5588,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>  	if (err)
>  		goto errout;
>  
> +	err = btf_parse_kind_layout_sec(env);
> +	if (err)
> +		goto errout;
> +
>  	err = btf_parse_type_sec(env);
>  	if (err)
>  		goto errout;
> -- 
> 2.39.3
> 

