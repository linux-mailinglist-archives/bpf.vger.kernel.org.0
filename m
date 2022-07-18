Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA357899B
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiGRSeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiGRSeY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 14:34:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230E3A8;
        Mon, 18 Jul 2022 11:34:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IHVd5u024475;
        Mon, 18 Jul 2022 18:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+omK/eXw0klz501Z2FfbJvn7084lSW0MPcPzYqwzhto=;
 b=UCUY268N5r2XIZ8X7st9nJIaJFoj/KzFaZh6LF7h6pnYPXTAs8trWlpwyK69DR7bmDbN
 +E3tUOun4DFikzFZN5r5LaQ4JLK5uc902avPOJBNmRTi6dsme/mhXdoSXVUS60dj1qX5
 +6jGYT8lyXmu1Kbzf1DL7kY8qEZh4ch51BkVslF11imJckKmPvAt96eozyRv1b+ypeGH
 fqdzkH8l/hujidy9I7jSLaqQ6IqNrp4YhOWlqpkC5LpRDbMgIxiljnv/ZIZspQQHQ55e
 X42dCh9fa+FZ2X7Mr5AugNBcvglNThN+uKhcDJX6iuokLBDad+ih5n+UKm6XACeEUbnD FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42c6q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 18:34:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IH6oV2006429;
        Mon, 18 Jul 2022 18:34:00 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gft8rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 18:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOALEMdKGZygTEuDTfiDdUGQL8ED9aersLsNs3r0boGofPG3fGZShpIM+5ZF6Y+aJ4CosjS/EItpZJD7NpRTHbbADSscuEjVQy9YaV0eZhBo75lwQaTePa8zStzZhQLkqOoPo9QC6A/wWMqB3vFLlUsrEFfFYhExoeBrMB+vi34fBrGf5MLer8zmpQtuBV1IAPGYRWSwIsvq2Ncu7s5zIHlL1wl8KW6n7BUSwYGC3SCt0LXcCYLvSlRN3TXFEp6qqWG/C4AIbyRljgxgscNXmOl5djn6lxwYT0mhLC0BKvkUPSeht//w2Ml4wbqZ2ZSktuCjA4NPYm+wY6h5Wdx1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+omK/eXw0klz501Z2FfbJvn7084lSW0MPcPzYqwzhto=;
 b=ltdIksRhpfh0UsrpJTzr41vaO908mrOCU1UsXN0JXVCFAfBMui0zzayFaiJ3/Tb3MkLEYMSpHX4PMAzYmPIRwHllMefZ9h/OlfgPx8kFlEa482p4UhlKSmtR8gmnKbdesROAukG09F6lC+/Jy9yv4wNgbUS6KKoy6InbwiVDG+3eGARRxUx7uzsMoY2xMjPMDr/T8T5AYU0U7WhyN8dXyGWzpYmRYefCmpSPwaTVjW77oL+Nm+Ksn3yl+y0/mPxDwrVg4/o8J1pts46E2rDKFIotmdJHiZfJAvnuySe089hWllwUzySu9tvdfjDu+gYn0+35Fv3QESmk68BEVELtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+omK/eXw0klz501Z2FfbJvn7084lSW0MPcPzYqwzhto=;
 b=somSiezT4KGxFsfscPu4Bayq3H00DPWWFRZfcnV6NzHEp1mBBc5QPjxQESDbpxGxViJp2U0sAUhpwGI03R1CvY2KhGxO0UtVc5JORIXCL5YAoyge9UQXLRqy2s41QbS5W+dZmliUrnmRKviE0gh0ieas1QtPZMIRpmXCQtHPeKQ=
