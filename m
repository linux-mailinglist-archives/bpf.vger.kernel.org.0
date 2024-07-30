Return-Path: <bpf+bounces-36070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF3941983
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 18:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C26286E9E
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A83146D6B;
	Tue, 30 Jul 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBsH9J0t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B88BE8
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357197; cv=none; b=R2K8ATK1hupgWud7XPDgtHEm6SKimur2UcGSBfZK/QYpYmr3YqQrX4wGOo3B2J9HPoO0N70RpQd5BQbL3kvSImw2m8f69A0GKYyjWRCxU3STmqRE2Xq2yl9dOn62rbGjhP2UdELdO0n9WOUpehy2WqMayr4C4yyN59caeTJBmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357197; c=relaxed/simple;
	bh=q4tZTJNUDE9/kYIg8+7p9Z77AZjx/rDe/x6zJrNCsQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlTXUU2gekhntqH6YPW9Kt6FPu+lQrj0MGQYd6PzJPTIqPzQ2BjpAt+fCcV1WbM5tMpF3EOY2kycPKjd2HBE3iFQqlx5cBNcTDOF7EZQkZq/JvZiPGKmK6JCnVLPngMQCNLDDwy6E6WJwm0v11+Mtnf2JW+Lvan25J7Q5H7D6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBsH9J0t; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65cd720cee2so32581877b3.1
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357195; x=1722961995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yATZ9Yr6M5yA75GZNnkUseD72JccJQZEr9px5vCuNgU=;
        b=DBsH9J0tqWXc2H6rBDUG6UtiUzhlLKoFnVgDZoc8AY9oGuRlTKuLRHmhX0Nk3gqzY1
         LA0qY7LlUdZdddIdp9xAZqT1eDAXMPpGLwalRAuqeAMPPlc5p9VwGxfUrJ6m9PtXqF97
         Q73fUXHnJCfjk9WFD+sXnUNICzuvLcFGzd682D9n4UzQ++xW/ZJGcAUtv5+8HLgR+kKe
         EAeNNpmRwRSEEs1NLVwrMIhKb0ABUmLthw7SY1PqWkuO+Et/zKUt9noCywXniLdqP/Fc
         ndtC/4k7OSa1ir4l186iRFHwRYuch0k8yVF+sffTFTyqybR4PbpFmwB4kvWoO/63iTwL
         DfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357195; x=1722961995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yATZ9Yr6M5yA75GZNnkUseD72JccJQZEr9px5vCuNgU=;
        b=jz/OPD/vOGZSx+9JrWv1u4UuWbDx/qn9VSILPAG9t4rlqDILe91+Ahy1CV9AOyD/EO
         RlSAd8caIgsyeMZQW6jx8lX2D7Yq9dCK4IBB6BHXpPjym3AJnlcjTJwVPx8T8CH+6WXf
         nKdgDxqOt7tJqvuMYgF229bzudqSlLK5pf4k3MgWLWD88VxJYGU2DSeLxYh7ZzdDu/A2
         TAwoKqSNLSrG3I7deFho8p8+NsvQkSkKUdLx+WYHXmRBfcGuT+e+hgFb6ZGt4YEygqrm
         51vMi0VtIJE7verQ1IFXu4Dj07xhvzs6RWQQ4ZFltIIpe0lMjRmNQYnFQqUlnHz1SRDw
         M+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKinJyJBytwpxh4JDjrFkGKJzsq0tJ/DN2PljRUvh/bH+wvFhrPQ8LKFzo/A5NMaCC54ncOsTK/8qzP4VfFdIVnl74
X-Gm-Message-State: AOJu0YwdmDVhz73zE6hbt2EoIRInvGQpXZX0niFA1z4IBDCTMnNz4LNJ
	+6xEB+oBTgDb/Fu1+ls9AQk3IIDZZ7t4XlUUy8pBybS4q1U1eWBN
