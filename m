Return-Path: <bpf+bounces-8310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13EE784CB1
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AD51C20B2D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E934CEE;
	Tue, 22 Aug 2023 22:07:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935420183
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 22:07:54 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40BCF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:07:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MKrecD011604;
	Tue, 22 Aug 2023 22:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ViiLReDxQ7B1ofdxAQldnF4be6gF3DAs04CuTfmcaO8=;
 b=QbKL07U/7vfH1yrcGYqRWa2SDKjIOlA5YXzf0QIHCDfpgTlgu1COR5h87CvOko9yFiiC
 POTOoa3KuREJTAiTnCegIh1zcoRkru7sHg1HddNJCwZbOyjr1Wn8NxtIJjc6mI27nksk
 U+2cQzYA8XtbFmqOWMQJr5jQWA7k8lE5YddJZWNzrvXaqFSM/ssvyBRCkMUkpr0+nlMA
 vEBtRaY4yRrHMCJogiI3eNin1mKHt+2TTsAE3X5Ro9R5PviP1xZ5SUqQefFpzQ+QoN4T
 12R/w0PeXn9cdI34tq9SnUkDCd1qod5jFn84nHyMHV08b6I8JbwX59gQCuiqVWrE/VyR 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cggmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Aug 2023 22:07:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MLxq8o002175;
	Tue, 22 Aug 2023 22:07:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yuggh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Aug 2023 22:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXGQWCdQffsWnDHwXR8mQB0Nx1dwEIM+puU49ttRquC0jd5JkseBdUb7JljtHXdi0UYd+sYiaxmchVtgpEaa0buFfuAA6py3cA6D//TSVnif/vvEE1U7SkYB/yFADFxVrPcPpYLIpGDflpzlGeoD2aWaKzwlc/wVGzBRNjigSyspOMKpLalVNrHTtrui+YqTji91TiiBezXJclHpNJad5oObyiRNDNS1faFbNv9j3CGV0nzyivY9nBwqzG1lh534hsO9YCgH9g6gfyNaMheuCdJNyPh9LFi+yiVM8he+Uwfu+pdKRa5Nz8XWYgIblN0CwQ9qIBj8JKJHUxaucQh4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViiLReDxQ7B1ofdxAQldnF4be6gF3DAs04CuTfmcaO8=;
 b=cIAhoQ1xmNIe06O6PYTfsIkgoXkXJqL/62a5tZUtsvcxbMsA/Wu9ZBdms9wMrsOH2oAZglXWZVnqQNXNMYvna5hGdVUzejo2/jjy9+lnfJXGD1BrjYHLRAbqVvqJAYNmglgFmvWW1vn4ct8NJ7enh5SpYH2B4taWLCJWhBnjnIkPq+kZ69uQLv7KJrHXXgMbmGHc4YdZj2b56NyizRdonp3I3AWOHUZrixMPVuhyjihCy5WbquaQXpMGfDuulttjmuR+bqzkY7LjH1dn4i+6bIOGxiUa/WDnTmlTv5M8PQTm0EIa/F121748dRnGPbjuuriIrqDGXs8EAkmIyav4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViiLReDxQ7B1ofdxAQldnF4be6gF3DAs04CuTfmcaO8=;
 b=VfTSqvz7L7gYXCMRhv2yovZbDDiIe5JO5X4TsGagnloXDEtrf8MfX2nwQn+g224yhNWDjqzmSJCWPXd8itJV9/wcDpKIrB0tNlScpUgdP1YZ5DBFUUONcdKl1pr+eRJbBGtdLSgU6TsSAlFj5Kii0Lo25sKGr3eACG2FguugMBk=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB5017.namprd10.prod.outlook.com (2603:10b6:610:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 22:07:17 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::fd36:b9b2:19f5:6f74]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::fd36:b9b2:19f5:6f74%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 22:07:17 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
In-Reply-To: <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 23 Aug 2023 02:52:48
	+0530")
References: <20230809114116.3216687-1-memxor@gmail.com>
	<CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
