Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC95441E14
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 17:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhKAQZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhKAQZK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 12:25:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A533AC061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 09:22:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e65so17618366pgc.5
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/q8gY92WpHEhEb+p85M8WmEzLmdNCfJ38CSCvKtmBg=;
        b=NQ8LIalhWAOSrakB2DFRjOxZD+JNuo4at2aAV4g5J2B51qPSoxIWLUFcyhjriswA12
         1MwlyeX3DOtTi4+YJ8LBtLG9oU1Yy78tw4nZo5EZpvdjptyRSmb45ffh834U40jS3fha
         t3bKhRRmMRytzZsPz1b562jRpxqcGYzeF/EAXzfN6Q8NljbvDors8erhMr5xqkkoRtDo
         H+AZb1ge4wyymdEUd9OvJrfBdl/TYyZdITMKRQxoY9/FD/q03K6+KZnDqmbfMh7w1JY2
         jMgPo+V2IcZuzU8J3m/s2btNI9pzp+7J9gqrats9xxofXagrC043V/+45W2NRVU+XTbf
         oWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/q8gY92WpHEhEb+p85M8WmEzLmdNCfJ38CSCvKtmBg=;
        b=5vNdI2Vs23C/zXxD9KRS+gqfpjzHLde6A2T3WMSGEnte+jB7Dfrv01BUP5i7WEnwmW
         4nteRfcD+wbfe9CsC1M9VHvpGPC65u9jIOLms4X7CplCiWrGJhuKgJbkd6LAP56k97tB
         OYFgehacS9D/8FU9VVwki9A8mpEf1na8VoWeGVqIfcQfn4w4XtGVfrQUMVdzGzdFT/JD
         9Q5op2mJf9zQBF+j1VdnUqCL0Ri2Y2/Roi0PlUjBOb1SPfozpowXZVjGA6O823wtfEV+
         YdSHH6jzeaVgFzPNWwD7JBjDQ1ow1vjRNlzReLdwFsgT8DBiDqL0971ZM46sJyO5l3/m
         0jBg==
X-Gm-Message-State: AOAM533rltwrhYxhOuqlPXHY9pDv3PMBdt0HgSAU0Sbw3RtBKCPLrQxf
        6I7Cv44lO0o26bIwFVGt/yI=
X-Google-Smtp-Source: ABdhPJyqTQ3sFUPT79B9FWwG6dkhS2HkQvmLvcN5yyCQMv6SR0fYyS0kgNFT/2rqkW7ilmq2c3046A==
X-Received: by 2002:a05:6a00:248e:b0:47c:20c2:f038 with SMTP id c14-20020a056a00248e00b0047c20c2f038mr29989785pfv.13.1635783757175;
        Mon, 01 Nov 2021 09:22:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:880e])
        by smtp.gmail.com with ESMTPSA id q10sm5362382pfk.218.2021.11.01.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:22:36 -0700 (PDT)
Date:   Mon, 1 Nov 2021 09:22:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
Message-ID: <20211101162234.fhtnmrdj5gil3qfo@ast-mbp.dhcp.thefacebook.com>
References: <20211030045941.3514948-1-andrii@kernel.org>
 <20211030045941.3514948-3-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030045941.3514948-3-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 29, 2021 at 09:59:29PM -0700, Andrii Nakryiko wrote:
> Move internal sys_bpf() helper into bpf.h and expose as public API.
> __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> follow libbpf naming conventions. Adapt internal uses accordingly.
...
> -static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> -			  unsigned int size)
> -{
> -	return syscall(__NR_bpf, cmd, attr, size);
> -}
> -
...
> +static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
> +{
> +	return syscall(__NR_bpf, cmd, attr, size);
> +}

I think it will conflict with glibc.
It will also conflict with systemd that uses bpf() from glibc or does:

#if !HAVE_BPF
static inline int missing_bpf(int cmd, union bpf_attr *attr, size_t size) {
#ifdef __NR_bpf
        return (int) syscall(__NR_bpf, cmd, attr, size);
#else
        errno = ENOSYS;
        return -1;
#endif
}

#  define bpf missing_bpf

why take a risk of renaming?
