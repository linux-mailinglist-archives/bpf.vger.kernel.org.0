Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848863B7846
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhF2TNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhF2TNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 15:13:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C45C061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:10:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d19so27444733oic.7
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y79oU7iLPMZxXNvTSmBEBP8UKiUAbDjif+iOgsBtLDo=;
        b=vTg6OiOVnGjwslsgjCT4bExZN/seEnfVikGmCa/dbhs9ovyfphpnHfQXFCZtLJF12/
         ivppTDynCXxx1TR2uBphOYWynKe3sCyiEdtibVW3CXRENzSJHSk7kus67g23hKp3aR7O
         22JZ1J5f2Bh4IaUnkeTK6mrFKZd4A/KqP/EGJ2gsTMgBqM4ae11S40WLsDxKQAkWg5u7
         HSOFefVnUJXZieoaT4s0sVUqDhXvdZe7l4AnJKzYdTio40LEZ3ya1NBfs5M0xr2nRMvA
         H98GD22KO5++S6L5golfBkClp9ZqlK4ijIM55OViaAZs2RbdcX/tX/0isxT52MHRYTh2
         rK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y79oU7iLPMZxXNvTSmBEBP8UKiUAbDjif+iOgsBtLDo=;
        b=HSlyqgYDtAcrTaezBpPrButEbRl54j8iA/u0P+x169e57rEYALMdAlynJ2VaB4fhAs
         cg521iyS0i/uK2Dzv4Hz+/n7cS/5yoe4Jbb5bxh9ybPk8nexYXCxOTJ1cv7k0CcdbzYR
         OVl8beL2PqXxj4ioaI2833BxLVp811YacZlQanBSqxDfQUgFOdJa94ki77LsHsTc3FFy
         9axzHIiYddZ0YQM0v37wE3ZbPpYhwZYOVAqel2L4LhW3KQOJ85zpZez4Zjbj2eOA17/K
         rhKtvvsLrkvrwNduyH6uiST53bKWyCDfFe/r23t2PKOr/LiuFUlY06IgMPetSMj5FTa2
         kPEA==
X-Gm-Message-State: AOAM53034DSRQEpzr+ZtfTLgg6UR5hzgCDTIzhSxkEturJ7IPliABajf
        VhZPdm1sOP4kEcSihsdL53M=
X-Google-Smtp-Source: ABdhPJyVcjrHDmwa5m9rapRB/BodCk/Oz9yXRs/0RlA5V6cloFJVW8QuVwJ54swOz447vGSHrVYbAQ==
X-Received: by 2002:aca:5bd6:: with SMTP id p205mr255884oib.179.1624993837288;
        Tue, 29 Jun 2021 12:10:37 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.38])
        by smtp.googlemail.com with ESMTPSA id g25sm1912482oov.41.2021.06.29.12.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:10:37 -0700 (PDT)
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
To:     Greg KH <gregkh@linuxfoundation.org>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
 <YNtdfN28J59Ajogy@kroah.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <e07b2eb7-9c96-d42e-8483-31869e381dfa@gmail.com>
Date:   Tue, 29 Jun 2021 13:10:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNtdfN28J59Ajogy@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/29/21 11:50 AM, Greg KH wrote:
> On Tue, Jun 29, 2021 at 10:37:34AM -0700, Rumen Telbizov wrote:
>> Add support for policy routing via marks to the bpf_fib_lookup
>> helper. The bpf_fib_lookup struct is constrained to 64B for
>> performance. Since the smac and dmac entries are used only for
>> output, put them in an anonymous struct and then add a union
>> around a second struct that contains the mark to use in the FIB
>> lookup.
>>
>> Signed-off-by: David Ahern <dsahern@kernel.org>
>> Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
> 
> Did David author this, or did Rumen?
> 

Both. Rumen's first patch set and hitting some bumps.
