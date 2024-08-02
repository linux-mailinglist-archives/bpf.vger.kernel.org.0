Return-Path: <bpf+bounces-36259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9730945727
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5041C22C6D
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3B208D7;
	Fri,  2 Aug 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckHE0sbW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364511EB4AE
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573746; cv=none; b=ncHTJpvWf5exZIWyb1eJF1Vz0GHy1RT/LdGNoO7t4mGFN/0V1eFhjmKMKIFHjAm9pXhB4I5x9+EbOUFMIbJwwGTZMwfI7Bnhi6kg0T0fnZ6rkNUCWZeU3fCRiJhGQNGm2q66x9QtR2JbtYh2hpyUvnqQWyJqGBuZScLz0L6m5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573746; c=relaxed/simple;
	bh=BVmhk7VqOp9olLiVWTnk6WRM/7wxou05bZRgEl812mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZma3aFdvIaw64aUFbFmd2sAAu7wrvBe0kAJVp3LV6H7VhMM40CdupXSkHkWdIbd2n48Xaok+fSL2hLncoVDiLcrh5lI1QS4h5omu7sJzgcW/v1RM8eFbZEUbC0ZEFcuqFQGA9Pz8bmYIJHLPmhR9v1WLz/ExSS8Vut5dq4JAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckHE0sbW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-68537c804feso30165707b3.0
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 21:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722573744; x=1723178544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uAlaJP+zvfl0H4LOXXNO/zRJHUT5bM0z9iVAh3u7FU=;
        b=ckHE0sbWOq1/E0fuSAjIHLAjYR2QPMeYLRiki5baF1bIt8AXjIm09EDFUrU2Z7O+DE
         +rciPe8+z1XHENcuvtTjsRv1V+BQI+mWSgfFCB/jZv0yUZkjByjxT4iSKxl3QagzhtaP
         x26OIAZwRqZXOVDPEW/Nxjjvm/HEm/VX+MJfDVJ1ZkjvHx8drpNLHwKTg1AuQbi4HbWF
         bxE54imp/s+jwJIFRQPB5z8Keh1pPkHnx1O2uU6h5JkdWgO08SH4EvxE+TOCqxxSCQCM
         nW5RqwXLokdG/5G0YY0usac9IjVSC9xI2uoeNV6JoEsQ7chu9tAn0QGFybiequvhyJPQ
         DZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722573744; x=1723178544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uAlaJP+zvfl0H4LOXXNO/zRJHUT5bM0z9iVAh3u7FU=;
        b=n3jCFyOIYyylPNkQg2Hz5jVio9H3p4bxSSc/U1eEepTdI7QY1BohMWu5zcIBg6RYGI
         pR6UahPmxQR87rv8gWZRUzVvaLPT9CZxL3PN9Iby4AdCxRrCzVMPSRqhPDAIxo8wANhz
         b8tSYnPf2SM286hPW5BVz+T7Aew4Rv+FMflyc0vsQxqPeSMg+wmOC+XtC9t9yBFMHjEt
         itruWT20QJUX8etSsomEGzVxDbOrSGNXbq1pylc/ckBwRc5pZ4bvWjRYw/pZ9zL2V1oR
         +/z/1/Mk0q1xKLRsK8YZyEyNH0xIQPF1VP43ct2pOtQvMsuQeRw9KpfNk7UiDmRzF2XL
         KCxQ==
X-Gm-Message-State: AOJu0Yx6K+ONsBjBe6AUe+oCq+CuUmz88899ToxnbRumDzaFQdcFkPpa
	SluY9iFGdI1ETl1Upl1OCrEDLhfouPzTb4aDSLxLgOUC2pxv26br
X-Google-Smtp-Source: AGHT+IEkU29GI4igOYEnT6rmBcyCb8ZV0cDRdci3czxEREWzW/OaOW7Lhmv1Fp4jhE35HiIQbjYInQ==
X-Received: by 2002:a81:9382:0:b0:62f:b282:9f02 with SMTP id 00721157ae682-68961130a54mr29256637b3.21.1722573744045;
        Thu, 01 Aug 2024 21:42:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10ed:40b:8a2e:9686? ([2600:1700:6cf8:1240:10ed:40b:8a2e:9686])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a136bfd11sm1319177b3.126.2024.08.01.21.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 21:42:23 -0700 (PDT)
