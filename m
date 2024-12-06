Return-Path: <bpf+bounces-46252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D69E6B21
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2337116AC24
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03731F472F;
	Fri,  6 Dec 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay6IaAYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E41F03F6
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478873; cv=none; b=UbI0xWBFra6fLLzdBYxFZHD9irBlspbWOOAeGloRf78MgZU5o/iX75jxRP7zbZZ+u/TIRix6v0ppFa6AFi+HIW0xRWg2RvuzItfx9t6GnE0hGVBvpgKAlq46eueDDKvksUEs3EH9OenAOA/85OVFMyVJBUqsV0FjkJpIY6QosOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478873; c=relaxed/simple;
	bh=AYCOp8q3qFsOzansaenIvZft+I/IVvrPBF29nRSP6KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abP8QhjbKYvbBSPm1pz6sDc3IrrSUoKaV9OFJo3P0+2XbkB/OssMYWiwNJCKwBZvzLhZewQ3HZsbqbmaJkR2t2Z/AGBf3xZGzS4d2MMptgd3SjdsdHBzkvnAvP0eJGCkCwAppBjY4pao2DycjR5T+Ch9R68Msdm23uoxKzCu6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay6IaAYV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso932822a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733478870; x=1734083670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkJCkLiqEwvdKuW/WlBJzLxtlOAiRycTFIk7A5r+Y4U=;
        b=ay6IaAYVdvIxmr0jtlO/QkWOvU5lZeuwWyxotvNPd8+JePo3i6QiSllCPrIJL3Y9EW
         h6joB+/9rMVRGNBFX9PNIM76WM0cG1ntG8tcZI4h1H55XZHwu7Um+m6ZJsMp+I9u8E4k
         ALUo65lRs5l4IUMBU16JBzQEcYpBxZ4Jv58lSkoG2cojgYA6latrQY1bg7iuwhvJ1Q+d
         QnZB6j91JMEQXtmPjIBGZpLj+PAGLXO7bVvaI6BQB0lmcpqR/cO151X8raDxPMIV9rKs
         +cpBWUx6AGTEFYE6Rjsgx8OYG0kjN0I1c3QlFScR2AiC6eB5jga0uipdJ8T1IWyGL8JC
         +C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478870; x=1734083670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkJCkLiqEwvdKuW/WlBJzLxtlOAiRycTFIk7A5r+Y4U=;
        b=j5xZXV5WJ8vIvFl6fBEFW3yf+K1FwSn5VfTOzJjdV4n9P4tJUc5YxhAQmsM8zDtSpY
         RLZu4y3o7wgtJmU0rlBJdgaBHUUtzrA8V2XLp8ullhwOGBc2lepzFSDM3/tBea8HwRE5
         rBb7PvpN32JB+OzF5uR7omQKEdSq7zkuGp5QWlys1P6u61Lu/eBS93SFr/tQq5faUtsn
         PKivNfjdGQupgEguOqWPr7yIWVW/xb8NDmFoE7OExG/iz5WyNuIaO4zRfg+YpXUdvkfg
         zyaE8ZNSIUklghIQngheOfb6nMu6ttpDcfE+uObdKTU2zkeNiu9ZCPa7IyhNMhRdA3T5
         JeLw==
X-Gm-Message-State: AOJu0YyUM+pgahFPyu1OCMsOqePHJ3f+tPtU0pjMupM2rMXPO0R/bR8C
	uwaeDJcgqlO4CxRP0vTz31JGIohoYC+pKUK2o8xvFr/AJ1st+DNk
X-Gm-Gg: ASbGnct5tlrjDuOYFDpkGUJmVJlvfignAqxft/28VPiF+QfJfWQhmVW4Uk7IInjzsVn
	u1drZKtONtMpGtrmszuJDsgEm/eCjGbh+cYekrmTO2n34CcPcnz5uIY+yuB5MMXFt5mgSbuk+9h
	orFyEKb53ydjtq1kHuSlFGWBg9slHqVUvR1hbnQ+7SCqRDJmtkbCKJ92430Tv+KJmLnwM4y3j1J
	QHpKtCpF1c0woxTrInlpfw5BtdiEhjmT26nFl90HPTTN7F2eat1zvUodFiNqReDhcWultzZVW3i
	HQuVgJQD/fjbubr4tRoUfk3piVMrC3Jt7Q==
