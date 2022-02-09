Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8257B4AE606
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 01:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiBIA1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 19:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiBIA1T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:27:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6B5C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:27:19 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218LX2nV028171;
        Tue, 8 Feb 2022 16:27:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4Ghk0xDvmByt8ONt3ZKG44ayPRZkCkftskMuQjpAiGM=;
 b=M3ZtxUbB1dw3Fy+UxcLa43D/LOGPoacuyWqv3bbSHYPqqW/D6TMLur7/zuXtF7H6osih
 QDLN0PI/Npt5QNO3Ql6WFhThXHiuzQg5Cp0GvTAv/M/kasFbSOqbM6xgbIQeJtDOOJnj
 aZmMobYhQGc5TCOxyMkwyriFaDUkJIpG020= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3n0c5ymh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 16:27:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RttFZHtICVSQ7/oUQP4W8T4FFsaMdSA73LrVlHLkQ0FNfizrIa6GGchIkVZ9gDdgGJ/Bw3Fb+FdiRTojPJEThUcVx4QB/K2xhVSJRsQGrgZLLfNBNMBrPYZK911ACk32pi4XSRxINZ4EcXKzrzOuUOTWQBCvMBke3JAWRvtE/Co68kAnxKXuZYbKpuY60mKinBCiT92zg24eLUVREneQ5rue8b0SVoal9jfew9Zr0nR4oHfZTXIOvLnjQrcpggh6Wu+A0YnZVs6JAUMj+rDTOm2TD1IcJW9ReioEdCmIWfo6c3Xw2DLbgxDmN8HXDiXn7EI+HWx0jr1EujCFMqJWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ghk0xDvmByt8ONt3ZKG44ayPRZkCkftskMuQjpAiGM=;
 b=EFVhroRdvrwdlOOz6wK8wheuQszrvgZ+9xsz5JUKJrOliSGHvd4qAzNmGq/JvhcDR1a3xcjAS7a9xd/Z54IRLNGbyJVvJN9EteURmKXvkGZngMEpQtiTEHtNb5B2LdubkhKeI6UXTBIGfJGhmZbPYwn/t5Vzc5jOtjhrgyqymJWBzA/v1oQpnHP890yydl+m7PJ8PmrmYXv2TKKbMPWmgMIVdcnbqwFw4mfj0j4xt5NdFXwXVvdLQKn24hjrbkqFVqdGyaIO+iS7D/nRAA4tiGnjOY1M7aPS/xEXihcAC2S0Yy2jYbef6dGXkZZeh0dBt5TO6B1rroAluQItKYJXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3308.namprd15.prod.outlook.com (2603:10b6:5:16f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 00:27:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 00:27:02 +0000
Message-ID: <0a6bc9bb-c556-5017-3c51-5cc0840cc2eb@fb.com>
Date:   Tue, 8 Feb 2022 16:27:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Update iterators.lskel.h.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-5-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208191306.6136-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:300:ad::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d56700-ed4f-4122-e737-08d9eb62e4c4
X-MS-TrafficTypeDiagnostic: DM6PR15MB3308:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB33084657A1A309458C3C5172D32E9@DM6PR15MB3308.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 318G2f+EgOoT3qRI5yCCCp30wGDrmxOXsbBuXQhx4l56BdIvoZM1Quq+ZbwZRhC33lV8jWqNT5kHGMuqSRKOe3gTS5ycaX25NS75A20wVlHpNFHNOemFUZoK4Wpfg2rxOt4yajgGeHoHj4DyhNL6zTEXo0YkQ3UzN9ERoM8ohqUG3h59K1KdSey0CpLN9VYFDwp8wi4xelKzgJAgyl9ZzurHYY+3MOLU44JWp37Mn37BFRcau7R/TeNUiSfaDFjqhnQSj/HRW8CBYsrH86d73T5xVCwdkfBV5lIgU+SBvyMjgdzvf9XpqTZWJfamanWfI0GoBKLWH5BQ9LDnk7V77OmgfMiC4TVAY3Poxj9fmgVyDute3NgOe4vGz7peOv1sbzcoEhcr6FV+13ZffpB9A2BLYROKhZsW4YBHWaEzEZ1YYw6uEmQHZ9K86JIUKvwYOla6XEeF5sB/2MhsPrHdfJcVyTBoEC8HB/fopWcGPXrQrheoufA9u0wO80H8alpETKMQarzD7n2SHuxNwHFFr2WK9bAcURoq4qqoxdnrECSE2QTwDPecwBq3GHWxjqOBpfne4Uz6JpvfCvaqJFA28q97busjPWozL8lDvnKWOMVitFRbPCJUhqdEZI/OTlbv6feXZdHofWdD+gaqDP/NbYONbx8acUZazhr/P4URkm1KE9mOLb0CMaqUEY+LcQ30DcRxf7kqKU+QWQ+dt7pST/HuSXdeQjBfdAIU9z7t0XgWwTYre4uK53ZW4Rq/3GYA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(83380400001)(66946007)(316002)(31686004)(2906002)(186003)(2616005)(53546011)(6512007)(5660300002)(15650500001)(86362001)(38100700002)(558084003)(36756003)(508600001)(4326008)(8676002)(6506007)(8936002)(52116002)(66476007)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRkSHFZMVo0K0FwOWNrSVZERzdlL0RHUU1YclJKWHYvdGsrNFhoN1AxeS9j?=
 =?utf-8?B?OEdvcERWVGNBekNJdEVINHM2V0lhRzdHaXlXeXdQZU80aFQvNUhUWG5xL0xM?=
 =?utf-8?B?U0MvbS9SaVI4Z2lzRXBNY2RYWjk1TjE1RlFENUZxREtnV05TUEVHUUM3eHoy?=
 =?utf-8?B?V3pzUkxRazhMZkdoN2hxQlAxbUo3cWdRelJqQmJlOXAxRGN3ZktNaVFZSjRP?=
 =?utf-8?B?NmxsZW1OSm9EOHZ0ZEVMZ3hBT0pLZlZMdjhrY2IrRFRwYWM0M25ld1B4bFdU?=
 =?utf-8?B?ZFg1TWV3c0gwNkY0VmZxbzJGSWVwNlIxMjM0c0cvblZKMW9UUVdid0d0RmUy?=
 =?utf-8?B?amI4SDdGNTRFV25lMEdpVU9IK25RbkFKeFpWYW55OC9LWWZwYzJkclB1SHNB?=
 =?utf-8?B?alRXZDlyQjQrRDgrNmc2UTExQjF5LzdvSnVVWUtDNVl5OGtJb01mYm5tNkw3?=
 =?utf-8?B?WjZRZWdYa2dCbGxjNXE4aGxDamt1NHdUTy9kSkwzZWw2TkExc3MxMk11UGV5?=
 =?utf-8?B?U2JSZEp5UVpRWGdDWTJxRG4rb0pOem5PVWNSMHk0ZXJkNUlNanBkUkRPNmtL?=
 =?utf-8?B?M1ZzS1JmeUU4OFg2MUhwVHJVVVZwOUtvVW9FajNoL1dPVXFzd3FLMWJWdDcv?=
 =?utf-8?B?cnZqRm51S0pZbGFHYnZDRy9zRXd2STRXMUF5WWNGSXRPVGRpemtBcWN3Y0ZN?=
 =?utf-8?B?Q0w3NXUxZjJIRjlGRzhzYU1IS2J5c09sY3diTFZZMG0waTBFN05majFwK0R4?=
 =?utf-8?B?Vml3bS9hZWFXeEFMMjFPSzRXZ0o0c3ZsMTdsSElsQkZKVnRRZFVZa2ZKSjZt?=
 =?utf-8?B?bCtjYWJMaVIvOWhxSnBkWTdZNEloNzVXZ3Vpd1FuK1ZsL0w3bUFGKzF3cVBS?=
 =?utf-8?B?OXdtVVJBaS8vSEJSdm9nK0xIbHF0OUlvRGtGcjdWdG96ZHB3UmtIT2J3V1pj?=
 =?utf-8?B?ck55R01qUTRNVzNOMnhybTJRNGtQY0VBeTYxNDJHU3EzT0ZIVmVLODBLQ0lK?=
 =?utf-8?B?OXNNYlJvckF5c2dBcUdJajBGdmhISlljSXl6M0xXNi9wWXlIREU1dlBzM0tk?=
 =?utf-8?B?T2xWTlNNWTU2N05mdzkvNlNEQVZMeFpVZzFQMWM2V3BqUVl1ays0Vjhhc21k?=
 =?utf-8?B?VGNwYkZvWFJQZkt2eVFOZ21kK3NvcUIxYzdoZmNMUjFZRmZ4MGt0dTc3ekN0?=
 =?utf-8?B?SDFoWjVqOGE3Yy9pWEhQdDJGaHViZkEyVG1iOHdLdndUaU1qV3dBK2M1RnFH?=
 =?utf-8?B?MkR0VmhTTlVrcEhtVzdKbzVqQjRPbHdmWEd4TC80bWdZZ3gzV2I4bCtQS05s?=
 =?utf-8?B?NnVsM3BKc1drU0p1cmFRMTFEbTExVTlLQThQOU5WUmdzQnlxQ2tvdk9DVU9s?=
 =?utf-8?B?VGxCT091Qk9KYUdMdFdYTSt3c3l3a1pUUUtpMzZHK2RhbmtRQnZQazU3anhZ?=
 =?utf-8?B?QVRzTXNZdVI3czFWUC9YcVQ4OHJKNnJhaUkwb2ZOREVNd3JjVFFrcTNJYXB1?=
 =?utf-8?B?RzcrcE5neGdKQkZnRTBTeVhyakxYL3lPY2M1TUdxNXdZRklPc2ZBWE5zSVNu?=
 =?utf-8?B?cnpFRzhnMTU3Q2JaRUs0c1c1U0NUMkpHTUJoYmRPQjltMmFKYXBwT0NtNUZm?=
 =?utf-8?B?YndpK01NMzNTU0laVFNJZG9EbUFON09HRUc2QjRLa2FyZE9HUzdWOTVhbG5H?=
 =?utf-8?B?YktPK1o3OTNSakZ6QkVJdk9aMnVlZDdGaWhzeW43RUpXdi9LS3R2UXRGUFor?=
 =?utf-8?B?bzlncWMxaG0vS2dteThkbFRUUE5yT1hkRzg5RytjRUtscCt0UjRFdnIxdlJW?=
 =?utf-8?B?SWF4Q1ZaZ1pLOThGZDl3aG5IbXFYSERVZ3d5MzBncWcyNTdjTTZsNkx1OFha?=
 =?utf-8?B?UnlyNXIzbGpXei9rUlhRN2tGaWtFYUxMNHRYM1hJM01uQnp6TWFTOFdPSU1v?=
 =?utf-8?B?UzJ0ajJxZXZVa2svMjBELzJGa20yalh3RnVCR3lBZEU4V1lEajM0SkczUGov?=
 =?utf-8?B?dlhrMFVhSldMVHNaYzQ4L0pvc3U1NzF4d0RoRkFya1p2OEY5eUNTOEpJeFZC?=
 =?utf-8?B?bWZNeVlhQ3pWUDJ3TzNDU1JkK1A5MXgxa1ZxclMyZzhTb21rUk5pTTNreEEr?=
 =?utf-8?B?QzZTYzE1eFV4K2JCZzVEQ1hiMUtPNnU1VGJud2R6TTZvL2ZTTTZpK2htMkdM?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d56700-ed4f-4122-e737-08d9eb62e4c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 00:27:02.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5suJwaFZeJcw2RqO9+ZeA3Hyroszasam7RfDQ6091EBt6iVG0c0M7gCP3gf9no8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3308
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2OWDH-wbMX4PPeifus99J3LdCMRJBzix
X-Proofpoint-GUID: 2OWDH-wbMX4PPeifus99J3LdCMRJBzix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=735
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090001
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Light skeleton and skel_internal.h have changed.
> Update iterators.lskel.h.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
