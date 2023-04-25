Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0D6EDBB5
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjDYGiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjDYGiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 02:38:00 -0400
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F7E9
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682404677; bh=AtnDc7pWa0CYdHFbae5uSVEe7HPDyHCYHPe7s+HzyVA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Qg4qMYVxAAs7QfO2aRdUElYa9EN+3tKzyg9WkhuNFglQRQPf0hvX4yXKvoAXCZeeq
         WuUbwNgKn8yiJ0HFA3t4BETYNsOOcvQcs6cp1y6kTCEHtRd20+8uJiUxXicSFewE1v
         kNzKMWBuETyRXUIXdKA6g06WO7WFTorRAoURcPMr33QA359sXfFJBNPXNw0Ze8dqSi
         jAS/jHn7lUfL2t59/XH+wf6E+7UxtbVbJHdQfO/v4HTBFOmTOxta3wjPtWqcZLFoR/
         DKMJIT8D0rF/Ar4HijgjnwHrpoDMGD51LAVvI9JAv3yj9t/laUVQfi1RnHyJWxsYS0
         4sgmmsz8Nfb9Q==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 8D2383A0C0D;
        Tue, 25 Apr 2023 06:37:53 +0000 (UTC)
From:   Xueming Feng <kuro@kuroa.me>
To:     yhs@meta.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuro@kuroa.me,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        quentin@isovalent.com, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for map_of_maps types
Date:   Tue, 25 Apr 2023 14:37:50 +0800
Message-Id: <20230425063750.72642-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <561b0f03-4a3a-89d3-5793-a0d69535ca0f@meta.com>
References: <561b0f03-4a3a-89d3-5793-a0d69535ca0f@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1LvcXIxTfN7FMPf-6mBsy-6lGA08URWM
X-Proofpoint-GUID: 1LvcXIxTfN7FMPf-6mBsy-6lGA08URWM
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1030 adultscore=0 phishscore=0 mlxlogscore=967
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304250060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>On 4/24/23 9:10 PM, Xueming Feng wrote:
>>> On 4/24/23 2:09 AM, Xueming Feng wrote:
>>>> When using `bpftool map dump` in plain format, it is usually
>>>> more convenient to show the inner map id instead of raw value.
>>>> Changing this behavior would help with quick debugging with
>>>> `bpftool`, without disrupting scripted behavior. Since user
>>>> could dump the inner map with id, and need to convert value.
>>>>
>>>> Signed-off-by: Xueming Feng <kuro@kuroa.me>
>>>> ---
>>>> Changes in v2:
>>>>     - Fix commit message grammar.
>>>> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
>>>> 	  `n` to `arg_size`.
>>>>     - Make `print_uint` able to take any size of argument up to `unsigned long`,
>>>> 		and print it as unsigned decimal.
>>>>
>>>> Thanks for the review and suggestions! I have changed my patch accordingly.
>>>> There is a possibility that `arg_size` is larger than `unsigned long`,
>>>> but previous review suggested that it should be up to the caller function to
>>>> set `arg_size` correctly. So I didn't add check for that, should I?
>>>>
>>>>    tools/bpf/bpftool/main.c | 15 +++++++++++++++
>>>>    tools/bpf/bpftool/main.h |  1 +
>>>>    tools/bpf/bpftool/map.c  |  9 +++++++--
>>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>>>> index 08d0ac543c67..810c0dc10ecb 100644
>>>> --- a/tools/bpf/bpftool/main.c
>>>> +++ b/tools/bpf/bpftool/main.c
>>>> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +void print_uint(const void *arg, unsigned int arg_size)
>>>> +{
>>>> +	const unsigned char *data = arg;
>>>> +	unsigned long val = 0ul;
>>>> +
>>>> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>>> +		memcpy(&val, data, arg_size);
>>>> +	#else
>>>> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
>>>> +		       data, arg_size);
>>>> +	#endif
>>>> +
>>>> +	fprintf(stdout, "%lu", val);
>>>> +}
>>>> +
>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>>    {
>>>>    	unsigned char *data = arg;
>>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>>> index 0ef373cef4c7..0de671423431 100644
>>>> --- a/tools/bpf/bpftool/main.h
>>>> +++ b/tools/bpf/bpftool/main.h
>>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>>    
>>>>    bool is_prefix(const char *pfx, const char *str);
>>>>    int detect_common_prefix(const char *arg, ...);
>>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>>    void usage(void) __noreturn;
>>>>    
>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>> index aaeb8939e137..f5be4c0564cf 100644
>>>> --- a/tools/bpf/bpftool/map.c
>>>> +++ b/tools/bpf/bpftool/map.c
>>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>>    		}
>>>>    
>>>>    		if (info->value_size) {
>>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>>> +			if (map_is_map_of_maps(info->type)) {
>>>> +				printf("id:%c", break_names ? '\n' : ' ');
>>> 1> +				print_uint(value, info->value_size);
>> 
>> On Mon, 24 Apr 2023 18:07:27 -0700, Yonghong Song wrote:
>>> For all map_in_map types, the inner map value size is 32bit int which
>>> represents a fd (for map creation) and a id (for map info), e.g., in
>>> show_prog_maps() in prog.c. So maybe we can simplify the code as below:
>>> 	printf("id: %u", *(unsigned int *)value);
>> 
>> That is true, maybe the "id" could also be changed to "map_id" to follow the
>> convention. Do you think that `print_uint` could be useful in the future?
>> If that is the case, should I keep using it here as an example usage, and to
>> avoid dead code? Or should I just remove it?

On Mon, 24 Apr 2023 22:58:10 -0700, Yonghong Song wrote:
> Maybe, "inner_map_id" is a better choice. For array of maps, some array 
> element value could be 0, implying "inner_map_id 0", but I think it is
> okay, people should know a real inner_map_id (or any map_id) should 
> never be 0.
> 
> Function "print_uint" is not needed any more. Please remove it.

Will reflect this in v3.

> 
> Please add the command line to dump map values triggering the above 
> change, also the actual dumps with and without this patch.

$ bpftool map dump id 138
Without patch:
```
key:
fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
27 16 06 00
value:
8b 00 00 00
Found 1 element
```
With patch:
```
key:
fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
27 16 06 00
inner_map_id:
139 
Found 1 element
```

>> 
>>>> +			} else {
>>>> +				printf("value:%c", break_names ? '\n' : ' ');
>>>> +				fprint_hex(stdout, value, info->value_size, " ");
>>>> +			}
>>>>    		}
>>>>    
>>>>    		printf("\n");
