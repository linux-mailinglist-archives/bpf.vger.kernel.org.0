Return-Path: <bpf+bounces-4089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4E748B3C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA391C20B7A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE713AF8;
	Wed,  5 Jul 2023 18:07:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBA134A7
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 18:07:43 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608E198C
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 11:07:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365HwtnL011394
	for <bpf@vger.kernel.org>; Wed, 5 Jul 2023 18:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=V+kFHl5be22mF57dWeLYLkGC3yS/r5SYpz/oYAekG0s=;
 b=Pf6nPZR9VilvlnUcmI2eYTWMHye6zIaNKQ+hwHsE3K4RhXFKuMeq557DFApKj41olpGJ
 8AFitF3b1LT+VO6gEGxL9TdNCGXOHcnCKb62SGF5TqOD8XtYXnwVxtLKbmFqSN036Lcm
 mAPBXz2rPYZ1lcauwylIcBWJ4/o5rafJh+HFLXtyvJqresGVQ+CsKDgieauB5CBD13tM
 0fX79De28mZBbfWhjMb0T561TtHBqxGQovBGGKq/ho0qgnkUjhO/U1eq7n/2GAhIz4T9
 hYWKKfKa1Zw0Oelxh5dDT1LCrNO3Fi6hEAYz2LIdQ+mU6rZt3PUM1+4F1sZ1ccP8h5XV 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnawv8eu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 18:07:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365GmG22010531
	for <bpf@vger.kernel.org>; Wed, 5 Jul 2023 18:07:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak5x9nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 18:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV4OJd6olY8EEWXI/MtIw/Ca9X49jEEE6c6rMu/aaG8HWqDQIS6I7wL5Vyj97ZRJBJJ1xFLI7gz0neCW9FFcsuVYGqvujwRml1psqTTA/hynBgE1X2TA0FCqBqbuuFDqjMZSiUDoCgCoNl5OgyKGvHW6ZXGX2T+SDf9a924XeDiMQqvyq2hgvdvn895XeZGYa+6an21W+r9CWPInWOuEkpIiUWeCD07FQ0EnoilGo8cujCUDFLtdmWxVihrJnQ1M81cLJoILc/eAnNrKSz5a2Q518QqOI1mT9MAngCrhhjhB/p7qB7mNIjoPVTIpSJsPSPb5G2n4jqN2eSfdIaeYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+kFHl5be22mF57dWeLYLkGC3yS/r5SYpz/oYAekG0s=;
 b=echJvWDSdoSKkFD0lqRPJE+vm33L87/HWFmiIY0Db4Rmnk1uXxsEuWS9JHhcVBOb39o/D/lD+j3fybE1mwDivFdmPwQzCXIrA3e3WtC1Aq4pe4oBX7RArz7HFZgWd760fE/ggjyFGtl4bgYJ6jG05djMR0Jr9fCE+uEcaEKXALy8KegAinM6qkmegRPRmVQ6b1Ci9jqx0LoFxzLF8n3A/2HRLeZAh2rK8Jl1FSZnwTAN7WANlTRImsIvDWsBRWvMAVjimAK+TWUKZKfXi3NvEx3qBnPFSAUmCoh7iprrgJsOi0sXTOdkdSJ1kRJMoMsGSIT1NS89pENNzCMndVLK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+kFHl5be22mF57dWeLYLkGC3yS/r5SYpz/oYAekG0s=;
 b=yTYh0J1PpteVDLr9afENQvZz+AZd/SbSgcsSdyHYRUU4LFl85aYyD2TudTt3M1puClesMGZQqJCxqfhPSyAVfe/lXWZcyS7ghmDx1TsqyrRn+zhDNN6E3TGTICqrElknXxjW/EjVYvKpgdcQtxJXJMjJACsZdU8gSYkP51D18Sg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:07:33 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3bcd:97d3:9742:c497]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3bcd:97d3:9742:c497%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 18:07:33 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com, david.faust@oracle.com
