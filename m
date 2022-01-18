Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38D492CD1
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiARRzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 12:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiARRzb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 12:55:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F08FC061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:55:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso6337988wma.1
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=umcTXVP9psQjP6LbPXMW2IlOEioLWA+MGu8a04LukTo=;
        b=8MevCmFvFcN7Vf7uoKrMJ7awgRkHipHq2qp/KfZ2xPd95ETMq3qiq+gposZCdSjbNo
         l2CYnVXZtApbUzO0UMvrW+nskpMw3C0zTkLYmNfhhPWz0EkpKRFvmgj3aumWVVbeONKH
         YJ8lCDrCKvAYrMDffdswNuRdm+S9DRgMOwhDHChjyvYc9uMA+ix3db5KjhWyWaqZE+ox
         NYvB4AHFzA4bvyuNyNKQ/Gcqc75VLnY5fhWvjnUQy5j1fPqO2PBcrVxcUn+jTNIfXZYg
         P9bZ6xqD9Z8H4kxHR2M6/WUWiK1z+Sf4hssDVVau+O3d/XwniV/m4hngT3QW1HPNDGGJ
         yKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=umcTXVP9psQjP6LbPXMW2IlOEioLWA+MGu8a04LukTo=;
        b=aHzp+VX2Xcsx5P2X7LHrZkHDwtxWjeUbKOE29rnCxNRe7/vPioKcZtSGLqIrX9+QCb
         sMEiFTV88cPRgA2rgVPdO2mex4sUInoPkS9dH9eYBDa/qso7v2sLAMGu6GPqZJXd/Vyb
         2U0j2X3MJU4d8SV+hdBpPoALQFnHKAjdAoI1LdPvcV2cIs7S5ytYZkGOZxyXfsWky3IK
         zWDXqoUTcJT8FgH5qGNOxP6FfEUIAba+GZgltiwuzPrLWdMUen1l2o31dNit8O2QCG2M
         uMktDNfzg+ASN3/p1fbDNGIdR4+z4ZsCVcWNaiixR2uEb0/SmLe+ses3WjTIhP0H2T2C
         0/HA==
X-Gm-Message-State: AOAM533Xls9JJA1+1GsfQZvfkxOvApYQyi40EZQZI4qUXNLQHYX4jS+n
        gzkIztN9QvJdTt0pcNTRND/cRw==
X-Google-Smtp-Source: ABdhPJzs8LJWpNPrjpFL35a+tEqReLcZeLO5k9Xw34cA4rYHMCKzt4mToMj0e3uWDorYokRSCwGFPQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr24534060wro.501.1642528529658;
        Tue, 18 Jan 2022 09:55:29 -0800 (PST)
Received: from [192.168.1.8] ([149.86.93.121])
        by smtp.gmail.com with ESMTPSA id n14sm3072957wmq.42.2022.01.18.09.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:55:29 -0800 (PST)
Message-ID: <b130c526-5c32-e2c4-c0b9-20a3744decab@isovalent.com>
Date:   Tue, 18 Jan 2022 17:55:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf/scripts: Raise an exception if the
 correct number of sycalls are not generated
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, andrii.nakryiko@gmail.com
References: <20220118171609.1044550-1-usama.arif@bytedance.com>
 <20220118171609.1044550-2-usama.arif@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220118171609.1044550-2-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-18 17:16 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> Currently the syscalls rst and subsequently man page are auto-generated
> using function documentation present in bpf.h. If the documentation for the
> syscall is missing or doesn't follow a specific format, then that syscall
> is not dumped in the auto-generated rst.
> 
> This patch checks the number of syscalls documented within the header file
> with those present as part of the enum bpf_cmd and raises an Exception if
> they don't match. It is not needed with the currently documented upstream
> syscalls, but can help in debugging when developing new syscalls when
> there might be missing or misformatted documentation.
> 
> The function helper_number_check is moved to the Printer parent
> class and renamed to elem_number_check as all the most derived children
> classes are using this function now.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Looks good to me, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
