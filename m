Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACB59F30F
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiHXFbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 01:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHXFbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 01:31:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54375FFC;
        Tue, 23 Aug 2022 22:31:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f17so9324725pfk.11;
        Tue, 23 Aug 2022 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=NwHAtPjAReXq/IjjS87Nz2IZAEkxk0WwcyPP68OUjKs=;
        b=dfETqFUX4r2doa8+YKnEM7KHNpmOIwbcjAyyTLvSbbf4Buq0Hqh0w/0LgI8xcQgtgy
         7kLZJxgex/+rsLh43mWBx52978BzobJ77S2Z871ZHCIvvgcg9UgHp4eSAVcAo/p5zbMj
         57sns4RFXk3S/yljREhwrWWOGeiozpHtwHbvtWO8jeo/qdjOR0qaIUhY0z1l1Us/e3ER
         qJDcSMIK/dusXJf1AcomNiRkntZq1rf0wtDT42rcDYeiKuSDhMh4IP8d3NrppybCKKcN
         eJKXkj0o0CUjteK3lioSHdejLz6cFG77AS/6SbzQiUZtNxr2X21peFeLwGyq4l9jtfMb
         SQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=NwHAtPjAReXq/IjjS87Nz2IZAEkxk0WwcyPP68OUjKs=;
        b=Og6v7crLSohZj2L8Lb8zDvxKk6cwK4ahci4YfiTMV/T3sspE+AVk/8mkS/8jrdpC7h
         iRoef74NQBlaiiPx/KIunSYZqJG1fFjDHvurxiNQKZ9bXHF0Jvca41X53HxbAgxL9Dt5
         V1Uj0RMeby7POig12TbMlu/HUUwAcwc0GtGl1+LRyLj3UY+dn3b649DNfJCWslgRycG6
         0qBoCy9jPPhf/DihVQa6phTrPWd+YfYuH/uB4lkVgi6P32lMExGUOqYFfhzd7MK6hMgn
         U2U+ndccmbTtWxiv0CRmnKXUq0M60vBQlQf9Lus1pPOdRMKMdpA5NjzWStLveLBqBfVc
         hIFQ==
X-Gm-Message-State: ACgBeo3kbn1TI2dlkG3DrM/nChAeEGJJ1DxEG17SWYArlDc/AXRvccQs
        1zOOovL47Mh7ignKR5zslSpxqBG3Pd4=
X-Google-Smtp-Source: AA6agR5e/DKwfYI/Z4kodn0YLTc8GJCp2dQWpCLj0lHTsPJLAzBRncyfS5vP7zIyeYfGmbqxSiE4mg==
X-Received: by 2002:a63:6d09:0:b0:427:bbb0:e62 with SMTP id i9-20020a636d09000000b00427bbb00e62mr22152708pgc.346.1661319103706;
        Tue, 23 Aug 2022 22:31:43 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b00172ff99d0afsm2841733plr.140.2022.08.23.22.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 22:31:42 -0700 (PDT)
Date:   Tue, 23 Aug 2022 22:31:40 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <6305b7bcbd7a3_6d4fc208d9@john.notmuch>
In-Reply-To: <20220823210354.1407473-1-namhyung@kernel.org>
References: <20220823210354.1407473-1-namhyung@kernel.org>
Subject: RE: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Namhyung Kim wrote:
> The helper is for BPF programs attached to perf_event in order to read
> event-specific raw data.  I followed the convention of the
> bpf_read_branch_records() helper so that it can tell the size of
> record using BPF_F_GET_RAW_RECORD flag.
> 
> The use case is to filter perf event samples based on the HW provided
> data which have more detailed information about the sample.
> 
> Note that it only reads the first fragment of the raw record.  But it
> seems mostly ok since all the existing PMU raw data have only single
> fragment and the multi-fragment records are only for BPF output attached
> to sockets.  So unless it's used with such an extreme case, it'd work
> for most of tracing use cases.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

> I don't know how to test this.  As the raw data is available on some
> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> rejected by the verifier.  Actually it needs a bpf_perf_event_data
> context so that's not an option IIUC.

not a pmu expert but also no good ideas on my side.

...

>  
> +BPF_CALL_4(bpf_read_raw_record, struct bpf_perf_event_data_kern *, ctx,
> +	   void *, buf, u32, size, u64, flags)
> +{
> +	struct perf_raw_record *raw = ctx->data->raw;
> +	struct perf_raw_frag *frag;
> +	u32 to_copy;
> +
> +	if (unlikely(flags & ~BPF_F_GET_RAW_RECORD_SIZE))
> +		return -EINVAL;
> +
> +	if (unlikely(!raw))
> +		return -ENOENT;
> +
> +	if (flags & BPF_F_GET_RAW_RECORD_SIZE)
> +		return raw->size;
> +
> +	if (!buf || (size % sizeof(u32) != 0))
> +		return -EINVAL;
> +
> +	frag = &raw->frag;
> +	WARN_ON_ONCE(!perf_raw_frag_last(frag));
> +
> +	to_copy = min_t(u32, frag->size, size);
> +	memcpy(buf, frag->data, to_copy);
> +
> +	return to_copy;
> +}
> +
> +static const struct bpf_func_proto bpf_read_raw_record_proto = {
> +	.func           = bpf_read_raw_record,
> +	.gpl_only       = true,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> +	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> +	.arg4_type      = ARG_ANYTHING,
> +};

Patch lgtm but curious why allow the ARG_PTR_TO_MEM_OR_NULL from API
side instead of just ARG_PTR_TO_MEM? Maybe, just to match the
existing perf_event_read()? I acked it as I think matching existing
API is likely good enough reason.

> +
>  static const struct bpf_func_proto *
>  pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -1548,6 +1587,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_read_branch_records_proto;
>  	case BPF_FUNC_get_attach_cookie:
>  		return &bpf_get_attach_cookie_proto_pe;
> +	case BPF_FUNC_read_raw_record:
> +		return &bpf_read_raw_record_proto;
>  	default:
>  		return bpf_tracing_func_proto(func_id, prog);
>  	}
> -- 
> 2.37.2.609.g9ff673ca1a-goog
> 


