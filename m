Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045DA23C290
	for <lists+bpf@lfdr.de>; Wed,  5 Aug 2020 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHEAUp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 20:20:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5328 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgHEAUn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Aug 2020 20:20:43 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0750JOKA027488;
        Tue, 4 Aug 2020 17:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pGkph6ZFvX7CF26S2Mz+lDFnOmMAkbmM/Scm0toWwFc=;
 b=gARZHrZkLpBKQzfZbu/Raob+yKjk53nJ2IjQzGMbPRP/Am7dELpjaCQxo2aUa2lw8mXc
 148xM8hsNocI4en9TW2igPcsqMnE6zb3CEcr0q6/5qWFu0IMTl0whZE3Uic48Rz5QYC8
 MBRLzJytaEVPhu0cZNR3NtLYok9wTPF56KI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32n81jqfsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Aug 2020 17:20:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 17:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTqgSsFeDTb3lUrbx8L9bZCxJAdfbrqllrdBj64KYwZBxn1E807wJeBYycdodXRE+HX6OHDJmmCMQWStYjr/UYKliRFiyn3nlGmiH0zLW+ZTvYTvTzHNBXpBqUB0GCEvutVW5KTHzTE3Aqocqm9VhmoZohzTA9UySuEwK6lJ3rLPklFOuY4wcopD/ZgD26+VAXY80384NIMtMjozMOPepLTy1gdmy9KjMK7woiYJ67VzeX3uHSc3MsI3rb8DiKQ5AiFLgRZxC/dTVC3MhgpxWzBWMgAABJDk0AVvDRrkqkSlmUKHHguoPEBJd+62xPDDe2+r1b5PT+gGqXKbslLTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGkph6ZFvX7CF26S2Mz+lDFnOmMAkbmM/Scm0toWwFc=;
 b=KG+EJLAnq4RdZArnm6gC0nBOFPXOVJRD/G1LLQXk0QbMwOXoNn6VJ+2+QByquiCDFuC/gRtPmzUKf16qtFXleGgVQ9UENuIp5ha5KNcZj/Ths+McJ6MC7qQGeIPrlQH+Ma919LZ+BmJPgZEeGvEDtaTASaJ44aaulkI8Sez3mawP62tUAHTIo8Ag/POVvYDpz6Utvmg36oiaS7Q/bhOWVhXaNBKko/yRse8DMpKMahQz42lIIR7r56QHe3VGy3Og4qxitnAUEdFuXlk4CD4VdQth8Y0TfXM3MnY9zcPiXtVDQY5WhuBFKJoHhY71i+X0GiprkrszSCxyfQeeVggFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGkph6ZFvX7CF26S2Mz+lDFnOmMAkbmM/Scm0toWwFc=;
 b=goiHmT/ZH/LNzTYKAlcdUwefgZOxT6vNUqPhacAT4Waa1v3paiOc4y7ou0OLTeyPoIPJOKfet2/JUJJpamzZcMu/aQ2SqdxaH+u1RC9665SAXzqoMWOoUuLgZpWSX8OT1rJA66E0dMFRrymkdTPTk0Y9+JczsYTYUCv7vEe9k1E=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2565.namprd15.prod.outlook.com (2603:10b6:a03:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 00:20:25 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 00:20:25 +0000
Date:   Tue, 4 Aug 2020 17:20:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: BUG: Invalid wait context in bpf_sk_storage_free
Message-ID: <20200805002020.sq4qavce7kml5irk@kafai-mbp.dhcp.thefacebook.com>
References: <CACAyw99CPB-9bDdvodkYWA6Wwjqov+WkZ-5TZetmfuE3Swe=EQ@mail.gmail.com>
 <20200804160508.auvw56y5ayd6xbia@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw99tB_8TyGR9apOjXuWSZ5-kEeMZNSMvUbPviGq4ECAAuQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw99tB_8TyGR9apOjXuWSZ5-kEeMZNSMvUbPviGq4ECAAuQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f057) by BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 00:20:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:f057]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c60c9f-8c2f-463e-5fa3-08d838d55973
