Return-Path: <bpf+bounces-65994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1EB2BFB2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9F172AB0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62417322C70;
	Tue, 19 Aug 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5/3vufQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD983112DF
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601247; cv=none; b=mJJ0wAWR+XuxYWEbqaOLpT3Ts2QjpzuVZ2hc8x5u+0XSBkKhWvAVhoznHbg2xfWG2RDe2dXlFXzhbtbMyihhwFGkfN50Xs9o4m06Cg9TP3IQDCYJgGIjUE1CTZG7AKgko37kWP6rqGQv4Y7Mc3UCgfKeEbEIgnIX3g+8V0ClKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601247; c=relaxed/simple;
	bh=skZ7RCZrnorJ/EZMG1jjvXPiC3m48ieEzKfmHv773sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D11YtnLy6Etm979Di6BFh94Ku5MJCSRYxg3uHL+y3hW+eRsWt3ey2Jrincdb5v4DoF+KPgoG29wWyHep0EWuJEZFGcqvpF1oejwPGrTgDBPGHrCmXDY8AWod6G8bj9Kj8EE/EwEtvOl3cU3AgFlqZtQ4lXxQ2DeuL79Vxz/YtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5/3vufQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9dc5c8ee7so3352440f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755601244; x=1756206044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwlzGXS3yBaMGKgzmo/tSpbKvn71vB/A5Lx9lZogcyQ=;
        b=B5/3vufQOADIlq+3k1D0PNETdVx4fCmg+bZHptOw4qYB5oOHwoSRjXg2MWPLEihYvJ
         ndvtgQhTPpAeZ0djRRuvGr5q8k1Z0879jZOPNbOGhAgcARcN2qPZpSZAvA2OcKKqcxNX
         fQhxPaBddfqr/TX6jqXWNhEmM21hm0G8gGNbXV7N96qyyF9WAZCE19MejhF+ut4Vvczs
         zFvkYSLygsGFUn+WNwHTbooqqectcD9g+7+NANdkcXePVLoJD7HQPkTW0/qMGJ4TBzLx
         p9CU26J82HBxoLSxQDdaOIsbN9tCX0zY3byzyVCYhOFwb2Uy517IWo8vMCV2Dxi63GVs
         SH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601244; x=1756206044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwlzGXS3yBaMGKgzmo/tSpbKvn71vB/A5Lx9lZogcyQ=;
        b=HY/QAQy0NVAj8QTAO1NnJlYgooda4Jyg5RHxTuS+sFLUxNdyk3/VVCJ4X7XsnA6tC6
         bLwDdIvJ29jR8T9YPPyY2Nl2ws98VBxriO/gOj71ooF70VT4E5bGG0y6YNUouargfu6w
         Fh3fYCOJE6K7TOw4kWhCILgMimoMrZggZ0vqorUO3B9e02NU5lWPVm6d7awQJsaawQRA
         a3VHOZJX+lIvggUfv+/M+AMnU16RTff1Drn1q3NlJDOjbfn+m4GxfMEawFK28lFOpauD
         qPR+gUb/kJq99yKIAdQmUEev6swnHva5vlpM9s5r00lvj5juwkIt3YlRQvodU/eatbPC
         LLtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3vQ8Fby3nWfASlGdvvCXEm1iW7f2hpIVdrwLP3iYG8v5lOY0DuIBiGiQuAbGOxIr8MwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwMss0uza6i8Pki0Ao3Ts2uG9UK49qqA+/N2fQ7O9naDF008i
	E0CsuazIfkwoBm26sjKxfk1hUIqAzxyxsbrSH24+9XvRC9+rWgsose7v
X-Gm-Gg: ASbGncvUHg/gXou3VcVf9qIE8RbJAhlBreVGZqCzj4E2iMNNXQyfJ8GfHhb0wOsykzV
	XMGfYynMJJQEzRW77RN1u8sSMSxK7qopeKZ9W4tLUFPMZwr5SQGWEDH70fr5eBtGGIbF4zmQVo2
	RnuGH5QQiwXiEatDlpJil0sfkUKR/r3sqmJdj3XIK/znjXAHnqPVJ8fnb99FIv1hfmso2Kv/sO8
	0vEE4VY3H2MkVMymHRyzwi35zQsAV5+rNkXLO00H96UPQqayT+6FsDamqftJw1bga6ZnFdkbhyW
	h7Ek7cD9OKMSWwATK073hzjXFAB6/rB3HLVOFfBj1kk1YU5i1Y5o+9kfnnyTjTBfoFpaiH29d8C
	yi6TM+n5uiwMp38QNolfCMJeqKQgnHZjavkC8gJIB2Av50asKyzczgis55Npo37B1Ka34QA==
