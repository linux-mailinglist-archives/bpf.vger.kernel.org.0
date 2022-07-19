Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E857A68C
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiGSSfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbiGSSet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5805D58A;
        Tue, 19 Jul 2022 11:34:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGmRSi003839;
        Tue, 19 Jul 2022 18:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4/IDXs3WR0jBq8rlN52v4EDRYO8QhQ5NFVwgr8c/sis=;
 b=MoY+OOF+daxbrK8d+zkVOnNizN9hXmjPhSsQoyXEL95IUTI/1NZpB8lJMnSF+SoL5epx
 q+eLuqfYw0fY6E08W7Fxr1gdRT3MW0h/L68XemFWQUGfYFEqVMUfKZk7OhlLv5dsAYCc
 ML8BnDWQA9DXG6SuWWsqJNTLM6f/+QPEheol0VIKv4yqwTRNxVIFdnf8pDgQ7v3+cX3q
 Gizlnc6JQjQeaQJM2L3eyGlQJbiC9r0H5JIdnF9h/m/+ZBkYx7DItzT1XD6ZsErS/cky
 vBuOmm4K89UuFE4G7SRm8zwzejmFVW1ipQNPI7eFaJvBfwipYku8QU01ZrIJNfUr504B Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs7bsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:34:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIU5JP016547;
        Tue, 19 Jul 2022 18:34:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1emtc4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI0atActdtvjsmuTVtDcVwPfIf+93EmduMKuQif1dNkPvh0fBr7I+5eactaqWkq43E85EfOS4ap3s0mGZesl2GpgehcdDv8Pgq68cXFU/aClWMt6+hOiTXq60I0RTTT/dZSV/aY+PchIb3ouBXMlybZUDFZI0OXj2Sehbd/X3pa5zAD1U9JrNqnGl0IJwlpCIndNzgPOFBJlUIJH9mihoT1gTvgxefCy+SZdPXcffpGFR/wqi4WTMMxwCxXL5P2bvn0gEHtQdPK0MCgVfw9Bcj41e0v2HNxsy725NiBY1yiVAAUTLICHhfeSPEzZg4aYMYGV10EfYe5b5R42zgwhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/IDXs3WR0jBq8rlN52v4EDRYO8QhQ5NFVwgr8c/sis=;
 b=BRR4pNkKoXvOAOfOuLz/Py2WfNig/FXrHB806Dj464znV5KK00SqgcKbS6QDFbfa7ytOonB31qX+pzwzGJFFXGUxaJVLFG7Dls5Hi/nh7GXt5GERIp0jbLbYzrUInlmBlcx64JCss5XPXmPdr2SDrfewwlndqdS/svu4k1YNcNJaILsL8PT7aVzhuHNaFnB2r9Vx2lKCi6G+UYg/0n5EFwhTW/WdlW7pFpcbr6L7FIKMfzm9ij20yTJrMjh2m2sr/HjjtskhKBhbJLuR1/oXjm/UBL0mKT/5eQ0ItrVxEH51K/AqZjpQ/Ebu38yHe/fMlE3lzmoG8bR6fNkx8eAHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/IDXs3WR0jBq8rlN52v4EDRYO8QhQ5NFVwgr8c/sis=;
 b=bbfPoW8hwUsIPVSXQ3LsIeaRpGQTudKcowW/Uy0jYK+1gS6EooBut2VE0PlfPipon8+tqbWELRRU4zh0RIR7SlnN6jycmdhGmR8M8vOHCzlfTR//zFwOljgd1zqISNwmVzfnHjAXU5xhm8bQHqSS5j8z8ccO7ir5XYEMgrh1Euk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2655.namprd10.prod.outlook.com
 (2603:10b6:805:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 18:34:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 18:34:25 +0000
Date:   Tue, 19 Jul 2022 21:34:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix sign expansion bug in
 btf_dump_get_enum_value()
Message-ID: <20220719183413.GG2338@kadam>
References: <YtZ+LpgPADm7BeEd@kili>
 <20220719172640.pfbsfhdgmzn76kos@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719172640.pfbsfhdgmzn76kos@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0211.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d60f02d-ced0-4c10-e804-08da69b54e2f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2655:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwFwt1eb2Wb5KJA4b50kcge6fImp99WRkaEBPTDJvW048VeXRzUB4yFXnGOmpGiRFECzo4px1jtbgY2MUni/nnhOXuKN9JWsaYAPXTNFdp//OFcOybkGYcGQa6Gfy2yOk6trVCs3235Yv87rePhujQfsbE/kNdQYZXhjutWMrTpDYrYO2MtyrsYCDfcdV7G9nfHD4ie4FpvvxrZtsDpjeXHo6hoa8ZFIydfFK809h9frI7aNfTgKlfl52QcsgrjUVZq1nHBaU11/82XkomU4TGwn+mO3vUoA/I7y26jGHm2P5B/WZEId5t2AoT/6mNNBLSLYGXQojhsbMVEmrDlbecbJB2ryasS5A7XP7/336C8rTENf2UEXX3cLzS1i2GxG37Ks/JXxD9RnPpG3+NiC/rRiW82LnrART2Yi3jh1fBVZ+NQeUBHb9MPvW3O6f9M2rYfGcdUnxS9dTqaSdMyQ2GyciS/4VxXnv2T5rg8fGXGhFK7uQPXSF4W81rwujbS5WOLOVPjpDDM2X5Lg1cW/LG6eYGtOXfVLlJ6Y2JKYnQBAc9vJcTzLjlL4txMqCAF+nictxTLI7vNi4wocqthEN/XkWdK61evzavxa7Nr95JoRgT5qxuo4qx3UqPs6bL3cDG/caTIzCROUlN4SLDiVGXkTYBlLPlKx2mHz8H4cIBMg/gdVm+YPlE+399QvphmwzP9BMMFXLtTtjOWRidog8jMveDKqX2wwMTnLMuTPafzA2RbWlAQhgAisFz7zRwrdp4f9hruilQeV62GZNrl1NPVtlkwYi1whQ0/kcftJeQQKsfnFwxfT8oyUgyAYxUr3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(7416002)(6666004)(1076003)(9686003)(41300700001)(44832011)(186003)(33716001)(83380400001)(2906002)(6512007)(5660300002)(6486002)(26005)(478600001)(66946007)(66556008)(4326008)(6916009)(38350700002)(33656002)(86362001)(8936002)(316002)(66476007)(54906003)(6506007)(52116002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91yPhSYM3QSjbJ7wBOfokupOZ+k9vS13Z+QTIVGwY+FS6crenaa8k+btpMMF?=
 =?us-ascii?Q?muJsEUuX90cGVamF8y548HFMA9XXIWNBReSttq+29INmPN4Rl9Ya4CN4nVB9?=
 =?us-ascii?Q?idGojR+ZiJsis1mcVSxSF/0OzQeWg6bCA40HRqSAVbOeYUEVMet7LmB7hKDI?=
 =?us-ascii?Q?VI8vI++zFckphtP5OwlOopaVlhnfUN5QgA2TvIuP/34hlT79IMDUURkjnPWF?=
 =?us-ascii?Q?Ib+dVqyjbblqlBP58p3lUXuHy/D1DbV/xCiuGhjUKQRFS+rYW4iub9/QA/Y3?=
 =?us-ascii?Q?EK7Nzi36ZPQCPBbBv/tOZCTQOu1+o2bDwkxZo/OiZADTjqp9phjaLj9cs9NA?=
 =?us-ascii?Q?gZjxB6FXQJ7z5WF1o08xe86pFJKr4o3cL7KCtvI/n4zd7XyZhbB65qaGJCzI?=
 =?us-ascii?Q?Wl1H0WaIro3yffX2Qy9WsmQWDkEOUyKImPwX8lBqd6es3mSh0U0VVX7eFUy8?=
 =?us-ascii?Q?dUnpiJj90q7C554w4MTYMQflgxzssfkgSX3t8mWGKQ/MPu+0KrGcvGGCelfj?=
 =?us-ascii?Q?HXyvw/24ZzfPy5yp4ESrPeiHMe9M8kPocWGu4Cq15OGSag99mO5SxYE3g1MJ?=
 =?us-ascii?Q?txDQRdb6DgVIvLwVwHB5NBJ3dUhQHmiQcPru9x8jeiFSRu6XQTPxTlXS3bcb?=
 =?us-ascii?Q?Vi8z2dJy9gqIndqsgeD5xr6zHTk8j7jklGH/zGgK8ylQ4NK33WNvTle2u7Jm?=
 =?us-ascii?Q?AAjX7kkZRNICQgK2n3ks6RdKBR+IkygmnBrNx5fSSFPLh0cvguQWNXcM1VAK?=
 =?us-ascii?Q?ldJrM1e5e5iP69HKxkLNHt0X1WjQunck5pdZdH1sJER61M2KqE1h+o+0vSmC?=
 =?us-ascii?Q?jf/Rma5oK+pKDahf0KZ8ItJSkkq3D0Sb5jB8CObWMDxDN0It+MYWS3pVQ5T+?=
 =?us-ascii?Q?2N7jenTVA/GVhs0nLBaq27PlbLasIWm8UJI11asafvop4+IR3iQLna+oFE6A?=
 =?us-ascii?Q?gxaz9gd1F1SvJ7lupjwrN2Iytrgk4nTVUqKFSGFotRNogeFpCs8i+oXIkPST?=
 =?us-ascii?Q?qwCjJR5cmkJp+YhXJMCfTf/0bJnaGuhEG2mHF20RnYm0bsqHSweC8UtjjtJ7?=
 =?us-ascii?Q?OC9mGXLmqav/AdiUx/2rImG6T2za+EVei/dPJA3jAt+h4qUE8uHjnaxtuUgA?=
 =?us-ascii?Q?yUicA6ntRoqTOthdk9wDKpZYME73T06L62pmpKhUdt07mxb5uMdw1BOH/y8c?=
 =?us-ascii?Q?+Y3cH3SiDxOPUR5ZcatmOVVbtafGqTokNPjiAqqVPZqVP4r2V4NhOECq3/5Y?=
 =?us-ascii?Q?SyXWEr/gyaT9avgVJgGgssOtQ8Sjz777X2l4su/udVu/WKVPXVU7yw4/SXUe?=
 =?us-ascii?Q?+f7xwdW2MRgZsNA+2c7/pqgJcLNHxRd3HB5I5vOH3CruPAl9V56j6+XufkU5?=
 =?us-ascii?Q?k9HM9SCsvMRIA4lHIHfa+XCXSxPzCZSf9thUzXQ0PCu04o1MmqfLJGJa5o2Y?=
 =?us-ascii?Q?edHLZuKFsRyS+9eG5fm/Evw3fNJVm5wMip3Ws9gFDK9tPrRSwji44BePl45Z?=
 =?us-ascii?Q?baV3aCdldzg1oSrCfKVrQ19wXvMdOIz+j8lICR7RCiwU3IFAJUrr1WtA0Adl?=
 =?us-ascii?Q?cWc//DimGZ7VJw1aur/rhDjmsy+1e+i0QDZx5IEIOSAiLRcsID47e67idHwc?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60f02d-ced0-4c10-e804-08da69b54e2f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 18:34:25.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ounTANdAYL+TsZ7LSjIlVTIBeIjnch4uqXaDM1Eafla1INEkmxqICimO5YuH7ae3RRheO2Qen8CH1j6NnsGIS4NItM1x+Y3xar0ewLeCadk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190078
X-Proofpoint-GUID: xbYzVmNx5wjLaO0ECBDCNOKsMSc6-_oa
X-Proofpoint-ORIG-GUID: xbYzVmNx5wjLaO0ECBDCNOKsMSc6-_oa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:26:40AM -0700, Martin KaFai Lau wrote:
> On Tue, Jul 19, 2022 at 12:49:34PM +0300, Dan Carpenter wrote:
> > The code here is supposed to take a signed int and store it in a
> > signed long long.  Unfortunately, the way that the type promotion works
> > with this conditional statement is that it takes a signed int, type
> > promotes it to a __u32, and then stores that as a signed long long.
> > The result is never negative.
> > 
> > Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  tools/lib/bpf/btf_dump.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index 400e84fd0578..627edb5bb6de 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -2045,7 +2045,7 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
> >  		*value = *(__s64 *)data;
> >  		return 0;
> >  	case 4:
> > -		*value = is_signed ? *(__s32 *)data : *(__u32 *)data;
> > +		*value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
> Only case 4 has issues and what does the standard say ?
> 

It looks weird, doesn't it?

Yes.  Everything smaller than int gets type promoted to int so the sign
is extended properly.  The only thing larger than s/u32 is s/u64 which
is already the right size.

> Do you have a sample dump to debug this that can be pasted in the commit log?

This is from static analysis, but I made a little test program just to
test it before I sent the patch:

#include <stdio.h>

int main(void)
{
        unsigned long long src = -1ULL;
        signed long long dst1, dst2;
        int is_signed = 1;

        dst1 = is_signed ? *(int *)&src : *(unsigned int *)0;
        dst2 = is_signed ? (signed long long)*(int *)&src : *(unsigned int *)0;

        printf("%lld\n", dst1);
        printf("%lld\n", dst2);

        return 0;
}

regards,
dan carpenter

