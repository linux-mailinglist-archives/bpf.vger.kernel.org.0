Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3553723BDB2
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHDQFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 12:05:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHDQFc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Aug 2020 12:05:32 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074FuRhf020805;
        Tue, 4 Aug 2020 09:05:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I4uaV73PDIWx7YXN6UEMpusrqqS6tGMhalQlumBdBqI=;
 b=JWD+26L9gBJrkBbbXWcFYui4+rnN2MEnhQbBlEdyCCsiPiYpo0mHQNigxlHF+ZK1Mxa5
 h4PgSKAyDhsMRTsPnZ/cgLPliAxZMZw7dKA6GhYIW8jcMeOooHwVziPNLoFr555yuEew
 ku7AVp3M+2KEL4akayHFU4Fxv5mr46/eHM8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32nrnp2ucx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Aug 2020 09:05:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 09:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+NkUAgeD3P2hDwjXaAFox/AnRSlU6oAYBo5DB07j548p1VLa3kQTA0vqDZBFODuDyd5GRpLH2yuWGEsK8MItE6nJR7ijkIKbfoVRS5naD9cJMVhOCpJ6CHGkPeav9tijR77DghaecLpP2O6jW7JryRO9uiprF+n595L6FbnZj5bDtQMrQkahD4nc23qSIyWZSlYWuZG3T5zdOAIHDPHJEpr6MqHcIlENVx1Q3/fC0VOYpB/FLQrGblgOyzfea/xd+xOkHiwY0elBqxwCHJxAD/pnKJA9IwOKU6fm9F4wZY53WNGLdcCPcxoQDybWXZ6XD4zg9vkZByHj+iZiVwHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4uaV73PDIWx7YXN6UEMpusrqqS6tGMhalQlumBdBqI=;
 b=l/2z/54DRsprCKbdDz1Oo3yJC9iD51bhPwKhTEEIr3uL9D1/pdvpROQSriSWfAXIjzZuSU9LuLZ7/RdEIyBQrqEWPpam+nKjfokSwawkh+ze39BlrT8dycRCzM+eS1Eqcy9MUS97JDuTTKWUAlif5Or1JgCKyHP8JLd4oHYrGJEzxmHHiea6KJUr3gxDdptmfgS2vCReeteGvxkkI8cnn5lqpgPFPw1JW6694xn1/iFUglKNx8LYvfBqFiwi1xsmFRGznipwX2wA71uADjyNGkA9ZCSLWCnpEU1oU2wrrCHsKOSBd32X3NXrN7zyvXR82zdByBhYQ+KCfvFqzFNBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4uaV73PDIWx7YXN6UEMpusrqqS6tGMhalQlumBdBqI=;
 b=TmvJtugswRbtzmS37bXmiaOcb4XnIHtwsBH4NJLM/0cPICqAIeiCHp1QgJ1Euwv1M4ZD6XH5kdI7S5itQ0TyRYvvLAzTrjsQDX5xFZ5wp/yMPKQyKz5eCKT61NlZda8zZP0eQb97pp8PkiJ3taUwFH4ZjuoDGeKcbI5y2/T8ngs=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3048.namprd15.prod.outlook.com (2603:10b6:a03:fc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 16:05:13 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 16:05:13 +0000
Date:   Tue, 4 Aug 2020 09:05:08 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: BUG: Invalid wait context in bpf_sk_storage_free
Message-ID: <20200804160508.auvw56y5ayd6xbia@kafai-mbp.dhcp.thefacebook.com>
References: <CACAyw99CPB-9bDdvodkYWA6Wwjqov+WkZ-5TZetmfuE3Swe=EQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw99CPB-9bDdvodkYWA6Wwjqov+WkZ-5TZetmfuE3Swe=EQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:1f75) by BYAPR06CA0043.namprd06.prod.outlook.com (2603:10b6:a03:14b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 4 Aug 2020 16:05:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:1f75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb3d43f3-fbdd-4ad0-f643-08d838902ba8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3048:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3048404FED36620A8A0E78B9D54A0@BYAPR15MB3048.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iuX+ghxbcR3CNMx4jIaiXFmDrAN7dUC5X28pzlSWckiAysS1+p88MvpuvLB9Fn8coNa8PYjS8Y4Rb+c3ZESJ6dB7F15tZX5nPb1Ra0fZWx/uVtJzGqv171tzwfwmndfydctrxftsMMFfRITnwDW/cWs0gwP3APP7qq2G2G4GkavmcjfQcxgU0VVOBPYvI5u/19SIKt7QhgjVyrI2RBAcQslxtcdDxksJmUGNk+brV/OQ2gS7LL0XnRolPKsLgZ0iYabzDjLzF2/8GGYctSiIuGAWzk656ahyORhHqjgLNF6sPj1FcIA96byM3x+tIDpTBpqoegq0zxELIfEr1BvQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39850400004)(136003)(346002)(376002)(4326008)(6916009)(6506007)(6666004)(55016002)(86362001)(83380400001)(9686003)(5660300002)(2906002)(8676002)(66946007)(316002)(54906003)(478600001)(8936002)(1076003)(66556008)(7696005)(66476007)(16526019)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rWXVsDbZRLpaEe4jj+D7iNLov8gAWuRrsi9RuIrldGvTChhXkn9y5S6TzqH3Zu5T1nj+mTXGvxW9jz5AjZJ2Ac2JZXSC49rlbyFj+YvHR9DWg3PCNpT7vmqXv5i8XfA0xZRb7njlYVOk1ejlnYK9fM5qmfVakVvBgTudcrlUAalYEnkzZw0eFqnR5Y5Nwfl98DGJRtc9MUbVVy2rNSWdYbOH1J2ldKa6onpnjj1OTyrytF40U7+Mav7bzPA4BGiIDxv4cg/DtpPhJPIPdZwpRBQNLG9ypkXXPreAlWeZWDu6qT/kygJq1WeMpvHuWyBpQ8kyU+XzCyV4J1G3jsbGSs+dX3C15q7G2V9O/Hb00ibosLS7RTIB62G9XkrtoIVMb7RQ/47vog+5fwgFOyPFw5GXKQnNZvJ4OqzMEEQtZyNvrP28wAZ7z7j6PbXQMUumWUFucavaVGj46/sr9SAapRBMRE7f0NDj5nUvJlwdWJHhHnrMfnUKcNBDKWYEm8rIZLaliByiFfvU2F+Tg83ashCf2JVcJHoL/+7mDi4rykDr39NYj+Qu0q8S+Ennp/OuEWZiT+3E5VenVMFt/yD6Dcxz+T4I/fr0BZjf1kFkDGCO1m319GCFm5xUhey/fsJBR2vX0myGpY8CkGPOhmfdhT0Oo+URfLpaZKrCavCz4Qz93jAYRnj8LZXrqyvZ8EXt
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3d43f3-fbdd-4ad0-f643-08d838902ba8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 16:05:13.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrVUG64S0dfl8L+xFNvDdqcrSwy0+lyVDTgGheWg/rgJGH//NTTa/LUzZ04lMSGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3048
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=5 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 04, 2020 at 12:21:01PM +0100, Lorenz Bauer wrote:
> Hi list,
> 
> I just got this warning while running test progs on commit
> 21594c44083c375697d418729c4b2e4522cf9f70 in the #4/22
> bpf_sk_storage_map test.
> 
> [   38.775254] =============================
> [   38.775692] [ BUG: Invalid wait context ]
> [   38.776234] 5.8.0-rc6+ #35 Not tainted
> [   38.776699] -----------------------------
> [   38.777141] test_progs/254 is trying to lock:
> [   38.777650] ffff8881197f4450 (&krcp->lock){....}-{3:3}, at:
> kfree_call_rcu+0x1a6/0x5b0
> [   38.778589] other info that might help us debug this:
> [   38.779155] context-{5:5}
> [   38.779476] 3 locks held by test_progs/254:
> [   38.779944]  #0: ffff88810dc3f020
> (&sb->s_type->i_mutex_key#6){+.+.}-{4:4}, at:
> __sock_release+0x76/0x280
> [   38.780957]  #1: ffffffff83d66840 (rcu_read_lock){....}-{1:3}, at:
> bpf_sk_storage_free+0x0/0x2a0
> [   38.781878]  #2: ffff88810b6940b8 (&sk_storage->lock){+...}-{2:2},
> at: bpf_sk_storage_free+0xa3/0x2a0
> [   38.782812] stack backtrace:
> [   38.783115] CPU: 1 PID: 254 Comm: test_progs Not tainted 5.8.0-rc6+ #35
> [   38.783789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.13.0-1ubuntu1 04/01/2014
> [   38.784711] Call Trace:
> [   38.784976]  dump_stack+0x9e/0xe0
> [   38.785429]  __lock_acquire.cold+0x3a6/0x46c
> [   38.786025]  ? register_lock_class+0x17a0/0x17a0
> [   38.786588]  lock_acquire+0x1be/0x7e0
> [   38.787010]  ? kfree_call_rcu+0x1a6/0x5b0
> [   38.787421]  ? check_flags+0x60/0x60
> [   38.787790]  ? mark_lock+0x12c/0x1470
> [   38.788179]  ? check_chain_key+0x215/0x5a0
> [   38.788613]  ? print_usage_bug+0x1f0/0x1f0
> [   38.789036]  _raw_spin_lock+0x2c/0x70
> [   38.789415]  ? kfree_call_rcu+0x1a6/0x5b0
> [   38.789829]  kfree_call_rcu+0x1a6/0x5b0
> [   38.790239]  __selem_unlink_sk+0x1eb/0x520
> [   38.790691]  bpf_sk_storage_free+0x118/0x2a0
> [   38.791138]  __sk_destruct+0xd3/0x4d0
> [   38.791525]  inet_release+0xf4/0x220
> [   38.791939]  __sock_release+0xc0/0x280
> [   38.792328]  sock_close+0xf/0x20
> [   38.792676]  __fput+0x29b/0x7b0
> [   38.793004]  task_work_run+0xcc/0x170
> [   38.793429]  __prepare_exit_to_usermode+0x1c6/0x1d0
> [   38.793948]  do_syscall_64+0x62/0xa0
> [   38.794407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   38.795004] RIP: 0033:0x7f73410e33d7
> [   38.795376] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
> ff ff
> [   38.797266] RSP: 002b:00007ffc86615fe8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [   38.798030] RAX: 0000000000000000 RBX: 00007ffc86616040 RCX: 00007f73410e33d7
> [   38.798755] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
> [   38.799488] RBP: 000055fa708beb60 R08: 0000000000000007 R09: 000000000000002c
> [   38.800241] R10: 000055fa6abd508d R11: 0000000000000246 R12: 000000000000000d
> [   38.801007] R13: 00007ffc86616034 R14: 000000000000000c R15: 000055fa708bcb30
> 
> Not sure if this is useful or not, a quick search in the mailing list
> didn't bring anything up.
I cannot reproduce after running test_progs -t bpf_iter/bpf_sk_storage_map in
a loop.  Can you share you config?