X-MS-TrafficTypeDiagnostic: BYAPR15MB2565:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2565D1A3EF370BABCEEEFAEBD54B0@BYAPR15MB2565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rugDyB72ORAmH5+apzfW6z8JeRwrq4Tg9Dz3PGdXDZgTKA/KKGRhCWYevLB7bDtx3IH3U7Noa2XeE5f6UKRCprlqL1E52cKc2xWby4tSecKWWwufgLesNYrSf7pFzSSGBtOzvgAIR2SOSiD3bXvJMN3ae5DBKPRwy7dMWHagTojWcSlafOvqCThTtE4+B+MgbvCjQyrqtUyoNyVmkkFnWCYb3aVC2/BtoO3HK3E1+ZxrV/ggl9/zcKCSpo7QoeCr9+flzCG6nWa7h8HSk+62OQUjrD208G10nJ0y9za8rnkZ+Jq1at9W3IECsjK3vqRm77LSjFd19K7EZv1dXehb0vO6Hr1Cm3kmHHLdUn55IvTNKx8bgWnGdQQdC/9RBqGuiv9VbZoUEOpqlHqxJUJVWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(136003)(366004)(376002)(66476007)(66556008)(66946007)(8676002)(8936002)(478600001)(55016002)(4326008)(9686003)(966005)(6666004)(1076003)(54906003)(7696005)(186003)(16526019)(6916009)(6506007)(86362001)(83380400001)(5660300002)(52116002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HYkfJZ15879q60pZCRdRR/Ea9eDJE++3xy/JNSEzxBFZHyB70as3HGpsCLlUbcQMmhE3Wm/twyn2O2rvJylu5ZweTdgZmQ9OjbbA6OcmylKy3grG5a7lBojndtK35kD4y+3xbMz9Q8pBK8hviWADY7z7z/25AafmtWk74c3fp1NsPJOWfTOqbM3o2rt/65f0tZQEUzHrp8TyhIxMm369UopYB3CRp4ZfIprZksCpUTUfowe7z4VSLUn4xLFhwPSoruh1oOvMRIbEe7/8cGGpWK3QCQPXAqMzmf5YhHL20WtqJ/gBzjqqlIbvkxaGlHn6D6UUGvnHxYijU/5xkd3c/VCGUO9EWn2m3FXN9mF4v5gVqIIjF1/mAfwwfRBRTWeyB3pbPN6IPiPJvgo2MsYlP0KMUHUE6EpR32y8bCP3zsJiBBnnZR7BofFNn4ZLHOuQR5kf7+S2d7Br5tc/ZTGRVdC5Evc0fcJ10Fum2WRb9PhH6jHjKRxJSCq0TNtoUDyTDA2gHSPL3PGQGIS2a3AadaMxfYlJeCUumn78pYoJAhkFhs9XrqKCs1iQgLxufSbm36g7uYUmznD8JB/dFH9ZthyTcRnom2F2Es/8BX2f13ZDZrAvxPMieXRwfAf32d8BGS/qF/A6/uqgj2IXnnpryutXkEHiYtoCIlkDy3AzDMQLrluOFf4QNBXMMGXNTAOr
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c60c9f-8c2f-463e-5fa3-08d838d55973
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 00:20:25.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEghMDqz9zlUwQ/tPOCcglTvwggtKs23kx39fA1PR3AOxuNk78X/8b/gFdXS69pP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 04, 2020 at 05:45:43PM +0100, Lorenz Bauer wrote:
> On Tue, 4 Aug 2020 at 17:05, Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Aug 04, 2020 at 12:21:01PM +0100, Lorenz Bauer wrote:
> > > Hi list,
> > >
> > > I just got this warning while running test progs on commit
> > > 21594c44083c375697d418729c4b2e4522cf9f70 in the #4/22
> > > bpf_sk_storage_map test.
> > >
> > > [   38.775254] =============================
> > > [   38.775692] [ BUG: Invalid wait context ]
> > > [   38.776234] 5.8.0-rc6+ #35 Not tainted
> > > [   38.776699] -----------------------------
> > > [   38.777141] test_progs/254 is trying to lock:
> > > [   38.777650] ffff8881197f4450 (&krcp->lock){....}-{3:3}, at:
> > > kfree_call_rcu+0x1a6/0x5b0
> > > [   38.778589] other info that might help us debug this:
> > > [   38.779155] context-{5:5}
> > > [   38.779476] 3 locks held by test_progs/254:
> > > [   38.779944]  #0: ffff88810dc3f020
> > > (&sb->s_type->i_mutex_key#6){+.+.}-{4:4}, at:
> > > __sock_release+0x76/0x280
> > > [   38.780957]  #1: ffffffff83d66840 (rcu_read_lock){....}-{1:3}, at:
> > > bpf_sk_storage_free+0x0/0x2a0
> > > [   38.781878]  #2: ffff88810b6940b8 (&sk_storage->lock){+...}-{2:2},
> > > at: bpf_sk_storage_free+0xa3/0x2a0
> > > [   38.782812] stack backtrace:
> > > [   38.783115] CPU: 1 PID: 254 Comm: test_progs Not tainted 5.8.0-rc6+ #35
> > > [   38.783789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.13.0-1ubuntu1 04/01/2014
> > > [   38.784711] Call Trace:
> > > [   38.784976]  dump_stack+0x9e/0xe0
> > > [   38.785429]  __lock_acquire.cold+0x3a6/0x46c
> > > [   38.786025]  ? register_lock_class+0x17a0/0x17a0
> > > [   38.786588]  lock_acquire+0x1be/0x7e0
> > > [   38.787010]  ? kfree_call_rcu+0x1a6/0x5b0
> > > [   38.787421]  ? check_flags+0x60/0x60
> > > [   38.787790]  ? mark_lock+0x12c/0x1470
> > > [   38.788179]  ? check_chain_key+0x215/0x5a0
> > > [   38.788613]  ? print_usage_bug+0x1f0/0x1f0
> > > [   38.789036]  _raw_spin_lock+0x2c/0x70
> > > [   38.789415]  ? kfree_call_rcu+0x1a6/0x5b0
> > > [   38.789829]  kfree_call_rcu+0x1a6/0x5b0
> > > [   38.790239]  __selem_unlink_sk+0x1eb/0x520
> > > [   38.790691]  bpf_sk_storage_free+0x118/0x2a0
> > > [   38.791138]  __sk_destruct+0xd3/0x4d0
> > > [   38.791525]  inet_release+0xf4/0x220
> > > [   38.791939]  __sock_release+0xc0/0x280
> > > [   38.792328]  sock_close+0xf/0x20
> > > [   38.792676]  __fput+0x29b/0x7b0
> > > [   38.793004]  task_work_run+0xcc/0x170
> > > [   38.793429]  __prepare_exit_to_usermode+0x1c6/0x1d0
> > > [   38.793948]  do_syscall_64+0x62/0xa0
> > > [   38.794407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [   38.795004] RIP: 0033:0x7f73410e33d7
> > > [   38.795376] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> > > 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
> > > 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
> > > ff ff
> > > [   38.797266] RSP: 002b:00007ffc86615fe8 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000003
> > > [   38.798030] RAX: 0000000000000000 RBX: 00007ffc86616040 RCX: 00007f73410e33d7
> > > [   38.798755] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
> > > [   38.799488] RBP: 000055fa708beb60 R08: 0000000000000007 R09: 000000000000002c
> > > [   38.800241] R10: 000055fa6abd508d R11: 0000000000000246 R12: 000000000000000d
> > > [   38.801007] R13: 00007ffc86616034 R14: 000000000000000c R15: 000055fa708bcb30
> > >
> > > Not sure if this is useful or not, a quick search in the mailing list
> > > didn't bring anything up.
> > I cannot reproduce after running test_progs -t bpf_iter/bpf_sk_storage_map in
> > a loop.  Can you share you config?
> 
> Here you go: https://gist.github.com/lmb/0f19df936b296df34e4cb90dec6c3032
I can reproduce now.  The splat is from the "CONFIG_PROVE_RAW_LOCK_NESTING=y"
in the posted config above:

config PROVE_RAW_LOCK_NESTING
	bool "Enable raw_spinlock - spinlock nesting checks"
	depends on PROVE_LOCKING
	default n
	help
	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
	 that the lock nesting rules for PREEMPT_RT enabled kernels are
	 not violated.

	 NOTE: There are known nesting problems. So if you enable this
	 option expect lockdep splats until these problems have been fully
	 addressed which is work in progress. This config switch allows to
	 identify and analyze these problems. It will be removed and the
	 check permanentely enabled once the main issues have been fixed.

	 If unsure, select N.

There are known issues in kfree_rcu() in PREEMPT_RT.  My understanding is
some of them are being worked on, e.g.
https://lore.kernel.org/lkml/20200624201226.21197-2-paulmck@kernel.org/
https://lore.kernel.org/lkml/20200803163029.1997-1-urezki@gmail.com/
