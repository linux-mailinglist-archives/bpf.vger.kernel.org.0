Return-Path: <bpf+bounces-12134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2577C83BE
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 12:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF21282D6D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89366125DE;
	Fri, 13 Oct 2023 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xq0nqzE6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C441107A4
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 10:52:01 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF67AD
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 03:51:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3507250a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697194315; x=1697799115; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=WRNUCHsw+3VMAZ+2Q57cjFAPNq03dg8xlsDmGlCajWE=;
        b=Xq0nqzE6/hBRx55lanKZUmF17KEcGLq2eNbBvV18LVnwLgi/t0mRPxUF1ZLg5kl0mo
         eIQTEOwNqyeSk3AO1Y7Ro0iOdPE5Y+WOwjYsAUP21Z4sYo2niaM+jDCPlH39CC/IC3SK
         PWhvDvOWuoxVMXsJfU7AXWbnEQnvL8uYa2kDiEEoJ2Ais53il921X4l4E4FTIVe6y5dx
         Cm1JUyDu8ZFQbveZzeOWXdrjH3vSOjfLn2HNcyxc64y4855GwCZsrQY1qwPpkOsVxKIQ
         d0oFvwrnqMiwmf1yGvAhEbvfrr91PucruVfFYmcmF2E2DE6d9NXEkntQYQj4BiTDPW92
         0vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194315; x=1697799115;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRNUCHsw+3VMAZ+2Q57cjFAPNq03dg8xlsDmGlCajWE=;
        b=fIRfj4plVPFd5UblPSWIVN3cijuV6eKMucEnjVAjCxcuiC2lHvdbsNRGQGrndkLgjF
         H+OqPJ0oK6oOuEiyw/icrZIoYxNXKYb4ACRdo2rIA9xcpPHfDuLg2oLDPCMyV/WdOtVW
         +MpRve9ERX0ksCmJbE1Uty8FXfADm40orlR3c1Atqq205f044kHPQ5ewNM+djnzQVjxW
         JIsR4o2GTN++ut7bjo0MEWGcy89AqLsWN+m/FZC638KFuwUMmhOYIw789qJq6tRh24on
         jQ0EghSWRqkYyxueTHa4OqkoTxqFIR5mUWcb9rbz2flnehJY6/nm8atUYywoO2VTLvUR
         SNGw==
X-Gm-Message-State: AOJu0YwqoXuufSHKDuUcXcofI0R3fvjOABpug4ERz8joO6+/u2CDkjZW
	hpbQxOnMzUvzQB+vfCTZbOZ8VQ==
X-Google-Smtp-Source: AGHT+IFaM6UTQ1nOKmPob3bZ1dFsf1q63bdao3C1SnDvINKVai4iQ/x0t4RBAyfjeBTKRUF6oGKLAg==
X-Received: by 2002:a05:6402:907:b0:53e:5f9:328b with SMTP id g7-20020a056402090700b0053e05f9328bmr3896173edz.2.1697194314850;
        Fri, 13 Oct 2023 03:51:54 -0700 (PDT)
Received: from cloudflare.com (79.184.153.26.ipv4.supernova.orange.pl. [79.184.153.26])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b0053629f43083sm11329277eds.57.2023.10.13.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:51:54 -0700 (PDT)
References: <cover.1696490003.git.geliang.tang@suse.com>
 <10920edc470974553e66e2391400dfa81ec03d47.1696490003.git.geliang.tang@suse.com>
 <1124e2ba-2856-41c7-713f-5a4b4ffd3ec5@linux.dev>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add
 pairs_redir_to_connected helper
