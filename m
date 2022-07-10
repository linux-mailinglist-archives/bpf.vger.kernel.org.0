Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2039C56D139
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGJUTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJUTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 16:19:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210C11C36
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 13:19:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so5685978ejr.5
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2dNNm+2Z7DDTrnInVJhwVhx6QVDRUW2xps/sEbVOHiU=;
        b=Dwui2oCyaMCi3tSvwOpjfJZZGOdnlgOydmP1frvpBNLn1BUL+tcGUAax1agMvlcYsy
         WUnVjcydaCNS2c83Y/M8M9fEQ0Dt/vN+P73bxohbthMchvleQX+gARGjXCQ0DPshKc+1
         1Idou1dB1cCjuH6ciMb6E3eETHHFU+dp/zFOGgSIcpU4SyTmIgdke91A1zteEP58u+EU
         jE7frmfd6Tu97whiyPZAF5l0z0/mMCor34Z30cn9bluePt2Yiz8BhkLugKMvuB/qvprN
         4v2y+6A/Li1tt9gc6GiTGggYzrjXs/Q7nANLT4zKc+MRApKm6fGZil+sGy4AWIkw5cKt
         1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2dNNm+2Z7DDTrnInVJhwVhx6QVDRUW2xps/sEbVOHiU=;
        b=qWARxxGCX+d/qJP9h2YLyvnvDDIeDz97ER5UOE3HFhIPcOkc+zS5tXOCTS51VTCFn2
         Jo/0Js37ERrnDc+iljqwpQkifMHH/UnZy8vE6tjACViLYXFlRsAhsMSvWSi9IbUXf83K
         oeB8MNA84tDFMnOhgD4889jGSoWKz+JWsPv1atfti3aymTb8wbej7gL98ID/TwxwoM81
         jXfHigfiTqqo4e3229CKCNQxEEq1ua3tTVx4DXTk1B9yM5cxwt81GA2N0yN4wx4nvoad
         qIHVr7GBT/BZXuKWqQbLtT2X/qgZvgmIN4r3lDqpMMh686zjz1lsBprWgucI8Uy/5tDq
         O9Aw==
X-Gm-Message-State: AJIora8zvjLPPour4ymSihbrZIkd/Ent8HnlcKgEoxIANGcNNdLFkubQ
        5IcrzaRUHeHvp+W/XT8nyUr48A==
X-Google-Smtp-Source: AGRyM1sN+yMDd9eMlY/wC+lb+z5dP2YfafkBCnRXR4CiepxY34tTWOLWn1G0hHHRtHX0158SS/jnSQ==
X-Received: by 2002:a17:906:9bdd:b0:72b:3cab:eade with SMTP id de29-20020a1709069bdd00b0072b3cabeademr7647876ejc.58.1657484345371;
        Sun, 10 Jul 2022 13:19:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8f5b:bf6f:385:d647? ([2a02:578:8593:1200:8f5b:bf6f:385:d647])
        by smtp.gmail.com with ESMTPSA id f8-20020a50fc88000000b0043a8286a18csm3230479edq.30.2022.07.10.13.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 13:19:04 -0700 (PDT)
Message-ID: <428689f2-ad91-e1b4-64c5-c1c4802e2cbe@tessares.net>
Date:   Sun, 10 Jul 2022 22:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield'
 warnings
Content-Language: en-GB
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
 <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

Thank you for the review!

On 10/07/2022 18:59, Yonghong Song wrote:> On 7/10/22 1:35 AM, Matthieu
Baerts wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 81b19669efba..2ac424641cc3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
>>   };
>>     struct bpf_loop_inline_state {
>> -    int initialized:1; /* set to true upon first entry */
>> -    int fit_for_inline:1; /* true if callback function is the same
>> -                   * at each call and flags are always zero
>> -                   */
>> +    bool initialized; /* set to true upon first entry */
>> +    bool fit_for_inline; /* true if callback function is the same
>> +                  * at each call and flags are always zero
>> +                  */
> 
> I think changing 'int' to 'unsigned' is a better alternative for
> potentially adding more bitfields in the future. This is also a pattern
> for many other kernel data structures.

There was room, I was not sure if it would be OK but I saw 'bool' were
often used in structures from this bpf_verifier.h file.

I can of course switch to an unsigned one. I would have picked 'u8' when
looking at the structures around but any preferences from you?
'unsigned', 'unsigned int', 'u8', 'u32'?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