Date: Wed, 23 Aug 2023 00:07:11 +0200
Message-ID: <87lee2enow.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bce61d-9826-4167-c789-08dba35c25f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2rLHEe35fyNi5e1qapCzsu7TMQCRan8JIyi+eEX/oTCpvdGqNVfYFOGxmZ+2zlr9a9CwPei23KqpJxQTYaHNLryQFa1t8CR5dXEbwyYOnV3jjzRmBvFtxNQDbM+n1BZPRuZsQmKiiX3nBapM/S+x9NDG6kEEUBB6lK8ZG7w3fd2joPNP68exDTcIdsnfacN0E6avNAXLFP3Kz3kplVNyudJmJ0owSa/0T5/uzpuT0ErePLu9vYHLsBuf3DqgHX7vsLfkA6o8sZvFrmlZq4Neq3yCYzNiU+dGr1s0IbpnJNhpsev6jdX+aNCVcrPeT3DynxO+V9xgUZH0JnltCCXBGWQlEawR7A8B8xv6RpXH2EgqRDMnU+byB1UiS0Vc9SdGuFWJw7FjDjeOi8ei/udgsmz6N3jyQEkVCkEVBI/9/R6eE1vGF7ijGbl3E2dyU3Pey3fUvQsK2LVkx9NweJs1lge/j013ns5V2NZIpEhttMZU2Vor3TELSIRxt/yxeS0Q67YzspotwEQ46CEW6IXgSnuFRZLbjbMPN45eA4J/w2NuFjYWeVJe7dFOA+oWN+kQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(54906003)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rrDvGju6s32IHySzlsJs5C6D1NZULGeK/S9ECvXAuTVOou49gb0PAYRnw3Pg?=
 =?us-ascii?Q?z0Lc2yRIpPTEw6scgPUo5jnE34h4BfXld0HVjft3RiG3u/jys66Z2s6tpA8r?=
 =?us-ascii?Q?MO0yZ0eXMPXUj2erJ3yI+m/ES4o3viQa7xhD6HsDj8IxWnfW1XWOTf5JH4oj?=
 =?us-ascii?Q?s7sa9qdUB3ycbmWdCve077wyPG7Dbw1Ipv+x9NU4W0Ft3yCXcqXWDfZuWc8o?=
 =?us-ascii?Q?O/1yfe+rAIiUSC3FJtxzgDi1xMVjTU8ufx0HiD59b5Yj1lTpRlCGLk9POmrN?=
 =?us-ascii?Q?pF/34fuLWNclDuY57UTTnxskt5u7juOi2SS/4RlDWjnTT1cFOHwGTuaWH4gY?=
 =?us-ascii?Q?aevT3y7BPHEOSpmGuzEkGt9/B8rpVsL85SeYNl1lIHuvdRB1wPnOwYFopLgS?=
 =?us-ascii?Q?TTri7F0n1R9kr2OcGgf8CUgMMifz+5Efh3zvnRW+cBBPe7oQ89WpiNvZCAl3?=
 =?us-ascii?Q?xbZwo3HsP9/jmYsNllAe5mhIHPcUcboTFDSXX7BNB3hLsa1Bv8p1E/1fG7OC?=
 =?us-ascii?Q?DRKpvY4B0QAVn/S2W6KDJKxIVER/EljM7Mgf/UaWQDWXAwxzn/52J+lwIqmT?=
 =?us-ascii?Q?VgUaoUHpD//Le07hEbkVR0/m0g55WbsMsRbeG4eRdovOhr848d3vDo1MMnba?=
 =?us-ascii?Q?8mKmzNSahek3HbOJqrkTyvJkbW1Wd5u9t4pHiCaX6y8QX13fZO1IgolJSRqs?=
 =?us-ascii?Q?+6X06LjD3jv7d3npoRaiKOVckSJASd2TE7jcevjcObEPvbUtYbiN7B9LnU0e?=
 =?us-ascii?Q?1wjdcrxgU/gD9IS8X+BSdI+n3KhyCDEx0b0lCeiJEhHFKzj+UF1pql79Epq1?=
 =?us-ascii?Q?6uXDfFJk8dgGLrlOJYjuTZuXkpgvE5hraFGOUXHCLmceHqm0ykVDmPtwUCEJ?=
 =?us-ascii?Q?6wvgb5K/CqNJg/UQqs5WVFvqaa4UzBKA07HDi8VjAp1ia1P96YUlUpMgcZA2?=
 =?us-ascii?Q?EnSlCOlSjrkZlfMrby3i478hWjZ7zrk1YRysr5GO5hm9/wJ+dxXor6w7B/iz?=
 =?us-ascii?Q?WqFaidsN2EeVdMCPQmY9zCId/6PskLGJuigWwuuFO+F5EboV9JQZGE1ghfK8?=
 =?us-ascii?Q?QlYe7PqqMVXg1Fm3CkvXsayQp/liwx6+T7yUWj7quiWfBsYiGN1VtbtOpJaS?=
 =?us-ascii?Q?0uuX8tmrPX1orNE04HeVJdYzelGJX9kY7zbQd3toGc7oFtsGLMi4aE851rnV?=
 =?us-ascii?Q?ifCDqeUtGHqIvxP7sQlNXNI7HoTnHMCSZh4D/OTimt1w8nVJt8ffUHrmkzN6?=
 =?us-ascii?Q?4eOyf5RcCTduIXhTRNKBfKGXCu56rsF/OB+wKLsbLXxzxQevnCNBW9w+f2FH?=
 =?us-ascii?Q?LJEoTIZcq6ahLjORC0YB2/mK4IBQd/3VBvP74WQi7yzh2hojw2n4I38KGoK1?=
 =?us-ascii?Q?nEIWO9W+T2MzRx9e6uZFP5E+OTYv7SI7IOvdhLWjM/HN5fldIpHOzAkxKnvI?=
 =?us-ascii?Q?1HcTgXK8k2puyDjLxoJCduEljE7yM9517k4Zd1gudcWmnQzCZnim1m93STfi?=
 =?us-ascii?Q?9B6uzgpzX7+wDElZSrjhff1C0tYI8E+jivJlp/BMkTfFElpmpZQBMcf56U6V?=
 =?us-ascii?Q?UVHw2btolh4ZhK1+1OxpqZZ8dlbYX2s8K3nTaaOLzH5UqUlOMyqgH//XQJc6?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EApccral9mONZLcv8VHndIeWv5K1HhAgSODfsFvQdlvyqew/1lApNFCTFc1pARpWmkRVGl5HvnDYMXj7LvcDFgrpBkSLTBzqskuJcUDVjgaoWCte/ocCKSNwngw6vFvKmxs/JKoybxOXNVGAplLBQu6B3ooqPa3UvZNiNTd3dL0AQTvD52/22SMfVQ2idi7kKfK2wGLfAFXoxdghv529Mq/Jwg9hq3XvTta6ufzVmdohfisQl8jpROzMhrANCvrMqUWEcwq+xoS3iPjBJ0ZdwBuQgjXlyDigi73xEy6AFmGXLsIZuFy7wWMhwWnkwV8kcPrN6vWrfpR3cTIBo8Jn+ZG8bl4zmPXimPf6oeB2c+u1BX7T39F/1M4mdMy98hX8ARTHbc3ZZHCzuF/42x99SqvLQiuHWqeFlsYB6JC2rNx9I8BEzdz2EYkifu/wsnTJGn2zhuEyqbNDlnPtMQqvfB9H/42be3PmnkKzXwU69KGRKkcMQvnVGqwVBak6ISC4XafLOFjKnOAngyD9D/6l+MLpjIJrDiK73xHz1YydBqj+avonAxY3CegAGmRIOdms7fPbzY7I+Yb5q9cPkI9AnlySP9LQDk7OQj3MQbXE1MK+YZHyQ/wizOqQgqhSZP2jzOaOJ37uSsGrJNuJ4IEbUnS9TapeeAZsxKrQ0SYKOAVnwVgIEYFPMgEmFgWpfk5jVhHPv+5VcU3ixIb5VFYEWIMAfTKg913GsMQNsj1XC61vYZZjkNac0o3OoMzZDne/pvWOVrOuboyAd8JHysaYgg/FZoVldkDQNZF0QRb8kqc7dwyKq63PseuRI77qlW01qq5D1w2dAsHsqxf++xZ9nGCoODGYIqphmvpcIUE/Rel45IPc0QF5ykTi3Pj2CqzKO9Vcqo8J7Jq9pO9IuJlnUK2hrixx1W2Cjv7mym8NkQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bce61d-9826-4167-c789-08dba35c25f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 22:07:17.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIRH67WAJdS7UdEQ67QC9Oh7302cnBn5LYW/cziHyA/N6pX8zZICqeD7Qeur43Pzl29qVq0ohwuWQ9ic/2R4Cgx5h/n4ANckO4KtIxbgams=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_19,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=980 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308220180
