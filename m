Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100056A5626
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 10:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjB1Jwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1Jwo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 04:52:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F526872
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 01:52:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6B4mN025751;
        Tue, 28 Feb 2023 09:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uMuvb8+T8zY4RVAOXngocuDPJ5eHL0LW3IK8HItiJfg=;
 b=lCgEydhjXk28aY0vm2/CZ+W1fQgUxVOQakP50P/Hhd+wUwB7rW98nuXNA1Ss+F+nCPgS
 QsfOCgV/SlNv6+u+QuC0lSLSJxlaVhFtQKiSS6HsDIqrBhIRsCcrJAIWFkNHAXIvT6e4
 weiDPkW0q3SoX9p/nv1ZXwiiPYMUxCLPvin198TnXlm5/MuDqCCpKu4VaTrkbdGYLB4s
 /UGH4CVYdObd5jZ3KLFhXvx+Wo1ed+naoyZ59FEiF9dTB+f65wkaXYEaxU/aCgJbN021
 cOVtckbLmPVcwBMWf1VtXZR+8tm+PmQs4l1P0STEf+yzf5FQFhtyztBOcrH7CNubEEqj QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wnsqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:52:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31S8ckth033086;
        Tue, 28 Feb 2023 09:52:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6j42q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYzO2hRebPr3sp2pRNR1NOuvuFdvH1inN467uYmufKzdpYPXnU1jZ90bTZlDIDbOo6CKJweZbIMkrHNS+o9X0I79YRvmcAQNQ0F+B4GOKZeuBI487Euy1etQDMimRymLcdCGVr8xUeglf2r7sHJGsQ5vXs70ZE8LU9Cnni2HUGbWZK1xQoKJFuVyWaRWIIM4n/K1UWpb+wc3yPNGCxUVYshvPc/Vky4oh91lhxcO+CCPg7VqdL5MVXc3wYqKPQcmiz75WK+60W0XcEZYYVAe/4uuyKCzlRn+r7NRqG9pbZRxUUOyombp6mlL20nNQM5BpYU6YQj2h+03iLy9NIvRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMuvb8+T8zY4RVAOXngocuDPJ5eHL0LW3IK8HItiJfg=;
 b=i9pJjAxVjhvAVYeVA1yjt6qhLb2jlwtV7K3Mn/gIMjUabC5LshUTz5vVHIkCfn+m+OiUlmt0V/YT4Q3ImjuLHA13lUaYUkvyA9D+exi+FDsfnLuDR1Cpx7TOuUxSY8BwAGR5qs8LH91O2CQ0MiN8x881Xa8RHY/Jp93Nn1uBiy8qbt4O5syns+1P1tY8+IWqYyzFdEHJ/2Zvx+sILumO73LSPWo57ffZzzhIjGm225Zv1/U1OG3ouTL91yuPba9JmCpdc0m3RGZituZcZXnwAmhW0AsEfMHMwWXjZBTupAyCYHh4SnnS828aazc6aSqS1ZBfu7pah09Xwy8anPfJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMuvb8+T8zY4RVAOXngocuDPJ5eHL0LW3IK8HItiJfg=;
 b=K6g53LRrMpKDlRDLKYUwROY7RaAzcjiQ/hPxluxh2Vg3OXvVb3oRgmQ4p6iGYb97voh2y2ndFGcvMTJrGT8jDycyyOPT18yZwbjk5osC9VnVHsM3U/RxGnVGn6sYgzAOo59JCcOpO2Js7uM3kCUoIB50W+8+SFU0UmibJxSkN7o=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 09:52:35 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Tue, 28 Feb 2023
 09:52:35 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH V4] bpf, docs: Document BPF insn encoding in term of
 stored bytes
In-Reply-To: <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com> (Yonghong Song's
        message of "Mon, 27 Feb 2023 23:00:24 -0800")
References: <87r0ua7fu8.fsf@oracle.com>
        <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com>
