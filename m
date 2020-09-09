Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4353826373A
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIIUWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 16:22:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725772AbgIIUWH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 16:22:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 089KHWoa020695;
        Wed, 9 Sep 2020 13:21:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ntsNb1ijNYT+DyaCok001dpAEEeCpX8AXCRZr5svjC0=;
 b=W+FF1784au2TumUBBbmMOHa00iO/h4P8STPz/eMy5pRr8s8To8/537vXl8Fkg+2do7ah
 I56FZsdEunURZxhBPh+SATxbIU5I4zrrO5UNWbUvFBN3UhZgN8lYJRQMVC1gcon229x2
 XsMvwlKfjnoCLSkDUW2O0ACgbmz2iLVzgXY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33exvhth3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 13:21:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 13:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuJQ3HZjPQfYXoseE2O30HDRGbVNe1ellBSjt+40o6FBXDUv3N+KdFpTAqFMVbLsY3/aYWxlqeBMNMSXJGP2z6VUFsdTSstcq4PNzad5uNAqoDKnz/L7QL3RMOPWYwLJ3oCgMXQ0tIMKf1kKXfs5N7D775RyrOQgLlvho6DjGRCYSE5foPrUGBoc9vNyiJoeKmmrtcMdYnYBJNXJcXeiStkLdOAcv/kFfmL9ESmINE70pTD3j6BuhfalUIUElcF7gt34EZ5KUEgpK2wx5uWUXVigvTWySdYVnjmV0DMZWmIiLk5eFSFL43OHyL//IHCZcyKFaMF22B4/1E3Oon6V9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntsNb1ijNYT+DyaCok001dpAEEeCpX8AXCRZr5svjC0=;
 b=odK1vtWgpGp+sefw816pfmDo0HLicvlAKyd06PC31WYD1ZRZ2dP86wmh0zqhiB98y0fSEC72GUBk7pS6f/jZrmAHnH1b8nZVF0fsfuYMbKj3Z294oyVajURzNrlwHcQfCizbB5eDroWUqU7WDjtu3Myf1eDWwXRreEmp94bNwDmc+wuQB+tHjAbzMpYlOSDXm48nThiyfZhesTkDwgSuW01Y7YcN4GrTEJeYFfmeQlAvazUzpPwOgDN6veZ8FBVicszHNhFG0S2QTWuc37h6xNjQ8OXp+6irkldjquqvr3tC0TOVjPHDIjsAMA2a15JXY7uMA60qtQsJa5I8rSlyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntsNb1ijNYT+DyaCok001dpAEEeCpX8AXCRZr5svjC0=;
 b=H9eKnid4qWy667jjVSPPvfugSOOjwpUN9wRDxmcQeRzeM9vPzw2PtsdmOFQwH2GdYf4ranT1Y+3xINnz7q1oPxFrrlDqDR14UsrEYQqWfojfwAEiv1xEp/+5vXfHu+oVSjQG9jicXNnUIfPPSxD5cf6UHQZuxyOC5phf6cSR3b4=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:21:52 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 20:21:52 +0000
Date:   Wed, 9 Sep 2020 13:21:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 06/11] bpf: make reference tracking generic
Message-ID: <20200909202145.nt7bkwdwa4rkkbzp@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-7-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-7-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:300:39::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR18CA0053.namprd18.prod.outlook.com (2603:10b6:300:39::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 20:21:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fd5aa8-8bb0-45ff-4597-08d854fdfcfb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2455FE13B0D3F8CB7332B80ED5260@BYAPR15MB2455.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZN9Gu5zFthBigjYfEZHdGRLudtxiaT/xwDLoVPz2fECNJ2ZFlG8JoeBPgAS2neFbWnHFi83pL4uJAvaLZL1LKyA8QYFqN/vHZtrSkG8BF4qnx14LSMXtU1JwP45LzrUxPT/lFGn4UfD5/cRLP7fl6K8b7KkWHr3NWE6ZGBnpppzmorUTB8c9jjYs8W+V/n4OMWlpxMNKMD4oLwowYxP5OGYiQm9fbtEADdFyMeS/gn7H9hCFFvUfM/yKXLi5702mNv/S7Ucd2Nm94xazFH4KOZw3PMPlUq1Q7PsFE+Drt9UapacN9JPG333loAX6j7lqhPXj1wI/gEjJ0cFjUiNGfOXeLMYHHPyySpxRv3nWcXhc9LvZXgWByluz6TZE+rQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(558084003)(16526019)(7696005)(6506007)(55016002)(8936002)(8676002)(6916009)(9686003)(52116002)(4326008)(66946007)(66476007)(66556008)(5660300002)(478600001)(316002)(186003)(6666004)(2906002)(1076003)(86362001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RuUF7LITYcBVYeu6QpXFZVcVL3AbE8HKBeHmtouNyGQX4cERhxFm9Zj4WWLKGwDpsVTDNEeowxkKsTEFXRnt+ObYc7EioFxgPJcvq7pajxLhPx9/pRYeopJ3sHXbfBW7ipS0pfs93U0v40WrZoNQPTw6EPBQ+oBBChegCCyuggrdZ95RTENBPkPk+yCND6IMFu+IX3i+XMNlf+lp5PvJnDmgF68My1Vk42cTmzwqOeu+Cg4eIW3sj7bkzcU2FN6HuGo2Q7ccHzBcO4HrULL6aeBWEPDqul+rn4OQYpvsPzENV2rEZZ/hmU8xmU4nR31kJteUjiB+K8OIzkBWUcdCNBrHcRcS76brOzXV09j7ZwGJjX+o5jVOrS0bmmB10oZFvfewtMfjJR6V85JD3pGXN4Br1R3cPrn0Vf5vzLuzDl1slp4Th0NKZ21AMHK/gd9J6NbeNgBdgDkul/D2NMcSTelttafnyfwO7mrEJfgK2m6HT+OUA/vpl5yqzC6d9kmf+GLJY4lFkypFkMy8arg3p79PZFOq9/vfW/kJRm1+CYsBDo49WuC3HuSJJoqBkFD7knBAHvkTxrFj3czdmILavVMFgrCY6LFMvR9RfYmdHiAzuTCxAhorBSchVUFuqHs5+Es3R3v/cgWYd9eM8v9wUVafoLlxezqW+1iwjAkBtfk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fd5aa8-8bb0-45ff-4597-08d854fdfcfb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:21:52.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKjMvwSFk8Z5EU6QOBVjlshapXeh1/AFesKHff3onLTT8qeKjLjthbry64cUwJ3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_16:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=1 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=753 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:50PM +0100, Lorenz Bauer wrote:
> Instead of dealing with reg->ref_obj_id individually for every arg type that
> needs it, rely on the fact that ref_obj_id is zero if the register is not
> reference tracked.
Acked-by: Martin KaFai Lau <kafai@fb.com>