X-Google-Smtp-Source: AGHT+IHIZvDAGj/RBHRNyf2Xj+LMpfP2h20vccoLmf1fRB12TF5b/18WNRYf7xPvLj1bP45GygRVEA==
X-Received: by 2002:a05:6000:4305:b0:3b7:8338:d219 with SMTP id ffacd0b85a97d-3c0dffac794mr1751653f8f.3.1755601244113;
        Tue, 19 Aug 2025 04:00:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4794:3655:9535:baee? ([2620:10d:c092:500::4:853d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d4393csm3262226f8f.17.2025.08.19.04.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 04:00:43 -0700 (PDT)
Message-ID: <2e84d77d-60e0-46cf-b755-4625db2df0fc@gmail.com>
Date: Tue, 19 Aug 2025 12:00:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add BPF program dump in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250818180424.58835-1-mykyta.yatsenko5@gmail.com>
 <4f5238d786e4393184b27abb58bcb5a87852819b.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <4f5238d786e4393184b27abb58bcb5a87852819b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 01:18, Eduard Zingerman wrote:
> On Mon, 2025-08-18 at 19:04 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index d532dd82a3a8..3ba06f532bfa 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -181,6 +181,12 @@ struct var_preset {
>>   	bool applied;
>>   };
>>   
>> +enum dump_mode {
>> +	NO_DUMP = 0,
>> +	XLATED,
>> +	JITED,
>> +};
>> +
>>   static struct env {
>>   	char **filenames;
>>   	int filename_cnt;
>> @@ -227,6 +233,7 @@ static struct env {
>>   	char orig_cgroup[PATH_MAX];
>>   	char stat_cgroup[PATH_MAX];
>>   	int memory_peak_fd;
>> +	enum dump_mode dump_mode;
>>   } env;
>>   
>>   static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
>> @@ -295,6 +302,7 @@ static const struct argp_option opts[] = {
>>   	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
>>   	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
>>   	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
>> +	{ "dump", 'p', "DUMP", 0, "Print BPF program dump" },
> Nit: describe that it should be either '-p xlated' or '-p jited'?
>
>>   	{},
>>   };
>>   
>> @@ -427,6 +435,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>   			return err;
>>   		}
>>   		break;
>> +	case 'p':
>> +		if (strcmp(arg, "jited") == 0) {
>> +			env.dump_mode = JITED;
>> +		} else if (strcmp(arg, "xlated") == 0) {
>> +			env.dump_mode = XLATED;
>> +		} else {
>> +			fprintf(stderr, "Unrecognized dump mode '%s'\n", arg);
>> +			return -EINVAL;
>> +		}
>> +		break;
>>   	default:
>>   		return ARGP_ERR_UNKNOWN;
>>   	}
>> @@ -1554,6 +1572,26 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
>>   	return 0;
>>   }
>>   
>> +static void dump(int prog_fd)
>                      ^^^^^^^^^^^
> 		    Nit: prog_id
>
>> +{
>> +	char command[512];
>> +	char buf[1024];
>> +	FILE *fp;
>> +
>> +	snprintf(command, sizeof(command), "bpftool prog dump %s id %d",
>> +		 env.dump_mode == JITED ? "jited" : "xlated", prog_fd);
>> +	fp = popen(command, "r");
> Silly question, would it be sufficient to just do "system()" and forgo
> the loop below?
yes, I guess it will be the same result.
>
>> +	if (!fp) {
>> +		fprintf(stderr, "Can't run bpftool\n");
>> +		return;
>> +	}
>> +
> Could you please insert some header (program name)/footer (newline)?
yes, sounds like a good idea.
>
>> +	while (fgets(buf, sizeof(buf), fp))
>> +		printf("%s", buf);
>> +
>> +	pclose(fp);
>> +}
>> +
>>   static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>>   {
>>   	const char *base_filename = basename(strdupa(filename));
>> @@ -1630,8 +1668,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>   
>>   	memset(&info, 0, info_len);
>>   	fd = bpf_program__fd(prog);
>> -	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
>> +	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
>>   		stats->stats[JITED_SIZE] = info.jited_prog_len;
>> +		if (env.dump_mode != NO_DUMP)
>> +			dump(info.id);
>> +	}
>>   
>>   	parse_verif_log(buf, buf_sz, stats);
>>   
> Note: below this hunk there is the following code:
>
>            if (env.verbose) {
>                    printf(format: "PROCESSING %s/%s, DURATION US: %ld, VERDICT: %s, VERIFIER LOG:\n%s\n",
>                           filename, prog_name, stats->stats[DURATION],
>                           err ? "failure" : "success", buf);
>            }
>
> It looks a bit strange, that program is printed before the above
> header is printed.
The header is printed with the verifier log. I think dump should go 
before it, probably with its own header,
as its probably not often used along with log.