Subject: CO-RE builtins purity and other compiler optimizations
Date: Wed, 05 Jul 2023 20:07:25 +0200
Message-ID: <87zg4as04i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:208:122::15) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c14e358-a3e0-4866-8ba5-08db7d82b37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f/tzFilVUUnRmicdKjqpKgX9E0jMIAg1O3E+wpE/WDowdKg+lJs8AAA/5YRIVZ/5colRkOOrTUx0Td/EdUYibQ9TS3UrkGSqxKpe3LD+G0TYJzLtvPv3sRbJ02mDoBMHIUatyVoqipPdxOLcIWcyr8rcFPWD4amiahX44xiOfPsC8NNAeuIBBvV4ESzkp2ilbPgOtMnfXDn4VDT04cvacdFKyve/ZrvhBUzGt0CAca2AqEN+31RQbUK85Lxw6cbofw4p2Z6JUeYK1213wRV8an9JLNCVdwSnNhoHGeFqF+tAe1FUNoI5D5z579e5ly4Lzo669llfkQwUIEDkebgqdlmmfug9mcVeaHkhtWCxl/ei13P+yDlmKKSZ3yytalCqk1BfvOvPiFZUZ/HctzAtBnpqqlSarvDEsgMTJMR1hKtaKFwstKYdT2Sit2XbUQU+9tHGGut2g9ATL8q4HiKrI0R1xZWKkB98GPqGpx1Gdi5/B1qNAEtu9Gugw9xdLRJrMTF2bOAd69UedjwCDqBWHXBrFPphcaKOUQ/IMkiUPM4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(41300700001)(6486002)(83380400001)(6666004)(2616005)(107886003)(186003)(26005)(38100700002)(6506007)(966005)(6512007)(86362001)(478600001)(2906002)(36756003)(316002)(66946007)(66556008)(66476007)(6916009)(8936002)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?55akv+eOMZ2Jypj320cLYON2q4ymTnwVo8fv31trth/m51+gv+as4q6LJHcu?=
 =?us-ascii?Q?RKj/2W7oDiRAuvzp8UG1ruavkkF1XqUiwhaKU9i+k2xNlW0BvI4RH2PQTGaG?=
 =?us-ascii?Q?Q021EeOUMqGTYyPxmjbtPCTkrGRhQguWpVeEF2Zhmx2hCDUDiEv67li4Oofo?=
 =?us-ascii?Q?M2Z9y+XgQMcFcYGDb4uhM6boxnD1BB6ySF3qCXvoqdsCmXRI31FZZFgdcwqf?=
 =?us-ascii?Q?msWBnfDb33DSbg6em8u+hdAvLDVyXpIpqB3gy4FDlFXIdOzNe9hxafP3fWZN?=
 =?us-ascii?Q?BtFt9xRofRiiOsbh4L0+JkF9f32dRYlJK3pLYbKAIXFHIz3asaxvzamNlVoB?=
 =?us-ascii?Q?Wa7sdPZ8MB97Y21Rjn73LS+PvPnvOL/1SDRrisZAeWolrVakfmksAv9MKD8O?=
 =?us-ascii?Q?0lHc/wyR50UVCw0aMVT3eD1dg8qyQIN0LWT0XfNqLYdjqKpGIvGMvzEAAdIS?=
 =?us-ascii?Q?wwKpEdKDbJPJVg0e4T4bYG+tGL6hoWxiP1R8Y6raniOfqpYakxUiHLIENhDP?=
 =?us-ascii?Q?zc+DaIcGxDxKNIkKU26D7zMoidc2/m8K64ackWybz6m5ykqZo+J0T3X5zFcd?=
 =?us-ascii?Q?j0iifgTQYzp9ctTwFtPWJXe3uMqoXz26IZedEF7cl867No/T+DChSBlA2LVX?=
 =?us-ascii?Q?Ae1GkrbZgk4dynkNjIaEYegzkhJyPXXoWuez3smT4L7USJSocmGwMAXqvTyc?=
 =?us-ascii?Q?MBbDbC+5f+W7liGwUEZyYcmypI53UCDqPDNUyULQ1NokJCB172w+h0kRJkSY?=
 =?us-ascii?Q?Vthw5cwfKCjSewtsyefa8G46zmxhwE66yKxGInmu06e8q704NapJHgVqx7g1?=
 =?us-ascii?Q?Rqzm8cmUd3kha9MgIz/DD3z40VzTe7Yr85Uv4GeQyVgyQMEA3JhynRVfUUkv?=
 =?us-ascii?Q?Tm7xlGRRIYpk4WmticbJSHwIMzF0yF74Ot1fsS5jA8JwlbZrRPpPUcKO5NNn?=
 =?us-ascii?Q?PFoWPVuWQbvmoV6SKj5cSqMNUr+Inii+6xPkAhCzGiV6I9q5elKjf6xd+ehr?=
 =?us-ascii?Q?aodd5r54OS8TZ7D/3ds9oQiYzNw3dTgabgshJp87CyIL5+gqQ8nmdYI2zt8Y?=
 =?us-ascii?Q?fxR9jHg0SqbSBy+4Qms2+UWNae8B/fm5v53PRw0FZRpFtxRpdy/BgSDWiYtv?=
 =?us-ascii?Q?58FLX917Kuea4JGyS5NRJE63XDz0+Mpu1lu2/Bd9ofoz8oQ3QFWZiXJrv4st?=
 =?us-ascii?Q?reGbeRvpHDArtJ9NKKcm0zUzxH9NSDwubLbZFYcncrVvrrCjWug8hNVrLscM?=
 =?us-ascii?Q?sLnGoCL0HJxj2itDoonZy9rGIN9bVPcSjPLNIRZhhv8pPhbrvFLcrgYpkSYr?=
 =?us-ascii?Q?Pwg1/IqGfAZLcXS9KyG4Vj+mKijIQHgOALGOJFkeiFkIC8TeARhx86Q+J5Wp?=
 =?us-ascii?Q?7/+/kR9VEmicyxZwjS0VLDVmsAznUjdE5DyHAke99zEXXliY6g2tKMl91I7t?=
 =?us-ascii?Q?O85aPFil7S4TQ+ig23pEDaZCFcli9hOd0dkEqjXKpl8/bH4B5cbcsMCceT1Y?=
 =?us-ascii?Q?XZW9aTM7atcZ9ANsXi6OYXR8/gzuljy77/9KaBlSol+wL1b1jqJrEMZsRRpw?=
 =?us-ascii?Q?tiZr+leaozY9iK5UNkFjKXW70oqKFH+7BEklmXCqVmCnUhRd4Z4ZI0it+9aM?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9RulW6fwN64wMm3omLvgyCtTP9dHexrB/rNzPHwcXVbvlhkISa2f7sdxA7Z6VwT8I/Am9oi9ndL5dW/dNhFu3xZ+vz4k6+2aj0R6jVmseFeVGErFTo6wLTe3DV32zf9flfdiiiLbIcXhFGe5zkFK0p6PD4TqCHwJME9p6GX4b3jGqy8LgLywUU1bDOSIB5XU2TDxCQdUQ39x6i6RuMU/9gt2LCMesqwlZS1hHXZrr7/4IqirbGjL2eEe9ksrRFfPs3Zr+21TvKbEudd4qzPWd3jMI+ldKaAyB8aaO101b483nTJecEP2zLBhwbBG/TMzIvB8nl291GHMCHJZ/qlKSU43Th2NjIWfUvKILXKGJnlDrQxMnYvVz59rLLqLz28nL7Iu5qJg/eYXPRROyAz189qlpNz6lCJiVbxCPTdTFRXY5aBULAOpC1vAB2Lx/XAv7TcuMKGmpbkFFnOm1ap7XyL/FWF6Rnuz5ANcJfpoLfgjWoN28iR6QCoFpMfMEeAghp72+Pe2goV+/+ooVF0sWM8nbh76PCKDrVMlgdif1s0Rjn4B426Gsn+5zKz/2IPBGLMN2qLutGBwc4aZEKK1tk0/LHhvugwCkE/HjfFIbEvURHDeiDKg2YIDL9zQPKoelWiERGLj2sepivsnkfBb1SPKdoVSPAlKcndPQOng4iS0GT9Fi0xXljLuir9nL7sZuKGp2rfxkDqYYls19YIAwwQgV1aXVjY9uwhZlVBWEC3PvfT6qORtp3ch2uIrnP31
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14e358-a3e0-4866-8ba5-08db7d82b37b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:07:33.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKhOO1gq5Rvmf5u3lblaFWkUceAEtkg/Yx1ywojx1qrZKU2XLrzUmifE/Oj9bvuD58ce0JCsO4PPONji/a2wYcewKuzd2u8o0CjureMYAV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=606 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050164
X-Proofpoint-ORIG-GUID: FdNBpjTy5oDiV_eyV3Ma0bGORtUGVdvv
X-Proofpoint-GUID: FdNBpjTy5oDiV_eyV3Ma0bGORtUGVdvv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello BPF people!

