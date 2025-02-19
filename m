Return-Path: <bpf+bounces-51909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2974A3B190
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655771890A90
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234381BBBDD;
	Wed, 19 Feb 2025 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNZ0cu5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2A1B87F1;
	Wed, 19 Feb 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946224; cv=none; b=LbAq7dudiOicWFa37MZZuJV6i9XytPQEFFiK7DVNMbMr9ZmrjZ2yi2IVsgHAph4mwdgCWsnBuZj5VeDlRHAnLkY0/FmoE6nAjeCfDv20lb/oupa/vnWto6eJcmivgAv9o5kugL9QeH7i50Ju0JYjXqGaTA+L0plq/U98LE6fe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946224; c=relaxed/simple;
	bh=g4fn69USjubabP/aaFEa1yeWpIt4/bfFB1okdWo3Dp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgGBCMQJIscgqqG0GK2dAPW02xbn99sHCaFDdpO2RbbBjZby80zgFANhOkHxdoR39RIyDIYqbjN/pqR6gbNbCsdl+duBHy95K/KgxrhikJcx5vcuNykwbuAb8DNsnxfknDlhMB2W+tUlRIhxPYab0wJN9rOk82v0Yo2TWRjiGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNZ0cu5z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so11935957a91.0;
        Tue, 18 Feb 2025 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946222; x=1740551022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzuJPp/o5P7UYg2+VQ3VISzpITM/125GEB4688KsCm0=;
        b=TNZ0cu5z7J3G2FTVQPTY/DKuWxKF+Oty+nZL8bJIPDwFHXNLUFFmtiB4Q2Fv76zgc+
         O9pLN6OXG0YT0Nd8hRNNCoaV/rbh+/RhT4bD+IaHki6PjLt1Q+4uqcp/t9+q2HoHj+uB
         7W+wNcGFXfd8XGQsbQIp8zooGKFfEe5GGVursqkpVfiS1/qqY3xwkm35DQaf+Rsj9yQl
         B3fY8OTqUkvfcJVPqFFLPGq7jYCmmtkC0Lj3jPnhdPaF0ZzzCPYfV/3XxFeQ9ZZ+b04j
         sn/J7ePoIFFJavHh6B3rCJqW1TvzSWPcw8xuZ4Qwyq0EhLef3X22vloCVMyAA1txHGvv
         3/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946222; x=1740551022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzuJPp/o5P7UYg2+VQ3VISzpITM/125GEB4688KsCm0=;
        b=NS0Jvj6pP36j07lyYLvmdWjhV/ZqZbMbVM8E4qsVtgoPZgMoI1/bTEfivVxU0xj+Yc
         9QS6sQ0/J+f2YGgH3duAqFOGYAkJRn0Em+pUnwRkMK2aM4G6Ek3N1PoP7e55rS5WeXmu
         btt55YzsfcygiOS0FR9Vi4a1FwXXQwnZqH6Qci4aZLc2nKusBD3uHoSQ4RJHuacaQAMN
         hQnkLw/Qh6hWpSr1lfdY8RzwlLAIFpV/DWISkg9Jp4HQ3j63eYrk0XA0kMEzwITeAJNC
         hxvvuHD5oTDYfu54Ao85cIMXVQ1IG/i1si+Mwx00fOrtbLdxFx798rId7nOryq+MPue7
         TniQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwyD5cPyi+7+bLvS2jyrLaBc0d3bknluEXWlbj6iuxsmISHqDRDLw1IiX0Zy0KM1XNeL0ami7W9H6o3kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIwuCuNLp3lLMxUMpAJNw04YMo1iGLrJgVboD4Ov2usPk/BAG
	1kVqij26CBqfbvQRDt6y7+HTi6AvcXDHFePjAvi0Z6ASG7FORaZf
X-Gm-Gg: ASbGncu+TxXZSc71Gx4qyopr9d9BOU0rvaPowlNb5FGXJkGFKNBe+1+zTyZG7iNhmWp
	Mg34nzqDxnSqH3JFJPtDfGPePyGmUKpUiqo2JrXJLEGcDBuwBV8V/EkUWMRfRNSYJGW+3YPDbLO
	f4ErSopIkr81BRt/tb2830YA1qGxIHMlERAJP8qTO61yD8dn2JyxDbf2suDP9agKBhYOlW+stAv
	iz93xyCPtAbW8QE4u8uWP+pMSYEuGGji6rjHPuMjaUeoqwQuwznnCSxLBnFLAPprvZoX2zImrli
	qvSVFMixNkzT2YMVbO36i5KcefwKKq4Jiw==
