Return-Path: <bpf+bounces-6232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B776739B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199071C2110A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9115ADE;
	Fri, 28 Jul 2023 17:40:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D5154A1
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:40:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DD10CB
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:40:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4W7r031039;
	Fri, 28 Jul 2023 17:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xebVdql2dD3eXeehvbpIHDVT1P/dOaW+3rBg5lqKL4M=;
 b=ntJ7b8jKUewekq16m0lrxKjJbRYKlirPAs7ps+hgNgftizzExe4TLdq3tJRK5g/721xV
 DuBJKiP0oTVZ66inNsBY0jTbpU2YY/Cj/nG3z6h393R5jS54TUXTLImC+vYTI1yCiKcY
 +tyR21EMf0Fb4RJoHKCJHdWGYfC1ZtbaM02hPeIn8QTnVDfgo/GC0Sy1yYddgLshsT8X
 PJss7A+xohbwZIspvHEWgjxCjCgq8WMRkcMeA9BjLkuH0PmPbu8q7mdRTXdZtYzKAFNI
 cWwnpaiiA7g+LN0eFWoXn41htLxX1T4MhUlyAE0RKzcjkoiHriJYuyS4Ai3sfQOhkzfq BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he4bp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 17:40:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SH1CpR033390;
	Fri, 28 Jul 2023 17:40:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jfp30f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 17:40:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B39S2swL5WfHliYA0JXPamdkJfEDa/gnkDDM4nSNz/JbM9Lab22voloYPJfClcOI+8MnqjWesrdj6eBvbC+N1CTS8kwzLSpqHEoNKpkv9xqQYP26oSeJz9UWhuBHlx93bCGUZdVO9SK/hB4bwjYP4wcBVvm0DjySqaw1PPAPeOu/64VZprCraxsu2jfOpNJq/2igefaRgt0xMVHqGHdBmCwDpr6xycni6AI7OiK+h+DYSPAaZpHX3RECFrr4pEXaXfq5jHQUzX0MVgCxiTIPoZWpGDYQ2wuebzW/l7+mAzwd/fu8G6A+H3L0sTAUVfT2Q/1DDBdnR8HVfFKLBTqR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xebVdql2dD3eXeehvbpIHDVT1P/dOaW+3rBg5lqKL4M=;
 b=Fd0tEtTh2upqcqENvUfrVQf/WLBf50swvpufBgB44uux0HBjU/iCUHJjFRIu9TnvRGRCe40xyEL9OeqtLQ6LOzkHsDt1LPhx8hYACH3of96DtqpDeDO7pCKT3dSTsJEluseDredDKgdhaAVjOW0ylQEJ/eZUOPASdSAdNRCrgTLIVqTYKfKTz19tpi7b7D7VSNYj5UtDTJKzlBkalEQD1z7Wf/mfw7hQMa65a8zICLQHYZJbjNdn3TFD4piRsyQ4UStEsjVFypY1f6ekITzURtnab6oImujr5iA6NaogOtzYU0jD44sf5au/Nttop7LxsiyHOb8kAB5Wi5yMgTMIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xebVdql2dD3eXeehvbpIHDVT1P/dOaW+3rBg5lqKL4M=;
 b=GM3OYTQnj9BIMzW09mt8XkhTVobJXyRFJpO98j7EZ/EUjUZBqAfugHQECW2jHZFU2kZjIjTtFHNkCsMrOiHfh6EX2iW9RMU2YSvrMQb/FJOWS9hhrisjkHElNgRHEga8T2PNiwmIh1MGwpPN9k0UOkcZnxhfkxfwvP7A2OODyp4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:40:27 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 17:40:27 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev> (Yonghong Song's
	message of "Fri, 28 Jul 2023 09:59:46 -0700")
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
Date: Fri, 28 Jul 2023 19:40:20 +0200
Message-ID: <87v8e4x7cr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a62b68-2bfc-41ac-c6e6-08db8f91bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0dmqManp2DqKZI0Cwb9Z5USZJAWj0qDqZlYlV7bIYz3xYVjIPqv67eHIs7tB1wO8RhqRgy9LjjWqmbZZ0bQ4bfZ+xlVPPPhmO9lPYdB/GEXy6kOQD9T1vrmYSfCqyRNXRvFuwxjmww+KAlNC5qZOvsq/Ir53roirf9qIxGAvMsL8D1hezR04JUPUZDNyBieAHRLxIOxTA4Q5HZA4mdfEPTlptaGoypm0QO5/im6LUINSumOHzvdFGlKxcZI6+77MgRSKEzD13+8aqVOPvFXlKfCUUq7U8o9REAkwtFsElRv+mVw/H1ldnDgrXCYQf9bmZerIKXkBE6cSeZ8E5chIFVcbxBynYlqb488PnKH0PKjl5U+mAeqOG4RRnQIjdw1XMqlYQ9w45+UdE4PZRlPwqDgmwM3QQ5wXhnh5bDwTWyr2wdVLdwB6YiPjCnwcuvgnOz8DDTan5pwLGCDdag+AJRMlSEUmXEza8n/z8bVZuR2NAx3pEqU9T5/eCH5zL+pEn8mEJU50gONwVqSX5+k3SpM4JJO3oU3mBI9cr7qs94T3dL0H02VeeuzitRf0gnN/2AGRfdZKQM8rfL7tYKVf+A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(83380400001)(5660300002)(316002)(478600001)(8676002)(8936002)(38100700002)(36756003)(41300700001)(6506007)(2906002)(2616005)(4326008)(66556008)(86362001)(66476007)(6916009)(66946007)(53546011)(6512007)(966005)(6486002)(26005)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aEQWojhQT9dIA2IsOrfJzYzyUeuCuixRn+Uh/xVMzZV0zmLalXMKkX09mOzQ?=
 =?us-ascii?Q?G1YSMqdk+1MnhpqCOnVBrA74PkjJwiNnGNM/CzgDGy5+9/wtcOgfDMZS9GHr?=
 =?us-ascii?Q?fbYEIOUDN6GonoK5ApQtrvatPNJrA4qGMnBTe85r6CR/BVDi9LTMqi8gVPt8?=
 =?us-ascii?Q?C4AXrqmrAfNnLRJUys3d4dOVXXqEiqhozQENTZNR8qCFpQTGZuVCX8hSD0mX?=
 =?us-ascii?Q?f8Or7IJD47ozD23cKc0MFB1ItfU16kcQlxeH2rYHO99cN3bdQwv05zcrMmPH?=
 =?us-ascii?Q?6cKYFcZoIHi5Or0Z2k9L/yQHvCvQ9nNH6mMrYAzuaBeO2Rzk74HiHpccuiLf?=
 =?us-ascii?Q?HoP/zcBq28VqyH4hlD7QnSuhakBpgTfdC9+gFZHYlHsDZXk6UwxbjDOiMw3o?=
 =?us-ascii?Q?d8Ar10cWlSSC09hiRGW0ZCiDf4u8JXJPO/vAKtXmoqaxjKnhp1XKBG8O3np6?=
 =?us-ascii?Q?JabC1x9Nr8EzJK7xhGmgOE2OHPgN7w3SljEbAiC3I5KaQufZWBAMlhKC2NtU?=
 =?us-ascii?Q?xHBOPulfB1WF+rH8PDqCXPGKT8vySbL6gV8gwKL2UfTMrdSCcMAfysCzQ+aG?=
 =?us-ascii?Q?PLU35zfsDfaQ4nDr4BNFhiCE4gHBSmhJDAXv4rPdrWLQubJ+u6ifDNkNiKTY?=
 =?us-ascii?Q?qzz/X7q3XxhiPn6WHzJkO7pR8ecjYaM5AsPaBQI8qkJUWxrQCNRUaqMkXRoV?=
 =?us-ascii?Q?H8GZLq85KlF6HSIcpYM+gvcf8Y62vYZvoQgtHegVitDV1O3ONp0zKW9k5gP7?=
 =?us-ascii?Q?URw1A0otqaWeWl2pEfORVKDmHu5h0PyGF62qLDgnEL6m1wbYJaMPvpaqYuE2?=
 =?us-ascii?Q?pZP6Sw+wxQVv1p+kZ3AYTTQhhXP6tL3z1ljkNbbH3NwRa5ibhSR41HkI6FhZ?=
 =?us-ascii?Q?kFd+Eik4Y7wy40CLLg6AZ6I+IZ3ERJQEcVJLH248Yj5uuM9tM1KHcWzuliNK?=
 =?us-ascii?Q?appsY5eJdQKQbK7BnvUaa8myseBUvrsVe61fXp5FzpfnFauoWtOSQp9sLcfZ?=
 =?us-ascii?Q?jhKElshzt1L7FFF72GFzbp7Ka5jTx2xmuVg9Jujx8ZYl4y/ASzLaQ3jz4xGU?=
 =?us-ascii?Q?WW/PgAPGp4UPVLE4mJHdrNG8q/eERwbEldq/6OMCOSLSrpLaHB58BvX72otZ?=
 =?us-ascii?Q?qzpKYmlxNfwKw//JaMrM3kMA+Z+rvW7AnXQNNodpBD29th/tXvm0/fN5X2Pz?=
 =?us-ascii?Q?DrTW/fisA0WT2yhEgCQ9orjQdOerSbT3srxY3sWklXccDRZ9qvhsrOzBwY8+?=
 =?us-ascii?Q?D7pP/dyNbRH66UK/Dq3c3YPwNE/MnLv8oxedldmVC6zkwiuX6viERWATNRJ8?=
 =?us-ascii?Q?DCrzb7IaVuAFPExpe1Gm4NHT3cEGDiH3Av7nyE5UzaDGNf+pLFzZKaA4GngA?=
 =?us-ascii?Q?L04mwRrx91Agt1gbkzgBCiQJ9hhVoadXcSvJZQeg7nrH769PZzgmnVj0p0aN?=
 =?us-ascii?Q?9vuRPInb4twliwu+/aYIh6PU1Ty3KK2nrRt276+n3LMofCNsMfTBiKqcHk2K?=
 =?us-ascii?Q?RsIFtQKkEifKO+aAuMRoPxZ/fBbP0H5PiT27/92Bd1HIQSJMRFD/5fbcSxSS?=
 =?us-ascii?Q?jmxgywEfqk96v186nSKYw5TJyVtYAvLiClrfXax3t/VKUuwr1aiIdiErQPF9?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DQGOd5aKLrb/9uXJHVtzNRJFuU0vuDJb8s+m6qOFctrOgvP16pc6jczcKezkNH+kDUktX+KW5ODI55vBOc5uf+lhLf9/5ZEnfWiTX6frWEWSZYtRC+sEwW+cSihrmC2jhy9dl7Y98Qn4GW33ytRPbWz4oc+rzWagcjHB2/ajWcewyYaYOCiFToclGzUM2W6kgxtgsY8P5W7+ZFh+FGeiwm5eOqVDIJrZnKbY/d1GcQQ7HnNVN2ByoAsCSIz+9yEPYqWTfgdpw0kIShz8dJkOJk3R6IlPxiRK5ZythcBpyfU4fcGAVkgzS1wGlseYUgGXT4AIlOYJhVf6QTvKdaTU74Iw4+kwPek5V9cn90/jV0Rgk1cotvlFhYaYEJDlMRJIy77x2vIO/Up2JK01jdzpOeg0LHtZJcweqOJjrBWndzaQU4aDoQqF9DH3+QIGjLZHGn9G7nQBFmpY3VLBJO6WMksXwes5Dg6NCWWsB86yA4KDomkSee7/hYu+8QovvTQGsNCBv5JIwnwyBtNJH7gDOdKjm8/YwI0feUkk1C9XycM7fbkuxKoBG/gvoPgxxmMS8B2nvqhi95OBaxalPrkPmgw4uZOMST+hIN11Wt5huKUb/avAG1A0jl6V2llXqosACYgDVLwLE2CQ4D82l31UEAhFEcu/WOYtmrHRZR66vnkGaQ3SxUSygFm/Wrf4lFNW50/UKBiIh8qXoep47t8WBeZBqZRJCoL4oEY5LB1BMER1yVW09Brq+BNzMjQjhIzQ3+VSc22ySom/zEqG6YXv0XpytI3VqZ9vxEwj6uLFmSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a62b68-2bfc-41ac-c6e6-08db8f91bac7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:40:27.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEATNwnsSFwwSusXtIqyKPTP+Sk/h4Q37Hgphh+U7vy40TPA5g9xv9nFC/1Ix7q3JRPuQtz3xgH3ovwQonno6MmzcC8GwfU/fbzGG9/t0GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280160
