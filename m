Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12814003D1
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349940AbhICRHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:07:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12370 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhICRHP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 13:07:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183H69Pj009525;
        Fri, 3 Sep 2021 10:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=RtGB8qTubdCDLUaFgpqueZXamD3l8EtVsG02sLOyno4=;
 b=GrdUoBJibMOrR3t4PLm0LQv2ilkhR0n7Evq7BwLQypMI8Z5lkZID+Ydnvx3QrpCkp5ZK
 XhQf0egzsSMd5Zysgo3+3g/jJxS5FNDW/YJc12Cb6eWrowVZhTj0W8GayQttYe/RdamZ
 xaRc5ZQniJ4tt6UewHnUy9XKytLg78C3XMk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3au5kj1uq1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Sep 2021 10:06:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 3 Sep 2021 10:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVS89V+7dkJP//qxX6hnq0SoAxNFoeaTYZRuTz3boIsbqpVCgyIR5hD2ts+yY/qBI6dHvzVWQJ3r3isFBj+Y0shJuOf9hBptCNCI6cJtBAXL2a4OjeXT0FG/qwRf6+cG10Y1fyzopK9mVKxe2f7eK09TjRtKOWWGtoAM6gEAAYHuFdI4ZzIDMs+LkYIodAPUMDowUKp0IDbLoxbBsfuKtBkaZikURibBynhoQCx2h92IThGZ/gnaYJTZFbh9QPn2pz4c7suMXl+HGs4EhwD1anjUW2ca8fQH8EnxHXAaZPkedphl4WZl4VwG1/VNGU7+v01o9pewa4iDL/ULSTPhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RtGB8qTubdCDLUaFgpqueZXamD3l8EtVsG02sLOyno4=;
 b=eJQEeDtXf5QqenQwdF8Bra0o8pB7NCYZBudZ7h3uMin6mrKBZO7Hvk9oduVujulBCLj23aP02wWe4qO3TrHvK8SfB0V8S5BglMY9ia74FP+bKEZ19bCATgShTKAxphiTx5lcrk2vP9cPOhzfnQqSizvAqzknUeXVDkm31ksmnRKr4kBeOWXCmtoMckHUaqiTudFCy/wDr50ARfOu68tRYszIic7+JVSBXzw/Xrj37bHSpTo5hAkEHn+Axv+Via/w7uOP2vkljnHR5Qh+UKUP+5bMcUh6nVqrex380LKKVCRLf4fFZHXhdWuNX22ZDtP6i2iavpk8T9FBrIDYYA/VQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 17:06:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 17:06:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Index: AQHXoBucwnw6xFDotUqgbr6c5GY6BquSAI+AgACLOAA=
