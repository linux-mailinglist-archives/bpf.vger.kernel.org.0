Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1375E601654
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJQSdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJQSc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 14:32:59 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20F674E06
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 11:32:57 -0700 (PDT)
Message-ID: <c89f7691-d413-cc4e-2f8f-11abe9680e33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666031575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+r0oWfon9R//AXET/WnMrXcD1xkYeGelXY3wPd0HcmQ=;
        b=sh5Sjytc+ffbP8+uKoQNOSFGUXF1S0eE/Uv1S2OIkrsFvOuZ1wLdzHyBzjADN10U+2K4qN
        GYWPZa38fuvugRcGaZzJQLVJeKCarVE4+3BuSGehv2CACib8sXAUZaED96BeEAOkw8csYe
        NK6Uv5pQGZhaHvp8DbPEyq9TJwedAGM=
Date:   Mon, 17 Oct 2022 11:32:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced
 in func_proto
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
References: <20221015002444.2680969-1-sdf@google.com>
 <20221015002444.2680969-2-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221015002444.2680969-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/14/22 5:24 PM, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index eba603cec2c5..35c07afac924 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4436,6 +4436,11 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
>   			return -EINVAL;
>   		}
>   
> +		if (btf_type_is_resolve_source_only(ret_type)) {
> +			btf_verifier_log_type(env, t, "Invalid return type");
> +			return -EINVAL;
> +		}

Thanks for the fix.  It is applied to the bpf tree.

