Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E867197A
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjARKpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 05:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjARKnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 05:43:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9464676FE
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:49:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I7YMxK022191;
        Wed, 18 Jan 2023 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jQ53a5bRM99ilrq1fTyOcvRpl9bJN0qfcLmzRXlCHZ4=;
 b=nUBxLMha4iCPwff5RbA3ITa+Hwvn+wRDxB61XbSHxnFTL3OamdEpTRf2ZdE56q0PSzXw
 v1Auv6/SkQxujGMi9AY+Ohg22tEP65hQrdpsj5RsvuG1V+guMwRz5/IeYtuHGZUAr0MK
 GZaEZcfibAijyqFsKZHGJLol06OytuflfK6SJAg2rKnfsgxhRuz2ou1ycUQA9dQm/qpX
 S98XH/UM+VtekzGxwR1gi3i6ihR9zaC9lAge6ZyWGEQpKWxAkibW8hSGuCk/vDEHTkOo
 s88gETUKrlOVPqil+7DZr58y/C1MI7ixCw+D66HkGHir949NqQktB4u0wW3aOiqs8Qr/ Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt71m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 09:49:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30I9lDTp005080;
        Wed, 18 Jan 2023 09:49:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6eeg037k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 09:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXioon+LqiLc2pyPrDyIOD/tTB0mgg+eF+XomDQjGaUJNWzWa7mhexAGp4O14gIkBXcZ1MctrEPRQ+o+232HJ+de36ne9+9/sDHK2zDTBe8EC+kyirW5RWnK66863+nNPsBeuXMU0iRSERag+VzHo/q0OkCPUjz3JG9TQG+YtPB8R2b0oYk3FbcgegB9XubfjRZRWs+y3MxryMc5E4g3EBoU0QvHd23eIl+yzTO0NS+CBA+f3Yax5WstsDcgHhRtbCL3SvK3HDI+sZn2axSg/Ep6Nseo39fz/JsbuO9QyPQG2X853CBmpzwsgWQv4GTFnollZ0Dl2kpHyNqmDTHW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ53a5bRM99ilrq1fTyOcvRpl9bJN0qfcLmzRXlCHZ4=;
 b=ajU34sVPjBOK1SHaMVsyFdXwi7iGREN9ZKxfBzd71dqRaxBZimB1AWNC33eOVnf/sKqCFgGZZRMAmAcW9DhhwkgI+yoQI6BunU7A7LTynk/LGdkUC037bxiGrdRyS9rFg3Oiqo7h/sY2m/NC1OOpBoA20PeY24WpfFI9WYbVEuNWcaAM8aqB7Kj81tUTAXfY8szbYzseiPzTJt1Yx46mTqQU4uNsz/44kG1FhnQfAlDjrCFufwJQMVOBorMdj2hHD8wd3evAMSnG6Uic1V2PoNZAJ5OIRzRffoHGQSmSzzitrkGC/BDSaT8B8+QHdAZJ2LfZKD6dz0/jaIii7kKPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ53a5bRM99ilrq1fTyOcvRpl9bJN0qfcLmzRXlCHZ4=;
 b=kRz2/Z+6rNlwArOgrRNaj0nnzBGQ5T8/HdBYLk3nhyGjByRFFqcjzYBxtszqvM2ZMPx2kc5Y/ZmbBID1GgAaaQ3UF2C/mu5zWMgkhQwirYsVo9tJAwK1B7WY5/bumN9RRdvsq6hf55u0426K1fDHos4iMfGvS5bbBXWyn9oBKFY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 09:39:19 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6002.009; Wed, 18 Jan 2023
 09:39:19 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
References: <20230117224951.984-1-dthaler1968@googlemail.com>
Date:   Wed, 18 Jan 2023 10:43:31 +0100
In-Reply-To: <20230117224951.984-1-dthaler1968@googlemail.com> (dthaler's
        message of "Tue, 17 Jan 2023 22:49:51 +0000")