X-Proofpoint-ORIG-GUID: tXWwQaZ1pkBdT22rLiIp8Tnhg7MlZ0Yb
X-Proofpoint-GUID: tXWwQaZ1pkBdT22rLiIp8Tnhg7MlZ0Yb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Wed, 9 Aug 2023 at 17:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>
>> [...]
>>
>> Known issues
>> ------------
>>
>>  * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
>>    for bpf_throw, there needs to be explicit call in C for clang to emit
>>    the DATASEC info in BTF, leading to errors during compilation.
>>
>
> Hi Yonghong, I'd like to ask you about this issue to figure out
> whether this is something worth fixing in clang or not.
> It pops up in programs which only use bpf_assert macros (which emit
> the call to bpf_throw using inline assembly) and not bpf_throw kfunc
> directly.
>
> I believe in case we emit a call bpf_throw instruction, the BPF
> backend code will not see any DWARF debug info for the respective
> symbol, so it will also not be able to convert it and emit anything to
> .BTF section in case no direct call without asm volatile is present.
> Therefore my guess is that this isn't something that can be fixed in
> clang/LLVM.

Besides, please keep in mind that GCC doens't have an integrated
assembler, and therefore relying on clang's understanding on the
instructions in inline assembly is something to avoid.

> There are also options like the one below to work around it.
> if ((volatile int){0}) bpf_throw();
> asm volatile ("call bpf_throw");

I can confirm the above results in a BTF entry for bpf_throw with
bpf-unknown-none-gcc -gbtf.

