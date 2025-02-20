Return-Path: <bpf+bounces-52100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7AA3E609
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CFC18866E1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3D214210;
	Thu, 20 Feb 2025 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT71uikk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B202B9AA
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084216; cv=none; b=nMz2v90XHoasZ8/KNJP/ihVZuYnAbpcuc/eGIF4WniYUs61SzCltPEmMCKoSxGtj7N6bKdxJArMU1QjK4or31UzMeWJwWTc5cHXlj9MCGX3wXVyD9HHCNCQrpQKSWr1gzDArd9o31KLdHET5TrsMCidGBiWtGuYex4wZGQpPQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084216; c=relaxed/simple;
	bh=fLdNtRmGRrye0crg+DYBMKfCEMhJ0A3lhXhFPIkWJEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSOgxXzxVN0ciLM4Kv0TSvHyCeaOwHki5QFVepasoIpQZ7U7MBeueP1B1RmRO0N5svWU4lOlHCPPPuFh4S+3s5F6W6rY3p9DsbCwrDZ6G46Tb3wi4aXUO5st8+hGXka8awjrs1RexIks97lvr7jhBIR/y/GSrVhIbA1zMTxexhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT71uikk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3486062eso1144938f8f.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740084213; x=1740689013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xacpfgj50Xs5Q9EnqSFfPiFbS5saFaDXoyAYTyTNu9g=;
        b=UT71uikk3ZBSrCaMQ+Cq1+TlfuLmcMN9vxlJfB2hBW10f8q3qEChYVjeVTlcLr8pQY
         Dgk+Qvkpa8QQauLDfsX2UOOiUqc4JnoMo/9MrV9Dn4MczYqQLP/aQAzxqk0GH3DicDRw
         72BFT0XZiHKLHg2NAsxqDG9lUFHCMckb/BO1uZM1m9MiMQRmGD5rSr/k2P4k2/HMWN+h
         T4dmRZw4vg2HM/a4fM3FofTpDiPFb62PmIGFUsSn/WLt5q5J6MQIr8RFJ1X02LtQc3rs
         l0zgjM+kx75nozkhI+ZY9h0en1vDTmrG80sO32x+dZ4yLpEI8FTWeI0wgPQCRkgNCrtZ
         ftLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084213; x=1740689013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xacpfgj50Xs5Q9EnqSFfPiFbS5saFaDXoyAYTyTNu9g=;
        b=Gz71gg3fAT6wUG0520bSLKiOXA8ViKZqLIETVtkx1U+e/Fr0McgG8BwezR2oOE0JCl
         lmOuzN2GK5Awo2OzfKH3dnRqdrjRjCe2t50xkMNeZbVbTSIRxWC2meEqlsk/1IzVxwp/
         iaAMlzzFZ/WS1a1Nt3A1E1Q7AV3q+5DqwMxZx9AVzjeikyZpgFQVAJvt/x6QaWVsETRx
         GWOX+A1DH8mOeOZAAjD2QqhAN9GSjq+Nl7wrMk+/6imTkgOcwSqHYho+WgglMY201xYx
         UxEwTydmCFlilk+/HGfK6n8BTsgE+20lH6lQ930Yanmd10kM/LTQ4EyQ3cJ3HcePYvhP
         S28Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqnkKHanjcG5g/I0mcIr5eX8UfrX9YbBbM+NmEcBQGsEM9C+oAYQfSDx423j+74FJdnFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ArCFl+/6rYms1IXfWAyxxBGmjVUAx7kIhk9aCxjIlqoD3wgm
	7kYgjx8o0C4SPkEVSst8ixfnuun0uOjU2oBrR1bERdscT/a7YSkN
