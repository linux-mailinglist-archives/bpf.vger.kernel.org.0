Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7658E12C
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiHIUei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiHIUeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 16:34:37 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99E45F5A;
        Tue,  9 Aug 2022 13:34:36 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLVvr-000Dzr-DD; Tue, 09 Aug 2022 22:34:31 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLVvr-000FAz-5k; Tue, 09 Aug 2022 22:34:31 +0200
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix vmtest.sh getopts
 optstring
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1660064925.git.dxu@dxuuu.xyz>
 <0f93b56198328b6b4da7b4cf4662d05c3edb5fd2.1660064925.git.dxu@dxuuu.xyz>
 <20220809181845.bkmrgogdgd3divfj@muellerd-fedora-PC2BDTX9>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8bb12b0c-8581-94eb-2852-00586a5d5092@iogearbox.net>
Date:   Tue, 9 Aug 2022 22:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809181845.bkmrgogdgd3divfj@muellerd-fedora-PC2BDTX9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26622/Tue Aug  9 09:53:52 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/9/22 8:18 PM, Daniel Müller wrote:
> On Tue, Aug 09, 2022 at 11:11:10AM -0600, Daniel Xu wrote:
>> Before, you could see the following errors:
>>
>> ```
>> $ ./vmtest.sh -j
>> ./vmtest.sh: option requires an argument -- j
>> ./vmtest.sh: line 357: OPTARG: unbound variable
>>
>> $ ./vmtest.sh -z
>> ./vmtest.sh: illegal option -- z
>> ./vmtest.sh: line 357: OPTARG: unbound variable
>> ```
>>
>> Fix by adding ':' as first character of optstring. Reason is that
>> getopts requires ':' as the first character for OPTARG to be set in the
>> `?` and `:` error cases.
>>
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>>   tools/testing/selftests/bpf/vmtest.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
>> index 976ef7585b33..a29aa05ebb3e 100755
>> --- a/tools/testing/selftests/bpf/vmtest.sh
>> +++ b/tools/testing/selftests/bpf/vmtest.sh
>> @@ -333,7 +333,7 @@ main()
>>   	local exit_command="poweroff -f"
>>   	local debug_shell="no"
>>   
>> -	while getopts 'hskid:j:' opt; do
>> +	while getopts ':hskid:j:' opt; do
>>   		case ${opt} in
>>   		i)
>>   			update_image="yes"
> 
> I tested with this change and it worked fine for me. One thing to consider
> pointing out more clearly in the description is that ':' as the first character
> of the optstring switches getopts to silent mode. The desire to run in this mode
> seems to have been there all along, as the script takes care of reporting
> errors.

I've added this description to the commit message as well for future reference
while applying. Thanks everyone!

> Acked-by: Daniel Müller <deso@posteo.net>
> 

