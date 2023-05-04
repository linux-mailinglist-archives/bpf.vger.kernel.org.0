Return-Path: <bpf+bounces-40-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1F6F78C9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC65280E22
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4BC155;
	Thu,  4 May 2023 22:09:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D037C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:09:46 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312B1249B
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:09:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6439f186366so26245b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683238184; x=1685830184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pM/CJu6a7n3uARXl7xMzmgg9TR8hFopXFSlEMebtshE=;
        b=U25AFYhjvZhXc2bIEx/nmsCdgXGEGYGL4/XmADIYpHme0Tz39DqBoNT3OJOZNznHWA
         JwP6tTWjWIxJM5U8J0ANBrFjFhgg3cHVlfJjMNCHUYEVdqLJ7LKnVsJj5huBZlq5JKv5
         e2QOVnunwroVydX8UV8ZnFe0S1E7IqLyJFSfs57JeCKPzhjWwrG3I0YY32hBb+h5by8s
         LZ4UTGC6ta40UPwmN+eTfkV6At1F7OzF1w1sU3OBXGWeggngR4UEPuqPpTrdiPLokJPj
         oDSwyyT0NVVxXQO2unh3gcZOBV8ds1l7u9OQ3UVaoTlxuv8tNOlFd42yyncsGDSyX3lN
         +OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238184; x=1685830184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM/CJu6a7n3uARXl7xMzmgg9TR8hFopXFSlEMebtshE=;
        b=FJcRXyL48Y+ayt7B8aTCC5nuK0ALxXI/1XMrEzBV05Vg+hHl+ay99+OwL2226u6g2t
         BG6+x18P3hP2OH0F0pHXAiMZz3vQn77tRk+RFTUXlg3a3XJmGm1chHh3P5ZROt0fdDUS
         f12rLZZfyA6aOJnunPKNhWtPTtf4KHe6R3AKMPfzTj5MWdTa5fEs90Lxv1bu4dhooO43
         pYTkV9vall+DV09zkInYzUQDbpot/FX73FxSlj/AftFOfTHoHFqq2cbzoCjGiMbf5/hR
         P6UiOwbm6PodSMCctHjxfXMWBGeKCKDf1ofB6ap5wvvLIjVAi2+J7Ir6oiZ5jEHoVajA
         l84A==
X-Gm-Message-State: AC+VfDzUmQDkqpjPtDSMjMIQdNVPCpid8Sw9JfHQCFqVl2GaVniNRVHJ
	N37l1DnCT12HvuuQjjtGf7A=
X-Google-Smtp-Source: ACHHUZ4Xk3vqDv29bdSRA/i7CFHxcA16EOIVBoU/BSUW69p49u9BPTfMemu8GEQUIf1YVo/w7PtZBg==
X-Received: by 2002:a05:6a00:179c:b0:627:6328:79f1 with SMTP id s28-20020a056a00179c00b00627632879f1mr4146955pfg.34.1683238184140;
        Thu, 04 May 2023 15:09:44 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b006436ffa3dc4sm159446pfi.24.2023.05.04.15.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:09:43 -0700 (PDT)
Date: Thu, 4 May 2023 15:09:41 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 09/10] bpf: use recorded bpf_capable flag in JIT
 code
Message-ID: <20230504220941.rppjhdmnydlpm7ig@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502230619.2592406-10-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 04:06:18PM -0700, Andrii Nakryiko wrote:
>  
> -int bpf_jit_charge_modmem(u32 size)
> +int bpf_jit_charge_modmem(u32 size, const struct bpf_prog *prog)
>  {
>  	if (atomic_long_add_return(size, &bpf_jit_current) > READ_ONCE(bpf_jit_limit)) {
> -		if (!bpf_capable()) {
> -			atomic_long_sub(size, &bpf_jit_current);
> -			return -EPERM;
> -		}
> +		if (prog ? prog->aux->bpf_capable : bpf_capable())
> +			return 0;

I would drop this patch.
It still has to fall back to bpf_capable for trampolines and
its 'help' to cap_bpf is minimal. That limit on all practical systems is huge.
It won't have any effect for your future follow ups for cap_bpf in containers.