Received: from DM8PR10MB5479.namprd10.prod.outlook.com (2603:10b6:8:3b::14) by
 DM6PR10MB3577.namprd10.prod.outlook.com (2603:10b6:5:152::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Mon, 18 Jul 2022 18:33:58 +0000
Received: from DM8PR10MB5479.namprd10.prod.outlook.com
 ([fe80::a89c:4216:cf54:bec9]) by DM8PR10MB5479.namprd10.prod.outlook.com
 ([fe80::a89c:4216:cf54:bec9%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 18:33:58 +0000
From:   Russell King <russell.king@oracle.com>
To:     Ivan Babrou <ivan@cloudflare.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [External] : Removal of 128MB limit for BPF JIT programs broke
 perf symbolication on aarch64
Thread-Topic: [External] : Removal of 128MB limit for BPF JIT programs broke
 perf symbolication on aarch64
Thread-Index: AQHYmsMJIaCLkuSlxkSbEGKBDv2xn62Ec9jt
Date:   Mon, 18 Jul 2022 18:33:58 +0000
Message-ID: <DM8PR10MB5479F2B4DC247B7F0BC96860E48C9@DM8PR10MB5479.namprd10.prod.outlook.com>
References: <CABWYdi2NBSv8sUdFONrYyACa60+W6O3+r5D44OXjftxPySKTXQ@mail.gmail.com>
In-Reply-To: <CABWYdi2NBSv8sUdFONrYyACa60+W6O3+r5D44OXjftxPySKTXQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 25241ecb-f1bc-ab24-d0db-d31543708149
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e46e5cd-a223-42ef-20cb-08da68ec1410
x-ms-traffictypediagnostic: DM6PR10MB3577:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJAFU4tSEWmq/QLVVh1JunPC1uySA2vsfHrSdWgZGaPjaVvmEdTVr2RoefyxanMhLLkhYTfs3+QcRk4gTed8grgnus1ckazAQFJ3hKow7T1ZQjtaG5Bgl4ofZkHPYCwUBK0WQjkuxnL0iers8sUz9KHPk5egQyova4PLbmZrsNtfbGWnXZKaoAqA9QQ0y7D7vikbK7hFOdNSM4qQqI0Iy0O3TONnvfjXCD0jsZ7TfK6B3F3244MQ9tFrOXkgLFlX+/dZ2PMM73Ko7tepNvY4496sWjpdhYiuEaDoUGsO8mtFASe3rJylhT2ATsr/g1VfSKNLH+bzAKZ1OwN7bHc8DF2DOnQI/I6Ey+fpLv+yryYyFIlhdojTmg2o1Dk7Y2QAR5pnXnA9hw86+nEAy3IHzAlhGLXsyWT2CwcEcrs/2isgL9wr++sN0vB1j2J2f7/+2miIwl5OaD7pxLHCDSnLzTI2bb+xBNPPDwL8eKtcyMIw+U9z9t1CrIlv78JA0zIU2e7Cneiiu9MXlWNxiYDQN2eEdapbUqvEWJ2vlniTawo9md9e8aQ9X0WIoFRkv/v+t/JdEvZrH34LB7fTTOAjSXjeallj4DGFduBot6+LQZdZ1luIoCSCGFYHg+tDySgOelaKD3Mo+kYDiUKcIt+pRlLrNPdbc7r3xz0kZv4+GhrqFqcObbGbn3lbd0CkkEu+768oIv9Po09mlH6dfqvC58W6yVQz2JU8UvSU9JtW1q/3UKEbyHOolAUAhtn2Hjr2UTxcCXWmbUWVFxmaFoGtlMeZPk4TWCUd/seFSsBSyip5KfnOxgihwxV3FXQkINbj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(9686003)(186003)(83380400001)(41300700001)(44832011)(55016003)(2906002)(71200400001)(5660300002)(86362001)(478600001)(38070700005)(76116006)(64756008)(66446008)(4326008)(8676002)(66946007)(66556008)(66476007)(122000001)(38100700002)(52536014)(33656002)(45080400002)(8936002)(6916009)(54906003)(316002)(7696005)(53546011)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q9oNnp+oloY6xrGIREYjn9zLinNAcIXiycg4to54n2Rydfnda4moWUn9b+nh?=
 =?us-ascii?Q?u5SOsj0oJSesFr19sgmmikAHYZcA2Lj1ZtzllHl2xaITqs4EDhrP5xuD9igf?=
 =?us-ascii?Q?BPx2p00wcmIKulXC1yM/EXqYwVvlo94wjaJuGkKQH4FjNv6gZQ9xDS36XM5g?=
 =?us-ascii?Q?KsSGkRNDnXC7BO4G7CFOkX1EME9y/wj9+MG8gMN2ORsag2YaNSNYaboC+txW?=
 =?us-ascii?Q?JwIk4PnNoCUW8r2SmI6hV0/NAg7dhUc+vgBT9ZAFQ59vKrxnY1bt9yp5Yt/t?=
 =?us-ascii?Q?OINepUPotuUByrthxf9ixgGd4aEWVraiNw+3uTRDE8MfOCKZOrPSFBute3Oa?=
 =?us-ascii?Q?wIeEDVZipc8VwWV+qlSD4LQH3zkzZluq0M30XfHmPqBa5mao166MME1clqRP?=
 =?us-ascii?Q?fu0Nk1hSvOGoY1cq4zi+HGvCZkx/G3BA7o1RRdYoqns59yX1Uf3XrL9+y4UL?=
 =?us-ascii?Q?9zLvX66ZU3r7zbxSTQ3TV1y/I8ygp9ECYfeSefWhvcRNwOZz1ynSeVDqwvsP?=
 =?us-ascii?Q?xSqOavU2PAyCfJCyNRO3YTE3C+sHQPEvQ42/tSMDr4HHu7mesEa6nkJ3EOLQ?=
 =?us-ascii?Q?eyYMpS4ReOkPwa4omfusv2zKEI1/xuqBJuP/v220DL8DNfz1opud52pWazih?=
 =?us-ascii?Q?72tACpQuq7NvcmJegG8F1c805aM6tOMq4HtG0iMV1QolqZpOXSSSP3tc6me5?=
 =?us-ascii?Q?wOrT62JtnljBag4N6u5zIV0EJMFpMMNMTCfwqccZ+/iox9q/dfJLkKGlZj2R?=
 =?us-ascii?Q?XBgMKKG8HKw4W+h347QgjLOhKjOKa6vKVAiS1i9F20Fm8vizu284j9A7rCU2?=
 =?us-ascii?Q?WHGHlRkgHfLQdCIzEoSlDY3NmCDqOahZEXzQIOt41BAiFGs13D6wmvUgVUPE?=
 =?us-ascii?Q?HtbO5QKrMIDHhZ8J8ma53NQzhuB72fm36ADIrZa46+/AjjATQKAxPpdiy1dt?=
 =?us-ascii?Q?GDL8gT5HXRTvyV+TrllERe4JLzXUH2RR8x040eSNc8st7PM/+qFSJiDdT5nj?=
 =?us-ascii?Q?D81tovlCCRMEZlTYp83Gr/RNtNBDq8m2OTNCH5CQQ+IkYtS1bxURLE9fUcuB?=
 =?us-ascii?Q?YLEqnnTM74oG2VQs3FiQdL7bSyvAZozb/reivpOjRb2Kby+u85qmflRQO6Ag?=
 =?us-ascii?Q?UVfOSh7O9AxpDfR+upBda7I95uvCcBADLyNpsB6lgDWurb3ibWf8WN1h3oH8?=
 =?us-ascii?Q?4aLkUeNNQl1mLCkwwSePBEUExNyrefn8o0O43AKSTIZzaMC9z3RFOwqm8cxH?=
 =?us-ascii?Q?TkVYXkdFW6HQfAUYuz0IvSk4nfWLitYMeC1jSRskeGgaMW9FumnN0ftP6IXZ?=
 =?us-ascii?Q?A/vk3irsI3cObP5kUJkKeBEnB6EqVv4anwQOLAMYjhre0ShduqorJKF5vpdH?=
 =?us-ascii?Q?K6x+Cgt/Uf1XH8f3WvkJaNJibKKCes+TCBhWNDZ1PGJrEp1MZsVXlyrDxt0D?=
 =?us-ascii?Q?s88DtNf8Ottu0NnqH+9pauwPwtnqa+Mh6rKX5zx+V7U8U2XMRXXJk5vvLZkq?=
 =?us-ascii?Q?0+nQLYjfZAPpmp0WO2m8QLnss+KIAwx1iTzWeVBMG1dls/v2NS/RVDW6wFoo?=
 =?us-ascii?Q?UCPwN0mzhPlvNjmtWDeS3DAX86MQAdC43knXY3W/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e46e5cd-a223-42ef-20cb-08da68ec1410
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 18:33:58.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+hE/0WDdfm8/OQEVnI8bbghQn1q38s3PMgK7UdgRwUrM9i9UiEw8z7/y8wRvD0MRCT/gb1tAqAnMzQbUZaM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_18,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180079
X-Proofpoint-ORIG-GUID: x0Q-QK_RA_QS4K2vVTjBgNo8ZffuzlAf
X-Proofpoint-GUID: x0Q-QK_RA_QS4K2vVTjBgNo8ZffuzlAf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Sorry for the top-post, you sent to my @oracle.com email address which is O=
utlook web based and I can do nothing else here.

I'll look into this after the UK heatwave is over and we've recovered.

Thanks.

________________________________________
From: Ivan Babrou <ivan@cloudflare.com>
Sent: 18 July 2022 17:25
To: Russell King
Cc: Ard Biesheuvel; Daniel Borkmann; Alan Maguire; kernel-team; bpf; linux-=
perf-users@vger.kernel.org
Subject: [External] : Removal of 128MB limit for BPF JIT programs broke per=
f symbolication on aarch64

Hello,

We noticed that perf symbolication is broken on aarch64:

ivan@vm:~$ sudo perf_5.10 record -e cpu-clock --cpu 3 -g --call-graph
dwarf -F 11 -- sleep 0.1
ivan@vm:~$ sudo perf_5.10 script
swapper     0 [003]    75.516009:   90909090 cpu-clock:
        ffffffe7fe311808 [unknown] ([unknown])
        ffffffe7fdaf0a60 [unknown] ([unknown])
        ffffffe7fdaf0bdc [unknown] ([unknown])
        ffffffe7fda29538 [unknown] ([unknown])
        ffffffe7fe3253b8 [unknown] ([unknown])

On Linux 5.15 I was able to bisect this to 5.15.18, where this commit
was responsible (b89ddf4cca43 upstream):

* 9c82ce593626 arm64/bpf: Remove 128MB limit for BPF JIT programs

Reverting this commit in 5.15.18 resolves the issue. The issue is also
present in 5.19-rc6.

In addition to that, I noticed that on my personal kernel build this
doesn't happen on any kernel version. After many attempts at config
reconciliation, I narrowed it down to CONFIG_PROC_KCORE. When the
option is enabled and the commit b89ddf4cca43 is present, the stacks
have no kernel symbols.

This seems like a regression.
