Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2032B59A7
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKQGSl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 01:18:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21510 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgKQGSl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 01:18:41 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH6G2vU032216;
        Mon, 16 Nov 2020 22:18:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=J2+DwgyuJf402HwxGALgcmzpMC/AYk4sg65k1+LJAIo=;
 b=FW6FAurdujybhwkS9QvevsGq9UcDcX3Em2vK7DOsAV0l1MM6NE1ZsomOcEi6WfuXtRV9
 5EPirgyV9rTMrQItntgN9bN2jZvi9UJAuRQzNSseSi6Kq0Va+K8BDkQ7NxRRkjBxTQtU
 wU8r4G3Z1sgS6IhjcPRSmMA9MZZzbiZauOo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34v7wf093t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 22:18:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 22:18:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTRvei964TXGzNtP5X+lHjKB+CoZ69Ki/50RCZ6DwhXZUgAyXdQq4lsz33F7URJ7+4VkOFJe/epHjiJY992jNH5wGZXfCPkZAjA2+4vWvfojJAnaLzHwF36VeaGOpy/3kml/AORIDiwMT9N2P9QQGdD2SEJPVWOPjA0gwRIawuiyOjBJq21/Bk5o2Y6QorYDF6RCwUQlqeQOOvOX2CJyKJ7KMh3zj4+pxEYwytj8C9VYvXqQml3ss+5dYP38zzT+6/UVt9ugxGjEdVTPvE4RC/OLANPvJisX0wAX1KO0Ankog13qE0/Kvm9RcvcSCOj3ngCNSy2cFyepcaxDgJRgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2+DwgyuJf402HwxGALgcmzpMC/AYk4sg65k1+LJAIo=;
 b=QrjjlZshOT6h0EU38zKTVOCCn70i8Sbf6FxO+3bd+T/T2e/5lzzt7kowyMXenN/3b2Mxmiqyz7fvj1WeZ3wTOfuVnxRDcIgULaXjWZrYsbKwAJ4eVBs97j/Zj8H3AED0Q/LfCxh+ym7UK3/ofU0qeunEa6aBjYyqYzCaSukn1eZfaYaBf8E8CFLEb65ahudjhwBh9KzYatIx9C9DqGYGyzmqZJEXKTGi0Iz8GdTMzLmSvQXdqwCJovz+55ppdqh6C/oApJb0osFja1+8gBvef8KBYt0zIafMTkPtaDaWJCzRH05gxHz3O5qkvvmj0mAztBu16pecOkZnyGmpl4dxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2+DwgyuJf402HwxGALgcmzpMC/AYk4sg65k1+LJAIo=;
 b=cIA63DlIvb4Eo0mSAfQ0qur1OFomFIc/PU5MeTBkgocNWLnJbR3VpsJs/7On73Qz+tJE5DvORFdFrUGau6fzgigXe96P0KwawP8mWls4GYKpiiEBnnoLkMNY6R6NL9eDwoE3O7tewTpK3Z8UkbTyvc0muIu/Yruc+3rXe3yzs9U=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2824.namprd15.prod.outlook.com (2603:10b6:a03:158::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 06:18:23 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 06:18:23 +0000
Date:   Mon, 16 Nov 2020 22:18:16 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
Message-ID: <20201117061816.z446lhcdjkuswtmg@kafai-mbp.dhcp.thefacebook.com>
References: <20201117021307.1846300-1-kpsingh@chromium.org>
 <20201117021307.1846300-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117021307.1846300-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:8f7f]
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:8f7f) by MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Tue, 17 Nov 2020 06:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80915a86-810f-40af-bbb3-08d88ac09614
X-MS-TrafficTypeDiagnostic: BYAPR15MB2824:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28243D02EE320824C04B70D9D5E20@BYAPR15MB2824.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYZVUPmMLQS5hl6etQNbuxJiifjoPH4WpiJ/0UWu8hSVZZ0+50nGBtZpmn6Ev2z7AsDhVWvvQJdTuVTMgb3YOzx3Sm0EeGRqHxAjQiKASYj+866cDF/FZAN0La7ZWefsjGOFLMTMplf/ry2Yzc4zfcjY/XXZOXOM4DIvSC4J6ddlcvQHMOWDvNaMRE1GAzcbVOYElrZI1fErV8W7PVi+6s9aSofeaa2RQKPzgvju6RbJXceIxGc94XAWHw9GfhmAsiroQ0uqi8REKE75Bq7qzq4QyqLyUys2zoNN2yjF+4jYCkeJqNSky5XLPuaSirPVNh01d5EgtIxu1AWNcl05bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(16526019)(83380400001)(6916009)(186003)(86362001)(4744005)(54906003)(316002)(52116002)(7696005)(55016002)(9686003)(478600001)(8676002)(2906002)(66476007)(66946007)(66556008)(8936002)(6506007)(1076003)(4326008)(5660300002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zD9x+WWvy2dj8bZVLrN6nCD93rAQWrx9fksIK1TlEtVNHUtZNSkcsIxmdtu3yVYycCpf/C4KNx4mDD9JBnZYWdn9G6FWyiTYkLuJj0lQkRN2BTT7yof6OEg7WsBnS2SLkFxHLSNTaRuKSzJDOcl62SPSY4KOA1Od5bSm3IKsyAlNd6kqfMr6QPTIHsxUvo8Q0joGDSzRG10qAdyrTTL+2QjDZ1YU8ArdUXJbX/b9TGz064oWgDCMs6sOYSM252RVaPPo7NM/6ceEtS38LiypDizLVUJUv0uOTjFtCGVywTXCvyj7P/9uZ9ZulnmWzKf82eSUaD+sS+3IeH4omBP4/j3HrbMKFmV4eRZtwP8GyjdOxmJlUNPQ4FmJGO4HrwD8afaoQ+g3jOcBpIQLUKP0SZu8PiCtIJcgHCe2FXQVlh7p7+2t/p2IHxltnCvAcOn8Oim/sKTnmniasjctjIvp41hySqlX4eOit9A9qqod7u5fNFRi/CgU3tTwtpcy1j9ATkGM7gtTTclsL7Bj1V7wFSWCEWhwrf9bE1IAlI3MeHjjLKThkPXteQMEcSKNE1PG97gyydqT2DRtzv3AA2Vu4T8VIBPwSN96aqjKgmu9Ii6WPuiIradXxGcppGwEf/YSu4jhVxNBnjVF9RWMf8ufjUrdQ9RY9BlBBl5d9hwKDbbxkXu8sFPSGU7LdXVevm3QMB8/5Z/xhbxPGcutrN/Xjz8qaUdkNslE4MGYzpb82LV2sDs/obSvMIZ1y12A5p2jU8CD7VDQv2eGi0trk2tE3o62/pDKmDSV/SvBtDUuZFXogg2QpjemPW6dMuk7qk/2e6DFHe6JrG96oLpd28fT7BoCGZurAWUzoFyH0FNpUPBG3cypdk183Tkf9M/8PEtGgzEyh+FHTgFkVjDAD1j082UOgnrL+Hc+PevPmUWSi9A=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80915a86-810f-40af-bbb3-08d88ac09614
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 06:18:23.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MysuKV89sz/V45/I28XPk237xBA47UIHCo6fu67izqZ4+L5EVrCWUAYttnQwU+9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_02:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=1 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=959
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 02:13:07AM +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test forks a child process, updates the local storage to set/unset
> the securexec bit.
> 
> The BPF program in the test attaches to bprm_creds_for_exec which checks
> the local storage of the current task to set the secureexec bit on the
> binary parameters (bprm).
> 
> The child then execs a bash command with the environment variable
> TMPDIR set in the envp.  The bash command returns a different exit code
> based on its observed value of the TMPDIR variable.
> 
> Since TMPDIR is one of the variables that is ignored by the dynamic
> loader when the secureexec bit is set, one should expect the
> child execution to not see this value when the secureexec bit is set.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