X-Google-Smtp-Source: AGHT+IHo/5/0ht8pdeC7qkzHv8YfKPz7ny4UAySp7z6Qsjptp8w1VopWzNuBH4QsBsSGagjgNKBLfA==
X-Received: by 2002:a17:90b:3886:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fcb5a17cdamr3728032a91.13.1739946222233;
        Tue, 18 Feb 2025 22:23:42 -0800 (PST)
Received: from [172.23.161.38] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53674b1sm98752675ad.98.2025.02.18.22.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 22:23:41 -0800 (PST)
Message-ID: <9df12336-ca00-4d45-a832-24203c334df7@gmail.com>
Date: Wed, 19 Feb 2025 14:23:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214141717.26847-1-chen.dylane@gmail.com>
 <88f0c25cc981f958e46d51560fbf6db7136a3fa0.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <88f0c25cc981f958e46d51560fbf6db7136a3fa0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/19 10:08, Eduard Zingerman 写道:
> On Fri, 2025-02-14 at 22:17 +0800, Tao Chen wrote:
>> Just wrap the direct err with libbpf_err, keep consistency
>> with other APIs.
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
> 
> While at it, I've noticed two more places that need libbpf_err() calls.
> Could you please check the following locations:
> 
> bpf_map__set_value_size:
>    return -EOPNOTSUPP;       tools/lib/bpf/libbpf.c:10309
>    return err;               tools/lib/bpf/libbpf.c:10317

Will change it. Thanks

> 
> ?
> 
> Other than that, I agree with changes in this patch.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 

I use a simple script, other places may also should be added:

9727 line: return NUL; (API:libbpf_bpf_attach_type_str)
9735 line: return NULL; (API: libbpf_bpf_link_type_str)
9743 line: return NULL; (API: libbpf_bpf_map_type_str)
9751 line: return NULL; (API: libbpf_bpf_prog_type_str)
10151 line: return NULL; (API: bpf_map__name)
10458 line: return NULL; (API: bpf_object__prev_map)

-----------------------------------------------
#!/bin/python3
import re

LIBBPF_PATH="tools/lib/bpf/"

def process_functions(file_path, target_functions):
     """
     find return err fix
     Args:
         file_path: like libbpf.c btf.c etc.
         target_functions: libbpf APIS
     """
     with open(file_path, 'r') as file:
         lines = file.readlines()

     function_info = {func: {'start': None, 'end': None, 'code': []} for 
func in target_functions}

     in_target_function = False
     current_function = None

     for i, line in enumerate(lines):
         # check the start line
         for func in target_functions:
             if re.search(re.escape(func) + r'\s*\(', line):
                 if ' __' in line:
                     continue
                 if '=' in line:
                     continue
                 if 'if' in line:
                     continue
                 if ';' in line:
                     continue
                 if '*' in func:
                     continue
                 in_target_function = True
                 current_function = func
                 function_info[func]['start'] = i
                 function_info[func]['code'].append(line)
                 break

         # check return err in target function
         if in_target_function and current_function:
             function_info[current_function]['code'].append(line)
             if re.search(r'\breturn\b', line):
                 # check return
                 if not re.search(r'\breturn\s+0\b', line):  # return 0 
ignore
                     if not re.search(r'libbpf_err|libbpf_ptr', line):
                         print(f"code should fix at {i + 1} line: 
{line.strip()} (API: {current_function})")

             # check function end line
             if re.search(r'}', line):
                 function_info[current_function]['end'] = i
                 in_target_function = False
                 current_function = None  # Reset for the next function


def extract_libbpf_apis(map_file):
     """
     extract APIS from libbpf.map
     Args:
         map_file (str): libbpf.map。
     Returns:
         list: libbpf APIs。
     """
     functions = []
     inside_global_section = False

     with open(map_file, 'r') as f:
         for line in f:
             line = line.strip()
             if ';' in line and 'LIBBPF' not in line:
                 functions.append(line.replace(';',''))

     return functions

map_file = "tools/lib/bpf/libbpf.map"
input_files = ["libbpf.c",
                "btf.c",
                "bpf_prog_linfo.c",
                "btf_dump.c",
                "btf_iter.c",
                "btf_relocate.c",
                "elf.c",
                "features.c",
                "gen_loader.c",
                "hashmap.c",
                "libbpf_probes.c",
                "linker.c",
                "netlink.c",
                "nlattr.c",
                "relo_core.c",
                "usdt.c",
                "zip.c",
                "str_error.c",
                "strset.c"]

target_functions = extract_libbpf_apis(map_file)
print(f"Target functions extracted: {target_functions}")

for input_file in input_files:
     print(f"===========check file:{input_file}=============")
     process_functions(LIBBPF_PATH + input_file, target_functions)

-- 
Best Regards
Dylane Chen

