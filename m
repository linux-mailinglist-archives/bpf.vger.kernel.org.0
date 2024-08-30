Return-Path: <bpf+bounces-38596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F004966A89
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EED1F23579
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3714171089;
	Fri, 30 Aug 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TySXRa1L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB681547D7
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049868; cv=none; b=ozKeGFEybQS7hFXZ4MEkjS2gaqILBJgk5BKDh4wUkg1W2F+ybQxibpEsmpUrQ7i1mLFKUwqX2fa6feGCVLD7k60vjBsa85pOkWL21VRnxQ6Rs8ODjV+sKsj6ssbNDsYQGBdDFU3yfncPAxs9mA+UTKUlV6C2m2CyE/UxDjk8e4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049868; c=relaxed/simple;
	bh=KUs0oQ9a5JxDNm0F/syCmR48jbQ5tETCAQ06ckVxYLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGNS65/ZCUzPt3grpD+OJm2o8E4ECuAPCz2AIVK3kE+1t2tUv7ZShySTL3iw3BlWtoKLRHV4vDpyRtULdSQC2MD4ws2P5tLnMYhuyvXgI+RlImABqqvi/BtGmhUi03yAVoBde5Fm39kJLNwl7jJBWl5WKU90y2PaVJMJV0HXI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TySXRa1L; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86a0b5513aso261686966b.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049865; x=1725654665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygLHSA8dpd9eS0O+hRgdyFteWuVnZvEJ4KC+ctUsXww=;
        b=TySXRa1LuzDC/cHRs7AXQtVFuii35AB0Jj+fGsu+Kwo9h3mYMsyUUkjc9PpNJbIlcN
         F/ziI2CEQxLiM/tiyEjmKqDx/XXuV0kT5wi73F3Zw0c/l9Q2zUMYoDqfpwNuLm/Ns7OM
         7ekerJ3y0tidawkV10GS1evIE+ym08JC6GdTr0pY3eK4XpnDtH40aCrq9SisDsZ/3Agk
         YNitaf/xtGJVnyb01cgHNiiD7PqnJdV+Q8iDVCVxRJ0d57lPbBjijVcTWIvT1Nges6dC
         Y/jql/FJ3zAPy9ygw1HllZ1MQXU/lldrBjXVDhlJ/D4sHDpNQmaSq1bxqM+rJMsA9LPo
         aWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049865; x=1725654665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygLHSA8dpd9eS0O+hRgdyFteWuVnZvEJ4KC+ctUsXww=;
        b=lkkBdYCUZa9NZtYzuYIigpnBd7AnLwaVI8E1/Am5AzsM1iepNLh5tsMRycTRaRkgUQ
         7ytbe6nW8WmoM2ZPsrUNV1fQ4GOHU2LRmjp/N6HH8xWTBunaDCrHgJuCsagYBUTWeMI+
         kJse5/Ld0Hocc+XwAgiDY65uEnbHN6GwYbyq+WwuM/o8fGcNi56KRoFQXjyUcidNVwTP
         vvYXVuNsOguMe2o6aMFsNHKdRGDjFNRkQ8BsVqBqrPrftj06nyyzaEXHKKOifaXJn20h
         UCMTh0QZnqBRFisfDUV4fLtHQV88hpQDQ5mMTCuZ+lPtE010a2yPyerk4FuJI67F3f1u
         3KAg==
X-Gm-Message-State: AOJu0Yyu9LWznGDgR15Be3VZRl/PO60ZiL5HpbHgS0aZHbR3VaeZV4Ho
	HwiTwDa60egSKtZyCSmuAOAQexJh+Z7UM7jy08zdldCcAW161dPf
