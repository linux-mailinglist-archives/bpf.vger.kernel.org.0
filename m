Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD35895A4
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 03:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiHDB2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 21:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHDB2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 21:28:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483E14034
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 18:28:16 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Lq9Z8015077;
        Wed, 3 Aug 2022 18:28:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=M/tkDyMeXjewWBytjG0jIwPiulkLpHkc+9LiUCmOuso=;
 b=JHGw/sSldXANkl/7xXQmumuKSXPBGN3XD4Iidap2zt9H6GgTgIWyEjld1WahEQ4L/79E
 eu+4asZ53Tp4WH5mOkFToT1e4vaEFotMSKFbES6YDHj3eo6YzbeuxyxdkEydU38k8S22
 bKidDzPC5jW8zLHPDOHXd7OGWhq9RUo9Y0Y= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hqty7m128-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 18:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL/TBZz3Svwd2flhVTlNW+RgMHQZY5jsPc4ktZDS4tRqh27gHsaxsNuBfxf4JKJpe89ypGe+9WvaLStKA0oAAazlBVJNhdzkOVXYUNNuuWWRdoAyGJR6u9dfL6a4Z4UucfihHhIqNucZTdC/B4Ik+z6Deep45zsdbeJJrdSEOPbufCxOGSjPvwysBjH46eSWCqPcfzH+hLjsenSZtdksRUi8HageqzcaEk9g5Xfo+PTnViGoM2oRAp8HOOG+RNPcuojn46N72zy0XTLvS/R45Z8jI+NJkYtL7PzvqKuZ2jiKwgMBKIVll+yuyy/iTEcH2tUaIBa4IqGXjlMbSBLvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/tkDyMeXjewWBytjG0jIwPiulkLpHkc+9LiUCmOuso=;
 b=gD+V5ErgAzsVgfkGh+5e7TNqY+OpfMkmdbfhydnnPZWKukfdbJFM4xGYdMlQCRQQ9T/L8mZvmhbQlPt44yDHGlaHXBrkGMgSAoar+AlxaRxxgu0C/JSxoQuclUH8E22Ws8/iGqfR0WmtYzOm8vfoDhYsJ5c7qOmzU1nehBXA/fSidBRL4O1oUHrDx6oQOewSop9o029tEbX1xYcK+PZlALhaWGKjDoUynW0LNOsAzmx5BPfHyJ7UZIDXYAqWj6oE8PJ689bNQtRBNvn1t4C/SyLk9pq3SsnB1rZC4eD6SUP0Q/QohazJz7PhUhDw1LkMHzHtrS2UcwfRlrGZvKqKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4772.namprd15.prod.outlook.com (2603:10b6:806:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 01:27:59 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 01:27:59 +0000
Date:   Wed, 3 Aug 2022 18:27:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220804012756.2eqvkofecpthzcoi@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
 <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
 <20220803162540.19d31294@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803162540.19d31294@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 750c0b56-96d7-4c12-83b0-08da75b890a4
X-MS-TrafficTypeDiagnostic: SA1PR15MB4772:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xVGhB+BJijtRnwlnw9BFa2F5k3hPiRFgGJ4zJsaVRfDhjDAenEXWb2DGKXN41wlx3+NpYuvtwx0yj6/QBD2FpRaz+gtwfjfW4iP0DvrfotGR/uPcr/8yIajHLD2HAFlj8I2XXgvY/ZXnPFaUiXv67vgniG4SrZTIYE0jgpWb1Vfdo6Lk1HxdEX+2sBj0++hft8IjP5qIt1PdEbsVYhss1K2khUmel7K4+bho5iYsKOncN4FXQ+xulujt+aNCMyTE6PvdFapFEs7+N3AJCQDfFdgsHQyoeAzzOOUOGcPfYqH43kdY57L1NNCYeqPa4E5jwC6MCNrj7q91ItjC7eZmabrG1IwS0u8X8kQpYCWPl1TE/zKLrWlF/F1yApDFdfimc7uDtZxSDv7QdUjo52hXEKqMHAPnzbOVTj1rdkRltQOyjeitO0jW9xW9ZRT1s6Z6DIwxQtpvIwXh6DXlv9eXQIOfaIeIHGmpqsdikGMmx8f/VooWfJZvJlogdUmrFac8Ow7b/rRsVOp5pBEH/YhtzbkFi1YW/erqPnwsjILon6oOb+EwSIQPoTksTKI6yiGjNII2UM96sUCSkK0LEOub/Gtyokffe0GihkvRm4alDxVmQidV1so14IKQU7WIq89DNjCWQQQrN7eYLyI6we/f1+DRGZUWF2JKJ1QrlK+kG6AtBTgQVCIiHBmrLtW4KuYI/Dp1eboOn/kD6/q6V1c58BeYGB5Ly6wD0/1gOyjMzpm9BkQru9VLk+YIpH6wx30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(186003)(6512007)(9686003)(5660300002)(6506007)(52116002)(1076003)(38100700002)(2906002)(66476007)(316002)(54906003)(6916009)(66556008)(66946007)(4326008)(8936002)(41300700001)(86362001)(6666004)(478600001)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hv/KXRD7g+XqIXj+s1j3hDpPIRwfFAm+COaWrqak4Y8krmEMoFV/EjybOR1Q?=
 =?us-ascii?Q?+qV3TLtZpV/qyC2hhjTI7Cq6PtOSbDH1LKrxTBBmjAWSPsuAuyTfHZNck903?=
 =?us-ascii?Q?r7sG2Y9USbKsMxleGhb5pPh7Pmk5hwbMY0QNehr/OqjngzHL//hg/K2AjXxj?=
 =?us-ascii?Q?/4sVxfMXRQC0TyPLHJ2cHd8Z1Z+n0fPf3i4wYfzH1DVk1V47e6pkCWlSjMS+?=
 =?us-ascii?Q?iwmhE0qskV6dKSnyM5Z00ByKS09z9/yko8kZKwyZr1rg/CihvLjT8tnj4rnF?=
 =?us-ascii?Q?30Lz+oUt+/eWdUUr/6rcV4hWoMi+Pa3ia6cFMXmisfQ3Q9kSCQRSwOaORcCv?=
 =?us-ascii?Q?bAmsknhjQyVqC5uI0IHwKD7lxw7qvY90T/NCbeeOLOlrl5GbkF4J7sOQ56UD?=
 =?us-ascii?Q?i1VttFvONParSrLC4EaCD9Zi++cYC5a/2mECDmdwZTzpCu/dqfWUFOF1PGTj?=
 =?us-ascii?Q?SdMTLxf/eJhq0jtNkkSTwd0yxeRuJbdZG1UDB5O6iI7XiRYU8aa4h7xu6CMu?=
 =?us-ascii?Q?WRSuBC5uBCOKPFxm1OG+3OqRL10XaG/9logURYkR6I2Of09t/2CxYK9+z8x+?=
 =?us-ascii?Q?lTtj5a8xxZKd19VDa1vUjHhnPafkETEUBJr2GYofGPIYI9vxI18NXdtHwXrP?=
 =?us-ascii?Q?o0kLc9dB3CR9Ek31NJTDFn/8mS+OBETvZrsj9VtNuRhiMX4GK7R+LpVRcJOO?=
 =?us-ascii?Q?riM9wcEdjJXA2W6NQo3+5KWdcx7sWxhHmnE2cKblNkgMwKlNQjA1nU6GziuH?=
 =?us-ascii?Q?L9l8093CC7hyZZAfNYn4jJQJAOyXX/ELOt8qdqITvgDxleiw8EBMK0wQQltk?=
 =?us-ascii?Q?LNpKu7E49yoyTZWBUSTj6BH5O/UC5DYsUPL8LDYWbRtwdXF1HGZA0/WYxDce?=
 =?us-ascii?Q?gOizn90SqXxyOOuO75+UoSxsB3sja7A1HFf8/QsZSo4h9NbtIufWb29Soq/h?=
 =?us-ascii?Q?4eMnk8Av04raxZRSxrLDIwkRvuvXslGObtADLSgebZPtTmfkz1lDu2nGumub?=
 =?us-ascii?Q?D9tJfdSvBBVUlrmtR1uyhZr5jh10QgN4HUT5VvPmsSpk6wF6//jZ/QH0yqGi?=
 =?us-ascii?Q?1x2Q8/IzsYu22DYImZbLlSqAxQCO/U7hpaC51QPgB8giZKnVlHNBXKeRkGYY?=
 =?us-ascii?Q?vAG6V5NAuyN4OfRMUa5v0X1+y2MEY0yUcVPsHM/CUz2W/CAN3KdpC4jC+Spm?=
 =?us-ascii?Q?IPbbzSseG2h6ONmQRCZoY/8rqT8AzFSeCkKStlfOwMYk5Snf1+hpFI+pJVtC?=
 =?us-ascii?Q?WCd6yqIv4gwRJMRW5MRI6NQilaFPeLsoaDTWpIrYDv38C7TXvKja2cHEGPsy?=
 =?us-ascii?Q?mwq2/OzKY1W5eywLGjtRfgr10Y7MJ1elhejBls2M4rj5zzzO5tbxxe+Gc3Ek?=
 =?us-ascii?Q?0bGhmQulI9N/oNx16M2Z8HXRyvV5rgWxr6E8OxWGAPYPJvJEeTXC23mebYk1?=
 =?us-ascii?Q?CWCUibHtzWTCxM5m/T3PTuzSe5dABsHKw19XRSVX3Ug4OoHuAzBsodU56kgr?=
 =?us-ascii?Q?nZY+vE3xFsXJTzkmMQY5yEBqDLk2QcASSmvsVFHXkhDtFMacoiNWeLC98xr+?=
 =?us-ascii?Q?ZnM7ONoeZmdy5VPP6ZSidMrIXZ6FGf6HgvwHxLp7FuW8T6YldakckHGwZ89f?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750c0b56-96d7-4c12-83b0-08da75b890a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 01:27:58.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdKRSJtXgpeCPlQYGQTo177FcIjarCFhsH7XLvq4xjxulNAqTF/4UIg9Z/PThvCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4772
X-Proofpoint-ORIG-GUID: X2fPPbxc6yuoPIRomCMGYSkLMAQc3l8b
X-Proofpoint-GUID: X2fPPbxc6yuoPIRomCMGYSkLMAQc3l8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_07,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 03, 2022 at 04:25:40PM -0700, Jakub Kicinski wrote:
> The point of skb_header_pointer() is to expose the chunk of the packet
> pointed to by [skb, offset, len] as a linear buffer. Potentially coping
> it out to a stack buffer *IIF* the header is not contiguous inside the
> skb head, which should very rarely happen.
> 
> Here it seems we return an error so that user must pull if the data is
> not linear, which is defeating the purpose. The user of
> skb_header_pointer() wants to avoid the copy while _reliably_ getting 
> a contiguous pointer. Plus pulling in the header may be far more
> expensive than a small copy to the stack.
> 
> The pointer returned by skb_header_pointer is writable, but it's not
> guaranteed that the writes go to the packet, they may go to the
> on-stack buffer, so the caller must do some sort of:
> 
> 	if (data_ptr == stack_buf)
> 		skb_store_bits(...);
> 
> Which we were thinking of wrapping in some sort of flush operation.
Curious on the idea.  don't know whether this is a dynptr helper or
should be a specific pkt helper though.

The idea is to have the prog keeps writing to a ptr (skb->data or stack_buf).
When the prog is done, call a bpf helper to flush.  The helper
decides if it needs to flush from stack_buf to skb and
will take care of the cloned skb ?

> 
> If I'm reading this right dynptr as implemented here do not provide
> such semantics, am I confused in thinking that this is a continuation
> of the XDP multi-buff discussion? Is it a completely separate thing
> and we'll still need a header_pointer like helper?
Can you share a pointer to the XDP multi-buff discussion?
