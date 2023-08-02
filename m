Return-Path: <bpf+bounces-6701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F976CC6B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABAB1C20F37
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE37460;
	Wed,  2 Aug 2023 12:15:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6083187A
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:15:40 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0882139
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUzcgoeWMYKNpA7bCwpBfL5YiC4RejmZuwhGa0uULokMNSb9KeyzbIlsol6ANdhUzPYoeqiCsn1UM3Gnx+0sHNFjkDue/gyAgg45kMcdtYCBEMH336MPVJGiuEPVgl83xYdk4NR+g1xQ9/TwyWdRHWCuPgHJM+quDTNcxJXBa1/BYMVY5uBjDZ6nZbJYp2XrcRGtMuKJKx02ZVm94k9nDMMkuUZP69+dDmITN8P9dgtNbiGMezVyu0fZwz7z1IZ2kqCzpZssPGaFWNYhcH5pSc5WhvLR6vUdsJfiIO+M/ulhzAi+E5op52QlDrvgZ+w/myAlcDZKlh1TCBSKFBazrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn/+ypCVtsw2IfxABMjK1saEvHMcl9LFeoeDXpcDVJM=;
 b=PckgsNAUew8Yc9lZbmRr7LWhcoEjkNnZxBUK5rJ/J27zLEmnJUuWcuQS1fAGCcZSz4MsxYYngiwmFtBL54RzHOVhq5/qt/CgY8C4CdLL//+58p1qawrHn9F4n8l6ZnHYy0I9/6MBvWe6aVgregYhIw0U/ha8Q+kRkKlJKhk7Ysl5NRDJ0OGK9T4EOrRn7UL4svJQ0cpS2OvCdUfCe0uQHuf/h9nu7pXnYk5luj5J0iOqvmRrFdGjwEzIFlLRlbFr5xNpEKEfMu9QLAMdyHpVKPcn3g/soVIwSY9b5w5U665MuByckPHqwfOgzx15Tp7BIZbMDZLGLOTWh3pN8gg8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn/+ypCVtsw2IfxABMjK1saEvHMcl9LFeoeDXpcDVJM=;
 b=EECjqejb0F7+X6zzn/DpDdm51vPNfR0G0hjCQL+YcjwtAbNz8w+3uSEWDQ+YP+dB1NQjTAbjEsdGR0erhW4XZvvCSy1Py26LTvITMdtu3rCnNU8rGbhTKLkpsHOPNiq0joajMl8ENRfqEBDXwm5ri3qPad/zc+dD5s5NA+gc+4w=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DM4PR21MB3153.namprd21.prod.outlook.com (2603:10b6:8:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 12:15:36 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 2 Aug 2023
 12:15:36 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Will Hawkins <hawkinsw@obs.cr>, Watson Ladd <watsonbladd@gmail.com>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Topic: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Index:
 AQHZvrWW9Z2mpBtp0E2+6M55X5/AaK/Kg57wgAAlYwCAACeEAIABnVIAgAH0AgCAAXhcAIAACQCAgAAD5YCAAASEgIAAAyOAgAABqACAAARZAIAAF4WAgAALs4CAABuJAIAGE7vAgAANsYCAAJYucIAADUZA
Date: Wed, 2 Aug 2023 12:15:36 +0000
Message-ID:
 <PH7PR21MB38781121163CAB2C6BCB75CBA30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
 <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
 <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
 <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQLt7S9uwMxB3JaLMYACs5xTVwZ+en9pLYUguZ3gOf=33g@mail.gmail.com>
 <PH7PR21MB387874D32202CBA7F0C9E8DFA30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB387874D32202CBA7F0C9E8DFA30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47093801-2e17-4671-aeff-9a517ad050ff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T11:27:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DM4PR21MB3153:EE_
x-ms-office365-filtering-correlation-id: ddabd4c1-1acb-4dca-d3a6-08db93522d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FHwurmE19oi2RDzyGozdu/+EFnsiLuJeNx4M2cBstBmJUvxseCDOMSMCzja0GZ76sUWC+QFtrs7+FBWJ09hxvV3eksIeirhIpoJv306LPpH/opQd9TzIc228kFNkxrmaIG5/jMGBZQRdleLJM0qecRdZ1FGmF6PJ1RbiRXA2SK9XBHm9jS4chkiD+OCKtgEWml7sX+oPLbA3+5n6c6f7Cd4H+aZ1L8sKifHc6MoSDhzn12ya6+7v2THJbTO9naFyGr1/iqMaiaOh4WqGvtakgAr0X5q/opq+7eUEfHg+CfCiWKNamqf89kzPgQjzVPT/gPge3O8AbqItvRBetR/T2w07+oSB0x3L9EN9G6+ZOWTVEPovvkCdScCmIgPY9hhTrhk6GYQjKLwRVRi2Fe1Q689zRrtLhmwkUx605ZpG/tbyl20CaBjS0vf5BYQtn4IBDWYrwD4vpb0fuSD5fmKxWIVHGyL2joYFZ1jaNNQnD8AGwgbYxiZn+qCJxSZMxubHdySKJEBu2P2TtLy16BzAk4vnHkdVu4exD2abjGK6NH2qaiICgrSvvqGDAS8fidcnSTRJAdpk0+BxVrWyYuFI9SnPMabDBqOFVufUbHzdz5L4R/1BQLK2W6kZLarVLzGfYCbV4s2V2DLGWDrpe3HAEQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(71200400001)(38100700002)(54906003)(10290500003)(55016003)(7696005)(82960400001)(82950400001)(478600001)(8936002)(52536014)(8676002)(8990500004)(2906002)(5660300002)(86362001)(66476007)(38070700005)(6916009)(4326008)(64756008)(33656002)(66556008)(66946007)(66446008)(122000001)(76116006)(53546011)(316002)(26005)(786003)(83380400001)(41300700001)(66574015)(6506007)(186003)(2940100002)(966005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmpLRG5mWDBYSnVPUWVaN0FVd1lickw5ckh4bkkyb3grbThMMnpYeHVXekN6?=
 =?utf-8?B?anJCUXBISUJIV0s0a2ZsYitzVjY2MDdYMUIzR0dzSTVtZ24vWVZZT2NkeFdI?=
 =?utf-8?B?d1VDc1FWYVlhMzdMREhTRUpGa3l0eFB1bXpvaVl2a0JvSnZ3OHhxV2NiT2Zp?=
 =?utf-8?B?bmQrNEdnc3VQQUhDYW5scUV2aU12VndUNE1rZkpidlNkUTJpOGgxcWE1STFS?=
 =?utf-8?B?Ly92cWdCaDRzV21XUEloUXZERFoxMEtPd3NVZDFHK0hGR293Z1dZUFhSUXpk?=
 =?utf-8?B?Z3p2Vm1CdEFyT0NDemJKODRIT2p5V1FpRWtvVG9mbzZZcHhoaDR1ait2Z2lX?=
 =?utf-8?B?TWkvaEtld2ZNVXhzbU83bWN0YnRONVV2eUlBZUJWTDVabEZBMkVsTzljYTNL?=
 =?utf-8?B?clEramxzYXdEK1ZrMjF3K2JCNDdFeVJRbmxLakMvNzlXY3drdlBoekxZM01R?=
 =?utf-8?B?bzI1KzlwQkQzb1hWaEQxNlJNZjdoK0crb0NzUjhLWWQvbDE3VHcyN25lMDVi?=
 =?utf-8?B?a2U4Sm5CeWg0aE45VmxqTjRsZm5SejFKNkJvLzJ3eDk0U1VKYS9lbGx1ZFMr?=
 =?utf-8?B?eGdUQ3k2NU9JL1FpZlMwem1USE9saUs4RmtBK1hxTUk2RnZVSGZ2bWg1a0N0?=
 =?utf-8?B?VHRlQkRLeVVYZmhKdlJxYWJ5UEc2MWVuQUlxcGhqY0NnOHI0SU5aWDVFYVdK?=
 =?utf-8?B?ZVJyM09JdjU1NmVOQXM3bkRMMlZ2YWlSUENHQkhWZzNKcmMyUFd4cFRVRlY0?=
 =?utf-8?B?cWVYbGgvQzFlK2RVVmFQcFBaRFI4U04zU3dSRDFFMkNPL2RkUks3THVGVGE5?=
 =?utf-8?B?TzdVeVpuNlVhUG9KdHkwaW5ncFNtY2k5eTRIbk1HM2prN2FOWXMxNkd3eVcv?=
 =?utf-8?B?eW1COXdESHAyK2ZsbzZTc3NDK0tKZWpVVHhPelRIcWQ2QW9LdHlsRy9Nbm92?=
 =?utf-8?B?Z1lPa2NvUjZNZnNyeUdpOFFISGNaaG1xQnE0NFF0MmliMmVZY09WUHg4U2Fh?=
 =?utf-8?B?b2VvQlpMYkJqWFQrcG1DNDkzZytOVkFOVm1udVJQZnRFTllJMDhSSzZXdjFY?=
 =?utf-8?B?K2NXbVhISmxmSGNhMXN6ejQ4WmFwNlF5ejRBbnBDR2RJK1NoRlVFdEMyT1M1?=
 =?utf-8?B?TTE2UWl1bkJtTjlGMVZtNlcxYXpyUmg3T1BwZEdmb1JNa0ZLRGowei9zek52?=
 =?utf-8?B?QnAyQTMzbE1Tb0NCakRtUGF5aUtTL0dTNlFwdjRVdHEwODNFSVIwaXh5byt0?=
 =?utf-8?B?NGc4TXdjMHUzT0haMXhCMFQ0Y2VXQllQaTBHWUhGcEpKMHpoOU16TlNFUU90?=
 =?utf-8?B?S01Ld2ltUjdkVGNRNWZZS1VRbGE0OWl5Q1lJNGl4UWpYemRLeGhPY2hTdlEw?=
 =?utf-8?B?RDRhdllUVHdxaW5lK2d5ZEFuenppM25lNlpPVzgxYnJrc0hPUGVyUFB4SXI4?=
 =?utf-8?B?UWlYcGZtd1dtTHE1TkdJWU16cCtKQjhrb1lwM2tUQUdtaFJtZ1U3WTZMeW1v?=
 =?utf-8?B?L2Y4eU4yR0pua2t5blFGNWJTTi9HRWdsTlhEMzZCNlVpNXQwMGwrSU8yZ3gz?=
 =?utf-8?B?dWE3MlRGQk14WkZrajkrZ1FrUXNCRmZNajN1aVhodVVBZWhXQjNQcExwS1Y0?=
 =?utf-8?B?TVQ2alcwWGY3Q0p0T0tTV0Y1V2c4bmkwUzlmQm9neUhObHNzU1pCL01kWFhH?=
 =?utf-8?B?QWhCN1ovUEFkNk5IbVpRaXVhYVdhRXRiZmFDQVBuaXBCRll2UkZ0YnBCdDBM?=
 =?utf-8?B?elRjOVB5TG8rbFZDMnJUcFRaMlFSZ015V1EyUUpQRjNWaGhhNWxQOW9zV0g4?=
 =?utf-8?B?V2FaNmF4R3lPaXVrQ2N0VFduWDc3Vm9NczBiM0ZEV3hrelFkRmpaSVQvazhI?=
 =?utf-8?B?UHBUaitBMjBqK0FXMEV5ZUVJSmdZbTc4YVNBR21OYldLK0ZmbkwyMkNVNzMx?=
 =?utf-8?B?cHdDb3JHSGRjbzJka2JwYzMvSkpvMldkUjlSdEg1RjdoQkgrcC8wdXJMWXN2?=
 =?utf-8?B?U3dVUXFONENIMWlTSlF1bGRyNnN3NW0wYjNBWmE4UGhKNjlJTXpqcDRmYmFo?=
 =?utf-8?B?cG44VXp6T0diRmJVODdJQUYrdXhTNGVLNlRNRmc3aHRXVCsyN1dCQXFIMlNE?=
 =?utf-8?B?QVlWSlJSZStwdkdyWjhXNmFYdGt6Q2xkSzBaNzhUQUxwcjlRVDhHcVp1b0JZ?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddabd4c1-1acb-4dca-d3a6-08db93522d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 12:15:36.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOvOj4LhDX3LnWpukkBD769GKXllSsYW/2BZZM0DT2o8MqrR/dLeLDy9j2s/8GaIHqism9jY/B9aK9aTIzmWCE1eTT9K5ub9us1Jm4eQD5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIFRoYWxlcg0KPiBTZW50
OiBXZWRuZXNkYXksIEF1Z3VzdCAyLCAyMDIzIDU6MDUgQU0NCj4gVG86IEFsZXhlaSBTdGFyb3Zv
aXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4NCj4gQ2M6IFdpbGwgSGF3a2lucyA8
aGF3a2luc3dAb2JzLmNyPjsgV2F0c29uIExhZGQNCj4gPHdhdHNvbmJsYWRkQGdtYWlsLmNvbT47
IGJwZkBpZXRmLm9yZzsgYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSRTog
W0JwZl0gUmV2aWV3IG9mIGRyYWZ0LXRoYWxlci1icGYtaXNhLTAxDQo+IA0KPiBBbGV4ZWkgU3Rh
cm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIFR1
ZSwgQXVnIDEsIDIwMjMgYXQgNjo1NeKAr1BNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29m
dC5jb20+DQo+ID4gd3JvdGU6DQo+IFsuLi5dDQo+ID4gIEkgaW50ZXJwcmV0ZWQgdGhpcyBhcyBz
YXlpbmcgbm8gb25lIGNhcmVkIGFib3V0IGhhdmluZyB0aGUgSUFOQQ0KPiA+IGNvbnNpZGVyYXRp
b25zIHNlY3Rpb24gaW4gYSBzZXBhcmF0ZSBmaWxlIHRoZXJlLiAgQnV0IHdlIGNvbmZpcm0NCj4g
PiBjb25zZW5zdXMgb24gdGhlIGxpc3QsIHNvIGl0J3MgZmluZSB0byByZXZpc2l0IG5vdyBpZiB0
aGVyZSBhcmUgZ29vZCByZWFzb25zIHRvDQo+IGRvIHNvLg0KPiA+DQo+ID4gSSB0aGluayBJQU5B
IGNvbnNpZGVyYXRpb24gc2VjdGlvbiBpcyBvcnRob2dvbmFsIHRvIGdpYW50IG9wY29kZSB0YWJs
ZS4NCj4gDQo+IEl0J3Mgbm90IG9ydGhvZ29uYWwsIHN1Y2ggYSB0YWJsZSBpcyBhIHJlcXVpcmVk
IHBhcnQgb2YgdGhlIElBTkEgQ29uc2lkZXJhdGlvbnMNCj4gc2VjdGlvbi4gIFNlZSBodHRwczov
L3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODEyNiNzZWN0aW9uLTIuMg0KPiAoc3BlY2lmaWNh
bGx5IHRoZSAiSW5pdGlhbCBhc3NpZ25tZW50cyBhbmQgcmVzZXJ2YXRpb25zIikuDQo+IA0KPiA+
IFRoZXkncmUgcmVsYXRlZCwgYnV0IGRvbid0IGhhdmUgdG8gYmUgdG9nZXRoZXIgaW4gb25lIC5y
c3QgZmlsZS4NCj4gDQo+IFRydWUuDQo+IA0KPiA+IEkgdGhpbmsgaXQncyBjbGVhbmVyIHRvIGhh
dmUgc2VwYXJhdGUgaW5zdHJ1Y3Rpb24tc2V0LW9wY29kZS5yc3QNCj4gDQo+IFN1cmUuDQoNCkZv
cmdvdCB0byBhZGQ6IHllcywgdGhleSdyZSBhbHJlYWR5IGluIHNlcGFyYXRlIHJzdCBmaWxlcyBp
biBteSBwZW5kaW5nDQpjaGFuZ2VzLCB3aGljaCBnZXQgY29tYmluZWQgaW50byB0aGUgc2FtZSBz
ZWN0aW9uIG9mIHRoZSBJbnRlcm5ldCBEcmFmdA0Kd2hlbiBpdCdzIGdlbmVyYXRlZC4NCg0KRGF2
ZQ0KDQo=

