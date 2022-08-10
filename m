Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A158E404
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiHJATh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHJATg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:19:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F37D791
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:19:34 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JQaqI022694;
        Tue, 9 Aug 2022 17:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PwEzS1KWeJ2MXemrU04PjV6YNQ+oPhmxvjpIs3tjyQI=;
 b=BtAvacB9ncbWzGVfXUzR8Q1ih8XvWsNqxWpoVxNqcvUY04RYo3hn0NETf+q82a6kwgxb
 bm+lpMyBfdWlpSd8cPFxO1z7n5Dh7cJrFtgdFh+nzFje3H9IglK8z8pzbyXS8XjPy55+
 ZVbpexklRZnaa0yV7PRKnI+B9KDSDCu028M= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huwr8hxrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 17:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpESbzbMebA3TMSToBBUDPasX8e6XtfAjRxBXGYhqe0IeKI9f+I58ydXkxqTm1/T1VOsPr/lV1U7CNWtTPXbXNm1ApTHKwtYvEm1fxxaXBV9cguosi+Isfo/xbu3Pi51vKmbOj8O8r2R0Q1mjzvlHiaVvLDFJ2eA9OfszPkhXK2U+JA9fwKEQY/K6l6UsduyWCgM3ZhWtYrOE/FYRNhGkmdDw9q/X6yA993VpxdGyR24VXHJeedMtL43+nIKrTB997ioHIx13l5BQzOin7JLn08nIO2vVkXjJ4GhbnP/0fnLlTwLwhYxe8wViWml15/Xw11qVKrDBe21xHwqNn2RNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwEzS1KWeJ2MXemrU04PjV6YNQ+oPhmxvjpIs3tjyQI=;
 b=KssqSq4jQrm0ObsuTD2mdHaQ0lr64vhAM6qYdY3rOn3E6VkpXiNh7r7RTxcGqTJ7R6NsazHB7uC4neQtfVcVwiNeXzW72tQcqsS+w/lbzNu9YyIrlqw2Ak2oKuzZCHGK9fVXI4BKeGNWfO4SkY2TabZmvS3Jd2DyalU8IsWllXqSX6Ay1VIU2c5FI5/cWSXObL4xv4REVDrAFKevYFVyi9JuruShO+j5UrLjMHJ4DG1W720RwX98rD5aGaECPJRkuiehJzEaH+kc4GQK4FeDWgjJfInbHsBL4/sPh6vEss7WFII/ZAM/31apLbH4imAEv+H5FJTqJLELEngDuMf+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3659.namprd15.prod.outlook.com (2603:10b6:5:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 00:18:54 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::fd9e:186:4e22:21eb]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::fd9e:186:4e22:21eb%7]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 00:18:53 +0000
Message-ID: <0bc4545a-817f-e618-a208-79fc2a25a9cc@fb.com>
Date:   Tue, 9 Aug 2022 17:18:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 7/9] selftests/bpf: Add tests for reading a dangling
 map iter fd
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, houtao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        Lorenz Bauer <oss@lmb.io>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-8-houtao@huaweicloud.com>
 <32e803c8-4042-2d01-0249-b6358c0fb627@fb.com>
 <695edb91-dabf-2bff-9cba-12eb64162b1e@huaweicloud.com>
 <20220809191357.ut6cza5x6t6ho4ej@kafai-mbp>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220809191357.ut6cza5x6t6ho4ej@kafai-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5928fe70-643c-4027-3498-08da7a65e2ff
