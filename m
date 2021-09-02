Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E83FF798
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 01:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348325AbhIBXEu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 19:04:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347937AbhIBXEs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 19:04:48 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182N0Lcp018459;
        Thu, 2 Sep 2021 16:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=IUd/Jq6mX7NP+Z3b7oxZTnQ/bT+X+iu8k77VUUgJ5ng=;
 b=fzVQJCeIt5BLvuhFV3fAQ+5DHDLR9vAqPDNEHFN4/bcF6Coic3YizLAFLd1/wAY+0/9C
 mRzUFOl53DRMjvsgiNzPV3Xob9V3VFG+dupPxTNm8hoheIdVdS2pn7N2itmCzADVgMdp
 1lzCqjKpvDC8tqk6BDm7FI0tdwrC4o4zL6o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdxcwtps-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 16:03:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 16:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxQw+lFqC0xXX0+FdZg2kKkn/1woDHnVRQmmJnRPd4yR319ZIkZHsZVRTtHVOldNtcAIuo0EhhtqAUZaE9a1jkX+0ONL8OKKshNYFEEIs/JWoXMzLuA+lu3+zIVzsAcjL8ekQF14N0GKeSjgI+GbNKT11yZJfYs8tPqS0TbMl4zkOXAYc2oH4JS+nfYlhWdfm7TV0d02dTOzyhw0GW3hgyogvFswyIOjYCaXpvu0kDV5xm3UJnK2eEvrUyIKw/DhmYpzHccfUg0yrtMt6qvjCkHMm/+Hd5JWY0wY2d2rp7H2qB3smOvDmEuz4rqCVaBbBJPVgn0c8upSWcimSogi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IUd/Jq6mX7NP+Z3b7oxZTnQ/bT+X+iu8k77VUUgJ5ng=;
 b=X2hW4O/voCNjq4wPuBhoPzhRPi2V8jotxInXJWA94IV2osvqaCHfmollB/AvUTlVXKW25AuC9aj7KDnUgHQiHuK+N0Qb0q8VkBynhxcDtn5WxhMOEm2ejs5a/PRCPQt+uDHlcEXYKLRpre1tgtIP45bByC7OKozBi7ud8bYDL4gP4HeuSmGL3ToTn2cKdcyMAiyuc/UoHhw40l2Zh9fozeUeiPmdAE7WmRLEwZN4TVSP9x/8fo9KlQ7nAu4Kua9T99EA3q1ddKaZaDb3ZNexfbPHcsmNzGnWIoD8UyvGpg3Erzfe0j/FI47oxGsb5T2hBWpNyjMl8vWDn47WhdxNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 23:03:47 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 23:03:47 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Index: AQHXoBucwnw6xFDotUqgbr6c5GY6BquRWm8AgAAC64A=
