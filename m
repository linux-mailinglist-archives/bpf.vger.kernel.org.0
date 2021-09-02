Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3973FF6CE
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347605AbhIBWFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 18:05:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347526AbhIBWFH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 18:05:07 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182M0JwB029372;
        Thu, 2 Sep 2021 15:04:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=09nQTi0wWhLoVG4gMMHbWMTZqQIIn65SqU71GRvgcMg=;
 b=M+e8NopQo+OOh790AW0Idn8lrocr3w1R+nsGFpVPPXta292N2yLeznAwGsNFwiDJKKOc
 JOmYQJvmCcAv1ktqSWsZHw9sr08gDj5o6Vzezi+HwrT/VvaaREJUflybcfJoYaHmJawQ
 lm6+IWB2jBrZs+lWPt5CXMw6Rzdt1Mo7Km4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdxcw83e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 15:04:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 15:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbFSjL3IkfI/y8W5aAUBNKsJC+mMho5wF7hO0BFKz4lveXsng2CLvbldgXNRDAAEPy0DdZQk5yg0x77Ie32bllTFEiLzfgoG6UQSJ93rEYP3Su9vpKG0dRFjC6Z/35V8e1BBNmzjLeap7UgbxkmLpJYU554jOcu41FsDxykKHPavWTzjIrkiUa31yT9MP/f+iR/xD2ZcF/bc7/uI+75ubGMdOVla0jp62V6Npfshh2mJ6ueJUseiErEhCPV3ssZioiaLzBgfs9NMHyzJIE4fx/JzZg0xWJhvo58tG4iHbQC+VzVb+8JUQqkogJ0zKckTk0/pE74/Pin0g6/r/sSPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=09nQTi0wWhLoVG4gMMHbWMTZqQIIn65SqU71GRvgcMg=;
 b=VwNOtFW1bsrlj4qzm89fsw9tSijlqif9jqobMYLKp4w9P1d8EbSOksJlozNPGF4jidLlQREupUkaYI21sJdK+8Gt02FtJFgPJcCdag9pgUer27jb3qqvqYp72PWzI2cR7lFR9Y6axpu6SluRM2AC7tHJdLPN2ySOqZtFYkveuQEbRIxxk1yxYgNIU1ljc7n+1UObwmAmzwj/zOeAdsP62FaJTZDL5wq4dyWMTsUoO7VjUMC084SFBARJxi1dcWVcbYhiaIDt8KlJABESIox8mLeGw+XvVCH/q3FbzNPnB6iVGz8su6sj5BTRnD42/3/PPyUbnwOCN9a3/LNiR1OHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 22:04:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 22:04:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>
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
Thread-Index: AQHXoBucwnw6xFDotUqgbr6c5GY6BquROd6AgAASzQA=
Date:   Thu, 2 Sep 2021 22:04:05 +0000
Message-ID: <6C6E8C20-1EC7-46DD-84BB-6885F0C3F86A@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <61313a8fda896_2c56f208bb@john-XPS-13-9370.notmuch>
In-Reply-To: <61313a8fda896_2c56f208bb@john-XPS-13-9370.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b84a102-5883-4474-823e-08d96e5d94c8
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5112D0C501FA6DBC7F229DEEB3CE9@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITvqKT8oVxktUlpA2QxtcBc8wbjGlgTOykX8fwTCi7CNoKaIxWDYCLsuk1hNzDxfoNKbT1zDWB7Lz5US+0kEEO/cIbRGclCMnuVm+Y0hqbrMNtjzz9clgfr67Birt1xN9ptZ5OPjSRvRim9hRS7iVaM9pJpe5NWDPuUE/WjF3MxYWPoeWDy6ck1HkZOxu+y8S/u5bspI49IYInxalJM4knAzUQd60lh3/sPGSMOu1Izm8sGO+mBRHH+TTeUYQFCBQvj3suTHt4mQ1AmKOq4nF5CYiOqv55kyFm5uLtY3agCyT/+40TrepD3JMgWzxWmNgBxbW7Z9wgQoPiRyp+uT1NKL2aZwRc3yEdiddi4P5rBEq+RAEPaxA3x+TwNbGNNbaAyWYYgInZ+loojKfHC3gC/a3C2uQQRm0yiWxV+ktyR9bW+/AYG70E6DWXCXCDPQcGJ56MBoTiLhpwScMR/MQii8vf4Pydg2HATD30ZBFYw2PboJ/n6wx/7rP2HjGYJwmBckyQMATrjerps68EcsNiPacGg0eGQPI809Rh2kJczmQE/eSSB6NrpDoxaTOluO7Ay95FF8lRDCCxyexkRT/EyHCmFheCIFCQPKDBtM0OCGczmrXEew1W91qND/3Kt83XenD4k27opA6WcmTHNZ+fTVIfe4ag11dxERlygHxkep9LSzyWHZ0g640AcgXitoCsAUhDWeQqy+gEjh5QpBYgiAKzWVd+ZERki4nBgiPXcvcZTcs68dQgEBb5s4LZ75
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(36756003)(4326008)(122000001)(66946007)(66446008)(66556008)(66476007)(6486002)(64756008)(5660300002)(6916009)(2616005)(8936002)(38070700005)(8676002)(71200400001)(86362001)(33656002)(316002)(186003)(6506007)(76116006)(91956017)(53546011)(54906003)(6512007)(508600001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pcsUrYVxTOjQP33Xayqr/jg0lJzebLReX1BLHCKS8dmJmd12GHdWmVVoCgwS?=
 =?us-ascii?Q?1YHWI8Ls9/yWsQWGf85ite4/PqpXAowpwY1MyoM1YDzYlVZ7yESUC5HV8k93?=
 =?us-ascii?Q?SpZcjfAdtdS3Et8auOkBQ3NrfTklZjtNNTJaxjWxDTc1WG5Pyjxd1HA3SoEQ?=
 =?us-ascii?Q?57b3szjILankun6W2Gk3U1dJXPUq0eXE2GJYRZrgOhZKYFPdRFBCx5AlefDY?=
 =?us-ascii?Q?5S0CTp0H9icNhPSPNShUc0e+beRx6M/yRokYWqoh8Unr8eI+q8qe2zDO64mT?=
 =?us-ascii?Q?KPJoZ6ICC6s95i+sJ/rPQpzmTgU+FO1rZHYG/pmnxs4x1O09HnTwe5a7ixzD?=
 =?us-ascii?Q?JdS1Jw0aXtfusTM40iIJmvIt04FqUHJXe1i94xSFL3V/DtF+CdtCbLU0m8rQ?=
 =?us-ascii?Q?Spa0MciZeaN4iDSYtTNbY2Zv/egs55ZIasJZTsrPXlSIR5W6bWeLZdmfLTHL?=
 =?us-ascii?Q?EhGuFASqcOZtsYSrKzL2FSgm2fPKelFTU7WTOSwk8MlgDsW85TxE4GaaLUMd?=
 =?us-ascii?Q?UDtHfrPegb+OTTJUl/NMUykYnxoiclaVurKHxVrTrSs0SVvonezs5apKrB5n?=
 =?us-ascii?Q?3zcm3UOc1mYHSV06u4LeU0r0VuzAjFeBGp1zq/UKDeLkfi/RKdZfaSHCMyAn?=
 =?us-ascii?Q?U/etAzouqEC/Oetu+HGNlJEP3a4fRoSWShwKJbj4XG1E6Ffetfsm9DSjqVmi?=
 =?us-ascii?Q?2yJuD6dx30cNqUDdXZmXk4hwSVra1pmVcOi5wH0SG1WJMwmZ1uJ+5jeUBuTd?=
 =?us-ascii?Q?fgfUfJcBXd9/wnSy8w1YTArS2sqXbN10r3cjsbkKkvtsKGU8b/boD7/U5Acw?=
 =?us-ascii?Q?0hRbuevDLf/IM6TnQlQrneTN2At+DUCpvzMUvv1T9FPAf247ubPUc/F9R50M?=
 =?us-ascii?Q?qsIk89jb24f0jA9E8UiZN4G1MUTlMDuVlxrkbrTR8bdBEUx/rEjSHnNO3T0P?=
 =?us-ascii?Q?OJASFjhKRceN3jlkEeWtlSUItWnEOmBvCjxplBMsTCr3XnF6N4Sw7K86JTM6?=
 =?us-ascii?Q?HWfAL7hthRoWJHrXGKoJtXFcbo+a2CVQ3Xuu0MbMUT/RbUP1nRrTt1hrwxXM?=
 =?us-ascii?Q?TTUeihQqO7vh3e2siZlaa2hUhH2c8WDSxVTkRtGtgS5wjZogfv2ocuHgCFYZ?=
 =?us-ascii?Q?vDVSevJrgRY1ThZAge9b2ESCATDPmHUlM6020WwnXKFsNHqjtEt4+4BZpcZ0?=
 =?us-ascii?Q?1LGhy9sYGGEVUvOvAE4pOg+T1L0HQVk0xNnuNAHRmR7S3EEV21SfSmfHJCQI?=
 =?us-ascii?Q?Ga2aCi3ATKNUStWnUO0dhC6X1EXW8/GzFbGpw2zsWSiEGYxPhW7ajXH8F64v?=
 =?us-ascii?Q?teD12LvpsUxtSRmtT8p/rZ7ao4+a2wL+L9gnAgKz0updgr/luS6si3ENK1AY?=
 =?us-ascii?Q?3p2rAQ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEB3C87E941DC140B18AC400BAA2D903@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b84a102-5883-4474-823e-08d96e5d94c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 22:04:05.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pg0dC2SHeaungLZuzaMr/TRLTX0AJ2WKzVm31SWZhEidzP5oKqlKIj+0UZMLpY1PvEnXzAvqU4qdhUM76Fpyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: wKE8FY50zIHkWqGhJfuOrgC6oFeiUx-E
X-Proofpoint-ORIG-GUID: wKE8FY50zIHkWqGhJfuOrgC6oFeiUx-E
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 2, 2021, at 1:56 PM, John Fastabend <john.fastabend@gmail.com> wrote:
> 
> Song Liu wrote:
>> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
>> branch trace from hardware (e.g. Intel LBR). To use the feature, the
>> user need to create perf_event with proper branch_record filtering
>> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
>> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
> 
> [...]
> 
>> 
>> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>> +{
>> +#ifndef CONFIG_X86
>> +	return -ENOENT;
>> +#else
>> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>> +	u32 entry_cnt = size / br_entry_size;
>> +
>> +	if (unlikely(flags))
>> +		return -EINVAL;
>> +
>> +	if (!buf || (size % br_entry_size != 0))
>> +		return -EINVAL;
> 
> LGTM, but why fail if buffer is slightly larger than expected? I guess its a slightly
> buggy program that would do this, but not actually harmful right?

This check was added because bpf_read_branch_records() has a similar check. 
I guess it is OK either way. 

> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks for the review!
