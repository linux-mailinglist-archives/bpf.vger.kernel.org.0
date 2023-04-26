Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472D6EFB15
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjDZT0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjDZT0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:26:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370C193
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:26:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwxG3015486;
        Wed, 26 Apr 2023 19:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PvRebnnDSWx0TimcKc+bDBCH+X8LamUj/RXiWreExK4=;
 b=suTcSq5DL+gqJQdPnKIItcvXSeKXZxFL7kQUOKidjyFccZ7pQup4ZRBkg5aGM79i6k4k
 xfsOVbsCY6aLLvwQHM7L/20YYXMWZY0f73t+3tojwIO9Sl8z5ETSFkXnrDnDLLGy6e7/
 HuhVoRJxycQpX3LSh7yN18OuSR1cDfNfkCnKHF/IZZuNwTbnptjSp4UyzI1J8ipMdypl
 6fa0SrzVxrnzMpayAHTTZq9o6PpWyRnQyLHzDYIBx8k4XEf9tui6ikYgSM0ouY0UgKud
 bVnJ3MNvoWzjaS+NutxpNAhKd4ZC0Nh1idY0bSOG9THEAZis2p4RYLtAixz4XKyW4Eib 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460da80u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 19:26:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIIS5i008510;
        Wed, 26 Apr 2023 19:26:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618kuss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 19:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOu/DKIgNVrnt+Cty4aESUj7qJMIJxPtCvxkqxC/II9p2JIPUF4GUp3w2eVIaFw81cF59HdAwLg2Pmgj+Mg07V4cXBkKAhE8OfQrsaKf0CbavtpevEjxel2KPPYr3fjlgg6XVrc3c4W+rM8cSD8PNSESjPCuHd47fftiveXbBGd3KWnK6Ixm9/khZNyWE5B+Xk9xNtreY5YKuNukqqq0vIK7TJa79KxB5yHSnpNXO/Hz+ZpWgIpkOmNEZY+aGy5UFUoEVtcmxVKD+jO61dfTj24POm59jDgaKx+N8+m+g4+S1R9dAg8yj6X2wG3CMMl0iTG7wA+ohfCMQwqpmA3XsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvRebnnDSWx0TimcKc+bDBCH+X8LamUj/RXiWreExK4=;
 b=M0DUoAAbHt4GxD2RGTlcgQjLI4vcimGBlFWgTu1/0nDNmUrC8XTua5xsZ3MUhmD7ukecniZM/M9CT9EuKoUKlNSlURyTgkdiyOnKU/A0u6fr0oEDfGvYfGAi21oJh8Pr0G05kp3XP70meZ6k6oKeq7G61kMRsKJIPpVyQYDlv5lvIjQ+SwemSXazAyeMU89cV6MC6C9rJ9EXpd+mKgE2Qbiici/HpsUAUYO/VkqGViVWgUgm7Wmlo9XiAn97RL/fAJhjj5RhiMfze2soVhqpU63S5arUsC06cKXOBkwuukjpCmy9/tnbSC6M3/cSIu4C/L/aCOfxl0sJSuxi21CSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvRebnnDSWx0TimcKc+bDBCH+X8LamUj/RXiWreExK4=;
 b=WMTa2Q1N5T1VbkYj6OFXh0vJpBKoXmLXwJkQYALFuag5PVyE5ZzJ14vrxsAICq5m+/LoU/IMb2DNASc06AyypBurAhBBY/4G+f7limwu9+ADZjhw3CE+IYc20ClHD423Zx2l+LJ28bYRdV1B2SpXbnjiLTlLtxqNPNTaORQy+BI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB4943.namprd10.prod.outlook.com (2603:10b6:5:3ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:26:39 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::53da:d3b:d2e4:d40]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::53da:d3b:d2e4:d40%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 19:26:39 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
In-Reply-To: <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com> (Yonghong Song's
        message of "Wed, 26 Apr 2023 11:28:15 -0700")
References: <878reeilxk.fsf@oracle.com>
        <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