Date:   Thu, 2 Sep 2021 23:03:47 +0000
Message-ID: <F7A1D3BF-357A-46FB-92EA-938DB99D8193@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <CAEf4BzZLSs3ejyVLPMORd_GPCYNE8Jz4M6=4wxzR576Vag-+-A@mail.gmail.com>
In-Reply-To: <CAEf4BzZLSs3ejyVLPMORd_GPCYNE8Jz4M6=4wxzR576Vag-+-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469cd46f-dc05-4fdb-eb6d-08d96e65ebea
x-ms-traffictypediagnostic: SA1PR15MB5109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5109E8E0EC00852E5445AFD3B3CE9@SA1PR15MB5109.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIvCqd5UgJiCXW+ihg5YJcxPl8SeZBM3tJ+qYnrOthV241NhLC81zPiABnNYWDNTXIP9mbEXk9I2ZFEyQbBCx3N+CC+Uw0dca+pdqWh3DxCtYBHQBb0ThQ2NlA9nS7XHW2TZCNxgqPrmOhvoG98cXEcW6bJZisSkUqimWhV7jV0+pAQ16/6wkTVOlpJ2wKK9qBq+GoznJgNlIijsuy1zr4qXe7CFWvnlEwsxdK2Wwr7Cv54VyOvDoUdSmTUwpTEQx1up4D68Ic5jO4T3KmFeg6Qe74S70jXQ9o32Nhqp7XmuXFGvYJg/EbuBDLndrBtmqBgF7kPQHIhzqD+B3ADHdRq9XJ7AELsW9Tvt3z6VK/OHWJEtke0NHPSJdAHT7zQVBZ6E89ZsuHyQ+4OiF591bjQq9tZECqsOT3MntdmWCNtby96xqrUSXz9HpPBu7RIZ0/mVPA7IKyJpLJvbxnRdXynmPSncIwp+SfDY5uU4myX78iC4VmI8Rfds+KPRwPoN0gRqpeD3r96bIbSGQsxzh0yiua5FCVvZW74e/HIGtKW8QdlxzhngBEhhESYIQoKGccxCnpViHAGvU8TyH9qpbooARGsslvzk8SUb3ptJENz/rsIhgcfvg9glJrodKiQ9elvq815KIak8iII/QTHp5+msoePTdBm6y2mnEUBelk0dX0+T6m1Qcu6gMyYoJHoTGVVoefqvlcxkbtxPi2CmmUOt59XdPXusR/RTxb9M8SwEET38q3TlzI3d8eq+7uhf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(83380400001)(66556008)(2906002)(66946007)(71200400001)(8936002)(5660300002)(64756008)(66446008)(66476007)(186003)(122000001)(91956017)(38070700005)(8676002)(86362001)(6486002)(76116006)(6916009)(36756003)(4326008)(33656002)(54906003)(38100700002)(6512007)(478600001)(316002)(2616005)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7024EeqxdR8Zxh6OSyWSZtPgVrgatYbkgU0ix8b2gjDDa0rc2fTaZQRV1O+S?=
 =?us-ascii?Q?TW9fY696fkz15+c9ENHrJkwY6E2dxnhqxZkQ53IHq5hW5A8OBrbSRspGYe18?=
 =?us-ascii?Q?Ij2V0/H846+KioAHZnakZoM4XkWuMjCS7zmwVAh3tH/YVd75/eC/hIEpgwr3?=
 =?us-ascii?Q?HCicUuWZvzl9fpj08WMyLMg3PSfXADARtpI7k3+I3lO27XH6ArcKbR3X2ZUP?=
 =?us-ascii?Q?lpCx5fxQe+xLY70/QwcboljWF7otZcUmAvDMfhABPVuVHwoia922vKuVcef9?=
 =?us-ascii?Q?e6Mv7lNidTLQjt5QvdslCW5KUxZX9uAPJ5n5hfqINMa3LAIx1KVkOugkdueU?=
 =?us-ascii?Q?jFwFb3VPV/Szn0mQNdQYyoRs+gOBhi2rzIlJt7KksWPze+JHWeSNR7stiGsK?=
 =?us-ascii?Q?o1hgYH68VWmfU/gG9izhRPK31QQJtjSJh0TvM/XZTjrvHMGbXIwlE0M+8ybS?=
 =?us-ascii?Q?kw6TtEY2MKKEFKp6SXamEGyMPBQxB5caw11MaQKDrT/C9PuBm6rf2T1gcPpn?=
 =?us-ascii?Q?BN4RXRscvEGzU4JyHOFvWRZwEzZubwXkVcA9gyRgxgPUXi74TmtjsjQKaDVr?=
 =?us-ascii?Q?BiylW2HWLHSaXPBRTkkmBPDecEQf3qIu0J1hCEHfa39vnSHoT53wqzwNkyen?=
 =?us-ascii?Q?V3H9TpTEft4FZ2jkzVTU+5Lgyk6V4kd5LdMOtg7VgDpSM+ItrT1jVunkYC8S?=
 =?us-ascii?Q?H6XczbaIeYfVirpsec2Fv0Dc9qtvZgvjeSpv4WtJ7OwtauzV6uvNJM0d7oxu?=
 =?us-ascii?Q?y9A3DS86W5dv8YeCJxANp5d7oQXYEas+76bbn90W12Sehxm1J/9mnv0JjIyX?=
 =?us-ascii?Q?G5428UGf4BXauNEMlCyYPpMF3MhCIrY0Dfkqv7VG8tJiVCCzDyFLpv9G4c1S?=
 =?us-ascii?Q?nB+zJsUPXO355AG3FiksDAiOlbqHOfmz2hNZgA0SUXjVfSgbgMLvUzq5kJ8k?=
 =?us-ascii?Q?+gSq2Qtu113QWiFLSR7gmrpstCNdz07k4bvt0Rr79TC7epqNfZAfLNf/4ObF?=
 =?us-ascii?Q?WNaBpVqzvpwQ6FgYSL67H0ps3ZCIJKzscn32Wvj7KzkLUAgwGD6T0/a6JeOZ?=
 =?us-ascii?Q?VwaS/CYKFYhUWUzbc/BaT2rtdD22/o8AwUri+fJ4Mi8c7d4XvUwWWqp3wZQX?=
 =?us-ascii?Q?SveBSt3s7ga6CH5xuFHLigmXA8buGyukRLxYVPMOUCkX1st8OocW8t+N1pqV?=
 =?us-ascii?Q?l1ccDs4weMPMz14iA3TVfpNiA5mEBI28LeeHSX0KoKvYQ7yJVk3y033EJYbc?=
 =?us-ascii?Q?5AeHxVKvwolMEk/CSbTyrvgSXEdQlfpu+ubrvi2LhB600XBxLDHUgIIbuJQj?=
 =?us-ascii?Q?VWPr68zDK6SwrxWYoAUqXoIPbPSfACdHjZU9n4euO7v8bUfMdkdIA2zj6iqY?=
 =?us-ascii?Q?00murHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBAAB951B6A5A74DB1A5FDB1D61361FD@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469cd46f-dc05-4fdb-eb6d-08d96e65ebea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 23:03:47.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o25N0FS2Vb59SoINjv3Jgm1W3Z41sc+NhMZZBtfTtjuY/T2s2fgUyPsZKSJDd2Rlx3ER/N8oiD+WLwjcmUNvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5109
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -S1dzygUkH1OrtVaCqEilaFX5ma5d-vX
X-Proofpoint-ORIG-GUID: -S1dzygUkH1OrtVaCqEilaFX5ma5d-vX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 2, 2021, at 3:53 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Thu, Sep 2, 2021 at 9:58 AM Song Liu <songliubraving@fb.com> wrote:
>> 
>> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
>> branch trace from hardware (e.g. Intel LBR). To use the feature, the
>> user need to create perf_event with proper branch_record filtering
>> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
>> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> include/uapi/linux/bpf.h       | 22 ++++++++++++++++++++++
>> kernel/bpf/trampoline.c        |  3 ++-
>> kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
>> tools/include/uapi/linux/bpf.h | 22 ++++++++++++++++++++++
>> 4 files changed, 79 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 791f31dd0abee..c986e6fad5bc0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4877,6 +4877,27 @@ union bpf_attr {
>>  *             Get the struct pt_regs associated with **task**.
>>  *     Return
>>  *             A pointer to struct pt_regs.
>> + *
>> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
>> + *     Description
>> + *             Get branch trace from hardware engines like Intel LBR. The
>> + *             branch trace is taken soon after the trigger point of the
>> + *             BPF program, so it may contain some entries after the
> 
> This part is a leftover from previous design, so not relevant anymore?

Hmm.. This is still relevant, but not very accurate. I guess we should 
provide more information, like "For more information about branches before
the trigger point, this should be called early in the BPF program". 

Song


> 
>> + *             trigger point. The user need to filter these entries
>> + *             accordingly.
>> + *
>> + *             The data is stored as struct perf_branch_entry into output
>> + *             buffer *entries*. *size* is the size of *entries* in bytes.
>> + *             *flags* is reserved for now and must be zero.
>> + *
>> + *     Return
>> + *             On success, number of bytes written to *buf*. On error, a
>> + *             negative value.
>> + *
>> + *             **-EINVAL** if arguments invalid or **size** not a multiple
>> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
>> + *
>> + *             **-ENOENT** if architecture does not support branch records.
> 
> [...]