X-MS-TrafficTypeDiagnostic: DM6PR15MB3659:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLSpwATMmkLlEM7Ui7xAYJ+YiedQ8dVL10bf/NZ9FlnOsQ/pevPuDu/jmwojlLvyIq2nOvM+pZLUw/wX48OdOdg4BYnq9SSNLItxb4f6YVI+m1NYGevZXni2ddeTaeb+MeyuYRQoCvRRjSIGjkG3mwdV9UlbhTNeiCOySjCK0hn3LkQS1FXV4vZ8X9jHgeZOcRNd2RCP+ox0APotYHAvy6hRz2cS0EM6Mb91i9oTjLNfcAhiLkNkwJcCOCe4CXWXk/isJCZfyqZ/H6Q84p9uM1kscBkmyYDbyqkGIFzIclCJeST3x1+NpMBxzcTPHJuMDvFiZ7SMQmmVliKf0sav7yqNFfLz+QMcYjNizh/+u8bXxnKzltvuKKeBDlGmdGNZeO7dIRuM8WMkLGJNeVWdtQiHwpYCvBRwlR56rKZARsgIrCex5JNGuRWoOYWPuDoJiz+nQ+aGOX62X5spI4TrNsOZRHMnYnklFXrDcJH53VRNdOaWVI30mSCkQv5s8paVYatP+MO1dR1vaBPEHQNvShNII7O1+9DFJePAQ0Teqw5nPmqLwZdKe+BLwWhSEALvVCt/9lwKA8cdIhpifkMqB6JttZOUPgfqTp+i6Y3DGzdSSkdsEzbTojvsAsJhrgxBAmPGNCg/PJiQ0TTSXU6WCbw1SdTzijC2sQqzR3eH3T24W7gdsWAh+FywPXHE45jElPYM/YBIGgV6YXHjOKfLMEtkdrE8fW7h28sMyTzLHJZoE8dINjL6lGt6hEio1JSl0XI+UHzahmUDalnAVuwKY6KfZkThBquBlRnwrDx8DsuIG/xoUWkv45gq5CPdhEORHi87YVtFMu7lFp6wzrva6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(8676002)(7416002)(4326008)(66556008)(2906002)(66476007)(66946007)(478600001)(36756003)(6486002)(316002)(54906003)(110136005)(86362001)(41300700001)(38100700002)(6512007)(31696002)(6506007)(6666004)(5660300002)(2616005)(31686004)(8936002)(53546011)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDk1ZUdVdDM2VjdKdTVVdDZ1elN4dEM0Nk94UlJlZUgzaUxBeHhJYXcwbXly?=
 =?utf-8?B?a1Y4QXZGbWE2RWJDdDVlRThGZkkrTjRCN3FlUUxkczh0T1FVV0dqYmdUL2Uv?=
 =?utf-8?B?MG1ic2s2MmVXT0hnTGtZQXFMMEZkNU5FZmF6K2xwM0xIbXE0TUtwVzFMZ0lE?=
 =?utf-8?B?MXg0NHhmWS93QWZFV1hLekdVMkdkeFJkUXhqY2ttSFQraGp5SXdVY2RBQUVE?=
 =?utf-8?B?b1JGYktlMlpudEFadE1jK2VwR3J6ZXpMa0VvUGk3U0VIcU1hOU10SGVCOWdl?=
 =?utf-8?B?elYwS1ZJVDR0ZUo5QTl2TkhTcWwrcEFjQkNaVHBzVW8zWDBScm8vbU00ckEz?=
 =?utf-8?B?bWJmWTRqQjMwTnlTMFlSMFRTU3FsMEhDWU4zdkRpUEs1YXNOeHFaM1NrRlFI?=
 =?utf-8?B?aTM5V3cxNDdONlFKblJUSjNDanFjcEU2RFZIaHMzam82V2drUnV4SWJ1U2sx?=
 =?utf-8?B?L0RUTGIxOUoxUW1QUzVOMkZxdzhxUEtka2dadTZGeWlSdDY1aVI1SVdBNDJL?=
 =?utf-8?B?WW4zSmVPZ3NHS3BlYmg3VUdldUtqWGhNQksvVnZLR0IzUHM0WThueGY2WS9E?=
 =?utf-8?B?dFlpOGZYclJZK3k4dUVwOVJPMVM3T3VXdmhlSU1rS3c0LysxcjZhM2luZjJv?=
 =?utf-8?B?N3NqWndVUXlnVGhWNXIveGtDL1FzZWdkS2JZUUd6RTE5RjdWcXk0RE5WelZn?=
 =?utf-8?B?bDI3bm91OW9lWkU4SkxUNk5oYWhFMktxTmlMWUNsY2pKN1BwREt1YlRIaHR3?=
 =?utf-8?B?dWpyR0NaY25UdlhvZzduSE02ZGRYOE95L3RWa2YrdW5ubnl1eGRQMXhMU1cx?=
 =?utf-8?B?RnA2NlNWZHlNQmJXTHpDYlRzTDhPdkROK0xoTHBNbitJcktJeWs2QVgzdnZv?=
 =?utf-8?B?d055K3dHUHhKNUhRaWphd1VrRWpYQzJHOXZIcVNxK1V2ZHhqUjlsY3h0LzVp?=
 =?utf-8?B?ZTAweXJlQTgvaFFEczgxT284aEZYbFhqRzZ5VnYwdkxjREZKcjYvZkNjek03?=
 =?utf-8?B?SVVuUWlMWUZ4ZmlwemtLVXBWRlhKU3J0YXgvWGE0OXQvNFFIdVdSVlcvMk9m?=
 =?utf-8?B?UU1yRVRKSDJJV2FpTG1xd01vZnBMTmgrYnByQmZGenpJWkJnYTU2SUk1ZEg3?=
 =?utf-8?B?ZVprcXFVZGg0UDNHSWpPUVpqaUJUOHF6RHBQVEJPbXpBV2YvZGc5WC93RDR1?=
 =?utf-8?B?M0VpdlhseUZXUUU5UGJWTEUxMmVaYjNvQk5WZ21mU1lHV3hxaGNkenlHMkFK?=
 =?utf-8?B?dDl2UkxYZDRNcDIyamtwL2xEUlNkdE1ndTNQc3Z4STNsTjlISGRrbDVJMTBN?=
 =?utf-8?B?aUorZ1FhV1NSNys4RTZ3b0ROd1I4elR2NmVDay8weTVxUmd3RU5oMkpTT054?=
 =?utf-8?B?RlplbG1JZ0lNeEpzVXdQcERCTmMwM0h2Q0FQdjVJbzdMUmdBR0U1TW5uMmo4?=
 =?utf-8?B?OTZRU1dzY2Nva0N5RlljTXV4ZDMzMjFoZTRpZnRiVnVmWFppUWF5aWxzV0VY?=
 =?utf-8?B?NHArSCsvU3FQQW4xaWtyN2pxVExmOFlxRktLUTh4NWtCemw0NHFJTmJhS3dS?=
 =?utf-8?B?M016Qi9kTEdaMms4TUdCaEdDYzRTV3VtTHR4VWpWZ3JxRVNJOGZxaTFEdG5a?=
 =?utf-8?B?OXA3Ym1TZVVWTWZod2xBTGdKN3haMnNtcjVhNmRZU1BnNWUyMUJ4cVhJYnBz?=
 =?utf-8?B?ZWN4YnZRRmdpbkFFSlZENWphOFlCaSt5M2xjQlJ3d2lsWEg0bVRWRUdrNE5W?=
 =?utf-8?B?NGpQS2t6cE1CbHJLbmtmaG1TdWM0UVdDd2RwVjBXWGJENUxGQUxMSXA0eDNt?=
 =?utf-8?B?K2ZBVDNFeE5pNzZZdk15RHpSTnU3dDBvcTR4ejkydFAvUkUvcS9pRjY3UXpD?=
 =?utf-8?B?ZmF3QytYMXRpb2xYS0dpbHZkWXBIY1RodXZrTUxQU29udWxhWnpmK29lQzQ2?=
 =?utf-8?B?MVU1eE45MGYzamRiblgyQ2JjOWQyNGJOSVo4RGd3TGdwRUlBZTFhaHMwZGlo?=
 =?utf-8?B?OXNVeSs1R2R4TllZb0dVWlpsQzRrdVB3ek5mRkEvSFNnUmZnZXBhbVlvS1k5?=
 =?utf-8?B?V1E1R2xvZXFuQXBhUzNxTWxEWnU4YjZ6UVNFQXZyR3JrSzg2UHdscTZNMVdU?=
 =?utf-8?Q?OyCwqL88+FU91Y9kywemj9zoH?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928fe70-643c-4027-3498-08da7a65e2ff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 00:18:52.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETmC6M3MC2uE01Pc3SAjCrsSThpw9Tn7a7PiNOP2gMAs6v59S45+9t5mpHRwSdv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3659
