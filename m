Return-Path: <bpf+bounces-654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946A7051F4
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D262814ED
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0128C39;
	Tue, 16 May 2023 15:20:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4034CEC
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:20:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DCC7A91
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 08:20:13 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDpG2D024541;
	Tue, 16 May 2023 08:20:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=esabHDvA7w7nYln9v0iYmIwoHuUXivlxmRxJfK+bv9o=;
 b=OnBSxgHB77VH8518IFAruXAq15SmbqWxuaKhp+mYD/FFBrWFCKbYpBGZSxqLoLu3V/Bv
 I8YJxK5BGoRXSngekSEHjRWOL/41yt+/6onrWPGi323Bt7FxgNyg869r8eEmZJ3oizJf
 XVUW4Amw+X5/EllZSHi2WQGfNaa8vror77Wsv/T7hr/r96nxz8oW2ASxYhoI5LZbVt5+
 TCLtD2+kKhHFOa1HrnOWlNp9aCTkDRZxPSSJ19EFtkui9+H65XElhclMt/uYhPDqG3Wo
 IAab8157+XHfh6e1jUfgMK6rRMaHiwDVDV+i1igX3DLyftk9326zl552ToNSKWYqnG3p sQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qkwa45j8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 08:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S38Te4+0lU20tXHdvhdnVxBow5eHQXtlAHB+e+X+CuYRor8VIW3nx/kM7M33AZFOB8y5dCMRADsMh1YkpHTQELRiY60PdRug/voYNMQplNlg/ZOb2MJuoiT/oz20GxPZN2dowvI3eq6bvO8kvT/WkyQ3VXzf9lEPEtuKCrF7Wxv6fKOBG6g7dRmFsSPcDjvoQ1v2nMS6O9ZpxJVP18UtWAyhdqp8mtzcPiaAMUjGZ9TRwPfDbTNrXe2EV8yfzObHLVnxUrfQLLYGuGadIFtMRlropTw6tpvbA4QFVQZmI19cPi/hvYtMp9X0zOk44aoB/lyD3zWF8/qjz0PeLdsyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eggAGm5THiP6//tQJJJYNP7bYp7HPotjS2Bn29KI0A=;
 b=Zp3/SWgr4RPVW7NaYeYl/D2uqXqXB6/qui9WDQBZ3qNQfATY5cmEUGQ0WdkyayQJ5DL62SWnA4rn2aj5rzuEtV+xgrEEinu6TlvpdC97l70JZgzix7yDb58uGRiD5qbQajxvg6FgdXnP4xv4w8z1znaYYY9BYyFb+UZQ0+cLbdLSdKmRRJ4joAjbWzaL2QahTaZAs4RgS0wiIf9pNhiIfmuUU0HmB2R0jrWHHBfXE9gInVth7zV0CgjX4ibVV0raLr17oyuMCcTf4Wffws9P/rG3ZbLSRefabtep3rTIbDN74jcCeM+YUFEmZiUxDtWG64bOwEoR9AkQqUXRqZB7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6341.namprd15.prod.outlook.com (2603:10b6:208:47e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:20:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 15:20:04 +0000
Message-ID: <c69ed7a9-d176-83e5-113e-ff9a8fde534b@meta.com>
Date: Tue, 16 May 2023 08:20:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
Content-Language: en-US
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
 <5a57547e-6865-1026-60db-bb6b2ca70e34@meta.com>
 <4c1c070f43ac53bf22aa71fb205ee83d45403143.camel@linux.ibm.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <4c1c070f43ac53bf22aa71fb205ee83d45403143.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: dbffd730-0736-48af-7679-08db56210625
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wUgruCbH4V7/y1VEeEDO1HL/erSM2qutY5Rvswk1syfUXnfLRbWpIORHyX1w+iKoQ43FLiwiDjNho1VNdg9m8iE+WuABNSTNDbVxNUPwSREJdFCcQ1GYxf+UotSS9XAQbxuE+agor9jwzeIzHpbrpS1abFoJMy3MSUw4a9GG9L2O07T29wpUsdT+4zMlZRWGyHwaytCnRPx8lRm/UcWTR6rzDRkB2+WqwaR2fFB/wN0x2H87r4auUOIDO+DexjKErtoty/fjyDox6GBymrmzt7l3i1Pg7GVPDWc+nnMPtvcvsbQ0pbHp0B6TMERI7Daz6qeleZXWTgjxxYViVWD1H0UpWMxhISb9rIWZ6Wm9ZHYCY/FiPveb1aGISIUTtaoFtckLwCAn24c8yF/agcgmsrcGtCVG3IS9BjuQgkGabL0Ab1bua3ntT279s02oPB8Rf7ONtINzdlpKs6tX8EhcTDNofxfLGfMQ7ReEz290dZmh8ZWE7R/IALk3Nu6k297XP9bTYGVUk+5rRq3BXRzSTEEa+THflC6lnAOReSnlCEjrDRH2ru8ked6eQsE5RXqCg9r4++hogPEKgVpw+x3lY6zv3eVIrInXPrtyh6xaGs7kOGxWxKFbUgE5XhUcVLcf6eILWEPfKFUK27aHhZcBkIBo1E+WqNFaza0gI7poMP8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(478600001)(54906003)(8676002)(8936002)(5660300002)(316002)(36756003)(30864003)(31696002)(86362001)(2906002)(6916009)(66476007)(4326008)(66946007)(66556008)(38100700002)(41300700001)(966005)(186003)(2616005)(53546011)(83380400001)(6506007)(6512007)(6486002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWR5eFdEQ1ZBS1BIOTBsRGdpQzE4U09MZkxHbHdIeFpNaThNUXZyMmMyZ3FT?=
 =?utf-8?B?MXRqNjBLQ1FGeDI3eGFZSjR0THBGL011VHB5UVprRzkxSS9GcmRhemFhQ0JG?=
 =?utf-8?B?aGFMelEyWXI3cFdCKzNlME9iREJGWkNQaFFlR3JhY1JrVFJjTW5adlN2OW5t?=
 =?utf-8?B?eW5WckhObVByTzQ3aWFoYWpjeEEyajRFWTExMjR1YTV0b1VmSG85dG91Zlh0?=
 =?utf-8?B?R3BlUjZBTXNOUVMwRmt5NkFTRTBMcjR0QjBIVmxENlczUE5RbkErOStVaEJr?=
 =?utf-8?B?UUtMcjZ6SXVOK1pmbnhFTnMzNkMyK29GWnZuWHdWSjBxekhlTnM4YTI3b2Nt?=
 =?utf-8?B?Umh2WUVpUDdmcmJFa0tKSUxxMWVQWUFUMnB6anBHWnErbFVGTG1GMVlOQlNE?=
 =?utf-8?B?NkxBVHo3VWR3L2trN2VNRG1xbTV5QnNyeWM5VStQdW1ZWElNdEVCdXRuZkxU?=
 =?utf-8?B?UG1zanIrWXpocGI3T0FUa2crcURzdkxoU2pEUGJuczRsQnRXNUVlQk5VU0d6?=
 =?utf-8?B?OVpTRTllem5Xamk2azhRa25yclJFMDVDYUVsN29OaE1pWmV4TUtqdFJYWllJ?=
 =?utf-8?B?QUx4VFQrVmFRalRSakZzQUVGTDlNeENMcWJUSFFYMk1DTGl1dlF3bnRaTHB2?=
 =?utf-8?B?aVRqU2tlMUsyUDN4WFZqWmxpUVk0eVRqejdHZGNuYXVzaEMxRC9VVlhuWW5z?=
 =?utf-8?B?T09LckQyWGxNS0hzc2ZjeTd3WFg1QVhoSmU2NUY0MkdUQzlsKzVrZXAza2tV?=
 =?utf-8?B?S2Q4dXRIUkV5eUNIUE9iNndDNis2bDJyTDMrR1I0UExhV0d2TngxakpsUUdh?=
 =?utf-8?B?Qk5jTlBUemtvQ2xiRU9JQ1A5cjFFdG5hMkFEOWkvazNtY0NRanhEekNEYS9L?=
 =?utf-8?B?UXlIS1RNcEd2b2ZIQzMwYmtuWERJNTJCa1lJeFhJZU81ZzhFOGtuTG5Edjd1?=
 =?utf-8?B?MXV0VWxwMGlvcUsvLzEvU1gvVDBoL1pKb3lnWmZQUEhZVHJtOEJwYkNIV2Fp?=
 =?utf-8?B?b0pJd1M2MmRDMFpLNWRZRjh2aHZLS3VjYmRVcXVyOUlnSEg0N3VFOVZtSHVn?=
 =?utf-8?B?TlhqcFcyS24wNm1TcWdqUk5mMFF6SEFFYVNpWmhGRytlMENlQ2hBTld0aDJu?=
 =?utf-8?B?TXUzYVNkRzY3OWwwUmprNHZ1RlBCeFR0TThHT3VGeTVxTDdWTDhkNnFiaHIr?=
 =?utf-8?B?QzU5VkxZbU0ranhIU2s2aUJNaUd5TC9zUTBrc2VhRTA0MGtScnFxWTJrU0JS?=
 =?utf-8?B?TEdMbUx6anFzSTdMRldqVk1xekQxZ1ZUb21jNkdYbGFYU0hWRkxkMkxJK3RB?=
 =?utf-8?B?ekdkNnc3NkpMSEV6Z1NsZVVzUUZlcHo0TUxrOWFjSWpXcFBkZ09VRnpKN1RT?=
 =?utf-8?B?MjRFWTI5bGx1VHBIWUR1Nm5HU1lRdW5DNytIV1F5YVIzMmlocTRxTG54U2lT?=
 =?utf-8?B?dFVGdTFGSVhCMnljT2hBTjh0OWZiM2VCMzF0TjVxMFdHdGRDMFRicU9FbDJn?=
 =?utf-8?B?MVI4Q0owS0h4UkIveGlDWTdydmRxVEg4eTZIQzNsSUZUMk9HTmpwOEZBWUdH?=
 =?utf-8?B?czZHd0NEbjV1bUhMRTQvV0YxS1l5cEdsUzQ4T1JPQTcxR2ZSQk5Ob2dGZVZz?=
 =?utf-8?B?OUVZSDc0aU9aVllqbjdreEQrZ1l0YXdSSTVmdWRqbmF6aG1tY3gyVzhLNDZp?=
 =?utf-8?B?WDRNZXE4T1FEMzVEVm02ZHlMbkhTVGxxbWlRTmZybU1lRGhQRSs5RzZpdkN1?=
 =?utf-8?B?bWtOVG5tU1RTdXZBTWNCSzVLMDJsWndKSERKM2pIQmVvQzRsbS9VUHVJOGJH?=
 =?utf-8?B?OUZVY29QZy9qVUxDK2ZwMFBzV3NEZTZqMmJ2eFNOKzUzcldEUjNJcG1vakJK?=
 =?utf-8?B?MStRMHdxTkRsajNHbU5PN3psVU9DeG9MSkRtVVgySUwwUFlsbnRQL29jajBh?=
 =?utf-8?B?Vy9CMFNJL2V1Sk9LY3pTT213ZHloa2VxalBZNEQ2dDNoakI4VDkzMC8vb2VT?=
 =?utf-8?B?dHFOOHFucWR4TEl3cmtMNTJTUWNpSzc3RlZxQVNEb2c4WkM2eU04Y2xYdFdU?=
 =?utf-8?B?aEVWcnJmVSt4VWQrWnY3Rm02bzNrd0w4M3c0T0NJT2VSYUVrSkc1TGVydHIx?=
 =?utf-8?B?ZTg1S1FjSm1NRXVkM00xcWVoRUJHZXM1cVpMUkp2UVpqT3A2NHNVRUc5blA2?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbffd730-0736-48af-7679-08db56210625
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:20:04.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM0CJO1mDryqH8muuT+Yt1fr6ebtZxdSaeo04HrzoLy97EYqq07A16coARuosZbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6341
X-Proofpoint-ORIG-GUID: QlTziNZ8_gr1AMh1tSvz4VmRzjZOHFNf
X-Proofpoint-GUID: QlTziNZ8_gr1AMh1tSvz4VmRzjZOHFNf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/16/23 2:16 AM, Ilya Leoshkevich wrote:
> On Mon, 2023-05-15 at 08:27 -0700, Yonghong Song wrote:
>>
>>
>> On 5/15/23 12:55 AM, Ilya Leoshkevich wrote:
>>> On Sun, 2023-05-14 at 09:58 -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 5/13/23 1:24 AM, Ilya Leoshkevich wrote:
>>>>> On Fri, 2023-05-12 at 21:13 -0700, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
>>>>>>> On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
>>>>>>>> On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
>>>>>>>>> Hi, Ilya,
>>>>>>>>>
>>>>>>>>> BPF CI ([1]) detected a s390x failure when bpf program
>>>>>>>>> is
>>>>>>>>> compiled
>>>>>>>>> with
>>>>>>>>> latest llvm17 on bpf-next branch. To reproduce the
>>>>>>>>> issue,
>>>>>>>>> just
>>>>>>>>> run
>>>>>>>>> normal './test_progs -j'. The failure log looks like
>>>>>>>>> below:
>>>>>>>>>
>>>>>>>>> Notice: Success: 341/3015, Skipped: 29, Failed: 1
>>>>>>>>> Error: #191 sock_fields
>>>>>>>>>        Error: #191 sock_fields
>>>>>>>>>        create_netns:PASS:create netns 0 nsec
>>>>>>>>>        create_netns:PASS:bring up lo 0 nsec
>>>>>>>>>       
>>>>>>>>> serial_test_sock_fields:PASS:test_sock_fields__open_and
>>>>>>>>> _loa
>>>>>>>>> d 0
>>>>>>>>> nsec
>>>>>>>>>       
>>>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(egress_read_
>>>>>>>>> sock
>>>>>>>>> _fie
>>>>>>>>> lds)
>>>>>>>>> 0
>>>>>>>>> nsec
>>>>>>>>>       
>>>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(ingress_read
>>>>>>>>> _soc
>>>>>>>>> k_fi
>>>>>>>>> elds
>>>>>>>>> )
>>>>>>>>> 0 nsec
>>>>>>>>>       
>>>>>>>>> serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_
>>>>>>>>> port
>>>>>>>>> 0
>>>>>>>>> nsec
>>>>>>>>>        test:PASS:getsockname(listen_fd) 0 nsec
>>>>>>>>>        test:PASS:getsockname(cli_fd) 0 nsec
>>>>>>>>>        test:PASS:accept(listen_fd) 0 nsec
>>>>>>>>>       
>>>>>>>>> init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt
>>>>>>>>> _fd)
>>>>>>>>> 0
>>>>>>>>> nsec
>>>>>>>>>       
>>>>>>>>> init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt
>>>>>>>>> 10_f
>>>>>>>>> d) 0
>>>>>>>>> nsec
>>>>>>>>>        test:PASS:send(accept_fd) 0 nsec
>>>>>>>>>        test:PASS:recv(cli_fd) 0 nsec
>>>>>>>>>        test:PASS:send(accept_fd) 0 nsec
>>>>>>>>>        test:PASS:recv(cli_fd) 0 nsec
>>>>>>>>>        test:PASS:recv(accept_fd) for fin 0 nsec
>>>>>>>>>        test:PASS:recv(cli_fd) for fin 0 nsec
>>>>>>>>>       
>>>>>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_ou
>>>>>>>>> t_cn
>>>>>>>>> t,
>>>>>>>>> &accept_fd) 0 nsec
>>>>>>>>>       
>>>>>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_ou
>>>>>>>>> t_cn
>>>>>>>>> t,
>>>>>>>>> &cli_fd) 0 nsec
>>>>>>>>>       
>>>>>>>>> check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
>>>>>>>>> nsec
>>>>>>>>>       
>>>>>>>>> check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
>>>>>>>>> nsec
>>>>>>>>>       
>>>>>>>>> check_result:PASS:bpf_map_lookup_elem(linum_map_fd,
>>>>>>>>> READ_SK_DST_PORT_IDX) 0 nsec
>>>>>>>>>        check_result:FAIL:failure in read_sk_dst_port on
>>>>>>>>> line
>>>>>>>>> unexpected
>>>>>>>>> failure in read_sk_dst_port on line: actual 297 !=
>>>>>>>>> expected
>>>>>>>>> 0
>>>>>>>>>        listen_sk: state:10 bound_dev_if:0 family:10
>>>>>>>>> type:1
>>>>>>>>> protocol:6
>>>>>>>>> mark:0
>>>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6)
>>>>>>>>> src_ip6:0:0:0:1(::1)
>>>>>>>>> src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::)
>>>>>>>>> dst_port:0
>>>>>>>>>        srv_sk: state:9 bound_dev_if:0 family:10 type:1
>>>>>>>>> protocol:6
>>>>>>>>> mark:0
>>>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6)
>>>>>>>>> src_ip6:0:0:0:1(::1)
>>>>>>>>> src_port:51966 dst_ip4:7f000006(127.0.0.6)
>>>>>>>>> dst_ip6:0:0:0:1(::1)
>>>>>>>>> dst_port:38030
>>>>>>>>>        cli_sk: state:5 bound_dev_if:0 family:10 type:1
>>>>>>>>> protocol:6
>>>>>>>>> mark:0
>>>>>>>>> priority:0 src_ip4:7f000006(127.0.0.6)
>>>>>>>>> src_ip6:0:0:0:1(::1)
>>>>>>>>> src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
>>>>>>>>> dst_port:51966
>>>>>>>>>        listen_tp: snd_cwnd:10 srtt_us:0
>>>>>>>>> rtt_min:4294967295
>>>>>>>>> snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0
>>>>>>>>> mss_cache:536
>>>>>>>>> ecn_flags:0 rate_delivered:0 rate_interval_us:0
>>>>>>>>> packets_out:0
>>>>>>>>> retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0
>>>>>>>>> segs_out:0
>>>>>>>>> data_segs_out:0 lost_out:0 sacked_out:0
>>>>>>>>> bytes_received:0
>>>>>>>>> bytes_acked:0
>>>>>>>>>        srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
>>>>>>>>> snd_ssthresh:2147483647
>>>>>>>>> rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
>>>>>>>>> mss_cache:32768
>>>>>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:272
>>>>>>>>> packets_out:0
>>>>>>>>> retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0
>>>>>>>>> segs_out:3
>>>>>>>>> data_segs_out:2 lost_out:0 sacked_out:0
>>>>>>>>> bytes_received:1
>>>>>>>>> bytes_acked:22
>>>>>>>>>        cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
>>>>>>>>> snd_ssthresh:2147483647
>>>>>>>>> rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
>>>>>>>>> mss_cache:32768
>>>>>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:925
>>>>>>>>> packets_out:0
>>>>>>>>> retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2
>>>>>>>>> segs_out:6
>>>>>>>>> data_segs_out:0 lost_out:0 sacked_out:0
>>>>>>>>> bytes_received:23
>>>>>>>>> bytes_acked:2
>>>>>>>>>        check_result:PASS:listen_sk 0 nsec
>>>>>>>>>        check_result:PASS:srv_sk 0 nsec
>>>>>>>>>        check_result:PASS:srv_tp 0 nsec
>>>>>>>>>
>>>>>>>>> If bpf program is compiled with llvm16, the test passed
>>>>>>>>> according
>>>>>>>>> to
>>>>>>>>> a CI run.
>>>>>>>>>
>>>>>>>>> I don't have s390x environment to debug this. Could you
>>>>>>>>> help
>>>>>>>>> debug
>>>>>>>>> it?
>>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>>        [1]
>>>>>>>>> https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8679080985?pr=224#step:6:7645
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> thank for letting me know.
>>>>>>>> I will look into this.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Ilya
>>>>>>>
>>>>>>> In the meantime the issue was fixed by:
>>>>>>>
>>>>>>> commit 141be5c062ecf22bd287afffd310e8ac4711444a
>>>>>>> Author: Shoaib Meenai <smeenai@fb.com>
>>>>>>> Date:   Fri May 5 14:18:12 2023 -0700
>>>>>>>
>>>>>>>         Revert "Reland [Pipeline] Don't limit
>>>>>>> ArgumentPromotion
>>>>>>> to -
>>>>>>> O3"
>>>>>>>         
>>>>>>>         This reverts commit
>>>>>>> 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
>>>>>>>         
>>>>>>>         https://reviews.llvm.org/D149768     is causing size
>>>>>>> regressions
>>>>>>> for -
>>>>>>> Oz
>>>>>>>         with FullLTO, and I'm reverting that one while
>>>>>>> investigating.
>>>>>>> This
>>>>>>>         commit depends on that one, so it needs to be
>>>>>>> reverted as
>>>>>>> well.
>>>>>>
>>>>>> The transformtion "Don't limit ArgumentPromotion to -O3" is
>>>>>> temporarily
>>>>>> reverted. But it could be reverted again once the issue is
>>>>>> resolved.
>>>>>> So it is a good idea to resolve the issue in the kernel.
>>>>>>
>>>>>>>
>>>>>>> But looking at the codegen differences:
>>>>>>>
>>>>>>> $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-
>>>>>>> 9]*://g
>>>>>>> fail.s)
>>>>>>>
>>>>>>> -pass.o:        file format elf64-bpf
>>>>>>> +fail.o:        file format elf64-bpf
>>>>>>>
>>>>>>> -00000000000002c8 <sk_dst_port__load_half>
>>>>>>> -       69 11 00 30 00 00 00 00 r1 = *(u16 *)(r1 + 48)
>>>>>>> +00000000000002c0 <sk_dst_port__load_half>
>>>>>>> +       54 10 00 00 00 00 ff ff w1 &= 65535
>>>>>>>             b4 00 00 00 00 00 00 01 w0 = 1
>>>>>>>             16 10 00 01 00 00 ca fe if w1 == 51966 goto +1
>>>>>>> <LBB6_2>
>>>>>>>             b4 00 00 00 00 00 00 00 w0 = 0
>>>>>>>
>>>>>>> This is what ArgumentPromotion is supposed to do, so that's
>>>>>>> okay so
>>>>>>> far. However, further down below we have:
>>>>>>>
>>>>>>>      Disassembly of section cgroup_skb/egress:
>>>>>>>
>>>>>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>>>>>> +       61 76 00 30 00 00 00 00 r7 = *(u32 *)(r6 + 48)
>>>>>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>>>>>             85 01 00 00 00 00 00 53 call
>>>>>>> sk_dst_port__load_word
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>>>>>> +       74 70 00 00 00 00 00 10 w7 >>= 16
>>>>>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>>>>>             85 01 00 00 00 00 00 57 call
>>>>>>> sk_dst_port__load_half
>>>>>>>
>>>>>>> so there is no 16-bit load anymore, instead, the result
>>>>>>> from
>>>>>>> the
>>>>>>> earlier 32-bit load is reused. However, on BE these kinds
>>>>>>> of
>>>>>>> loads
>>>>>>> for this particular field are not consistent at the moment
>>>>>>> -
>>>>>>> see
>>>>>>> [1]
>>>>>>> and the previous discussions.
>>>>>>>
>>>>>>> De-facto we have the following results:
>>>>>>>
>>>>>>> - int load: 0x0000cafe
>>>>>>> - short load: 0xcafe
>>>>>>
>>>>>> So 'De-facto' means the above is the expected result.
>>>>>>
>>>>>>>
>>>>>>> On a consistent BE we should have rather had:
>>>>>>>
>>>>>>> - int load: 0x0000cafe
>>>>>>> - short load: 0
>>>>>>
>>>>>> What does 'consistent BE' mean here? Does it mean the
>>>>>> expected
>>>>>> result from the source code itself?
>>>>>
>>>>> I should not have called the de-facto example "BE" at all: it's
>>>>> rather
>>>>> "mixed endianness" or "weird endianness" or something along
>>>>> these
>>>>> lines.
>>>>>
>>>>> On "consistent BE" or simply "BE" properties like
>>>>>
>>>>> *(uint32_t *)p = (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2);
>>>>>
>>>>> hold. This is currently not the case for bpf_sock.dst_port.
>>>>>
>>>>> We compile with -mbig-endian, so we promise to the compiler
>>>>> that
>>>>> the
>>>>> machine is big-endian, and the compiler expects the above to
>>>>> hold
>>>>> for
>>>>> any p. Unfortunately when p points to bpf_sock.dst_port, this
>>>>> is
>>>>> not
>>>>> the case.
>>>>
>>>> If I understand correctly, *(uint32_t *)p to get the
>>>> bpf_sock.dst_port
>>>> is for backward compatibility. But the real u32 read by compiler
>>>> will
>>>> do (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2) which is not the
>>>> same as expected *(uint32_t *)p so we have problem here.
>>>>
>>>>>
>>>>> The property above is important for the correctness of the
>>>>> load/store
>>>>> tearing transformations. What we have here is not exactly
>>>>> tearing,
>>>>> but
>>>>> is quite close.
>>>>>
>>>>>>> Clang, of course, expects a consistent BE and optimizes
>>>>>>> around
>>>>>>> that.
>>>>>>>
>>>>>>> This was a conscious tradeoff Jakub and I have agreed on in
>>>>>>> order
>>>>>>> to
>>>>>>> keep the quirky behavior from the past. Given what's
>>>>>>> happening
>>>>>>> with
>>>>>>> Clang now, I wonder if it would be worth revisiting it in
>>>>>>> the
>>>>>>> name
>>>>>>> of
>>>>>>> consistency?
>>>>>>
>>>>>> If I understand correctly, I think the issue is
>>>>>>         r7 = *(u32 *)(r6 + 48)
>>>>>>         w7 >= 16
>>>>>>         w1 = w7
>>>>>>
>>>>>> after verifier, it is changed to
>>>>>>        r7 = *(u16 *)(r6 + <kernel offset>)
>>>>>>        w7 >= 16
>>>>>>        w1 = w7
>>>>>>
>>>>>> and the result after verifier rewrite is completely wrong.
>>>>>> Is it right?
>>>>>
>>>>> No, the verifier rewrite is correct.
>>>>> The sk_dst_port__load_word() part of the test succeeds.
>>>>>
>>>>> All these rewrites already work fine, they are correct and
>>>>> consistent.
>>>>> It's really just bpf_sock.dst_port that is special.
>>>>>
>>>>>> If this is the case, during verifier rewrite, if it is
>>>>>> big endian, say the user intends to load 4 bytes (from uapi
>>>>>> header)
>>>>>> while the kernel field is 2 bytes, in such cases, kernel
>>>>>> can still pretend to generate 4-byte load. For example,
>>>>>> for the above example, the code after verification could be:
>>>>>>        r7 = *(u16 *)(r6 + <kernel offset>)
>>>>>>        r7 <= 16
>>>>>>        w7 >= 16
>>>>>>        w1 = w7
>>>>>>
>>>>>> Hopefully, we won't have many such cases. Does this work?
>>>>>
>>>>> This would break the sk_dst_port__load_word() part of the test.
>>>>
>>>> This is a hack. This may work for this specific u16 case, but
>>>> yes, it won't work for u32 load case.
>>>>
>>>>>
>>>>>
>>>>>
>>>>> Above I asked whether we can resolve the inconsistency, but I
>>>>> thought
>>>>> about it and I don't see a way of doing it without breaking the
>>>>> ABI,
>>>>> which is at worst unacceptable, and at best a last resort
>>>>> measure.
>>>>>
>>>>> What do you think about marking bpf_sock.dst_port volatile?
>>>>> volatile
>>>>> should prevent tearing and similar optimizations, with which we
>>>>> have a
>>>>> problem here.
>>>>>
>>>>> We could also add a comment warning users not to cast away this
>>>>> volatile due to the quirk we have. And then we should adjust
>>>>> the
>>>>> test
>>>>> (making all casts volatile) to comply with this new warning.
>>>>
>>>> I did a little study on this. The main problem here for
>>>> static __noinline bool sk_dst_port__load_half(struct bpf_sock
>>>> *sk)
>>>> {
>>>>            __u16 *half = (__u16 *)&sk->dst_port;
>>>>            return half[0] == bpf_htons(0xcafe);
>>>> }
>>>>
>>>> Through some cross-function optimization by ArgumentPromotion
>>>> optimization, the compiler does:
>>>>       /* the below shared by sk_dst_port__load_word
>>>>        * and sk_dst_port__load_half
>>>>        */
>>>>       __u32 *word = (__u32 *)&sk->dst_port;
>>>>       __u32 word_val = word[0];
>>>>
>>>>       /* the below is for sk_dst_port__load_half only */
>>>>       __u16 half_val = word_val >> 16;
>>>>
>>>>       ... half_val passed into sk_dst_port__load_half ...
>>>>       return half_val == bpf_htons(0xcafe);
>>>>
>>>> Here, 'word_val = word[0]' is replaced by 2-byte load
>>>> by the verifier and this caused the trouble for later
>>>> sk_dst_port__load_half().
>>>>
>>>> I don't have a good solution here. The issue is exposed
>>>> as we have both u16 and u32 load for &sk->dst_port and
>>>> the compiler did some optimization with this.
>>>>
>>>> I would say this is an extreme corner case and we can just
>>>> fix in the source code like below:
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>>> b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>>> index bbad3c2d9aa5..39c975786720 100644
>>>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>>> @@ -265,7 +265,10 @@ static __noinline bool
>>>> sk_dst_port__load_word(struct bpf_sock *sk)
>>>>
>>>>     static __noinline bool sk_dst_port__load_half(struct bpf_sock
>>>> *sk)
>>>>     {
>>>> -       __u16 *half = (__u16 *)&sk->dst_port;
>>>> +       __u16 *half;
>>>> +
>>>> +       asm volatile ("");
>>>> +       half  = (__u16 *)&sk->dst_port;
>>>>            return half[0] == bpf_htons(0xcafe);
>>>>     }
>>>>
>>>> Could you try whether the above workaround works or not?
>>>> If we want the code to be future proof for potential
>>>> cross-func optimization for these noinline functions, we
>>>> can add similar asm codes to all of
>>>> bool sk_dst_port__load_{word, half, byte}.
>>>
>>> Hi,
>>>
>>> this makes the issue go away, thanks.
>>>
>>> However, I'm still concerned, because this only inhibits a certain
>>> optimization and does not address the underlying fundamental
>>> problem:
>>> we promise to clang that the in-kernel implementation of the eBPF
>>> virtual machine is big-endian, while in reality it's not. As
>>> compiler
>>> optimizations get more aggressive, we will surely see more of this.
>>>
>>> Why not do this instead?
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 1bb11a6ee667..3c9b535532ae 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -6102,7 +6102,7 @@ struct bpf_sock {
>>>          __u32 src_ip4;
>>>          __u32 src_ip6[4];
>>>          __u32 src_port;         /* host byte order */
>>> -       __be16 dst_port;        /* network byte order */
>>> +       volatile __be16 dst_port;       /* network byte order */
>>>          __u16 :16;              /* zero padding */
>>>          __u32 dst_ip4;
>>>          __u32 dst_ip6[4];
>>> diff --git a/tools/include/uapi/linux/bpf.h
>>> b/tools/include/uapi/linux/bpf.h
>>> index 1bb11a6ee667..3c9b535532ae 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -6102,7 +6102,7 @@ struct bpf_sock {
>>>          __u32 src_ip4;
>>>          __u32 src_ip6[4];
>>>          __u32 src_port;         /* host byte order */
>>> -       __be16 dst_port;        /* network byte order */
>>> +       volatile __be16 dst_port;       /* network byte order */
>>>          __u16 :16;              /* zero padding */
>>>          __u32 dst_ip4;
>>>          __u32 dst_ip6[4];
>>> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>> b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>> index bbad3c2d9aa5..773ded84ac12 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>>> @@ -259,19 +259,19 @@ int ingress_read_sock_fields(struct __sk_buff
>>> *skb)
>>>     */
>>>    static __noinline bool sk_dst_port__load_word(struct bpf_sock
>>> *sk)
>>>    {
>>> -       __u32 *word = (__u32 *)&sk->dst_port;
>>> +       volatile __u32 *word = (volatile __u32 *)&sk->dst_port;
>>>          return word[0] == bpf_htons(0xcafe);
>>>    }
>>>    
>>>    static __noinline bool sk_dst_port__load_half(struct bpf_sock
>>> *sk)
>>>    {
>>> -       __u16 *half = (__u16 *)&sk->dst_port;
>>> +       volatile __u16 *half = (volatile __u16 *)&sk->dst_port;
>>>          return half[0] == bpf_htons(0xcafe);
>>>    }
>>>    
>>>    static __noinline bool sk_dst_port__load_byte(struct bpf_sock
>>> *sk)
>>>    {
>>> -       __u8 *byte = (__u8 *)&sk->dst_port;
>>> +       volatile __u8 *byte = (volatile __u8 *)&sk->dst_port;
>>>          return byte[0] == 0xca && byte[1] == 0xfe;
>>>    }
>>>    
>>> This also works, and as far as I'm concerned, this would be a
>>> proper
>>> fix for the underlying issue: we tell the compiler that it should
>>> never
>>> ever (with any of today's or future optimizations) try to be clever
>>> when accessing dst_port.
>>
>> The above test_sock_fields.c change should work too.
>> I think the uapi change is not necessary. The key word 'volatile'
>> intends to avoid merging two or more identical loads together.
>> In this particular case, with only uapi changes, the
>> harmful transformation can still happen since the sk->dst_port
>> is indeed loaded only once.
>>
>> The test_sock_fields.c change itself forces proper load
>> which is verifier friendly. So I suggest to have
>> test_sock_fields.c change only. My previously suggested
>> changes have the same effect, to preserve the verifier friendly
>> load.
> 
> Ok, let's do it this way then.
> 
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> for the diff you posted above.

Sounds good. I will submit a patch with my previous suggested
'asm volatile' approach. This is purely to workaround the test
case which tries to exercise different access patterns for dst_port
and such usage pattern should not appear in typical user bpf
programs.

> 
>>
>>>
>>> Best regards,
>>> Ilya
>>>
>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com
>>>
> 