Date:   Fri, 3 Sep 2021 17:06:12 +0000
Message-ID: <50D0C11D-71EF-4C82-A208-D7C73E241805@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
In-Reply-To: <YTHhOy1gqr44C1bI@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ec48151-64c5-4578-c64d-08d96efd2211
x-ms-traffictypediagnostic: SA1PR15MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5094E1E13DCB1A4DD698924FB3CF9@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SX2zos7h4TkGeZmavHa1H4M3wsn57ZwToQ7OwnmjcnEYo2eJgOwL115+wmC0F4verCnRBvNatOTvFCOQPN8jsYU/ai+BEK55n/otQK+90MySEoOvHZx8zR9Yl7IviDN48ycLLD93NgQ0SSayqqTMHFiW4WjwaCIDLcEGC9VCdOr2MeHkux5DmzltN0FxYkdSf2Dw1nYx+nvSwG+k2a3DNv8G7D95laTBWocaCWucG6VTbFtm4Zm95s4rj6Q4WE2iClz4Y8rm1zmsC+0Hsi7mOoOwj2yLxvEMNG5ofxZ/VtDB+/mrkwmnFZR4OQDH5ydEDqktye14ftK+LNTfx7JSBAdpnZ80DCyLKk2jQyM9NwKgIdwSZE9LIcF9QZTD1riGXSkcQT6ZAhUToKRE4YSPt1rCZ6qc9gmUUTHgspCYWZL0g4PquB8OhF+YOaolexO4SKJ+6aXy+JQxQXE4gb3uV1PmygAUlSEmSQiBPdwWronehYZptCA2BQc4qrEnzPnfIDJoHnHYALncDDGoSH1cvnykBOqbjnLYPD/5Itq9Btpl1w8oQoH0B4fMiVHHqIYiPmiME6peYJr3ZK4+oUNZg8guURpvW+AHPtndhXiTkeE4SVNMpyzYWKVlmb17lKA/vxHAc5a3SJfbrrxc9zlG/NkK3tqihA8H8XZBluiyIscS3WKGfHSZczpE2Ya0bNCVwkVG4gaex9voGdnwaNnZ6iLUumu4FVQ/11qPPNTzNac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(71200400001)(38100700002)(6916009)(2906002)(6486002)(122000001)(6512007)(5660300002)(4326008)(83380400001)(2616005)(54906003)(508600001)(316002)(36756003)(76116006)(38070700005)(86362001)(64756008)(66556008)(66476007)(66446008)(8936002)(91956017)(186003)(66946007)(53546011)(8676002)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?54vrX7UffI8i0ARnmcXtXteBRilaqo2QjdPgpTMDVZltQFnLLRdkPedt1BWp?=
 =?us-ascii?Q?ZZW9AoEn42Gp1BzGG7tdJDRYszjCSbekFdsyGpIoCLp6DOEvyfS/TRuMBUYc?=
 =?us-ascii?Q?yLN7f7pf2i/KyJOiFHbNv5IZ9//Z+eR+OjDl2FcPwm7W5nWctYr5PVwVSzLP?=
 =?us-ascii?Q?Hca3Ol9uqHCmMCX5ve13NF0KjKYfBUNHD4XkuS0AtgGmmnxgifrTzk2FrbQK?=
 =?us-ascii?Q?3Zqc4b3xSGIw3s6fW5dA3fY/ABkHaQ89kWFPryOmmgHS924pQrVTYwSHjNMn?=
 =?us-ascii?Q?gycT9Mm9rxuBaLvBXtL8ua/HB/5egiPi0VdQYYSSIeJXrQ07mNHOKLxbjqHW?=
 =?us-ascii?Q?bYPu0DlBST6P3UamijRUSRlzO3QwslDA1WGl/q0X543Zc0FWjUYeN1CSVhmL?=
 =?us-ascii?Q?jsdww2VNIC4toDNOexKkR3lYE7Ld79Gq8XX7if8gwDvapXsMr5gGMT2Aa8Nf?=
 =?us-ascii?Q?zpSQkwLOArkzsMeq47u9g/KL4nox7w/Z0yjj4Rn/ZKyghGNTK/tYYggRaGNm?=
 =?us-ascii?Q?6aYDfFIOhBzTqnvnRZrXbT/lvCF6JxNxQKvSM++blNTgbxtm36L1z1MtjeT8?=
 =?us-ascii?Q?j7wNZYvgToZrTnpxN2SOEDiWAqdbqa76EjlpkPjeKJz8zsda6vUJl0QMoeDb?=
 =?us-ascii?Q?zdvrtaUMrP6P4vW9ZmFUI6UybGmf5HKWjrfQv/pezs2aWXpMhEWqNyC4FUCK?=
 =?us-ascii?Q?KP/CS200RWfecQMF11RW0b6HeQLTu2++7olw/ThetJBKuxMu9fcRcjzGwGCa?=
 =?us-ascii?Q?d7gMg3RxkxfQAvTfFWWt4v7diVoUkAfDbd35EBxZ5ISaZUsmcAZmg9grnb8F?=
 =?us-ascii?Q?MgjoazIacOgmuC+f3wfwefz5j7iVxfda5nIEPDesJRyX+JJKJKjtzMh9SzbG?=
 =?us-ascii?Q?jwr5ZMooqOc/bhh2U4UW6ZZLSHAUZkZIDiqOG00TQcPDTnqj0rkJkyHYTP75?=
 =?us-ascii?Q?xrw/6LVw72MlhcLAx5/JwZZ17pXXJXuHitH2PQD5ukxsH5mjTTngUtWT6n8z?=
 =?us-ascii?Q?57+M25c17hdjYIkWql+qOA7AVtkbGQaS23urr7UmHxLsJBSYE3MNIowNvijc?=
 =?us-ascii?Q?BxTbcafQWJBhYjmznXeDX0RUmesDSm/bmsTv9f1TJ60Lg2svfp6QhQfSv58u?=
 =?us-ascii?Q?divYenSPeXdp3sIDxram6+1gOwFSVnzAk4EFLeBJp4vEqbfn7tctMGH13GSM?=
 =?us-ascii?Q?fyuQ5a+AXvp6LuLNUJOZMRZkhVoFd4RUEJmSro/Esl4s7DZv54ySQZxe/do6?=
 =?us-ascii?Q?+geJ2ccR3HGdQQn9pHKQosRrMi2dxYJtNXMRLg89j3hcIgFEneBO10caIP6R?=
 =?us-ascii?Q?to+AT4GGgCGpPxn+MFBOWlTzerTqdNzXggVhR0XzXy63sttYxu7lz4/ZOfX5?=
 =?us-ascii?Q?cnToyDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <580A60AD2C471742BC3E7607426A2D5C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec48151-64c5-4578-c64d-08d96efd2211
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 17:06:12.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1952ytTgXpXCnHO9eDpY0gVweY7sYl9x0gvjE/gbmelzAS4kGitYPUWdcXd1M4Gv7rmtDCvL5O8UuVE5vKWoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: SsGivosI2PaguXgZVj8kT5RPMHGF5J2J
X-Proofpoint-ORIG-GUID: SsGivosI2PaguXgZVj8kT5RPMHGF5J2J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 3, 2021, at 1:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Sep 02, 2021 at 09:57:05AM -0700, Song Liu wrote:
>> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>> +{
>> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>> +	u32 entry_cnt = size / br_entry_size;
>> +
>> +	if (unlikely(flags))
>> +		return -EINVAL;
>> +
>> +	if (!buf || (size % br_entry_size != 0))
>> +		return -EINVAL;
>> +
>> +	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
> 
> That's at least 2, possibly 3 branches just from the sanity checks, plus
> at least one from starting the BPF prog and one from calling this
> function, gets you at ~5 branch entries gone before you even do the
> snapshot thing.

Let me try to shuffle the function and get rid of some of these checks. 

> 
> Less if you're in branch-stack mode.
> 
> Can't the validator help with getting rid of the some of that?
> 
> I suppose you have to have this helper function because the JIT cannot
> emit static_call()... although in this case one could cheat and simply
> emit a call to static_call_query() and not bother with dynamic updates
> (because there aren't any).

We only JIT some key helper functions. I didn't think about that because 
current version is OK for mainstream and future hardware. I guess we 
can try JIT if it turns out some architecture needs more optimization. 

Thanks,
Song