X-Gm-Gg: ASbGncvayXm5872AmnzA6OtA9wLlnT67A11s7E5gciuoUHSnKhDDUe3ypfOSXPIAc97
	lxX3vFji8fNmcSjl02h6+LSdWJ46vjXTtR+LSx3N9desMTv04sZAEyhPElHscuCuUyv50lEdZha
	bpl2+lcF3vA9ERIcovwAhs4VLML1pJDY8kZgTPvKbqH1AOooicExvfPBcjkDx35QCyYzVEl2zxB
	QGv5Cv2cvoVvV/FgONATocD3UHZJ5DwMx8gOx5RnRf6Gqw7Aj79buAw6YrC443EWAVzluhv3FvO
	8CtuZHXNbQxAj9SFk43pEzSdsV1fTBOg6jpcPPIc+S1o5Tt/qpVkt1DNj7QsjjKINf1egU214XP
	i9oiqIXyNiQs=
X-Google-Smtp-Source: AGHT+IHYcSdNIdhFhT6Fcx06UPAHntKy6fPzrZS13+EfWpSkUJ/J4HaCwUqhB95Swc/Gf9/u+AG5+g==
X-Received: by 2002:a05:6000:1448:b0:38d:da11:df19 with SMTP id ffacd0b85a97d-38f6f0b0c1cmr600291f8f.41.1740084213170;
        Thu, 20 Feb 2025 12:43:33 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm21691844f8f.33.2025.02.20.12.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:43:32 -0800 (PST)
Message-ID: <123f8ac5-934e-4f1e-bf24-d42b35794cca@gmail.com>
Date: Thu, 20 Feb 2025 20:43:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: introduce veristat test
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
 <20250219233045.201595-3-mykyta.yatsenko5@gmail.com>
 <efa9d618c13ab7f2108f3c739805313c10f9bf3a.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <efa9d618c13ab7f2108f3c739805313c10f9bf3a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 20:24, Eduard Zingerman wrote:
> On Wed, 2025-02-19 at 23:30 +0000, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introducing test for veristat, part of test_progs.
>> Test cases cover functionality of setting global variables in BPF
>> program.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
>> new file mode 100644
>> index 000000000000..eff79bf55fe3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> [...]
>
>> +static struct fixture *init_fixture(void)
>> +{
>> +	struct fixture *fix = malloc(sizeof(struct fixture));
>> +
>> +	if (access("./veristat", F_OK) == 0)
>> +		strcpy(fix->veristat, "./veristat");
>> +	/* for no_alu32 and cpuv4 veristat is in parent folder */
>> +	if (access("../veristat", F_OK) == 0)
>> +		strcpy(fix->veristat, "../veristat");
> Nit: 'else PRINT_FAIL("Can't find veristat binary");' ?
>
>> +
>> +	snprintf(fix->tmpfile, sizeof(fix->tmpfile), "/tmp/test_veristat.XXXXXX");
>> +	fix->fd = mkstemp(fix->tmpfile);
>> +	fix->sz = 1000000;
>> +	fix->output = malloc(fix->sz);
>> +	return fix;
>> +}
> [...]
>
>> +static void test_set_global_vars_from_file_succeeds(void)
>> +{
>> +	struct fixture *fix = init_fixture();
>> +	char input_file[80];
>> +	const char *vars = "var_s16 = -32768\nvar_u16 = 60652";
>> +	int fd;
>> +
>> +	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
>> +	fd = mkstemp(input_file);
>> +	if (!ASSERT_GE(fd, 0, "valid fd"))
>> +		goto out;
>> +
>> +	write(fd, vars, strlen(vars));
> Nit: 'syncfs(fd);' ?
Thanks, makes sense. I'll include these in the next version, along with 
CI failures fixes.
>> +	SYS(out, "%s set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
>> +	    fix->veristat, input_file, fix->tmpfile);
>> +	read(fix->fd, fix->output, fix->sz);
>> +	__CHECK_STR("_w=0x8000 ", "var_s16 = -32768");
>> +	__CHECK_STR("_w=0xecec ", "var_u16 = 60652");
>> +
>> +out:
>> +	close(fd);
>> +	remove(input_file);
>> +	teardown_fixture(fix);
>> +}
> [...]
>


