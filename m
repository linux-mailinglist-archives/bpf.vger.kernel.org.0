Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5AC6EDFD6
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjDYJ6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjDYJ6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 05:58:35 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 02:58:18 PDT
Received: from ms11p00im-hyfv17291101.me.com (ms11p00im-hyfv17291101.me.com [17.58.38.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA70CC0C
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682416361; bh=BOZclCrFL8zwBZy00LVQJcyJUAB/39k6Slgpaa2Yfls=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=EIKOR67wtHzOc2RXSaFO9NM8zbl4/gqZ2ljixm0sHFwhri5Xbx7nfDPGtWbfTfkyg
         2i3Oyt0eW2nfgmi3ImizkYA+oz5Z6pQJp+YyPj0piLZger0/rko7Vru5pQCiBn3lwd
         xKb1J23Q8BgrkRsjDwgO6kyFuvS/RmexK+rJ3BFsW7LMK9PvCcezewvf5Q9F683ggl
         lnY3wIFIST0sLeeDxwMmbpoSpg/prj0rJ0v1xktPR/n56b0Qhd7kcyTYKM7gFeS1GN
         uRNFUBAHv4BF4dlDNM51HkR0AyQ6srIGO7L2h8c2ScoUMu37g2TSYHOdrTR4myfU43
         CSpzzLq2hAS9A==
Received: from localhost.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-hyfv17291101.me.com (Postfix) with ESMTPSA id E0A02760171;
        Tue, 25 Apr 2023 09:52:36 +0000 (UTC)
From:   Xueming Feng <kuro@kuroa.me>
To:     quentin@isovalent.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuro@kuroa.me,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, yhs@meta.com
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for map_of_maps types
Date:   Tue, 25 Apr 2023 17:52:21 +0800
Message-Id: <20230425095221.20805-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <fa14348d-b7ce-2a0e-d0f6-387162621ae8@isovalent.com>
References: <fa14348d-b7ce-2a0e-d0f6-387162621ae8@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yvZ7oYU2RTPiIdpNNoooZvCjqegvm5QH
X-Proofpoint-ORIG-GUID: yvZ7oYU2RTPiIdpNNoooZvCjqegvm5QH
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1030 malwarescore=0 mlxlogscore=781 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304250088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>2023-04-25 14:37 UTC+0800 ~ Xueming Feng <kuro@kuroa.me>
>>> On 4/24/23 9:10 PM, Xueming Feng wrote:
>>>>> On 4/24/23 2:09 AM, Xueming Feng wrote:
>>>>>> When using `bpftool map dump` in plain format, it is usually
>>>>>> more convenient to show the inner map id instead of raw value.
>>>>>> Changing this behavior would help with quick debugging with
>>>>>> `bpftool`, without disrupting scripted behavior. Since user
>>>>>> could dump the inner map with id, and need to convert value.
>>>>>>
>>>>>> Signed-off-by: Xueming Feng <kuro@kuroa.me>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>>     - Fix commit message grammar.
>>>>>> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
>>>>>> 	  `n` to `arg_size`.
>>>>>>     - Make `print_uint` able to take any size of argument up to `unsigned long`,
>>>>>> 		and print it as unsigned decimal.
>>>>>>
>>>>>> Thanks for the review and suggestions! I have changed my patch accordingly.
>>>>>> There is a possibility that `arg_size` is larger than `unsigned long`,
>>>>>> but previous review suggested that it should be up to the caller function to
>>>>>> set `arg_size` correctly. So I didn't add check for that, should I?
>>>>>>
>>>>>>    tools/bpf/bpftool/main.c | 15 +++++++++++++++
>>>>>>    tools/bpf/bpftool/main.h |  1 +
>>>>>>    tools/bpf/bpftool/map.c  |  9 +++++++--
>>>>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>>>>>> index 08d0ac543c67..810c0dc10ecb 100644
>>>>>> --- a/tools/bpf/bpftool/main.c
>>>>>> +++ b/tools/bpf/bpftool/main.c
>>>>>> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>>>>>>    	return 0;
>>>>>>    }
>>>>>>    
>>>>>> +void print_uint(const void *arg, unsigned int arg_size)
>>>>>> +{
>>>>>> +	const unsigned char *data = arg;
>>>>>> +	unsigned long val = 0ul;
>>>>>> +
>>>>>> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>>>>> +		memcpy(&val, data, arg_size);
>>>>>> +	#else
>>>>>> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
>>>>>> +		       data, arg_size);
>>>>>> +	#endif
>>>>>> +
>>>>>> +	fprintf(stdout, "%lu", val);
>>>>>> +}
>>>>>> +
>>>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>>>>    {
>>>>>>    	unsigned char *data = arg;
>>>>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>>>>> index 0ef373cef4c7..0de671423431 100644
>>>>>> --- a/tools/bpf/bpftool/main.h
>>>>>> +++ b/tools/bpf/bpftool/main.h
>>>>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>>>>    
>>>>>>    bool is_prefix(const char *pfx, const char *str);
>>>>>>    int detect_common_prefix(const char *arg, ...);
>>>>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>>>>    void usage(void) __noreturn;
>>>>>>    
>>>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>>>> index aaeb8939e137..f5be4c0564cf 100644
>>>>>> --- a/tools/bpf/bpftool/map.c
>>>>>> +++ b/tools/bpf/bpftool/map.c
>>>>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>>>>    		}
>>>>>>    
>>>>>>    		if (info->value_size) {
>>>>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>>>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>>>>> +			if (map_is_map_of_maps(info->type)) {
>>>>>> +				printf("id:%c", break_names ? '\n' : ' ');
>>>>> 1> +				print_uint(value, info->value_size);
>>>>
>>>> On Mon, 24 Apr 2023 18:07:27 -0700, Yonghong Song wrote:
>>>>> For all map_in_map types, the inner map value size is 32bit int which
>>>>> represents a fd (for map creation) and a id (for map info), e.g., in
>>>>> show_prog_maps() in prog.c. So maybe we can simplify the code as below:
>>>>> 	printf("id: %u", *(unsigned int *)value);
>>>>
>>>> That is true, maybe the "id" could also be changed to "map_id" to follow the
>>>> convention. Do you think that `print_uint` could be useful in the future?
>>>> If that is the case, should I keep using it here as an example usage, and to
>>>> avoid dead code? Or should I just remove it?

On Tue, 25 Apr 2023 09:57:17 +0100, Quentin Monnet wrote:
> This makes me think we could also have something similar for prog_array
> maps (but not necessarily as part of your patchset).

Good idea, will take a look at that after finishing v3 patch, and possibly
make a separate patch for it. (This is my first time contributing, better keep 
it simple).

>> On Mon, 24 Apr 2023 22:58:10 -0700, Yonghong Song wrote:
>>> Maybe, "inner_map_id" is a better choice. For array of maps, some array 
>>> element value could be 0, implying "inner_map_id 0", but I think it is
>>> okay, people should know a real inner_map_id (or any map_id) should 
>>> never be 0.
>>>
>>> Function "print_uint" is not needed any more. Please remove it.
>> 
>> Will reflect this in v3.
>> 
>>>
>>> Please add the command line to dump map values triggering the above 
>>> change, also the actual dumps with and without this patch.
>> 
>> $ bpftool map dump id 138
>> Without patch:
>> ```
>> key:
>> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
>> 27 16 06 00
>> value:
>> 8b 00 00 00
>> Found 1 element
>> ```
>> With patch:
>> ```
>> key:
>> fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
>> 27 16 06 00
>> inner_map_id:
>> 139 
>> Found 1 element
>> ```

> Thanks! Please add those sample outputs to the commit description for
> v3. Can you please also add an example with JSON ("-p")?

Sure, will add them in v3! About json output, they are currently not touched
to avoid breaking scripts. I will add inner_map_id as a new field in v3 like the 
following patch.
https://lore.kernel.org/bpf/20230419003651.988865-1-kuifeng@meta.com/

> Quentin
