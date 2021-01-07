Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62BE2ED74A
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbhAGTMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 14:12:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42830 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbhAGTMP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Jan 2021 14:12:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107J8k7P020143;
        Thu, 7 Jan 2021 11:11:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=53+SowExSmyCLP7CjO7aGaSVxL7A8tJ2g8a01yhp6NI=;
 b=mXE96QKLYxrMDUFnAuJgRtdJP1ZrMnJY/1ZRRYdu4b+eo59KeTUReGxuCVk5YfZ+/s5z
 W0L53q9afz6S09yqY5BeuvdKGDQ9Hp1Zye/pe0TAh10F7D9shoYm+AFgNtvOwiotnr1G
 MYFCG+DX5IWYBrah5e/pBfGBD0cv29vx++4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35ws7x3tpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Jan 2021 11:11:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 11:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZMIOqepKxaHWueznWo3eYpk3rsy7iGtAmHT9qx0U8GCqOwkrm9/9y45eBf6S6pBpI+opmfODq1heWr9bMWLI8VRlIsD/K3iOobe0mDqtymiiY5gnQcACNbyLGHHb2WqrXlKNp8n4lExXFVomQBB/s0yfhgJZSSbK1S+i9q7Lfj8XyiHM76ebeqIrI23KRQzuoN0P47BNuBo5sUVRfP4YbOxQrfu3eI+dMuTKrAucyhwbkWb3zU62gOpGwNs0imzVqNFgSh8uY9a0b1pT/fjz3AhvU7Pzzq/Va/P8eLZiRQ8WgJuT28ehvkploaRUGZjNLNjIW8TJ/HkjXvDTbRu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53+SowExSmyCLP7CjO7aGaSVxL7A8tJ2g8a01yhp6NI=;
 b=eem5W8UjIfUHJxkd9jbBAmbIE+3anzYAGoQfYJ2ti3M3UsxQSFvFSCLak16mAuotmCIy7bjPLf3Qm0RMoJxOI3f8flLND4SYGkhYzXsfvWnD8xHUpVV4/m6l7Qqq0fzf8H2ASkhqzIgZmr6Yt6L5JZ48Ug/ytm59jP6B5Y6WWhMWmZJvhHrBJAfhVT/zuzoFa6XjSnezhtbp+rgDDoYf1YgPEsregM2ehMGcC+AdERbo/kyj0bJbA5mgwNupv+S2EDrbTGVC3bYj/izEtleHroNFLIQ82j1pCrITHr8BaDxRgmzYmyRPxVoT9hqkQ+5EY8AnbngrMHXvnekrouEDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53+SowExSmyCLP7CjO7aGaSVxL7A8tJ2g8a01yhp6NI=;
 b=FUUUsMfEH3ph23TFkNHN9yS+f9V1TZvJtbqO7oUfBeQ6fFzmHIEkSfi2Yz3iZ93lajznKsn9VJOURaodrSSWa7UL9qZ70eeVZE3VKqjXQqEcBIM0iz8oFjp6ph6dbtXKZwoglbgxrjFlJMfBulC/EmGz0ebJ9uGDGNu+DC245CE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 19:11:14 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::217e:885b:1cef:e1f7]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::217e:885b:1cef:e1f7%7]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 19:11:14 +0000
