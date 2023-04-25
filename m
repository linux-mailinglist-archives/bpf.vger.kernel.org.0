Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919E76EDB80
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjDYGJv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDYGJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 02:09:49 -0400
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FAAD2E
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682402986; bh=XRQW1cQRj3VpX+F0n3pPfIVgf/nwNr+TzcqKbgCJw6E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=PyyU4RGpFFdoAMp8XYQYnhDi7ZYYUSIGVU4R0HkdQwKErS/asPBb+EnVUg6rHOKiD
         aQGMDjRs2vilDax49Gc/tabEVrms4fYCUJL0YRVB+P6Hj6inLIaoharpPoRXYmU7UV
         BsNAv6qYWEYJvk622uCBmOkp9nwDhSKg6Qg323moSNbVEewWog9Dex28+yqVid3F9p
         siCzYMnYLBbjtL79CCxizHMP//aCAf5oxiks56fmkMkADa4k7LKBXUkZaO9V+of65J
         h8DcEBCfPVVHmLobGx8xEGF/Wk+cDx4MkPuIzlENE2j7piGSvqYvmsDJXNbCVm9vyv
         b/bIHl6ANujfw==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 6B2358023D;
        Tue, 25 Apr 2023 06:09:42 +0000 (UTC)
From:   Xueming Feng <kuro@kuroa.me>
To:     sinquersw@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuro@kuroa.me,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        quentin@isovalent.com, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for map_of_maps types
Date:   Tue, 25 Apr 2023 14:09:38 +0800
Message-Id: <20230425060938.51020-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <6353e12d-6fe6-f42b-4277-b32e2b2268a8@gmail.com>
References: <6353e12d-6fe6-f42b-4277-b32e2b2268a8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DSLQazJ2klkQkRozrq7pH5kxpU2KODMh
X-Proofpoint-GUID: DSLQazJ2klkQkRozrq7pH5kxpU2KODMh
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 clxscore=1030 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304250056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>On 4/24/23 20:58, Xueming Feng wrote:
>>> On 4/24/23 02:09, Xueming Feng wrote:
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
>> 
>> On Mon, 24 Apr 2023 09:44:18 -0700, Kui-Feng Lee wrote:
>>> Is it possible that arg_size is bigger than sizeof(val)?
>> 
>> Yes it is possible, I had the thought of adding a check. But as I mentioned
>> before the diff section, previous review
>> https://lore.kernel.org/bpf/20230421101154.23690-1-kuro@kuroa.me/ suggested that
>> I should leave it to the caller function to behave. If I were to add a check,
>> what action do you recommend if the check fails? Print a '-1', do nothing,
>> or just use the first sizeof(val) bytes?

On Mon, 24 Apr 2023 22:19:52 -0700, Kui-Feng Lee wrote:
> In the previous patch, it may have integer overflow, but it is never 
> buffer underrun.  This version uses memcpy and may cause buffer underrun 
> if arg_size is bigger than sizeof(val).  I would say that at least 
> prevent buffer underrun from happening.

Thanks for the advice! This function is pending remove in the next version of 
this patch. But I will remember this for future patches.

>>> +
>>> +	fprintf(stdout, "%lu", val);
>>> +}
>>> +
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>    {
>>>    	unsigned char *data = arg;
>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>> index 0ef373cef4c7..0de671423431 100644
>>> --- a/tools/bpf/bpftool/main.h
>>> +++ b/tools/bpf/bpftool/main.h
>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>    
>>>    bool is_prefix(const char *pfx, const char *str);
>>>    int detect_common_prefix(const char *arg, ...);
>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>    void usage(void) __noreturn;
>>>    
>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>> index aaeb8939e137..f5be4c0564cf 100644
>>> --- a/tools/bpf/bpftool/map.c
>>> +++ b/tools/bpf/bpftool/map.c
>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>    		}
>>>    
>>>    		if (info->value_size) {
>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>> +			if (map_is_map_of_maps(info->type)) {
>>> +				printf("id:%c", break_names ? '\n' : ' ');
>>> +				print_uint(value, info->value_size);
>>> +			} else {
>>> +				printf("value:%c", break_names ? '\n' : ' ');
>>> +				fprint_hex(stdout, value, info->value_size, " ");
>>> +			}
>>>    		}
>>>    
>>>    		printf("\n");
