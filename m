Return-Path: <bpf+bounces-543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBD703182
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AB81C20C39
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4051DF4A;
	Mon, 15 May 2023 15:27:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D8C2FD
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:27:34 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A119AA
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 08:27:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FDvPQ4006035;
	Mon, 15 May 2023 08:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=IUh8Mi3reeISoj8M+TvlxmfkcMSd1aqJ9m9JdvaH4fY=;
 b=GbQAbGmTNSgGv87Z4MZ2X/z3J0NSGC2dyhsWzBwffbzdf00aqlqKe+f5LYO8MkO7tvgJ
 Hh2JYXJqqY2PQaSn8zXmbkAKah8fRxZLpVpLEEnmwvVIv7iVwDmZ+ny9QGctRcPv4wyB
 U2sWU6pk93TvJfV5yg5NxooM/r343EUXLErXTeGFxX+R3hxFWIqxNV1SS1eqVOqvGNZJ
 1TLRod+uIKUNR/XVBFLRqllolqIyrXpF/eVH3NmFzlNfXxrIWrRDHNBbuXyfdcvOtzBP
 PYNx9GGrLT+rOSKfihWfku80xM8Jux53baNhbDLnjr5d/jIT2bU8IKiaKibSRoCeMXm8 kQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj88rm55w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 May 2023 08:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gElTh5KYru50u4lmq1KrS8b6O5Aj2rV0AbUEGX9EljXQFkmH19MH3Qz+NHQwJwjtHPbuPnpHuFkA7wAefPIBMHVFyPnRbYWOlMCGgbiiOex8sgakL1wNB65QF43dahH6BqK4JokSG0vIrnjmqHuxug6D2pDPEy3LBay90+cETu098LvQxC/g14keVOMMiQJcToFmcQG84Es36ygH2ZtP/2dB2A7XRwS3TRulJp+dTbTaNXRNKeMk4uRCHq0vxiXuy0hEzArCKWfNjTeE9TqWpEXSWAFFlRzuxIQFC0k/fv1PzCktkZSVfc2oAHayLv76vO7F/y+vIwN92Iz+G6FtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNAhQIdg+wv+dvNzjzy9nhItRlPVTkWj1B9K2GCgCME=;
 b=D19zP/5sGfJcvntaVtlHw2adkO8+SCCjspUSAzQuLPlyeE29tvF/uM0dMyd3xL84Cl3cFW8JenpRBzs2dF59JoqTK1V34WGynp9oJccvY+i8kI7JSL6MxJxqZBvhEctxflQFldhLzLVtF9T1t+s1bvXm9nudHSGvdBTTxPp5XVjEGJJzgWX64H0+F+T3ey3ls1qQgKBiBcFszRV/dfLZ2m48rOLIPIIW8wZLaOIi6dkPAfUsDj2NtC0eoOc04Ocsj5v2cIqqdUxLosLaXAgiWv1R/4PN6mSWunY849wBblYWUGz0i6JJLIDdZ8l2UqGaWsGNab6K/nBpsiyakqKp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5921.namprd15.prod.outlook.com (2603:10b6:8:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:27:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:27:19 +0000
Message-ID: <5a57547e-6865-1026-60db-bb6b2ca70e34@meta.com>
Date: Mon, 15 May 2023 08:27:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu Bretelle <chantr4@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
 <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
 <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
 <75f39027fe1889cd69d01d439d558418cbd020a1.camel@linux.ibm.com>
 <d275bd5e-e468-c590-9a10-8230a9ad7daa@meta.com>
 <35094b7c6fbe9843638a3695d56a92e42f3cfe4c.camel@linux.ibm.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <35094b7c6fbe9843638a3695d56a92e42f3cfe4c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 311b34d3-4b52-483f-48be-08db5558ded8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7kHHepjWLl/7i3AqUBMnJbLcSZ+8A2epP6g3wH+zud5DY7cqImOcy5pyy99pbkXllGThOYzv1jzQXTi4qa3f6RluM6k7xWUy+GVXyiXwuJjB5ewOnw64uYVsC1WhZYCRS+KIF8zMOnlTCnZP3XOPdcQmJv7UsRsaBtrAQ1xbC4qb63E4ch1BkMLxJ0sTUiSWX8DAt7cdqcqY0cgKVxXu46n0y8GC0Ss0ET7mnNlq3hP5Rmu6XrgTnGgTLda5GjBnrEyf/wpeJZwcAe0I+KKM2d2Sgib42ujTGZOT4Ca+m8BhRb5nPihFGsFBRslhjv9GKEB68or449IfSFu1b8YdiyGdoBCMktpJCmv2l/xSvxJ0swo11RKHlKTBDRJY/GrD3hpTt2UfnhehM60Hm46UNaGugTFl+IX6m9qkihTWcDnztHIh41z84QUEnMhECXCrsl0r4+/TBYs/o6TtB1YY/xAnYbh5xPJpJ7PBf9/7MBVvWoshnLQ2rF/3QTyKLZqqfUOXdFjkOBl0Pl/lJuFaCO8BTeyEtukewSNI0vfJEY5u4RJPwzF3rYi5gIqoxg3nz4Gwx8JZNbYVmUoGFsf7TBAeWqQONDYDyOzccEMe92WdaqrfzVtT0wRCgt2XncNRasT0TcDfSplZk+fSZg02q1LQEjzpOoQXvQnKT5cmaL8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(31696002)(86362001)(54906003)(478600001)(36756003)(966005)(186003)(53546011)(6512007)(6486002)(6506007)(6666004)(316002)(38100700002)(41300700001)(66946007)(66476007)(66556008)(6916009)(4326008)(31686004)(5660300002)(30864003)(83380400001)(8936002)(2906002)(8676002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkpvOTFVTURCS0lpTkZpQmxMSlZqcjZhV1owT0VkUEQ0L1l4NlF1bTFocDhQ?=
 =?utf-8?B?NXVBMTdYQnh3bHJMYUt3RWs4Nng2Vm8wV0xmN1JYT05xMEdmTFlRSUxta2lR?=
 =?utf-8?B?bWFCRUE1LzlURmNwY01VOXR5c1c0TWxOUEEyRzIzeUdQWEYyS1NQRXJFdjBY?=
 =?utf-8?B?UXdlYVJzNXZoalUyS3lZMmR4bTJTMGZSeDRsRndtNlFkTWV1Y1A1clRyODBk?=
 =?utf-8?B?R3NreHVMSkxlT1k4cmJWeTBodlZ0SFE3OG4wZEdNRlp3QkdWNllmbjZDdTVn?=
 =?utf-8?B?YkZIRExlZkM1ek1STFhpSFRBRG1obFNqSnlBWExRWmpoS09VQzd2ODlrSHZs?=
 =?utf-8?B?eHhrMTYwdE9oOWNML2hZS2lGUXVMZS9JZE5KWjlLNVl4OUNHVFNMbDgreGF5?=
 =?utf-8?B?V040V0ZmN2lOQzN1UFRPK1lsVWh5Q3NLOTBFY1NIQVl4QVVWZVZjampvU3lp?=
 =?utf-8?B?TTEwMERZV25JQ0ptNFVoMEhPdzhUSDF2TmdxVGNjN3NKN3FHQ21ESzdFTnVv?=
 =?utf-8?B?cUU5NFZ5ei9wSXZFTGZQZU5MeUVYWWhTdi9MODJQZWthR3RrNjVSaUNuOXEr?=
 =?utf-8?B?QWIwMFk5L3pCUGtVYnNKeWNFNTJkS1VBbERMS1hIYWMrMGtEd3ZuK2JDUmRh?=
 =?utf-8?B?UGpSQ01TMEpjR21rcTJmRzBNMzNBNENjSWFCMkgxeG9ieFVOQkd5aEd3QnRu?=
 =?utf-8?B?cGVlODQ3ZWRvc085cWpLVWJMVUlTWkxoZUhyblpRV1ZJbGYzcVZkN016dlg3?=
 =?utf-8?B?MHpVbGhDa2g2WTRuYTkzamFHN2E3bkYrMlhET1BFOVRGMmM0bTlTVWZiOEtz?=
 =?utf-8?B?cFRueVkrNWhjNXExV1pxRW9QRC84UFJTdXhJclpJc3doMU1EQm9aMGFpSkU5?=
 =?utf-8?B?R09EeDlyMytrM1BIb2FXajRLbnluRkU2TVFYTmRWVVFyWVZKWjgvYktlUUpp?=
 =?utf-8?B?dzdjeWpiQUFsWkZxQ2kxbTlrOUh0WmsxZ20yeGhWa05ETlpVaXpXdCtxb04z?=
 =?utf-8?B?Sko3d29yS3NXKzhrZ24yZlpPci9ONnhSOHpRZ2U4NXF1SnpLc05JdDdVVk5y?=
 =?utf-8?B?UVFpZ2dzMUFPaVBrWGVnVDZwcVRZdWdVZ2pvVDdSWHgxV2Rkd2tLQno4Sk90?=
 =?utf-8?B?OVp6bDNaTEFIYWplVlVEYTIzeEhIZlY0ZDFjb05VZTBtSmhSZjFLVUdZbnFs?=
 =?utf-8?B?U3llaE0rUEtMV3FpN09MSmNvTXVSR3BMQ2YxeFYrMkNyYk9ZWWRuUXFFU1lX?=
 =?utf-8?B?OHJTaUtoUWRRdjNrcWE0alh5WWY3YVZLdTNRWjlnNlJRbDl1K0xaT2JlZUpP?=
 =?utf-8?B?RXoyY1pCSEJCRC9xcHBMWTAwOXBZalZFdmJWUitTanpGSjhjd2VLeklIRGhM?=
 =?utf-8?B?Y0hiNE0vTUxiTU4xOUQ1TXpuTjZNWTlDREgzd1FLWG9MZW5EUXY0UUpGeEVD?=
 =?utf-8?B?cGYxRGZNQ3J6Wm83Q054VGJYcmRFZEVLc1g0TWZTaUh1MjlGN2lYNnpkc3lN?=
 =?utf-8?B?TUg4WklvNGU5cW9uSC80SFRodHVSOEg0ZFBXYlFOUXZZaUI4ODZxZ2V2RnM4?=
 =?utf-8?B?T2dPZkRvZ01oSk1CeW55SDNkZStxMnFZRWRkNEwxZ2ttTjlMdm12Rzh4Z1dY?=
 =?utf-8?B?WFhiOGMzaEwxWDRwLzExLzc4dEkyOGNZVG1CVzVYd245UlM2WEhreU5MSFMw?=
 =?utf-8?B?VVZ6LzI2Y3JRcGdRSDJlUmZZV3BWTFk2Q3N5T3E3eEpzZ0VhckNxRERIZGI0?=
 =?utf-8?B?TFlKZE9kNjlWMEVXdUhYT0FPYy9CYlZDbUEwYm9VR3VJSnNSRFVMeFk0bGZY?=
 =?utf-8?B?emlqWGNyZlZkNkh5RnVvWWdMY01iQ2syVjFOcnA0MVNWbjRNYTlybFYzbk5u?=
 =?utf-8?B?WVNzMVhGRHp4ZlhBNTh2V1JsbThVY24ybXc1WXZvYTV3MU1JRStyVnB1S214?=
 =?utf-8?B?M2VCb1JTL3h0SFl5WW45R3NGS2MzeVJUdGtZUU9BdEhnY3JmYkd5L3NhOVlC?=
 =?utf-8?B?ajUyWU56NmMxNU1aRnZ3K3puYzlYeXE5R3kveElvcUZQMW1NajZDN3IrRGFU?=
 =?utf-8?B?cTZhVEhOTXRFelRMeENFSkRKRFgwM0R2dUNRSDk0aUFYeE5weC9EU2NBNHpr?=
 =?utf-8?B?WEJQekYyd3d5Q3cvbVZkalVGYVZUbmJpUE8vTDBaMjJpeUNhaDY1dGVaU1lK?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b34d3-4b52-483f-48be-08db5558ded8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:27:18.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njxuzVWI0RlRl5TLd8NkSNOpcCONwPNU/foryxOFvsd5yA60FeXH4iPbb+4VTRGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5921
X-Proofpoint-ORIG-GUID: IRhBv-YGtKtuggZcblWIlchEclDCkYzm
X-Proofpoint-GUID: IRhBv-YGtKtuggZcblWIlchEclDCkYzm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_12,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/15/23 12:55 AM, Ilya Leoshkevich wrote:
> On Sun, 2023-05-14 at 09:58 -0700, Yonghong Song wrote:
>>
>>
>> On 5/13/23 1:24 AM, Ilya Leoshkevich wrote:
>>> On Fri, 2023-05-12 at 21:13 -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
>>>>> On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
>>>>>> On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
>>>>>>> Hi, Ilya,
>>>>>>>
>>>>>>> BPF CI ([1]) detected a s390x failure when bpf program is
>>>>>>> compiled
>>>>>>> with
>>>>>>> latest llvm17 on bpf-next branch. To reproduce the issue,
>>>>>>> just
>>>>>>> run
>>>>>>> normal './test_progs -j'. The failure log looks like below:
>>>>>>>
>>>>>>> Notice: Success: 341/3015, Skipped: 29, Failed: 1
>>>>>>> Error: #191 sock_fields
>>>>>>>       Error: #191 sock_fields
>>>>>>>       create_netns:PASS:create netns 0 nsec
>>>>>>>       create_netns:PASS:bring up lo 0 nsec
>>>>>>>      
>>>>>>> serial_test_sock_fields:PASS:test_sock_fields__open_and_loa
>>>>>>> d 0
>>>>>>> nsec
>>>>>>>      
>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock
>>>>>>> _fie
>>>>>>> lds)
>>>>>>> 0
>>>>>>> nsec
>>>>>>>      
>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(ingress_read_soc
>>>>>>> k_fi
>>>>>>> elds
>>>>>>> )
>>>>>>> 0 nsec
>>>>>>>      
>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_port
>>>>>>> 0
>>>>>>> nsec
>>>>>>>       test:PASS:getsockname(listen_fd) 0 nsec
>>>>>>>       test:PASS:getsockname(cli_fd) 0 nsec
>>>>>>>       test:PASS:accept(listen_fd) 0 nsec
>>>>>>>      
>>>>>>> init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd)
>>>>>>> 0
>>>>>>> nsec
>>>>>>>      
>>>>>>> init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_f
>>>>>>> d) 0
>>>>>>> nsec
>>>>>>>       test:PASS:send(accept_fd) 0 nsec
>>>>>>>       test:PASS:recv(cli_fd) 0 nsec
>>>>>>>       test:PASS:send(accept_fd) 0 nsec
>>>>>>>       test:PASS:recv(cli_fd) 0 nsec
>>>>>>>       test:PASS:recv(accept_fd) for fin 0 nsec
>>>>>>>       test:PASS:recv(cli_fd) for fin 0 nsec
>>>>>>>      
>>>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cn
>>>>>>> t,
>>>>>>> &accept_fd) 0 nsec
>>>>>>>      
>>>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cn
>>>>>>> t,
>>>>>>> &cli_fd) 0 nsec
>>>>>>>       check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
>>>>>>> nsec
>>>>>>>       check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
>>>>>>> nsec
>>>>>>>       check_result:PASS:bpf_map_lookup_elem(linum_map_fd,
>>>>>>> READ_SK_DST_PORT_IDX) 0 nsec
>>>>>>>       check_result:FAIL:failure in read_sk_dst_port on line
>>>>>>> unexpected
>>>>>>> failure in read_sk_dst_port on line: actual 297 != expected
>>>>>>> 0
>>>>>>>       listen_sk: state:10 bound_dev_if:0 family:10 type:1
>>>>>>> protocol:6
>>>>>>> mark:0
>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>>>> src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::)
>>>>>>> dst_port:0
>>>>>>>       srv_sk: state:9 bound_dev_if:0 family:10 type:1
>>>>>>> protocol:6
>>>>>>> mark:0
>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>>>> src_port:51966 dst_ip4:7f000006(127.0.0.6)
>>>>>>> dst_ip6:0:0:0:1(::1)
>>>>>>> dst_port:38030
>>>>>>>       cli_sk: state:5 bound_dev_if:0 family:10 type:1
>>>>>>> protocol:6
>>>>>>> mark:0
>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>>>> src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
>>>>>>> dst_port:51966
>>>>>>>       listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295
>>>>>>> snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0
>>>>>>> mss_cache:536
>>>>>>> ecn_flags:0 rate_delivered:0 rate_interval_us:0
>>>>>>> packets_out:0
>>>>>>> retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0
>>>>>>> segs_out:0
>>>>>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
>>>>>>> bytes_acked:0
>>>>>>>       srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
>>>>>>> snd_ssthresh:2147483647
>>>>>>> rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
>>>>>>> mss_cache:32768
>>>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:272
>>>>>>> packets_out:0
>>>>>>> retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0
>>>>>>> segs_out:3
>>>>>>> data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
>>>>>>> bytes_acked:22
>>>>>>>       cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
>>>>>>> snd_ssthresh:2147483647
>>>>>>> rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
>>>>>>> mss_cache:32768
>>>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:925
>>>>>>> packets_out:0
>>>>>>> retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2
>>>>>>> segs_out:6
>>>>>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
>>>>>>> bytes_acked:2
>>>>>>>       check_result:PASS:listen_sk 0 nsec
>>>>>>>       check_result:PASS:srv_sk 0 nsec
>>>>>>>       check_result:PASS:srv_tp 0 nsec
>>>>>>>
>>>>>>> If bpf program is compiled with llvm16, the test passed
>>>>>>> according
>>>>>>> to
>>>>>>> a CI run.
>>>>>>>
>>>>>>> I don't have s390x environment to debug this. Could you
>>>>>>> help
>>>>>>> debug
>>>>>>> it?
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>       [1]
>>>>>>> https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8679080985?pr=224#step:6:7645
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> thank for letting me know.
>>>>>> I will look into this.
>>>>>>
>>>>>> Best regards,
>>>>>> Ilya
>>>>>
>>>>> In the meantime the issue was fixed by:
>>>>>
>>>>> commit 141be5c062ecf22bd287afffd310e8ac4711444a
>>>>> Author: Shoaib Meenai <smeenai@fb.com>
>>>>> Date:   Fri May 5 14:18:12 2023 -0700
>>>>>
>>>>>        Revert "Reland [Pipeline] Don't limit ArgumentPromotion
>>>>> to -
>>>>> O3"
>>>>>        
>>>>>        This reverts commit
>>>>> 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
>>>>>        
>>>>>        https://reviews.llvm.org/D149768    is causing size
>>>>> regressions
>>>>> for -
>>>>> Oz
>>>>>        with FullLTO, and I'm reverting that one while
>>>>> investigating.
>>>>> This
>>>>>        commit depends on that one, so it needs to be reverted as
>>>>> well.
>>>>
>>>> The transformtion "Don't limit ArgumentPromotion to -O3" is
>>>> temporarily
>>>> reverted. But it could be reverted again once the issue is
>>>> resolved.
>>>> So it is a good idea to resolve the issue in the kernel.
>>>>
>>>>>
>>>>> But looking at the codegen differences:
>>>>>
>>>>> $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-9]*://g
>>>>> fail.s)
>>>>>
>>>>> -pass.o:        file format elf64-bpf
>>>>> +fail.o:        file format elf64-bpf
>>>>>
>>>>> -00000000000002c8 <sk_dst_port__load_half>
>>>>> -       69 11 00 30 00 00 00 00 r1 = *(u16 *)(r1 + 48)
>>>>> +00000000000002c0 <sk_dst_port__load_half>
>>>>> +       54 10 00 00 00 00 ff ff w1 &= 65535
>>>>>            b4 00 00 00 00 00 00 01 w0 = 1
>>>>>            16 10 00 01 00 00 ca fe if w1 == 51966 goto +1
>>>>> <LBB6_2>
>>>>>            b4 00 00 00 00 00 00 00 w0 = 0
>>>>>
>>>>> This is what ArgumentPromotion is supposed to do, so that's
>>>>> okay so
>>>>> far. However, further down below we have:
>>>>>
>>>>>     Disassembly of section cgroup_skb/egress:
>>>>>
>>>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>>>> +       61 76 00 30 00 00 00 00 r7 = *(u32 *)(r6 + 48)
>>>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>>>            85 01 00 00 00 00 00 53 call sk_dst_port__load_word
>>>>>
>>>>> ...
>>>>>
>>>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>>>> +       74 70 00 00 00 00 00 10 w7 >>= 16
>>>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>>>            85 01 00 00 00 00 00 57 call sk_dst_port__load_half
>>>>>
>>>>> so there is no 16-bit load anymore, instead, the result from
>>>>> the
>>>>> earlier 32-bit load is reused. However, on BE these kinds of
>>>>> loads
>>>>> for this particular field are not consistent at the moment -
>>>>> see
>>>>> [1]
>>>>> and the previous discussions.
>>>>>
>>>>> De-facto we have the following results:
>>>>>
>>>>> - int load: 0x0000cafe
>>>>> - short load: 0xcafe
>>>>
>>>> So 'De-facto' means the above is the expected result.
>>>>
>>>>>
>>>>> On a consistent BE we should have rather had:
>>>>>
>>>>> - int load: 0x0000cafe
>>>>> - short load: 0
>>>>
>>>> What does 'consistent BE' mean here? Does it mean the expected
>>>> result from the source code itself?
>>>
>>> I should not have called the de-facto example "BE" at all: it's
>>> rather
>>> "mixed endianness" or "weird endianness" or something along these
>>> lines.
>>>
>>> On "consistent BE" or simply "BE" properties like
>>>
>>> *(uint32_t *)p = (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2);
>>>
>>> hold. This is currently not the case for bpf_sock.dst_port.
>>>
>>> We compile with -mbig-endian, so we promise to the compiler that
>>> the
>>> machine is big-endian, and the compiler expects the above to hold
>>> for
>>> any p. Unfortunately when p points to bpf_sock.dst_port, this is
>>> not
>>> the case.
>>
>> If I understand correctly, *(uint32_t *)p to get the
>> bpf_sock.dst_port
>> is for backward compatibility. But the real u32 read by compiler will
>> do (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2) which is not the
>> same as expected *(uint32_t *)p so we have problem here.
>>
>>>
>>> The property above is important for the correctness of the
>>> load/store
>>> tearing transformations. What we have here is not exactly tearing,
>>> but
>>> is quite close.
>>>
>>>>> Clang, of course, expects a consistent BE and optimizes around
>>>>> that.
>>>>>
>>>>> This was a conscious tradeoff Jakub and I have agreed on in
>>>>> order
>>>>> to
>>>>> keep the quirky behavior from the past. Given what's happening
>>>>> with
>>>>> Clang now, I wonder if it would be worth revisiting it in the
>>>>> name
>>>>> of
>>>>> consistency?
>>>>
>>>> If I understand correctly, I think the issue is
>>>>        r7 = *(u32 *)(r6 + 48)
>>>>        w7 >= 16
>>>>        w1 = w7
>>>>
>>>> after verifier, it is changed to
>>>>       r7 = *(u16 *)(r6 + <kernel offset>)
>>>>       w7 >= 16
>>>>       w1 = w7
>>>>
>>>> and the result after verifier rewrite is completely wrong.
>>>> Is it right?
>>>
>>> No, the verifier rewrite is correct.
>>> The sk_dst_port__load_word() part of the test succeeds.
>>>
>>> All these rewrites already work fine, they are correct and
>>> consistent.
>>> It's really just bpf_sock.dst_port that is special.
>>>
>>>> If this is the case, during verifier rewrite, if it is
>>>> big endian, say the user intends to load 4 bytes (from uapi
>>>> header)
>>>> while the kernel field is 2 bytes, in such cases, kernel
>>>> can still pretend to generate 4-byte load. For example,
>>>> for the above example, the code after verification could be:
>>>>       r7 = *(u16 *)(r6 + <kernel offset>)
>>>>       r7 <= 16
>>>>       w7 >= 16
>>>>       w1 = w7
>>>>
>>>> Hopefully, we won't have many such cases. Does this work?
>>>
>>> This would break the sk_dst_port__load_word() part of the test.
>>
>> This is a hack. This may work for this specific u16 case, but
>> yes, it won't work for u32 load case.
>>
>>>
>>>
>>>
>>> Above I asked whether we can resolve the inconsistency, but I
>>> thought
>>> about it and I don't see a way of doing it without breaking the
>>> ABI,
>>> which is at worst unacceptable, and at best a last resort measure.
>>>
>>> What do you think about marking bpf_sock.dst_port volatile?
>>> volatile
>>> should prevent tearing and similar optimizations, with which we
>>> have a
>>> problem here.
>>>
>>> We could also add a comment warning users not to cast away this
>>> volatile due to the quirk we have. And then we should adjust the
>>> test
>>> (making all casts volatile) to comply with this new warning.
>>
>> I did a little study on this. The main problem here for
>> static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
>> {
>>           __u16 *half = (__u16 *)&sk->dst_port;
>>           return half[0] == bpf_htons(0xcafe);
>> }
>>
>> Through some cross-function optimization by ArgumentPromotion
>> optimization, the compiler does:
>>      /* the below shared by sk_dst_port__load_word
>>       * and sk_dst_port__load_half
>>       */
>>      __u32 *word = (__u32 *)&sk->dst_port;
>>      __u32 word_val = word[0];
>>
>>      /* the below is for sk_dst_port__load_half only */
>>      __u16 half_val = word_val >> 16;
>>
>>      ... half_val passed into sk_dst_port__load_half ...
>>      return half_val == bpf_htons(0xcafe);
>>
>> Here, 'word_val = word[0]' is replaced by 2-byte load
>> by the verifier and this caused the trouble for later
>> sk_dst_port__load_half().
>>
>> I don't have a good solution here. The issue is exposed
>> as we have both u16 and u32 load for &sk->dst_port and
>> the compiler did some optimization with this.
>>
>> I would say this is an extreme corner case and we can just
>> fix in the source code like below:
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> index bbad3c2d9aa5..39c975786720 100644
>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> @@ -265,7 +265,10 @@ static __noinline bool
>> sk_dst_port__load_word(struct bpf_sock *sk)
>>
>>    static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
>>    {
>> -       __u16 *half = (__u16 *)&sk->dst_port;
>> +       __u16 *half;
>> +
>> +       asm volatile ("");
>> +       half  = (__u16 *)&sk->dst_port;
>>           return half[0] == bpf_htons(0xcafe);
>>    }
>>
>> Could you try whether the above workaround works or not?
>> If we want the code to be future proof for potential
>> cross-func optimization for these noinline functions, we
>> can add similar asm codes to all of
>> bool sk_dst_port__load_{word, half, byte}.
> 
> Hi,
> 
> this makes the issue go away, thanks.
> 
> However, I'm still concerned, because this only inhibits a certain
> optimization and does not address the underlying fundamental problem:
> we promise to clang that the in-kernel implementation of the eBPF
> virtual machine is big-endian, while in reality it's not. As compiler
> optimizations get more aggressive, we will surely see more of this.
> 
> Why not do this instead?
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1bb11a6ee667..3c9b535532ae 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6102,7 +6102,7 @@ struct bpf_sock {
>   	__u32 src_ip4;
>   	__u32 src_ip6[4];
>   	__u32 src_port;		/* host byte order */
> -	__be16 dst_port;	/* network byte order */
> +	volatile __be16 dst_port;	/* network byte order */
>   	__u16 :16;		/* zero padding */
>   	__u32 dst_ip4;
>   	__u32 dst_ip6[4];
> diff --git a/tools/include/uapi/linux/bpf.h
> b/tools/include/uapi/linux/bpf.h
> index 1bb11a6ee667..3c9b535532ae 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6102,7 +6102,7 @@ struct bpf_sock {
>   	__u32 src_ip4;
>   	__u32 src_ip6[4];
>   	__u32 src_port;		/* host byte order */
> -	__be16 dst_port;	/* network byte order */
> +	volatile __be16 dst_port;	/* network byte order */
>   	__u16 :16;		/* zero padding */
>   	__u32 dst_ip4;
>   	__u32 dst_ip6[4];
> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> index bbad3c2d9aa5..773ded84ac12 100644
> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> @@ -259,19 +259,19 @@ int ingress_read_sock_fields(struct __sk_buff
> *skb)
>    */
>   static __noinline bool sk_dst_port__load_word(struct bpf_sock *sk)
>   {
> -	__u32 *word = (__u32 *)&sk->dst_port;
> +	volatile __u32 *word = (volatile __u32 *)&sk->dst_port;
>   	return word[0] == bpf_htons(0xcafe);
>   }
>   
>   static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
>   {
> -	__u16 *half = (__u16 *)&sk->dst_port;
> +	volatile __u16 *half = (volatile __u16 *)&sk->dst_port;
>   	return half[0] == bpf_htons(0xcafe);
>   }
>   
>   static __noinline bool sk_dst_port__load_byte(struct bpf_sock *sk)
>   {
> -	__u8 *byte = (__u8 *)&sk->dst_port;
> +	volatile __u8 *byte = (volatile __u8 *)&sk->dst_port;
>   	return byte[0] == 0xca && byte[1] == 0xfe;
>   }
>   
> This also works, and as far as I'm concerned, this would be a proper
> fix for the underlying issue: we tell the compiler that it should never
> ever (with any of today's or future optimizations) try to be clever
> when accessing dst_port.

The above test_sock_fields.c change should work too.
I think the uapi change is not necessary. The key word 'volatile'
intends to avoid merging two or more identical loads together.
In this particular case, with only uapi changes, the
harmful transformation can still happen since the sk->dst_port
is indeed loaded only once.

The test_sock_fields.c change itself forces proper load
which is verifier friendly. So I suggest to have
test_sock_fields.c change only. My previously suggested
changes have the same effect, to preserve the verifier friendly
load.

> 
> Best regards,
> Ilya
> 
> 
>>>>> [1]
>>>>> https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com
> 