Date:   Thu, 7 Jan 2021 11:11:07 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
Message-ID: <20210107191107.tygbtfi6i6ma3xkw@kafai-mbp.dhcp.thefacebook.com>
References: <20210107173729.2667975-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107173729.2667975-1-kpsingh@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:9b8f]
X-ClientProxiedBy: MWHPR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:300:103::20) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9b8f) by MWHPR12CA0058.namprd12.prod.outlook.com (2603:10b6:300:103::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 19:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a573a6-ccae-4a5b-0da2-08d8b34000c7
X-MS-TrafficTypeDiagnostic: BYAPR15MB4119:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4119670ACDF6305CF1EAEC8AD5AF0@BYAPR15MB4119.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yqf+zMeh2AQE37bxY7PyaU3Dry2faMN8U81Tf8EWhGCnsc4sAIBrlKSrlvFvg3QRb3WiMlUkRnCn0DoEWyNOnXtJ/2rOhklx1iC4SkGc9mcvcGRii7fEj3lR09a7Cxs0w4MuvJrRkRMLPnedQO1kbY5ipUfeF8ev8+RVS5f1Gbq50igweKb9tPXarJReg2xgfLK3IknGO5n0k2hPo6aCv91A27HSZUtHj7iVWTm3yE2qk9ZRdGcBui5FsDAo+5d4fVeHIBWWeQdVuOmoUeV38Rnfh9NTitvPeebHQsh8zBoucP7QUhJ26Pt9Yt2oc4qw3yjeHCBEri2zCeACZgfwolCn7yVZ1dhvWP07G4wOQYo7aMRA7Eez63jzkDPDDkjpX5FrqS91u13hh/MLvy01Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(366004)(136003)(86362001)(66476007)(66556008)(478600001)(6666004)(16526019)(186003)(9686003)(5660300002)(6916009)(55016002)(4744005)(2906002)(8936002)(8676002)(6506007)(66946007)(52116002)(54906003)(4326008)(7696005)(316002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I+UD7yqe6ejPBpSR5OYWThPd3x5r41qdiNuv2ttvfOjtBpl1gPrNKtjFDrDx?=
 =?us-ascii?Q?e+MKv+7FBUyp4/6cVJNhOUy5xm1tG8jo34VhN9oFnIRYr+McKq01Iu9qe9/p?=
 =?us-ascii?Q?FYh/mHCSQaT4WkblfzXaoku69jmi0lCoXZoHEkX6VB7BxWsr7zp8X8QlIS8P?=
 =?us-ascii?Q?VIK6kzX1wxiqvTIBC+ZimqYAqNgm5dVazNghvI1iic78+nn77tZSIRsr8+Nt?=
 =?us-ascii?Q?+6D/tbzzU4wiLfNzR9jWbtijm1eGTrGtEk8Zlgc9zrnGl6pKArl4SK/whAOP?=
 =?us-ascii?Q?4Rfy2Cke0bxfHFyW2s460uEVBm2i8L6+weVUc2XD40Q2uJAsz3Gj6NwRUQpR?=
 =?us-ascii?Q?l13Kv0tc0sAfEyWoKErX8pjijUM1utMZO9KIblYFuKc9rampQvec38YQoCJ6?=
 =?us-ascii?Q?8h9goD2Gx0QfUKD7H3EHxOrTqI6CitTclkK7CvuwS5JvdZZiMmw4/fFtuzIz?=
 =?us-ascii?Q?6AlVbiqVe+q1YV6LwpBBpyWJ3hLTrzIBCWY5/4iraBZtDbWXOgcLxUVHHC7t?=
 =?us-ascii?Q?0Y35d16RbaAUsCG8PJ7cdnaXvhRta5+aha6IC/Vk38LJ1jfHc7dvorQPQ2gl?=
 =?us-ascii?Q?rhiZsLPRCfhJ1PHMuCBn9XtK9YPDXtHTUDY5dC7DavNPeHAf+i9PyBZ5Zga/?=
 =?us-ascii?Q?+Q+GmuDVCmkjHi/IbjO8hrI22EhrdTT4HA3didWclEQTWC5pOvVu8hAVPo4g?=
 =?us-ascii?Q?doPKoB8dhca/zBhDP2aa/gP2851NeKj6z81lBoxJYropYsSAt+6kNIyYTBdx?=
 =?us-ascii?Q?3nK/g0py3mRIYP5BGUgC7GazYLUq/RLIo/u0ohBcLWpOKs68x5y+v9RWlg2/?=
 =?us-ascii?Q?VeH7IImwWuVlaejEnLRXqjRC91IhpFaYx5yn+lBiue7bA47BFePro/YuJdRt?=
 =?us-ascii?Q?kADob26nplQ95XsFqrfxWolja/54suyJ8vjPi3Lz8bb0R35oCH1iy+UK742n?=
 =?us-ascii?Q?JE6KHMN8UjgseFDV1su9m7CY8NAnk7TF+JCOd99YenkXFySS/Ht5++0pAo4j?=
 =?us-ascii?Q?DcQ5zeHWEPwxR3IC45/AEJS+4w=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 19:11:14.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a573a6-ccae-4a5b-0da2-08d8b34000c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF0ic7L8TDpwMi/aphIxQCfXLjKj3VXkkJJOONF50kBvKqPohfy8clpzCre7Hro0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_08:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=681 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 07, 2021 at 05:37:29PM +0000, KP Singh wrote:
> The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> helper implementations need to check this before dereferencing them.
> This was already fixed for the socket storage helpers but not for task
> and inode.
Acked-by: Martin KaFai Lau <kafai@fb.com>
