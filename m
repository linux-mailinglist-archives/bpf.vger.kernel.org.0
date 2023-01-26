Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0767D372
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjAZRnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 12:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjAZRnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 12:43:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9211814C
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 09:43:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so1534882pgr.12
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jb4brqQ/2hQ6pNEAUb9CIxAmJKrnM/gvXK7e4768ziQ=;
        b=hG05kY0DEp42M5nGP2fZkLLJVS2pDmOCpZWww85ikuH+klB5+4ZyZ/CdvwapLU4QKB
         DFTIqMw4pXtalsVtt4RWzpQgFVzAAJ3hA7GGVzA6pq21jXqpEgGT06BlX9AlOqwb2YAU
         DdJJa37y4Uqwt2gj3r8VV7nOlvd64Zy3kgJ0kMnySv8W1y9dcMbJfpfrPpqOSoQ9jDOT
         fxA5hrPK/KOs/TYrTPTnGXfDz0MUfXG+73cEkY/+cf+9qmlmy34CPglGpSvlRcrKYFNh
         mopx30AwW2SQOedh++Rm7tT5ySQsqp51d+XNN7CHsKm5gxXLqiBg1oXNt/xQK/L4gGnU
         rxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb4brqQ/2hQ6pNEAUb9CIxAmJKrnM/gvXK7e4768ziQ=;
        b=TIVrg1MC05ewdUTAg3MhRo2BwuexyMtqtAE0iO43PTZpMP8563uXNoo2dEeXktihCI
         sv8/WdxwDB+a8oHKQjtFHrqf3lDA84fuVKbj1C5HpvB2bER31BEKbzN/NWRAY2cgOsPo
         bFbLZnLyWqmfQD//SbuG5kBkM0YNj1AX0pogneej7k7bGKVQvoxarB+DjKuqnq16JdTm
         srLrYDqdD2bpEMwIc6KsnbMp2gRtRJmg0OytMm5zcGJ0tE3FjOPsR2POiHttdX3IwRSs
         YELXqBObwfBW0XvaC7v8uriFDWGzJwWFEi6lnBOM0UNRFqS1jGSy8d0MD5bISxJu/tF1
         /+NA==
X-Gm-Message-State: AFqh2kpk1RJrIWX7M1dZICQhK8xOh237TP8D+Q23ghCiNFts7NLjnGjc
        ToIrrYU97ONe7+p64ic9iGs=
X-Google-Smtp-Source: AMrXdXtKkj0wUL2tNp6sq7RuIFRDILr2uzOdGe+P57Ous/Mkk4kXFmbN/1ttGInsAUgyBBwUMdd3cw==
X-Received: by 2002:a62:ae0e:0:b0:58d:cc07:4f9 with SMTP id q14-20020a62ae0e000000b0058dcc0704f9mr30343324pff.2.1674755009923;
        Thu, 26 Jan 2023 09:43:29 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::13de? ([2620:10d:c090:400::5:80e4])
        by smtp.gmail.com with ESMTPSA id t22-20020a056a0021d600b0058d9e915891sm1117460pfj.57.2023.01.26.09.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 09:43:29 -0800 (PST)
Message-ID: <9d2a5966-7cef-0c35-8990-368fc6de930d@gmail.com>
Date:   Thu, 26 Jan 2023 09:43:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH dwarves 4/5] btf_encoder: represent "."-suffixed optimized
 functions (".isra.0") in BTF
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
 <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
 <e719fbaf-9387-7818-c9dd-7deb545eb60e@oracle.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e719fbaf-9387-7818-c9dd-7deb545eb60e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/25/23 10:59, Alan Maguire wrote:
> On 25/01/2023 17:54, Kui-Feng Lee wrote:
>> On 1/24/23 05:45, Alan Maguire wrote:
>>> +/*
>>> + * static functions with suffixes are not added yet - we need to
>>> + * observe across all CUs to see if the static function has
>>> + * optimized parameters in any CU, since in such a case it should
>>> + * not be included in the final BTF.  NF_HOOK.constprop.0() is
>>> + * a case in point - it has optimized-out parameters in some CUs
>>> + * but not others.  In order to have consistency (since we do not
>>> + * know which instance the BTF-specified function signature will
>>> + * apply to), we simply skip adding functions which have optimized
>>> + * out parameters anywhere.
>>> + */
>>> +static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
>>> +{
>>> +    struct btf_encoder *parent = encoder->parent ? encoder->parent : encoder;
>>> +    const char *name = function__name(fn);
>>> +    struct function **nodep;
>>> +    int ret = 0;
>>> +
>>> +    pthread_mutex_lock(&parent->saved_func_lock);
>> Do you have the number of static functions with suffices?
>>
> There are a few thousand, and around 25000 static functions
> overall ("."-suffixed are all static) that will participate in
> the tree representations (see patch 5).  This equates to roughly
> half of the vmlinux BTF functions.


To evaluate the effectiveness of your patchset, I conducted an 
experiment where I ran a command:

`time env LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats 
--lang_exclude=rust -j .tmp_vmlinux.btf`.


On my machine, it took about

  - 9s w/o the patchset (3s waiting for the worker threads)

  - 13s w/ the patchset (7s waiting for the worker threads)

It was about 4s difference.

If I turned multi-threading off (w/o -j), it took

  - 28s w/o the patchset.

  - 32s w/ the patchset.

It was about 4s difference as sell.


Hence, multi-threading does not benefit us in the instance of this 
patchset. Lock contention should be taken into account heavily here. 
Approximately 4% of the time is spent when executing a Linux incremental 
build (about 96s~108s) with an insignificant modification to the source 
tree for about four seconds.


Taking into consideration the previous experience that shows a reduction 
in BTF info processing time (not including loading and IO) to 13%, I am 
uncertain if it pays off to invest my time towards reducing 4s to <1s. 
Though, cutting down 3 seconds every single time I need to rebuild the 
tree for some small changes might be worth it.


>
>> If the number of static functions with suffices is high, the contention of the lock would be an issue.
>>
>> Is it possible to keep a local pool of static functions with suffices? The pool will be combined with its parent either at the completion of a CU, before ending the thread or when merging into the main thread.
>>
> It's possible alright. I'll try to lay out the possibilities so we
> can figure out the best way forward.
>
> Option 1: global tree of static functions, created during DWARF loading
>
> Pro: Quick addition/lookup, we can flag optimizations or inconsistent prototypes as
> we encounter them.
> Con: Lock contention between encoder threads.
>
> Option 2: store static functions in a per-encoder tree, traverse them all
> prior to BTF merging to eliminate unwanted functions
>
> Pro: limits contention.
> Con: for each static function in each encoder, we need to look it up in all other
> encoder trees. In option 1 we paid that price as the function was added, here
> we pay it later on prior to merging. So processing here is
> O(number_functions * num_encoders). There may be a cleverer way to handle
> this but I can't see it right now.
>
> There may be other approaches to this of course, but these were the two I
> could come up with. What do you think?


Option 2 appears to be the more convenient and effective solution, 
whereas Option 1, I guess, will require considerable effort for a 
successful outcome.


> Alan
>
>>> +    nodep = tsearch(fn, &parent->saved_func_tree, function__compare);
>>> +    if (nodep == NULL) {
>>> +        fprintf(stderr, "error: out of memory adding local function '%s'\n",
>>> +            name);
>>> +        ret = -1;
>>> +        goto out;
>>> +    }
>>> +    /* If we find an existing entry, we want to merge observations
>>> +     * across both functions, checking that the "seen optimized-out
>>> +     * parameters" status is reflected in our tree entry.
>>> +     * If the entry is new, record encoder state required
>>> +     * to add the local function later (encoder + type_id_off)
>>> +     * such that we can add the function later.
>>> +     */
>>> +    if (*nodep != fn) {
>>> +        (*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
>>> +    } else {
>>> +        struct btf_encoder_state *state = zalloc(sizeof(*state));
>>> +
>>> +        if (state == NULL) {
>>> +            fprintf(stderr, "error: out of memory adding local function '%s'\n",
>>> +                name);
>>> +            ret = -1;
>>> +            goto out;
>>> +        }
>>> +        state->encoder = encoder;
>>> +        state->type_id_off = encoder->type_id_off;
>>> +        fn->priv = state;
>>> +        encoder->saved_func_cnt++;
>>> +        if (encoder->verbose)
>>> +            printf("added local function '%s'%s\n", name,
>>> +                   fn->proto.optimized_parms ?
>>> +                   ", optimized-out params" : "");
>>> +    }
>>> +out:
>>> +    pthread_mutex_unlock(&parent->saved_func_lock);
>>> +    return ret;
>>> +}
>>> +
