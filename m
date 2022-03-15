Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4984D9E6B
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiCOPQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCOPQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 11:16:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34927CC2
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 08:15:03 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FENlZu000831;
        Tue, 15 Mar 2022 08:14:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5pHAFSer7ua4Vq1jvdLOG1CCqmAdNnvXc93//evs1kY=;
 b=oyvHh1wnr3U9LBn6uGZLnPbkQ23d7CAdGBxPcOyKFbVk1eyD4UE6iUaBN557kw02z1wo
 bUqLyPfM7tqfcJDC34jB91dfn4Lf+QFQ3Jm9FbdfJxX491Ilm+hYKW8ISh4Bcr/ktFXT
 XxMVNRdXnT+J7BQLQaUwWLXuMlQKq3hDZps= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et8k0852a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 08:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg/oGzB40EOxRjNTOT7lQEpg1+nuu0G2upOzJN0PxiiIDTvftRpV21ZaBRAcSSQ3QFYreb5iOSiSletW5c0xG9jkaG08YqBX9ML4xh4q3ors5CF6DThq9OBijLAaUqlu7CI1LQJfqh+iO+WEj4xbCsadJXe/Ulh1/TLKC+/MtqQBbc6L0Vok8tXBUpLJr/htDablldMMdmcA26LvDSOcFl3qx0CgNn1rgxLRXvF1HG/jbK/EMcL+m/ogPOahDjAhJhDybsxIAT0zVl7jN97uPEoGWA5EJoGGqVvca9+qv17o3cyprWXF9Sq4uwdEVADBfYj8QADivpn5mtDZd8EnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pHAFSer7ua4Vq1jvdLOG1CCqmAdNnvXc93//evs1kY=;
 b=MugxqGbMBElKJ7zRBLCZAc277S3HvWOcXIPVKy4u8I/qpzmlRmxpB3i9WtFkov9aqKJdLkLeiGu2Jx5lM6NzJXVxVu5beZ1P7IHLkpt7Fklj8uNdFhNaOdtvN5MZGO8Q7G5UuAuK7jzi10jPAIcyJXHQ6pwtwXWBv4ba+wf9ynNNNP8Czx9GihSURYdP41DBwXxQ5R5iUSPnSam9CpENEGmR7Amg7moDeCWTjdKYjc+UGnVCJi62k0hRG5p7zKcDYKXPCLk6eyS2nX868oqjx5NoZY5rhlWnuE1RiGIXonT2mI/1neFNASxej48nYIFIxUkE1DTz0EcuyGhX0CR+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BYAPR15MB2293.namprd15.prod.outlook.com (2603:10b6:a02:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 15:14:57 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:14:57 +0000
Message-ID: <d65063e0-5709-0b0c-9d82-526426680b4c@fb.com>
Date:   Tue, 15 Mar 2022 08:14:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: direct packet access from SOCKET_FILTER program
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, bpf@vger.kernel.org
References: <4d91422a-3c2e-4d8d-407b-f4367e9ff966@suse.com>
 <9c62401d-4076-9a45-3632-abb5f4ca4a47@fb.com>
 <c9170221-69ee-1195-b35b-11405c23a8bd@suse.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <c9170221-69ee-1195-b35b-11405c23a8bd@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a5aa60-8ddd-400e-5a2b-08da069690e6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2293:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB22934C31E7D42BE51ADB97D4D3109@BYAPR15MB2293.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6Z/H4wrp4QQrfPNgoDus3FMTyFxt9SNyJDEsw1c5XVPeIaRpMx3e+AiY7q9Nd9UR6QupMD+Sgj4CkdfIa/3kZXQBgQoW6g08vDMMuLeOGi6xO2uL7/HRfmZLc1b7E5GFoa38flRNgk+mBYkYjAXT1riT3ymofXNTMtt1zKThsOmqGjADDZnpflA3u2xENNfzgjEw0eKvMegK4yVDf4gTdE1bs7EanV/Q7+MMvBEcgtgM4XirehDh1NhL9CKF5hPTaXltDOGhjhgvuOxvajUcy1UYY6aAz2mIuNvrfksBV6OU3HXCK/UDDlkSIYbFWtop/zNjNxjlu7smkuRJQN0IADtaqetf8kPldMcxTZNHMZHVDUx4y5cj3FNOZY2lyDNV04mT0Bntgbvnl0TYJqWCebjvr91mgVqVLgPaAsTqVvOjJCx+zheKOIB/kxMUEAGZdU3rIrhHxNE3OGVz4bBCrtIVdVBfmw1cwhoNWVNfEwVTGn80VplkbW31LkVSyl4JVRS+XDDLqJXDL/X0WQ/dxUeJ2Z7O7/K5UhXqgAi//vnLTdpPJOfaLJttYAj26w6Az1zw/o6azDRgs41dTO2H62P4tXjk3upZdFeA/jmzaPzrA8tf3359u5b+jwbn4+KAFkbRtT02wwVPrYFd3t3KD0HtZfs1ZHTOq5Lqsj2C/DdbMYjCBYjCB56NjLVHUvym8wypt9Qsn0O876SRGa5ecqJoKCDIWiZlJi1gVDy5oj+xN0hS9wsgPbOAU9MtH8kERaAjUjEkHpszh16v3gWGKdcyWV8c8RoXL3hzWd8ozEswS6AJTTD7pUQLjZdXOIsPOTGNNSXUMJRvF9iSF9JiqlZPjy9ZJgkb0NFylaWwt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(966005)(8936002)(86362001)(6486002)(31696002)(5660300002)(83380400001)(6512007)(6506007)(316002)(31686004)(36756003)(186003)(66556008)(508600001)(66946007)(53546011)(52116002)(2906002)(8676002)(38100700002)(66476007)(16330500008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFpaWC9ZUkhrQUEyZ2pkZjZxMVZlTzd4dGJkVDBIdFcyejhXZXdDcXpSQnZk?=
 =?utf-8?B?OVl3UVNEN2RSdzUzbFo1TkxRb0pWNW1KL0kvRzlrd2Y0cHVGWXNNV2ROOGc4?=
 =?utf-8?B?aXpzb0x3VkFNWjBEcGVRUXlJMTYvb1lVTktVMEZva0pHNHRFUDdYdXlqKzhU?=
 =?utf-8?B?bmlzQ3RmanNydEptMkNhdThoT1JIYVdvVHBZeHVRSGc4TEI3anZ6SUFSRWJB?=
 =?utf-8?B?YzRIdHpGbTVKODQxdGorWVJPNExra3N2djRLOTJuMkZVOWs5TlFVT0FGL2dv?=
 =?utf-8?B?Vkt0dVB2eVEycTljL0xHWGJkYW5Tay9ibDRUd05rOTR6eVBMU2Z3aGhzNkl1?=
 =?utf-8?B?SmJNbDFoc0d2czMxNTRHSU1DQUE2c1RuSy9jc3JBdjk3L3Vrak5BdW9YbSti?=
 =?utf-8?B?bkFreWdhVE1VVVpGdzRiRy9GQysyNWxNWWcySWhvZ1IyaUZodmUzcGdJVzNY?=
 =?utf-8?B?SktZQ3czb0U1UlJMNm83V0IvTG51S3REdFdFQlNnbVhGR2pnR3dBaUtEV2Fm?=
 =?utf-8?B?aDh3TEVpSWpCNHppYXIxbkM2NkdDcjNIcldEV3BNQzc5Tnd1NmpwSjlJOVRT?=
 =?utf-8?B?dGhXL211M2l4QXljZ0RlNmhYRGFBdFZqUGg5S2c2ZWk4cDIrSnhEOGNMM0pl?=
 =?utf-8?B?NWhRWG1vdTJ4T01xRGdoQnhmUWJkTWVOZEEzWU83SCtTV1k0ZmJNRHJXM2RX?=
 =?utf-8?B?ei9MeHRqdS9uL3E2bzFwU09za0hla1Y4N0lzSjBLaWNkTGtMdVRVM2wzOHd2?=
 =?utf-8?B?TWZNSlI0SmNETnIwN2ZTV0VtYURsWW40U3dMNmtkL016dlhJUDk1SG53WHV4?=
 =?utf-8?B?MGtLb0RBMUc5eDJrZCtKZUoxazdxQitIaXNrQmdGVjNQKzlyS0d1QWtaaHRZ?=
 =?utf-8?B?elNjK3F5c2FyNWh3SGxRcytEaitBQXJHTFV5azFvUXJKL3dWbXlTYzE3eW5p?=
 =?utf-8?B?QUtDWitLaEtvTE4rbnRDRXVHTW5FRU9DaGIxYWFDbTR5bzhydVJtNEhmSEVB?=
 =?utf-8?B?U2s0QU0ySUZ0azJ5cCs3Zkc3SUhGaHVrSkJXejFVNEg1bENmRDUwcnYydGlB?=
 =?utf-8?B?QzI4WC93OUlUUWN3VGdpUlJTS09DS0F0UWdxZ093SFJjbmdraXBGeDNOMWY4?=
 =?utf-8?B?SVhHM2xUWURoTEZKbDc0ZDZWeE1iMUk4NTFOcEpRL0RhTzZYV1YzWFhkNVNV?=
 =?utf-8?B?U2xQRjErNFpoc3BJQnMrNjNRRXBnYmk5OER4OExJeEFOOW9sSkxwb3pCN3h5?=
 =?utf-8?B?eDFlcG5OT3paOUdxc2o4ZzhnSS9KMHJtVGlvaG1rSlpiSUxiWkdIcFJVb2JX?=
 =?utf-8?B?L3JBenQ5aG9yaHFkVEdCTHJsMUhxZmNEUEczYVNZcnhEWmZHNlNDYXEvQTJ3?=
 =?utf-8?B?TEN4MUUwM3FaWEVTRHVRbWN1Y09hZ2xXRmlQbExWeUxUSkpYM1NUNGkwNlRh?=
 =?utf-8?B?T3g2SzRBUlM1MXlkeXlJdnN1SjFpbVFZSWo0RjlwbmZBREFzZERsUXhjYWlx?=
 =?utf-8?B?cjkvSU9uT2Z5ekVMSGN1SmVGSkNnYlVtSUdQbVArTk45QnJnV2VtbXNuOU5Q?=
 =?utf-8?B?WEF4dzIxZnRTcUMvRkhQMm5KRGxBek5Cb3BLSlNwY2U0NGtSQUxLNjZZcDk4?=
 =?utf-8?B?V09VcFpKY0MxTUl4OWc2RGFsbkM0alJNTGl3SUtoalJqOWdtckFZTFZPS3p0?=
 =?utf-8?B?dXU5RjdrUVJ6Vnd1c2dsTmdzWW9DQnJOL3R1a1U3alZ0QnJYSnUzVzlIMUdJ?=
 =?utf-8?B?ZlpRcTVVUDZBbGtHbUlmbVBocVFnN0IvWFY4eWlVK25VUDlmdnJ5RUlUYmtR?=
 =?utf-8?B?TVFpMnBpRElhUmlpWmY4T0dLZ2RzSmFoZ0hLWTNuSmE2TXFFNFF4VVJpTzFM?=
 =?utf-8?B?OVZLUlJlY2h3bE5UbjRsNjBDZHk4ZWdrTHhkWjBoSy93Zjg4V2FTMFRRbXpG?=
 =?utf-8?B?OFBIRUFpd3dIS2lncXJKbUdYaDlXWjFqSTlkekVEV3YvZG9QQkpvUmdQczZq?=
 =?utf-8?B?amlkL3FieGFBPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a5aa60-8ddd-400e-5a2b-08da069690e6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:14:57.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lply3dm2qrqhbgL8hUH4neQSnRlpwQyig7ghYOU5awjVbSk9EwJxRxdG/JIAtbAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2293
X-Proofpoint-GUID: H-GMEFXKkXtTquj_vFBYTaNavwdtwXd7
X-Proofpoint-ORIG-GUID: H-GMEFXKkXtTquj_vFBYTaNavwdtwXd7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/22 8:08 AM, Nikolay Borisov wrote:
> 
> 
> On 15.03.22 г. 17:04 ч., Yonghong Song wrote:
>>
>>
>> On 3/15/22 4:09 AM, Nikolay Borisov wrote:
>>> Hello,
>>>
>>> It would seem direct packet access is forbidden from SOCKET_FILTER 
>>> programs, is this intentional ?
>>>
>>> I.e I'm getting:
>>>
>>> libbpf: prog 'socket_filter': BPF program load failed: Permission denied
>>> libbpf: prog 'socket_filter': -- BEGIN PROG LOAD LOG --
>>> 0: R1=ctx(id=0,off=0,imm=0) R10=fp0
>>> ; int socket_filter(struct __sk_buff *skb)
>>> 0: (bf) r6 = r1                       ; R1=ctx(id=0,off=0,imm=0) 
>>> R6_w=ctx(id=0,off=0,imm=0)
>>> 1: (b7) r0 = 0                        ; R0_w=inv0
>>> ; uint8_t *tail = (uint8_t *)(long)skb->data_end;
>>> 2: (61) r2 = *(u32 *)(r6 +80)
>>> invalid bpf_context access off=80 size=4
>>> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 
>>> 0 peak_states 0 mark_read 0
>>
>> Yes, this is intentional. SOCKET_FILTER programs cannot access skb->data
>> and skb->data_end among other fields. See:
>> https://github.com/torvalds/linux/blob/master/net/core/filter.c#L7864-L7879 
>>
> 
> Right, my question is why is this the case? I don't see a reason why 
> sk_filter_is_valid_access is not modified similarly to 
> tc_cls_act_is_valid_access where data/data_end where the info->
> reg_type = PTR_TO_PACKET(_END).

The sk_filter program is to mimic classic bpf which is used for
tcpdump. Daniel/Alexei should have more context why we don't
want to extend it.

> 
>>
>>>
>>>
>>> Regards
>>