Date:   Tue, 28 Feb 2023 10:52:30 +0100
Message-ID: <87cz5ui0bl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbcbc6f-240b-4465-af5a-08db197184fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERLpik6WLUkHJ998Tctfp1y/oMJbIfV5Xw17isisE8ZR6kaDcGNsN1aqpZIGcl2zS9nk+ZVFR/dC0KucfbUj1WXaKoOsPlPr6bToBK3A3l1awn2yAOJEFLGPj+2yzfI0payydvphJY10wgHJDH6rlSXmpKEcZX5qTYTpzicZAqXKtvXoXmOLRir3KsC4OYUgZ9FVox9+SPFhq5bJkSu5z6AO4Cer2dh1ZfUB5ZDdAyJNB2T/rpKD/u8MK31m4q5FGxKBJV/RZ6mvrF12fBMRKhdXASYTn0LX5inVEuwlNu0VhDYlMm3DWsn2jnF6ig0lBgJDoiLV3byrQvi/wd9MXG2CNFb5PmMr+Sg5+/GuH+i1lZcMN+THgyoqByppZNKXXOCyotSZ1JiDogS/uiMmiZspYOPkecPAjey7Fa3ueLjFZlYjiMiyedHyuMWjsxWZ4tvsiDxE+tWgrYZk8Gzi2kV40QgWPNUA1twZNYlwwTQ6KPP50PjrdpKVu4zcnTE4zrY6c+vq15OYOYA0yv3NoQ+loPoxZbRUOU7rIiTUv8xfi+U5ZsbIan6GAifD6lAq+gw6zwt2o9IOP86kkH5nbXiDoOCaprfSQ8k3BCX7TiOvvazPu1ThxtbllXPZJl636wfHY7X9dXglD1J7a/k+jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(38100700002)(86362001)(36756003)(2906002)(66476007)(8676002)(66946007)(6916009)(66556008)(4326008)(41300700001)(8936002)(5660300002)(2616005)(53546011)(186003)(6506007)(83380400001)(6512007)(54906003)(316002)(478600001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDiGyy3jA3uY4/D3igG0ppY6bqcCTJ4dhYgtW+dMbvBC4P13V6NSwxLBKNeX?=
 =?us-ascii?Q?NjlMcYvbWRRjqVidGg5+6qER0nTwwFcSUTufjc93Y5NdvpXTsVINPD0nbkbh?=
 =?us-ascii?Q?pnb5xNsjEtRGtyfAKavta+7DUlo5EnpjlO4WKGM/sJH7mEK1P1xoVoPAjEST?=
 =?us-ascii?Q?PmDeUDRBn7cX7NEIpTbD9nEumX/HQPMQsrHiaee0BA6eGVnRWZNSBEWj9KAN?=
 =?us-ascii?Q?dLQMdY8etn1n7hbAnACaGRzKG0+U7JTES6t45SFUfl5MFZoNWW+XX46xhKCc?=
 =?us-ascii?Q?O2l0A6DPwoqr4XySe8uulDFymV+p0zFgvkE+wWI/Mb+QxKgiit3iH/fzJyaV?=
 =?us-ascii?Q?8Md8MqWBN3q454Nerqw6Ou2k9PEHiZlVc1j5AOtPusHna7Sd1wACxH8JuVXK?=
 =?us-ascii?Q?hIk/kti4ho0MNpNfnF2QH9aeTDRE5F3LFRPUuQDq1ABdYOuk4PWKnhjbMomA?=
 =?us-ascii?Q?XTVzKpWXExYKdD8/b9Z9l9cx0K/dDOIVj7+WNizB1NvqcTgdqNVyra4jQv48?=
 =?us-ascii?Q?5++v8D+mJbpYP7GoYfC0Er/NArwh9Q2px18mSsR3TKSgGXuGWigZ51Zua3Tv?=
 =?us-ascii?Q?TbyZJHKCZ9zwD/amaqlz3Zhwhad9+27Y9w1WLAaolKZu28P3V1f5tmSL7hMx?=
 =?us-ascii?Q?QP9IDtKmbYzZFHiNrHR+rNA1vhB8z6fjkNJLUGSHOBX3v1Tb3hS5NsZ4Edpe?=
 =?us-ascii?Q?f4XSrg6BtA+fSo2xcMys+XKUtpYPHteiD8Hgw0dMlRXUmw0YARP/tuTcU5er?=
 =?us-ascii?Q?sbF/iqOlMwqRdLQ4mMM7p535ZK4c693YAoyG6drmgWbTgbw0EWAU8VxLV1Vn?=
 =?us-ascii?Q?zOlffCODxDcmFg0sttR33hL9iXe+AWhilryeatoShJQ970Fp1ItIox9j9zo8?=
 =?us-ascii?Q?LppVKvcYs2pOsWF+P0zMtrVB0YLmutBwSTPLHtD7nwjZs/YjX0K6po7qdrzW?=
 =?us-ascii?Q?8pGN4n32kcgGM2tI49a2wN7UjeIjwDcmIel5wyMditiP/wP4KMwWetvhY8uh?=
 =?us-ascii?Q?YCiCauX7fZviajtOgYaeR6+1nZ+5T8AOHcKt3vuNw0Pv6tUIa2NVwyeRbH7B?=
 =?us-ascii?Q?4iPx2iOTb/+lxowIc/ikqMYCHDvyEgKDWPn6SaOWSeq3H9oxSeB0HdQA5jim?=
 =?us-ascii?Q?s2DpT3IpClPigHnHI5b4TJebdY7RwmQ5GvwvfxTX5ErrjX2D0P53/+T3RXPP?=
 =?us-ascii?Q?eSR0LT28tRUFH2P1CEicxgYAmWjXRLhJEyPsu8dMhPNoxw4LND+OllqvlSmm?=
 =?us-ascii?Q?LD5YdE2HbHZqsZUPcxqh93mIhiKn/fItceWv2e5euWUAArlH3mT5F8NGk089?=
 =?us-ascii?Q?/YjzDAv32Y4YQ85fj1XQxVE1eDsz4gSrsX3C+bo8m+Hk7radWtojo/aodYHX?=
 =?us-ascii?Q?ylzKavPz/ZK49p4fK5k3ucNFIunR7qxSNESNkSDXp/vJFE9Xkq1oQMBrvH5D?=
 =?us-ascii?Q?3kk0H/YJg57zFmTMEZODDXelY4Zrp6SlL1EqkmH+4GVeGSAxECAoy2jqSjAy?=
 =?us-ascii?Q?D5BARL6nL8RDfmdnOo0IXhcSTIDLC147MrfSZj8qJMgsgAQU7+FF2pYc+p/E?=
 =?us-ascii?Q?UtPti8nY7GNS2gc26dcz8cuPuUjYWDwmzgebuNxUzPjUb8Y4JpTxnM2keH4K?=
 =?us-ascii?Q?t31XJXo5ExDnTdL8QJO95NBSRdG9heSoxw6QBXwaV72Qx5xYR5jJKa8NKG+o?=
 =?us-ascii?Q?28pOmw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RY6WYZnba32ZxSuLm68a3VOfy6oCLFQ6WeLE0GWSzqqQlXdW7AOn9vvc+FgbtUYJH4yf++f+PHBPym0vERuH9Yxg85fn1O9cruNcGby1ptSegsxhq0c7gdN3db4m+uPh1E6JdzTZBR/8GT/7Dcd6WdMtXE3gXr88YBwcCDr4EGn/X1mis0+vbDJliF0tmevUBn1tVOhbFnDf3zZfPx2Egu3QLW6zXOQuPHcSw7YOhcGz5jfin7OOPEv7DggzXiMBW3wTIlNqTHj3Dd9kV6+E7CjXjeoy8EY/lfT3HAIYIiy3wENJbLbuo3CbG0gjNk5WS5TDpdOk3264Zyq44fb/X2dhB2vgPCjKbJ8pcSgUfNiiXRjJtdIfA/vunvLFWkQmFg3VoFMqFznvMc1AaPDpTfPxFoyCbMoGVPYavdXPEQ88cN8NNKfzswllp0Y4rdh+++KWuFVKO5W1ZTiddf07Kn4+yBGeOVg71CF1qvp6UmO/Qu6WfoNZRzoO7SfuKnjCVvJ8e7CWajpeE8K+wOWFsWkpNAw3mFI+ogZ/3T4UdLRAtJ3at50MjlC1pCQIfh5dhjzJ7tg4N0VkfTDfMdhnxUW7niknqGL0bBHwOAWRsD5gew3zGIJslfFoNs+AsdHrCdtnMv1C8K+pxJ9d0Daz82I8yP6dNxNRo6JvmADaDDRxAIjP/w9YWGJqYvEUyEpu81WZriXrX9MHfssjTVvbyM6Xh6Sk5MQYZnPOp7236SC5kpSGg5cFpxFzOHMkLYYW+v6qBg1zXabNiCp+krR3BWpMzrPY+rJfL+PsjqNG8tKCQ+Oz6NhmhtwFx9Qf2kaDxU4Ro1A1jA/smNnQHJ048aVbm+4tOx6OSFASFrLtD5Cv2l5mMYDorcbsdBs2hhejOE0P/huyjfDcYBdkeDKPhJhyPaEE1BJ7dCR6+wKF76I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbcbc6f-240b-4465-af5a-08db197184fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:52:35.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnQZE841OL3Tk7TSEO6kiIOx6s09M29RJ4urehX1HGhxg6KL8pGNtGubqowJ2tpgFfeDVu+dYO7I9MeMZEazjtZHglqiVLL2NwC5h2cocqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280078
X-Proofpoint-GUID: Vig76HAwNq3_FtmpK4lu22zT7rlKEVnE
X-Proofpoint-ORIG-GUID: Vig76HAwNq3_FtmpK4lu22zT7rlKEVnE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 2/27/23 5:12 PM, Jose E. Marchesi wrote:
>> [Changes from V3:
>> - Back to src_reg and dst_reg, since they denote register numbers
>>    as opposed to the values stored in these registers.]
>> [Changes from V2:
>> - Use src and dst consistently in the document.
>> - Use a more graphical depiction of the 128-bit instruction.
>> - Remove `Where:' fragment.
>> - Clarify that unused bits are reserved and shall be zeroed.]
>> [Changes from V1:
>> - Use rst literal blocks for figures.
>> - Avoid using | in the basic instruction/pseudo instruction figure.
>> - Rebased to today's bpf-next master branch.]
>> This patch modifies instruction-set.rst so it documents the encoding
>> of BPF instructions in terms of how the bytes are stored (be it in an
>> ELF file or as bytes in a memory buffer to be loaded into the kernel
>> or some other BPF consumer) as opposed to how the instruction looks
>> like once loaded.
>> This is hopefully easier to understand by implementors looking to
>> generate and/or consume bytes conforming BPF instructions.
>> The patch also clarifies that the unused bytes in a
>> pseudo-instruction
>> shall be cleared with zeros.
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> ---
>>   Documentation/bpf/instruction-set.rst | 46 ++++++++++++++-------------
>>   1 file changed, 24 insertions(+), 22 deletions(-)
>> diff --git a/Documentation/bpf/instruction-set.rst
>> b/Documentation/bpf/instruction-set.rst
>> index 01802ed9b29b..f67a6677ae09 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
>>   * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>>     constant) value after the basic instruction for a total of 128 bits.
>>   -The basic instruction encoding looks as follows for a
>> little-endian processor,
>> -where MSB and LSB mean the most significant bits and least significant bits,
>> -respectively:
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order::
>>   -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   src_reg  dst_reg  opcode
>> -=============  =======  =======  =======  ============
>> +  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
>> +  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
>>     **imm**
>>     signed integer immediate value
>> @@ -64,16 +60,17 @@ imm            offset   src_reg  dst_reg  opcode
>>   **opcode**
>>     operation to perform
>>   -and as follows for a big-endian processor:
>> +Note that the contents of multi-byte fields ('imm' and 'offset') are
>> +stored using big-endian byte ordering in big-endian BPF and
>> +little-endian byte ordering in little-endian BPF.
>>   -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   dst_reg  src_reg  opcode
>> -=============  =======  =======  =======  ============
>> +For example::
>>   -Multi-byte fields ('imm' and 'offset') are similarly stored in
>> -the byte order of the processor.
>> +  opcode                  offset imm          assembly
>> +         src_reg dst_reg
>> +  07     0       1        00 00  44 33 22 11  r1 += 0x11223344 // little
>> +         dst_reg src_reg
>> +  07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
>>     Note that most instructions do not use all of the fields.
>>   Unused fields shall be cleared to zero.
>> @@ -84,18 +81,23 @@ The 64 bits following the basic instruction contain a pseudo instruction
>>   using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>>   and imm containing the high 32 bits of the immediate value.
>>   -=================  ==================
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
>
> regs:16 -> regs:8

Thanks.  Fixed in a V5.

>> +                                  |              |
>> +                                  '--------------'
>> +                                 pseudo instruction
>>     Thus the 64-bit immediate value is constructed as follows:
>>       imm64 = (next_imm << 32) | imm
>>     where 'next_imm' refers to the imm value of the pseudo
>> instruction
>> -following the basic instruction.
>> +following the basic instruction.  The unused bytes in the pseudo
>> +instruction are reserved and shall be cleared to zero.
>>     Instruction classes
>>   -------------------
