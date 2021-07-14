Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46F3C7A5B
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhGNADH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 20:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhGNADH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 20:03:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B856C0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 17:00:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l26so559549eda.10
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvRiWO/1Ojh72xzWykPv58DuV/fBYdq4f2IrDOigDAI=;
        b=QU/uUBGa6NGMA+93CoVpgYrGLr8cCsaJMwnQjGBpVf0cEwcsBQYhPGpG68pKwfOoCO
         HNG8df3kL5ThK+AxTqQrtCzHL7tvtVDyi6LQdy0YS+4qS4KG1Mrqm3z/IhiHR8LhTBbb
         cjAQ2Cy3HFIY2fa2Df1oeHb1hWd5SiBQOGpPOZ4MkwiNyxQxIWnKBaEuFgFCa7bY9Wb2
         uQmkpKHkQ70XNdzX/iNi9QWuMT6LYo3IeH5xbi55Abll9NrcNAGsP6C1nxsDqXDBlThL
         Npa7x2HULWcljcLQv7AyzC9eNcy5EfjTXu/pexksPXJA0MoxLDEPo8PvW0Ajx4r2MRWO
         0dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvRiWO/1Ojh72xzWykPv58DuV/fBYdq4f2IrDOigDAI=;
        b=NtTJqij/31PiRidq1kElrdMyVXvTzgXf9gPDaG2bdeTiVoygsGOMQ2uEECyfNZlHuX
         6KAKoOX3y8A3jy0R12B+T/zHALau6keN3tFRpu/+Rp+kQ2ULIwmY2MQIsz4n7QaC6XAb
         lerVipXbOxQcFaHmIbtCYSpj1d6rECZXw7gUtXvKa73v8u6lWkpZToVliDkQcK+NMx20
         Oh6RGrPWbZTo+nkv8bm3Dd+JIcGN1lQju25wbhgqgMAPKrOB/ZU1K3u8UvQgt2M25npb
         QbEyYUQky30wr08jVCtozV0Z6LGTmx/I4y9x0KQ1fSXv/gjI2tyB7yH/Wt5X4lwl4EbQ
         3/PQ==
X-Gm-Message-State: AOAM531+Um3jNc3FgB1BR1FGQhPmEMWg/JCt0LCctXTE8SsRmJqi76hy
        YCSZAmXnSlxDJAp6cr5eNUBgPEHf9II=
X-Google-Smtp-Source: ABdhPJyx0/Tk3nAEum/D378kPeHkIc7HorOiY3VhiKZOSHAKem3e0QDpjBNE9mF/Ngjbma+Ms8rxpw==
X-Received: by 2002:a05:6402:3d4:: with SMTP id t20mr9274820edw.274.1626220812991;
        Tue, 13 Jul 2021 17:00:12 -0700 (PDT)
Received: from [192.168.2.75] (host-95-232-75-128.retail.telecomitalia.it. [95.232.75.128])
        by smtp.gmail.com with ESMTPSA id jo19sm116720ejb.59.2021.07.13.17.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 17:00:12 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] tools/bpf/bpftool: xlated dump from ELF file
 directly
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
 <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Message-ID: <fd4c8b07-a1b5-8b65-a98a-00cbc1644099@gmail.com>
Date:   Wed, 14 Jul 2021 02:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/13/21 8:35 PM, Lorenzo Fontana wrote:

> +		printf("uno\n");
>  		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
>  		if (IS_ERR_OR_NULL(info_linear)) {
>  			p_err("can't get prog info: %s", strerror(errno));
> 

This printf was not supposed to get here.
I'm sure I'll get feedback to do other changes so I'll revert that in the
next batch with the review changes.

Thanks Leo Di Donato for the finding!

Regards,

Lorenzo
