Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA16A2351
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 21:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBXU7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 15:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBXU7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 15:59:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB746BF70
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 12:59:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHiJjX003531;
        Fri, 24 Feb 2023 20:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=iZxIM/+jh+RNlnFW1em5B257ruPupUqOQ4nWWXz0dlk=;
 b=QXhQ12Om2j9LopSytYXY7sU+vy/ZX/+NJprm2PpMLu4bajzhw//VTJtHlUX3ChBVZ54c
 tYEht8y8Liqs0s3YMHZboy/KIkbMUUTumDL1E/Jm7+PClnR5LJ0tQM08EubniA+GKYYb
 H4YwRtERw4DWhNMVvD0GsPzbgdaLEz3+AREP8kg+GYhn4HkB9wRPfKfuiwyNefmqTLTL
 EQL5Naf2Gr64rXWTXukQdVlRCDpbYjMTdHxOd32PGT+ZInRnqBYP1+OUKa60cv7cCjR5
 6Ia2gK2gr2tySIz6pp6IgZkijd3gUGhKjIbOqPt4qYxmzRbrxY8lhjN2c9ErQlgFKhBE ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90x4nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:59:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OKFqke000635;
        Fri, 24 Feb 2023 20:59:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nxsb4tqp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm4AVadkqMjR7m4ktdkARbNV4H9/9PyJCJQbUugeKQsyHH2S3iKcDIlJy4lGBm8fhhv40k1sg38Jdv6CpZTHVm6PUCGQohcbZbHuEXK3NVeE0/qwqebWfn/oDS5pxBOu0POZ6g6w4cyUPxZWL2ERsTTmUsDkPC6k5dUoZ+P/J1uIw4MdauPt4V/lWgamLvr2lFzlYCCvURKOWp4bDAvP0oCuCtrRx+bXsCvtZr5MT7lh5ygkt8ji1ZSMZy8hlkg4cM62dZMBmkAIkVYC6b6AFbIW7bm8vhTPMuqvFeTsijaVGSog/LCoxxaA5TcroIiOMAAZycuTAy4Vu9xyMf9HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZxIM/+jh+RNlnFW1em5B257ruPupUqOQ4nWWXz0dlk=;
 b=hLPrMILPN5+WyjAGnzFoYHIts1nVZrshQgdaPbYlAmSrGgKJQVH/c3SnZJFmvZxG+rfuW4T9Jsmh7GFoqLqTRZAuDLJjCGN7Dm2/jSoZz38CoTWYcQwDOZhknoBziH1XJvywIK7tNZ7TIEy/6vG2fHO3DPfFO2L7O/HHX6a/33ycfWTZvb0kIu84F3IzIdiw3TUJNh/XQt3Z3QnOQsDpZ9bJhXpnvR9qkH9t6Z3qGywSpSiLu1Sxbrik/gyPdhVHlN1by7j3YPkq5vCoyBN0WZnjyUzbxjs4/LuaqMTORz3KXJbHoB7PeazUkCaqeEroUJKQMZlC+7lEuVfX0Quzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZxIM/+jh+RNlnFW1em5B257ruPupUqOQ4nWWXz0dlk=;
 b=lRcs6Y+1D2aF5s3doefkYbOMedcvmiwOYBdCl2vNzuxP7MZEUDK8dJzmgyA7qcKljHkVL0K8H5YHU72jLeP4xCW/14+GWt2YS5A8rxipXMInaTpbkI2ixOScGdNyxoBuWGgBlLI7ax75INnKyMa4AQoB9LuzCQDG3ga+XD7zoQM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SN4PR10MB5592.namprd10.prod.outlook.com (2603:10b6:806:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Fri, 24 Feb
 2023 20:59:30 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Fri, 24 Feb 2023
 20:59:30 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
In-Reply-To: <PH7PR21MB3878B8C1197ACE5318E332A8A3A89@PH7PR21MB3878.namprd21.prod.outlook.com>
        (Dave Thaler's message of "Fri, 24 Feb 2023 20:44:09 +0000")
References: <87y1om25l4.fsf@oracle.com>
        <PH7PR21MB3878B8C1197ACE5318E332A8A3A89@PH7PR21MB3878.namprd21.prod.outlook.com>
Date:   Fri, 24 Feb 2023 21:59:24 +0100
Message-ID: <87h6va230z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0299.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::23) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SN4PR10MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dec8016-7e57-4b34-8856-08db16aa05b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RX7RC3zmD9NzTYFGqa7gyR4K//kqEfr0WYdeQZ4auX9zS64oTOw7JFt/DEJFMXVLhGTpuW02uXsRpwcuoJecZbqpne7p44wMUwr3fyF1XOB0Gr05kLaQ71Xx3//HW4Pi/PjsD5KcIcveuESbGJkN7jL3ne7o+iXF/cOGLT0rAzUjH49lB1xY/xZfqSe7EKgw6fFu9lhhEAnSEE7hWOLXh1TQkL/eSH6XGFmrCyXuGzIwW2ZSeMG6TjnuNKfll8+EaoT3XdNF/RSE9FiBmF5wegtC36rvIbHkUwweya17FFNAFMhPPIbT/BEZ0zLppjmZ11wjg6sAqzmbfggK3uxr8RnfeMPJCMrKFmibg9cdiuB1mK7bfJze/izdXeMV9OrYDplBBK8Ieofg6Lk0yskLxod2y8NvRbJDnoFI+CtMv5RaM0VyF8qUh2/SiydMyecNf3xJUTtIUWNFH3/GDovydP9+HkR//4vRMHc63Bev9mZK+SDAKasDsc/AOx2sgiOwT8eHyl/PPKIhxvxBtFNYTP8gZhhSSQ1qMGB1Pbzd2gp4HzHxbld0M3hmPtelA8Cj6lb9IlP3Di/UGaPwINQWOhp3iZIOBiwTsqWBRuysv6nlQacdT50z/TChM0MYFqCSobka3TIhBE45AJVUUemVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(2616005)(54906003)(86362001)(8676002)(66556008)(83380400001)(41300700001)(66476007)(38100700002)(5660300002)(66946007)(2906002)(8936002)(186003)(53546011)(478600001)(6666004)(6512007)(316002)(6486002)(4326008)(36756003)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbkXkPDE02LfDzx6gBJsJttU4dodBvKT/cOdEkAo9RjZTKkRFfZwYUjpQB0J?=
 =?us-ascii?Q?rZSzZmSkqQFv/4pI3KVYX4grhCADgkc8kp1tF/988MhM2oivll3X++t9N+Rr?=
 =?us-ascii?Q?6cmU4zevOyRcWeNznQxBULFLE1IzOmIvMYR5At1ua4IxTNUU/tFGOjznu/xW?=
 =?us-ascii?Q?FtynD4/c79qxbITkrnq4FPGIlLwOaerJ9fAnt/M5hzoi7aVuDYLEWNNJo+D1?=
 =?us-ascii?Q?bxQmCil7X9tUDlhC+xWZZDZwzwpNzcP8PGe7R/97FhDZ+8bldE+QHsp9SKJS?=
 =?us-ascii?Q?q8XcMJiaqAxbB3G2/oBVr2Gg3jQwA2dXF6KLa7F6a+u1ZpPPxAMTwWhzF7WU?=
 =?us-ascii?Q?LM/mSc+jkeTdaxzPFZmcKt3S5CLO31eE6MRB4+uuzkTvNlvituk4DSi8FkdF?=
 =?us-ascii?Q?h34HDl9ba8oNHDTtzNwjPOCuz74ukR2Hxkr/UZsnZ5UE/dDBbRPDWUYHO1yb?=
 =?us-ascii?Q?of/gZAQAnlMDuFLpQntAO9vKSOhFLbknlKduH+FmDYw65D+OsDlihO8ULJIn?=
 =?us-ascii?Q?mHxyx46+kgsWaqZw6XBAq8XGX667PexC+SMJYdjPDKXnVYsZBir/8lWJPxV2?=
 =?us-ascii?Q?mH7zAyScoltCtZfVUohhSTVGSueluGPNgYqbrUEQTEt3dt1X9g/nWK1WXWb7?=
 =?us-ascii?Q?oiPWEChzP3BGt7maVZKlNKLF1PujIRH9DcK6iRO6ItSIp8V9aynjg7HVmXTg?=
 =?us-ascii?Q?05q3KPkNg2IH4NNSBihvVFgHplPONgKPxPqxKkko0VOwWJlwIBGgpQzZ0twZ?=
 =?us-ascii?Q?xBEfWMM/CaFgCSi9ZyUTP902pt+0L21RYpLhg4d4tE7NNiS55hMHHtgaynWd?=
 =?us-ascii?Q?bu7vX6dZe/S/6756Fig8ExNesc7+LI/fvYKv/csj+lBZNlQccXzS8drw4EWr?=
 =?us-ascii?Q?wS+wBZ9WmKruGWFYbBxZ3P9SXqjZQt6W657PcG7DhNazMKPsNG16WykTQXcd?=
 =?us-ascii?Q?j67ZtdRzZVGcFbRGRsXsqcwjpDncJXRXfSIz0xgFnET/lnNczdVejlFRiEKs?=
 =?us-ascii?Q?VROHJZf9gv1FgP1UYnkrWmErQ7bGq4Rno26H6pFNMG8x4Zjk0EkJRC580DwL?=
 =?us-ascii?Q?/JdH3kmzYIhPx3bB5jr8hQmP4T54EKf21ZPlkjADhlbCiAbWrYGMNFFyQjNa?=
 =?us-ascii?Q?CqVaZ0yiyn2ycX2Z6LHQvf82MO7pT/hgl6TWYEFT3JDvwOba5DsWrmycuHX1?=
 =?us-ascii?Q?+m5oWCuAan83iAc0Wo/z5qaSqi/ScvZvSNIH5wsgTkpV9bm4iK2j60NC/lXr?=
 =?us-ascii?Q?s1SQ0bhoL1gxG5iIiRyM2IqQ8VUidmhHJzqJFwBwkQiYa0X/ZmA5m4ddPcAo?=
 =?us-ascii?Q?Pg0672SbF3MgQxTVKZF9+Y5GnIdFIxiIG9oA+C4QrVICQtwVxBQVI7TbIKKZ?=
 =?us-ascii?Q?JGrUfZn0yQMKmTkQ1K24lWO5Ic+4ETH6JjRxD9C4py4Jm5bKjwEY0aOzTuwi?=
 =?us-ascii?Q?dRwtlIv5beSs+B1YgQ7gnxTTatQik0A2Z6PkJbhi34GLzz03Gg+AKRnH1NGk?=
 =?us-ascii?Q?FeVN02nLolwZQYFA4EGxYdj64czDeyb6V/0u6g5AT4PNThcmGdDzJO4DhQB8?=
 =?us-ascii?Q?RUla1EEHajXdWwDkwqxAmxRcUNBMncqjz4b/soDoVgsfgDIltyH5ltPAlxC6?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vfhV0qwsnkMRyiXfvZU0wSg5BF1FzFAD3z3VKeW8yyXtwm/ucHBMj5Nlo9J8ROQnDgGaSiR4qR+4v9xiequseZCF0erpBf7wfVLXHwmPaESldhUGe9HKYKaBNDXwZr6ms+vNxcElVsaMluWSpC3AcDd/wcl8qKqtHilPyJrJZUI0w7t5g3lMJ4iq4UnQUNGoUJQTaUWR4ZA/1ypreNWIE1HR8Xx49i/6Qn1rRCY/SuFnoGVBMpunD1qKhbrDi0Ger5BwPgGWIJDh4j37urFGah12KMbf9lmA22xAKvcSvaNDH26MlFNvW5LObHX9eRfWJJzuE3t0mC0selNVseMesxKy2z2IRb1fsK/YHPcqKVx2JDdO5IwlgXW9fMFhOxNhGHVlGS7seBsfyaA8fIgUZ2/s33mMSC+LMPzeCAHCl72qmWdqZ1XthSimw0mf9nXgk2q+a+aF89il2fuLxAwNmgJziHfG5OZW4CASQtKJ51pds2SRH9fJvLj3Kzlzv0fUCqZ1tdsDD9acRH23uToNexIn9VeAG2yLRqBLpcJ3d5YdMph2J0yvRaKru7dsFI4bZPHx8z8oeRMekUJFTbK4NPKJhWrWqChUZr36WFJdwJIGoIHXPtZjscD2f1kPD1mqEBNQByTjjyPuWGDr09hfFQVHZbXJpbyeFOW445kTGgKT+3zGAaj3wlq2kfNghE4EAATEUbUxjJEX3imGjOjBJqxBm747xo7jJpX5Cl/HZ39/7vC9pBozNUT5Ekkv6VRBPa5DO5HCCHOaNKnJBk4EOp76IMZTHQSZQmGFa1fal/lm/geJqEwYXIh3hY5RQ3PuYwc1B9lMhWQ2X3obyzBDq+Q8VMIUd+xzGOD5a2jzK98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dec8016-7e57-4b34-8856-08db16aa05b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 20:59:30.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xYSWjheO//WCC9Hz8oj5H6gMECCnQv8KE32F0mZ2FLE4gxOkxBYmrJYFFouABmUIHEecuswKFXlTTYf24njF4+ur+332YIdQn+byutghco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240167
X-Proofpoint-ORIG-GUID: CPGpZgKhihrkhn6mDnfMBevcxWbc0zwD
X-Proofpoint-GUID: CPGpZgKhihrkhn6mDnfMBevcxWbc0zwD
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
>> Sent: Friday, February 24, 2023 12:04 PM
>> To: bpf <bpf@vger.kernel.org>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org
>> Subject: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
>> stored bytes
>> 
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
>>  Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
>>  1 file changed, 21 insertions(+), 22 deletions(-)
>> 
>> diff --git a/Documentation/bpf/instruction-set.rst
>> b/Documentation/bpf/instruction-set.rst
>> index 01802ed9b29b..9b28c0e15bb6 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
>>  * the wide instruction encoding, which appends a second 64-bit immediate
>> (i.e.,
>>    constant) value after the basic instruction for a total of 128 bits.
>> 
>> -The basic instruction encoding looks as follows for a little-endian processor,
>> -where MSB and LSB mean the most significant bits and least significant bits,
>> -respectively:
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order:
>> 
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   src_reg  dst_reg  opcode
>> -=============  =======  =======  =======  ============
>> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
>> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>
> Personally I find this notation harder to understand in general.
> For example, it encodes (without explanation) the C language
> assumption that "//" is a comment, ":" indicates a bit width,
> and the fields are in order from most significate byte to least
> significant byte.  The text before this change has no such
> unexplained assumptions. 

The fields are not ordered from "most significative byte" to "least
significative byte".  The fields are ordered as they are stored.  Thats
the whole point of the patch.

As for //, :N and | below, I think these signs are obvious enough to not
require further explanation, but I wouldn't mind to use some other
better notation, if you can suggest one. I am not a very graphical
person myself.

>
> [...]
>> -Multi-byte fields ('imm' and 'offset') are similarly stored in -the byte order of
>> the processor.
>> +  opcode         offset imm          assembly
>> +         src dst
>> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
>> +         dst src
>> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>
> Similar assumption without explanation of "//" meaning comment, and
> some implied tabular formatting without being an actual table?

It is intended to be a diagram, not a table.  I used indentation which
AFAIK is the rst way to denote multi-line verbatim environments... is
that wrong for ascii-art diagrams?

> [...]
>> -=================  ==================
>> -64 bits (MSB)      64 bits (LSB)
>> -=================  ==================
>> -basic instruction  pseudo instruction
>> -=================  ==================
>> +This is depicted in the following figure:
>> +
>> +  basic_instruction                 pseudo_instruction
>> +  code:8 regs:16 offset:16 imm:32 | unused:32 imm:32
>
> And here the use of "|" above I find confusing.
>
> What do others think?
>
> Dave
