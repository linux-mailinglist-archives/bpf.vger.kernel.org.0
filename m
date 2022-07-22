Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189C57E0C4
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGVL0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGVL0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 07:26:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BD2610A
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 04:25:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MB99At006322;
        Fri, 22 Jul 2022 11:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=aJXlkw7F8p+KaIr7latwMKTxkYwCqG3x6EH5aQbrVOY=;
 b=kHqsVoV5m8NCHzWdHCIrW+TCxJwp8fMn54uYK0cpBdIvctjuTn9SpaVIga8RXFPu2tJ6
 /y3rRbesxqO1ss5WpjOGfHkp0cTkXmaPi/+GvUAgEfVNwyRPixUpKCGo2Q/ML5aFHc12
 7wrwgLTaHiDNOafoOURVFeYEkTjAkxhVGDRAbmTfDTjENZz4XleQ9WPEiKBaLd6lBFvT
 3+PTg7uO9XYF6de72KVMa3z6cs5pg9NqZTG9qzF27Aw+YvPSyr6f3iaoll68N+1mXePe
 Xr7JHIpWX/7iWa4KhtDkQBCfrxZNELOYOXOYoRLJVcNnu8YpkZWWTlKfPBeee472HVt4 CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42q6y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 11:25:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M90M2Q007819;
        Fri, 22 Jul 2022 11:25:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k6ddvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 11:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkPRDeCa4AYcUUVU8MFsCnXJqz5O1YvhItEZIjLNYgb7/xfDn+YzzcmsF2F3wzhmoySlJXF4wjSbr1bqG4MWYB3mCWlARMbYOPQWTZUS8UJgx4pwpl+NtwO60UTP0yWunjD7XCWFUI7ZsNUagYnFEhLRU4ztZsEQNvHM7Nb+cbyDecyl81wsKql4886pfoUoXK8yRluZsQeEsK1sXallIP3e/g96p4NxL1Pla9P1iMX0uLolav4yEyJ0VSfUh7aE8MoW/yFZ6y4l+rtHwun+fP9i0CA1qlKdialfEd4lg6dcyng2Z7ECYsuLPtJPqO289kX3GqXtIrNsxZ+Bm85wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJXlkw7F8p+KaIr7latwMKTxkYwCqG3x6EH5aQbrVOY=;
 b=O27fbANqzNLxDNT+AaeAg8OMRGpvnkRS7AJ4QgPEn79kBhvLWsFH/JvQAIJ1cFAgsDndUcyfS855gyI7c4MI5dXnVd7w/WGLYEZ2MKgP/fiR+ElhAh1DJKkgPvpLSzKpEWHw6bgPkxDfGWC7jOT8TktNC+n2PDGDlvq1q7v6f8zGchO5PCn5o6sSxBEW3EjB3Lnlc3ST0gUALFgs62bcz6arRJSK4o6kE0iWHLyjIjZwoFaKf0e1BR2XkVk3Der+pKzsal8/VnTO3uUH7SzNn+ou18Dx3tiDuCdn09C3tWER8XQAjD2aQAw5hXP7PtojomtSKA6iOk6Rnm6q51Yk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJXlkw7F8p+KaIr7latwMKTxkYwCqG3x6EH5aQbrVOY=;
 b=luA8DS1pIWe89clPe/pMxQVlLAQlyvI2vqP+fTujRVzgYCuzi8FHnKS8T4WehxytmzhDy+SWlEmmM6aaU2NEhyJ4kk5go7xnT/U9WvIVQNclI8jLVoo/JxRbaf9Me/IoN7jHQmwn+JK6ovpuOndNHsfZcuXxYjZVrHlk9UeEUB4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by MN2PR10MB3423.namprd10.prod.outlook.com (2603:10b6:208:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 11:25:46 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5438.024; Fri, 22 Jul 2022
 11:25:46 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org,
        david.faust@oracle.com
Subject: Re: Signedness of char in BTF
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
        <87wnc6bjny.fsf@oracle.com>
        <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
        <875yjqayyz.fsf@oracle.com>
        <d56865b1-30dd-8761-2c12-ae5f66778de1@fb.com>
Date:   Fri, 22 Jul 2022 13:25:33 +0200
In-Reply-To: <d56865b1-30dd-8761-2c12-ae5f66778de1@fb.com> (Yonghong Song's
        message of "Thu, 21 Jul 2022 15:52:40 -0700")
Message-ID: <8735et8k42.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0399.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8213d7e-6442-4067-cc03-08da6bd4ec06
X-MS-TrafficTypeDiagnostic: MN2PR10MB3423:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7YFPqwOcDZoLLcNFuHyeL5IsO7gr6Tir12bIBvxfkHnQV+Wmg+TVIDKdLyAHvcoxkOaNzM/RG9ETJb8MTnjew0n5M1/FW2HrYB7zXah+hqSEOGA/CAPGVu37aXsXiO/2cOrIQfH1pBT09fToxD6wL8u9DQt3U3Z4z38YSj/0RJtnYQubPEqwJultOpS/AIcotsajQ65JInJWAxAcTH3zowtUEKhGmy3pSg+QTDpD6zcYSdBfgkynfkmrCWFevGbS/jcHcs35qU9CDECA5AZXAYY9u2eF2gSfpidzPjnuD/XKuoUNrbLJFlZ+sqPRXBj1NNyc0GZRy8wrcAyRKRWb379aDZQx54UwpKw9XnjwGf1oknwDAZi4Ied1Z/QEroXHcE24BTRvycp8bVyhvH/XC2GXdPd8JgMEevZwgjy9sn2wkpsqBJHWTHNTPudXaHW/JKDvZVxe12ggklQPpVEHv7tfpSd1l4OmHnzdh2mgv8swTcIPYRoycSfAhVJcYOnZLVhAUx2RVy44mShAcgsgNgCue5wd8Ocs7Ia4G3SEr07rxxaI7LA52RlrtrIt3PXqfM0hDih6UThO3b6qcnhGQ3iUpGl6rnrUfmTHU8X0RzNLZB2K7TBOw/trx5KG7GB7Kzv6j5ZvpioC87Ptl8YjqzoUquqesA9a1dZSfJ9Ixqq+M83ptHMB9xPMdc2WFmqLpViKjI46Kzpd39gc+uCuf8bN9E5OwKVKSFFCcflDStt752vN8XHnD17S6ld+g9uTaRHX8kDmHHF4Ioh/cfFYoyHdlgpj9e5L3TzDZqdGVJTRag/DX5xgg6vYRjdaxWf+M0mF65/nzhyh+QYPNd5go+2RNDoYqzXymvJwCO0v2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(38100700002)(5660300002)(4744005)(66476007)(8936002)(66556008)(66946007)(8676002)(4326008)(2906002)(38350700002)(36756003)(86362001)(478600001)(6486002)(316002)(107886003)(186003)(26005)(966005)(6506007)(6666004)(2616005)(52116002)(41300700001)(6916009)(6512007)(533714002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jg9EEN6fX85DszeLtvsCZuA8RStGAmzskl+pHJhvCqUtizshjK9Ut8Q/8zlh?=
 =?us-ascii?Q?8gPp3tUZ4tafxrmTnFHtIAXi8r0tQUw7Z05x3XUHcoGo2KAFF675LeRHyIXU?=
 =?us-ascii?Q?IJ3NBCf8C0doQSulqbdnEoxymcTgZsk42HYz8crNic6IPh8WICawIENdwBR4?=
 =?us-ascii?Q?YrpCtsB27SqfenE3UE7l8JQU712S85jgsEvcAX44auLTjEk85S8PxdD4TaWX?=
 =?us-ascii?Q?pvpQb3ABi16flapV6W+GrP070yVUzS1KneHVfZa7+JWbJJaJEXH5MwzTPA4y?=
 =?us-ascii?Q?zx9s6qD5BOXwvEtDUiWBG/7M+h3AHvaPtVrhqVc5wleZIhkcjB74CzogjdHE?=
 =?us-ascii?Q?ISQZh5hvwaTFahRiI+aP9HIQo/tJQLuOIswtc3Ngv2jMX8dWaaRddyNW1LQp?=
 =?us-ascii?Q?OjkJmH0klhLjcFO5R7zGlaR+xYTgfmcgcG2UE7oTFHsH9e/bWmeOgEpEE+TI?=
 =?us-ascii?Q?MS/yyK/60reW6zMJcfPALeosA11yHo8v09PuPoH9cPoUxC/MbORlAsXK9v86?=
 =?us-ascii?Q?TEXssWjOQuUM8XuvJjuY2vKCvEvdJJSLLJ+nCDUnGEGhZ5HxiMqK/ivzrPpU?=
 =?us-ascii?Q?+mGU/+qvaV4Ch5lfqYgZ+vgDtt09uZGAj9C2yQfpnksem8jXX/HpI79xrup2?=
 =?us-ascii?Q?+7mOSStj6sYmnVEC06rWOmgl4VIJ3/+waZZqOLXvy7GOSsKkqAF9tKkAGDSe?=
 =?us-ascii?Q?Zper8OC01J4CV6UdorqdMShKx1RXcJEzFOmWD0PdF2LnTmC9xqcX5b4eylcL?=
 =?us-ascii?Q?Epykdw2sDPNXNm/u+KV2YWGBvMYrAPXZ/lvGoDsFGfd4WnaT+vZ+gHU9YciM?=
 =?us-ascii?Q?e+Gw6oy+5hmXmoHxNNaevhH24Ovs/JD8F7ScAheCe7OoOhIiQqfq7RESSOC3?=
 =?us-ascii?Q?FPoj4EO2rOJd2pUHEEvcIkDBqw36YCA6WwxzUgIBAz8g1PV1+LULccsNSWLg?=
 =?us-ascii?Q?Z9XlgVTRXNbSVm6VMTJsyji88uKPuBQdSNN5M4vxa0eN5rXkt1gi8GOoRkdl?=
 =?us-ascii?Q?Ht0o6BWEwGm3oiX5LtztTZnKbj2tLgO38jDGk9I8WOxqojsw1z2uRVeNo5DM?=
 =?us-ascii?Q?QN1Z4xmLgTHmO5PoSYhqb/tb+53VPXhJRarpvce3z8WWifPhh26zdsKxfzIH?=
 =?us-ascii?Q?yt7be3echknwSzDi2/IkKleHAirBFsZl9yyYUzCSToDMmLyBAOUOlzIhIIbl?=
 =?us-ascii?Q?SzHyqYAT60z5Ll6iMwRxekQWOam9HyGLFsuOZqd5c4jBkpqs++gBmizIQGwx?=
 =?us-ascii?Q?vnWXfr0/oCqx1SkUZ76l2KmP6RxLhZPdA8dYTM5HqfSBImp16UMutINVDNWY?=
 =?us-ascii?Q?iZLEneRTxHdjkW3yzplPz+PEWDwPBYEo/xSn/5qngySPiGqu/FpOnGxZhAWp?=
 =?us-ascii?Q?oQ0Y5DXSN3FBEBzxPN3+e79FHHICp+PlTtpq8tXbxmO468HIov8JZzV+7zht?=
 =?us-ascii?Q?mVV5ogiBB47qgCMMq00/IHx5tPFSjGweI7v+c/QNdFBvRUwXJsxTi39PW4rv?=
 =?us-ascii?Q?e5edFcWB5+PQD31qkAI0eoPgdNdzDyTGRRPDRD1fzej+RJou+8r+NWLb4MXp?=
 =?us-ascii?Q?Pi2lrJTHCgKsTzRIEJtQ+FY5Hem0pHl9W+/F61l8P9NDVrbW0Y3LNoXcWvr7?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8213d7e-6442-4067-cc03-08da6bd4ec06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 11:25:46.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8Xzpevzl3n2D0hHIRt9RfpxXYil8XXqHwP6AhLjsaVL0k+hWyk1LIrj4pyentuj401uYyPjWYj0ssONzwb1fWNNDu1CUFByfyByAwY/2Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220048
X-Proofpoint-ORIG-GUID: qSsxYKo7pHoDddE4uJyJTPhXbtgaEORP
X-Proofpoint-GUID: qSsxYKo7pHoDddE4uJyJTPhXbtgaEORP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> The llvm and pahole generate BTF_INT_BOOL when the dwarf type has
> attribute DW_ATE_boolean.
> But BTF_INT_BOOL is actually used in libbpf to differentiate
> configuration values (CONFIG_* = 'y' vs. CONFIG_* = <value>)
>
> In llvm,
>   uint8_t BTFEncoding;
>   switch (Encoding) {
>   case dwarf::DW_ATE_boolean:
>     BTFEncoding = BTF::INT_BOOL;
>     break;
>   case dwarf::DW_ATE_signed:
>   case dwarf::DW_ATE_signed_char:
>     BTFEncoding = BTF::INT_SIGNED;
>     break;
>   case dwarf::DW_ATE_unsigned:
>   case dwarf::DW_ATE_unsigned_char:
>     BTFEncoding = 0;
>     break;
>   default:
>     llvm_unreachable("Unknown BTFTypeInt Encoding");
>   }

I just sent a patch to make GCC behave the same way:
https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598702.html