X-Proofpoint-ORIG-GUID: nSPInH479mt6uN4mHO6yN_Uyc55cecL9
X-Proofpoint-GUID: nSPInH479mt6uN4mHO6yN_Uyc55cecL9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>> Hello.
>> Just a heads up regarding the new BPF V4 instructions and their
>> support
>> in the GNU Toolchain.
>> V4 sdiv/smod instructions
>>    Binutils has been updated to use the V4 encoding of these
>>    instructions, which used to be part of the xbpf testing dialect used
>>    in GCC.  GCC generates these instructions for signed division when
>>    -mcpu=v4 or higher.
>> V4 sign-extending register move instructions
>> V4 signed load instructions
>> V4 byte swap instructions
>>    Supported in assembler, disassembler and linker.  GCC generates
>> these
>>    instructions when -mcpu=v4 or higher.
>> V4 32-bit unconditional jump instruction
>>    Supported in assembler and disassembler.  GCC doesn't generate
>> that
>>    instruction.
>>    However, the assembler has been expanded in order to perform the
>>    following relaxations when the disp16 field of a jump instruction is
>>    known at assembly time, and is overflown, unless -mno-relax is
>>    specified:
>>      JA disp16  -> JAL disp32
>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>>    Where Jxx is one of the conditional jump instructions such as
>> jeq,
>>    jlt, etc.
>
> Sounds great. The above 'JA/Jxx disp16' transformation matches
> what llvm did as well.

Not by chance ;)

Now what is pending in binutils is to relax these jumps in the linker as
well.  But it is very low priority, compared to get these kernel
selftests building and running.  So it will happen, but probably not
anytime soon.

>
>> So I think we are done with this.  Please let us know if these
>> instructions ever change.
>> Relevant binutils bugzillas (all now resolved as fixed):
>> * Make use of long range calls by relaxation (jal/gotol):
>>    https://sourceware.org/bugzilla/show_bug.cgi?id=30690
>> Relevant GCC bugzillas (all now resolved as fixed):
>> * Make use of signed-load instructions:
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110782
>>    * Make use of signed division/modulus:
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110783
>> * Make use of signed mov instructions:
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110784
>> * Make use of byte swap instructions:
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110786
>> Salud!
>> 

