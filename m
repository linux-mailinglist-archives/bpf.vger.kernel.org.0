Return-Path: <bpf+bounces-71053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA8BE0B5B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C647352D66
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F52D2383;
	Wed, 15 Oct 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IM0Jdjg9"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E972046BA
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561661; cv=none; b=X3y5Mh6o5p9j63ns/Sw9w6ZRfpR0+jkm3+DOx8N4AzUo22ViKcwMwlcOoSKwFcomdhvpseTsZXN97dVghmYuKZrAQX46MeyifJpPSKOpZWu+5dZ12qUQirFitmFQpd0JNSGnr1o5K3Xeink3U3BYQTpV4vt6EPm5l16XW0QiYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561661; c=relaxed/simple;
	bh=FELPSjZTS/IFr7JkBw/MxQ/fyf6mwm2Q0Zr6knIQGcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU1Jafi3vHZpHecNMFaP74xV9eVFA0d2GWdnAVSaHFYQ4PyipdGlHkODQgrB1i7/8uwQnQQrbaImsQSuwZED+A4aZSOmJZSYPhu0wRjaH23S26fy75/L0S6U0xgniy/OO33xJfyiCHpinHqBDLZ+QMCWWLIaIw4P1jx6f8UNoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IM0Jdjg9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77c9925b-8567-460c-8441-c42b3629e4a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760561656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoMOSJAGDRmYXJdzQ4c3wB/PRH8o18bOVk4ODvevw9c=;
	b=IM0Jdjg9X122TFP/56wRybI7VpZSfwpenkFwlcEIt3EvzV+HqrI+HLoibpH2CfE+gBX+ZZ
	PQa1hSj9wdF8MjE/eDlnZE4eCSdvqnGo3ncbk1QHqdMdIicWHfUn+35SA1yo0WKvsh4RZD
	yvxTD8wgrdUP/o3kQPoqC9ejHAWh8Fs=
Date: Wed, 15 Oct 2025 13:54:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 verif_scale_strobemeta failure with llvm22
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20251014051639.1996331-1-yonghong.song@linux.dev>
 <CAEf4BzaNATrMLU6SpbFAJn8er+0ouGg1Q8RRv589=opgZ8QM5A@mail.gmail.com>
 <93fc2f1c-c5d3-4260-9a83-1a7300ff73cc@linux.dev>
 <CAEf4BzYuK5faqPD+YRmPf5+T16BJKsM4E=BRTQcLUJxkq8=qPA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYuK5faqPD+YRmPf5+T16BJKsM4E=BRTQcLUJxkq8=qPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/15/25 1:31 PM, Andrii Nakryiko wrote:
> On Wed, Oct 15, 2025 at 12:56 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 10/15/25 9:45 AM, Andrii Nakryiko wrote:
>>> On Mon, Oct 13, 2025 at 10:16 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> With latest llvm22, I hit the verif_scale_strobemeta selftest failure
>>>> below:
>>>>     $ ./test_progs -n 618
>>>>     libbpf: prog 'on_event': BPF program load failed: -E2BIG
>>>>     libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>>>>     BPF program is too large. Processed 1000001 insn
>>>>     verification time 7019091 usec
>>>>     stack depth 488
>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_states 33927 peak_states 12813 mark_read 0
>>>>     -- END PROG LOAD LOG --
>>>>     libbpf: prog 'on_event': failed to load: -E2BIG
>>>>     libbpf: failed to load object 'strobemeta.bpf.o'
>>>>     scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
>>>>     #618     verif_scale_strobemeta:FAIL
>>>>
>>>> But if I increase the verificaiton insn limit from 1M to 10M, the above
>>>> test_progs run actually will succeed. The below is the result from veristat:
>>>>     $ ./veristat strobemeta.bpf.o
>>>>     Processing 'strobemeta.bpf.o'...
>>>>     File              Program   Verdict  Duration (us)    Insns  States  Program size  Jited size
>>>>     ----------------  --------  -------  -------------  -------  ------  ------------  ----------
>>>>     strobemeta.bpf.o  on_event  success       90250893  9777685  358230         15954       80794
>>>>     ----------------  --------  -------  -------------  -------  ------  ------------  ----------
>>>>     Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
>>>>
>>>> Further debugging shows the llvm commit [1] is responsible for the verificaiton
>>>> failure as it tries to convert certain switch statement to if-condition. Such
>>>> change may cause different transformation compared to original switch statement.
>>>>
>>>> In bpf program strobemeta.c case, the initial llvm ir for read_int_var() function is
>>>>     define internal void @read_int_var(ptr noundef %0, i64 noundef %1, ptr noundef %2,
>>>>         ptr noundef %3, ptr noundef %4) #2 !dbg !535 {
>>>>       %6 = alloca ptr, align 8
>>>>       %7 = alloca i64, align 8
>>>>       %8 = alloca ptr, align 8
>>>>       %9 = alloca ptr, align 8
>>>>       %10 = alloca ptr, align 8
>>>>       %11 = alloca ptr, align 8
>>>>       %12 = alloca i32, align 4
>>>>       ...
>>>>       %20 = icmp ne ptr %19, null, !dbg !561
>>>>       br i1 %20, label %22, label %21, !dbg !562
>>>>
>>>>     21:                                               ; preds = %5
>>>>       store i32 1, ptr %12, align 4
>>>>       br label %48, !dbg !563
>>>>
>>>>     22:
>>>>       %23 = load ptr, ptr %9, align 8, !dbg !564
>>>>       ...
>>>>
>>>>     47:                                               ; preds = %38, %22
>>>>       store i32 0, ptr %12, align 4, !dbg !588
>>>>       br label %48, !dbg !588
>>>>
>>>>     48:                                               ; preds = %47, %21
>>>>       call void @llvm.lifetime.end.p0(ptr %11) #4, !dbg !588
>>>>       %49 = load i32, ptr %12, align 4
>>>>       switch i32 %49, label %51 [
>>>>         i32 0, label %50
>>>>         i32 1, label %50
>>>>       ]
>>>>
>>>>     50:                                               ; preds = %48, %48
>>>>       ret void, !dbg !589
>>>>
>>>>     51:                                               ; preds = %48
>>>>       unreachable
>>>>     }
>>>>
>>>> Note that the above 'switch' statement is added by clang frontend.
>>>> Without [1], the switch statement will survive until SelectionDag,
>>>> so the switch statement acts like a 'barrier' and prevents some
>>>> transformation involved with both 'before' and 'after' the switch statement.
>>>>
>>>> But with [1], the switch statement will be removed during middle end
>>>> optimization and later middle end passes (esp. after inlining) have more
>>>> freedom to reorder the code.
>>>>
>>>> The following is the related source code:
>>>>
>>>>     static void *calc_location(struct strobe_value_loc *loc, void *tls_base):
>>>>           bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
>>>>           /* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
>>>>           return tls_ptr && tls_ptr != (void *)-1
>>>>                   ? tls_ptr + tls_index.offset
>>>>                   : NULL;
>>>>
>>>>     In read_int_var() func, we have:
>>>>           void *location = calc_location(&cfg->int_locs[idx], tls_base);
>>>>           if (!location)
>>>>                   return;
>>>>
>>>>           bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
>>>>           ...
>>>>
>>>> The static func calc_location() is called inside read_int_var(). The asm code
>>>> without [1]:
>>>>        77: .123....89 (85) call bpf_probe_read_user#112
>>>>        78: ........89 (79) r1 = *(u64 *)(r10 -368)
>>>>        79: .1......89 (79) r2 = *(u64 *)(r10 -8)
>>>>        80: .12.....89 (bf) r3 = r2
>>>>        81: .123....89 (0f) r3 += r1
>>>>        82: ..23....89 (07) r2 += 1
>>>>        83: ..23....89 (79) r4 = *(u64 *)(r10 -464)
>>>>        84: ..234...89 (a5) if r2 < 0x2 goto pc+13
>>>>        85: ...34...89 (15) if r3 == 0x0 goto pc+12
>>>>        86: ...3....89 (bf) r1 = r10
>>>>        87: .1.3....89 (07) r1 += -400
>>>>        88: .1.3....89 (b4) w2 = 16
>>>> In this case, 'r2 < 0x2' and 'r3 == 0x0' go to null 'locaiton' place,
>>>> so the verifier actually prefers to do verification first at 'r1 = r10' etc.
>>>>
>>>> The asm code with [1]:
>>>>       119: .123....89 (85) call bpf_probe_read_user#112
>>>>       120: ........89 (79) r1 = *(u64 *)(r10 -368)
>>>>       121: .1......89 (79) r2 = *(u64 *)(r10 -8)
>>>>       122: .12.....89 (bf) r3 = r2
>>>>       123: .123....89 (0f) r3 += r1
>>>>       124: ..23....89 (07) r2 += -1
>>>>       125: ..23....89 (a5) if r2 < 0xfffffffe goto pc+6
>>>>       126: ........89 (05) goto pc+17
>>>>       ...
>>>>       144: ........89 (b4) w1 = 0
>>>>       145: .1......89 (6b) *(u16 *)(r8 +80) = r1
>>>> In this case, if 'r2 < 0xfffffffe' is true, the control will go to
>>>> non-null 'location' branch, so 'goto pc+17' will actually go to
>>>> null 'location' branch. This seems causing tremendous amount of
>>>> verificaiton state.
>>>>
>>>> To fix the issue, rewrite the following code
>>>>     return tls_ptr && tls_ptr != (void *)-1
>>>>                   ? tls_ptr + tls_index.offset
>>>>                   : NULL;
>>>> to if/then statement and hopefully these explicit if/then statements
>>>> are sticky during middle-end optimizations.
>>> this is so fragile and non-obvious... Just looking at the patch, it's
>>> an equivalent transformation, so as a user I'd have no clue that doing
>>> something like that can even matter...
>> You are correct. The llvm generate different codes due to compiler internal
>> changes, and in this case the change caused the verification failure.
>>
>>> Have you tried adding likely() around non-NULL case? Does it change
>>> generated code, while leaving ternary as is?
>> I tried the following:
>>
>> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
>> index a5c74d31a244..6c0ec8794d3e 100644
>> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
>> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
>> @@ -346,13 +346,12 @@ static void read_int_var(struct strobemeta_cfg *cfg,
>>                            struct strobemeta_payload *data)
>>    {
>>           void *location = calc_location(&cfg->int_locs[idx], tls_base);
>> -       if (!location)
>> -               return;
>> -
>> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
>> -       data->int_vals[idx] = value->val;
>> -       if (value->header.len)
>> -               data->int_vals_set_mask |= (1 << idx);
>> +       if (likely(location)) {
>> +               bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
>> +               data->int_vals[idx] = value->val;
>> +               if (value->header.len)
>> +                       data->int_vals_set_mask |= (1 << idx);
>> +       }
>>    }
>>
>>
>> and the verification still failed (exceeding 1000000 insns).
> I was thinking to add likely like so:
>
> return likely(tls_ptr && tls_ptr != (void *)-1) ? tls_ptr +
> tls_index.offset : NULL;
>
>
> and then hope that Clang will prioritize leaving non-NULL code path as
> linear as possible

Sadly with the suggested change:

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index a5c74d31a244..d31d5fb1e96e 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -330,7 +330,7 @@ static void *calc_location(struct strobe_value_loc *loc, void *tls_base)
         }
         bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
         /* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
-       return tls_ptr && tls_ptr != (void *)-1
+       return likely(tls_ptr && tls_ptr != (void *)-1)
                 ? tls_ptr + tls_index.offset
                 : NULL;
  }

the verification still fails. Stubborn clang :-(

>
>> I think that we can leave patch for a while. I will do some investigation
>> in llvm side to see whether I can come up with some heuristics to benefit
>> verifier in terms of verified insns.
>>
>>>> Test with llvm20 and llvm21 as well and all strobemeta related selftests
>>>> are passed.
>>>>
>>>>     [1] https://github.com/llvm/llvm-project/pull/161000
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    tools/testing/selftests/bpf/progs/strobemeta.h | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> NOTE: I will also check whether we can make changes in llvm to automatically
>>>>    adjust branch statements to minimize verification insns/states.
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
>>>> index a5c74d31a244..6e1918deaf26 100644
>>>> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
>>>> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
>>>> @@ -330,9 +330,9 @@ static void *calc_location(struct strobe_value_loc *loc, void *tls_base)
>>>>           }
>>>>           bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
>>>>           /* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
>>>> -       return tls_ptr && tls_ptr != (void *)-1
>>>> -               ? tls_ptr + tls_index.offset
>>>> -               : NULL;
>>>> +       if (!tls_ptr || tls_ptr == (void *)-1)
>>>> +               return NULL;
>>>> +       return tls_ptr + tls_index.offset;
>>>>    }
>>>>
>>>>    #ifdef SUBPROGS
>>>> --
>>>> 2.47.3
>>>>