X-Google-Smtp-Source: AGHT+IEMkknElQQIGnrfVYgo0+HBU7yIdI8d6gRoBZWx7BBnSn7ueLLPSuPIMb2XXx7UzJvyHgUxWA==
X-Received: by 2002:a0d:fd01:0:b0:63b:c16e:a457 with SMTP id 00721157ae682-67a069151f6mr121064127b3.13.1722357195187;
        Tue, 30 Jul 2024 09:33:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:18c9:70aa:517a:c04c? ([2600:1700:6cf8:1240:18c9:70aa:517a:c04c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024d9dsm26001057b3.79.2024.07.30.09.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:33:14 -0700 (PDT)
Message-ID: <ccd4c20a-84f4-4677-b4e5-c0028e6e6f5a@gmail.com>
Date: Tue, 30 Jul 2024 09:33:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: Monitor traffic for
 tc_redirect.
To: Geliang Tang <geliang@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
References: <20240730002745.1484204-1-thinker.li@gmail.com>
 <20240730002745.1484204-5-thinker.li@gmail.com>
 <7da1f071b59bebf6583844b79c72271cf4ab958d.camel@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <7da1f071b59bebf6583844b79c72271cf4ab958d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/30/24 02:43, Geliang Tang wrote:
> On Mon, 2024-07-29 at 17:27 -0700, Kui-Feng Lee wrote:
>> Enable traffic monitoring for the test case tc_redirect.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/tc_redirect.c    | 48 ++++++++++++++---
>> --
>>   1 file changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> index 327d51f59142..46d397c5c79a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>> @@ -68,6 +68,7 @@
>>   		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
>>   
>>   static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST,
>> NULL};
>> +static struct netns_obj *netns_objs[3];
>>   
>>   static int write_file(const char *path, const char *newval)
>>   {
>> @@ -85,29 +86,52 @@ static int write_file(const char *path, const
>> char *newval)
>>   	return 0;
>>   }
>>   
>> -static int netns_setup_namespaces(const char *verb)
>> +enum NETNS_VERB {
>> +	NETNS_ADD,
>> +	NETNS_DEL,
>> +};
>> +
>> +static int netns_setup_namespaces(enum NETNS_VERB verb)
>>   {
>>   	const char * const *ns = namespaces;
>> -	char cmd[128];
>> +	struct netns_obj **ns_obj = netns_objs;
>>   
>>   	while (*ns) {
>> -		snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb,
>> *ns);
>> -		if (!ASSERT_OK(system(cmd), cmd))
>> -			return -1;
>> +		if (verb == NETNS_ADD) {
> 
> Maybe better to keep "verb" parameter as "char *", and use
> 
> 		if (!strcmp(verb, "add"))
> 
> here instead?

I have no strong opinion here.
May I know why you think string is better here?

> 
>> +			*ns_obj = netns_new(*ns, false);
>> +			if (!*ns_obj) {
>> +				log_err("netns_new failed");
>> +				return -1;
>> +			}
>> +		} else {
>> +			if (!*ns_obj) {
>> +				log_err("netns_obj is NULL");
>> +				return -1;
>> +			}
>> +			netns_free(*ns_obj);
>> +			*ns_obj = NULL;
>> +		}
>>   		ns++;
>> +		ns_obj++;
>>   	}
>>   	return 0;
>>   }
>>   
>> -static void netns_setup_namespaces_nofail(const char *verb)
>> +static void netns_setup_namespaces_nofail(enum NETNS_VERB verb)
>>   {
>>   	const char * const *ns = namespaces;
>> -	char cmd[128];
>> +	struct netns_obj **ns_obj = netns_objs;
>>   
>>   	while (*ns) {
>> -		snprintf(cmd, sizeof(cmd), "ip netns %s %s >
>> /dev/null 2>&1", verb, *ns);
>> -		system(cmd);
>> +		if (verb == NETNS_ADD) {
>> +			*ns_obj = netns_new(*ns, false);
>> +		} else {
>> +			if (*ns_obj)
>> +				netns_free(*ns_obj);
>> +			*ns_obj = NULL;
>> +		}
>>   		ns++;
>> +		ns_obj++;
>>   	}
>>   }
>>   
>> @@ -1250,17 +1274,17 @@ static void test_tc_redirect_peer_l3(struct
>> netns_setup_result *setup_result)
>>   	({
>>                          \
>>   		struct netns_setup_result setup_result = { .dev_mode
>> = mode, };             \
>>   		if
>> (test__start_subtest(#name))
>>      \
>> -			if (ASSERT_OK(netns_setup_namespaces("add"),
>> "setup namespaces")) { \
>> +			if
>> (ASSERT_OK(netns_setup_namespaces(NETNS_ADD), "setup namespaces")) {
>> \
>>   				if
>> (ASSERT_OK(netns_setup_links_and_routes(&setup_result),  \
>>   					      "setup links and
>> routes"))                    \
>>   					test_ ##
>> name(&setup_result);                       \
>> -
>> 				netns_setup_namespaces("delete");                           \
>> +				netns_setup_namespaces(NETNS_DEL);
>>                          \
>>   			}
>>                          \
>>   	})
>>   
>>   static void *test_tc_redirect_run_tests(void *arg)
>>   {
>> -	netns_setup_namespaces_nofail("delete");
>> +	netns_setup_namespaces_nofail(NETNS_DEL);
>>   
>>   	RUN_TEST(tc_redirect_peer, MODE_VETH);
>>   	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
> 

