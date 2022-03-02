Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1E4CB18E
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiCBVrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiCBVrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:47:23 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446896C1CC
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:46:40 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPWnt-00073N-SD; Wed, 02 Mar 2022 22:46:37 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nPWnt-000C3P-M0; Wed, 02 Mar 2022 22:46:37 +0100
Subject: Re: [PATCH v5 bpf-next] Small BPF verifier log improvements
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kernel-team@fb.com
References: <20220301222745.1667206-1-mykolal@fb.com>
 <20220302212302.y7ct3xgkpwu4dto3@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d4e589ac-db4d-b721-580c-120ee524084d@iogearbox.net>
Date:   Wed, 2 Mar 2022 22:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220302212302.y7ct3xgkpwu4dto3@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26469/Wed Mar  2 10:27:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/22 10:23 PM, Alexei Starovoitov wrote:
> On Tue, Mar 01, 2022 at 02:27:45PM -0800, Mykola Lysenko wrote:
>>   		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>>   		.matches = {
>> -			{6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{7, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{8, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{9, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{10, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
>> -			{11, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{12, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>> -			{13, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
>> -			{14, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
>> -			{15, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
>> +			{6, "R3_w=scalar(umax=255,var_off=(0x0; 0xff))"},
>> +			{7, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>> +			{8, "R4_w=scalar(umax=255,var_off=(0x0; 0xff))"},
>> +			{9, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>> +			{10, "R4_w=scalar(umax=510,var_off=(0x0; 0x1fe))"},
>> +			{11, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>> +			{12, "R4_w=scalar(umax=1020,var_off=(0x0; 0x3fc))"},
>> +			{13, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
>> +			{14, "R4_w=scalar(umax=2040,var_off=(0x0; 0x7f8))"},
>> +			{15, "R4_w=scalar(umax=4080,var_off=(0x0; 0xff0))"},
> 
> Sorry for the later review.
> Would "int" be more precise and less verbose than "scalar"?

Could work as well, although in many places today we make use of the term "scalar",
so developers might be more familiar with it (and more consistent towards the
verifier type internals).

Thanks,
Daniel
