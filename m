Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04DCF4A1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2019 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfJHIHv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 8 Oct 2019 04:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfJHIHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Oct 2019 04:07:50 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32DC2C049D5F
        for <bpf@vger.kernel.org>; Tue,  8 Oct 2019 08:07:50 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id g24so2094595lfh.4
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2019 01:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8r2A8RHSVbPNJ/Z5+6unczctADtPbNcHivoK3Mjt5kI=;
        b=p3eby4QJwZ8fm+xRYW6B5H1Gkxg/0Nw6NMM0v/dXhdbkdts6LWcrgvnYP3VirghtrH
         kONVZI+Z3XhQB+Zuw+yIAMXWMzOUENthZUpk8cfmjgO4LOQAnHVe9AuJmcmzjJjFOuEA
         w5y5O+30oxQ4J2PHNRGoCaqtQ1Ef1OkRMGTiZODCllUqzwTX4/Sa++Gd1lXEwyjeyHOc
         NsVfvr147Cbrb44jEjwETRE7wTqBPRXyoLPgGkXkCWUZp/CREIe7ktbqRUAQrzgTkGcG
         LEKxikMx1YPPJ2TdJYYyjBQmFWzN8vzpFJCD7cuYssErJbd7zV4hm6YRd2V57w6173Rl
         dVQw==
X-Gm-Message-State: APjAAAWQQ13t/gnlQeXnQylb+xqfXnA3gC5LULA7QMe+NG/dEIPckJT9
        sIbA3EYZu9ptL9WuJ6rfxLuXevc2XFs8ZdMqH/ifRujR+Q1mvS8wYCICjtdS3XAWSPZQcDp7jYV
        ey5lGuUEdk3x7
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr20619848ljg.41.1570522068698;
        Tue, 08 Oct 2019 01:07:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyim6hiQaeQ/UWuNLi3kyV1DsNTtYSZaibuAdQU8PJzdmY/5MLV/YLt8f7pjEIPn2hG1swk3w==
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr20619831ljg.41.1570522068421;
        Tue, 08 Oct 2019 01:07:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id x25sm3858154ljb.60.2019.10.08.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 01:07:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D752B18063D; Tue,  8 Oct 2019 10:07:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF programs after each other
In-Reply-To: <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Oct 2019 10:07:46 +0200
Message-ID: <87sgo3lkx9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Oct 07, 2019 at 07:20:36PM +0200, Toke Høiland-Jørgensen wrote:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> 
>> This adds support for wrapping eBPF program dispatch in chain calling
>> logic. The code injection is controlled by a flag at program load time; if
>> the flag is set, the BPF program will carry a flag bit that changes the
>> program dispatch logic to wrap it in a chain call loop.
>> 
>> Ideally, it shouldn't be necessary to set the flag on program load time,
>> but rather inject the calls when a chain call program is first loaded. The
>> allocation logic sets the whole of struct bpf_prog to be read-only memory,
>> so it can't immediately be modified, but conceivably we could just unlock
>> the first page of the struct and flip the bit when a chain call program is
>> first attached.
>> 
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  include/linux/bpf.h      |    3 +++
>>  include/linux/filter.h   |   34 ++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/bpf.h |    6 ++++++
>>  kernel/bpf/core.c        |    6 ++++++
>>  kernel/bpf/syscall.c     |    4 +++-
>>  5 files changed, 50 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5b9d22338606..13e5f38cf5c6 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -365,6 +365,8 @@ struct bpf_prog_stats {
>>  	struct u64_stats_sync syncp;
>>  };
>>  
>> +#define BPF_NUM_CHAIN_SLOTS 8
>> +
>>  struct bpf_prog_aux {
>>  	atomic_t refcnt;
>>  	u32 used_map_cnt;
>> @@ -383,6 +385,7 @@ struct bpf_prog_aux {
>>  	struct list_head ksym_lnode;
>>  	const struct bpf_prog_ops *ops;
>>  	struct bpf_map **used_maps;
>> +	struct bpf_prog *chain_progs[BPF_NUM_CHAIN_SLOTS];
>>  	struct bpf_prog *prog;
>>  	struct user_struct *user;
>>  	u64 load_time; /* ns since boottime */
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 2ce57645f3cd..3d1e4991e61d 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -21,6 +21,7 @@
>>  #include <linux/kallsyms.h>
>>  #include <linux/if_vlan.h>
>>  #include <linux/vmalloc.h>
>> +#include <linux/nospec.h>
>>  
>>  #include <net/sch_generic.h>
>>  
>> @@ -528,6 +529,7 @@ struct bpf_prog {
>>  				is_func:1,	/* program is a bpf function */
>>  				kprobe_override:1, /* Do we override a kprobe? */
>>  				has_callchain_buf:1, /* callchain buffer allocated? */
>> +				chain_calls:1, /* should this use the chain_call wrapper */
>>  				enforce_expected_attach_type:1; /* Enforce expected_attach_type checking at attach time */
>>  	enum bpf_prog_type	type;		/* Type of BPF program */
>>  	enum bpf_attach_type	expected_attach_type; /* For some prog types */
>> @@ -551,6 +553,30 @@ struct sk_filter {
>>  	struct bpf_prog	*prog;
>>  };
>>  
>> +#define BPF_MAX_CHAIN_CALLS 32
>> +static __always_inline unsigned int do_chain_calls(const struct bpf_prog *prog,
>> +						   const void *ctx)
>> +{
>> +	int i = BPF_MAX_CHAIN_CALLS;
>> +	int idx;
>> +	u32 ret;
>> +
>> +	do {
>> +		ret = (*(prog)->bpf_func)(ctx, prog->insnsi);
>
> This breaks program stats.

Oh, right, silly me. Will fix.

>> +
>> +		if (ret + 1 >= BPF_NUM_CHAIN_SLOTS) {
>> +			prog = prog->aux->chain_progs[0];
>> +			continue;
>> +		}
>> +		idx = ret + 1;
>> +		idx = array_index_nospec(idx, BPF_NUM_CHAIN_SLOTS);
>> +
>> +		prog = prog->aux->chain_progs[idx] ?: prog->aux->chain_progs[0];
>> +	} while (prog && --i);
>> +
>> +	return ret;
>> +}
>> +
>>  DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>>  
>>  #define BPF_PROG_RUN(prog, ctx)	({				\
>> @@ -559,14 +585,18 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>>  	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
>>  		struct bpf_prog_stats *stats;			\
>>  		u64 start = sched_clock();			\
>> -		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
>> +		ret = prog->chain_calls ?			\
>> +			do_chain_calls(prog, ctx) :			\
>> +			 (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
>
> I thought you agreed on 'no performance regressions' rule?

As I wrote in the cover letter I could not measurable a performance
impact from this, even with the simplest possible XDP program (where
program setup time has the largest impact).

This was the performance before/after patch (also in the cover letter):

Before patch (XDP DROP program):  31.5 Mpps
After patch (XDP DROP program):   32.0 Mpps

So actually this *increases* performance ;)
(Or rather, the difference is within the measurement uncertainty on my
system).

-Toke