X-Google-Smtp-Source: AGHT+IFvXBx3i4IO2P20TgnCjFEYa33n7KI1AWRhfQAXSUDUxGht+SgnKGFyFxHw75wf4gE03HE8nw==
X-Received: by 2002:a05:6402:4307:b0:5d2:723c:a568 with SMTP id 4fb4d7f45d1cf-5d3be67ce20mr1591467a12.10.1733478869536;
        Fri, 06 Dec 2024 01:54:29 -0800 (PST)
Received: from ?IPV6:2a02:8109:a302:ae00:6eb3:da82:a6be:6559? ([2a02:8109:a302:ae00:6eb3:da82:a6be:6559])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62608f57fsm215179766b.146.2024.12.06.01.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:54:28 -0800 (PST)
Message-ID: <ddab9633-3a62-4cf6-84fc-fcdec9b9d64b@gmail.com>
Date: Fri, 6 Dec 2024 09:54:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: add more stats into veristat
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20241205193404.629861-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbV-dt7vEmQ3yCdiVw5qBWE1WekY_Stoo+vf_3QUXOOgw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbV-dt7vEmQ3yCdiVw5qBWE1WekY_Stoo+vf_3QUXOOgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2024 23:50, Andrii Nakryiko wrote:
> On Thu, Dec 5, 2024 at 11:34 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Extend veristat to collect and print more stats, namely:
>> - program size in instructions
>> - jited program size
>> - program type
>> - attach type
>> - stack depth
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 51 +++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index e12ef953fba8..0d7fb00175e8 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -38,8 +38,14 @@ enum stat_id {
>>          FILE_NAME,
>>          PROG_NAME,
>>
>> +       SIZE,
>> +       JITED_SIZE,
>> +       STACK,
>> +       PROG_TYPE,
>> +       ATTACH_TYPE,
>> +
>>          ALL_STATS_CNT,
>> -       NUM_STATS_CNT = FILE_NAME - VERDICT,
>> +       NUM_STATS_CNT = ATTACH_TYPE - VERDICT + 1,
> this doesn't sound right, because PROG_NAME isn't a number statistics
I did not realize NUM_STATS_CNT means count of number statistics, now 
this makes sense, thanks.
>>   };
>>
>>   /* In comparison mode each stat can specify up to four different values:
>> @@ -640,19 +646,22 @@ static int append_filter_file(const char *path)
>>   }
>>
>>   static const struct stat_specs default_output_spec = {
>> -       .spec_cnt = 7,
>> +       .spec_cnt = 12,
>>          .ids = {
>>                  FILE_NAME, PROG_NAME, VERDICT, DURATION,
>> -               TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>> +               TOTAL_INSNS, TOTAL_STATES, PEAK_STATES, SIZE,
>> +               JITED_SIZE, PROG_TYPE, ATTACH_TYPE, STACK,
> I think SIZE or JITED_SIZE might be good candidates for default view,
> but not all of the above. I think we can also drop PEAK_STATES from
> default, btw.
>
>>          },
>>   };
>>
>>   static const struct stat_specs default_csv_output_spec = {
>> -       .spec_cnt = 9,
>> +       .spec_cnt = 14,
>>          .ids = {
>>                  FILE_NAME, PROG_NAME, VERDICT, DURATION,
>>                  TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>>                  MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
>> +               SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
>> +               STACK,
> this is fine, we want everything in CSV, yep
>
>>          },
>>   };
>>
>> @@ -688,6 +697,11 @@ static struct stat_def {
>>          [PEAK_STATES] = { "Peak states", {"peak_states"}, },
>>          [MAX_STATES_PER_INSN] = { "Max states per insn", {"max_states_per_insn"}, },
>>          [MARK_READ_MAX_LEN] = { "Max mark read length", {"max_mark_read_len", "mark_read"}, },
>> +       [SIZE] = { "Prog size", {"prog_size", "size"}, },
> drop "size" alias, it's too ambiguous?
>
>> +       [JITED_SIZE] = { "Jited size", {"jited_size"}, },
> this probably should be prog_size_jited or something like that (I
> know, verbose, but unambiguous)
>
>> +       [STACK] = {"Stack depth", {"stack_depth", "stack"}, },
>> +       [PROG_TYPE] = { "Program type", {"program_type", "prog_type"}, },
> let's drop "program_type", verbose
>
>> +       [ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
>>   };
>>
>>   static bool parse_stat_id_var(const char *name, size_t len, int *id,
>> @@ -853,13 +867,16 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
>>
>>                  if (1 == sscanf(cur, "verification time %ld usec\n", &s->stats[DURATION]))
>>                          continue;
>> -               if (6 == sscanf(cur, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
>> +               if (5 == sscanf(cur, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
> is this a preexisting bug? why we didn't catch it before?
Nothing is broken because of this, sscanf sets all 5 variables either 
way. Currently we continue ongoing iteration of the loop, instead of jumping
to the next immediately. We can drop these checks at all, it's not going 
to change correctness of this code.
>>                                  &s->stats[TOTAL_INSNS],
>>                                  &s->stats[MAX_STATES_PER_INSN],
>>                                  &s->stats[TOTAL_STATES],
>>                                  &s->stats[PEAK_STATES],
>>                                  &s->stats[MARK_READ_MAX_LEN]))
>>                          continue;
>> +
>> +               if (1 == sscanf(cur, "stack depth %ld", &s->stats[STACK]))
> heh, not so simple, actually. stack depth is actually a list of stack
> sizes for main program and each subprogram. Try
>
> sudo ./veristat test_subprogs.bpf.o -v
>
> stack depth 8+8+0+0+8+0
>
> so we have to make some choices here, actually... we either parse that
> and add up, and/or we parse all that and associate it with individual
> subprograms.
>
> I think we can start with the former, but the latter is actually
> useful and quite tricky for humans to figure out because that order
> depends on libbpf-controlled order of subprograms (which veristat can
> get from btf_ext, I believe). Not sure if we need/want to record
> by-subprog breakdown into CSV, but it would be useful to have a more
> detailed breakdown by subprog in some verbose mode. Let's think about
> that.
>
>> +                       continue;
>>          }
>>
>>          return 0;
>> @@ -1146,8 +1163,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>          char *buf;
>>          int buf_sz, log_level;
>>          struct verif_stats *stats;
>> +       struct bpf_prog_info info = {};
> this should be initialized with memset(0)
>
>> +       __u32 info_len = sizeof(info);
>>          int err = 0;
>>          void *tmp;
>> +       int fd;
>>
>>          if (!should_process_file_prog(base_filename, bpf_program__name(prog))) {
>>                  env.progs_skipped++;
>> @@ -1196,6 +1216,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>          stats->file_name = strdup(base_filename);
>>          stats->prog_name = strdup(bpf_program__name(prog));
>>          stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
>> +       stats->stats[SIZE] = bpf_program__insn_cnt(prog);
>> +       stats->stats[PROG_TYPE] = bpf_program__type(prog);
>> +       stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
>> +       fd = bpf_program__fd(prog);
>> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
>> +               stats->stats[JITED_SIZE] = info.jited_prog_len;
>> +
> please check that this is total length including all the subprogs
>
>>          parse_verif_log(buf, buf_sz, stats);
>>
>>          if (env.verbose) {
>> @@ -1309,6 +1336,11 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
>>          case PROG_NAME:
>>                  cmp = strcmp(s1->prog_name, s2->prog_name);
>>                  break;
>> +       case ATTACH_TYPE:
>> +       case PROG_TYPE:
>> +       case SIZE:
>> +       case JITED_SIZE:
>> +       case STACK:
>>          case VERDICT:
>>          case DURATION:
>>          case TOTAL_INSNS:
>> @@ -1523,12 +1555,21 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
>>                  else
>>                          *str = s->stats[VERDICT] ? "success" : "failure";
>>                  break;
>> +       case ATTACH_TYPE:
>> +               *str = s ? libbpf_bpf_attach_type_str(s->stats[ATTACH_TYPE]) ? : "N/A" : "N/A";
>> +               break;
>> +       case PROG_TYPE:
>> +               *str = s ? libbpf_bpf_prog_type_str(s->stats[PROG_TYPE]) ? : "N/A" : "N/A";
> let's not have x ? y ? z pattern, please do explicit outer if like we
> do for VERDICT
>
> pw-bot: cr
>
>> +               break;
>>          case DURATION:
>>          case TOTAL_INSNS:
>>          case TOTAL_STATES:
>>          case PEAK_STATES:
>>          case MAX_STATES_PER_INSN:
>>          case MARK_READ_MAX_LEN:
>> +       case STACK:
>> +       case SIZE:
>> +       case JITED_SIZE:
>>                  *val = s ? s->stats[id] : 0;
>>                  break;
>>          default:
>> --
>> 2.47.1
>>


