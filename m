Return-Path: <bpf+bounces-63410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C6B06D31
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 07:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D774E70ED
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121EF270EBD;
	Wed, 16 Jul 2025 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nfy1ADgS"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792B134BD
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643740; cv=none; b=VcIhvNOVTaxMGWLtdii4tirqgiZ+Meg4oS/CsqsUdth2O6w4l1mkBe3Lux62UXMWhB+7zbT4rdeg03RYdM2z2fz+h3WeIxy0y9Y6+uAnnwn/5VdqXE+A1G2nZWu5UMsFeFTSsIUBPvHzZRq67d9njaW2wxtiKtvM/dXBYgF8KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643740; c=relaxed/simple;
	bh=VutHikv1pvEMGzxLE3PRw2qY+nMCiEHHyOZJtbI+ik4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU5ly68obOmAgtLbvtHTqxYrI6EjR1NPaF+6uCWqOzUQepD2PAqyl8Lp1o3q7xUFODmWvSxXuFhxliOVqAhjUDo9ZUVcHJhHM/gnQq7E24huX9hhnXO13ZbPelqy2d97/9hbDqntwOwQcazVBYgLRFhnFQV2OtzsBjNV6RN5wEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nfy1ADgS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9716ac8-b6b1-4524-8c94-2f7261f9b5cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752643726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyhZ/FnFe6rb1lJ+3cQ1tnL5rn/O/A2CII8bIqwgAEI=;
	b=nfy1ADgSrX3vI0IWtmxsIz3mEDMcMNgniXaLYdsFYXQZ+ZJSrsIwNcbcOhaUODUkhu92qC
	vdTp5gESXRpGAGbaPlaYpY/6ZQY9diwpP9gCYyOLzyNSuPlGEI6YXLppjUK33Ftzk8kVw/
	u3PnOyZflaFAHZhiDDD5wi8XcNTj5qg=
Date: Wed, 16 Jul 2025 13:28:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf/selftests: Add selftests for token
 info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715035831.1094282-1-chen.dylane@linux.dev>
 <20250715035831.1094282-2-chen.dylane@linux.dev>
 <CAEf4Bza8FVL55qLds5ZWaKuz5Hw_r+bwg-MeXWX9H7ZsA_8ZJw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4Bza8FVL55qLds5ZWaKuz5Hw_r+bwg-MeXWX9H7ZsA_8ZJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/16 05:51, Andrii Nakryiko 写道:
> On Mon, Jul 14, 2025 at 8:59 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> A previous change added bpf_token_info to get token info with
>> bpf_get_obj_info_by_fd, this patch adds a new test for token info.
>>
>>   #461/12  token/bpf_token_info:OK
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/token.c  | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
>> index cfc032b910c..a16f25bdd4c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/token.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
>> @@ -1047,6 +1047,36 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
>>
>>   #define bit(n) (1ULL << (n))
>>
>> +static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
>> +{
>> +       int err, token_fd = -1;
>> +       struct bpf_token_info info;
>> +       u32 len = sizeof(struct bpf_token_info);
>> +
>> +       /* create BPF token from BPF FS mount */
>> +       token_fd = bpf_token_create(mnt_fd, NULL);
>> +       if (!ASSERT_GT(token_fd, 0, "token_create")) {
>> +               err = -EINVAL;
>> +               goto cleanup;
>> +       }
>> +
>> +       memset(&info, 0, len);
>> +       err = bpf_obj_get_info_by_fd(token_fd, &info, &len);
>> +       if (!ASSERT_ERR(err, "bpf_obj_get_token_info"))
>> +               goto cleanup;
>> +       if (!ASSERT_EQ(info.allowed_cmds, bit(BPF_MAP_CREATE), "token_info_cmds_map_create"))
>> +               goto cleanup;
>> +       if (!ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_XDP), "token_info_progs_xdp"))
>> +               goto cleanup;
> 
> nit: there is no harm in just doing a few ASSERT_EQ() checks
> unconditionally, it's cleaner and more succinct (and either way you
> return err == 0 in this case)
>

It seems necessary to assign the err when ASSERT_EQ fails, will fix it 
in v3, thanks.

>> +
>> +       /* The BPF_PROG_TYPE_EXT is not set in token */
>> +       ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_EXT), "token_info_progs_ext");
>> +
>> +cleanup:
>> +       zclose(token_fd);
>> +       return err;
>> +}
>> +
>>   void test_token(void)
>>   {
>>          if (test__start_subtest("map_token")) {
>> @@ -1150,4 +1180,13 @@ void test_token(void)
>>
>>                  subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
>>          }
>> +       if (test__start_subtest("bpf_token_info")) {
>> +               struct bpffs_opts opts = {
>> +                       .cmds = bit(BPF_MAP_CREATE),
>> +                       .progs = bit(BPF_PROG_TYPE_XDP),
>> +                       .attachs = ~0ULL,
>> +               };
>> +
>> +               subtest_userns(&opts, userns_bpf_token_info);
>> +       }
>>   }
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

