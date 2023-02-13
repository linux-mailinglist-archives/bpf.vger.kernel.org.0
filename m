Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D798695332
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 22:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBMViM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 16:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjBMViL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 16:38:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08A78A42
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 13:37:52 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso12253408wms.5
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kFpTi21EROoZ3UCd/jRbkmPmSRuIk/rq/xKTB3p6kE=;
        b=AQ/zv1GIcF9g3oQ4z3cw2nnlWrtm7rnMJG6yLfJm/Uf+5uQaCAVNaaJYnnicaqIRD8
         0MX8vSzo1fpb9pdYpNwdahYAVULzmgC7h6kPHxHqzkorVCPDUoOURcNvQ5V4EwmsQ+Yu
         do6Vj5EzNE5IFA7OE2e3kwPhik7Q2THeuJKe3vzhDSJ5ns/UqufSsdI6gOp89JJ7CQ0E
         /nJcejFHq0WAQ6iYPKknXiP4ef9VfnxQYCKldyeBq2pMykVL/a1ATZfzK6N0bP1n8piM
         /6R4qliIkmuqrY+6Bdye/MuVxe00fGKRQGTxXSi7ADK98HGNH2Kl7CZPPVI376yYs4cI
         LLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kFpTi21EROoZ3UCd/jRbkmPmSRuIk/rq/xKTB3p6kE=;
        b=wOnwWnJ74+cShnDFrJ9CFagHjgy6m8D/fE8Han1j2UFCOz6YowxNPqv83SYu52n0yl
         wCp1h4U9+GQvPx2ItV0zgRmVUvAO/uED3ZX+tXvfBJZNgUQjALizlzdLFO8DyIAXynVj
         awKnzo7RBJHoiLMEB8sg0SxXOMGkt0n0B78YO/nS+jtFKPNm+nZo5LY150b/Ms6IL6C0
         bijpZcAyK92eS0Dbw59Wh1jfl9zHaZdxWspJJxNlnNRww3Qb7njl1yfA7aUluZUgykCU
         6rMMemul0NzpPBbdw1Lvg9WEqc1CVGFunhc6BCWjteT4w9tUTI3nSoFpE4VCkBL2p8m9
         vmpw==
X-Gm-Message-State: AO0yUKU0LOms1hDpbrZ8H5norQnFWnOd/UM44aNUldTrTxI2mPK78wMn
        hxfbBSPc58gfMEAezo3jItKBwDcMWquV7y99WMazx4wO
X-Google-Smtp-Source: AK7set8JiN95agMI6tLvdxiiGwiKzecaiZrHBRpC2gNQca9agNdnxFMm10bDjA45WPw4lsoBOZoRXQ==
X-Received: by 2002:a05:600c:3310:b0:3dc:405b:99bf with SMTP id q16-20020a05600c331000b003dc405b99bfmr100659wmp.15.1676324271108;
        Mon, 13 Feb 2023 13:37:51 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:e444:af40:8c53:f900? ([2a02:8011:e80c:0:e444:af40:8c53:f900])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003e1df9bc86csm8337343wmz.3.2023.02.13.13.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 13:37:50 -0800 (PST)
Message-ID: <cb82a360-dac1-4bf7-2dc4-63b3fb34425c@isovalent.com>
Date:   Mon, 13 Feb 2023 21:37:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Proposal for patch - Extend bpftool prog run to accept cpu and
 flags options
Content-Language: en-GB
To:     Stanislav Fomichev <sdf@google.com>,
        Alan Jowett <Alan.Jowett@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <CH2PR21MB14309C209861239DB568C3C1FADD9@CH2PR21MB1430.namprd21.prod.outlook.com>
 <Y+qKjbYJV7WhiSYA@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <Y+qKjbYJV7WhiSYA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-02-13 11:07 UTC-0800 ~ Stanislav Fomichev <sdf@google.com>
> On 02/13, Alan Jowett wrote:
>> BPF,
> 
>> The existing bpf_test_run_opts structure exposes additional fields
>> including "flags" and "cpu". I propose extending the bpftool prog run
>> to accept options so set these additional fields.
> 
>> Use case:
>> Some BPF programs access state that is potentially shared between
>> programs running on different CPUs. This can impact the performance of
>> a BPF program. To permit users to more accurately assess how their BPF
>> program will perform when being invoked on multiple CPUs in parallel I
>> am proposing adding the ability for bpftool to set the cpu field in 
>> bpf_test_run_opts struct when calling the syscall.
> 
>> If no one else is working on this or there are no objections, I will
>> submit a patch using bpf-next https://github.com/xdp-project/bpf-next/.
> 
> Patches are welcome. I don't see anything controversial with extending
> bpftool with those extra fields.
> 
> PTAL at [0] on how and where to submit the patches.
> 
> 0: https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst

Hi Alan, I agree with Stanislav, this is a welcome addition to bpftool.

Quentin
