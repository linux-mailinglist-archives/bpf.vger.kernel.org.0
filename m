Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6853817C648
	for <lists+bpf@lfdr.de>; Fri,  6 Mar 2020 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFT1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Mar 2020 14:27:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41154 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCFT1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Mar 2020 14:27:54 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026JQ0Iv018339;
        Fri, 6 Mar 2020 11:27:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0axSdQSqJlUHy3U0D+0t0hjkgkUFVCAi8SVfL/IZrnM=;
 b=Q3Cr6fuxhjFqj1y04E0/GFB+V4/1o8E2mYiYiz1haRBhSdTTR8aV6J4yds8j8RMHOjeK
 sek0GNsIRuGNUUKeXecJTAA9ayDqMs1XwtGLXV3g+GYYsQcYfqDGtb457LpjXstK4sdP
 jykD9XtpgtEDDSvfexytfyINdN1jCwJq7Lg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yknm8j4f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Mar 2020 11:27:50 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 6 Mar 2020 11:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyK3RYS7/4KAzab4hbqMJwVHZktCTjGEZAaU9xwuzBKgEibr/4DZf1LZ7t4xuwPhNxJoaSYjvWXaGSp+c7QWVLAZDC9SGnGrF4LlskvWStmFV7r6QmFcBeVUZFXqLQ8Cff6IHdMv7qhiv3ytJraARCCHmbcOOYfeta5FMbHX/CWCytJwv5s24Ro4neE+KsIQtm86l0iBE32XC5Etlyr8MFfTVBw7Z4DRXhqmCEUjkDaE35gflxYqO+i4BWzROl8M0EVr0CAjJhUxf8+1Wxcl1CM5HJdoiynr0ghNftDDqnZ0add9iTqVyMkBg94ngrEsgH/FRsgstukRjUGCXvhVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0axSdQSqJlUHy3U0D+0t0hjkgkUFVCAi8SVfL/IZrnM=;
 b=H6YUkjNt4ouwUHp+0Pz5pmIG3NacyHw8H+Y6lfDGHQBvh4wO5554Q8lFRdGRMdS9tSRKsCEyBYLZYwafJMFstD3Zgkzh3Gdou5e9AR3/eqKlAKbaJkKFbVvdJV4DwHhtSjm8AkEPhtiHcGAMbZGs3fjLWTfJLCVZ+VOcnRSueoSodtntwHX3MaIiw/o36gMakg3/3Y/Nl78w/SZ5HkYj0LbdfzitTONtkA/gsfv+pk+MtylwJO0ak8Xr52ryALRyTzBz2m7sgCb5EpFe2m96ePncvi8mBV4c04gRTGn5aBjNvjoe4i6+I70r2qgkVIBYNG2vO9vHD9Jmt+rOjIKTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0axSdQSqJlUHy3U0D+0t0hjkgkUFVCAi8SVfL/IZrnM=;
 b=bAKYU1u2aUm1IPC2ES88tA04ALKYS1CxjdMNqktl2IY71AzoKOGC+nu6Iy2Yy3q0F8k7jPNaibslqWbNgK+IQJWUYC+UKgtsuQ+ERy8RGuhaJ+ic9tYkWS1hd0C6ithEKXmhkgWq5Z+vUZKd2gFxX9XTLPrk6+Wl+g4fuZ2mmfo=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (2603:10b6:805:22::25)
 by SN6PR15MB2239.namprd15.prod.outlook.com (2603:10b6:805:20::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 6 Mar
 2020 19:27:48 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 19:27:48 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-block@vger.kernel.org>
Subject: Re: [LSFMMBPF TOPIC] long live LFSMMBPF
Date:   Fri, 06 Mar 2020 14:27:45 -0500
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <76B62C4B-6ECB-482B-BF7D-95F42E43E7EB@fb.com>
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:91::39) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.115.171] (2620:10d:c091:480::65ce) by BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.7 via Frontend Transport; Fri, 6 Mar 2020 19:27:47 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::65ce]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d50bf8c8-75eb-4f60-3815-08d7c204744b
X-MS-TrafficTypeDiagnostic: SN6PR15MB2239:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2239730E2E5F72F7A6FC5BC6D3E30@SN6PR15MB2239.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(136003)(396003)(199004)(189003)(4326008)(36756003)(54906003)(6486002)(33656002)(316002)(6916009)(186003)(5660300002)(52116002)(16526019)(53546011)(8676002)(81166006)(81156014)(8936002)(66556008)(66946007)(66476007)(86362001)(478600001)(2906002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2239;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7LwsFbAGkt4KCb99SfM1FD0bwqM14KMPynvhAQEtbwH+Tbl6Xq3mnRdjiO1IX3XUsbIBOMTxjE/WWhtxmQ05zOymW1ez59tMHYt6h8KucusUJdhnmyvA8c6RCVBuDjnsNVciZ6ZMgwoNQqkXF3R6lZqdFdzLraBgxztUUf3KMebmurdnyDHw+N9eEWZXSzWNV8CFOeUSD9shj8xKHRTWrzXTIqX/y+nWPNhBGbZYPl4ZYtYaYLVPFwxpao9gH9Wwl8NGEEbQPRWrLH1Xmh5N9KCI/zIDJ4E1XMr7U166IooVd7llcIGm9200MWv/rsOio7wiG7he4X+pOB7RnmSweSHTQ8AxXrOkAuJW0jbrH97b7oBDQZFXlusNiZX+m7Etm/DRUvO4MAndrQ52ZA+oRuvxM9zz6szIQ/0rpf3mXUXN8w5rBPLww+qlhYS/sCb
X-MS-Exchange-AntiSpam-MessageData: WU+os3gmN9OSjJly5FmpwF5rN71pzopdJUB3K4tyxZiW38qFiyGpp2ic4h3+on72g4hRV9PG9NkaEO072Kiu6l0WinhsfdRLFJUL02M7MONYIACkvQMIOW3C1k7Jwr41J4RFTmHsLwnk2LyT/hj4ScTBasEIppNINXgRDwbgdW4=
X-MS-Exchange-CrossTenant-Network-Message-Id: d50bf8c8-75eb-4f60-3815-08d7c204744b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 19:27:48.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frxghS7XmfzzqqSxQ95B4ghvKsxUaw1fuZXeD8yfHaWdkfHzFjulunK+T5Or0Tj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_07:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=615 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6 Mar 2020, at 9:35, Josef Bacik wrote:
>
> Many people have suggested this elsewhere, but I think we really need 
> to seriously consider it.  Most of us all go to the Linux Plumbers 
> conference.  We could accomplish our main goals with Plumbers without 
> having to deal with all of the above problems.

I think James and Ted have covered pretty well why Plumbers isn’t a 
great fit, but I agree with the overall idea.

>
> 1) The invitation process.  This goes away.  The people/companies that 
> want to discuss things with the rest of us can all get to plumbers the 
> normal way.  We get new blood that we may miss through the invitation 
> process because they can simply register for Plumbers on their own.
>

