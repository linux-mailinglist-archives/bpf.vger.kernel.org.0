Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC0249F01
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHSNEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgHSNCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 09:02:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B893C06134C
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 06:01:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so26221312ejb.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S08efVGlFbnCRWAooQ5BgeOCyESGGd5F97xt8fYK1v0=;
        b=gXzVlZtvnou0mDkrZAK2Fnuw9dSHO7Edi/cQP/i3F+AAbHgN3yCpdOvzogBHylOWmq
         Qc0FKLbxNWpaTbSaQEuwm+ujFF001aQbadp4GYn5t3ogCQHV/SqT1EaYeGyGK5d1Zyc7
         esDQ142rLIroj8edGg4TAizj7oV8OgZaOxosM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S08efVGlFbnCRWAooQ5BgeOCyESGGd5F97xt8fYK1v0=;
        b=jAMrhipQHcyAcipZvdJjbnTFRPlGWIcUVOT3dPi1jNLeWBEgX9uVnFKXDgFnYaYhEN
         1+keSMTv5+s7IYerdVrQFlsEicovR2H6+xCe19rRygje3QBuk1VWKaAJp9Hx1fZ6h6nR
         LC3iiKYM16PXPMzwzUU1nVIm97YPtRBZm3zc6Da418q70OQtpA82LhCT49mysLRes226
         pZw42rBds3VP58D7HPpgLLeTwUIEGjMeh4VUvkTIZaOVdf6YqHmlAoeBUpI8OHmq0fJb
         yYSIWFURx2u8C1HUgUVdHmsslLwk43WUYY9kaShGaVAPjvPCSS5MCAg62ecdtR7O7IFV
         X+Ug==
X-Gm-Message-State: AOAM5326vUT27+PgKhUWHU7aog6PzXh+la7VqnDKJxFRcttjqE7f2fkz
        2XUwrOlhZBBfQ15jBh1CvmFveQ==
X-Google-Smtp-Source: ABdhPJxS2tf0sP7AgOv/ZCmElHwH5nT7hhwed9Oh3Cg6C5L9jxDqiFxUJFEr130TB6JjA6KVwlTe4w==
X-Received: by 2002:a17:906:1f15:: with SMTP id w21mr24281904ejj.152.1597842078291;
        Wed, 19 Aug 2020 06:01:18 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o25sm18529498ejm.34.2020.08.19.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:01:17 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 6/7] bpf: Allow local storage to be used from
 LSM programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-7-kpsingh@chromium.org>
 <20200818041638.2dv5cewlgwerd7hm@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <87e6c97f-5d72-ddb9-331a-4a79ccab11c1@chromium.org>
Date:   Wed, 19 Aug 2020 15:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818041638.2dv5cewlgwerd7hm@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/18/20 6:16 AM, Martin KaFai Lau wrote:
> On Mon, Aug 03, 2020 at 06:46:54PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Adds support for both bpf_{sk, inode}_storage_{get, delete} to be used
>> in LSM programs. These helpers are not used for tracing programs

[...]

>> @@ -2823,6 +2823,10 @@ union bpf_attr {
>>   *		"type". The bpf-local-storage "type" (i.e. the *map*) is
>>   *		searched against all bpf-local-storages residing at *sk*.
>>   *
>> + *		For socket programs, *sk* should be a **struct bpf_sock** pointer
>> + *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
>> + *		programs.
> I found it a little vague on what "socket programs" is.  May be:
> 
> *sk* is a kernel **struct sock** pointer for LSM program.
> *sk* is a **struct bpf_sock** pointer for other program types.

This is better, Thanks!

- KP

> 
> Others LGTM
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
