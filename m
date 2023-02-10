Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38840691653
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 02:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBJBp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 20:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBJBpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 20:45:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46036A735
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 17:45:54 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319N49jK019097;
        Fri, 10 Feb 2023 01:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=EC6xdvFxiQzYL1SPObskAKED/snW+aGlir2lugWIZVU=;
 b=WsdqC63nkleSViwDMeZPEwwxeh1U9NF9FII4msL41WpXqUozlbt47q61p2B9GIe3TIFk
 64twoex8IGC0IgaMgGFwuEA3zTjGYppOYVTGHgmuB7nq8Do4JVf8cZN2Nab4wYlIvqGF
 2BaH9jafrL9hHANng556ZqSj32mw7KkuLwtpABGJ576NwwiYPghBHRBiIRDZB+klLjdm
 LmhpWm5LX4eZTFs5tdQLf5WEt94xRjmkfgzPEiHQ2g0oZElAlskqT//YVhreF7rIrjo9
 z9684+fno9GIMBjizRjk17sQRIuRppXT/W6le6h4BBHwhPrWwEU22cOSJE5+8fEgz5Kn Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdv7w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 01:45:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319NsvQa036019;
        Fri, 10 Feb 2023 01:45:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtg0er4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 01:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HspE7xxuWnM1rYTDUVPb8AL949Jpmp/0vLObozH9yMHHkzQNizZylxbcnd+jY1HjKsQIzYSpkZbHkcNm+2qXeXaA5noIQ367vnZv89rh+JzwcSipk6fU0VNpipICkV+6RfwPdnLpid+v7jgLI8QRhA323N+u3S4ZRYDaEmHHt/+HIXNoxbbyRlPiXBvxj60O4u3M48XyPQYBhqKG9XVrbk1CFG9+OdwD1FyGu5o+YrF31JuvHTSDinylbvvdBH/D97iX9Oq5Lc+eE+QlB2Iz6qY7nRqUHrwt40qnN4Wj3j6cwnzcLyUaOgc2Kh1WsKC33tQF+gYENzEAEHyZs4QpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC6xdvFxiQzYL1SPObskAKED/snW+aGlir2lugWIZVU=;
 b=T9rdCK65H/08lBdTXY2+GV6mhX6vVfJQRyozCkwsKODtyA08zgF3jPWlDC8mMR34i9eHN2dhYrKJ9AjsaXtR67ZSL6rIqTfPUeN0Iqg8lMgKJKb2sbI7TqYzzNKpOK+DEckGD0gSeqCbhx2mQ+3osRjLiZ0t4Dg0F6bIpB844K16pZITVmNsl8f2HjXVuAqR04S4nT6I6Ia6UPem3igaSBCR7WGSK8T9eIQKZuvD2IMPWmdp7UGUenYMSzo/2HASxgB+GIoZXZvw6EThU1ZzZQFKGt+F0SrJD2UEHa1rPH6yPqX8EUOMAdz6LPROpTANqI9NSSFwhvx9ZBovJFstwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC6xdvFxiQzYL1SPObskAKED/snW+aGlir2lugWIZVU=;
 b=P3VFG4WTiiC1wWQBtvsw8c2J++Q89xrv8xKcwawInpbT9mUynDh07V9gMUq4dKRdxNk78rOBt2WSh9i9PK778zwjXMy25fw6oNIGJqs4I22DCQvSDmjISoZXD3EDyLP6CYjGZdZLBT5M7FSKZvedHG2uvC6OXC7DGm4fzrgRMMA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 01:45:31 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 01:45:30 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
In-Reply-To: <87fsbe8l8n.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        10 Feb 2023 00:36:24 +0100")
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
        <87fsbe8l8n.fsf@oracle.com>
