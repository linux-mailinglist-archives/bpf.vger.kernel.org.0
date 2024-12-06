Return-Path: <bpf+bounces-46267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4E9E6F4D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B401882140
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61400207DED;
	Fri,  6 Dec 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EniflkPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29896207DE3
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491790; cv=none; b=KQ7ltU5Q6fL2dxenru5+SqwlisnseJl5nBsDUSXsvUXKD68LgRpv/Pf2VrAhUtsWmdsCfW5nLDIMI+hidIRfkBnSosu5WVsSZgPs606L5ogCo2NkeXY/OOKbcxlJx8hmRlDt6OY3G8kqBCiWI4EfrZu0WvNq/FpCCILAR4bORKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491790; c=relaxed/simple;
	bh=fje2fHmsfrfmnc5cUl3ZATb3QX3v4SyX360qRrY1YcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iffGMbd4Rb+yZN7FVMIlNUFiEXinr8BounXCHGO6YFKFJef+sk8vE97fz+2NSFhJbJ296P8fCR9LUSY+n6ohY6chGMwycvi1eAI8Zz5CZ7QzBsYPVKayaMCHamG17chkf0VXnxozHbQGCnUfUXszHYT4m7b806UtZnWYtWA+Xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EniflkPr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa560a65fd6so360349066b.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733491787; x=1734096587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc4fw1HD5R7JliOrMw0utOzvaJyKuOXRKiJBH8cGep0=;
        b=EniflkPrpExL3a7x6ge9rpsJ0kqzcLP0qXSPl7TX8AFADNM/JVWPVctkLnJMW7oUho
         L9KUvi0fdSz4SBmHag+TB2DSeeMWrHsO0GwVgX/s/NrJB/5qJspkWcA/Sini8kS4Y8/l
         6bpEq/9jk8bom+YFaY0Q0mgifdgFefJXAYwmgztEMcpNEEAJdwhSjndZbnwCr28HQkdJ
         4thvFPIgL/Zaj3GMnR6PSi1fvJ78RW53gF1d1s21et0QjCO+bBhQLkR7RO0YSQ6EZz1R
         qJ2/E0vKFhv3n9VaF1qJu6vuvSvYI+YvQ+TIkpnENb/kd/xZ/TQ6RzBNfvEdMQbaNA5a
         2onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733491787; x=1734096587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc4fw1HD5R7JliOrMw0utOzvaJyKuOXRKiJBH8cGep0=;
        b=DSpJEVaPdswpPeidRLtG+L+o62UNh3pF5jCLcMpguBRGusTKchZIdVk6h5WxCiYwIH
         95cWILpwHO1I+1YzLPFGLXu8aygXjXwi1yQh+XsGd0LXhi9YtJP+X+CQbJK+V1z+/Irh
         sdegLi7DIB7ApYcORi91RyrGe49Ri1M20tRllCzb6SbBsU337i1VHYzidIC7FmqjpraJ
         rAdmsvBfAoPGvriF885UVgnn61ULDvl8sxgc8uwF1qnLxsSLHZ6m5UV9vF8waBrdyNGq
         asHqLD3mey8uP4gQk+aMxLqnOKS1REEed61fzizY4xAQ2D+EO7ZPsuNSLcGP7558svX3
         l3UQ==
X-Gm-Message-State: AOJu0Yy4OpkzuAIsK5RPyXZDYigzl0ie/mxJnDoUAiwdHmfiD9WAlr7l
	NkUAsPY1l2bA/nu2ZvmqCmd0m0o4acLmnLMgtn46yKPzcc4kw2bswDdiog==
X-Gm-Gg: ASbGncvXJ9/VTeZXdFJTkUD0Oon8/oL7Rtws2jMxbWui/J9jlCwovg+x6J5ymIopZNX
	tIWXeAeaaHWRY446mzSs1mS5Mg0PgMTtdAGLVjOSaorY7BbWeuovfr8KUtIy0uv0Al/OScJLUY6
	1xYuGsH59fU1Eoh7SKPTNmwkxloeztcygSF+jEMEVxa/9e//ff0fqxXrOd0FnXrfAyAIoROKct0
	t2I9mrfkikwOhoZOss8GnOeeHvVsP3tXZTgKFWD865NE6yHZOt14ja2OhxUnE3G9d6f+Q203Qcf
	s9R+DM4dvi+g6WRm5DNIG7REU4KGb/cQHQ==
X-Google-Smtp-Source: AGHT+IFwFKHcGcE1ecyuHMKUaacnWfFrhwKkf76cIpAzr9NI54wxrFZw96qaRstbgUgkgTMpeELU/g==
X-Received: by 2002:a17:906:8a4a:b0:aa6:19c9:ad0a with SMTP id a640c23a62f3a-aa637626ac8mr303922766b.29.1733491787234;
        Fri, 06 Dec 2024 05:29:47 -0800 (PST)
Received: from ?IPV6:2a02:8109:a302:ae00:6eb3:da82:a6be:6559? ([2a02:8109:a302:ae00:6eb3:da82:a6be:6559])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da21sm239486566b.33.2024.12.06.05.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 05:29:46 -0800 (PST)
Message-ID: <7f3209b0-5c4e-47d8-af95-ad88d4865818@gmail.com>
Date: Fri, 6 Dec 2024 13:29:45 +0000
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
>
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
>
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
I think it does include subprogs. I checked this by loading program:
`bpftool prog load test_subprogs.bpf.o /sys/fs/bpf/test_subprogs`
then print its jited code:
`bpftool prog dump jited name prog1 test_subprogs.bpf.o`
summed sizes across all functions and compared with veristat output:
```
File                 Program  Verdict Duration (us)  Insns  States  Prog 
size  Jited size
-------------------  -------  -------  -------------  ----- ------  
---------  ----------
test_subprogs.bpf.o  prog1    success            181     56 6         
54         333
```
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


