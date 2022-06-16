Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E431D54E619
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiFPPbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377927AbiFPPa6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 11:30:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8440A1D
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 08:30:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so2699263edw.8
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=v//CUxzEr8ArkTHXqMywoytyzVYtHGMcre8gIGXw7zA=;
        b=zAfzEPEU0HL8QAF50ahVgPFzYDlZv71iPvraEh/d4LGAsNkMKYVzn1sVExcp12zfaX
         qPsDiBKP/emm4BOpXQH774pucRYOpPKtiGuJjfBIRJzYHUqXUHp/BLLX/e6xMuqbwkOm
         huh6iZ6Rh6eZ0fLODDk9u2lEGoyPi1aK+uTbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=v//CUxzEr8ArkTHXqMywoytyzVYtHGMcre8gIGXw7zA=;
        b=31c1PG8FLn6WsL8RmwsZAA4KttFyt2Wzp/Dfg3inJ6BF/ojyMPIiwkXCVep/vjCUd7
         lhx0syeKqhnoPfgocjpUM0tfdzwsp4NwndwCP1Q3UgGhoSY2wVryCwPc0/cAcAueQYL6
         GRxw8ZVxlcboiKilmcMGG8FiDMJjyvPGm6T+2RHAZg048r7stND57jz03/xMpmZ6GJm3
         xYVf8TTSP2NlYT+UX+wHE8ho1z757ODu1tP1WodVRQXr6SSceor5VdGY6w33WJgUlbTZ
         fdDRCQslqBL+5cC3yn5joOD2tluaYWOA+gSq8/hvN512zsjczYYfAJmAyqYfV7iKg6nS
         nBbg==
X-Gm-Message-State: AJIora8ZkCV9/MnxZovsUvkcPNxehiEAvo1eo9tbmNcyPLjNjQ8i8+qX
        kgeC+j0Z/E8zPaSvDnohUFKhS/EdhbJhTQ==
X-Google-Smtp-Source: AGRyM1sEAS6AIAGWi7DcR29KEvOtjjr5Lhyp1hVNUS62cCx5OoHJkfbQ0Y3AXXxbl39QF0aI1T8MTQ==
X-Received: by 2002:a05:6402:388b:b0:42b:5f20:c616 with SMTP id fd11-20020a056402388b00b0042b5f20c616mr7228997edb.50.1655393456030;
        Thu, 16 Jun 2022 08:30:56 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7c0ce000000b0042bca34bd15sm1918874edp.95.2022.06.16.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:30:55 -0700 (PDT)
References: <20220616110252.418333-1-jakub@cloudflare.com>
 <YqtFgYkUsM8VMWRy@boxer>
 <d7a52f4c-9bad-da94-2501-015bdde32e97@iogearbox.net>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@cloudflare.com
Subject: Re: [RFC bpf] selftests/bpf: Curious case of a successful tailcall
 that returns to caller
Date:   Thu, 16 Jun 2022 17:28:25 +0200
In-reply-to: <d7a52f4c-9bad-da94-2501-015bdde32e97@iogearbox.net>
Message-ID: <8735g4wrpt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Thu, Jun 16, 2022 at 05:22 PM +02, Daniel Borkmann wrote:
> On 6/16/22 5:00 PM, Maciej Fijalkowski wrote:
>> On Thu, Jun 16, 2022 at 01:02:52PM +0200, Jakub Sitnicki wrote:
>>> While working aarch64 JIT to allow mixing bpf2bpf calls with tailcalls, I
>>> noticed unexpected tailcall behavior in x86 JIT.
>>>
>>> I don't know if it is by design or a bug. The bpf_tail_call helper
>>> documentation says that the user should not expect the control flow to
>>> return to the previous program, if the tail call was successful:
>>>
>>>> If the call succeeds, the kernel immediately runs the first
>>>> instruction of the new program. This is not a function call,
>>>> and it never returns to the previous program.
>>>
>>> However, when a tailcall happens from a subprogram, that is after a bpf2bpf
>>> call, that is not the case. We return to the caller program because the
>>> stack destruction is too shallow. BPF stack of just the top-most BPF
>>> function gets destroyed.
>>>
>>> This in turn allows the return value of the tailcall'ed program to get
>>> overwritten, as the test below test demonstrates. It currently fails on
>>> x86:
>> Disclaimer: some time has passed by since I looked into this :P
>> To me the bug would be if test would have returned 1 in your case. If I
>> recall correctly that was the design choice, so tailcalls when mixed with
>> bpf2bpf will consume current stack frame. When tailcall happens from
>> subprogram then we would return to the caller of this subprog. We added
>> logic to verifier that checks if this (tc + bpf2bpf) mix wouldn't cause
>> stack overflow. We even limit the stack frame size to 256 in such case.
>
> Yes, that is the desired behavior, so return 2 from your example below looks
> correct / expected:
>
> +SEC("tc")
> +int classifier_0(struct __sk_buff *skb __unused)
> +{
> +	done = 1;
> +	return 0;
> +}
> +
> +static __noinline
> +int subprog_tail(struct __sk_buff *skb)
> +{
> +	bpf_tail_call_static(skb, &jmp_table, 0);
> +	return 1;
> +}
> +
> +SEC("tc")
> +int entry(struct __sk_buff *skb)
> +{
> +	subprog_tail(skb);
> +	return 2;
> +}

Great. Thanks for confirming.

Since I have the test ready, I might as well submit it.
I think the case of ignoring the tailcall result is not covered yet.

Also, this makes changes needed to support bpf2bpf+tailcalls on arm64
simpler. Will post soon.

>
>> Cilium docs explain this:
>> https://docs.cilium.io/en/latest/bpf/#bpf-to-bpf-calls

