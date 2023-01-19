Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2C67328B
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjASHe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 02:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjASHeo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 02:34:44 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB9A63097;
        Wed, 18 Jan 2023 23:34:33 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5bZoN010043;
        Wed, 18 Jan 2023 23:34:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kdfvpMhkO8cLnvwFwifzskoFTr/XyVS9hCwSRDuZGRo=;
 b=Xbsfsw7G9ZLvf2hwpL5hVuoKKix8JF3iyPykYc1na8r7LUlpBx8jLlgLxntUbM1K/Db3
 9iG5TKUfBC8BjHDtwZJCZA3j2AyJsLhRkWuCtIaTdKwC+fqiPpwAitV4hSJmhTcT/hgq
 sxZRE8VDQUrrb5nsfsPjBNCJ1xv/Z1I4/VccL9zFokUShz2pyHuevpBMilqQ/8uvzth2
 9pHT4xlGPyjUKKZ7wKiYHpvk9eFCMGGsnGSKPOgyWAR+OGc4QTGltCDRTG2PAmvPAl8X
 e7feqvsmVWDl0RXTmvokozFtvKe+12dnbGanU+GBXietcjsHbWYnb0fFq/gfWUVSyxfY eQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6ubvsx8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 23:34:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7CtUN0TY8sBcucS6/Erm/w93wzSz6e90EzmR+X1nq/ACBatrggSVwzqXJP7B3LfOmSCYJGAqXLUaLWkEtW4AcsL5hZpqX2E9he0TT93VWvs8JL55/andybI5a/gZ8xRhi222sexLI4zHgiGW8bGz+CYn5jWepOSgvv+TujRlpOGYFGzEHjE/ZQKJQSUwsmwa114MUJ7JLeXQ5UYwgKczRvMCzwMGr+j5nbBTnKqkGGgk08fJOyGR2cqz+1FS7l4VylvI0pLFV0AtgdBQ/Ii02XbO5uc+xRu7pT3SwlvcpHYyPzSNwvodd9QTviixBNM0qLV4lBfX8Oyi4lZalkRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WwGl+BAQhjXoXvlHa5s5LCKRjhxtWdmyFnF0L4x3Qw=;
 b=RhSGUuPryhIp1Tfk4lvCwDnAPnKE6RKaxJOzyb4nTmF/faGI7Gfz/WRBMyZy7Z5QUk0jr72jAuB2kdXDV7gzAcIk8I9TTdRWKEQ/+8XLeu50n2zI7ip2/M6IxOBgr46kuS9UdTYnQSI3CdUzGWr5aN4ObAY2Pc7GRCcoReOFl++8BtF98hpigLZRAm1wz/znSjpHEkKVBCdaseJIVCefWeTHzElirlg3v167l+pBfA+zJCzEfu6M3V3T/gp3SwfHWk5ZhN+/ZQzSNzjTDJlJP1RhkN30lN3NFzgOxqdTuZbA0isngvNdM/9kNNBnVwlQWxBJ3MylhCCjlfHnLJQhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY8PR15MB5578.namprd15.prod.outlook.com (2603:10b6:930:99::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 07:34:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 07:34:04 +0000
Message-ID: <4dc6a571-8564-b38c-31df-0d9741dfc592@meta.com>
Date:   Wed, 18 Jan 2023 23:34:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Peter Foley <pefoley2@pefoley.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <701abf4bbf5b7957a24d2f164c643e1d9f586fad.camel@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <701abf4bbf5b7957a24d2f164c643e1d9f586fad.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY8PR15MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f38143-9e68-4444-6394-08daf9ef8a9d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUQIrltbl7hiTyecmsO29Qwa5qh9rPx9AP4nbjO+VaV+y8GXsz+UA5/OAjmnKombrLQ+z7zeFxIX3Sg1uJ/QZuhxaDqePYMHAS4u+FJPLZLsb8c6PtUZ3gbZdCfZbqC7P2yxV+pkIWjq1q7xNCyUvByQCEoi3YSFZzjN8HeXHWP4f/TW24XtLapdnlhek92CffrNp2Nw4rB1dk9fmu8EDE7OBANdCuL9/OCa8ZRxrHW0bHVTesB4UaEqJQJMFlIxg8gk7G/F7jlI3hcrc6+Rq47hcC+duIjaDjzUmLMt62EQO+hxY8OtgxRIpU9peC7l65bUm3osE9WUbHib4REICJ2zoAzQa0oDo4n9RZ2vfil1fMLuGBVuC6kKme5NeuJmq/S0oING4DMQQEzAnXvQGKU7EsjXXRO27+7POWBKOVqdhnOcS7kf8b/Kh7NxaYSLHDkdMnwgx8c95434Oixw2kz2NOISzBEdMpBDxlPCLGkfeJp8ITJGa4P9dhxiq4LVPqROQ3TQANQbMO1i8lioS4DYyP5PgqtgaGps8NEeEnApNyVcDodeOpQCZTIDpcDB7tKNPsU51JHS4NgcSNdH2VnUlKEM9OIxTtDgy71BAQb8jZXZjKPojVN5RYbkq1Uo4EN6TABO3hc5iXU5iQncLRd+478HGDAvyddfv6C9Q9QVFAxqMsUx2B155Y5PdLFKoP5p3jJpOo4tuAQnn+8EzgqPYfF1/XjA1bK6Kfp/vhO8WRb8Nlc8Nk3qOUAXV/Dyr+QoA7WnAV2PYdist/I7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39850400004)(366004)(451199015)(86362001)(53546011)(6506007)(31696002)(6666004)(966005)(6486002)(478600001)(36756003)(8936002)(5660300002)(316002)(66556008)(66946007)(7416002)(66476007)(4326008)(8676002)(38100700002)(41300700001)(921005)(186003)(6512007)(2616005)(2906002)(83380400001)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhqeWdhQW12dmpxYTFjMDhES1VITENpRzJWT0MyamJ0ZmUyUDhyR0U0MERa?=
 =?utf-8?B?RzMybm5QdVZkUVRNY0RvSStiWG9pMVNreVFTWU5hSUF2TWdvMWpGWlFwdVM5?=
 =?utf-8?B?NGJpQit3MS9ZdnRlbnBCUThDZE8yL1FJTXVHVHJVb3Fnc2NWamphcUpsSUpl?=
 =?utf-8?B?YzNpVFlIdkQ3eUlhK2RLdDBTd0Z2RWdPd29KajV3cWI3eTJKZnZrU0J6bU8w?=
 =?utf-8?B?UEhLdG1EYmJhSkZZRDFyNHlqOGdVZVovSDI2U0ZUTzVFTmMzQmFJWGhCaUhT?=
 =?utf-8?B?UlV2OFpyQzNmWUVFZUR0NjNCendleW9nNzFzaHdCQUxHcE5SQkdtSzBjdFJB?=
 =?utf-8?B?K0JtV09VUFcvTDc0cXhIYXhDa0dmaVVBcHIxYXdHL01pSi9zbjBpd0JLT3Zt?=
 =?utf-8?B?MUtCY1BpVGkyZFM4MkcrTktMcW9EVnJxVk9ESHZGV0xBa3pxakthTjV6cnB3?=
 =?utf-8?B?cXQrRkM3RVZ4akgzNWZ0UGwxcVZibWRhWmRyRTRzRTFoSElRckJyNThqc0Js?=
 =?utf-8?B?aE1MdngzVFl0WVVnZS9PM0lXK0pvZmxkaTMrUC9SazlzcHdFUGZWbDB6V2Va?=
 =?utf-8?B?eVdvUSt6Q2x4WjRVNVpjZUpTNW9OUXZjaDY0emtJSlpsdDdwdFVnWmpLWUZL?=
 =?utf-8?B?OXFBanJEcjJqYStTNkJ0RVVPczgvVGFveTVGNUcxQjZCR2ZCOEhNVTNzcnNK?=
 =?utf-8?B?ZlhPYnJOMHVBTUVUMGFhU0FJNkdQbDVtV0pmRVl5cU1QY1FzdEw0NjNKUWFW?=
 =?utf-8?B?Qk5FTStNYURpMzBURE55SWd5UTdQNUNYaTVSbm51UmhGSTBSR1ZsM3NMZ1RU?=
 =?utf-8?B?dkZMZ1E4NzdRaXR5U1J2MXIxcmR0eXR2dkd6ZEl5RmRtTEpPTk5IRE5EcVgz?=
 =?utf-8?B?LzJDMXVjc1FDNytCaTB2Y3NSSEtnQWsyMVFBL1RKa1Z4Sy9tcnFjMlRJTDRs?=
 =?utf-8?B?Tnh2bHZIWTNvUXp4dGpqT2VHUGNFZ2xnenhHc3k0bys2RUVMRks0b1dZcWFr?=
 =?utf-8?B?d0V5ZHpJODAxejZ1TGpEa3NZSFJFbzdMZ0h0akhIWjJiQWxxRCt4bWwwcnQ5?=
 =?utf-8?B?aC9WTUZKL1hiM3dTMWZXWkFOUFNMUUM3QnNxOEg4dXBlcDVJMnZJSk9lWnNB?=
 =?utf-8?B?U1E5TDBNVi9KK2pDbXVFMzR3MTZXSFRLNlpPN1ZEU3o5Rjc5ZnFpdmduOHhl?=
 =?utf-8?B?ZmtxU1VDZ1BsSkJLd0VlaTZlZ1UzYmN6TWJESFhaa1VLOHlQaGdZUjB4ZmxQ?=
 =?utf-8?B?RGt5V21TaWR0QU9MUFNIRmc4V0hYb3F4cnVtLzBFb0JrMmtlNVJmTGdQMkc3?=
 =?utf-8?B?bE4zQ0U2aHVsY1FHOEhUbE5TUjB0RHNuSVYyaENKcm15MkhKd2pjaGJPTDZB?=
 =?utf-8?B?Z3k5RmgxUkdLb3NBWEMxS1dPenpFK0pTMmdHQlUvbFhtd3RCMktQTXBqdG9u?=
 =?utf-8?B?RjZhazl1TVgvYW01ek1Oa3hNN2dhYU16SmVqQ2hzK0plUHlyM0E3Y3BLcXds?=
 =?utf-8?B?MU9yZ0hSS0c0Zm1paS8vcm01TjIyUzQ2cDVObEZtTVBqejZuc1F0bjY4aEZN?=
 =?utf-8?B?SUFnWmw5RkgzV2g0em9vYWNUUXg5dVZkYXdOME1TeGZsdjQ0bmJMOGFVSjB5?=
 =?utf-8?B?TndJMmlEUnEzam5HVG9KNUhNaFdqYlY1OVduYzBLai81c1RzalViaHZYYXU4?=
 =?utf-8?B?RElQTHZkYWs0aDA5bkRRSkRWc09PRHA4ZitHVzk3VzF6SVpkd0svSTlVY3NR?=
 =?utf-8?B?S0RwdER6YjhicWJKVzBpTHFLT1lENGlFdXN5RStNWnVwdU1jVDFhSzlmSkJp?=
 =?utf-8?B?d0VLaFFXMVNWaFFCU1FXSzVjMHNaSWRaeGU5UVliS1liMFFGZ0Y4UndRc1I0?=
 =?utf-8?B?NWx5c3VHY2gvYXFQRndNZHM5L1dKRTM5cUZ2Q0VFVGhUeVc0Q0NybFdBRm95?=
 =?utf-8?B?TkMzdXp4N3c3R3N3Q00yNzl0VFluSngydWt6dS9CM3dwSWdkWG0rN2RCOENK?=
 =?utf-8?B?aktpNE9Oa3p0VGdnKzFKTk4rOXhheWFpMGhwRW9qa0FxQTArMGdnV2ZvbnhR?=
 =?utf-8?B?S2FGdDBkak42UXdycG91NkY4LzBmWmZnMWxWWHJUTmV2ekRBS25mOThnOGsw?=
 =?utf-8?B?UGJlM0VUSDJ0Mnc3Qml5MWtHWWNxV1FvTFVBRnc1anVGcUdGdWlaOE1ZaTZr?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f38143-9e68-4444-6394-08daf9ef8a9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 07:34:04.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBq3V91i8iCtCo2a0i7rEk7zDz8RoFNsUnROzRQzb2xTdvH+lz4TtJZdkBG3Zcl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5578