Date:   Wed, 26 Apr 2023 21:26:32 +0200
Message-ID: <87zg6ufnrr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9395cf-4d44-4fc8-8279-08db468c2848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENx5wl51Pv9bVRIbKOuAZUHlYp7KCBSITdO36YqXhLzKO3sTLrRj8VbN5n8YENGUhi+B0C7dFULNecL19hubq1t0JUv2Gh7tUk6xtoozjg8WZq2ltH4UgZ9/mBhGLfG2qfW74JfM5RxIInzr0lf7RglFN3ARa4+tVOCzcZieGiTySQpC6Gd7m0ZQb4GwQlCcchwJHJzqE1Zr/Jjg8LHg1ECL279CONqtqEoHO48rciRqaH99OANJdBK3D81RYrCkkS2KO4q/1JI3KrpnaeB8uj2rLBfYPC+DEdHO5GXJITSTyx33scBvsqxao/kODFGxu9z9LiLOw0TCzGJpPuX0MLDcFOYC+GWtudzEvWRo/osgFV8uwv4cJ9a5Z3hNFp7jMw163u2Ei+qYuurOHlh3m+2YpswXx2kJJM6ZqAmay/WQhLBhHxb3arFDx8Anww5Kgxl0FDSx+CQmnFHEaYwwaS7Lk2/QkZyKWZOUI/DPuteJ5YmhB/Enyfv8h1CapDlmGw77KT2owW9IcT+Lmy9WxnePTHxrXfiRj32EapYMXFugi9iClKvvmC9/LWbuykK6ZYn7mHBgTTcrzQvEjZGzaY2BiLzNJtlywI1lbEZF0qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(26005)(6506007)(6512007)(38100700002)(966005)(6486002)(478600001)(66476007)(66556008)(6916009)(41300700001)(66946007)(36756003)(86362001)(6666004)(4326008)(316002)(2616005)(83380400001)(186003)(53546011)(8676002)(2906002)(4744005)(8936002)(5660300002)(533714005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2f6Kq4YlwgNbjc9dWPzTYLRzN384VNVGiQTzvjTNsmYE1IL0DTYQZ0q0MSZ?=
 =?us-ascii?Q?qaDgOGk1BDZJbXP7XLXZ4oYul9wMr/FFuZ5T88lrODQ4Wxok8dz2hHYqp2jT?=
 =?us-ascii?Q?VM4UPkIi+MLpJ3aYBpBAs74jm6MFUilXW1ARLwz7WrT7iknOLepkFV8ZZIdH?=
 =?us-ascii?Q?SR8Jp2yas4Hh+8NcsMqr8w+jO7UXdkMJDyBvDWSVa8/2P0MZKnPkz2IE9KZV?=
 =?us-ascii?Q?2Af/FD9g6mhI4hrUYfVnfoxp0OqhE03gZGSqfJNRLm649+pkFfiKyXbn/ru6?=
 =?us-ascii?Q?dgYGWzzblQ4FjfeouA3Yn8gp/eY/d4Rn1LZHCF00y2I9rtG+yU9TfY4Ne5dX?=
 =?us-ascii?Q?IuNyvse3lcy9c4EZvrqUBs/H0gi3ord8E0+nBoQyIKoY0FNKGy1mKw4vidV5?=
 =?us-ascii?Q?1sN6G3JXUnfOQzOD7LkWYwDK6fYZ9RtL8E5skHvtRmjjDjq/72X2/xWRBnSE?=
 =?us-ascii?Q?gBrKARmKf5E13FYHIAqWZFu1o33YB5+AFvnZQNMfShk4lhC5YfmeBm9rtT55?=
 =?us-ascii?Q?CzcCOOWztg+GWbb/ywT6KgKMT3upy9xRCdldd0pgB/t7N2VzH1nntBO9Y+fW?=
 =?us-ascii?Q?sAmxslI0UUzupF0HL2/1ccAN9ofEZunXiLDWyBzUkISs/4q+dOaC7D/++BbE?=
 =?us-ascii?Q?ZOyE6J3+YHwmUElN0PF4G3QTnJdVtHNlJhI58ANiiBb2M3OigKo51CZVM7Jo?=
 =?us-ascii?Q?6imkS/z5OX9roZqMo8kuhExSlyS5c0MWMDjeb+jFV58GvdC9vuzHhQnkODym?=
 =?us-ascii?Q?B+x7iOsHfSvf4387wA9BkLypcWYK/RIgf7sI/71zKJGM8fZdD25Nz5uieBdt?=
 =?us-ascii?Q?S7Z5O+RZCqwh0QVfa2KUCjzpAdZeSJDtoO7k4DxJHE7b8IdoeoJ95OpwdklM?=
 =?us-ascii?Q?FV4XVo+KF/NhfagHFivjLM+2kkdlFQimPu0gMO434cUo88fOtUMbL/9YlSeQ?=
 =?us-ascii?Q?PIvnVzXFpwoT545GA7q8xAaAl2jlCXeeCNMGjVgZgiNbBQct76yy1Kuy/1Rx?=
 =?us-ascii?Q?CSQ8GUvAF0ibRZKTKn98JyXABOJdRJ+q8Pp7Kc5vmDAFMLyVA7MgC/mkjPUm?=
 =?us-ascii?Q?wuF5bUMuyjvQya3VHTbsldQDBPiuIADXZszPG1R199eiA39eczFGQrmGdRwX?=
 =?us-ascii?Q?OCWTVgsZhB1V3+sJ2t5nF61HMlXSeOs/SqUEQI0fdFe2KWSl5Q42ON0vDz7x?=
 =?us-ascii?Q?jK7kfqFdCFauoGuDMpLhu5KbOkNiFAnrh55lpV5Xk3UXre4fEY9DD+BucFzz?=
 =?us-ascii?Q?gHtCMyMYE++wp5VfJXZFGUo2ixuziSD8PO+RhTQZEPzrTl7T4imWTPbzEelV?=
 =?us-ascii?Q?xeJtlkgKFhgz6ccoQGlzMJ5Cy/1bJRd5K6Vih9Wo399ChFq4UL8gNN47W3dc?=
 =?us-ascii?Q?WPGjH3Ns9Tw3YP499xSAn/OK3uD3fQc0cOxpvihOQU3Gm/e+3xrAsz1yeaYB?=
 =?us-ascii?Q?ISBd6sXTupmGS+2iUkWIgAnId4LAq8L/UpKMeXwbfQpG3yX5xmId+izQUawG?=
 =?us-ascii?Q?McaDCAx2+kz/2JaxP4shlrzLXldbNN48C6BzMWWEJNQhgtlk+VKjnAMaTzOJ?=
 =?us-ascii?Q?JFd6YJvI0EJinc6616/z6jCudz0sH8Y/ldpws3PUpw/ntwG54kMOdAFVwqYL?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcAypExD4flWtnD3HjAMJYJijUw5h42gWPhrBV2Xo5BMHdeibZ+RHfGYpZWOtKcA2CMZa1GsIDiZxKq5zJeKP4eGRyz2JWP3JaEAFFvU5rp0LWWuMB2zmHo2YUPcgOR5DaC1Zlysdd4BwYkq18RthUPnL2nsuSKApnFa1+GTX8I/33p7EAYM+MoRjZxUzDV7A+1me0QGMkLQB6dXQDq9sbviHO3mEbhUHrKogA61pzPJzkmMsTWnPNoUMs409OftTkKCxb2UQ4033IR0bAVYb59fuGGNt3cbAVqXkb2N6aunPixGBIsldDnlicLygU5RxcY/xge90azVIXq3sh0uU9OWDGUIeWEycN1zgCo2s03tlzppP+crh/8Whis2PQUGrqQwnISx2MlTJLzWm3sfYQDWWu6iN0eyezG08b+zKo5oELN0r49voNIku4XDXlhdOPUd7U7gkQsy8v0Vw7rESHgO8eC3ZzgXKPY/behRJHwrLFf2G9/rEMW0Gb4qgD2yPXIX82g2q4eC+dom+mCsVHrMP2Bn/BKw1ogZwEm1CO+4YFxCIEAdZfp4fl++1JaRO0NXXJ03YMQ0SZ+KpnzTTIQCmVjtKZ6xHrDllb+oDun0mtE6odZPKP3g/kYVrsQmTRojbCP7sgB63r7ouqrRKDsTYywHtz3SQQg75g45ECzPPhd6AXi6alUp14McVu1FL/at3aPFx815cuT6jy4LuUZYGtsaGQ/7SE+PqdLRf1s6PzteynuzbbCDXCUq8hrlckfr9TV8s6owAkCtrG/73vqf3TcjKwu7/VDTlkURAcIKh55afqPpDVtbXHq7UC+L
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9395cf-4d44-4fc8-8279-08db468c2848
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:26:38.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDG7rcgrXBrAZ5n86KiV6MNFy0AnsGnjsBvcuppvyl3GxwiyqRE55PSIeXl8qc+XdXxPw3FjTWsAfPc9vPv5guV7iiJ7vfdfD/inJZFFlKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=995 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260173
X-Proofpoint-GUID: HbkLnne2GK6kjk5c8QUa5Xucnig5cpoA
X-Proofpoint-ORIG-GUID: HbkLnne2GK6kjk5c8QUa5Xucnig5cpoA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
>> Just a heads up, we just committed support for the assembly syntax
>> used
>> by clang to the GNU assembler [1].
>
> Thanks! Do you which gcc release is expected to contain these changes?

This is the assembler, i.e. binutils.
We don't need to update the compiler.

>> Salud!
>> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.html