Date: Fri, 13 Oct 2023 12:40:04 +0200
In-reply-to: <1124e2ba-2856-41c7-713f-5a4b4ffd3ec5@linux.dev>
Message-ID: <87zg0meqwm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 10:18 PM -07, Martin KaFai Lau wrote:
> On 10/5/23 12:21 AM, Geliang Tang wrote:
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -1336,32 +1336,22 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
>>   	}
>>   }
>>   -static void unix_redir_to_connected(int sotype, int sock_mapfd,
>> -			       int verd_mapfd, enum redir_mode mode)
>> +static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
>> +				     int sock_mapfd, int verd_mapfd, enum redir_mode mode)
>>   {
>>   	const char *log_prefix = redir_mode_str(mode);
>> -	int c0, c1, p0, p1;
>>   	unsigned int pass;
>>   	int err, n;
>> -	int sfd[2];
>>   	u32 key;
>>   	char b;
>>     	zero_verdict_count(verd_mapfd);
>>   -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
>> -		return;
>> -	c0 = sfd[0], p0 = sfd[1];
>> -
>> -	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
>> -		goto close0;
>> -	c1 = sfd[0], p1 = sfd[1];
>> -
>> -	err = add_to_sockmap(sock_mapfd, p0, p1);
>> +	err = add_to_sockmap(sock_mapfd, peer0, peer1);
>>   	if (err)
>>   		goto close;
>>   -	n = write(c1, "a", 1);
>> +	n = write(cli1, "a", 1);
>>   	if (n < 0)
>>   		FAIL_ERRNO("%s: write", log_prefix);
>>   	if (n == 0)
>> @@ -1376,16 +1366,34 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
>>   	if (pass != 1)
>>   		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>>   -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
>> IO_TIMEOUT_SEC);
>> +	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
>>   	if (n < 0)
>>   		FAIL_ERRNO("%s: recv_timeout", log_prefix);
>>   	if (n == 0)
>>   		FAIL("%s: incomplete recv", log_prefix);
>>     close:
>> -	xclose(c1);
>> -	xclose(p1);
>> -close0:
>> +	xclose(cli1);
>> +	xclose(peer1);
>> +}
>> +
>> +static void unix_redir_to_connected(int sotype, int sock_mapfd,
>> +			       int verd_mapfd, enum redir_mode mode)
>> +{
>> +	int c0, c1, p0, p1;
>> +	int sfd[2];
>> +
>> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
>> +		return;
>> +	c0 = sfd[0], p0 = sfd[1];
>> +
>> +	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
>> +		goto close;
>> +	c1 = sfd[0], p1 = sfd[1];
>> +
>> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
>> +
>> +close:
>>   	xclose(c0);
>>   	xclose(p0);
>>   }
>> @@ -1661,51 +1669,19 @@ static int inet_socketpair(int family, int type, int *s, int *c)
>>   static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
>>   				   enum redir_mode mode)
>>   {
>> -	const char *log_prefix = redir_mode_str(mode);
>>   	int c0, c1, p0, p1;
>> -	unsigned int pass;
>> -	int err, n;
>> -	u32 key;
>> -	char b;
>> -
>> -	zero_verdict_count(verd_mapfd);
>> +	int err;
>>     	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
>>   	if (err)
>>   		return;
>>   	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
>>   	if (err)
>> -		goto close_cli0;
>> -
>> -	err = add_to_sockmap(sock_mapfd, p0, p1);
>> -	if (err)
>> -		goto close_cli1;
>> -
>> -	n = write(c1, "a", 1);
>> -	if (n < 0)
>> -		FAIL_ERRNO("%s: write", log_prefix);
>> -	if (n == 0)
>> -		FAIL("%s: incomplete write", log_prefix);
>> -	if (n < 1)
>> -		goto close_cli1;
>> -
>> -	key = SK_PASS;
>> -	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
>> -	if (err)
>> -		goto close_cli1;
>> -	if (pass != 1)
>> -		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
>> +		goto close;
>>   -	n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
>> IO_TIMEOUT_SEC);
>> -	if (n < 0)
>> -		FAIL_ERRNO("%s: recv_timeout", log_prefix);
>> -	if (n == 0)
>> -		FAIL("%s: incomplete recv", log_prefix);
>> +	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
>>   -close_cli1:
>> -	xclose(c1);
>> -	xclose(p1);
>> -close_cli0:
>> +close:
>>   	xclose(c0);
>>   	xclose(p0);
>
> Patch 1 is applied. Thanks.
>
> In patch 2, the xclose() here is confusing after this change. It is also
> inconsistent from how other tests in sockmap_listen.c is doing it. c0/p0 and
> c1/p1 are opened here but only c0/p0 is closed here and c1/p1 is closed in the
> pairs_redir_to_connected() above instead.

I agree with Martin.

The refactoring idea itself is nice. But, I also find it surprising that
newly extracted pairs_redir_to_connected helper takes ownership of cli1
& peer1 FDs.

For me, ideally, we would start using the __cleanup__ attribute, like we
do now in the kernel code [1], to auto-close FDs on return. That would
make error recovery and resource release less verbose.

[1] https://elixir.bootlin.com/linux/v6.5/source/include/linux/cleanup.h