Date:   Fri, 10 Feb 2023 02:45:25 +0100
Message-ID: <87357e8f9m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d19a57d-e07e-4786-2b66-08db0b087df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrcMXLlZsBJSLBqTvUCbuDMegvPPZhWQilED3lUAoHIRqMnN8DoPc6aEZgJ+jUOFKOON7M3rWWmoKI5NDhn0j6ikdPgwURjQzdX+S88UU+36sSmsnmuJleK38iOegSddqz0d/K9uzTiouEYmFBdpCAIesU2L6mZzCc4d4jhVB9iofwrCjRYXWc3rteRl8ZswSeEG8W5YG6oA4IdUECXxoEUPGcdo+VBTjN2Sw5z8eVclYEEddhY0gmWLr3emsEe8998eDz5UhSwrqtv+TNJKJLoad5AE6jxxRqcL89fPwomNpKr9kfVGjyDUQJHWKy4phuz/EWfdLiIHEYxw+v0LOr5Sm6FvpKADJY/u45PNzLzOGuaQuKoVoZP0i1nD76KEgeUDDWsK8rr5XE6C//95k7thol4CTUPQ6OXJJfmom0pDJ+BEcQBpr0jGgUiR76f8zg3/m5FyMb9GrISimwgXvfI5T4VblOB8m+8VZ1aCFb6HV7tNrpIEkmmJ569AwKBiHf0RcjO2jIqlbemaXgtI5B0S0Oo9V1gnq/0779aNNo+YjX8piAuJCzC1lC+xJo+1k/9yDBS1sCcJ8GRkcsPc+RkGFISue8KcgGWKi+4mhY5pvX+OWswyzBxcvS4CkvvlMh0PGuuLvm8wb/klz9p1LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(2616005)(2906002)(8936002)(4326008)(6916009)(8676002)(66476007)(36756003)(5660300002)(86362001)(66556008)(66946007)(54906003)(41300700001)(83380400001)(316002)(6486002)(478600001)(186003)(26005)(6512007)(6506007)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uY16thT7bLqoVl7X7swFQjwPfXNkTaPZeitF6aFcRcV+M7TrMKtDqvejzwUa?=
 =?us-ascii?Q?HOZ/BiRiYiv6qcF0jgIqzuuQ17k0IpQplWJttf98/0TvNfF/AwzJNF6FX4l0?=
 =?us-ascii?Q?qdH79cE7BovB4htnD1jW0x63cXqiqNzq+lfn1liEK2TT7Gx4d0YxbR18Qwl9?=
 =?us-ascii?Q?6TzZ9dISsFP9mD3euJs0ttvSJPfXWVfSOXMZkb4S42AdUq4kVRaOisbxoS2H?=
 =?us-ascii?Q?m2nXy8yisNNjdNjzDLDwX4Ystrf7rcglZQ1e96VMFcJRsEqQghX9xVHBmjHJ?=
 =?us-ascii?Q?IPTDB6qt0BqWMoPbC2hPitJ0P2u6hixFBAgu2yymqVjTRSaTs/+b4WSQ4IPJ?=
 =?us-ascii?Q?uDaIdVC+VQ8t0lIf4VDm+8NJIRLcsl/X0vYPpeSs/DY+DGdGTXxhm/kYWB87?=
 =?us-ascii?Q?I2qABq7BcTQnZg1EO5v6r0kC2TjbVDkSknLNRjzL37PrmTfj/e3TXuOaB9bw?=
 =?us-ascii?Q?+IfIy4tBxWuHJUTzmGr4lKWhkhOwQ3l5FLNsycpXrV4EzcX7fePnV3do5Y3k?=
 =?us-ascii?Q?d8BrWldv24Mzx6XzWUAH2NVLzBMRkYrQeUEdktHXZhEo8poyY3BFCMKzX/YL?=
 =?us-ascii?Q?1BKCt/iqENY6iKDSM1DthyEQPm1BLvMPG0PRl6ARfW1Yvq48Uem9+66d1I76?=
 =?us-ascii?Q?sETKB2S4bay/4f1M7K8E/iYtydZkDL49z5vzyrqce3pPGXukkts+dfGnkJbF?=
 =?us-ascii?Q?1JLErCKXLhDGh7WB7LhQ9TWkr4tcXENyr4qicnPg7437f11x7AKrf+yUl40+?=
 =?us-ascii?Q?5rE2hIBBIK7ivnPrnwOtyGGIR+Yeor/2h+onqfGQd3+Z+H526sh1rN6rJphb?=
 =?us-ascii?Q?9Gtb7CczbhFYhBJPjGZLa1nV7AEENLOjgIImYWhRJfo1PqKMq8LNVoJ418re?=
 =?us-ascii?Q?xsGsyL2Zvp264AZq6u19yRacCyWf3vLR+u7gigpARjYcxATq9txEZQknCeLh?=
 =?us-ascii?Q?E+bW5RkbJj9/pdAiCMgj+Opz7Gttmjr+2w6ZyTlqG+hM0aD7CgoWDPL4RwJE?=
 =?us-ascii?Q?s4R/wDUKzI5hPcGxEco9K9iywMIcgylEeJbaHvoyO8CAl6xtoKgQSF/ymukM?=
 =?us-ascii?Q?issrNOSsp9sNgzCBPtMzFYxXAhDt0wq2ZIslu2rNAeMdG7jI+GVR2FjHeYJ7?=
 =?us-ascii?Q?uvz8xBgC5/8M75osq0/Zn2uNvut31Moxnhu/iXHYaWGqQtVX/zV7GE9DQy3p?=
 =?us-ascii?Q?hVrW7qQCZl0hM/rf6XUuWMrkZhjSqoVmI+XLbh331QWHBNVDdd0u5UPzPqOJ?=
 =?us-ascii?Q?ffj+xAHAuOgn192ZKiWRoOz+c9gSJh+yWM4w6Yqihr6m8WljPl6ZJDBKPtMp?=
 =?us-ascii?Q?auR+kVaedAzPzLMXCNM2IVDfbVE+py7sHBylXZbXYMhjMgVY3UFkt3DXDIUp?=
 =?us-ascii?Q?DtG+UBzpMWI9YRNm5q/3WBWYl/qhf6gw9RRmMJr4O/eTq3L5lQKy7D78Zgvs?=
 =?us-ascii?Q?bd/NbOLe4c8aJI/N3YWo0BJu0IfDY44PMcE8nX06hL2S2adOD8ero2//bZ/t?=
 =?us-ascii?Q?03jMmj1cuRet/UfsXebholIU91DeLcWJOKBjBtsA35CVZL1CS8ex6PXw1PNP?=
 =?us-ascii?Q?CWIGEef3x47Sekjf3cpXq/6Nf3NnEONv8wymoHEVtJi4Sjk1H44tA6eMkzXK?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AKs8IPWR3nYUmMXhYFrT81/sobqAsBZCPIqZYx/gz0L66RgLTmTNyDgd8kWjwo+av4jEz+qMFCe8wSE4bXvUU4QF2mWvDYpn+n+1L8bS1tl24hmkK9cIcBzzLUawYAKrhND7yk+3vGccALYm41KBOcoy3DjH2NYcp/dv2T0PbfGhjXKv+B3SGbCl+bqfC0sRkHQAI+pB1VaSUy4v8X2RjXIO1+oN67FwaYJkcAt/vfRtUedOl6dWe+TuJCpcdVrCUgrDfBqs2Kw4/n2mclP3ebURM8dHd/dCs2Ec9XvNy68xkGBStXq8gKvqFzPisDj/jdWvJNKUQ4qJgmGO+hobjFnR7xFJUjMdUbUsF2l+LrikB7gBmzn3ggErz+FhJCTWwdrlyHYLghe2SmTP61gKRoavlUR6Wu/zKvnDBijLQ1TnaxEtATS325qqSDWDbG3cdtreXCjT9eczDiC7TdTvLf97OifAFrl2Tr0negPtk6gqXja+0FP9ekOz+OIgcaayj4TMOFFhO+dhpeECi70JemCeKCIjgEnCUfTbkpEkSptbYkTdAzqpUk1E17bDAibepntToWDyBKggEoesBtvcLOk/n39mUX9dpkU/Mges64TAkcxZ0HRPV8FRmtRxcUN2VyWGPgeKICTHwMm6u4W8ELBnnhiqnKaFzePLlbAAr/29otSD8l25inqalHWyocpPyokQtALO8NnbOcqAdhKWf+F7LdAYVg+wjfpXwFAugjGoHyGQqkvcPSWc1TRJxwIArcJaiZA39bVjjDacqMoNoyVPNC0JMVoeHQFrj+tNgqxN1FvY6N4BYykFfHpr55aRw8bIkiiCCcm33gVyQMLKYmC8JKx+/t7dbI/rg5MPhMQe7EfZN340mMwbBE4F1ymaTzIGBtg1AtEYy0LbSQW/rQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d19a57d-e07e-4786-2b66-08db0b087df8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 01:45:30.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK5NhHhZeFVOWM62LHid9VBMcg//67q6OHV7nhE8tjrkzlg8WTn8nejRh4XIkwaVD7AQRy5rY45Q2z5/TIMrdTvvsJ+3VkWCWfdngwPf11c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=575
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100014
X-Proofpoint-ORIG-GUID: oeeP1RTXuFc5XCtOmTx_qXbhh3HjYaL4
X-Proofpoint-GUID: oeeP1RTXuFc5XCtOmTx_qXbhh3HjYaL4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Hi Yonghong.
> Thanks for the proposal!
>
>> SDIV/SMOD (signed div and mod)
>> ==============================
>>
>> bpf already has unsigned DIV and MOD. They are encoded as
>>
>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>   off(16 bits)
>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
>>
>> The current 'code' field only has two value left, 0xe and 0xf.
>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
>> But using these two values takes up all 'code' space and makes
>> future extension hard.
>>
>> Here, I propose to encode SDIV/SMOD like below:
>>
>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>   off(16 bits)
>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
>>
>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
>> to indicate signed div/mod.
>
> I have a general concern about using instruction operands to encode
> opcodes (in this case, 'off').
>
> At the moment we have two BPF instruction formats:
>
>  - The 64-bit instructions:
>
>     code:8 regs:8 offset:16 imm:32
>
>  - The 128-bit instructions:
>
>     code:8 regs:8 offset:16 imm:32 unused:32 imm:32 
>
> Of these, `code', `regs' and `unused' are what is commonly known as
> instruction fields.  These are typically used for register numbers,
> flags, and opcodes.
>
> On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
> operands (the later is non-contiguous and conforms the 64-bit operand in
> the 128-bit instruction).
>
> The main difference between these is that the bytes conforming
> instruction operands are themselves impacted by endianness, on top on
> the endianness effect on the whole instruction.  (The weird endian-flip
> in the two nibbles of `regs' is unfortunate, but I guess there is
> nothing we can do about it at this point and I count them as
> non-operands.)
>
> If you use an instruction operand (such as `offset') in order to act as
> an opcode, you incur in two inconveniences:
>
> 1) In effect you have "moving" opcodes that depend on the endianness.
>    The opcode for signed-operation will be 0x1 in big-endian BPF, but
>    0x8000 in little-endian bpf.
>
> 2) You lose the ability of easily adding more complementary opcodes in
>    these 16 bits in the future, in case you ever need them.
>
> As far as I have seen in other architectures, the usual way of doing
> this is to add an additional instruction format, in this case for the
> class of arithmetic instructions, where the bits dedicated to the unused
> operand (offset) becomes a new opcodes field:
>
>   - 32-bit arithmetic instructions:
>
>     code:8 regs:8 code2:16 imm:32
>
> Where code2 is now an additional field (not an operand) that provides
> extra additional opcode space for this particular class of instructions.
> This can be divided in a 1-bit field to signify "signed" and the rest
> reserved for future use:
>
>    opcode2 ::= unused(15) signed(1)

Actually this would be just for DIV/MOD instructions, so the new format
should only apply to them.  The new format would be something like:

  - 64-bit ALU/ALU64 div/mod instructions (code=3,9):

    code:8 regs:8 unused:15 signed:1 imm:32

And for the rest of the ALU and ALU64 instructions
(code=0,1,2,4,5,6,7,8,a,b,c,d):

  - 64-bit ALU/ALU64 instructions:

    code:8 regs:8 unused:16 imm:32
