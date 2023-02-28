Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67FB6A507F
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 02:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB1BFT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 20:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1BFS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 20:05:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85403173D
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 17:05:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIi21o018882;
        Tue, 28 Feb 2023 01:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=7p1c5T3L9MEiOheNDvv1XdrlaXNZP/LUjFXHmZua/F8=;
 b=iVhMAz7t515wO9TPEWM3slW52/a6ZmKwhAj+r7+e6ZNJYhO1DuHVFW6YwWXBPSbFbp3a
 TQmZMvUJ4C0sX77LpoTFTckvoBGfDvugeibWzrePaQy+WIBc1GzNWMir98nl7y8Rr1Ug
 kOdnT5JA0VnExiJ7LqE2s9OVyUmbF0ZCgqTuB/AbBb9iaV6YvbEC0GTaUnPGkhdVk6j/
 LgCRWNHux+5Lyy91L4BfAyJi2cjOUMq3yNqx11Xi3a3yTtcHHlN5vtaUn2wuvAjKr+tg
 bsYLJCRfMcyubqTg3Ce4BKyCPMaI4MN8xKvVFtSoGeU+l0DnsTb1PN55GtmvfiVqf438 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7cycn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 01:05:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RN0qmR001109;
        Tue, 28 Feb 2023 01:05:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5tx1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 01:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEDPJR+eeMaFiZOOWlnDIn2WUMWIP2SUl7Stm16pas7ryzVZRR7pKORPF2USoeKRAf9xZnyIvJqOsXsoZc7vHjPqzAvBRXF+b7oLwXy6uEmWiU9Rn6BrYNaqL3q084bdYpvzLSk+VZBZr7q4wTrNlg75zU947Qx2tiN3jOQxbwNaPhQxTxOu5FREUmy7h679lH9PaPgf5FKOAOg+MibxzUSZJb8HtLbtA9j663+1oB1anjRE4yEw3a3vKXMIf4KnP6QZbvI0KN7BfVbFnt2Rv5/4NwA2TMrp/8S5MuMSaq7Fon1bsbFSh5QyvHrcNDV2eIB2Pu0rJSAIazMlNRJ9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p1c5T3L9MEiOheNDvv1XdrlaXNZP/LUjFXHmZua/F8=;
 b=CEovI53QXnGkZSD9rgmFv/vQVV1Q516NojJsPJILkbTTJJs4vEI1cxYJjDa/qSD6kbhpzw8HIalKB2nJZfVedcmbFUM1hP6E2ckW1r3vT8kvLDdQOS7mxqMa8sc1CY3BSkRCy4XCscCMjYolD1T3YcIaEtGkOeX6PyOaPORIvUYq1hqQn5v8yvHfS5nkuv4lTzdn9gXBBlRFBZIrA0feGNFt0smKpKJ/6QxewAB0/b160qe4TZg84SG4eUfhvpup5jolA7MIkS1IQsyOvLuSXUnv60DtyONmXHE3gbmmGJdu4D1wKbqnNInvoKjYVFgzwNXSzfh+ZFa8tb953SrfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p1c5T3L9MEiOheNDvv1XdrlaXNZP/LUjFXHmZua/F8=;
 b=l6whQSmtw9WjMCjefocCmqK/1tlqSQAaMSQnCFwd9PW2d/xL+5JTAT09TdKVJJyPLmT3AFzFlKjM4O1PQletaw4K070CkudZC7kcRn507gF7ArpWsm9nscnx7XUD1hwKXUxCJDhxU6/EORhs5BmT/ypZcygdwazWycjrj+O1jbQ=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SN7PR10MB6644.namprd10.prod.outlook.com (2603:10b6:806:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 01:05:09 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Tue, 28 Feb 2023
 01:05:09 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@ietf.org" <bpf@ietf.org>, David Vernet <void@manifault.com>
Subject: Re: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term
 of stored bytes
In-Reply-To: <PH7PR21MB3878F2AF288BE7671D61E257A3AF9@PH7PR21MB3878.namprd21.prod.outlook.com>
        (Dave Thaler's message of "Mon, 27 Feb 2023 21:49:15 +0000")
References: <877cw295u8.fsf@oracle.com>
        <PH7PR21MB3878F2AF288BE7671D61E257A3AF9@PH7PR21MB3878.namprd21.prod.outlook.com>
Date:   Tue, 28 Feb 2023 02:05:03 +0100
Message-ID: <87v8jm7g74.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SN7PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: fcab3bb8-1a32-42ed-c41e-08db1927d630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzvbhpZrS257WMj2O9RgoZ0YIxFDixj+M3e+1EhDY5zW20+NUTM3SnVSlZ2VGJvFzZpQ2lyK8j80+jn6t6HOBUvLdbps4qOOpsz7R7sR+4sRsv8IeqCL1B86ifXsBuXBvM2irY41vahSjbvxDBXgGkl8doTQupFvU3C6Yp//OJnxFD5W5GQp6CsF6Xdd+Udv/9dFKwq3VpZvVSlczQwXEdUyDL7QE8qlniyW/v5vLetYkM/H2g4lk9rLksC8/JFB/3Kl2Hi5QjFUjaa4PAFBCoyK/r/kRrNd5V7MIAjHeOElEGOoOdjb+cBWCsZ2O5qyVwAt7v+SeSug3WoOOghQA2n1FaTScHZh0XIW+HbQ5He07OldDCPyNpBgIHkdd4YSBuHSbMORseJnrNZ0tyqU2nBz4cbYkmK+fCoibktCBAXolEAip1wgxUkHH2O4+AcrA/zbNoMsfUKJ/gtcn7PHqO07xxg2tUEopoqap7jKJiGjlxyfM7W0IITyNQ3XCFKc9P7dsmgAyHSEs88NLHJ/Gr+4W+dRQ+GSvDQ+xnhZ33dW6Wkw1tmozzJwYdmnuQ6TKgRxMSzPfV19P2Nhy5eegWEh72e/HEK71hr8RLv1wo831LtCi4e6bVXis/aKowKsZtlLhT5t/rirYq4Z19kUUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199018)(83380400001)(54906003)(316002)(36756003)(4326008)(6916009)(8676002)(38100700002)(6506007)(53546011)(2616005)(26005)(45080400002)(6666004)(478600001)(6512007)(6486002)(966005)(5660300002)(66476007)(66946007)(66556008)(2906002)(86362001)(41300700001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e26BlEVWObr5pFSOMIbXYa9zg+fAmldCGZ6mNhY7HZTnW2amj0ECEptDlY8d?=
 =?us-ascii?Q?Cfmt3ThWYqmmHFjbut8ylmkJtovWYkiyf1yWDQ8V9xT0qc+6HXnZwkPrLjE1?=
 =?us-ascii?Q?24LiyS6Od15jWKoWzB+rJHMgDnJqdNb1W//NAbtrWMucCnKZD8IedYqdVNTB?=
 =?us-ascii?Q?rg67McyD3W2LCyjlxjQGmzpRVYLEGkzEj6caGdw/cvkVQN/yx+VgQGwbICWM?=
 =?us-ascii?Q?b2RFfZX+vuSJwjdc0mlRKRMgw0P8u9FgQNXTa5976ZXh3M+xRHrAbqAAnUyX?=
 =?us-ascii?Q?OoSPYjTTHAogdspO8jH+59HTEiYgJNIL0ZY4d6pt5vkxWEu2DwLcCtewEayC?=
 =?us-ascii?Q?wwbTaa0YBWnfjhJ29bliBExkqG+mLmuL/d2IaMAtBafEHVC53U0j1W1qhnJo?=
 =?us-ascii?Q?Qemwr3sAMICj+o48YtoeEEtp5kSimL378rZGE/7d8SOWGCCfISKS3VuL22Ka?=
 =?us-ascii?Q?PRojalgW3t61VVvlSXRPHFWutVVLj5+sdjruqSYuBE3XNRzqFxc78sQbVcSx?=
 =?us-ascii?Q?04UbfY60NxsREVJblwGbY41gtoV8EdoBZ27bHtEy6L5khxqSN38xppVk4TxR?=
 =?us-ascii?Q?Da+zwu5cNscZDG3/lX80+SZD0kd20RAO66NEDptr4pCnYQene67bxvOEqn+H?=
 =?us-ascii?Q?ILIgnCKQ0drdz/dTJnTdL8jNrLnqummW6QtIynT2/eHNuGg2QZBqlW1nmV/9?=
 =?us-ascii?Q?cITRNvPQeid4zzoyWzmDuUno72FslhB2HxYUKB70IMRvr/d27Vw8JKIFQ0yo?=
 =?us-ascii?Q?rsdgHo5+B4hO6rjlodT6PF9rloecyrjQXALpFFcUyehjBD0ye7si/8jxqJBe?=
 =?us-ascii?Q?vymRPezddtAQfnXujf6Jcm0aCphesUl8i35I6BFUOqiAegbS1qsnEoBNldPs?=
 =?us-ascii?Q?k4woZpDxxsa3eLSNMnyF9nTLRgSwPoe9/VV77SZFjFTlQiz3Pc+2meU+nSjy?=
 =?us-ascii?Q?MwxyiCuY9a0LH4jM9x5niRTxj/TNxWK6mNIFVOIcqA7en3wk94z3C6QfPAQT?=
 =?us-ascii?Q?/4XULZyPIvJGAGrTX9WkMXDiuzARDElzRNjqFB1Shdsj79tisC8YLc+c6To/?=
 =?us-ascii?Q?5Z7BKH88tdYZZsMfsAe6614L1182eu9UYkpXrg4Xp/7e4hWyHWQZMeNS4I44?=
 =?us-ascii?Q?lizVe5bhzykxD44vbgVgsIs1g/f86SbehQo6lssxFJFam9nOD3C858Fk7oNx?=
 =?us-ascii?Q?NM4BdmgVUUJhFhNMyEXe/cNr0ciE+nWGr8DpOSnnmcV0APDFZkK0xMB7tgZ6?=
 =?us-ascii?Q?2CT/fMplFnXhocKOqqdvWhd8bQor0kiiVadppcnUWcpcZQQg/ZWVKVRnzvj6?=
 =?us-ascii?Q?dr8G8t+7+HbGYdL0zonKaLlaU4R5nKEY1iYJk5WkSQGvMtFeJ1BZbWdH//m2?=
 =?us-ascii?Q?xTX2l/EHPiMkNxKdWWFQBHjKdWelxFHIO/JUsi6pIxt/+THR0APFjy76vEi9?=
 =?us-ascii?Q?z3B6DibsgNo04r0OUs0+eni/gboZgxXFMV/xn0VqMHVAHP2PQvqo3z1i1sdw?=
 =?us-ascii?Q?PTtNep8TbVBy63tA+d5tKHxGUMen5jtqg9A/CH6g/zx54n0ZgCvw1gqyuHwS?=
 =?us-ascii?Q?VdwjT2sGEEi+vLoGS5ABcg+oax3DN+jZHuvbSyF3fqg9YG0SnGXlLUu1yES+?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HhS/YM/MD1dcxyCNY0VZWpM4AqU2I0bMGypwr7jt8BJA+7SYCj3xZffS9J41I+dNVEuJiIgfzFL+eiWIhpCHVkpg5qxLMhCOnR026thcWv4QftQLchY0dKUaZoT9weupgt4JAi3GCZJP9iywA7A9j2o+FgTMov/vOCB5XwMtb0DEaj0T+PNskuT33adz4dw1GYJwxjSnQVQ+hImtppczlNfHRpxJSwy1IulcZnVJlFKtAkJ8Z6kgHiTLVHW2WpMT2TAUjwv71mDN+C5/n7nNm031Ab00nv1RfFyj2PI2heNXnZYeHlslL44yl/BSPom2Gfw+VshJRP1T271sDvxuwVsFrMss6GsKPsmlhBEnbzLWzCUrJnjZ+iPHSWHlRgKmM+zr0uO5Kax7YtqAYIwmwt+K81s+nkzsSe7X1S8y/Feja9Az899rpNmgjwTwGnZt3VvonoKhJbgMISzFwbpmJqWSpo1I/tNPUxaUEVss0MX2LcOBsHbwmVlqQFodAqWUIkq8cjRLy66W/jFKQFg65GeqRocczOqGKD1DFGOQF2HQNPuKXYISFxMpQU+k4m/Jef5ZPvbBrx7Z2y8oq9Mp+j6hqFRU0y/RPpgUuqE1p20JpnHrepz3w0oRyNHzdnNQJjVOi4pEtgm4ZOjP6K2DNBhO6J1tMK45Te+0ViTCO3SCyB8q4cjHFW2n2D76dljrmE6yQ22gQmITzjhX0M4sFjzG4sElPylTySd7+nbN4tJorTa8CY5rlfU6C/9GmbmK/d0I+/JYoTKhCLtFeD5Sg6+suiv5y8p2E6XRsOuQXiW5or4xh8gipdXEBtokA8YmA2WW20lzoXJ72m5mkHXFd6cfi2+UwUZN+HRlPSOn3fsf2ZVQfKkdPnwci/b/Qrdj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcab3bb8-1a32-42ed-c41e-08db1927d630
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:05:09.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkj/8BfzSKxMFrW1cMdJvcznZwICSC4pUQw55Sa/qN/cYyBqdh653eTWqulHxv0cdY5+0H1YSFoX7HVmBPri//bYyr30BPWkdx9P19W4pBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280007
X-Proofpoint-ORIG-GUID: b8UwLfwtHwh8luokDtLU5E5iAsqjpG4B
X-Proofpoint-GUID: b8UwLfwtHwh8luokDtLU5E5iAsqjpG4B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> -----Original Message-----
>> From: Bpf <bpf-bounces@ietf.org> On Behalf Of Jose E. Marchesi
>> Sent: Monday, February 27, 2023 1:06 PM
>> To: bpf <bpf@vger.kernel.org>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org; David
>> Vernet <void@manifault.com>
>> Subject: [Bpf] [PATCH V3] bpf, docs: Document BPF insn encoding in term of
>> stored bytes
>> 
>> 
>> [Changes from V2:
>> - Use src and dst consistently in the document.
>
> Since my earlier patch, src and dst refer to the values whereas
> src_reg and dst_reg refer to register numbers.

Oh, I didn't realize that!
Yeah sure, resending with src_reg and dst_reg.


>> - Use a more graphical depiction of the 128-bit instruction.
>> - Remove `Where:' fragment.
>> - Clarify that unused bits are reserved and shall be zeroed.]
>> 
>> This patch modifies instruction-set.rst so it documents the encoding of BPF
>> instructions in terms of how the bytes are stored (be it in an ELF file or as
>> bytes in a memory buffer to be loaded into the kernel or some other BPF
>> consumer) as opposed to how the instruction looks like once loaded.
>> 
>> This is hopefully easier to understand by implementors looking to generate
>> and/or consume bytes conforming BPF instructions.
>> 
>> The patch also clarifies that the unused bytes in a pseudo-instruction shall be
>> cleared with zeros.
>> 
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> ---
>>  Documentation/bpf/instruction-set.rst | 63 ++++++++++++++-------------
>>  1 file changed, 33 insertions(+), 30 deletions(-)
>> 
>> diff --git a/Documentation/bpf/instruction-set.rst
>> b/Documentation/bpf/instruction-set.rst
>> index 01802ed9b29b..fae2e48d6a0b 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
>>  * the wide instruction encoding, which appends a second 64-bit immediate
>> (i.e.,
>>    constant) value after the basic instruction for a total of 128 bits.
>> 
>> -The basic instruction encoding looks as follows for a little-endian processor,
>> -where MSB and LSB mean the most significant bits and least significant bits,
>> -respectively:
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order::
>> 
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   src_reg  dst_reg  opcode
>> -=============  =======  =======  =======  ============
>> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
>> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>
> I think those should be src_reg and dst_reg (as the register numbers)
> not src and dst (which are the values) or this will be a documentation
> regression.
>
> Right now I think this is a regression since if I understand right, with this
> patch, "src" and "dst" now refer to both in different places which is
> confusing.
>
> Dave
>
>>  **imm**
>>    signed integer immediate value
>> @@ -54,48 +50,55 @@ imm            offset   src_reg  dst_reg  opcode
>>  **offset**
>>    signed integer offset used with pointer arithmetic
>> 
>> -**src_reg**
>> +**src**
>>    the source register number (0-10), except where otherwise specified
>>    (`64-bit immediate instructions`_ reuse this field for other purposes)
>> 
>> -**dst_reg**
>> +**dst**
>>    destination register number (0-10)
>> 
>>  **opcode**
>>    operation to perform
>> 
>> -and as follows for a big-endian processor:
>> +Note that the contents of multi-byte fields ('imm' and 'offset') are
>> +stored using big-endian byte ordering in big-endian BPF and
>> +little-endian byte ordering in little-endian BPF.
>> 
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   dst_reg  src_reg  opcode
>> -=============  =======  =======  =======  ============
>> +For example::
>> 
>> -Multi-byte fields ('imm' and 'offset') are similarly stored in -the byte order of
>> the processor.
>> +  opcode         offset imm          assembly
>> +         src dst
>> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
>> +         dst src
>> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>> 
>>  Note that most instructions do not use all of the fields.
>>  Unused fields shall be cleared to zero.
>> 
>> -As discussed below in `64-bit immediate instructions`_, a 64-bit immediate -
>> instruction uses a 64-bit immediate value that is constructed as follows.
>> -The 64 bits following the basic instruction contain a pseudo instruction -
>> using the same format but with opcode, dst_reg, src_reg, and offset all set to
>> zero, -and imm containing the high 32 bits of the immediate value.
>> +As discussed below in `64-bit immediate instructions`_, a 64-bit
>> +immediate instruction uses a 64-bit immediate value that is constructed
>> +as follows.  The 64 bits following the basic instruction contain a
>> +pseudo instruction using the same format but with opcode, dst, src, and
>> +offset all set to zero, and imm containing the high 32 bits of the
>> +immediate value.
>> 
>> -=================  ==================
>> -64 bits (MSB)      64 bits (LSB)
>> -=================  ==================
>> -basic instruction  pseudo instruction
>> -=================  ==================
>> +This is depicted in the following figure::
>> +
>> +        basic_instruction
>> +  .-----------------------------.
>> +  |                             |
>> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
>> +                                  |              |
>> +                                  '--------------'
>> +                                 pseudo instruction
>> 
>>  Thus the 64-bit immediate value is constructed as follows:
>> 
>>    imm64 = (next_imm << 32) | imm
>> 
>>  where 'next_imm' refers to the imm value of the pseudo instruction -
>> following the basic instruction.
>> +following the basic instruction.  The unused bytes in the pseudo
>> +instruction are reserved and shall be cleared to zero.
>> 
>>  Instruction classes
>>  -------------------
>> @@ -137,7 +140,7 @@ code            source  instruction class
>>    source  value  description
>>    ======  =====  ==============================================
>>    BPF_K   0x00   use 32-bit 'imm' value as source operand
>> -  BPF_X   0x08   use 'src_reg' register value as source operand
>> +  BPF_X   0x08   use 'src' register value as source operand
>>    ======  =====  ==============================================
>> 
>>  **instruction class**
>> --
>> 2.30.2
>> 
>> --
>> Bpf mailing list
>> Bpf@ietf.org
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
>> .ietf.org%2Fmailman%2Flistinfo%2Fbpf&data=05%7C01%7Cdthaler%40micro
>> soft.com%7C65d83bf2fe834f73f84908db19067400%7C72f988bf86f141af91ab
>> 2d7cd011db47%7C1%7C0%7C638131287757978381%7CUnknown%7CTWFpb
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn0%3D%7C3000%7C%7C%7C&sdata=8il1%2B8I1T8GBqn3U%2B7YJehIKjS6s
>> gvxTRWS2CTpg%2FZY%3D&reserved=0
