Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9192219E121
	for <lists+bpf@lfdr.de>; Sat,  4 Apr 2020 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgDCWhT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 18:37:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388922AbgDCWhT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Apr 2020 18:37:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033MV5Ab022207;
        Fri, 3 Apr 2020 15:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=orVTRiVunI3muYjWiUhSjohyYMfn4ykT064MFswaZ7k=;
 b=pIsRWgso+tw0W/eVTxNm9b+Y8ztUl78s8dkeZlQ4Szknny2Cv8W+Wcibm9Fh3CAww57n
 0nrs9mh2KN2Taey07JRKjgfXegpuzjx35WbEeSsQbmxMkq3VWPa8iv6uKFnb4b1yEZV8
 NwK8TGkqqnOtu1D5WyEvUxtHv/riI7EvDt8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30671528nq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Apr 2020 15:37:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 3 Apr 2020 15:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IojIATX1K9TXVV2LCBvB4ykFawUrS7+FrxMne4Ys9643vdo8LiLbKM8YiFgCCN3Dri0KISudhsjqm/MdpRuez0W3A/Ft1Wka/1+jyNnIaCHIDRoCbaiJE3zEviQO6I1HFtszETBY7qA0gNElTQzQbuL9Yr+3mwPTR2w1Z7RvLcKYvSMrnGk9pH2qXQ8Hq73L14rYfbT5Yyjxop9EmFbXBs6PJsPzOinAAmMHNRSB80qguhf/b57Bb91nuf51B4dKeCWHoKOx9xC3RvPBG/UQ5h9fVQqElEQK+VVmU4/9za1PQ7aJHsFiBdemW4CS2tAulAqj+oByeeUCWhKcEZGjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orVTRiVunI3muYjWiUhSjohyYMfn4ykT064MFswaZ7k=;
 b=DWE8snAEMH+yxy/+L+8CUyBTyGm9NgmyvNG3ZWDa83tLgSC8Ec/7pAyMklD7fNuYYWFxxLqYX6QOv5oF3T51sdY1Le//3W9RhFZDLcbrpp8dZheyjADGstZ7xMaUmIPa6NkYaXRhp2m41Zmi9y88KrZjoovRxj7ORg9AWoofEs1FKE1zaONGmBJm5M5lkaaqXO5rN05pYz4KqaGDBlBoaSv4oovi4BN5SfInCn3OETN0OP6ThpGMQSYb8ELSUiZJDPZO6M7Og5XsB5KJgSj8He4VD/jh9tviDGvLk9FIQhpWYuDkF7P+F1vU5kmUGxMBDtpJoUEJ95elCbJU+RXJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orVTRiVunI3muYjWiUhSjohyYMfn4ykT064MFswaZ7k=;
 b=AeFC5HydC2rMv/8IRToJj53O1u6zL1hRNZ5Z90MgzjxX/9X3am84SvdSzd/3tAWPXgcdNTUrF9lWCbCtm7fcBUIunjMNTrgF0WZXEIx908nFYRcHJlCKL/XSd2C/MPbE0fhtMjxZAxOFpKCXwsVYTOG+xUCZNtFX+uamQCr1J04=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (20.177.229.24) by
 BYAPR15MB2887.namprd15.prod.outlook.com (20.178.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Fri, 3 Apr 2020 22:37:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 22:37:09 +0000
Date:   Fri, 3 Apr 2020 15:37:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Odin Ugedal <odin@ugedal.com>
CC:     <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <Harish.Kasiviswanathan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
Message-ID: <20200403223704.GA306670@carbon.dhcp.thefacebook.com>
References: <20200403175528.225990-1-odin@ugedal.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403175528.225990-1-odin@ugedal.com>
X-ClientProxiedBy: CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:71d6) by CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 22:37:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:71d6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6d0a80-23b9-4f07-37d7-08d7d81f8b5e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2887:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2887E8AD37FE718C555ACEE1BEC70@BYAPR15MB2887.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(81166006)(478600001)(66946007)(86362001)(6916009)(52116002)(6506007)(2906002)(7696005)(66476007)(66556008)(316002)(81156014)(55016002)(5660300002)(4326008)(9686003)(6666004)(186003)(8936002)(8676002)(33656002)(16526019)(1076003)(4744005);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2gzfofFl/6VmFzQlEgVA+ey0W7Zn3/ie8CrZlVOPtZDO6GS3UttuWLpM6g8XNzGAEyswiI70KpYq/6rXGobWpbeh/GjoCTCryWGTnkxRQtWcbQrkpUIbiKtFGMVizOIVtJjd2AbzVpBJOroqVtHuBpHXFi+8o/X4P3noJv57jgYte0eyjY3jCAguGJOxAilP5PSps/OqbEaYHiTP9s35JU+fbMlSp5Ov8vdVdkZgZyjAz46QEVzOQ/8lIzgae6yF77WY7IZ+uS6ZkNTqpCy4O5+XIMBHkq35YjGOvcQdDA1csIFnCzKz+DBDGJlxiIOenhPooktK/2l08LXoYkhHvFK+xwjNpaRSVzQcf091SQuT/LjuwN88rlQRaXqelv51LPz0A9e4TFJjXCXZbQE0AfztNfEfr1nEjVlKfhb9P7uY71x6pgSI2dW3U0ui7oh
X-MS-Exchange-AntiSpam-MessageData: zPnNOeLuXvygXAsutdLup0oQbXCvwQHRi8I+CeC7lFFgLmD779VOeXOikCX7S+nVCT7K3vRgRSV5fQ9qHF7jWqrpee1h0suG+DiPpH4t4RJ+SlgaRnUMAnIFe12QMgL3tuGpY9TwNsGnY9SclMHVkOPJsIcKjdzXiCv0/NPqRKPcBjN8VqR30x3S1g8//t7Y
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6d0a80-23b9-4f07-37d7-08d7d81f8b5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 22:37:09.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7jJ36HbcgBEBVnE9nVGIG/eySBgjBIu15HNpzPHEseQ1d3+sI0hWOJ0sAYUgquR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_19:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=953
 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004030173
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 03, 2020 at 07:55:28PM +0200, Odin Ugedal wrote:
> Original cgroup v2 eBPF code for filtering device access made it
> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
> filtering. Change 
> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
> reverted this, making it required to set it to y.
> 
> Since the device filtering (and all the docs) for cgroup v2 is no longer
> a "device controller" like it was in v1, someone might compile their
> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
> filter will not be invoked, and all processes will be allowed access
> to all devices, no matter what the eBPF filter says.
> 
> Signed-off-by: Odin Ugedal <odin@ugedal.com>

Hello, Odin!

The patch makes perfect sense to me.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