X-Proofpoint-GUID: y_6kDbA5K2Isa05mjGxY4OCizUSBqmo6
X-Proofpoint-ORIG-GUID: y_6kDbA5K2Isa05mjGxY4OCizUSBqmo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/22 12:13 PM, Martin KaFai Lau wrote:
> On Tue, Aug 09, 2022 at 09:23:39AM +0800, houtao wrote:
>>>> +    /* Sock map is freed after two synchronize_rcu() calls, so wait */
>>>> +    kern_sync_rcu();
>>>> +    kern_sync_rcu();
>>>
>>> In btf_map_in_map.c, the comment mentions two kern_sync_rcu()
>>> is needed for 5.8 and earlier kernel. Other cases in prog_tests/
>>> directory only has one kern_sync_rcu(). Why we need two
>>> kern_sync_rcu() for the current kernel?
>> As tried to explain in the comment,  for both sock map and sock storage map, the
>> used memory is freed two synchronize_rcu(), so if there are not two
>> kern_sync_rcu() in the test prog, reading the iterator fd will not be able to
>> trigger the Use-After-Free problem and it will end normally.
> For sk storage map, the map can also be used by the
> kernel sk_clone_lock() code path.  The deferred prog and map
> free is not going to help since it only ensures no bpf prog is
> still using it but cannot ensure no kernel rcu reader is using it.
> There is more details comment in bpf_local_storage_map_free() to
> explain for both synchronize_rcu()s.

Thanks for explanation!
