Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA101678079
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjAWPue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 10:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjAWPud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 10:50:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7018B3B
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 07:50:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEhsVR030967;
        Mon, 23 Jan 2023 15:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9KzbWunrQwjjNhN8VPEhubu6OhamKcBqf8APlRbfLjQ=;
 b=DjgTVFbEhkvhsCXLhx+r6nGSHE9AWZIhmhnNJKt2gmRH6R0PLdaxSvtwCgeY1YosIL1S
 d81RfhQu0cHdOZp9fmWo1OhDkDPdeP6QSiBakyyFhuwjVdWSjB4TWSiN/7fgcP3lYUSc
 gFWR0Nif1ZL1yFQyYwtThna6EDEQUGnQW7XF4zFkLfoFmHSM9BriwF77GIRb7YIEs/vC
 PGNVblT/I2nuiULXSGPuQXSl+oq6YRmc+7R31KoXWpYm5hnoY5zCeItnD68xuDY6+Ajn
 mgda/nV/7wd6A20FmbfM1gQ4NDHokd2JF0R2DjrhjjCOEa3ZWH+2af36JtGwQs+byDYW eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktu0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 15:50:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NFaPaU014107;
        Mon, 23 Jan 2023 15:50:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g9y63g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 15:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPm3DoykDSsm01RMo5HE1mBvkusd+nvWSV25sP8CWxtBE9FJLC3yW0RVEiwMAkwZlecTko0jNT8VHC03iaGX/D6o9I4Ik3LPsIk2OH/gLHrZBBMLaWGELYIYK6esG4wITN/X1Blboi/3h2AYboyDUrLhI+IOgzjt+o/bOcP4JquCtlcVs6cf2yqOg38tb1dsRP2QI3/s1v99qhiyWc/13X++zZZ5XOJcYNs7soc24035c/pwBXvmkYmycKiNYFRCJIXSID4jbZiTdd09bpSSZ9qVNs09TFE5O/gT2biE1eDiIuuWx+y/Oy/CETGTYbeOF1oFHgkuoynJ6tJPgtfZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KzbWunrQwjjNhN8VPEhubu6OhamKcBqf8APlRbfLjQ=;
 b=kDRNBidADPLeZ/TsSfMJNAH9QN9xUtdP7bwl5v69puw7KIZRJz1mvfVXp8grodThNcKuS+rtRa2VE2jitTKhTYruGiqcSH7zmDGcXVv/FhBk1sB5oY428mQGRtXl6u+aBXirjh6FcNIpF7QvuHGNIMovKdKK7xzfeHCwxwgA+uqud4lvhX1TdDJMRF9tMXLWzOuiLYro7eq2brlf6L39ANChrIvdR4mpAMdTeOrjn36qVdjRIFqp7GtjCrqemR+jvxERHQCvNJuuMSUhdREwqljYML+QEbFfZ2d7FxZXSZP9N4xg0RdUwLYJLhf5XDO9183C6KJ4tojKa/aX29uuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KzbWunrQwjjNhN8VPEhubu6OhamKcBqf8APlRbfLjQ=;
 b=cFiMYfRABIHeW/QUktU446aTqN1QYhJ4KDb1mzL3muBzjlNO0RZ4TuGWELNFV5zHha/tsV0zjZ9bpMfyyNuPRofWrRKz/P69Srm3aG0NuUQ78wNJKZ8t40rGUEGOKcokTay/NfDBM8WT3ummvnnA5mweN3Fc4+i92E5q3Q/Crv0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH7PR10MB6107.namprd10.prod.outlook.com (2603:10b6:510:1f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Mon, 23 Jan
 2023 15:50:17 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6043.014; Mon, 23 Jan 2023
 15:50:17 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, david.faust@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
In-Reply-To: <f3963ae2-2a9c-b8b4-2b19-ebbcc7863b8d@meta.com> (Yonghong Song's
        message of "Sun, 22 Jan 2023 09:53:51 -0800")
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
        <f3963ae2-2a9c-b8b4-2b19-ebbcc7863b8d@meta.com>
Date:   Mon, 23 Jan 2023 16:50:11 +0100
Message-ID: <873581i72k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH7PR10MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cb25aa-04a4-47c5-c846-08dafd59861b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeebgeBwERYPe/7/faBiQ31hGNF5h+I7jIIoTskbiwLrjZt4LEPV4GjmIRrSCSRdhrKGAMyy14D3h+4wmbGNUb/bZUIgoob/6RYvWNQqXDRXLvGwpi66mulWd+hVmImfgGrwNQs7gviCs9mll8bohjTRx95BOGfFwjHLBNFundL5wjSsEIKmIZCn1apD1zHSIPjvXZWEThpYLqT+jqoZoxQh7ggI120g8yhThsfiyBZvtYsTo6q7v4MVuqS5i2vOIWp90NUZjxLyoV1ohf5r1jXvVzXBCkyTy3KD/IcwG1BjwAnNH9bS1GsPCC/qWrDWV5Uydat0JCDVXTw4RDfuN5IBO8TC1NxapENQJmFVKWuvlSmELSrT45h5fgFM6qCIUI9ekxkqT2XOyAGU0BmrsyC02ZMq7cmZ9EjpC9kkwJuyQBR58dCQDA5xJZomsfENziDDGZh99yVt43LaVuirhinrUVf6Pw5HILytL8rzsA+lNRJ8rIObXxwbZCBL+fsGiq5dkAchNls1Vxlsh38pt6PZXWinXnVy9YzL36mSQFa5FhaIbgkOzUSfUMq3iwm/BffKxI9G8wehIMVMGlIXVoIqhS5DKYahyH8XNvaIaP9H96eq2/+A76GfvxVmdNIFENo8Nb0c5MkEkUxXblFB+YE2d/wUVO08JMA+GeU4DT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(6486002)(186003)(26005)(2906002)(6512007)(54906003)(2616005)(316002)(478600001)(966005)(6666004)(38100700002)(36756003)(107886003)(53546011)(6506007)(86362001)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(66556008)(6916009)(66476007)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4UbXIztdv+MrDtNCpx58kn9ttk5z8pwscjPlaJrH6UOPH1lBb2ewtMTEuZV?=
 =?us-ascii?Q?UaIjGtCz6sXnbl67TUzx1exHpakwwjZwFcZSzQRpKHzxsKA2au7Zye0npUn4?=
 =?us-ascii?Q?DpPJKxDNdzdzz5GIY7Yq6SsJuWIWfxT6USpqaf8033UrRhSl2yRb1VeSQs8Q?=
 =?us-ascii?Q?gcE1zEhP8lX5YDQ3UfA2adGxBzlZS/O1SwColZ168LPJJ0ysk5JuqBo5lWbx?=
 =?us-ascii?Q?HUjXq4s0eXDuhFpc9BsMpgffdbnluzZ+6uewfoOHE6pIBLCqa2QQECS7yAVg?=
 =?us-ascii?Q?UGO7KjLT4ylQNAZLbyXC3aF5pOFyN4LyiXyYmMC0TsMTi61CBzUh43aPHBIN?=
 =?us-ascii?Q?mo7oxnk/qx77NtK+ScCrmoRf5aGoqbhwrD9CbLM3uDLZ+dJM2uGHvlzPFi7/?=
 =?us-ascii?Q?npHh+kwxNYt/jo/hFyMLjuaFsBmxpbo8NO1DOvG7at1ySTBHuqW1kg79jyuw?=
 =?us-ascii?Q?vSnYSLXyxHAFjKz5kVQF4Zz9H7sPk+rjKUF2PRt+chpCibD2eu6dzEkKIHf4?=
 =?us-ascii?Q?JDPgz+0xoHY+z86dv31g573iDltc8KRWO1mCpk6BIj3Y5Um3nCWQUruhnmrE?=
 =?us-ascii?Q?iUi6ZVPPUuMznaA0pSytc2rX2p7wi+UabvQ3KfRXpBH3X/LHZc6xfYLvXdf/?=
 =?us-ascii?Q?nfBJOFRVANrIT2jv7xPFNA6QswRQZ1TEBFbIefbGIMlQ0OGZ9+vtT9c9gGsW?=
 =?us-ascii?Q?u4zQVMl47AHnfNhlJ24u4JU0dyiabGXyUczXVWrDdNpV+DrSz67+TSznfrfB?=
 =?us-ascii?Q?w80pxApZtNUwTv+WLnn7oR/3g38bOjY3BYieny74MYWfYgAMts7PQVNdDkam?=
 =?us-ascii?Q?61qHZbUAXyb6TvQpHxPawa8g677lFVKa2kxWrxMhPwr+Tjv8vGDCaTFRSLP/?=
 =?us-ascii?Q?877DDvtH/PorLArjf2lBCHOihcPi8Bkk2PSkGyedt29lLkwdkNoDlLc9+Acn?=
 =?us-ascii?Q?SsDeFIXFJ7Lj3HzCfskEvhw2fibu5KkdH/NPMPVtEmCF4Iv+D7lyTvWywXo5?=
 =?us-ascii?Q?kqYDushfX9LSxiEcuaIG+Xu8C9rtx/zqooTECTKGUqVqKno3fFafNsA3En3F?=
 =?us-ascii?Q?kr+4CXM3laWrVL8YSfJGikMWHR0bKe6+1NUQPwGiX4bEHrL3D8WBaA67Dk3H?=
 =?us-ascii?Q?fhIP3ZmNYkPQu+zJlL6TdEphbIa/vQG869YgosX9T2599W/zSxaDLGksGYSQ?=
 =?us-ascii?Q?CrOJ/1ZDgBBHdCtazO+yirsTZ+5ZX3L2+uxVWM6SoElTRDrZMpuoyJoHNaxG?=
 =?us-ascii?Q?ItHAzPMfhku/Gw9ptrkKiib6Eu1MWaSsCLxqdlFfbRDoehFltUx52zP0wwQO?=
 =?us-ascii?Q?MBsAqLqi/OMTtE7cejLZvgSstMyF0/j34Y8XOU5PR8mel5AjKWwaOTxreog7?=
 =?us-ascii?Q?iB3QdcxRgtF//HCeahXSTDy/2c0znB6iE3HhSp53y0mJhiAljIYVxCaN5Rts?=
 =?us-ascii?Q?GU3DnQF0xTupV/Ujrmzyzyww9XMs0+sknF4knKUczNhl7kdSGD94TjL4CSIQ?=
 =?us-ascii?Q?MEKCB2oQMipltO7JbvCEU4aP9BV3aVwAR34gQSREgJFOGFmqqI+Cw3qeifNP?=
 =?us-ascii?Q?AclXJJ8sFIsULSkXrdz4o8Juw4Ghld+EV/fZvNygEys00Y63j4XieIhDa2a4?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zrDZea0LX0w2CM/vyKCpqlqIRFEcBP/JS5Xkt5f3H3BnjpdDkKWM86FEiufnYnEbeHIaxLYEzAwrd/nRVYHlpPhyLScxXuFnfPaehZwzQvcnobktDkR9cIrOLVhLw1ZTp0Q3YBDc5HCNNh0fPvlOVeJWfQ1zZ+wIGMv91YNo9XgUrq1cSPoN2wCAHUEX8/q9Y0pqUYuwztCRmchfagr/4zVsJ9dJfHznkOh6u1EC8r1HcXz/1ygp2E2yc2pxID+RohRM4DqZ3XU/608pZNyT1ww3igzo4gTxQ6Vh3F6H4N4oW4yWFEb1BWLmUWATHNc3EfOh5Ua+gkohIQxNCxqR8l1+SP1zC20YPozOQyyO2WBCzPoUlBAfUpIBOuz/I3RFxa3hfXLlliEUlrWSlgnql536Y3kapnPLRFSn5Ff1rNv4dZ6sylkLJOOXl32aHWF4SFJg/ATuCXQCUBgoHKhLwu2btKEidtZx/Qb2X9XNy8cnfai+Mn+vxCEVZzICSJ5xs2hnp0QPqDaLArz/zL1QvrNBfWYc6GN5F7qmVVulWncgOTqkLXjrU+bfKSLY4TUCOyZkdWIVwonQ+isf9DuMUtz946PeyUBzVINFpBW6X3wtV+YJF76POgj3Y3h4gFKuGu6+xhaG5SYYVAhKEHDAQertsjyZnGAPG5b7u580Bt1FPD9OYD2KQpYKf3PqZT0o9mJrFfpqTd1CJW3QHod5i41uMSy87zu5xQYdU7JFJEARAS6pEhiA/BtOeCeeDCG9KN37DCcGFqHrXah+yZlmFWB6hEciLIJ6BFxLvD5KB/BgmmhpNS3nDfnetldlr6Ohechws7Hu6WNF0E/xatyEEv08fp/EtUEZj6VyVolojnRqDp5uffhkF4fxMeYaC5X+vRaLnhN4NqXBjUu94H+RUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cb25aa-04a4-47c5-c846-08dafd59861b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 15:50:17.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCnoOAty9iD1oFWXupyNOfoJlYbHPPHctF7YcY2XLn03aPiS2ZJWST91ABH3aQc0cYUaDe4jZccCmGXn0fSynqBIiMD76LUuhtymzbRb5EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_11,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=877 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230151
X-Proofpoint-GUID: YRkZIaTvOctn9ERAa-u9pn0teaTOyGQb
X-Proofpoint-ORIG-GUID: YRkZIaTvOctn9ERAa-u9pn0teaTOyGQb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 1/5/23 10:30 AM, Jose E. Marchesi wrote:
>> We agreed in the meeting to implement Solution 2 below in both GCC
>> and
>> clang.
>> The DW_TAG_LLVM_annotation DIE number will be changed in order to
>> make
>> it possible for pahole to handle the current tags.  The number of the
>> new tag will be shared by both GCC and clang.
>
> w.r.t c2x attribute syntax discussion in 01/19 office hour discussion.
>
> I have checked clang c2x syntax w.r.t.
> btf_type_tag and btf_decl_tag. They are both supported
> with clang 15 and 16.
>
> See:
> https://clang.llvm.org/docs/AttributeReference.html
>
> The c2x btf_decl_tag attr syntax is [[clang::btf_decl_tag("")]].
> The c2x btf_type_tag attr syntax is [[clang::btf_type_tag("")]].
>
> $ cat t.c
> int [[clang::btf_type_tag("aa")]] * [[clang::btf_type_tag("bb")]] *f;
> [[clang::btf_decl_tag("cc")]] int foo() { return 5; }
> int bar() { return foo(); }
> $ clang -std=c2x -g -O2 -c t.c
> $ llvm-dwarfdump t.o | grep btf | grep tag
>                   DW_AT_name    ("btf_type_tag")
>                   DW_AT_name    ("btf_type_tag")
>                   DW_AT_name    ("btf_decl_tag")
>
> I double checked and the c2x syntax above generates the *same*
> type IR and dwarf compared to __attribute__ style attributes.
>
> [...]

Thanks for checking.

That matches our impression that C2X type attributes actually order the same
way than sparse type annotations, at least in the cases we are
interested on.
