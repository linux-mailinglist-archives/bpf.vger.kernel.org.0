Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BE4B8709
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiBPLrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 06:47:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiBPLrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 06:47:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE7E1A812
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 03:47:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so3946756ejf.11
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 03:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=62NpyXW7RJqDYIXJ7vk5lYHTR7owIS81njlbOWTAyyw=;
        b=rAIntZe6MEHYuwmjFoZ3R9oq0Av2CeF+DbcAftFCHCOlSBM5o87oWVZIkc7yHtJrFS
         iZJvW47W6k2BpiosV9B0/5qBPIjUlzt+W9VSchyqCjbRQaYRbDDfZy8el5n9BAn8aDcj
         QyuYINQhJIYb1ubZp/NPdtndX38G9KuDpaSUkO9GoEIjUxxDj01Nr55XJvgZLTW5LXLQ
         vkaT0PIuPlIBC7IxISxfDP0ynWsXTZpDtfqTPlQcuCzlO9m+ilhWC6Y1CaQbIt+OY5Y3
         z8ll0aOfeF9djnN6C2mzrl6Vo1DQjKmhuN4qV8epYt/boSJBOswyEDT1dQkCQjDpMXx5
         zL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=62NpyXW7RJqDYIXJ7vk5lYHTR7owIS81njlbOWTAyyw=;
        b=Bi6GRC6KdhJKXFU9GzqiOmLt6arLGO21q0RvKtHq5dk+S1RsqbxX2tN37i9xp7S/tM
         PjIk8zp8i9KthorTaIeRs3UmWADLs6zzNSH4iz+XmqGD1AMQPggRUwwUIi97Z9ANxt8w
         p9D9r+XtD1zXBEE1q+iLk2ljnTe79v7UqXxYIWWd0aQATDEjKNOAMtAYsrnaUelB1i4g
         JESPgmMhxlxk2YvPb6Ryae5OMTrfmVmOECVG61A68Qut1pPg8tIx6W4SjhLKAs82bx8z
         irOyG9F54lNMNSF7PsHf9Ihpx/1mskZVuCe9s0aIhPlSvirYrO+0XIw+GgOtgKWMbp9K
         B4JQ==
X-Gm-Message-State: AOAM530+ZBg61NYWLYYQNYyozZ6AtLQKeYZpXnrqUphE0UUFRXXUUP8L
        VaPwpSu/1N5q2/c14iiPPr0Tmg==
X-Google-Smtp-Source: ABdhPJxcSV126+BY1H6fyBmqkdhXKGhZNhLBNCw4q9ZmVhLDPsw3EG2rD7WSDrTjuy86Gfb/0JbxSw==
X-Received: by 2002:a17:906:58b:b0:6cf:65f5:de28 with SMTP id 11-20020a170906058b00b006cf65f5de28mr1905797ejn.614.1645012054848;
        Wed, 16 Feb 2022 03:47:34 -0800 (PST)
Received: from [192.168.1.8] ([149.86.72.2])
        by smtp.gmail.com with ESMTPSA id u2sm12650907ejb.127.2022.02.16.03.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 03:47:34 -0800 (PST)
Message-ID: <ce295e8a-9b68-e385-d109-5af1f06c0632@isovalent.com>
Date:   Wed, 16 Feb 2022 11:47:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH bpf-next 2/6] bpftool: stop supporting BPF offload-enabled
 feature probing
Content-Language: en-GB
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Simon Horman <simon.horman@corigine.com>,
        David Beckett <david.beckett@netronome.com>
References: <20220202225916.3313522-1-andrii@kernel.org>
 <20220202225916.3313522-3-andrii@kernel.org>
 <86567f94-ec2a-5441-2657-4e8f3f21059d@isovalent.com>
 <YgzT81NRqceBfEa4@bismarck.dyn.berto.se>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YgzT81NRqceBfEa4@bismarck.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-16 11:37 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> Hi Quentin and Andrii,
> 
> Sorry for late reply.
> 
> On 2022-02-03 10:24:57 +0000, Quentin Monnet wrote:
>> Thanks for the Cc. This feature was added for Netronome's SmartNICs 
>> and I don't work with them anymore, so no objection from me (if 
>> anything, that's one more incentive to finalise the new versioning 
>> scheme and have this change under a new major version number!).
>>
>> +Cc Simon, David: Hi! If you folks are still using bpftool to probe
>> eBPF-related features supported by the NICs, we'll have to move the
>> probes to bpftool.

(I'm realising we forgot to remove the documentation for the "dev NAME"
option from the documentation, by the way.)

> 
> We do use this feature and it is something we would like to keep.
> 
> Do I understand the situation correctly that in order to keep the 
> functionality in bpftool the functionality of bpf_probe_prog_type(), 
> bpf_probe_map_type() and bpf_probe_helper() needs to me moved from 
> libbpf to bpftool and used if probing an NIC's features (ifindex 
> provided) while using the new libbpf functions if not? And the reason 
> for this being that libbpf going forward will not support probing of NIC 
> features?

This is correct. Given that the SmartNICs do not support as many
features as the kernel, it should be simpler versions of the probes in
bpftool, dedicated to probing the NIC; for probing the system, it should
keep using libbpf's probes which have a better chance to remain up-to-date.

> 
> Is this something that can be added to this series as to avoid a release 
> where this feature is missing?
> 

This series has already been merged into bpf-next (this is commit
1a56c18e6c2e). I'm afraid there will be a bpftool version without the
feature, because we just updated and bumped bpftool's version number on
top of that :/ (9910a74d6ebf ("bpftool: Update versioning scheme, align
on libbpf's version number")).

Quentin
