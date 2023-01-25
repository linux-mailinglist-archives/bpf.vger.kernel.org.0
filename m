Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585567B8D7
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjAYRyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYRyk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:54:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562E5FFF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:54:39 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 143so478449pgg.6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQmves07N5dQYWN8G95eelughaSmP47ZZVsEe5C844E=;
        b=f/C/P8FZnMIoiB1x6Iy0g3bLAIKljm54RXQ88xhwFFbkaHxxMQQGtMlk0c+mlpjkR/
         k7Iy98JzAuNYmWAd4Oy0jCHnLUxjYIjLqu/5kOYQvmoj2WKwI19g3cVj2mJpSY8J5Y1m
         T4VaG6DIqmdgtgxJRdsR+iY2ANftZmS+35dBL0T+FXJyu0o9QpPr03C1XbizUZUBbEm7
         EqFpsLXYjTPx0M2Z+LQeOYGrxLfh0tgXUoTUdMf10HcBMNLHU5OIWuJSR8kowKMxqF7R
         KQyhbDSxLOco7g0W9T0guZ2Wo9QL44D0BQlf1sjpz2fOocIBoiiRAEyYMvyHi7ZekarW
         OgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQmves07N5dQYWN8G95eelughaSmP47ZZVsEe5C844E=;
        b=IecqtDxC3F1zHgnpO/l9JpTA/CPeTD9M8WUTqZIirdS2PO1nTQLklAPvQD5D7DxWaK
         p4/RHrIfHJDTL9w1UlCmc+TCiucmZxrRnxNIkMLmf8OT4VJ3Q0wbLwCZ5d/1H5DEnOG9
         Jkx40eVq2hPMkc/KA71MuAM1DMVSkarGc7HfCU9x6e6vAHotN/EYNtN22LOD5V3DeeNG
         pY78bYGjlXP6f/pS8XaGfXQ1R1Ttq4i8c6Ai/h+U3PmsYs6MSFGm4VZy4D0yAiOR7JN+
         I2P0FFOTdSyVXhvHlbH+Ye/aiYRGR4aUOuh5RZLxd0xXxKzKCkO+36+FHcz4waXkgBE8
         9spA==
X-Gm-Message-State: AFqh2kqW/jIuVNUdmdiCuJ+PEVeOKdYObVSYjw2P16z4q7+3NcE8NdIT
        twWKzBU5iJC3FGx6v8zhrsI=
X-Google-Smtp-Source: AMrXdXvqnZOj9ziM6VmciLxRLrxeHgwv9eXJ6syyZiz4gFLNIiVhQtXPgk/6hor8J11Ux4XvKkSBdA==
X-Received: by 2002:a62:1910:0:b0:58d:c1ca:9360 with SMTP id 16-20020a621910000000b0058dc1ca9360mr32328714pfz.17.1674669279216;
        Wed, 25 Jan 2023 09:54:39 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1204? ([2620:10d:c090:400::5:5918])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00179400b0058dbd7a5e0esm3943892pfg.89.2023.01.25.09.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:54:38 -0800 (PST)
Message-ID: <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
Date:   Wed, 25 Jan 2023 09:54:26 -0800
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
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/24/23 05:45, Alan Maguire wrote:
> +/*
> + * static functions with suffixes are not added yet - we need to
> + * observe across all CUs to see if the static function has
> + * optimized parameters in any CU, since in such a case it should
> + * not be included in the final BTF.  NF_HOOK.constprop.0() is
> + * a case in point - it has optimized-out parameters in some CUs
> + * but not others.  In order to have consistency (since we do not
> + * know which instance the BTF-specified function signature will
> + * apply to), we simply skip adding functions which have optimized
> + * out parameters anywhere.
> + */
> +static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
> +{
> +	struct btf_encoder *parent = encoder->parent ? encoder->parent : encoder;
> +	const char *name = function__name(fn);
> +	struct function **nodep;
> +	int ret = 0;
> +
> +	pthread_mutex_lock(&parent->saved_func_lock);

Do you have the number of static functions with suffices?

If the number of static functions with suffices is high, the contention 
of the lock would be an issue.

Is it possible to keep a local pool of static functions with suffices? 
The pool will be combined with its parent either at the completion of a 
CU, before ending the thread or when merging into the main thread.


> +	nodep = tsearch(fn, &parent->saved_func_tree, function__compare);
> +	if (nodep == NULL) {
> +		fprintf(stderr, "error: out of memory adding local function '%s'\n",
> +			name);
> +		ret = -1;
> +		goto out;
> +	}
> +	/* If we find an existing entry, we want to merge observations
> +	 * across both functions, checking that the "seen optimized-out
> +	 * parameters" status is reflected in our tree entry.
> +	 * If the entry is new, record encoder state required
> +	 * to add the local function later (encoder + type_id_off)
> +	 * such that we can add the function later.
> +	 */
> +	if (*nodep != fn) {
> +		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
> +	} else {
> +		struct btf_encoder_state *state = zalloc(sizeof(*state));
> +
> +		if (state == NULL) {
> +			fprintf(stderr, "error: out of memory adding local function '%s'\n",
> +				name);
> +			ret = -1;
> +			goto out;
> +		}
> +		state->encoder = encoder;
> +		state->type_id_off = encoder->type_id_off;
> +		fn->priv = state;
> +		encoder->saved_func_cnt++;
> +		if (encoder->verbose)
> +			printf("added local function '%s'%s\n", name,
> +			       fn->proto.optimized_parms ?
> +			       ", optimized-out params" : "");
> +	}
> +out:
> +	pthread_mutex_unlock(&parent->saved_func_lock);
> +	return ret;
> +}
> +
