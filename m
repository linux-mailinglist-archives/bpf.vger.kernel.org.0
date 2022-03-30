Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7094EC821
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbiC3PYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbiC3PYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 11:24:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015131925A2
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 08:22:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j13so20708474plj.8
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=rWmpDeUvmPwlMuAa/jUl5NpTSjP3xGaCjNUDWkK+1Zg=;
        b=AhXUA5+qgVG2seWP3jphLDH5WMNHmVwE/tWVyuOtEUbJWBeM5+TXsL835dWg/k4JIY
         Rb7QX+SevoZpzAdqPdR9xq2O3j2BzGjf57qGj7lJyDl6TGxk9t0l2zLHpV8gXFhhLDEt
         VPyM5ekPFzJe426byH978obr4goimI5sG7d74j8vOnamdguZrvTsiz6siXpsFyvqBvZ4
         BfxIda6JM54xnXOMm2t7ZsPKu54fGRVYTaDf1kSnBpzefZ7UbhnrtVekkV1892crnR5w
         UanZTTh/wJHsD5lFRep9TeuuS0/atghhKXAz+oE9QezMn1AIgZZ2ItWRTrYekd/dGexg
         cdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rWmpDeUvmPwlMuAa/jUl5NpTSjP3xGaCjNUDWkK+1Zg=;
        b=hVNcRLTBn/8al8WyFQUCl3jgI56XlGlE94z6yYnrEaebKAaIbbvUGdF4elJfcKADaJ
         cMjxaVDZKToa+vof6xFd4mIEGT/Y97bHE2pQJ75rlx6CsSYZ+A0BMaCPeddCuR05hc4o
         gD4YoKYqXN5jqkeqWylm6LPPwVaGv3atgilL8G3nWjaSTYqMkIymZcCb/PKmRQHLl5Pe
         oHlWuhA53JmR2xPaH+8CDnNBBiPwYSfT8k+lQCd42hWZ0yWkTR6EHbdeM505ownJCRFx
         8fvBb/s+ulhiZiCvQQ+Wz1zZYf2YgoNLPVxrDi4sUTK1U8zXeeHQNa4st/z/eFL44R/W
         93qA==
X-Gm-Message-State: AOAM532zon+6ZipnptRHzUVTtG7tzFcZkVTngmjQaHFDfvfU7sOWQY6N
        eP+AVmbE18LR+6hgpLan1eU=
X-Google-Smtp-Source: ABdhPJw36hdy3Zt5ztAReg99kt+mZ2JM+td1NMUKZSWmaEklNVg9zoay/lttfZpESCOOu4hVyQb0LQ==
X-Received: by 2002:a17:902:e74f:b0:154:6052:55b2 with SMTP id p15-20020a170902e74f00b00154605255b2mr35650903plf.106.1648653771404;
        Wed, 30 Mar 2022 08:22:51 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78d53000000b004fdaae08497sm133975pfe.28.2022.03.30.08.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 08:22:51 -0700 (PDT)
Message-ID: <b11ef0fa-da27-cf96-cb5c-e61c04b5f735@gmail.com>
Date:   Wed, 30 Mar 2022 23:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
Content-Language: en-US
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
References: <20220325052941.3526715-1-andrii@kernel.org>
 <20220325052941.3526715-2-andrii@kernel.org>
 <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
In-Reply-To: <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/3/30 11:10 AM, Hengqi Chen wrote:
> On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
>> Add BPF-side implementation of libbpf-provided USDT support. This
>> consists of single header library, usdt.bpf.h, which is meant to be used
>> from user's BPF-side source code. This header is added to the list of
>> installed libbpf header, along bpf_helpers.h and others.
>>
>> BPF-side implementation consists of two BPF maps:
>>   - spec map, which contains "a USDT spec" which encodes information

...

>> +}
>> +
>> +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
>> + * Returns 0 on success; negative error, otherwise.
>> + * On error *res is guaranteed to be set to zero.
>> + */
>> +__hidden __weak
>> +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
>> +{
>> +	struct __bpf_usdt_spec *spec;
>> +	struct __bpf_usdt_arg_spec *arg_spec;
>> +	unsigned long val;
>> +	int err, spec_id;
>> +
>> +	*res = 0;
>> +
>> +	spec_id = __bpf_usdt_spec_id(ctx);
>> +	if (spec_id < 0)
>> +		return -ESRCH;
>> +
>> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
>> +	if (!spec)
>> +		return -ESRCH;
>> +
>> +	if (arg >= spec->arg_cnt)
>> +		return -ENOENT;
>> +
>> +	arg_spec = &spec->args[arg];
>> +	switch (arg_spec->arg_type) {
>> +	case BPF_USDT_ARG_CONST:
>> +		val = arg_spec->val_off;
>> +		break;
>> +	case BPF_USDT_ARG_REG:
>> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
>> +		if (err)
>> +			return err;
>> +		break;
>> +	case BPF_USDT_ARG_REG_DEREF:
>> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
>> +		if (err)
>> +			return err;
>> +		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
>> +		if (err)
>> +			return err;

Can you elaborate more on these two probe read call ?

I replace bpf_probe_read_kernel with bpf_probe_read_user, it also works.

Thanks.

>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	val <<= arg_spec->arg_bitshift;
>> +	if (arg_spec->arg_signed)
>> +		val = ((long)val) >> arg_spec->arg_bitshift;

>> + * BPF_USDT serves the same purpose for USDT handlers as BPF_PROG for
>> + * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
>> + * Original struct pt_regs * context is preserved as 'ctx' argument.
>> + */
>> +#define BPF_USDT(name, args...)						    \
>> +name(struct pt_regs *ctx);						    \
>> +static __attribute__((always_inline)) typeof(name(0))			    \
>> +____##name(struct pt_regs *ctx, ##args);				    \
>> +typeof(name(0)) name(struct pt_regs *ctx)				    \
>> +{									    \
>> +        _Pragma("GCC diagnostic push")					    \
>> +        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
>> +        return ____##name(___bpf_usdt_args(args));			    \
>> +        _Pragma("GCC diagnostic pop")					    \
>> +}									    \
>> +static __attribute__((always_inline)) typeof(name(0))			    \
>> +____##name(struct pt_regs *ctx, ##args)
>> +
>> +#endif /* __USDT_BPF_H__ */
