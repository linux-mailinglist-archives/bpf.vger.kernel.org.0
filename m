Return-Path: <bpf+bounces-35204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D1938767
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414F1C20C39
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9AC2FD;
	Mon, 22 Jul 2024 01:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4263232;
	Mon, 22 Jul 2024 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612972; cv=none; b=pC1ySE8LslUMPA2NcCHn9//5m74fAZ9s/9w116xVeWg8u5rWbhIsLD32eMP+XHSVxFDTgA6uVsR6i0kmC9eUr7x2FlAXpNHt5yfDLNHCL2n+tURoZjWK1AJQmHwSTvQtoJ9BbaqDPbaSTJROYsopD9r2ka6OZQ2s/o0UAvpXXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612972; c=relaxed/simple;
	bh=swvuAzxg91U5ghYWXkg8rKM9aIt6O6L6hqCR1Qfa/gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cYaIqskhPyvfk/J9qNqbpaLah2eIi1MU9i/xXYddJYBBC1jlnptXdzh9GnQ4jl4G6GiVpS83OpOCSVNgKCyeYJAdN4d4rCFjgVFJ7YjLrNGr5Wpvt9t4JvzY9nPr9KboDkzdKa37vjDxLIoeUEUVSF3de5fiPtN0owAkbm/95Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WS2dS0V04z20krD;
	Mon, 22 Jul 2024 09:25:00 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 322421A0188;
	Mon, 22 Jul 2024 09:29:08 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 09:29:07 +0800
Message-ID: <50180a93-b555-087e-2376-3bf46fabafb6@huawei.com>
Date: Mon, 22 Jul 2024 09:29:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/6] kallsyms: Emit symbol at the holes in the text
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen.n.rao@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<nathan@kernel.org>, <nicolas@fjasle.eu>, <kees@kernel.org>,
	<james.clark@arm.com>, <kent.overstreet@linux.dev>, <yhs@fb.com>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-modules@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240613133711.2867745-1-zhengyejian1@huawei.com>
 <20240613133711.2867745-3-zhengyejian1@huawei.com>
 <CAK7LNAQaLc6aDK85qQtPHoCkQSGyL-TxXjpgJTfehe2Q1=jMSA@mail.gmail.com>
 <c87eeb9c-5f54-480c-17c2-01339416b1b9@huawei.com>
 <CAK7LNARiR5z9hPRG932T7YjRWqkX_qZ7WKmbxx7iTo2w5YJojQ@mail.gmail.com>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <CAK7LNARiR5z9hPRG932T7YjRWqkX_qZ7WKmbxx7iTo2w5YJojQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/7/20 22:14, Masahiro Yamada wrote:
> On Thu, Jul 18, 2024 at 12:45 PM Zheng Yejian <zhengyejian1@huawei.com> wrote:
>>
>> On 2024/7/16 16:33, Masahiro Yamada wrote:
>>> On Thu, Jun 13, 2024 at 10:36 PM Zheng Yejian <zhengyejian1@huawei.com> wrote:
>>>>
>>>> When a weak type function is overridden, its symbol will be removed
>>>> from the symbol table, but its code will not be removed. Besides,
>>>> due to lacking of size for kallsyms, kernel compute function size by
>>>> substracting its symbol address from its next symbol address (see
>>>> kallsyms_lookup_size_offset()). These will cause that size of some
>>>> function is computed to be larger than it actually is, just because
>>>> symbol of its following weak function is removed.
>>>>
>>>> This issue also causes multiple __fentry__ locations to be counted in
>>>> the some function scope, and eventually causes ftrace_location() to find
>>>> wrong __fentry__ location. It was reported in
>>>> Link: https://lore.kernel.org/all/20240607115211.734845-1-zhengyejian1@huawei.com/
>>>>
>>>> Peter suggested to change scipts/kallsyms.c to emit readily
>>>> identifiable symbol names for all the weak junk, eg:
>>>>
>>>>     __weak_junk_NNNNN
>>>>
>>>> The name of this kind symbol needs some discussion, but it's temporarily
>>>> called "__hole_symbol_XXXXX" in this patch:
>>>> 1. Pass size info to scripts/kallsyms  (see mksysmap());
>>>> 2. Traverse sorted function symbols, if one function address plus its
>>>>      size less than next function address, it means there's a hole, then
>>>>      emit a symbol "__hole_symbol_XXXXX" there which type is 't'.
>>>>
>>>> After this patch, the effect is as follows:
>>>>
>>>>     $ cat /proc/kallsyms | grep -A 3 do_one_initcall
>>>>     ffffffff810021e0 T do_one_initcall
>>>>     ffffffff8100245e t __hole_symbol_XXXXX
>>>>     ffffffff810024a0 t __pfx_rootfs_init_fs_context
>>>>
>>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>>>
>>>
>>>
>>> With my quick test, "t__hole_symbol_XXXXX" was encoded
>>> into the following 10-byte stream.
>>>
>>> .byte 0x09, 0x94, 0xbf, 0x18, 0xf3, 0x3d, 0xce, 0xd1, 0xd1, 0x58
>>>
>>>
>>>
>>> Now "t__hole_symbol_XXXXX" is the most common symbol name.
>>> However, 10 byte is consumed for every instance of
>>> "t__hole_symbol_XXXXX".
>>>
>>> This is much less efficient thanI had expected,
>>> although I did not analyze the logic of this inefficiency.
>>>
>> Hi, Masahiro!
>>
>> In my local test, "t__hole_symbol_XXXXX" was finally encoded
>> into just one byte. See "kallsyms_token_table" in the .tmp_vmlinux.kallsyms2.S:
>>
>>     kallsyms_token_table:
>>           [...]
>>           .asciz  "t__hole_symbol_XXXXX"
>>           .asciz  "hole_symbol_XXXXX"
>>           .asciz  "e_symbol_XXXXX"
>>           .asciz  "XXXXX"
>>           .asciz  "XXX"
>>           .asciz  "e_symbol_"
>>           .asciz  "ymbol_"
>>           .asciz  "ymb"
>>           .asciz  "hol"
>>           .asciz  "ol_"
>>           .asciz  "pfx"
>>           .asciz  "pf"
>>           .asciz  "e_s"
>>           .asciz  "ym"
>>           .asciz  "t__"
>>           .asciz  "_s"
>>           .asciz  "ol"
>>           .asciz  "__"
>>           .asciz  "XX"
>>
>> But it would still takes up several tokens due to substrings of
>> "t__hole_symbol_XXXXX" would also become the most common ones.
>> After this patch, the number of "t__hole_symbol_XXXXX" will be ~30% of the total.
>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>> ---
>>>>    scripts/kallsyms.c      | 101 +++++++++++++++++++++++++++++++++++++++-
>>>>    scripts/link-vmlinux.sh |   4 +-
>>>>    scripts/mksysmap        |   2 +-
>>>>    3 files changed, 102 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
>>>> index 6559a9802f6e..5c4cde864a04 100644
>>>> --- a/scripts/kallsyms.c
>>>> +++ b/scripts/kallsyms.c
>>>> @@ -35,6 +35,7 @@
>>>>    struct sym_entry {
>>>>           struct sym_entry *next;
>>>>           unsigned long long addr;
>>>> +       unsigned long long size;
>>>>           unsigned int len;
>>>>           unsigned int seq;
>>>>           unsigned int start_pos;
>>>> @@ -74,6 +75,7 @@ static int token_profit[0x10000];
>>>>    static unsigned char best_table[256][2];
>>>>    static unsigned char best_table_len[256];
>>>>
>>>> +static const char hole_symbol[] = "__hole_symbol_XXXXX";
>>>>
>>>>    static void usage(void)
>>>>    {
>>>> @@ -130,8 +132,16 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
>>>>           size_t len;
>>>>           ssize_t readlen;
>>>>           struct sym_entry *sym;
>>>> +       unsigned long long size = 0;
>>>>
>>>>           errno = 0;
>>>> +       /*
>>>> +        * Example of expected symbol format:
>>>> +        * 1. symbol with size info:
>>>> +        *    ffffffff81000070 00000000000001d7 T __startup_64
>>>> +        * 2. symbol without size info:
>>>> +        *    0000000002a00000 A text_size
>>>> +        */
>>>>           readlen = getline(buf, buf_len, in);
>>>>           if (readlen < 0) {
>>>>                   if (errno) {
>>>> @@ -145,9 +155,24 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
>>>>                   (*buf)[readlen - 1] = 0;
>>>>
>>>>           addr = strtoull(*buf, &p, 16);
>>>> +       if (*buf == p || *p++ != ' ') {
>>>> +               fprintf(stderr, "line format error: unable to parse address\n");
>>>> +               exit(EXIT_FAILURE);
>>>> +       }
>>>> +
>>>> +       if (*p == '0') {
>>>> +               char *str = p;
>>>>
>>>> -       if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ') {
>>>> -               fprintf(stderr, "line format error\n");
>>>> +               size = strtoull(str, &p, 16);
>>>> +               if (str == p || *p++ != ' ') {
>>>> +                       fprintf(stderr, "line format error: unable to parse size\n");
>>>> +                       exit(EXIT_FAILURE);
>>>> +               }
>>>> +       }
>>>> +
>>>> +       type = *p++;
>>>> +       if (!isascii(type) || *p++ != ' ') {
>>>> +               fprintf(stderr, "line format error: unable to parse type\n");
>>>>                   exit(EXIT_FAILURE);
>>>>           }
>>>>
>>>> @@ -182,6 +207,7 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
>>>>                   exit(EXIT_FAILURE);
>>>>           }
>>>>           sym->addr = addr;
>>>> +       sym->size = size;
>>>>           sym->len = len;
>>>>           sym->sym[0] = type;
>>>>           strcpy(sym_name(sym), name);
>>>> @@ -795,6 +821,76 @@ static void sort_symbols(void)
>>>>           qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
>>>>    }
>>>>
>>>> +static int may_exist_hole_after_symbol(const struct sym_entry *se)
>>>
>>>
>>> The return type should be bool.
>>>
>>
>> Yes!
>>
>>>
>>>
>>>> +{
>>>> +       char type = se->sym[0];
>>>> +
>>>> +       /* Only check text symbol or weak symbol */
>>>> +       if (type != 't' && type != 'T' &&
>>>> +           type != 'w' && type != 'W')
>>>> +               return 0;
>>>> +       /* Symbol without size has no hole */
>>>> +       return se->size != 0;
>>>> +}
>>>> +
>>>> +static struct sym_entry *gen_hole_symbol(unsigned long long addr)
>>>> +{
>>>> +       struct sym_entry *sym;
>>>> +       static size_t len = sizeof(hole_symbol);
>>>> +
>>>> +       /* include type field */
>>>> +       sym = malloc(sizeof(*sym) + len + 1);
>>>> +       if (!sym) {
>>>> +               fprintf(stderr, "unable to allocate memory for hole symbol\n");
>>>> +               exit(EXIT_FAILURE);
>>>> +       }
>>>> +       sym->addr = addr;
>>>> +       sym->size = 0;
>>>> +       sym->len = len;
>>>> +       sym->sym[0] = 't';
>>>> +       strcpy(sym_name(sym), hole_symbol);
>>>> +       sym->percpu_absolute = 0;
>>>> +       return sym;
>>>> +}
>>>> +
>>>> +static void emit_hole_symbols(void)
>>>> +{
>>>> +       unsigned int i, pos, nr_emit;
>>>> +       struct sym_entry **new_table;
>>>> +       unsigned int new_cnt;
>>>> +
>>>> +       nr_emit = 0;
>>>> +       for (i = 0; i < table_cnt - 1; i++) {
>>>> +               if (may_exist_hole_after_symbol(table[i]) &&
>>>> +                   table[i]->addr + table[i]->size < table[i+1]->addr)
>>>> +                       nr_emit++;
>>>> +       }
>>>> +       if (!nr_emit)
>>>> +               return;
>>>> +
>>>> +       new_cnt = table_cnt + nr_emit;
>>>> +       new_table = malloc(sizeof(*new_table) * new_cnt);
>>>
>>>
>>> Do you need to allocate another huge table?
>>>
>>> You can use realloc() to append the room for nr_emit
>>> if you iterate the table in the reverse order.
>>>
>>
>> Yes, it would be much better. If it turns out to be the
>> "emit hole symbol" solution, I'll change it to that in the next version,
>> actually, I forgot to mark this series as "RFC".
> 
> 
> "__hole_symbol_XXXXX" is too much.
> 
> You can use the empty symbol type/name as a special case
> to represent the hole.
> 

Ok, I'll try it in v2.

> 

-- 
Thanks,
Zheng Yejian


