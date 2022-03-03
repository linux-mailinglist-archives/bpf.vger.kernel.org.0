Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778B4CB43D
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiCCBK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 20:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 20:10:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B6F5430;
        Wed,  2 Mar 2022 17:09:44 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMiOk029824;
        Wed, 2 Mar 2022 17:09:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vvUDA4V5Y58U0rcUf6z3or8jqpZUsp1Zq/Rtm56GTsg=;
 b=mQyPZY0FTwWaN+xGmetGiJ+2tQ0wFloMW/XnGRStjZ0/97a0G+B38pi25YER6spQiXgq
 aV2DxNp5KJbU8pqN9WCHu0DKPKDkUxYmilt6ZMwqI/tFcKm3sEPeuoyFm02aNtGQAnG2
 T6iOdeUzgJb5MtCH9m5xpN4DHhU+JYF3PKw= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej1r0sd4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 17:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2K2hYuXPlEVYa+WXWNw5xXn2i3VSoxkRHVNcdZ3KKf9w/Qn1Mf5RHtwQ0MtVBAA3hxB8j+KtQt982qC+nA1HSw7FRzZ1AwPILGb+/co/jyQwUQNde6GTZ/8DWXVND5hufY+Cyc1YVbVjRzzMJ2p2vfz0VZdCQwrDvwCC7leKZQZK52ejl/2L6O+aOBBuEsB5qSfgCq0esVIDrqMqTGBOBm0E/6xvQiaMa9ZbBIpjdmJorIvlxUwXg6n6hqSTVx03X6xqnjmkH1eAKxH8Qe5Hfl83aMhZ8DQaIRr2sq0r5bpPYf/ZTJX5usN2sRMQtcqzxlNjMOqX1E91+Oc1znQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvUDA4V5Y58U0rcUf6z3or8jqpZUsp1Zq/Rtm56GTsg=;
 b=c5vFxhVfnkJmWaGrrZstJJ5ScHHC05QaSKLnrQgbAj9KizdBQUC5i54alNwn72jFG1i7vgivt5gripEPv0MGHtkdAqGvpOhqPI/WxBCgqLeBbXkh/DBlNOlQqBNz80h3jd6xxUj2Fy7J9KrArqKM95lQCJ7zvrcoSTfERHT7Xd3NUVY/rttezycZTs0x+AfH6e2bwkZFZL9WUz5hJSqRBSYeih3aczLu4fsCuBFCoRPA93qvla206iepstgzabFOavcziUfc3iJu7pZgsRVoK1Yb+htWkexJ9CUS/N0KHubFfMOIu7Fxl6EExejPmAad6FAzHQjGCAFjcw5stP6VUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1892.namprd15.prod.outlook.com (2603:10b6:405:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 01:09:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 01:09:02 +0000
Message-ID: <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com>
Date:   Wed, 2 Mar 2022 17:08:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com>
 <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa4aafd-e6ca-4172-dc86-08d9fcb267e1
X-MS-TrafficTypeDiagnostic: BN6PR15MB1892:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB189201D0FA5A3A53430DF387D3049@BN6PR15MB1892.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QMpHbwo40SG89Z5prPw5Hj1cbdtiF+CmOLvjv0ZWh6gfR6g16WsUDUi2sPAiAC4kCjZiAq7L72Sxe2tNPJ6Oe5DGIjUfxx5J4BrUgWogoDZEza8end+n1sW+rbkxv4FUIW3vvm2kgvFfYtP7kQ+74ay8gmnt9hOHkAmusPUW/eLQJAK1MXa6Cte+aaAnXBrvTnggoexGY8CXO1QuFA2lBTjaqs7sQGXYAEE1DMlttIN2gmWbR6IGmiZQSbpjK7VFnwm2uNV0TQZPw9v9TUBPkgB2SBi3iMcGcx/65Jwaf7wXXFgvN5KDKGT/Ps6h+Men9GZUKl8O0HyvlPNhIzIoGSJQI0M/wKnH6UuJiQh2yk3fk9Ga6Dfu7NiWcLlYWJ4HI6zk4zPOMSzaTOxaDoqHkL08IzUIKcBx7UrsEvUi7FadXQuSijbPq/T9pOgiE+JXf+uONOIfHyY9WoruFyOl8GWWmGf4DwBEN7XZR+yOVaXNL4HDxLfvjo+9ii08z1bg796SP3slauirC1EtGwD9fJeVoB1f6evHpRfhPMY1BlezaurMWXN/4ts6sKCEpvPUQtuMxTkZlEYk8abjKq/U5h2Gh89FZkPIso0pPEJ747SVD6oGIckovHfJAVowvoGrmwfm4ksX8qTRY1b7xn4OG94+gK7BhVvhkyT5i8dFD8Zef3PLwqz4UfQsVySUgk364R1QKgj9FSSS0Fp/Moy2ik2t6UDrnxgvaaevgTI2LkTUS7mNL6svY5Boh9Sb8FZq6iwCkiTVhMrsKkIpZwpNNXvCTD7J7uEyadW6AkBTrNgwTgOaM0BLKan29kBNXlg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(186003)(7416002)(8936002)(5660300002)(4744005)(2616005)(38100700002)(53546011)(52116002)(6486002)(966005)(508600001)(6666004)(6916009)(316002)(54906003)(6506007)(8676002)(86362001)(66946007)(31696002)(66476007)(66556008)(4326008)(2906002)(36756003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZkOVR6OVd4OVJJcDl1WU1FQ3kvd0RuQXk2ZjMwYUV4OFFIelB6Y1NDa3Rl?=
 =?utf-8?B?WkR1RzUwMk1zVGdRRHlQRmVZVXlCLytURGs0a05WZk9BU2VoV0Y0cldwSjJ4?=
 =?utf-8?B?dkM2S0NXN1NCYjFlYW5kaC9sbEx6RUVBNHczUS9xOEc0bEg2SFI0VU5CcEVo?=
 =?utf-8?B?OFdEZHZxNld1YkRPVGlCQ2I4N1NGdEEvKzlKeDBFbUF2d0ZhWko3WjIwQWFZ?=
 =?utf-8?B?L1RLS1lEd0FMUWhycW0rWkR0cmtpaSsxM1h6UFZraVlvdzlicEFHdXZGa2J2?=
 =?utf-8?B?RVNJcFNnNVpPSDdiNkl2VW40ZU9YQnI1ektCd29aMHNCa1QyTlVzdDU5MWtw?=
 =?utf-8?B?YlFZRkVqd1N3b2pvS0lhOW5XSDd1UzQ2L1Q0NEtuWU4wemozb3hCVWgxNlBO?=
 =?utf-8?B?VW0yemJRK0hEQS9QZVFtK1hKY05RaWQxTmcvTGt1Q0V6enpNVCtLWlg3bkhD?=
 =?utf-8?B?Vi85NWNINGFjOWNzT1JLSi9KQ2dRVW5PbUFnNnZ2RVpCNzV1L2F6WVJnMElt?=
 =?utf-8?B?aTdibVQ4NGpia1MrbGlaeHNpeENHRDJLd2RwNEUrekQ3WDM2MnlZek1oNVJk?=
 =?utf-8?B?UWV3RktMLzU3b3ZwbjJHQ3RIamxGRXVGMXVFWG45bHBrSU9iT0Z4aVlFQ3Iv?=
 =?utf-8?B?Y0pLa0JZTjYxY2FDQnhVSU5oNUgzdDcyY3cvTTZSeEd1RGJrOWptUDVXS2hF?=
 =?utf-8?B?Yi9VK2tiTUZid00xNnM3MnZLb1hSOUw2eldrL3E5MkxUTDhhekJhWTdINXZU?=
 =?utf-8?B?Nm5hNWVjUVZKbEpqL3VLLzYyckZFWVRYWEFvM29uWlUrYmFyZUhPcVdMeDZl?=
 =?utf-8?B?b0x0Ynd0UHV5YUlUK3Zvd2cvWlhQcnFDdnE1SVdYZmkycmF6eksxenhpY3Ft?=
 =?utf-8?B?MTVDOU5mc250WE9iNitrOUwwTHNZUXoyNmRud2FmcEd4OFVrVTdnMDJDZDJD?=
 =?utf-8?B?Y0JCZkFrU3RPVUp3VnRHUU9kbEN6WGZvZnh0bWtweldGSldoMElGWlhmSnhK?=
 =?utf-8?B?V0pLSGxZWkdROVF4a1ZUclNCTDJHeVZlSUZnTXp1UlRhWjRtSzhwMjJzREhm?=
 =?utf-8?B?M3ptODBRbGdBd1g3Vk0wK3NQNG52REgweW1TMXJLTElBRUhlbFd5SnpiRmZr?=
 =?utf-8?B?MnhvcUVXekE1c2tUZHFOc1hJL3dMc1VGVlFOVks0akFoOXZsUkM5aWhraXI2?=
 =?utf-8?B?R1liVTlVSktGQnUxeEI4UFB6UU5JbGFVeW1OYmgweUdyOWdDODRNaE1SMlZ6?=
 =?utf-8?B?VUtsTktqcnYzdTdNTFI2NGRvYmRCK2Z1UWY2RWtTMHQwT1F2L3hORHF4bkEy?=
 =?utf-8?B?aWo4RE9reTI1R1hyUFkrMWt6bXhFS1JVSVhoeEtrTklyOHpVMmdSQlVVWlNr?=
 =?utf-8?B?WTlvT3l6bnlpL0QrYlYwRU93QktPZ1hJaW5NeEdBOXdDSU9KRDRUc2NkTmlk?=
 =?utf-8?B?UnVqZk9kZTZQckFlSlloZFMrbVIyNEE2bE5wOXIxTVZnQnRZZk4zTHlPMk8r?=
 =?utf-8?B?K0pVZ1lmZ0FjcURjOXQrWnJsTEZ1VzZPZDhIY1BhaENpcUxsNzErN2kxU3Fw?=
 =?utf-8?B?VUlKMi9WbVcwWVJRUTlKNy83U2x5RDBEemR3RndPdDlvMFBMMWpHZ2g1ZFJJ?=
 =?utf-8?B?S3k1SlZJMUdXd3N0OFd0S0x4cktlVE9xSTBmNEJwQzU5RG9TRkxUVmRqYjRt?=
 =?utf-8?B?eTQ0L1dUbGtjcTVKN29uMlpxSmhhcTFIQlZzVjA5bWVMQVNNZmRqVGZaaGtr?=
 =?utf-8?B?M2YwWkJOTm9uWHZZdTZzTkRSTzFwVWJkZzNzMm5DQ2t2S1FQdzh6NWFsd2U5?=
 =?utf-8?B?VVdNRTZXN3lKOXhHandNTzU2QlZQVHFIeldrbnJjNndqd2RxV1VyRHU4a2JC?=
 =?utf-8?B?VlA4SC8xUUtEVFBNVllMQlJHY0tDb2h2b2JDUnRabUtjblhTRldxVmE0dk9z?=
 =?utf-8?B?YzV1RXZtblRSYlBnT08yUHRYbnJNdjlzQjQ3WWlkN1BUcVB1b2RjblFTR1dE?=
 =?utf-8?B?Z09PS2g5MUxJbVNuNUVqa29xTXJ4Yy9GTUFsakR6ZDMwTmFkTTBCQWlIRHdM?=
 =?utf-8?B?YUhnYm5DakE4TUxENjVjSldZTFNleitqYzcrOXhSL0o0RDZlTUEwek5yby9Q?=
 =?utf-8?Q?Le58CDVAFBE6pn1L3UJp3Pkvn?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa4aafd-e6ca-4172-dc86-08d9fcb267e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 01:09:02.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/zUGx2cSJZJDX/U4hHTNP90DW4cYul8WZUQg0WgyOq69aGX3a4Lz5gZJ6tb5vNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1892
X-Proofpoint-ORIG-GUID: uVqz-R6VM9uTCAPvU6UenXk80olUmI6S
X-Proofpoint-GUID: uVqz-R6VM9uTCAPvU6UenXk80olUmI6S
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=701
 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030004
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/25/22 3:43 PM, Hao Luo wrote:
>>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
>>> the handler to make calls that may sleep. With sleepable tracepoints, a
>>> set of syscall helpers (which may sleep) may also be called from
>>> sleepable tracepoints.
>>
>> There are some old discussions on sleepable tracepoints, maybe
>> worthwhile to take a look.
>>
>> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> 
> Right. It's very much related, but obsolete too.
> We don't need any of that for sleeptable _raw_ tps.
> I prefer to stay with "sleepable" name as well to
> match the rest of the bpf sleepable code.
> In all cases it's faultable.

sounds good to me. Agree that for the bpf user case, Hao's 
implementation should be enough.
