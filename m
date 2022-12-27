Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C47656D0C
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiL0Qkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiL0QkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 11:40:17 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C9BE21
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 08:40:15 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m15so6971618ilq.2
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIce7nRh9xGN4UvjxO/SDv0vJFrrYRvHppVuS+QFVhE=;
        b=FcfQX0eCcRBZLlS57jjTpr+LOq0sKeVw7DK2g+Q4Acgwz00bMf6CvGTnhSH9rL3bAG
         HNOIBQR4nMp6zCISvMtm50GVOkLfSRHZk7+RQY4NimQk19p5c2ph8SUZLbEFLgOuQw6/
         P5E3L6absRQqw9qvGkH/usYqPr4JGgnGdl1p4UMhokXzNlWypfNTTnO3Dix6MxGyN4M8
         G1a7EHfzydAdWpc65Hk0LKfk7DM2+SVWOPCMfEPLhRWRkbhXDO43cHuYyytexuqGEw4F
         qMFurHI+1F965tvCHgRs/da724gEEZFTFWm/KEsOMazyyRs8bClETyr88Ezr2vbIRlmL
         g/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIce7nRh9xGN4UvjxO/SDv0vJFrrYRvHppVuS+QFVhE=;
        b=62rUq6Ily2CGQC7OvTNXzKHDfQjKw2SId48uyUwH2EEIi2hRLzaiUSwALoaLZYaqot
         ClCW/hfgCNWQYVb9iOkx+HInw/QqdTdqP/t7Njd8tYZsXISLBFl4kyXp1Qbf+o25Ivlo
         a0o7nyahNdaIgft+9aNzjJyZmvGTAuQc8XeLmgIpYSnEjQ3tPA0WEoh9FMiipri0SuIf
         Se/9B2NR3ILPe65c1ePnGf2Y250nkp9CCgZo3SJ/W03qOMeSb79PmGwxOqey67qw44Su
         z6kHvXK7dugWRPKWJIgoaF0Jx2RvcBHY4omzeev9+9F05H18LD039bB78rPtimN1/aUT
         Ajow==
X-Gm-Message-State: AFqh2koIPmG/g/aQyQh64b6+yHDYKh5Yhr77FNAwHkp9yKtE/qYvbqeb
        M98peSlMXFIdGqrGHGXGSS04
X-Google-Smtp-Source: AMrXdXvjs5MwFIzPRSKK0dJ0FJtURJU3NLvTA/UX1momTrK7JHfI4cMrdLQUVSDRERLGZnlgFHIvlw==
X-Received: by 2002:a92:7409:0:b0:307:7cf3:ca79 with SMTP id p9-20020a927409000000b003077cf3ca79mr15117006ilc.22.1672159215019;
        Tue, 27 Dec 2022 08:40:15 -0800 (PST)
Received: from [10.187.149.138] (mobile-166-170-20-165.mycingular.net. [166.170.20.165])
        by smtp.gmail.com with ESMTPSA id y23-20020a027317000000b00349c45fd3a8sm4375283jab.29.2022.12.27.08.40.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Dec 2022 08:40:14 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Stanislav Fomichev <stfomichev@yandex.ru>,
        <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <burn.alting@iinet.net.au>, <daniel@iogearbox.net>,
        <jolsa@kernel.org>, <linux-audit@redhat.com>, <sdf@google.com>
Date:   Tue, 27 Dec 2022 11:40:11 -0500
Message-ID: <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20221227033528.1032724-1-stfomichev@yandex.ru>
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru>
User-Agent: AquaMail/1.41.0 (build: 104100234)
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On December 26, 2022 10:35:49 PM Stanislav Fomichev <stfomichev@yandex.ru> 
wrote:
>> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
>> get_func_ip() */
>>>> -                               tstamp_type_access:1; /* Accessed 
>>>> __sk_buff->tstamp_type */
>>>> +                               tstamp_type_access:1, /* Accessed 
>>>> __sk_buff->tstamp_type */
>>>> +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
>>>>    enum bpf_prog_type      type;           /* Type of BPF program */
>>>>    enum bpf_attach_type    expected_attach_type; /* For some prog types */
>>>>    u32                     len;            /* Number of filter blocks */
>>>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
>>>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>>>> void bpf_prog_put(struct bpf_prog *prog);
>>>>
>>>> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
>>>> +{
>>>> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
>>>> +               return 0;
>>>> +       return prog->aux->__id;
>>>> +}
>>>
>>> I'm still missing why we need to have this WARN and have a check at all.
>>> IIUC, we're actually too eager in resetting the id to 0, and need to
>>> keep that stale id around at least for perf/audit.
>>> Why not have a flag only to protect against double-idr_remove
>>> bpf_prog_free_id and keep the rest as is?
>>> Which places are we concerned about that used to report id=0 but now
>>> would report stale id?
>>
>> What double-idr_remove are you concerned about?
>> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
>> while __bpf_prog_put just dropped it to zero.
>
> (traveling, sending from an untested setup, hope it reaches everyone)
>
> There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> tries to make offloaded program disappear from the idr when the netdev
> goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> is to handle that case where we do bpf_prog_free_id much earlier than the
> rest of the __bpf_prog_put stuff.
>
>> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
>> after perf_event_bpf_event and bpf_audit_prog ?
>> Probably can remove the obsolete do_idr_lock bool flag as
>> separate patch?
>
> +1 on removing do_idr_lock separately.
>
>> Much simpler fix and no code churn.
>> Both valid_id and saved_id approaches have flaws.
>
> Given the __bpf_prog_offload_destroy path above, we still probably need
> some flag to indicate that the id has been already removed from the idr?

So what do you guys want in a patch?  Is there a consensus on what you 
would merge to fix this bug/regression?

--
paul-moore.com