X-Google-Smtp-Source: AGHT+IFEB8iDm+ZMIZy5GLfEfpYEUqkqeu9P8JYca96bt5vPl9ZGv4c+F0TC7PeAkW4QdhtxK0TgQQ==
X-Received: by 2002:a17:907:9816:b0:a86:7e7f:69ab with SMTP id a640c23a62f3a-a897f8354bamr571782966b.15.1725049863961;
        Fri, 30 Aug 2024 13:31:03 -0700 (PDT)
Received: from [192.168.0.20] (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021922sm251475666b.83.2024.08.30.13.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 13:31:03 -0700 (PDT)
Message-ID: <86ff6bd1-6b26-47c0-9f5b-294a8609c0d4@gmail.com>
Date: Fri, 30 Aug 2024 21:31:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: emit top frequent C code lines in
 veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240820152433.777663-1-yatsenko@meta.com>
 <CAEf4BzYjzfK9ppcrLg6As_8egG4f49HjeG-UGzNgBg9qtao0Uw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYjzfK9ppcrLg6As_8egG4f49HjeG-UGzNgBg9qtao0Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 23:29, Andrii Nakryiko wrote:
> On Tue, Aug 20, 2024 at 8:24 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Production BPF programs are increasing in number of instructions and states
>> to the point, where optimising verification process for them is necessary
>> to avoid running into instruction limit. Authors of those BPF programs
>> need to analyze verifier output, for example, collecting the most
>> frequent C source code lines to understand which part of the program has
>> the biggest verification cost.
>>
>> This patch introduces `--top-lines` and `--include-instructions` flags in
>> veristat.
>> `--top-lines=N` makes veristat output N the most popular C sorce code
>> lines, parsed from verification log. `--include-instructions` enables
>> printing BPF instructions along with C source code.
> Hm... I think --include-instructions needs a bit more thought to be
> useful. Just one assembly instruction isn't all that useful, we should
> be thinking in terms of blocks of assembly instruction, probably...
> But then not sure how to take that into account when calculating top N
> frequencies...
>
> Not sure about all that. For v2, let's drop the assembly instructions
> parts and try to get --top-lines logic right. We can then see how it
> works in practice and adjust and extend as necessary.
--include-instructions outputs a block of the instructions that go after
the source code line in the verifier buffer, an example output:
```
processed 5549 insns (limit 1000000) max_states_per_insn 8 total_states 
226 peak_states 198 mark_read 29

Top C source code lines:
; [Count: 114]  ctx->off = off + *opsize; @ xdp_synproxy_kern.c:260
1033: (71) r5 = *(u8 *)(r5 +0)        ; frame1: 
R5_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 
0xff)) cb
1034: (0c) w4 += w5                   ; frame1: 
R4_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) 
R5_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 
0xff)) cb
1035: (63) *(u32 *)(r2 +28) = r4      ; frame1: R2=fp[0]-64 
R4_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) cb
1036: (bc) w7 = w4                    ; frame1: 
R4=scalar(id=75,smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) 
R7=scalar(id=75,smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) cb
1037: (b4) w0 = 0                     ; frame1: R0_w=0 cb
; [Count: 108]  for (i = 0; i < 7; i++) @ xdp_synproxy_kern.c:269
1038: (04) w1 += -1                   ; frame1: R1_w=6 cb
1039: (bc) w4 = w7                    ; frame1: 
R4_w=scalar(id=75,smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) 
R7=scalar(id=75,smin=smin32=0,smax=umax=smax32=umax32=0x100fd,var_off=(0x0; 
0x1ffff)) cb
1040: (56) if w1 != 0x0 goto pc+1
; [Count: 106]  if (data + sz >= ctx->data_end) @ xdp_synproxy_kern.c:211
1046: (bf) r5 = r6                    ; frame1: 
R5_w=pkt(id=72,r=0,smin=smin32=0,smax=umax=smax32=umax32=0xfffe,var_off=(0x0; 
0xffff)) 
R6_w=pkt(id=72,r=0,smin=smin32=0,smax=umax=smax32=umax32=0xfffe,var_off=(0x0; 
0xffff)) cb
1047: (07) r5 += 1                    ; frame1: 
R5_w=pkt(id=72,off=1,r=0,smin=smin32=0,smax=umax=smax32=umax32=0xfffe,var_off=(0x0; 
0xffff)) cb
1048: (79) r7 = *(u64 *)(r2 +8)       ; frame1: R2=fp[0]-64 
R7_w=pkt_end() cb
1049: (3d) if r5 >= r7 goto pc-9      ; frame1: 
R5_w=pkt(id=72,off=1,r=2,smin=smin32=0,smax=umax=smax32=umax32=0xfffe,var_off=(0x0; 
0xffff)) R7_w=pkt_end() cb

File                     Program Verdict  Duration (us)  Insns  States  
Peak states
-----------------------  ------------- -------  -------------  -----  
------  -----------
xdp_synproxy_kern.bpf.o  syncookie_tc success          37106   5549     
226          198
xdp_synproxy_kern.bpf.o  syncookie_xdp success          40206   5826     
228          201
-----------------------  ------------- -------  -------------  -----  
------  -----------
Done. Processed 1 files, 0 programs. Skipped 2 files, 0 programs.
```

Thanks for all the findings, I'll apply them for v2.

>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 160 +++++++++++++++++++++++++
>>   1 file changed, 160 insertions(+)
>>
> Ok, #1 problem is that --top-lines is useless without -vl2, so we
> should either check that this is specified. Or maybe better force
> verbose log internally without actually emitting it, probably it's
> better.
>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index 1ec5c4c47235..977ab54cba83 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -16,10 +16,12 @@
>>   #include <sys/stat.h>
>>   #include <bpf/libbpf.h>
>>   #include <bpf/btf.h>
>> +#include <bpf/hashmap.h>
> well, great for veristat in kernel repo, but this is libbpf-internal
> thing and I'd like to avoid relying on it in veristat to make Github
> sync simple.
>
>>   #include <libelf.h>
>>   #include <gelf.h>
>>   #include <float.h>
>>   #include <math.h>
>> +#include <linux/err.h>
>>
>>   #ifndef ARRAY_SIZE
>>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>> @@ -179,8 +181,16 @@ static struct env {
>>          int files_skipped;
>>          int progs_processed;
>>          int progs_skipped;
>> +       int top_lines;
>> +       bool include_insn;
>>   } env;
>>
>> +struct line_cnt {
>> +       long cnt;
>> +       char *line;
>> +       char *insn;
>> +};
>> +
>>   static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
>>   {
>>          if (!env.verbose)
>> @@ -206,6 +216,8 @@ const char argp_program_doc[] =
>>   enum {
>>          OPT_LOG_FIXED = 1000,
>>          OPT_LOG_SIZE = 1001,
>> +       OPT_TOP_LINES = 1002,
>> +       OPT_INCLUDE_INSN = 1003,
>>   };
>>
>>   static const struct argp_option opts[] = {
>> @@ -228,6 +240,9 @@ static const struct argp_option opts[] = {
>>            "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_FREQ program flag)" },
>>          { "test-reg-invariants", 'r', NULL, 0,
>>            "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
>> +       { "top-lines", OPT_TOP_LINES, "N", 0, "Emit N the most frequent C source code lines." },
> "Emit N most frequent source code lines."
>
> Doesn't have to be C, in general.
>
> maybe let's call it "--top-src-lines" to be a bit more specific?
>
>> +       { "include-instructions", OPT_INCLUDE_INSN, NULL, OPTION_HIDDEN,
>> +         "If emitting the most frequent C source code lines, include their BPF instructions." },
>>          {},
>>   };
>>
>> @@ -337,6 +352,17 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>                          return -ENOMEM;
>>                  env.filename_cnt++;
>>                  break;
>> +       case OPT_TOP_LINES:
>> +               errno = 0;
>> +               env.top_lines = strtol(arg, NULL, 10);
>> +               if (errno) {
>> +                       fprintf(stderr, "invalid top lines N specifier: %s\n", arg);
>> +                       argp_usage(state);
>> +               }
>> +               break;
>> +       case OPT_INCLUDE_INSN:
>> +               env.include_insn = true;
>> +               break;
>>          default:
>>                  return ARGP_ERR_UNKNOWN;
>>          }
>> @@ -817,6 +843,24 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
>>          free(stats);
>>   }
>>
>> +static int line_cnt_cmp(const void *a, const void *b)
>> +{
>> +       const struct line_cnt **a_cnt = (const struct line_cnt **)a;
>> +       const struct line_cnt **b_cnt = (const struct line_cnt **)b;
>> +
>> +       return (*b_cnt)->cnt - (*a_cnt)->cnt;
>> +}
>> +
>> +static size_t str_hash_fn(long key, void *ctx)
>> +{
>> +       return str_hash((void *)key);
>> +}
>> +
>> +static bool str_equal_fn(long a, long b, void *ctx)
>> +{
>> +       return strcmp((void *)a, (void *)b) == 0;
>> +}
>> +
>>   static char verif_log_buf[64 * 1024];
>>
>>   #define MAX_PARSED_LOG_LINES 100
>> @@ -854,6 +898,120 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
>>          return 0;
>>   }
>>
>> +static char *parse_instructions(char *buf, char *buf_end)
>> +{
>> +       char *start = buf;
>> +
>> +       while (buf && buf < buf_end && *buf && *buf != ';') {
>> +               char *num_end = NULL;
>> +
>> +               strtol(buf, &num_end, 10);
>> +               if (!num_end || *num_end != ':')
>> +                       break;
>> +
>> +               buf = strchr(num_end, '\n');
>> +       }
>> +
>> +       return start == buf ? NULL : strndup(start, buf - start);
>> +}
>> +
>> +static int print_top_lines(char * const buf, size_t buf_sz)
>> +{
>> +       struct hashmap *lines_map;
>> +       struct line_cnt **lines_cnt = NULL;
>> +       struct hashmap_entry *entry;
>> +       char *buf_end;
>> +       char *line;
>> +       int err = 0;
>> +       int unique_lines;
>> +       int bkt;
>> +       int i;
>> +
>> +       if (!buf || !buf_sz)
>> +               return -EINVAL;
>> +
> let's make sure we don't call print_top_lines with not buffer instead ?
>
>> +       buf_end = buf + buf_sz - 1;
>> +       *buf_end = '\0';
> and buffer should be valid, so no need to zero-terminate it (verifier
> guarantees that)
>
>> +       lines_map = hashmap__new(str_hash_fn, str_equal_fn, NULL);
>> +       if (IS_ERR(lines_map))
>> +               return PTR_ERR(lines_map);
>> +
>> +       for (char *line_start = buf; line_start < buf_end;) {
>> +               char *line_end = strchr(line_start, '\n');
> any reason we can't use strtok_r() for this?
>
>> +
>> +               if (!line_end)
>> +                       line_end = buf_end;
>> +
>> +               if (*line_start == ';') {
> let's check that it starts with "; " with strncmp() and skip space as well?
>
>> +                       struct line_cnt *line_cnt;
>> +
>> +                       line_start++; /* skip semicolon */
>> +                       *line_end = '\0';
>> +                       if (hashmap__find(lines_map, line_start, &line_cnt)) {
>> +                               line_cnt->cnt++;
> so as I mentioned, I'd like to avoid the use of libbpf's hashmap. How
> about we just add each string's offset within the buffer into a
> (rather long sometimes) array of u32s. Then implement custom
> comparator that would compare actual strings within log buffer by its
> offset. Sort such indices this way, and then (reusing this comparator)
> implement "unique" operation just like std::unique. Then we'll only
> need to re-sort indices (but now taking their total counts), and emit
> first/last N items.
>
> Basically, keep it cheap by using offsets, but otherwise rely on NlogN
> sorting to avoid hashmaps.
>
>> +                       } else {
>> +                               char *insn = NULL;
>> +
>> +                               line_cnt = malloc(sizeof(struct line_cnt));
>> +                               if (!line_cnt) {
>> +                                       *line_end = '\n';
>> +                                       goto cleanup;
>> +                               }
>> +                               line = strdup(line_start);
>> +                               if (!line) {
>> +                                       *line_end = '\n';
>> +                                       free(line_cnt);
>> +                                       goto cleanup;
>> +                               }
>> +                               if (env.include_insn)
>> +                                       insn = parse_instructions(line_end + 1, buf_end);
>> +                               line_cnt->insn = insn;
>> +                               line_cnt->line = line;
>> +                               line_cnt->cnt = 1;
>> +                               err = hashmap__add(lines_map, line, line_cnt);
>> +                       }
>> +                       *line_end = '\n';
>> +
>> +                       if (err)
>> +                               goto cleanup;
>> +               }
>> +               line_start = line_end + 1;
>> +       }
>> +       unique_lines = hashmap__size(lines_map);
>> +       if (!unique_lines)
>> +               goto cleanup;
>> +
>> +       lines_cnt = calloc(unique_lines, sizeof(struct line_cnt *));
>> +       if (!lines_cnt)
>> +               goto cleanup;
>> +
>> +       i = 0;
>> +       hashmap__for_each_entry(lines_map, entry, bkt)
>> +               lines_cnt[i++] = (struct line_cnt *)entry->value;
>> +
>> +       qsort(lines_cnt, unique_lines, sizeof(struct line_cnt *), line_cnt_cmp);
>> +
>> +       printf("Top C source code lines:\n");
> nit: there is no need to say "C source code", it's just "source code"
>
>> +       for (i = 0; i  < min(unique_lines, env.top_lines); i++) {
>> +               printf("; [Count: %ld] %s\n", lines_cnt[i]->cnt, lines_cnt[i]->line);
> [Count: %ld] prefix is super verbose. Let's just emit a number of
> occurrences without any extra "Count" text.
>
> BTW, newer verifiers emit file location information now which looks
> like " @ test_vmlinux.c:82", it would be nice if we could detect that,
> parse it out separately (at the very last moment, during output) and
> reformat everything to something like:
>
> 123: (test_vmlinux.c:82) <the rest of source code line>
>
> Make sure to use something like %5d for frequency, so at least that
> part is nicely aligned
>
>> +               if (env.include_insn)
>> +                       printf("%s\n", lines_cnt[i]->insn);
>> +       }
>> +       printf("\n");
>> +
>> +cleanup:
>> +       hashmap__for_each_entry(lines_map, entry, bkt) {
>> +               struct line_cnt *line_cnt = (struct line_cnt *)entry->value;
>> +
>> +               free(line_cnt->insn);
>> +               free(line_cnt->line);
>> +               free(line_cnt);
>> +       }
> we really shouldn't be allocating so much for strings, we have one
> huge string and we should be dealing with indices into the buffer
>
> pw-bot: cr
>
>> +       hashmap__free(lines_map);
>> +       free(lines_cnt);
>> +       return err;
>> +}
>> +
>>   static int guess_prog_type_by_ctx_name(const char *ctx_name,
>>                                         enum bpf_prog_type *prog_type,
>>                                         enum bpf_attach_type *attach_type)
>> @@ -1048,6 +1206,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>                         filename, prog_name, stats->stats[DURATION],
>>                         err ? "failure" : "success", buf);
>>          }
>> +       if (env.top_lines)
>> +               print_top_lines(buf, buf_sz);
>>
>>          if (verif_log_buf != buf)
>>                  free(buf);
>> --
>> 2.46.0
>>