We are still working in supporting the pending CO-RE built-ins in GCC.
The trick of hooking in the parser to avoid constant folding, as
discussed during LSFMMBPF, seems to work well.  Almost there!

So, most of the CO-RE associated C built-ins have the side effect of
emiting a CO-RE relocation in the .BTF.ext section.  This is for example
the case of __builtin_preserve_enum_value.

Like calls to regular functions, calls to C built-ins are also
candidates to certain optimizations.  For example, given this code:

: int a = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUMVAL_VALUE);
: int b = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUMVAL_VALUE);

The compiler may very well decide to optimize out the second call to the
built-in if it is to be considered "pure", i.e. given exactly the same
arguments it produces the same results.

We observed that clang indeed seems to optimize that way.  See
https://godbolt.org/z/zqe9Kfrrj.

That kind of optimizations have an impact on the number of CO-RE
relocations emitted.

Question:

Is the BPF loader, the BPF verifier or any other core component sensible
in any way to the number (and ordering) of CO-RE relocations for some
given BPF C program?  i.e. compiling the same BPF C program above with
and without that optimization, will it work in both cases?

If no, then perfect!  Different compilers can optimize slightly
differently (or not optimize at all) and we can mark these built-ins as
pure in GCC as well, benefiting from optimizations without worrying to
have to emit exactly what clang emits.

If yes, wouldn't it be better to disable that kind of optimization in
all C BPF compilers, i.e. to make the compilers aware of the side-effect
so they will not optimize built-in calls out (or replicate them.) and to
make this mandatory in the CO-RE spec?  Making a compiler to optimize
exactly like another compiler is difficult and sometimes even not
feasible.

Thanks in advance for the clarification/info!