Message-ID: <87o7qw18l8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::24) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: db18654b-3b62-4259-c6ec-08daf937def0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHfMWBoFBV9eicKnM3atc4SKp5UyQxknKwmmW9MByhXDkjHD4m4XijOqtnrz7JZ1dAwsC4JXj1teWg6k0rj9n11ATqOsmSfinOzRNT0+x5zrwkO7SyHk0sIe0w6eOJoOoBmZc5825N6Url/nMWHnVznDfI7WBwYnxsRaEbKCFsdUoZHhrkbM4teL5ruY3u5WHAzWLIxlbEYjBayI5s2/9dxknK2DopLwL4ho6SBHuP0yIn/Z+HS9sDcJ2qTdj5zEj1Lel0e+o4PleF3msYN5tTPA1zichF7ISxjY1UwUlojO42XgnZ9MpO6iHZ98X7LKNQ+OvMWQwkItO8M/Fwcml9gpJYGQfsO2gdUi7OMPMfoPBDlXTeSuWLUqFQitofeS8vfVHc4l+2DFYfBfwPQZqDIN6tEuaUtJTVu/yAkrEI5c+4l3gDTRY21toQn+TmZgkNJjokg2Pzrz8QW7DfK7OJ70b8pEf9TtX2FCUysfXARMTBf+C5m4jVR6rsrRQCz78gGyBm62PQxKjBVmSOLCw0ySfZeJk5Gl/7iM76gO/qlYRdk51sji15FzcOh+d+j5N54i8Y1Hr5B+vQylj8aHE2c5rwTPxdk/9GgLcTOHSuG4gHhEzFe8LYGn6kamu32TJ7F/jWpVYE/FIUu20LaH+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(8936002)(5660300002)(41300700001)(4744005)(6916009)(4326008)(8676002)(66556008)(66476007)(66946007)(86362001)(2906002)(36756003)(38100700002)(6486002)(6666004)(2616005)(6506007)(478600001)(6512007)(26005)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgvgxXtq+5jj7aCEePYKNqe9N3pFuL8S6RBac6QLS6m3ZsFvfHc7RYkUjPq0?=
 =?us-ascii?Q?eWftQUsUWq4EOrMQjUjrCGS6SJ2dHHD1j60nJ1fyCnxJRNCCP6d7s0Sr14A0?=
 =?us-ascii?Q?V5/ZX7oAsjZMBqz41ezB9SKRHSUYNx9IpT6NZsXc/tRAAH05Db8B1+1Zbq1P?=
 =?us-ascii?Q?RNIZUGMnaViIxJVv7PZO5CGQpCPDW0+F3pa4Ml84gCoXzZaeHlQr9pNdRW3v?=
 =?us-ascii?Q?1K3v5NHsXt4a7eTbu99L//VedBtmCJxzbcyggAk6XbFo/2t0/vmL9sK0VWTy?=
 =?us-ascii?Q?+T5vlI/bH3yLjDNKcPRkGU3tpfL4OnfYDkWCGdLgjJ0Cf2/LKVJ2ByAj9VL7?=
 =?us-ascii?Q?7x/n2K7iPhTNMRUjDNrNfCQ26I1AJ8a53IDg3QBx9huFnC8sd5VdvsFv63+A?=
 =?us-ascii?Q?8D5brttiOaUNLGUyB+z6EnwlDY6yLCBp8X1KBgRedohJbeK02t08FK12pF8U?=
 =?us-ascii?Q?hLRDiXgLiMZUj9aC3IHtRK8Y8zSZibMzLQhe+kaHt7A2HIrNL3QGJJfXVYwp?=
 =?us-ascii?Q?dMHBEgOmaOrmL7DGDqmoj2h4ZV5huYtb+2TNUGLOaUAm0VYwR2Zd6vO0Kbje?=
 =?us-ascii?Q?fJ4C7vrpJTgG5ZAmJ5Cq5p7CYPwOtqOCo8SSYvQBEDLkcVogjcWessY4T4pK?=
 =?us-ascii?Q?4LSttnGk3s9712ItJN5zGZm+uQEdhmj27IvFzCSbFjHJbR6Z63ZS4HgYvEbo?=
 =?us-ascii?Q?p3/dVwkdWas4xebM7UjpdH1FzNfsMnU5T9VUoRjZz8T1qIsOuHhwVJoKlkN/?=
 =?us-ascii?Q?PFPhmgMrrwEjYPnmUdTDa93WFxOG/ltgzSzgMYBU8PHQjBJVtQuGDIwNNzPA?=
 =?us-ascii?Q?T3x9qSDFBbC9ZR8YdmVRZpD6wELXabYRz40vu+khF0xNjllsL14jQl8cJWgW?=
 =?us-ascii?Q?KZsAwpykP0Sh7XEdg4vss/bJfehhQiiRvsTRcBc8qM8kyrsQ3dVoxgY/RMJ/?=
 =?us-ascii?Q?Q+5CxWUHYJQMqQWQSXBFZhD/cv4HDB/jbv6a9dFfTzK8UQoiC7I+SPJFpEAV?=
 =?us-ascii?Q?9PtFwUeVFn3GU1sEp20iTjAVLVTKLOivkR7qguL44fHEcdykIHgRpubfpj7d?=
 =?us-ascii?Q?9Sm5PGfu5IRzQ9dH/sBdgQfct6EBpjNeqm7XGnRJY6yogp+Uzi4e6RXJpsMc?=
 =?us-ascii?Q?m8ejB92xIEbolQ8aohvvjISp3muo6ZeQi/PHODHpXnDp2x9NzEk03F2WAnmi?=
 =?us-ascii?Q?buJppUVK3rJLIMzW/0vNDYw7FH3x0iwhhL9GWc8Lqv4mYv7XyN5jmL2voHyv?=
 =?us-ascii?Q?QExho9wfKDTA/UWyW8G35el5RGejGusFqeW+cJvsTZLicJkbj5lsyALHpOjl?=
 =?us-ascii?Q?3j842ieiY4h2DbsZHbhCXnYhCzDDeXd215QPKpGzpGHozI8qK6JiDfSyfv2K?=
 =?us-ascii?Q?Qly5IR4ISY9rMNQ+gEhTIDAOMeFw2mxqf14rAxp17x0oFl1eh6++xk+51z9k?=
 =?us-ascii?Q?YGy7NfG6He4k6AAPdN3F23XG1BUO65CmeV6/rt4Ij6HHvehbjedQ8BT5LCfj?=
 =?us-ascii?Q?fshvfUIZHja9CIte2aNrNH2xW8A5B3L8CNbj3HAjBqmi6xbZsIQrBzt+m4UR?=
 =?us-ascii?Q?xiw3i2FVAqsp9rDWuJV7o3tz88OugbWRgXE9k1x4FhRTiCgxV9R7yhOxU5w/?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1G/d5mCrD7RKMhWgS6E+PWu1FHUzdmNQG1lHyttWzgZYWTbpuvKcHgk+TbEQfgwFRM5OxwPaCHjik4O0sY6FSQtdvG3XtDRlLatrEry/8k4GANodxff9WDAP4gd6+mk4bB1V/rBMxLzbZFb4cEXZr/s0Qf+t7DEKoQ0cHOFv7eOHLFSNqPahCtiypyitJrpO6GqNOIkb84MZ1e4AfR0FXEet7gmdoHJ2u03ilsoQH1n9NMBYC/0rvn5TEVmelT3PCWNJjPfafFb/Rx1afbE+mSeRa2l3eJLav/p7yLb8SytthOYYi+l44Is4nRnoffJx3TgWF6jKrCm5cvPuy5NdOmzaPqo65o/ccvCLj4iaBlNcUQhLtdcz1gaz4aiM/xH5jyqsXEPvCLjE9uxgYHNACpRLJze1CYSxk0hMDt8cJYIfv0G4diTTIY9LIpWq1NpJxejcXQsA13kb6ho9qCBAW0hsoyEf/trgXxyu7XluhrMbVZrbdtwdvQI6O6Oj3lhl0wiPWg3UBkdqVQGwBgaVC+xfD9TS9d01Q7C21G8KotzCFXlnKq5XOuzrNwixIh9k1Gefrk96y5cJ1aBXc8SfuIezMEQslE0HZSt9twTXkkRLh+07bMQZBuUFcGjZdDHPia0GBRtnLzQ9Q+gkfS4uLCakeBRdxoJBsU5WuQpbxQNzfXXp2BTsUlBqHxmrFlBpnzA4FtNQ5gY0rpKl3GbG/1XNdY54k06BUM0NjvURJNB82Iuh/HtqdLfGio2H5xn/1hqzVcVoN3vPtu3+JAzgGzEMH1Mt/EFEHM+pASxxfajliSP0Zh4rGzIAe9i85Fg/IyCVkFkuiUPFurJMEKDfsA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db18654b-3b62-4259-c6ec-08daf937def0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:39:18.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o95//+GvLMKrVtrVxwC76DwrJsbdd8mVqOfCPA4mimAFCZOp1GILp5IuIHbbrimWwDmGCCXzMcmK5W0YqZr6MIecTz4G6ls8CH+oGokYFLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_04,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=627 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180085
X-Proofpoint-GUID: rsHyMHtkIHrcik99WrwA5eRrqXdu360N
X-Proofpoint-ORIG-GUID: rsHyMHtkIHrcik99WrwA5eRrqXdu360N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> +Also note that the division and modulo operations are unsigned.
> +Thus, for `BPF_ALU`, 'imm' is first converted to an unsigned
> +32-bit value, whereas for `BPF_ALU64`, 'imm' is first sign extended
> +to 64 bits and then converted to an unsigned 64-bit value.  There
> +are no instructions for signed division or modulo.

English is not my native language, but I think "converted" may be too
generic for this paragraph: are the same bits reinterpreted as unsigned?
Or an actual conversion like absolute value is performed?

Wouldn't it be better to say "interpreted as" instead of "converted to"
in this case?

Something like this:

  "Also note that the division and modulo operations are unsigned.
   Thus, for `BPF_ALU`, 'imm' is interpreted as an unsigned 32-bit
   value, whereas for `BPF_ALU64`, 'imm' is first sign extended to 64
   bits and the result interpreted as an unsigned 64-bit value.  There
   are no instructions for signed division or modulo."