X-Proofpoint-GUID: -M9iWvRNBAuZIzdAku94vEEwvBJPJ2RF
X-Proofpoint-ORIG-GUID: -M9iWvRNBAuZIzdAku94vEEwvBJPJ2RF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/18/23 11:28 AM, Eduard Zingerman wrote:
> On Sat, 2023-01-14 at 18:00 -0500, Peter Foley wrote:
>> Avoid build errors on distros that force the stack protector on by
>> default.
>> e.g.
>>    CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
>> skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__stack_chk_fail' is not supported.
>> int iter(struct bpf_iter__task_file *ctx)
>>      ^
>> 1 error generated.
>>
>> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
>> ---
>>   tools/bpf/bpftool/Makefile    | 1 +
>>   tools/bpf/runqslower/Makefile | 5 +++--
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index f610e184ce02a..36ac0002e386f 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>>   		-I$(or $(OUTPUT),.) \
>>   		-I$(srctree)/tools/include/uapi/ \
>>   		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
>> +		-fno-stack-protector \
> 
> While working on clang patch to disable stack protector
> for BPF target I've noticed that there is an option to
> disable default configuration file altogether [1]:
> 
>    --no-default-config
> 
> Should we consider it instead of -fno-stack-protector
> to shield ourselves from any potential distro-specific
> changes?

Peter, could you help check whether adding --no-default-config works
in your environment or not?

> 
> [1] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-no-default-config
> 
>>   		-g -O2 -Wall -target bpf -c $< -o $@
>>   	$(Q)$(LLVM_STRIP) -g $@
>>   
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
>> index 8b3d87b82b7a2..f7313cc966a04 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
>>   	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
>>   
>>   $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
>> -	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
>> -		 -c $(filter %.c,$^) -o $@ &&				      \
>> +	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
>> +		 -fno-stack-protector 					\
>> +		 -c $(filter %.c,$^) -o $@ &&				\
>>   	$(LLVM_STRIP) -g $@
>>   
>>   $(OUTPUT)/%.o: %.c | $(OUTPUT)
>>
>> ---
>> base-commit: 97ec4d559d939743e8af83628be5af8da610d9dc
>> change-id: 20230114-bpf-918ae127b77a
>>
>> Best regards,
> 