Message-ID: <38e7c382-ee49-4e00-a5e0-c5ee098369fd@gmail.com>
Date: Thu, 1 Aug 2024 21:42:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
To: Stanislav Fomichev <sdf@fomichev.me>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-4-thinker.li@gmail.com> <ZqqmaXpz_xlc6ZJn@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZqqmaXpz_xlc6ZJn@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/24 14:02, Stanislav Fomichev wrote:
> On 07/31, Kui-Feng Lee wrote:
>> netns_new()/netns_free() create/delete network namespaces. They support the
>> option '-m' of test_progs to start/stop traffic monitor for the network
>> namespace being created for matched tests.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/network_helpers.c | 26 ++++++
>>   tools/testing/selftests/bpf/network_helpers.h |  2 +
>>   tools/testing/selftests/bpf/test_progs.c      | 80 +++++++++++++++++++
>>   tools/testing/selftests/bpf/test_progs.h      |  4 +
>>   4 files changed, 112 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
>> index a3f0a49fb26f..f2cf43382a8e 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>> @@ -432,6 +432,32 @@ char *ping_command(int family)
>>   	return "ping";
>>   }
>>   
>> +int make_netns(const char *name)
>> +{
> 
> [..]
> 
>> +	char cmd[128];
>> +	int r;
>> +
>> +	snprintf(cmd, sizeof(cmd), "ip netns add %s", name);
>> +	r = system(cmd);
> 
> I doubt that we're gonna see any real problems with that in the tests,
> but maybe easier to use apsrint and avoid dealing with fixed 128-byte
> string?

asprintf? Sure!

> 
>> +	if (r > 0)
>> +		/* exit code */
>> +		return -r;
>> +	return r;
>> +}
>> +
>> +int remove_netns(const char *name)
>> +{
>> +	char cmd[128];
>> +	int r;
>> +
>> +	snprintf(cmd, sizeof(cmd), "ip netns del %s >/dev/null 2>&1", name);
>> +	r = system(cmd);
>> +	if (r > 0)
>> +		/* exit code */
>> +		return -r;
>> +	return r;
>> +}
>> +
>>   struct nstoken {
>>   	int orig_netns_fd;
>>   };
>> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
>> index cce56955371f..f8aa8680a640 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.h
>> +++ b/tools/testing/selftests/bpf/network_helpers.h
>> @@ -93,6 +93,8 @@ struct nstoken;
>>   struct nstoken *open_netns(const char *name);
>>   void close_netns(struct nstoken *token);
>>   int send_recv_data(int lfd, int fd, uint32_t total_bytes);
>> +int make_netns(const char *name);
>> +int remove_netns(const char *name);
>>   
>>   static __u16 csum_fold(__u32 csum)
>>   {
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> index 95643cd3119a..f86d47efe06e 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
>> @@ -1074,6 +1074,86 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
>>   	return err;
>>   }
>>   
>> +struct netns_obj {
>> +	char nsname[128];
>> +	struct tmonitor_ctx *tmon;
>> +	struct nstoken *nstoken;
>> +};
>> +
>> +/* Create a new network namespace with the given name.
>> + *
>> + * Create a new network namespace and set the network namespace of the
>> + * current process to the new network namespace if the argument "open" is
>> + * true. This function should be paired with netns_free() to release the
>> + * resource and delete the network namespace.
>> + *
>> + * It also implements the functionality of the option "-m" by starting
>> + * traffic monitor on the background to capture the packets in this network
>> + * namespace if the current test or subtest matching the pattern.
>> + *
>> + * name: the name of the network namespace to create.
>> + * open: open the network namespace if true.
>> + *
>> + * Return: the network namespace object on success, NULL on failure.
>> + */
>> +struct netns_obj *netns_new(const char *name, bool open)
>> +{
>> +	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
>> +	int r;
>> +
>> +	if (!netns_obj)
>> +		return NULL;
>> +	memset(netns_obj, 0, sizeof(*netns_obj));
>> +
>> +	strncpy(netns_obj->nsname, name, sizeof(netns_obj->nsname));
>> +	netns_obj->nsname[sizeof(netns_obj->nsname) - 1] = '\0';
> 
> Same here. Seems easier to have "char *nsname" and do
> netns_obj->nsname = strdup(name) here. Trimming the name, in theory,
> is problematic because do do remove_netns(netns_obj->nsname) later
> on (with potentially trimmed name).

You are right!

> 
> But, again, probably not a huge deal in the selftests. So up to you on
> whether you want to address it or not.

