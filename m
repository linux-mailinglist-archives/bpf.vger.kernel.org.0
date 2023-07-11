Return-Path: <bpf+bounces-4706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF774E47D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A5E1C20CFA
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A802116;
	Tue, 11 Jul 2023 02:55:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCD7F;
	Tue, 11 Jul 2023 02:55:46 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5210D;
	Mon, 10 Jul 2023 19:55:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262ef07be72so2462624a91.1;
        Mon, 10 Jul 2023 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044145; x=1691636145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rz2Z9uqGBu5n7dLxdjRn3DUHrI1c1OAJnAS4Abt85fE=;
        b=endMdthOppBOwx2i6IgP0RGFV4c4vlhf4/1XIHyi++9rZ9OurjbQsSmg/GdSnsUOqR
         /J3B2sQEfKDE0vjZVofernbv7j7JdCiYc0rNrgxzN0GrrBoO4ePWFrhlI9CG/CRHfBqD
         aoUf/fFNmUdkoWwpfRPW91OJt/ML9PjfDTC8PVR3gsBRUt/HNpgUyjrCr+vINjcpeaOf
         2m7q6z+L2bpl8+qO0mAdv0fGRBZdtSv6T/wRTbZVCOZES72ow8KerSa2NU/m5CmRkYeb
         95Nx0sneUXojQv+SmR6oIWZ3FZ4NjEZMF7Kj/rjETxLosbo7VJMArRt9sAzIDlETUpty
         e9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044145; x=1691636145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz2Z9uqGBu5n7dLxdjRn3DUHrI1c1OAJnAS4Abt85fE=;
        b=JUMaf0qK0NaUnuRr/rewMx+nqmwKi9fpLs+h62Pj3RE7izQNW8jjSFE5Q7gWlM4FyE
         mEBT3drSHRrv3lQvOjy7n3ZJ/qfy0fvpssXyysRBxHV37saOK0jC59DguTfZJG3x4KgQ
         8lN+oe3khGN2aJgXhIRt0MxQPrD7zVuipInu+JIB5zXm4HvOPTs1eU6qzISyksh6hMLA
         sXOTHu2Z/MJQL4zfS+yHm8aLQfncnLAPN0sA8/FriP51FTUzNPd9kQIRjy0yHouS/Rtu
         TAHVrrRhHgyaMiyCA0RI/0/QyH+ufo8rdEu5kSnA464WgS/aCqOsko7fBz9dRXIYPtd0
         43tw==
X-Gm-Message-State: ABy/qLYMPuMTrXVcyoInZbzIdQFUhIrvC13Qw5i9oRn197KausEp0D3I
	jfa2yxf6ybSenbup5do6no4=
X-Google-Smtp-Source: APBJJlGefJaLDQ/qu9dj4CMlypbzscGGz+zUgXdw8Kd4Fm3x1UinASvZDF+IPR97JY0klBG1CT/Ziw==
X-Received: by 2002:a17:90a:2a87:b0:262:d029:69fc with SMTP id j7-20020a17090a2a8700b00262d02969fcmr11103174pjd.34.1689044144557;
        Mon, 10 Jul 2023 19:55:44 -0700 (PDT)
Received: from [10.22.68.146] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id qe4-20020a17090b4f8400b0025c2c398d33sm600736pjb.39.2023.07.10.19.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 19:55:44 -0700 (PDT)
Message-ID: <115c6eac-ab28-7220-e1e4-5747bf641bbe@gmail.com>
Date: Tue, 11 Jul 2023 10:55:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Introduce bpf user log
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20230708040750.72570-1-hffilwlqm@gmail.com>
 <20230708040750.72570-3-hffilwlqm@gmail.com>
 <CAADnVQK5RLqVhc9AxaCSuQxFRDAb8wohmUDNrYEViXLf5mEMNQ@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQK5RLqVhc9AxaCSuQxFRDAb8wohmUDNrYEViXLf5mEMNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 11/7/23 07:45, Alexei Starovoitov wrote:
> On Fri, Jul 7, 2023 at 9:08 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 34fa334938ba5..8a458cfcd91bd 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1549,7 +1549,6 @@ union bpf_attr {
>>                 };
>>                 __u32           attach_type;    /* attach type */
>>                 __u32           flags;          /* extra flags */
>> -               struct bpf_generic_user_log log; /* user log */
>>                 union {
>>                         __u32           target_btf_id;  /* btf_id of target to attach to */
>>                         struct {
>> @@ -1585,6 +1584,9 @@ union bpf_attr {
>>                                 __s32           priority;
>>                                 __u32           flags;
>>                         } netfilter;
>> +                       struct {
>> +                               struct bpf_generic_user_log ulog; /* user log */
>> +                       } xdp;
> 
> 1.
> You cannot break api in patch 1 and fix it in patch 2.
> 
> 2.
> libbpf side is missing.
> 
> 3.
> selftest is missing.
> 
> 4.
> bpf_vlog_finalize() should be used and error propagated back through
> link_create.
> Same api must be used: log_level, log_size, log_buf, log_true_size.
> 
> But considering all that I agree with Daniel Xu that
> tracepoint would be better here.

Sorry for missing 2&3.

Tracepoint is considered. I'll change it from user log to a tracepoint.

I'll submit tracepoint patch with libbpf&selftest patches later.

Thanks,
Leon