Lsfmmmbop has always been most useful when focused on smaller and 
tighter sessions that aren’t well suited to open audiences.  I think 
the BPF and MM sessions are generally really happy with their size and 
level of discussion, while the FS one would benefit from a larger crowd 
split up by project.  This is much easier to do if we’re attached to a 
bigger conference, where the plenary sessions are available to the whole 
conf and the breakout sessions are smaller and completely project 
focused.

I think we’ve outgrown the original name, but I’d still call it 
something, we’ll need rooms and t-shirts and maybe a group event that 
we need to fund.

> 2) Presentations.  We can have track miniconfs where we still curate 
> talks, but there could be much less of them and we could just use the 
> time to do what LSFMMBPF was meant to do, put us all in a room so we 
> can hack on things together.

Agree here, although kernel recipes is a great example of a conf people 
visit for the presentations.

>
> 3) BOFs.  Now all of the xfs/btrfs/ext4 guys can show up, because 
> again they don't have to worry about some invitation process, and now 
> real meetings can happen between people that really want to talk to 
> each other face to face.
>
> 4) Planning becomes much simpler.  I've organized miniconf's at 
> plumbers before, it is far simpler than LSFMMBPF.  You only have to 
> worry about one thing, is this presentation useful.  I no longer have 
> to worry about am I inviting the right people, do we have enough money 
> to cover the space.  Is there enough space for everybody?  Etc.

We’ve talked about working closely with KS, Plumbers and the 
Linuxfoundation to make a big picture map of the content and frequency 
for these confs.  I’m sure Angela is having a busy few weeks, but lets 
work with her to schedule this and talk it through.  OSS is a good fit 
in terms of being flexible enough to fit us in, hopefully we can make 
that work.

-chris

